{if $ErrorMsg}
<script>
$(function () {
  toastr.error('{$ErrorMsg}');
});
</script>
{else /}

    {if $Action == "upgrade_configoption_page"}

                    <form data-class="configoption_form">
                        {foreach $UpgradeConfig.host as $option}
                        {if $option.option_type==1}
                          <div class="form-group row configureproduct">
                            <label for="example-search-input" class="col-md-2 col-form-label">{$option.option_name}
                            </label>
                            <div class="col-md-3">										
                              <select id="config{$option.oid}" name="configoption[{$option.oid}]" class="form-control selectpicker" data-style="btn-default">
                                {foreach $option.sub as $sub}
                                <option id="sub{$sub.id}" {if $option.subid==$sub.id} selected="" {/if} value="{$sub.id}">{$sub.option_name}</option>
                                {/foreach}
                              </select>
                            </div>
                          </div>
                          {elseif $option.option_type==2 /}
                          <div class="form-group row configureproduct">   
                            <label for="example-search-input" class="col-md-2 col-form-label">{$option.option_name}</label> 
                            <div class="col-md-10"> 
                              {foreach $option.sub as $sub_key=>$sub_val}
                              <div class="form-check mb-3">
                                <input id="config{$option.oid}_{$sub_val.id}" type="radio" name="configoption[{$option.oid}]" value="{$sub_val.id}" class="form-check-input" {if $option.subid==$sub_val.id}checked=""{/if}>
                                <label class="form-check-label" for="config{$option.oid}_{$sub_val.id}">{$sub_val.option_name}</label>
                                </div>
                              {/foreach}								
                            </div>              
                          </div>
                          {elseif $option.option_type==3 /}
                          <div class="form-group row configureproduct">   
                            <label for="example-search-input" class="col-md-2 col-form-label">{$option.option_name}</label> 
                            <div class="col-md-10"> 
                              {foreach $option.sub as $sub_key=>$sub_val}
                              <div class="custom-control custom-checkbox mb-3">
                                <input id="config{$option.oid}_{$sub_val.id}" type="checkbox" name="configoption[{$option.oid}]" class="custom-control-input" {if $option.subid==$sub_val.id} checked="" {/if}  value="{$sub_val.id}">
                                <label class="custom-control-label" for="config{$option.oid}_{$sub_val.id}">{$sub_val.option_name}</label>
                              </div>
                              {/foreach}	
                            </div>              
                          </div>
                          {elseif $option.option_type==4 || $option.option_type==7 || $option.option_type==9 || $option.option_type==11 || $option.option_type==14 || $option.option_type==15 || $option.option_type==16 || $option.option_type==17 || $option.option_type==18 || $option.option_type==19  /}
                          <div class="form-group row configureproduct">
                            <label for="example-search-input" class="col-md-2 col-form-label">{$option.option_name}</label>
                            <div class="col-md-10 d-flex align-items-center">
                              <!-- <input type="range" min="{$option.qty_minimum}" max="{$option.qty_maximum}" value="{$option.qty}" data-sub='{:json_encode($option.sub)}'  class="form-control-range configoption_range"> -->
                              <input type="range" min="{$option.qty_minimum}" max="{$option.qty_maximum}" value="{$option.qty}" data-sub='{:json_encode($option.sub)}'  class="form-control-range configoption_range float-left mr-2"  style="width: 80%;">
                              <input id="config{$option.oid}" data-type="number" class="col-md-1 form-control form-control-sm configoption_range_val" name="configoption[{$option.oid}]" type="text" min="{$option.qty_minimum}" max="{$option.qty_maximum}" value="{$option.qty}" >
                              {if $option.option_type == '4' || $option.option_type == '15'}
                                <span>个</span>
                              {elseif $option.option_type == '7' || $option.option_type == '16'}
                                <span>核</span>
                              {elseif $option.option_type == '9' || $option.option_type == '17'}
                                <span>GB</span>
                              {elseif $option.option_type == '11' || $option.option_type == '18'}
                                <span>Mbps</span>
                              {elseif $option.option_type == '14' || $option.option_type == '19'}
                                <span>GB</span>
                              {/if}
                            </div>
                          </div>
                          {elseif $option.option_type==6 || $option.option_type==8 || $option.option_type==10 || $option.option_type==13 /}
                          <div class="form-group row configureproduct">   
                            <label for="example-search-input" class="col-md-2 col-form-label">{$option.option_name}</label> 
                            <div class="col-md-10"> 
                              <div class="btn-group btn-group-toggle mt-2 mt-xl-0" data-toggle="buttons">
                                {foreach $option.sub as $sub_key=>$sub_val}
                                <label class="btn btn-primary btn-sm {if $option.subid==$sub_val.id}active{/if}">
                                  <input id="config{$option.oid}_{$sub_val.id}" type="radio" {if $option.subid==$sub_val.id}checked="" {/if} name="configoption[{$option.oid}]"  value="{$sub_val.id}" > {$sub_val.option_name}
                                </label>
                                {/foreach}	
                              </div>
                            </div>              
                          </div>
                          {/if}
                        {/foreach}
                    </form>
                   <div class="modal-footer">
                      <button type="button" class="btn btn-primary waves-effect waves-light submit">下一步</button>
                      <button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal">返回</button>
                  </div>




    <script>
		var UpgradeConfigStepOne=$('#modalUpgradeConfigStepOne form').serialize();
        $('#modalUpgradeConfigStepOne .submit').on('click', function(){
			if($('#modalUpgradeConfigStepOne form').serialize()==UpgradeConfigStepOne) return false;
            if(!$(this).data('submit')){
                $(this).data('submit', 1);
				$(this).prepend('<i class="bx bx-loader bx-spin font-size-16 align-middle mr-2"></i>')
                let _this = $(this);
                $.ajax({
                    url: "{$Setting.web_url}/servicedetail?id={$Think.get.id}&action=upgrade_config",
                    type: 'POST',
                    data: $('#modalUpgradeConfigStepOne form').serialize() + '&action=upgrade_config',
                    success: function(res){
                        if(res.indexOf('modalUpgradeConfigStepTwo') > -1){
                            $('#modalUpgradeConfigStepOne').modal('hide')
                            $('.modal-backdrop.fade.show').remove();

                            if($('#modalUpgradeConfigStepTwoDiv').length == 0){
                                $("#upgradeConfigDiv").after('<div id="modalUpgradeConfigStepTwoDiv"></div>');
                            }
                            $('#modalUpgradeConfigStepTwoDiv').html(res);

                            //$("#upgradeConfigDiv").html(res);
                            $('#modalUpgradeConfigStepTwo').modal("show");
                        }else if(res.indexOf('<script>') === 0){
                            $("#upgradeConfigDiv").append(res);
                        }
                        _this.removeData('submit')
						_this.html("下一步");
                    },
                    error: function(){
                        _this.removeData('submit')
						_this.html("下一步");
                    }
                })
            }
        })
    </script>


