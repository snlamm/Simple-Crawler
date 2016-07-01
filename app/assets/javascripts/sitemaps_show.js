$(function() {
  $('.data-info').hide()
  displayInfo()
});

displayInfo = function() {
  $('.toggle-option').click(function(e){
    e.stopPropogation
    var value = "." + $(this).attr('id')
    $(value).toggle(250)
  })
}
