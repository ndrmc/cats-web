// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery/jquery-2.1.1.js
//= require jquery_ujs
//= require jquery.fix-clone
//= require parsley.min
//= require bootstrap-sprockets
//= require metisMenu/jquery.metisMenu.js
//= require pace/pace.min.js
//= require slimscroll/jquery.slimscroll.min.js

//= require toastr

//= require sweetalert2
//= require datapicker/bootstrap-datepicker.js

//= require datepicker/bootstrap-datepicker.js

//= require_tree .


/**
 * Activates parent menu items if children are acive
 */
$(document).ready(function() {
    var activeLi = $('li.active');
    activeLi.parentsUntil( 'nav', 'li').addClass('active');
    activeLi.parentsUntil( 'nav', 'ul').removeClass('collapse');
});