<link rel="stylesheet" href="{$Setting.web_url}/themes/clientarea/default/assets/libs/bootstrap-select/css/bootstrap-select.min.css?v={$Ver}">
<script src="{$Setting.web_url}/themes/clientarea/default/assets/libs/bootstrap-select/js/bootstrap-select.min.js?v={$Ver}"></script>
<script>
var links={:json_encode($UpgradeConfig.links)};
$('.selectpicker').selectpicker();
//下拉
$("form[data-class=\"configoption_form\"] select").change(function(){
	configoption_ajax();
})
//单选
$('form[data-class="configoption_form"] input[type="radio"],form[data-class="configoption_form"] input[type="checkbox"]').click(function(){
    configoption_ajax();
})
$(".configoption_range").mousedown(function(){
	$(this).data("active",true);
});
$(".configoption_range").mouseup(function(){
	rangeChange($(this));
	$(this).removeData("active");
	configoption_ajax();
});
function rangeChange(_this) {
	if($(_this).data("active")){
		var range = $(_this).val();
		if (range_sub($(_this), range)) {
			$(_this).siblings(".configoption_range_val").val(range);		
		} else {
			$(_this).val($(_this).siblings(".configoption_range_val").val());
		}
	}
}

$(document).on('click',':not(.configoption_range_val)',function(){
	$(".configoption_range_val").each(function (i) {
		if($(this).data("active")){
			$(this).removeData("active");
			numberKeyup2($(this));
		}	
	})
})

