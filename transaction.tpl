{include file="includes/tablestyle"}
<script>
	$(function () {
		var action = '{$Think.get.action}'
		$('#accountsRecordSel').val(action == 'credit_record' ? 'credit_record' : (action == 'credit_limit' ? 'credit_limit' : 'accounts_record'))
		// $('input[name="expenseRecord"]').on('change', function () {
		// 	location.href = 'transaction?action=' + $("input[name='expenseRecord']:checked").val()
		// })
		$('#accountsRecordSel').on('change', function () {
			location.href = 'transaction?action=' + $('#accountsRecordSel').val()
		});

		// 排序
		var action = '{$Think.get.action}'
		$('.bg-light th').on('click', function () {
			var sort = '{$Think.get.sort}'
			location.href = 'transaction?action=' + (action || 'accounts_record') + '&sort=' + (sort == 'desc' ? 'asc' : 'desc') + '&orderby=' + $(this).attr('prop') + '&page={$Think.get.page}&limit={$Think.get.limit}'
		})
	})
</script>
<div class="card" style="border-radius:20px">
	<div class="card-body">

		<div class="table-container">
			<ul class="nav nav-tabs nav-tabs-custom" role="tablist">
				<li class="nav-item waves-effect waves-light">
					<a class="nav-link {if $Think.get.action=='accounts_record' or $Think.get.action=='credit_record' or $Think.get.action=='credit_limit' or !$Think.get.action }active{/if}"
						href="transaction?action=accounts_record&sort={$Think.get.sort}&orderby={$Think.get.orderby}&page={$Think.get.page}&limit={$Think.get.limit}"
						role="tab">{$Lang.records_of_consumption}</a>
				</li>
				<li class="nav-item waves-effect waves-light">
					<a class="nav-link {if $Think.get.action=='recharge_record' }active{/if}"
						href="transaction?action=recharge_record&sort={$Think.get.sort}&orderby={$Think.get.orderby}&page={$Think.get.page}&limit={$Think.get.limit}"
						role="tab">{$Lang.recharge_record}</a>
				</li>
				<li class="nav-item waves-effect waves-light">
					<a class="nav-link {if $Think.get.action=='refund_record' }active{/if}"
						href="transaction?action=refund_record&sort={$Think.get.sort}&orderby={$Think.get.orderby}&page={$Think.get.page}&limit={$Think.get.limit}"
						role="tab">{$Lang.refund_record}</a>
				</li>
				<li class="nav-item waves-effect waves-light">
					<a class="nav-link {if $Think.get.action=='withdraw_record' }active{/if}"
						href="transaction?action=withdraw_record&sort={$Think.get.sort}&orderby={$Think.get.orderby}&page={$Think.get.page}&limit={$Think.get.limit}"
						role="tab">{$Lang.withdrawal_record}</a>
				</li>
        
			</ul>
			<div class="table-header">
				<div class="table-filter">

				</div>
				<div class="table-search d-flex justify-content-end">
					{if $Think.get.action=='accounts_record' || $Think.get.action=='credit_record' || $Think.get.action=='credit_limit' || !$Think.get.action}
					<select class="form-control mt-2" id="accountsRecordSel" title="{$Lang.please_select}" style="width: 150px">
						<option value="accounts_record">{$Lang.transaction_flow}</option>
						<option value="credit_record">{$Lang.balance}</option>
						{if $Userinfo.user.is_open_credit_limit==1}
            			<option value="credit_limit">{$Lang.credit_amount}</option>
            			{/if}
					</select>
					{/if}
				</div>
			</div>

			<div class="table-responsive">
				{if $Think.get.action=='accounts_record' or !$Think.get.action }
				{include file="transaction/accounts_record"}
				{elseif $Think.get.action=='credit_record'}
				{include file="transaction/credit_record"}
				{elseif $Think.get.action=='credit_limit'}
				{include file="transaction/credit_limit"}
				{elseif $Think.get.action=='recharge_record'}
				{include file="transaction/recharge_record"}
				{elseif $Think.get.action=='refund_record'}
				{include file="transaction/refund_record"}
				{elseif $Think.get.action=='withdraw_record'}
				{include file="transaction/withdraw_record"}
				{/if}
			</div>
			<!-- 表单底部调用开始 -->
			{include file="includes/tablefooter" url='transaction'}
		</div>
	</div>
</div>