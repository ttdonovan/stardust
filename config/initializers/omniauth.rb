OmniAuth.config.logger = Rails.logger
# FIXME: figure out the correct way to fail, either SessionsController.action(:new).call(env) or preferably Warden
OmniAuth.config.on_failure = lambda { |env| OmniAuth::FailureEndpoint.new(env).redirect_to_failure }

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET']
  provider :identity, on_failed_registration: lambda { |env| IdentitiesController.action(:new).call(env) }
end
