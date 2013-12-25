/**
 * created by orz@mad4a.me with pirated webstorm
 * generate an floating outline according to the `h2' tags
 */

$(function() {
    var dict = {};
    $('h2').each(function (idx) {
        var title = $(this).text();
        var id = 'outline_' + idx;
        dict[title] = id;

/*        $(this).append('<a name="' + id + '"></a>'); */
$(this).html('<a name="' + id + '"></a>'+$(this).html());
    });

    var article_nav = $('<nav id="article_nav"></nav>');
    article_nav.append($('<li></li>')
        .html('<a href="#top">返回顶部</a>'));
    $.each(dict, function (idx, val) {
        article_nav.append($('<li></li>')
                             .html('<a href="#' + val + '">' + idx + '</a>'));
    });

    $('#content').append(article_nav);
    var main = $('#content'),
        article_nav = $('#article_nav');

    $(window).resize(function () {
        var w = $(window).width(),
            c = main.width(),
            a = article_nav.width();
        article_nav.css('right',
            (w - c)/2);
        /*article_nav.css('right',
                      (w - c) / 2 - (a));       */
    });

    $(window).resize();

});


