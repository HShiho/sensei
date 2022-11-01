// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// コメントアウト
// import Rails from "@rails/ujs"
// import Turbolinks from "turbolinks"
// import * as ActiveStorage from "@rails/activestorage"
// import "channels"

// Rails.start()
// Turbolinks.start()
// ActiveStorage.start()

// import "jquery/dist/jquery.js"
// import "popper.js/dist/popper.js"
// import "bootstrap/dist/js/bootstrap"
// import "bootstrap/dist/css/bootstrap.css"
// import "../stylesheets/application"
// import '@fortawesome/fontawesome-free/js/all'
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// add
import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"
import '@fortawesome/fontawesome-free/js/all'


var jQuery = require('jquery')
global.$ = global.jQuery = jQuery;
window.$ = window.jQuery = jQuery;


$(function(){
  $(".delete-btn").on("click", ()=>{
    let res = confirm('消してしまうと元には戻せません。よろしいですか?');
    if(res === false){
      return false;
    }
  })
})
