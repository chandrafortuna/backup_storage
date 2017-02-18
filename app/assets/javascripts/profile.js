$(document).ready(function() {

    $(document).bind('ajaxError', 'form#new_profile', function(event, jqxhr, settings, exception){

        // note: jqxhr.responseJSON undefined, parsing responseText instead
        $(event.data).render_form_errors( $.parseJSON(jqxhr.responseText) );

    });

    $('#profileModal').on('shown.bs.modal', function () {
        $('#profileName').focus();
    });

    $('#profileModal').on('hidden.bs.modal', function (e) {
        cleanupForm();
        $("#new_profile").attr("action", "/profiles");
        $("#new_profile").attr("method", "POST");
    });

    $(".btn-edit-profile").click(function(){
        var id = $(this).data('profile-id');
        $("#new_profile").attr("action", "/profiles/" + id);
        $("#new_profile").attr("method", "PUT");
        $.ajax({
            type: "GET",
            url: "/profiles/" + id + "/detail",
            success:function(data){
                // alert (JSON.stringify(data))
                $('#profileModal').modal('show');
                $("#profile_name").val(data.name);
                $("#profile_paths").val(data.paths);
                $("#profile_excludes").val(data.excludes);
            },
            error:function(data) {
                alert ("Error: Can't retrieve data!")
            }
        });
    })
});

function cleanupForm() {
    $('#profile_name').val("");
    $('#profile_paths').val("");
    $('#profile_excludes').val("");
}

(function($) {

    $.fn.modal_success = function(){
        // close modal
        this.modal('hide');

        // clear form input elements
        // todo/note: handle textarea, select, etc
        this.find('form input[type="text"]').val('');
        this.find('form textarea').val('');

        // clear error state
        this.clear_previous_errors();
    };

    $.fn.render_form_errors = function(errors){

        $form = this;
        this.clear_previous_errors();
        model = this.data('model');

        // show error messages in input form-group help-block
        $.each(errors, function(field, messages){
            $input = $('input[type=text], textarea[name="' + model + '[' + field + ']"]');
            $input.closest('.form-group').addClass('has-error').find('.help-block').html( messages.join(' & ') );
        });

    };

    $.fn.clear_previous_errors = function(){
        $('.form-group.has-error', this).each(function(){
            $('.help-block', $(this)).html('');
            $(this).removeClass('has-error');
        });
    }

}(jQuery));