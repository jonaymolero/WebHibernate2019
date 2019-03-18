$(document).ready(function() {
    console.log('ready');
    init();
});

function init(){
    loadReservas();
    setDatePickerSP();
    toast();
}

function setDatePickerSP(){
    $('.datepicker').datepicker({
        dateFormat: 'dd/mm/yy',
        showButtonPanel: false,
        changeMonth: false,
        changeYear: false,
        inline: true
    });
    $.datepicker.regional['es'] = {
        closeText: 'Cerrar',
        prevText: '<Ant',
        nextText: 'Sig>',
        currentText: 'Hoy',
        monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
        monthNamesShort: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'],
        dayNames: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
        dayNamesShort: ['Dom', 'Lun', 'Mar', 'Mié', 'Juv', 'Vie', 'Sáb'],
        dayNamesMin: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sá'],
        weekHeader: 'Sm',
        dateFormat: 'dd/mm/yy',
        firstDay: 1,
        isRTL: false,
        showMonthAfterYear: false,
        yearSuffix: ''
    };
    $.datepicker.setDefaults($.datepicker.regional['es']);
}
function toast() {
  // Get the snackbar DIV
  var x = document.getElementById("snackbar");

  // Add the "show" class to DIV
  x.className = "show";

  // After 3 seconds, remove the show class from DIV
  setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
}
function loadReservas() {
    $('#modalreservas').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var nhabitacion = button.data('id');
        console.log('hab' + nhabitacion);
        $.ajax({
            type: "POST",
            url: "Controller?op=reservas&nhabitacion=" + nhabitacion,
            success: function (info) {
                $("#reservas").html(info);
            }
        });
    });
}

