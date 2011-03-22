$(document).ready(function() {

    // INITIATE ----------------------------------------------------------------

    $('fieldset.collapsible').collapse();
    $('textarea.resizable:not(.processed)').TextAreaResizer();

    $('#link_edit_publisher').fancybox({
        overlayShow: true,
        hideOnOverlayClick: false,
        hideOnContentClick: false,
        enableEscapeButton: true,
        showCloseButton: true,
        href: '#form_edit_publisher'
    });

    // PAGE LOADED -------------------------------------------------------------

    if ($('select#publication_publication_type').val() == 9) {
        $('p.publication_type_other').show();
    }

    if ($('input#publication_translated_true').attr('checked')) {
        $('p.translated').each(function() {
            $(this).show();
        });
    }

    // ACTION EVENTS -----------------------------------------------------------

    $('.close').click(function() {
        $.fancybox.close();
    });

    $('select#publication_publication_type').change(function() {
        if ($(this).val() == 9) {
            $('p.publication_type_other').show('normal');
            $('#publication_publication_type_other').focus();
        } else {
            $('p.publication_type_other').hide('normal');
        }
    });

    $('input#publication_translated_false').click(function() {
        $('p.translated').each(function() {
            $(this).hide('normal');
        });
    });

    $('input#publication_translated_true').click(function() {
        $('p.translated').each(function() {
            $(this).show('normal');
            $('#publication_translated_from').focus();
        });
    });

    var press_find_url = $('input#press_remote_find_by_name').val();
    $('#publication_press_name').focusout(function() {
        if (jQuery.trim($(this).val()) != '') {
            $.getJSON(
                press_find_url,
                { term: $(this).val() },
                function(data) {
                    if (data != null) {
                        $('#publication_press_address').val(data.press.address);
                        $('#publication_press_telephone').val(data.press.telephone);
                        $('#publication_press_fax').val(data.press.fax);
                        $('#publication_press_email').val(data.press.email);
                        $('#publication_press_website').val(data.press.website);
                    }
                }
            );
        }
    });

    var distributor_find_url = $('input#distributor_remote_find_by_name').val();
    $('#publication_distributor_name').focusout(function() {
        if (jQuery.trim($(this).val()) != '') {
            $.getJSON(
                distributor_find_url,
                { term: $(this).val() },
                function(data) {
                    if (data != null) {
                        $('#publication_distributor_address').val(data.distributor.address);
                        $('#publication_distributor_telephone').val(data.distributor.telephone);
                        $('#publication_distributor_fax').val(data.distributor.fax);
                        $('#publication_distributor_email').val(data.distributor.email);
                        $('#publication_distributor_website').val(data.distributor.website);
                    }
                }
            );
        }
    });
});

function clearform(form_name) {
    form_name = '#publication_' + form_name + '_';
    fields = ['name', 'address', 'telephone', 'fax', 'email', 'website'];
    for (i = 0; i < fields.length; i++) {
        $(form_name + fields[i]).val('');
    }
}
