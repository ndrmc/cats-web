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
//= require jquery.purr
//= require best_in_place
//= require jquery.fix-clone
//= require parsley.min
//= require bootstrap-sprockets
//= require metisMenu/jquery.metisMenu.js
//= require pace/pace.min.js
//= require slimscroll/jquery.slimscroll.min.js

//= require toastr

//= require sweetalert2

//=require select2

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

//= require Chart.min
//
//= require_tree .

$(document).ready(function() {
    /**
     * Activates parent menu items if children are active
     */
    var activeLi = $('li.active');
    activeLi.parentsUntil('nav', 'li').addClass('active');
    activeLi.parentsUntil('nav', 'ul').removeClass('collapse');

    $('.cats-datatable').DataTable({
        info: false,
        pageLength: 25,
        stateSave: true,
        "columnDefs": [
            { "visible": true, "targets": 0 }
        ],
        dom: 'lfrtipB',
        buttons: ['copy', 'csv', 'excel', 'print']
    });

    $('.cats-grouped-datatable').DataTable({
        info: false,
        pageLength: 25,
        stateSave: true,
        dom: 'lfrtipB',
        buttons: ['copy', 'csv', 'excel', 'print'],
        "columnDefs": [
            { "visible": false, "targets": 0 }
        ],
        "order": [[ 0, 'asc' ]],
        "displayLength": 25,
        "drawCallback": function ( settings ) {
            var api = this.api();
            var rows = api.rows( {page:'current'} ).nodes();
            var last=null;
 
            api.column(0, {page:'current'} ).data().each( function ( group, i ) {
                if ( last !== group ) {
                    $(rows).eq( i ).before(
                        '<tr class="group" style="background-color:#ececec;"><td colspan="5">'+group+'</td></tr>'
                    );
 
                    last = group;
                }
            } );
        }
    });

    $('.cats-grouped-aggregated-datatable').DataTable({
        info: false,
        pageLength: 25,
        stateSave: true,
        dom: 'lfrtipB',
        buttons: ['copy', 'csv', 'excel', 'print'],
        "columnDefs": [
            { "visible": false, "targets": 0 }
        ],
        "order": [[ 0, 'asc' ]],
        "displayLength": 25,
        "drawCallback": function ( settings ) {
            console.log(this);
            var api = this.api();
            var rows = api.rows( {page:'current'} ).nodes();
            var last=null;
            var total = 0.0;
            var flag = 0;
            var last_index = api.column( 0 ).data().length;
            console.log("Row Data Length: " + last_index);
            
            api.column(0, {page:'current'} ).data().each( function ( group, i ) {
                var next_index = api.row($(rows).eq( i + 1 )).index();
                var row_data = api.row(api.row($(rows).eq( i )).index()).data();
                console.log("Row Data Length: " + last_index);
                if(next_index == null)
                {
                    console.log("Last row found!");
                    var row_length = row_data.length;
                    var row_data_trim = parseFloat(row_data[row_length-1].replace(',', ''));
                    total = total + row_data_trim;
                    $(rows).eq( i ).after(
                        '<tr class="group" style="background-color:#ececec;margin-bottom:5px"><td colspan="5"> <div class="pull-right"><span style="font-weight:bold;">Sub-Total: </span>'+Math.round(total * 100) / 100+'</div></td></tr>'
                    );
                }
                else{
                    if ( last !== group || last == last_index - 1 ) {
                        console.log("Row Data Length: " + last_index + " - last = " + last);
                        if (flag!=0){
                            $(rows).eq( i ).before(
                                '<tr class="group" style="background-color:#ececec;margin-bottom:5px"><td colspan="5"> <div class="pull-right"><span style="font-weight:bold;">Sub-Total: </span>'+Math.round(total * 100) / 100+'</div></td></tr>'
                            );
                            total = 0.0;
                        }         
                        flag = 1;           
                        
                        $(rows).eq( i ).before(
                            '<tr class="group" style="background-color:#ececec;"><td colspan="5">'+group+'</td></tr>'
                        );
     
                        last = group;
                    }
                }

                
                // console.log("Total = " + total + " + " + row_data[4]);
                // console.log("Total (P) = " + parseFloat(total).toFixed(2) + " + " + parseFloat(row_data[4]).toFixed(2));
                var row_length = row_data.length;
                var row_data_trim = parseFloat(row_data[row_length-1].replace(',', ''));
                total = total + row_data_trim;
                // console.log("Total = " + total)
            } );
        }
    });

    $('.datepicker').datepicker({
        format: 'dd/mm/yyyy'
    });

    $('.custom_datepicker').calendarsPicker({

        calendar: $.calendars.instance('ethiopian', 'am'),
        format: 'yyyy-mm-dd',

        onSelect: function(dateText, inst) {

            var dateAsObject = $(this).calendarsPicker('getDate');
            var jd = dateAsObject[0].toJD();
            var date_gc = $.calendars.instance('ethiopian').fromJD(jd);
            $(this).val(date_gc.formatDate('yyyy-mm-dd'));

        }
    });

    $('.cats-daterangepicker').daterangepicker({
        format: 'dd/mm/yyyy'
    });


    $('select[data-option-dependent=true]').each(function (i) {

        var observer_dom_id = $(this).attr('id');
        var observed_dom_id = $(this).data('option-observed');
        var url_mask = $(this).data('option-url');
        var key_method = $(this).data('option-key-method');
        var value_method = $(this).data('option-value-method');

        // var prompt = $(this).has('option[value=]').size() ? $(this).find('option[value=]') : 
        //               $('<option value=\"\">').text('Select a specialization');

        var prompt = $('<option value=\"\">').text('-- Select --');
        var regexp = /:[0-9a-zA-Z_]+:/g;
        var observer = $('select#' + observer_dom_id);
        var observed = $('#' + observed_dom_id);

        if (!observer.val() && observed.size() > 1) {
          observer.attr('disabled', 'disabled');
        }
        observed.on('change', function () {

          observer.empty().append(prompt);
          if (observed.val()) {
            // url = url_mask.replace(regexp, observed.val());            
            if(observed_dom_id == 'hub' || observed_dom_id == 'dispatch_hub_id')
            {
                url = "/warehouses/" + observed.val() + ".json";
            }
            else if (observed_dom_id == 'zone' || observed_dom_id == 'region') 
            {
                url = "/locations/" + observed.val() + "/children";
            }
            else if (observed_dom_id == 'woreda')
            {
                url = "/fdps/location/" + observed.val()
            }
            else if (observer_dom_id == 'dispatch_dispatch_items__commodity_id')
            {
                url = "/commodities/get_by_category/" + observed.val()
            }
            
            // url = "/warehouses/" + observed.val() + ".json";
            $.getJSON(url, function (data) {
              $.each(data, function (i, object) {
                observer.append($('<option>').attr('value', object[key_method]).text(object[value_method]));
                observer.attr('disabled', false);
              });
            });
          }
        });
    });

});
 function printpage(){
        window.print()
    }