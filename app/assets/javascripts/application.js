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

//= require moment.min.js

//= require daterangepicker.js
//= require datapicker/bootstrap-datepicker.js
//= require chosen/chosen.jquery.js
//= require jquery.calendars/jquery.plugin.js
//= require jquery.calendars/jquery.calendars.js
//= require jquery.calendars/jquery.calendars.plus.js
//= require jquery.calendars/jquery.calendars.picker.js
//= require jquery.calendars/jquery.calendars.ethiopian.js
//= require jquery.calendars/jquery.calendars.ethiopian-am.js

//= require data-confirm-modal
//= require underscore-min

//= require_tree .

$(document).ready(function() {
    /**
     * Activates parent menu items if children are active
     */
    var activeLi = $('li.active');
    activeLi.parentsUntil('nav', 'li').addClass('active');
    activeLi.parentsUntil('nav', 'ul').removeClass('collapse');

    $('.cats-datatable').DataTable({ "info": false });

    $('.datepicker').datepicker({
        format: 'dd/mm/yyyy'
    });

    $('.custom_datepicker').calendarsPicker({

        calendar: $.calendars.instance('ethiopian', 'am'),
        format: 'dd/mm/yyyy',

        onSelect: function(dateText, inst) {

            var dateAsObject = $(this).calendarsPicker('getDate');
            var jd = dateAsObject[0].toJD();
            var date_gc = $.calendars.instance('gregorian').fromJD(jd);
            $(this).val(date_gc.formatDate('dd/mm/yyyy'));

        }
    });

    $('.cats-daterangepicker').daterangepicker({
        format: 'dd/mm/yyyy'
    });
});
