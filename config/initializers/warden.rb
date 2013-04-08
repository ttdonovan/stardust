Rails.application.config.middleware.use Warden::Manager do |manager|
  manager.default_strategies :omniauth
  manager.failure_app = lambda { |env| SessionsController.action(:new).call(env) }
end

Warden::Manager.serialize_into_session do |user|
  user.id
end

Warden::Manager.serialize_from_session do |id|
  User.find(id)
end

Warden::Strategies.add(:omniauth) do
  def valid?
    env['omniauth.auth']
  end

  def authenticate!
    if auth = env['omniauth.auth']
      success! Credential.from_omniauth(auth).user
    else
      fail 'Authentication failed, please try again.'
    end
  end
end
