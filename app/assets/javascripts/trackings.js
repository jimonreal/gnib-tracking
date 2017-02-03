$(document).on('change', 'input[name="tracking[date_behavior]"]', function(e){
  var dateBehavior = $(e.currentTarget),
      form = dateBehavior.closest('form'),
      value = dateBehavior.val(),
      beginData = form.find('input[name="tracking[begin_date]"]').closest('.form-group'),
      endData = form.find('input[name="tracking[end_date]"]').closest('.form-group');

  switch (value) {
    case 'closest':
      beginData.hide()
      endData.hide();
    break;
    case 'earlier':
      endData.show();
      beginData.hide();
    break;
    case 'later':
      endData.hide();
      beginData.show();
    break;
  }
});