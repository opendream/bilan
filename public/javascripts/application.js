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


    $('a[id^="isbn_"]').fancybox({
        overlayShow: true,
        hideOnOverlayClick: false,
        hideOnContentClick: false,
        enableEscapeButton: true,
        showCloseButton: true,
        padding: 20,
        href: '#form_update_isbn'
    });

    $('a[id^="cip_"]').fancybox({
        overlayShow: true,
        hideOnOverlayClick: false,
        hideOnContentClick: false,
        enableEscapeButton: true,
        showCloseButton: true,
        padding: 20,
        href: '#form_update_cip'
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


    var update_isbn_url = '';
    $('a[id^="isbn_"]').click(function() {
        update_isbn_url = $(this).attr('href');
        var title = $(this).parents('ul>li').eq(1).children('div.item_title').children('a').text();
        $('#form_update_isbn span.title').html(title);
        $('#isbn').val('').focus();
    });
    $('#update_isbn').click(function() {
        $.get(
            update_isbn_url,
            { isbn: $('#isbn').val() },
            function(data) {
                var target_id = update_isbn_url.split('/')[4];
                var target_dom = 'li#isbn_item_' + target_id;
                var target_item = $(target_dom).html().replace(/isbn/g, 'cip');
                $('ul#isbn_queue_items').children().remove(target_dom);
                $('ul#cip_queue_items').append('<li id="cip_item_'+ target_id +'">'+ target_item +'</li>');
            }
        );
        $.fancybox.close();
    });

    var update_cip_url = '';
    $('a[id^="cip_"]').live('click', function() {
        update_cip_url = $(this).attr('href');
        title = $(this).parents('ul>li').eq(1).children('div.item_title').children('a').text();
        $('#form_update_cip span.title').html(title);
        $('#cip').val('').focus();
    });
    $('#update_cip').live('click', function() {
        $.get(
            update_cip_url,
            { cip: $('#cip').val() },
            function(data) {
                var target_id = update_cip_url.split('/')[4];
                var target_dom = 'li#cip_item_' + target_id;
                var target_item = $(target_dom);
                target_item.children().remove('.item_action');
                $('ul#cip_queue_items').children().remove(target_dom);
                $('ul#completed_items').prepend(target_item);
            }
        );
        $.fancybox.close();
    });


    var find_press_url = $('input#press_remote_find_by_name').val();
    $('#publication_press_name').focusout(function() {
        self = this;
        setTimeout(function() {
            if (jQuery.trim($(self).val()) != '') {
                $.getJSON(
                    find_press_url,
                    { term: $(self).val() },
                    function(data) {
                        if (jQuery.trim($(self).val()) != '' && data != null) {
                            $('#publication_press_address').val(data.press.address);
                            $('#publication_press_telephone').val(data.press.telephone);
                            $('#publication_press_fax').val(data.press.fax);
                            $('#publication_press_email').val(data.press.email);
                            $('#publication_press_website').val(data.press.website);
                        }
                    }
                );
            }
        }, 300);
    });

    var find_distributor_url = $('input#distributor_remote_find_by_name').val();
    $('#publication_distributor_name').focusout(function(e) {
        self = this;
        setTimeout(function() {
            if (jQuery.trim($(self).val()) != '') {
                $.getJSON(
                    find_distributor_url,
                    { term: $(self).val() },
                    function(data) {
                        if (jQuery.trim($(self).val()) != '' && data != null) {
                            $('#publication_distributor_address').val(data.distributor.address);
                            $('#publication_distributor_telephone').val(data.distributor.telephone);
                            $('#publication_distributor_fax').val(data.distributor.fax);
                            $('#publication_distributor_email').val(data.distributor.email);
                            $('#publication_distributor_website').val(data.distributor.website);
                        }
                    }
                );
            }
        }, 300);
    });

    $('.btn_clear').click(function() {
        var form_name = '#publication_' + this.classList[1] + '_';
        var fields = ['name', 'address', 'telephone', 'fax', 'email', 'website'];
        for (var i = 0; i < fields.length; i++) {
            $(form_name + fields[i]).val('');
        }
    });
});