function numberKeyup(_this) {
	$(_this).data("active",true);
}
function numberKeyup2(_this) {
    //输入
    _this.val(_this.val().replace(/[^\d]/g,''));
    var min=_this.attr("min");
    var val=(min!="")?(min):"0";
    if(_this.val()=="") _this.val(val);
    var number = _this.val();
    if (range_sub(_this.siblings(".configoption_range"), number)) {
        _this.siblings(".configoption_range").val(number);
        
    } else {
        _this.val(_this.siblings(".configoption_range").val());
    }
	configoption_ajax();
}

//滑块
function range_sub (range, val) {
    var sub = range.data("sub");
    var range_v = 0, range_i;
    $.each(sub, function (i, v) {
        range_i = i + 1;
        if (v.qty_minimum > val || v.qty_maximum < val) range_v += 1;
    })
    if (range_i == range_v) return false;
    return true;
}
function configoption_ajax(){
	config_options_links();
	config_options_links();//对前面匹配的再次匹配，防止无效的条件判断。
	$('.selectpicker').selectpicker("refresh");
}
window.onload=function(){
configoption_ajax();
}

//高级配置项
function config_options_links () {
    if (!links) return false;
    clear_disabled();
    $.each(links, function (key, val) {
        //条件
        var configcondition = config_condition(val);
        //console.log(val);
        //console.log(configcondition);
        //结果
        if (configcondition) {
            config_result(val.result);
        }
    })
}
//清除disabled
function clear_disabled () {
    $(".configureproduct input").parent().removeClass("disabled");
    $(".configureproduct input").removeAttr("disabled");
    $(".configureproduct select option").removeAttr("disabled");
    $(".configureproduct select").removeClass("disabled");
}
//判断条件是否成立
function config_condition (condition) {
    var _condition = false;
    if (condition.relation == "seq") {
        $.each(condition.sub_id, function (sub_key, sub_val) {
            if ($("#config" + condition.config_id).length > 0) {
                conditionTagName = $("#config" + condition.config_id)[0].tagName.toLowerCase();
                if (conditionTagName == "select" && $("#config" + condition.config_id).val() == sub_key) {
                    _condition = true;
                } else if (conditionTagName == "input" && $("#config" + condition.config_id).val() >= sub_val.qty_minimum && $("#config" + condition.config_id).val() <= sub_val.qty_maximum) {
                    _condition = true;
                }

            } else if ($("#config" + condition.config_id + "_" + sub_key).length > 0) {
                if ($("#config" + condition.config_id + "_" + sub_key + ":checked").val() == sub_key) {
                    _condition = true;
                }
            }
        });
    } else if (condition.relation == "sneq") {
        $.each(condition.sub_id, function (sub_key, sub_val) {
            if ($("#config" + condition.config_id).length > 0) {
                conditionTagName = $("#config" + condition.config_id)[0].tagName.toLowerCase();
                if (conditionTagName == "select" && $("#config" + condition.config_id).val() != sub_key) {
                    _condition = true;
                } else if (conditionTagName == "input" && ($("#config" + condition.config_id).val() <= sub_val.qty_minimum || $("#config" + condition.config_id).val() >= sub_val.qty_maximum)) {
                    _condition = true;
                }

            } else if ($("#config" + condition.config_id + "_" + sub_key).length > 0) {
                if ($("#config" + condition.config_id + "_" + sub_key + ":checked").val() != sub_key) {
                    _condition = true;
                }
            }
            //console.log($("#config"+condition.config_id).val());
            //console.log(sub_key);
        });
        //_condition=false;
    }
    return _condition;
}
//结果
function config_result(result){ 
	$.each(result,function(result_key,result_val){
		var       configoption=$("input[name='configoption["+result_val.config_id+"]']");//匹配的数据绑定的标签

        //console.log(result_val);
        var conditionConfig = "#config" + result_val.config_id;
        if ($(conditionConfig).length > 0) {
            //console.log($(conditionConfig).length);
            conditionTagName = $(conditionConfig)[0].tagName.toLowerCase();
            if (result_val.relation == "seq") {
                if (conditionTagName == "select") {
					var selected_val=$(conditionConfig).val();
                    $(conditionConfig).find("option").attr("disabled", "disabled");
                } else if (conditionTagName == "input") {
                    $(conditionConfig).attr("disabled", "disabled");
                    $(conditionConfig).parent().addClass("disabled");
                }
            } else {
                if (conditionTagName == "select") {
					var selected_val=$(conditionConfig).val();
                    $(conditionConfig).find("option").removeAttr("disabled");
                } else if (conditionTagName == "input") {
                    $(conditionConfig).removeAttr("disabled");
                    $(conditionConfig).parent().removeClass("disabled");
				}
			}

		}else{
			if(result_val.relation=="seq"){
				configoption.attr("disabled","disabled");
                configoption.parent().addClass("disabled");
			}else if( result_val.relation=="sneq"){
				configoption.removeAttr("disabled");
                configoption.parent().removeClass("disabled");
			}
		}
		var subSeq=[],subSeqChecked=false,subSneq=[],subSneqChecked=false,
		subSeqNumber=[],subSeqNum=false,subSeqQtyMin;
		var count=Object.keys(result_val.sub_id).length,num=0;
		$.each(result_val.sub_id,function(key,val){
			var conditionConfigId=conditionConfig+"_"+key;
			
			if($(conditionConfig).length > 0){
			//配置项ID
				condition_subid=Number($(conditionConfig).val());
				
				if(result_val.relation=="seq"){
				//匹配的数据相等 除了相等的值，其它禁选择
					
					if($(conditionConfig).data("type")=="number"){
					//数字类型
						$(conditionConfig).removeAttr("disabled");
                        $(conditionConfig).parent().removeClass("disabled");
                        if (!subSeqQtyMin) subSeqQtyMin = val.qty_minimum;
                        if (condition_subid < val.qty_minimum || condition_subid > val.qty_maximum) {
                            num++;
                            if (count == num) {
                                number = subSeqQtyMin;
                                $(conditionConfig).val(number);
                                $(conditionConfig).siblings(".configoption_range").val(number);
                            }
                            //console.log("count:"+count);
                            //console.log("num:"+num);
                        }
                    } else {
                        $(conditionConfig).find("#sub" + key).removeAttr("disabled");
                        $(conditionConfig).find("#sub" + key).prop("selected", false);
                        //if ($(conditionConfig).is(":selected")) subSneqChecked = true;
						if (selected_val==$("#sub" + key).val()) subSeqChecked = true;
                        subSeq[key] = conditionConfig;
                    }
                } else if (result_val.relation == "sneq") {
                    //匹配的数据不相等 相等的值禁选择
                    if ($(conditionConfig).data("type") == "number") {
                        //数字类型

                    } else {
                        $(conditionConfig).find("#sub" + key).attr("disabled", "disabled");
                        $(conditionConfig).find("#sub" + key).prop("selected", false);
                        //if ($(conditionConfig).is(":selected")) subSeqChecked = true;
						if (selected_val==$("#sub" + key).val()) subSneqChecked = true;
                        subSneq[key] = conditionConfig;
                    }

                }
            } else if ($(conditionConfigId).length > 0) {
                //配置项配置ID
                if (result_val.relation == "seq") {
                    //匹配的数据相等
                    subSeq[key] = conditionConfigId;
                    if ($(conditionConfigId).is(":checked")) subSeqChecked = true;
                    $(conditionConfigId).removeAttr("disabled");
                    $(conditionConfigId).parent().removeClass("disabled");
				}else if( result_val.relation=="sneq"){
					subSneq[key]=conditionConfigId;
					if($(conditionConfigId).is(":checked")) subSneqChecked=true;
					//匹配的数据不相等 相等的值禁选择							
					$(conditionConfigId).attr("disabled","disabled");
                    $(conditionConfigId).parent().addClass("disabled");
					$(conditionConfigId).prop("checked",false);
					$(conditionConfigId).parent().removeClass("active");
				}
			}
			
		});
		var checkedSubSeq=false,checkedSnubSeq=false;
		if($(conditionConfig).length > 0){
		//conditionConfig 类型结果判断
			$.each($(conditionConfig).find("option"),function(){
				if(subSeq.length>0){
					//console.log(subSeq);
					if($(this).attr("disabled")){
						$(this).prop("selected",false);						
					}else if(!checkedSubSeq && subSeq[$(this).val()] && !subSeqChecked){					
						$(this).prop("selected",true);						
						checkedSubSeq=true;
					} 
				}else if(subSneq.length>0){					
					if($(this).attr("disabled")){
						$(this).prop("selected",false);						
					}else if(!checkedSnubSeq  && subSneqChecked){
						$(this).prop("selected",true);						
						checkedSnubSeq=true;
					}
				}
				
			});
		}else{
		//conditionConfigId 类型结果判断
			$.each(configoption,function(i,v){
				if(subSeq.length>0){					
					//console.log(subSeq);
					if($(this).attr("disabled")){
						//console.log($(this).val());
						$(this).prop("checked",false);
						$(this).parent().removeClass("active");
					}else if(!checkedSubSeq && subSeq[$(this).val()] && !subSeqChecked){					
						$(this).prop("checked",true);							
						$(this).parent().addClass("active");
						checkedSubSeq=true;
					} 
				}else if(subSneq.length>0){
					
					if($(this).attr("disabled")){
						$(this).prop("checked",false);
						$(this).parent().removeClass("active");
					}else if(!checkedSnubSeq  && subSneqChecked){
						$(this).prop("checked",true);
						$(this).parent().addClass("active");
						checkedSnubSeq=true;
					}
				}
				
			});
		}
	});
}
</script>

    
    {else /}
    <div class="modal fade" id="modalUpgradeConfigStepTwo" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered ">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title mt-0" id="myLargeModalLabel">结算</h5>
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
                                        <th scope="col">原配置</th>
                                        <th scope="col">新配置</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {foreach $UpgradeConfig.alloption as $item}
                                    <tr>
                                        <td scope="row">
                                            <h5 class="font-size-14 text-truncate">{$item.option_name}:{if $item.old_qty} {$item.old_qty} {else/}{$item.old_suboption_name}{/if}</h5>
                                        </td>
                                        <td>
                                            <h5 class="font-size-14 text-truncate">{$item.option_name}:{if $item.old_qty} {$item.qty} {else/}{$item.suboption_name}{/if}</h5>
                                        </td>
                                        
                                    </tr>
                                    {/foreach}
                                    
                                </tbody>
                            </table>
                        </div>
                        <div class="text-right font-size-18">
                            总计：<span class="text-primary">{$UpgradeConfig.currency.prefix}{$UpgradeConfig.total}{$UpgradeConfig.currency.suffix}/{$UpgradeConfig.billingcycle_zh}</span>
                        </div>
                        <div class="d-flex mb-3">
                            {if !$UpgradeConfig.promo_code}
                            <input type="text" name="pormo_code" class="form-control" value="{$UpgradeConfig.promo_code}" placeholder="请输入优惠码" style="width:230px"/>
                            <button class="btn btn-primary ml-2 use_promo_code" type="button">应用</button>
                            {else /}
                            <span class="form-control" style="width:230px">{$UpgradeConfig.promo_code}</span>
                            <button class="btn btn-primary ml-2 remove_promo_code" type="button" >移除</button>
                            {/if}
                        </div>
                        <input type="hidden" name="hid" value="{$Think.get.id}">
                        {foreach $UpgradeConfig.configoptions as $key=>$item}
                        <input type="hidden" name="configoption[{$key}]" value="{$item}">
                        {/foreach}
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
     var flag = true
       $('#modalUpgradeConfigStepTwo .submit').on('click', function(){
         if(flag){
           flag = false
			$(this).prepend('<i class="bx bx-loader bx-spin font-size-16 align-middle mr-2"></i>');
			let _this = $(this);
            let postRequest = function(){
                let url = "{$Setting.web_url}/upgrade/checkout_config_upgrade";
                $.ajax({
                    url: "{$Setting.web_url}/upgrade/checkout_config_upgrade",
                    data: $("#modalUpgradeConfigStepTwo form").serialize(),
                    type: "POST",
                    success: function(res){
                      // flag = true
                        if(res.status == 200){
                            window.location.href = "{$Setting.web_url}/viewbilling?id="+ res.data.invoiceid;
                        }else if(res.status == 1001){
                            toastr.success(res.msg)
                            window.location.reload()
                        }else{
                            toastr.error(res.msg)
                        }
						            _this.html("下一步");
                    },
                    error: function(){
                      //  flag = true
						          _this.html("下一步");
                    }
                })
            };
            if(product_type == 'cloud' || product_type == 'dcimcloud'){
                $('#modalUpgradeConfigStepTwo').modal('hide');
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
             }
        })
       

        $('#modalUpgradeConfigStepTwo .use_promo_code').on('click', function(){
            if(!$(this).data('submit')){
                $(this).data('submit', 1)
				$(this).prepend('<i class="bx bx-loader bx-spin font-size-16 align-middle mr-2"></i>');
                let _this = $(this)
                $.ajax({
                    url: "{$Setting.web_url}/servicedetail?id={$Think.get.id}&action=upgrade_config_use_promo_code",
                    type: 'POST',
                    data: $('#modalUpgradeConfigStepTwo form').serialize(),
                    success: function(res){
                        if(res.indexOf('modalUpgradeConfigStepTwo') > -1){
                            $('#modalUpgradeConfigStepTwo').modal('hide');
                            $('.modal-backdrop.fade.show').remove();
                            $("#modalUpgradeConfigStepTwoDiv").html(res);
                            $('#modalUpgradeConfigStepTwo').modal("show");
                        }else if(res.indexOf('<script>') === 0){
                            $("#upgradeConfigDiv").append(res);
                        }
                        _this.removeData('submit')
						_this.html("应用");
                    },
                    error: function(){
                        _this.removeData('submit')
						_this.html("应用");
                    }
                })
            }
        })

        $('#modalUpgradeConfigStepTwo .remove_promo_code').on('click', function(){
            if(!$(this).data('submit')){
                $(this).data('submit', 1)
				$(this).prepend('<i class="bx bx-loader bx-spin font-size-16 align-middle mr-2"></i>');
                let _this = $(this)
                $.ajax({
                    url: "{$Setting.web_url}/servicedetail?id={$Think.get.id}&action=upgrade_config_remove_promo_code",
                    type: 'POST',
                    data: $('#modalUpgradeConfigStepTwo form').serialize(),
                    success: function(res){
                        if(res.indexOf('modalUpgradeConfigStepTwo') > -1){
                            $('#modalUpgradeConfigStepTwo').modal('hide');
                            $('.modal-backdrop.fade.show').remove();
                            $("#modalUpgradeConfigStepTwoDiv").html(res);
                            $('#modalUpgradeConfigStepTwo').modal("show");
                        }else if(res.indexOf('<script>') === 0){
                            $("#upgradeConfigDiv").append(res);
                        }
                        _this.removeData('submit')
						_this.html("移除");
                    },
                    error: function(){
                        _this.removeData('submit')
						_this.html("移除");
                    }
                })
            }
        })

        $('#modalUpgradeConfigStepTwo .goback').on('click', function(){
            $('#modalUpgradeConfigStepTwo').modal('hide');
            $('.modal-backdrop.fade.show').remove();
            $('#modalUpgradeConfigStepTwoDiv').html('');

            $('#modalUpgradeConfigStepOne').modal('show');
        })
    </script>
    {/if}
{/if}
