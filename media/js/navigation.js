/**
 * created by orz@mad4a.me with pirated webstorm
 * generate an floating outline according to the `h2' tags
 */

// ============== 目录提取 ===============
$(function() {

    var article_nav = $('<fieldset id="article_nav"></fieldset>'),
        count = 0;
    article_nav.append($('<li></li>')
        .html('<a href="#top">返回顶部</a>'));

    $('#content').find('h2,h3,h4,h5').each(function() {
        var name = 'outline_' + count++;
        article_nav.append('<div class="txt_' + this.tagName + '">' +
            '<a href="#' + name + '">' +
            this.innerHTML +
            '</a></div>');
        this.id = name;
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
    });

    $(window).resize();
});


