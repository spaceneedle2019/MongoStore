$(document).ready(function () {
    if ($('#payment_method').val() === '2') {
        $("#debit").addClass('hide');
        $("#credit").removeClass('hide');
    } else {
        $("#credit").addClass('hide');
        $("#debit").removeClass('hide');
    }
});

$('#payment_method').change(function () {
    if ($(this).val() === '2') {
        $("#debit").addClass('hide');
        $("#credit").removeClass('hide');
    } else {
        $("#credit").addClass('hide');
        $("#debit").removeClass('hide');
    }
});
