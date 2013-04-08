# Stardust To-Do List

INTERNALS
- move javascript from views assets - Andrew
- all SSL (rack ssl enforcer?) - Andrew
- maximize memcaching - Andrew
- check gems into vendor cache - Andrew

REGISTRATION AND LOGIN
- omniauth - Tanner

MAIN PAGE
- prettify row content html/twitter CSS
- split main screen
- pagination

CREATE POST PAGE
- prettify
- validation of all data
- make new post top post
- only one post at a time per username

SHOW POST PAGE
- prettify

DEPLOYMENT
- handle sensitive data

PROFILE PAGE
- so they resolve multiple signins
- cancan
- carrierwave

## JavaScript

* cleanup `assets/javascripts` and use application.js with Asset Pipeline
* add twitter-bootstrap gem
* move html layout javascript into application.js

## OmniAuth

* detect multi accounts ask to merge
* add modal window for login
* remove older login application logic and javascript

## OmniAuth Keys

* Google https://github.com/zquestz/omniauth-google-oauth2 and https://code.google.com/apis/console/
  * use http://localhost:3000/auth/google_oauth2/callback for the Redirect URIs
