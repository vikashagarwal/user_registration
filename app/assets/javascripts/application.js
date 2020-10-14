// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require jquery_ujs
//= require jquery-ui
//= require jquery-confirm.min
//= require popper.min
//= require select2
//= require turbolinks
//= require bootstrap
//= bootstrap/js/src/util
//= bootstrap/js/src/modal
//= require datatables
//= require_tree .

// function isNumber(evt) {
//   var iKeyCode = evt.which ? evt.which : evt.keyCode;
//   return !(iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57));
// }

// For Email field validation
document.querySelectorAll('input[type="email"]').forEach(function(elem, index) {
  elem.oninvalid = function(e) {
    e.target.setCustomValidity('');
    if (!e.target.validity.valid) {
      e.target.setCustomValidity('Enter valid email. e.g. abc@gmail.com');
    }
  };

  elem.oninput = function(e) {
    e.target.setCustomValidity('');
  };
});

$(document).on('turbolinks:load', function() {
  setTimeout(function() {
    $('#bootstrap_message_div').hide();
  }, 10000);
})
