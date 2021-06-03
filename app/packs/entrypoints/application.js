// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import { Turbo } from "@hotwired/turbo-rails"

Rails.start()

import "stylesheets/application"
import "controllers"
import gtag from "analytics/google_tag"

if ('serviceWorker' in navigator) {
  navigator.serviceWorker.register('./serviceWorker.js')
    .then(function(registration) {
      // Registration was successful
      // console.log('ServiceWorker registration successful with scope: ', registration.scope);
    }).catch(function(err) {
      // registration failed :(
      // console.log('ServiceWorker registration failed: ', err);
    });
}
