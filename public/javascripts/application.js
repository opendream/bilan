$(document).ready(function() {

    // INITIATE ----------------------------------------------------------------

    $('fieldset.collapsible').collapse();
    $('textarea.resizable:not(.processed)').TextAreaResizer();

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
});
