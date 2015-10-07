// amount + -
$('a[tag]').on('click', function(ev){
	var amount = Number($('input[name="quantity"]').val());
	var operation = $(this).attr('class');
	if (operation=='minus') {
		amount -= 1;
	}
	else {
		amount += 1;
	}
	if (amount < 1 || amount >50 ) {
		console.log('数量不对，撤销操作');
		return 0;
	}
	else {
		$('input[name="quantity"]').val(amount);
	}
});