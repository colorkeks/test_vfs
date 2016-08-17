// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require twitter/bootstrap
//= require_tree .


$(document).on('turbolinks:load', function () {
    var modal_holder_selector, modal_selector, window_holder_selector, navigation_holder_selector;
    window_holder_selector = '.window';
    navigation_holder_selector = '.navigation';
    modal_holder_selector = '#modal-holder';
    modal_selector = '.modal';


    modal_listener();

    $('.folder').click(function () {
        var _this = this;
        $.ajax({
            type: "GET",
            data_type: 'JSON',
            url: "/folders/" + $(this).data('id'),
            success: function (data) {
                $(window_holder_selector).html(data);
                select_this(_this);
                init_new();
                init_destroy();
            }
        }).done(function (result) {
            (console.log('ok'))
        });
    });

    $('.data_file').click(function () {
        var _this = this;
        $.ajax({
            type: "GET",
            data_type: 'JSON',
            url: "/data_files/" + $(this).data('id'),
            success: function (data) {
                $(window_holder_selector).html(data);
                select_this(_this);
                init_destroy();
                init_save_file();
            }
        }).done(function (result) {
            (console.log('ok'))
        });
    });

    function select_this(_this) {
        $('.folder').css("background-color", "transparent");
        $('.data_file').css("background-color", "transparent");
        $(_this).css("background-color", "blue");
    }

    function init_new() {
        $('.new_folder').click(function () {
            var id = $(this).data('id');
            $.ajax({
                type: "GET",
                url: "/folders/new",
                data_type: 'JSON',
                data: {folder: {parent_id: id}},
                success: function (data) {
                    $(modal_holder_selector).html(data).find(modal_selector).modal();
                }
            }).done(function (result) {
                (console.log('ok'))
            });
        });


        $('.new_data_file').click(function () {
            var id = $(this).data('id');
            $.ajax({
                type: "GET",
                url: "/data_files/new",
                data_type: 'JSON',
                data: {data_file: {folder_id: id}},
                success: function (data) {
                    $(modal_holder_selector).html(data).find(modal_selector).modal();
                }
            }).done(function (result) {
                (console.log('ok'))
            });
        });
    }

    function init_save_file() {
        $('.save').click(function () {
            $('form').submit();
        });

        $('form').submit(function() {
            var valuesToSubmit = $(this).serializeArray();
            var action = $(this).attr('action');
            var name = $(this).find('input[name="data_file[name]"]').val();
            var text = $(this).find('textarea[name="data_file[text]"]').val();
            $.ajax({
                type: "POST",
                url: action, //sumbits it to the given url of the form
                data: valuesToSubmit,
                dataType: "JSON", // you want a difference between normal and ajax-calls, and json is standard
                success: function (data) {
                    $(".data_file[data-id=" + action.split('/')[2] + "]").find('.file_name').text(name);
                    $(".data_file_size").html('<h4>' + parseInt(name.length + text.length) + ' байт</h4>');
                }
            }).done(function (result) {
                (console.log('ok'))
            });

            return false; // prevents normal behaviour
        });
    }

    function init_destroy() {
        $('.destroy').click(function () {
            var id = $(this).data('id');
            var controller = $(this).hasClass('folder') ? 'folders' : 'data_files';
            $.ajax({
                type: "POST",
                method: 'delete',
                url: "/" + controller + "/" + id,
                data_type: 'JSON',
                success: function () {
                    Turbolinks.clearCache();
                    Turbolinks.visit(location);
                }
            }).done(function (result) {
                (console.log('ok'))
            });
        });
    }
});
