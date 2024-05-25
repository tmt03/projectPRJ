
(function ($) {
    "use strict";

    
    /*==================================================================
    [ Validate ]*/
    var input = $('.validate-input .input100');

    $('.validate-form').on('submit',function(){
        var check = true;

for (const item of input) {
    if (!validate(item)) {
        showValidate(item);
        check = false;
    }
}



        return check;
    });


    $('.validate-form .input100').each(function(){
        $(this).focus(function(){
           hideValidate(this);
        });
    });

   function validate(input) {
    if ($(input).attr('type') == 'email' || $(input).attr('name') == 'email') {
        const emailPattern = /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
        if (!emailPattern.test($(input).val().trim())) {
            return false;
        }
    } else {
        if ($(input).val().trim() == '') {
            return false;
        }
    }
    return true;
}


    function showValidate(input) {
        var thisAlert = $(input).parent();

        $(thisAlert).addClass('alert-validate');
    }

    function hideValidate(input) {
        var thisAlert = $(input).parent();

        $(thisAlert).removeClass('alert-validate');
    }
    
    

})(jQuery);
