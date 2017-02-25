$(function(){
  var $setElm = $('.cut_string');
  var cutFigure = '20'; // カットする文字数
  var afterTxt = '…'; // 文字カット後に表示するテキスト

  $setElm.each(function(){
    var textLength = $(this).text().length;
    var textTrim = $(this).text().substr(0,(cutFigure))

    if(cutFigure < textLength) {
      $(this).html(textTrim + afterTxt).css({visibility:'visible'});
    } else if(cutFigure >= textLength) {
      $(this).css({visibility:'visible'});
    }
  });
});
