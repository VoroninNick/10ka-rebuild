function init_order_form() {
    var $order_form = $("#order")
    if (!$order_form.length) {
        return;
    }
    var validationSettings = {
        errorMessagePosition: 'top'
    };

    $order_form
        .submit(function (e) {
            e.preventDefault()
            if ($order_form.validate(false, validationSettings)) {
                alert("submit order")
            }
        })
        .validateOnBlur(false, validationSettings)
        .showHelpOnFocus();
}

init_order_form()

$(document).on("click", ".order-button", function(){
    $(".order-popup, .body-overlay").addClass("visible")

})

$(document).on("submit", "#order", function (e) {
    e.preventDefault()
    var $form = $(this)
    $form.ajaxSubmit({type: "post"})
    $form.addClass("submitting")
})

$(document).on("click", ".body-overlay", function () {
    $(".order-popup, .body-overlay").removeClass("visible")
})