$(function() {
    $("li")
        .mouseenter(function() {
            $(this).find('ul').show(300);
        });
    $(".sidebar")
        .mouseleave(function() {
            $(this).find('li ul').hide(500);
        });
});

