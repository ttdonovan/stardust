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

* oauth client sign-on
* startdust user sign-on
* detect multi accounts ask to merge
