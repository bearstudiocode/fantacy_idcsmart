{if $ErrorMsg}
<script>
$(function () {
  toastr.error('{$ErrorMsg}');
});
</script>
{else/}
    {if $Action == "upgrade_page"}

                    <form>
                      <input type="hidden" value="{$Token}" />
                      <input type="hidden" name="hid" value="{$Think.get.id}" />

                      <div class="offset-md-2 col-md-8">
                        <table class="table table-nowrap table-centered mb-0">
                            <tbody>
                                {foreach $UpgradeProduct.host as $key=>$item}
                                <tr>
                                    <td style="width: 60px;">
                                        <div class="custom-control custom-radio mb-3 upgradeRadio" data-key="{$key}">
                                            <input type="radio" id="upgradeRadio{$key}" name="pid" class="custom-control-input" {if $key==0}checked{/if} value="{$item.pid}">
                                            <label class="custom-control-label" for="upgradeRadio{$key}"></label>
                                        </div>
                                    </td>
                                    <td>
                                        <h5 class="text-truncate font-size-14 m-0">
                                            <label for="upgradeRadio{$key}">{$item.host}</label>
                                        </h5>
                                    </td>
                                    <td>
                                        <select class="form-control upgradeSelect{$key}" class="second_type" name="billingcycle" {if $key>0}disabled{/if}>
                                          {foreach $item.cycle as $sub_item}
                                          <option value="{$sub_item.billingcycle}">{$UpgradeProduct.currency.prefix}{$sub_item.price}{$UpgradeProduct.currency.suffix}/{$sub_item.billingcycle_zh}</option>
                                          {/foreach}
                                        </select>
                                    </td>
                                </tr>
                                {/foreach}
                            </tbody>
                        </table>
                      </div>
                    </form>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary waves-effect waves-light submit">下一步</button>
                        <button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal">返回</button>
                    </div>


    <script>
		$(".upgradeRadio").click(function(){
			$('#modalUpgradeStepOne select').attr("disabled","disabled");
			$(".upgradeSelect"+$(this).data("key")).removeAttr("disabled");
		})
  
       $('#modalUpgradeStepOne .submit').on('click', function(){
            if(!$(this).data('submit')){
                $(this).data('submit', 1)
                let _this = $(this)
				$(this).prepend('<i class="bx bx-loader bx-spin font-size-16 align-middle mr-2"></i>')
                $.ajax({
                    url: "{$Setting.web_url}/servicedetail?id={$Think.get.id}&action=upgrade",
                    type: 'POST',
                    data: $('#modalUpgradeStepOne form').serialize(),
                    success: function(res){
                        if(res.indexOf('modalUpgradeStepTwo') > -1){
                            $('#modalUpgradeStepOne').modal('hide');
                            $('.modal-backdrop.fade.show').remove();

                            if($('#modalUpgradeStepTwoDiv').length == 0){
                                $('#upgradeProductDiv').after('<div id="modalUpgradeStepTwoDiv"></div>');
                            }
                            //$("#upgradeProductDiv").html(res);
                            $("#modalUpgradeStepTwoDiv").html(res);
                            $('#modalUpgradeStepTwo').modal("show");
                        }else if(res.indexOf('<script>') === 0){
                            $("#upgradeProductDiv").append(res);
                        }
                        _this.removeData('submit');
						_this.html("下一步");
                    },
                    error: function(){
                        _this.removeData('submit');
						_this.html("下一步");
                    }
                })
            }
        })
     
        
    </script>

    {else /}

    <div class="modal fade" id="modalUpgradeStepTwo" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title mt-0" id="myLargeModalLabel">升降级</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form>
                        <input type="hidden" value="{$Token}" />

                        <div class="table-responsive">
                            <table class="table table-centered mb-0 table-nowrap">
                                <thead class="thead-light">
                                    <tr>
                                        <th scope="col">原产品</th>
                                        <th scope="col">新产品</th>
                                        <th scope="col">金额</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <th scope="row">
                                      <h5 class="font-size-14 text-truncate">{$Upgrade.old_host.host}</h5>
                                    </th>
                                    <td>
                                        <h5 class="font-size-14 text-truncate">{$Upgrade.des}</h5>
                                    </td>
                                    <td>{$Upgrade.currency.prefix}{$Upgrade.amount}{$Upgrade.currency.suffix}/{$Upgrade.billingcycle_zh}</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>

                        <div class="text-right font-size-18">
                            总计：<span class="text-primary">{$Upgrade.currency.prefix}{$Upgrade.amount_total}{$Upgrade.currency.suffix}/{$Upgrade.billingcycle_zh}</span>
                        </div>
                        <div class="d-flex mb-3">
                            {if !$Upgrade.promo_code}
                            <input type="text" name="pormo_code" class="form-control" value="{$Upgrade.promo_code}" placeholder="请输入优惠码" style="width:230px"/>
                            <button class="btn btn-primary ml-2 use_promo_code" type="button" >应用</button>
                            {else /}
                            <span class="form-control" style="width:230px">{$Upgrade.promo_code}</span>
                            <button class="btn btn-primary ml-2 remove_promo_code" type="button" >移除</button>
                            {/if}
                        </div>
                    </form>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary waves-effect waves-light submit">下一步</button>
                        <button type="button" class="btn btn-secondary waves-effect goback">返回</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        var product_type = '{$Detail.host_data.type}'
        $('#modalUpgradeStepTwo .submit').on('click', function(){
            let postRequest = function(){
                $.ajax({
                    url: "{$Setting.web_url}/upgrade/checkout_upgrade_product",
                    data: {
                        hid: '{$Think.get.id}'
                    },
                    type: "POST",
                    success: function(res){
                        if(res.status == 200){
                            window.location.href = "{$Setting.web_url}/viewbilling?id="+ res.data.invoiceid;
                        }else if(res.status == 1001){
                            toastr.success(res.msg)
                            location.reload();
                        }else{
                            toastr.error(res.msg)
                        }
                    },
                    error: function(){

                    }
                })
            };
            if(product_type == 'cloud' || product_type == 'dcimcloud'){
                $('#modalUpgradeStepTwo').modal('hide');
                $('.modal-backdrop.fade.show').remove();
                let content = "<div>"
                            + "<p>升降级需要服务器在关机状态下进行：</p>"
                            + "<p> 为了避免数据丢失，实例将关机中断您的业务，请仔细确认。 </p>"
                            + "<p> 强制关机可能会导致数据丢失或文件系统损坏，您也可以主动关机后再进行操作。</p>"
                            + "</div>";
                getModalConfirm(content, function(){
                    postRequest();
                });
            }else{
                postRequest();
            }
        })

        $('#modalUpgradeStepTwo .use_promo_code').on('click', function(){
            let _this = $(this)
            if(!$(this).data('submit')){
                $.ajax({
                    url: "{$Setting.web_url}/servicedetail?id={$Think.get.id}&action=upgrade_use_promo_code",
                    type: 'POST',
                    data: $('#modalUpgradeStepTwo form').serialize(),
                    success: function(res){
                        if(res.indexOf('modalUpgradeStepTwo') > -1){
                            $('#modalUpgradeStepTwo').modal('hide');
                            $('.modal-backdrop.fade.show').remove();
                            $("#modalUpgradeStepTwoDiv").html(res);
                            $('#modalUpgradeStepTwo').modal("show");
                        }else if(res.indexOf('<script>') === 0){
                            $("#upgradeProductDiv").append(res);
                        }
                    }
                })
            }
        })

        $('#modalUpgradeStepTwo .remove_promo_code').on('click', function(){
            let _this = $(this)
            if(!$(this).data('submit')){
                $.ajax({
                    url: "{$Setting.web_url}/servicedetail?id={$Think.get.id}&action=upgrade_remove_promo_code",
                    type: 'POST',
                    data: $('#modalUpgradeStepTwo form').serialize(),
                    success: function(res){
                        if(res.indexOf('modalUpgradeStepTwo') > -1){
                            $('#modalUpgradeStepTwo').modal('hide');
                            $('.modal-backdrop.fade.show').remove();
                            $("#modalUpgradeStepTwoDiv").html(res);
                            $('#modalUpgradeStepTwo').modal("show");
                        }else if(res.indexOf('<script>') === 0){
                            $("#upgradeProductDiv").append(res);
                        }
                    }
                })
            }
        })

        $('#modalUpgradeStepTwo .goback').on('click', function(){
            $('#modalUpgradeStepTwo').modal('hide');
            $('.modal-backdrop.fade.show').remove();
            $('#modalUpgradeStepTwoDiv').html('');

            $('#modalUpgradeStepOne').modal('show');
        })
    </script>
    {/if}
{/if}
