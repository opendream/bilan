$(document).ready(function() {
    $('select#publication_publication_type').change(function() {
        if (this.value == 9) {
            $('p.publication_type_other').show('normal');
            $('#publication_publication_type_other').focus();
        } else {
            $('p.publication_type_other').hide('normal');
            $('#publication_publication_type_other').val('');
        }
    });

    $('input#publication_translated_false').click(function() {
        $('p.translated').each(function() {
            $(this).hide('normal');
            $('#publication_translated_from').val('');
            $('#publication_original_author').val('');
        });
    });

    $('input#publication_translated_true').click(function() {
        $('p.translated').each(function() {
            $(this).show('normal');
            $('#publication_translated_from').focus();
        });
    });

    $('fieldset.collapsible').collapse();
    $('textarea.resizable:not(.processed)').TextAreaResizer();
});
