// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from '@rails/ujs';
import Turbolinks from 'turbolinks';
import * as ActiveStorage from '@rails/activestorage';
import 'channels';

Rails.start();
Turbolinks.start();
ActiveStorage.start();

import 'bootstrap';
import '../stylesheets/application';

document.addEventListener('turbolinks:load', function () {
  $(function () {
    $('[data-toggle="tooltip"]').tooltip();
    $('[data-toggle="popover"]').popover();
  });
});

require("trix")
require("@rails/actiontext")


document.addEventListener("trix-file-accept", (e)=>{
  e.preventDefault();
});

document.addEventListener("ajax:success", (e)=>{
  var detail = e.detail;
  var data = detail[0], status = detail[1], xhr = detail[2];
  console.log(data)
  let shoeFormModal = document.querySelector("#shoeFormModal");

  if(shoeFormModal && status === "OK") {
      $('#shoeFormModal').modal('hide');
  }
});