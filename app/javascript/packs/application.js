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

// add
import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"
import '@fortawesome/fontawesome-free/js/all'

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

function formSwitch() {
  check =
  document.getElementsByClassName('objective_post_check')
  if (check[0].checked) {
  // 「いいえ」が選択されたら以下を実行
    document.getElementsById('objective_yes').style.display = "none";
  } else if (check[1].checked) {
  // 「はい」が選択されたら以下を実行
    document.getElementsById('objective_yes').style.display = "";
    var inputItem =  document.getElementsById('objective_yes').getElementsByTagName("input");
    for(var i=0; i<inputItem.length;
    i++ ){
      inputItem[i].checkd = "";
      }
  } else {
    var inputItem =  document.getElementsById('objective_yes').getElementsByTagName("input");
    for(var i=0; i<inputItem.length;
    i++ ){
      inputItem[i].checkd = "";
      }
    }
  }
  window.addEventListener('load', formSwitch());
