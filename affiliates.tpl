<script type="text/javascript">
	$(function () {
		$('.activation').click(function () {
			$.get("activation", function (data) {
				if (data.status == '200') {
					toastr.success(data.msg);
					setTimeout(function () {
						location.reload();
					}, 1000);
				}
			});
		});
	});
</script>

{if !$Affiliates.aff}
{include file="affiliates/unaffiliates"}
{else}
{include file="affiliates/affiliates"}
{/if}