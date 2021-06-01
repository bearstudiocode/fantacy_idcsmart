
<script type="text/javascript">
	$(function () {
		spop({
	template: '[value]',
	position  : 'top-right',
	style: 'success',
	autoclose: 3000
});
setTimeout(function () {
			var url = '[url]'
			if (url) {
				location.href = url
			}
		}, 500);
	});
</script>