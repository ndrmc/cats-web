// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {

    $('.pca-grouped-datatable').DataTable({
        info: false,
        pageLength: 25,
        stateSave: true,
        dom: 'lfrtipB',
        buttons: ['copy', 'csv', 'excel', 'print'],
        "columnDefs": [
            { "visible": false, "targets": 0 },
            { "visible": false, "targets": 1 }
        ],
        "order": [[ 1, 'asc' ]],
        "displayLength": 25,
        "drawCallback": function ( settings ) {
            var api = this.api();
            var rows = api.rows( {page:'current'} ).nodes();
            var last=null;

            api.column(1, {page:'current'} ).data().each( function ( group, i ) {
                var row_data = api.row(api.row($(rows).eq( i )).index()).data();
                if ( last !== group ) {
                    $(rows).eq( i ).before(
                        '<tr class="group" style="background-color:#ececec;"><td colspan="5"><div="col-sm-12"><div class="col-sm-8">Woreda: <strong>'+group+'</strong></div><div class="col-sm-4"><div class="pull-right"> <a class="btn btn-primary allocate_pc_to_location" data-target="#allocate_pc_to_location_modal" data-toggle="modal" data-level="woreda" data-woreda="'+group+'" data-woreda-id="' + row_data[0] + '">Allocate for Woreda</a></div></div></div></td></tr>'
                    );
                    
                    last = group;
                }
            } );
        }
    });

    $('.requisitions-grouped-datatable').DataTable({
        info: false,
        pageLength: 25,
        stateSave: true,
        dom: 'lfrtipB',
        buttons: ['copy', 'csv', 'excel', 'print'],
        "columnDefs": [
            { "visible": false, "targets": 1 },
            { "visible": false, "targets": 2 }
        ],
        "order": [[ 1, 'asc' ]],
        "displayLength": 25,
        "drawCallback": function ( settings ) {
            var api = this.api();
            var rows = api.rows( {page:'current'} ).nodes();
            var last=null;
            
            api.column(1, {page:'current'} ).data().each( function ( group, i ) {
                var row_data = api.row(api.row($(rows).eq( i )).index()).data();
                if ( last !== group ) {
                    $(rows).eq( i ).before(
                        '<tr class="group" style="background-color:#ececec;"><td colspan="5"><div="col-sm-12">Zone: <strong>'+group+'</strong> &nbsp;&nbsp;&nbsp; Beneficiaries: <strong>' + row_data[2] + '</strong></div></td></tr>'
                    );
                    
                    last = group;
                }
            } );
        }
    });

    
});