{include file="includes/cancelrequire"}
{include file="includes/pop"}

<script src="{$Setting.web_url}/themes/clientarea/fantacy/assets/libs/echarts/echarts.min.js?v={$Ver}"></script>
<div class="container-fluid">
  <div class="row">
    <div class="col-12">
      <div class="card">
        <div class="card-body">
          <div class="row align-items-center">
            <div class="col-md-5 mb-2">
              <div class="power-detail-box bg-primary rounded text-white p-3 d-flex">
                <!-- 电源状态 -->
                <div class="mr-3 pointer">
                  {if $Detail.module_power_status == '1'}
                  <div class="powerimg d-flex justify-content-center align-items-center" id="powerBox">
                    <span id="powerStatusIcon" class="bx bx-loader" data-toggle="popover" data-trigger="hover" title=""
                      data-html="true" data-content="{$Lang.loading}..."></span>
                  </div>
                  {else}
                  <div class="powerimg d-flex justify-content-center align-items-center" id="statusBox"></div>
                  {/if}
                </div>
                <div>
                  <section class="d-flex align-items-center mb-3">
                    <h4 class="text-white mb-0 font-weight-bold">{$Detail.host_data.productname}</h4>
                    <span class="badge badge-pill ml-2 py-1 status-{$Detail.host_data.domainstatus|strtolower}">
                      {$Detail.host_data.domainstatus_desc}
                    </span>
                  </section>
                  <section class="d-flex justify-content-between">
                    <span>{$Detail.host_data.domain}</span>
                    <span class="cancelBtn" id="cancelDcimTask" style="display:none;" onclick="cancelDcimTask('{$Think.get.id}')">{$Lang.cancel_task}</span>
                  </section>
                </div>
              </div>
            </div>
            <div class="bg-light rounded p-3 ml-2 mr-3 mb-2  min-95">				
				<h5 class="mb-3 font-weight-bold">{$Detail.host_data.os}</h5>
				<span class="text-gray">{$Lang.operating_system}</span>				
				{if in_array('reinstall', array_column($Detail.module_button.control, 'func')) && $Detail.host_data.domainstatus=="Active"}
				<span>
				<button type="button" class="btn btn-primary btn-sm waves-effect waves-light dcim_service_module_button" onclick="dcim_service_module_button($(this), '{$Think.get.id}')"
				  data-func="reinstall" data-type="default">{$Lang.reinstall_system}</button>
				</span>	
				{/if}	
            </div>
            {foreach $Detail.config_options as $item}
            {if $item.option_type == '6'||$item.option_type == '8'}
            <div class="bg-light rounded p-3 ml-2 mr-3 mb-2  min-95">
              <h5 class="mb-3 font-weight-bold">{$item.sub_name}</h5>
              <span class="text-gray">{$item.name}</span>
            </div>
            {/if}
            {/foreach}
            <div class="bg-light rounded p-3 ml-2 mr-3 mb-2  min-95">
              <h5 class="mb-3 font-weight-bold">
                <!-- <span data-toggle="popover" data-trigger="hover" title="" data-html="true" data-content="
                  {foreach $Detail.host_data.assignedips as $list}
                  <div>{$list}</div>
                  {/foreach}
                "> -->
                <span>
                  {if $Detail.host_data.dedicatedip}
                  {if $Detail.host_data.assignedips}
                  <span id="copyIPContent">{$Detail.host_data.dedicatedip}</span>
                  <span>({$Detail.host_data.assignedips|count})</span>
                  {else}
                  <span id="copyIPContent">{$Detail.host_data.dedicatedip}</span>
                  {/if}
                  <i class="bx bx-copy pointer text-primary ml-1 btn-copy-ip" id="btnCopyIP" data-clipboard-action="copy"
                    data-clipboard-target="#copyIPContent"></i>
                  {else}
                  -
                  {/if}

                </span>

              </h5>
              <span class="text-gray">{$Lang.ip_address}</span>
            </div>
            <div class="bg-light rounded p-3 ml-2 mb-2  min-95">
              <h5 class="mb-3">
                <span id="hidePwdBox">***********</span>
                <span id="copyPwdContent">{$Detail.host_data.password}</span>
                <i class="fas fa-eye pointer text-primary ml-2" onclick="togglePwd()"></i>
                <i class="bx bx-copy pointer text-primary ml-1 btn-copy-pwd" data-clipboard-action="copy"
                  data-clipboard-target="#copyPwdContent"></i>
              </h5>
              <span class="text-gray">{$Lang.password}</span>
			  {if in_array('crack_pass', array_column($Detail.module_button.control, 'func')) && $Detail.host_data.domainstatus=="Active"}
			  <span>
                <button type="button" class="btn btn-primary btn-sm waves-effect waves-light dcim_service_module_button" onclick="dcim_service_module_button($(this), '{$Think.get.id}')"
                  data-func="crack_pass" data-type="default">{$Lang.crack_password}</button>
              </span>
			  {/if}
            </div>


            <div class="d-flex justify-content-end flex-shrink-1 flex-grow-1">


              {if  $Detail.module_button.control  && $Detail.host_data.domainstatus=="Active"}

              <div class="btn-group ml-2 mr-2 mt-2">

                <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown"
                  aria-haspopup="true" aria-expanded="false">{$Lang.control} <i class="mdi mdi-chevron-down"></i></button>

                <div class="dropdown-menu">

                  {foreach $Detail.module_button.control as $item}

                  {if $item.func != 'crack_pass' && $item.func != 'reinstall'}

                  <a class="dropdown-item service_module_button" href="javascript:void(0);" onclick="service_module_button($(this), '{$Think.get.id}', '{$Detail.host_data.type}')" data-func="{$item.func}"
                    data-type="{$item.type}" data-desc="{$item.desc ?: $item.name}">{$item.name}</a>

                  {/if}

                  {/foreach}

                </div>

              </div>

              {if $Detail.module_button.console && $Detail.host_data.domainstatus=="Active"}

              <div class="btn-group ml-2 mr-2 mt-2">
                {if ($Detail.module_button.console|count) == 1}
                {foreach $Detail.module_button.console as $item}
                <a class="btn btn-primary service_module_button d-flex align-items-center" href="javascript:void(0);" onclick="service_module_button($(this), '{$Think.get.id}', '{$Detail.host_data.type}')"
                  data-func="{$item.func}" data-type="{$item.type}" data-desc="">{$item.name}</a>
                {/foreach}
                {else}
                <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown"
                  aria-haspopup="true" aria-expanded="false">{$Lang.console} <i class="mdi mdi-chevron-down"></i></button>

                <div class="dropdown-menu">

                  {foreach $Detail.module_button.console as $item}

                  <a class="dropdown-item service_module_button" href="javascript:void(0);" onclick="service_module_button($(this), '{$Think.get.id}', '{$Detail.host_data.type}')" data-func="{$item.func}"
                    data-type="{$item.type}" data-desc="">{$item.name}</a>

                  {/foreach}

                </div>
                {/if}

              </div>

              {/if}

              {/if}


              <div class="btn-group ml-2 mr-2 mt-2">
                {if $Detail.host_data.domainstatus == 'Active'}

                <span>

                  {if $Cancel.host_cancel}

                  <button class="btn btn-danger mb-1 h-100" id="cancelStopBtn" onclick="cancelStop('{$Cancel.host_cancel.type}', '{$Think.get.id}')">{if $Cancel.host_cancel.type ==
                    'Immediate'}{$Lang.stop_now}{else}{$Lang.stop_when_due}{/if}</button>

                  {else}

                  <button class="btn btn-primary mb-1 h-100" data-toggle="modal"
                    data-target=".cancelrequire">{$Lang.out_service}</button>

                  {/if}

                </span>

                {/if}
              </div>
              <!--  20210331 增加产品转移hook输出按钮template_after_servicedetail_suspended.7-->
              {php}$hooks=hook('template_after_servicedetail_suspended',['hostid'=>$Detail['host_data']['id']]);{/php}
              {if $hooks}
                {foreach $hooks as $item}
                  <div class="btn-group ml-0 mr-2 mt-2">
                      <span>
                      {$item}
                      </span>
                  </div>
                {/foreach}
              {/if}
              <!-- 结束 -->
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-md-3">
      <div class="card">
        <div class="card-body">
          <div class="mb-3 text-center" id="logininfo" style="width: 100px;height: 30px;line-height: 30px;background-color: #ffffff;box-shadow: 0px 4px 20px 2px rgba(6, 75, 179, 0.08);border-radius: 4px;cursor: pointer;">
            {$Lang.login_information}
          </div>
          {if $Detail.host_data.domainstatus == 'Active' && $Detail.host_data.bwlimit > 0}
          <div class="d-flex justify-content-end mb-2">
            <button type="button" class="btn btn-success btn-sm waves-effect waves-light"
              id="orderFlowBtn" onclick="orderFlow($(this), '{$Think.get.id}')">{$Lang.order_flow}</button>
          </div>
          <p>
            {$Lang.used_flow}：<span id="usedFlowSpan">-</span>
            {$Lang.residual_flow}：<span id="remainingFlow">-</span>
          </p>
          <div class="progress mb-4">
            <div class="progress-bar progress-bar-striped bg-success" id="totalProgress" role="progressbar"
              style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">100%
            </div>
          </div>
          {/if}
          <div class="row">
            {foreach $Detail.config_options as $item}
            {if $item.option_type == '5'||$item.option_type == '6'||$item.option_type == '8'}
            {else}
            <div class="col-md-6 mb-2">
              <div class="bg-light card-body py-2  bg-gray">
                <p class="text-gray">{$item.name}</p>
                <p class="mb-0">
                  {if $item.option_type===12}
                  <img src="{$Setting.web_url}/upload/common/country/{$item.code}.png" width="20px">
                  {/if}
                  {$item.sub_name}
                </p>
              </div>
            </div>
            {/if}
            {/foreach}
            {foreach $Detail.custom_field_data as $item}
            {if $item.showdetail == 1}
            <div class="col-md-6 mb-2">
              <div class="bg-light card-body py-2 bg-gray">
                <p class="text-gray">{$item.fieldname}</p>
                <p class="mb-0">
                  {$item.value}
                </p>
              </div>
            </div>
            {/if}
            {/foreach}
            <div class="col-12 mb-2">
              <div class="bg-light card-body  bg-gray">
                <p class="text-gray">{$Lang.remarks_infors}</p>
                <p class="mb-0">{$Detail.host_data.remark?$Detail.host_data.remark:'-'}
                  <span class="bx bx-edit-alt pointer ml-2" data-toggle="modal" data-target="#modifyRemarkModal"></span>
                </p>

              </div>
            </div>
            <div class="col-12 my-2">
              <div class="d-flex justify-content-between align-items-center">
                <span>{$Lang.first_order_price}</span>
                {if $Detail.host_data.status == 'Paid'}
                {if $Detail.host_data.billingcycle != 'free' && $Detail.host_data.billingcycle != 'onetime' &&
                ($Detail.host_data.domainstatus == 'Active' || $Detail.host_data.domainstatus == 'Suspended')}
                <button type="button" class="btn btn-primary btn-sm waves-effect waves-light" id="renew" onclick="renew($(this), '{$Think.get.id}')">{$Lang.immediate_renewal}</button>
                {/if}
                {/if}
                {if $Detail.host_data.status == 'Unpaid'}
                <a href="viewbilling?id={$Detail.host_data.invoice_id}">
                  <button type="button" class="btn btn-primary btn-sm waves-effect waves-light" id="renewpay">{$Lang.immediate_renewal}</button>
                </a>
                {/if}
              </div>
            </div>
            <div class="col-12">
              <div class="bg-light card-body  bg-gray">
                <section class="d-flex align-items-center">
                  <h3 class="mb-0 mr-2">
                    {$Detail.host_data.firstpaymentamount_desc?$Detail.host_data.firstpaymentamount_desc:'-'}</h3>
                  <span class="badge
                      {$Detail.host_data.format_nextduedate.class}">{$Detail.host_data.format_nextduedate.msg}</span>
                </section>
                {if $Renew.host.billingcycle != 'onetime' && $Renew.host.status == 'Paid' && $Renew.host.billingcycle != 'free'}
                <section class="d-flex align-items-center">
                  <span>{$Lang.automatic_balance_renewal}</span>
                  <div class="custom-control custom-switch custom-switch-md mb-4 ml-2" dir="ltr">
                    <input type="checkbox" class="custom-control-input" id="automaticRenewal" onchange="automaticRenewal('{$Think.get.id}')" {if
                      $Detail.host_data.initiative_renew !=0}checked {/if}> <label class="custom-control-label"
                      for="automaticRenewal"></label>
                  </div>
                </section>
                {/if}
                <section class="text-gray">
                  <p>{$Lang.subscription_date}：{$Detail.host_data.regdate|date="Y-m-d H:i"}</p>
                  <p>{$Lang.payment_cycle}：{$Detail.host_data.billingcycle_desc}</p>
                  
                  {if $Detail.host_data.billingcycle == 'free' || $Detail.host_data.billingcycle == 'onetime'}
                  <p>{$Lang.due_date}：{$Detail.host_data.format_nextduedate.msg}</p>
                  {else}
                  <p>{$Lang.due_date}：{$Detail.host_data.nextduedate|date="Y-m-d H:i"}</p>
                  {/if}
                </section>
              </div>
            </div>

          </div>
        </div>
      </div>
    </div>
    <div class="col-md-9">
      <div class="card">
        <div class="card-body ">
          <ul class="nav nav-tabs nav-tabs-custom" role="tablist">
            {if $Detail.host_data.domainstatus == 'Active' && $Detail.dcim && $Detail.dcim.auth.traffic == 'on'}
            <li class="nav-item" id="chartLi">
              <a class="nav-link active" data-toggle="tab" href="#home1" role="tab">
                <!-- <span class="d-block d-sm-none"><i class="fas fa-home"></i></span> -->
                <span>{$Lang.charts}</span>
              </a>
            </li>
            {/if}
            {if $Detail.host_data.domainstatus == 'Active' && ($Detail.host_data.allow_upgrade_config ||
            $Detail.host_data.allow_upgrade_product)}
            <li class="nav-item">
              <a class="nav-link {if !($Detail.dcim && $Detail.dcim.auth.traffic == 'on')}active{/if}" data-toggle="tab"
                href="#profile1" role="tab">
                <!-- <span class="d-block d-sm-none"><i class="far fa-user"></i></span> -->
                <span>{$Lang.upgrade_downgrade}</span>
              </a>
            </li>
            {/if}
            {if $Detail.download_data}
            <li class="nav-item">
              <a class="nav-link {if !($Detail.host_data.domainstatus == 'Active' && $Detail.dcim && $Detail.dcim.auth.traffic == 'on') && !($Detail.host_data.domainstatus == 'Active' && ($Detail.host_data.allow_upgrade_config ||
              $Detail.host_data.allow_upgrade_product))}active{/if}" data-toggle="tab" href="#messages1" role="tab">
                <!-- <span class="d-block d-sm-none"><i class="far fa-envelope"></i></span> -->
                <span>{$Lang.file_download}</span>
              </a>
            </li>
            {/if}
            {if $Detail.host_data.show_traffic_usage}
            <li class="nav-item" id="usedLi">
              <a class="nav-link {if !($Detail.host_data.domainstatus == 'Active' && $Detail.dcim && $Detail.dcim.auth.traffic == 'on') && !($Detail.host_data.domainstatus == 'Active' && ($Detail.host_data.allow_upgrade_config ||
              $Detail.host_data.allow_upgrade_product)) && !$Detail.download_data}active{/if}" data-toggle="tab"
                href="#dosage" role="tab">
                <!-- <span class="d-block d-sm-none"><i class="far fa-envelope"></i></span> -->
                <span>{$Lang.consumption}</span>
              </a>
            </li>
            {/if}
            <li class="nav-item">
              <a class="nav-link {if !($Detail.host_data.domainstatus == 'Active' && $Detail.dcim && $Detail.dcim.auth.traffic == 'on') && !($Detail.host_data.domainstatus == 'Active' && ($Detail.host_data.allow_upgrade_config ||
              $Detail.host_data.allow_upgrade_product)) && !$Detail.download_data && !$Detail.host_data.show_traffic_usage}active{/if}"
                data-toggle="tab" href="#settings1" role="tab">
                <!-- <span class="d-block d-sm-none"><i class="fas fa-cog"></i></span> -->
                <span>{$Lang.journal}</span>
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" data-toggle="tab" href="#finance" role="tab">
                <!-- <span class="d-block d-sm-none"><i class="fas fa-cog"></i></span> -->
                <span>{$Lang.finance}</span>
              </a>
            </li>
          </ul>

          <!-- Tab panes -->
          <div class="tab-content p-3 text-muted">
            {if $Detail.host_data.domainstatus == 'Active' && $Detail.dcim && $Detail.dcim.auth.traffic == 'on'}
            <div class="tab-pane active" id="home1" role="tabpanel">
            </div>
            {/if}

            {if $Detail.host_data.domainstatus == 'Active' && ($Detail.host_data.allow_upgrade_config ||
            $Detail.host_data.allow_upgrade_product)}
            <div class="tab-pane {if !($Detail.dcim && $Detail.dcim.auth.traffic == 'on')}active{/if}" id="profile1"
              role="tabpanel">
              <div class="container-fluid">
                {if $Detail.host_data.allow_upgrade_product}
                <div class="row mb-3">
                  <div class="col-12">
                    <div class="bg-light  rounded card-body">
                      <div class="row">
                        <div class="col-sm-3">

                          <h5>{$Lang.upgrade_downgrade}</h5>
                        </div>
                        <div class="col-sm-6">

                          <span>{$Lang.upgrade_downgrade_two}</span>
                        </div>
                        <div class="col-sm-3">
                          <button type="button" class="btn btn-primary waves-effect waves-light float-right"
                            id="upgradeProductBtn" onclick="upgradeProduct($(this), '{$Think.get.id}')">{$Lang.upgrade_downgrade}</button>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                {/if}
                {if $Detail.host_data.allow_upgrade_config}
                <div class="row mb-3">
                  <div class="col-12">
                    <div class="bg-light  rounded card-body">
                      <div class="row">
                        <div class="col-sm-3">
                          <h5>{$Lang.upgrade_downgrade_options}</h5>
                        </div>
                        <div class="col-sm-6">
                          <span>{$Lang.upgrade_downgrade_description}</span>
                        </div>
                        <div class="col-sm-3">
                          <button type="button" class="btn btn-primary waves-effect waves-light float-right"
                            id="upgradeConfigBtn" onclick="upgradeConfig($(this), '{$Think.get.id}')">{$Lang.upgrade_downgrade_options}</button>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                {/if}
              </div>
            </div>
            {/if}
            {if $Detail.download_data}
            <div class="tab-pane {if !($Detail.host_data.domainstatus == 'Active' && $Detail.dcim && $Detail.dcim.auth.traffic == 'on') && !($Detail.host_data.domainstatus == 'Active' && ($Detail.host_data.allow_upgrade_config ||
            $Detail.host_data.allow_upgrade_product))}active{/if}" id="messages1" role="tabpanel">
              {include file="servicedetail/servicedetail-download"}
            </div>
            {/if}
            <div
              class="tab-pane {if !($Detail.host_data.domainstatus == 'Active' && $Detail.dcim && $Detail.dcim.auth.traffic == 'on') && !($Detail.host_data.domainstatus == 'Active' && ($Detail.host_data.allow_upgrade_config ||
            $Detail.host_data.allow_upgrade_product)) && !$Detail.download_data && !$Detail.host_data.show_traffic_usage}active{/if}"
              id="settings1" role="tabpanel">

            </div>

            {if $Detail.host_data.show_traffic_usage}
            <div class="tab-pane {if !($Detail.host_data.domainstatus == 'Active' && $Detail.dcim && $Detail.dcim.auth.traffic == 'on') && !($Detail.host_data.domainstatus == 'Active' && ($Detail.host_data.allow_upgrade_config ||
            $Detail.host_data.allow_upgrade_product)) && !$Detail.download_data}active{/if}" id="dosage"
              role="tabpanel">
              <div class="row d-flex align-items-center">
                <div class="col-md-3">
                  <input class="form-control" type="date" id="startingTime">
                </div>
                <span>{$Lang.reach}</span>
                <div class="col-md-3">
                  <input class="form-control" type="date" id="endTime">
                </div>
              </div>
              <div class="w-100 h-100">
                <div style="height: 500px" class="chart_content_box w-100" id="usedChartBox"></div>
              </div>
            </div>
            {/if}
            <div class="tab-pane" id="finance" role="tabpanel">
              <!-- 财务 -->
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- 破解密码弹窗 -->
<div class="modal fade" id="dcimModuleResetPass" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
  aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title mt-0">{$Lang.crack_password}</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form id="crackPsdForm">
        <div class="modal-body">
          <div class="form-group row mb-0">
            <label for="horizontal-firstname-input"
              class="col-md-3 col-form-label d-flex justify-content-end">{$Lang.password}</label>
            <div class="col-md-6">
              <input type="text" class="form-control" name="password">
            </div>
            <div class="col-md-1 fs-18 d-flex align-items-center">
              <i class="fas fa-dice create_random_pass" onclick="create_random_pass()"></i>
            </div>
          </div>
          <label id="password-error-tip" class="control-label error-tip" for="password"></label>
          <div class="form-group row mb-4">
            <label for="horizontal-firstname-input"
              class="col-md-3 col-form-label d-flex justify-content-end">{$Lang.crack_other}</label>
            <div class="col-md-6">
              <div class="custom-control custom-checkbox">
                <input type="checkbox" class="custom-control-input" id="dcimModuleResetPassOther" value="1" onchange="dcimModuleResetPassOther($(this))">
                <label class="custom-control-label" for="dcimModuleResetPassOther">{$Lang.password_will_cracked}</label>
              </div>
            </div>
          </div>
          <div class="form-group row mb-4" style="display:none;" id="dcimModuleResetPassOtherUser">
            <label for="horizontal-firstname-input"
              class="col-md-3 col-form-label d-flex justify-content-end">{$Lang.custom_user}</label>
            <div class="col-md-6">
              <input type="text" class="form-control" name="user">
            </div>
          </div>
        </div>
        <input type="hidden" name="id" value="{$Think.get.id}">
      </form>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">{$Lang.cancel}</button>
        <button type="button" class="btn btn-primary submit" onclick="dcimModuleResetPass($(this), '{$Think.get.id}')">{$Lang.determine}</button>
      </div>
    </div>
  </div>
</div>

<!-- 救援系统弹窗 -->
<div class="modal fade" id="dcimModuleRescue" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
  aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title mt-0">{$Lang.rescue_system}</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form>
        <div class="modal-body">
          <div class="form-group row mb-4">
            <label for="horizontal-firstname-input"
              class="col-md-3 col-form-label d-flex justify-content-end">{$Lang.system}</label>
            <div class="col-md-8">
              <select class="form-control" name="system">
                <option value="1">Linux</option>
                <option value="2">Windows</option>
              </select>
            </div>
          </div>
        </div>
        <input type="hidden" name="id" value="{$Think.get.id}">
      </form>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">{$Lang.cancel}</button>
        <button type="button" class="btn btn-primary submit" onclick="dcimModuleRescue($(this), '{$Think.get.id}')">{$Lang.determine}</button>
      </div>
    </div>
  </div>
</div>

<!-- 重装系统弹窗 -->
<div class="modal fade" id="dcimModuleReinstall" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
  aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title mt-0">{$Lang.reinstall_system}</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form id="rebuildPsdForm">
        <div class="modal-body">
          <div class="row">
            <div class="col-md-2  d-flex align-items-center justify-content-end">
              <label class="float-right mb-0">{$Lang.system}</label>
            </div>
            <div class="col-md-5">
              <div class="form-group mb-0">
                <select class="form-control configoption_os_group selectpicker" data-style="btn-default" name="os_group" onchange="dcimModuleReinstallOsGroup($(this))">
                                  {foreach $Detail.cloud_os_group as $item} 
                                    {if strtolower($item.name)=="windows"}
                                    {assign name="os_svg" value="1" /}
                                    {elseif strtolower($item.name)=="centos"/}
                                    {assign name="os_svg" value="2" /}
                                    {elseif strtolower($item.name)=="ubuntu"/}
                                    {assign name="os_svg" value="3" /}
                                    {elseif strtolower($item.name)=="debian"/}
                                    {assign name="os_svg" value="4" /}
                                    {elseif strtolower($item.name)=="esxi"/}
                                    {assign name="os_svg" value="5" /}
                                    {elseif strtolower($item.name)=="xenserver"/}
                                    {assign name="os_svg" value="6" /}
                                    {elseif strtolower($item.name)=="freebsd"/}
                                    {assign name="os_svg" value="7" /}
                                    {elseif strtolower($item.name)=="fedora"/}
                                    {assign name="os_svg" value="8" /}
                                    {else/}
                                    {assign name="os_svg" value="9" /}
                                    {/if}
                                    <option  data-content="<img class='mr-1' src='/upload/common/system/{$os_svg}.svg' height='20'/>{$item.name}" value="{$item.id}">{$item.name}</option>
                                  {/foreach}
                                </select>
              </div>
            </div>
            <div class="col-md-5">
              <div class="form-group">
                <select class="form-control" name="os"  data-os='{:json_encode($Detail.cloud_os)}' >
                  {foreach $Detail.cloud_os as $item}
                    <option value="{$item.id}" data-group="{$item.group}">{$item.name}</option>
                  {/foreach}
                </select>
              </div>
            </div>
          </div>
          <div class="form-group row mb-0">
            <label for="horizontal-firstname-input"
              class="col-md-2 col-form-label d-flex justify-content-end">{$Lang.password}</label>
            <div class="col-md-6">
              <input type="text" class="form-control" name="password">
            </div>
            <div class="col-md-1 fs-18 d-flex align-items-center">
              <i class="fas fa-dice create_random_pass" onclick="create_random_pass()"></i>
            </div>
          </div>
          <label id="password-error-tip-rebuild" class="control-label error-tip ml-8" for="password"></label>
          <div class="row mt-3">
            <label for="horizontal-firstname-input"
              class="col-md-2 col-form-label d-flex justify-content-end">{$Lang.port}</label>
            <div class="col-md-5">
              <input type="text" class="form-control" name="port" value="22">
            </div>
            <div class="col-md-1 fs-18 d-flex align-items-center">
              <i class="fas fa-dice module_reinstall_random_port" onclick="$('#dcimModuleReinstall input[name=\'port\']').val(parseInt(Math.random() * 65535))"></i>
            </div>
          </div>
          <div class="row" id="dcimModuleReinstallPart">
            <label for="horizontal-firstname-input"
              class="col-md-2 col-form-label d-flex justify-content-end">{$Lang.partition_type}</label>
            <div class="col-md-3">
              <div class="custom-control custom-radio">
                <input type="radio" class="custom-control-input" id="dcimModuleReinstallPart0" name="part_type" onchange="showPartTypeConfirm('{$Detail.host_data.os}')"
                  value="0" checked="checked">
                <label class="custom-control-label" for="dcimModuleReinstallPart0">{$Lang.full_format}</label>
              </div>
            </div>
            <div class="col-md-3">
              <div class="custom-control custom-radio">
                <input type="radio" class="custom-control-input" id="dcimModuleReinstallPart1" name="part_type" onchange="showPartTypeConfirm('{$Detail.host_data.os}')"
                  value="1">
                <label class="custom-control-label" for="dcimModuleReinstallPart1">{$Lang.first_partition_formatting}</label>
              </div>
            </div>
            <div class="col-md-3">
              <div class="custom-control custom-checkbox">
                <input type="checkbox" class="custom-control-input" id="dcimModuleReinstallHigh" onchange="showDcimDisk()">
                <label class="custom-control-label" for="dcimModuleReinstallHigh">{$Lang.senior}</label>
              </div>
            </div>
          </div>
          <div class="row" id="dcimModuleReinstallDisk" style="display:none;">
            <label for="horizontal-firstname-input"
              class="col-md-2 col-form-label d-flex justify-content-end">{$Lang.disk}</label>
            <div class="col-md-6">
              <select class="form-control" name="disk">
                <option value="0">disk0</option>
              </select>
            </div>
          </div>
          <div class="row">
            <div class="col-md-2 offset-md-2 d-flex align-items-center justify-content-end">
              <div class="custom-control custom-checkbox mb-4">
                <input type="checkbox" class="custom-control-input" id="dcimModuleReinstallConfirm" value="1" onchange="dcimReinstallConfirm($(this))">
                <label class="custom-control-label" for="dcimModuleReinstallConfirm">{$Lang.finished_backup}</label>
              </div>
            </div>
          </div>
          <div class="row" id="dcimModuleReinstallPartMsg" style="display:none;">
            <div class="col-md-2"></div>
            <div class="col-md-9">
              <div class="part_error"></div>
            </div>
          </div>
          <div class="row">
            <div class="col-md-2"></div>
            <div class="col-md-9">
              <div id="dcimModuleReinstallMsg"></div>
            </div>
          </div>
        </div>
        <input type="hidden" name="id" value="{$Think.get.id}">
      </form>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">{$Lang.cancel}</button>
        <button type="button" class="btn btn-primary submit disabled" style="cursor:not-allowed;" onclick="dcimModuleReinstall($(this), '{$Think.get.id}')">{$Lang.determine}</button>
      </div>
    </div>
  </div>
</div>
<!-- 电源状态 -->
<script>
  var showPowerStatus = '{$Detail.module_power_status}';
  var powerStatus = {}

  $(function () {
    if (showPowerStatus == '1') {
      dcimGetPowerStatus('{$Think.get.id}')
    }

    $('#powerBox').on('click', function () {
      dcimGetPowerStatus('{$Think.get.id}')
    });
  })

  

  var timeOut = null
  var timeInterval = null
</script>

<script>
  var showPWd = false
  $(function () {
    // 查看密码
    $('#copyPwdContent').hide()

    // 复制IP
    var clipboard = new ClipboardJS('.btn-copy-ip', {
      text: function (trigger) {
        return $('#copyIPContent').text()
      }
    });
    clipboard.on('success', function (e) {
      toastr.success('{$Lang.copy_succeeded}');
    })
    // 复制密码
    var clipboard = new ClipboardJS('.btn-copy-pwd', {
      text: function (trigger) {
        return $('#copyPwdContent').text()
      }
    });
    clipboard.on('success', function (e) {
      toastr.success('{$Lang.copy_succeeded}');
    })
  })
  function togglePwd() {
    showPWd = !showPWd

    if (showPWd) {
      $('#copyPwdContent').show()
      $('#hidePwdBox').hide()
    }
    if (!showPWd) {
      $('#copyPwdContent').hide()
      $('#hidePwdBox').show()
    }
  }
</script>

<script>
  // 图表tabs
  $(document).ready(function () {
    getComponentData()
  });

  let switch_id = []
  let chartsData = []
  let timeArray = []
  let name = []
  let typeArray = []
  let myChart = null

  $('#chartLi').on('click', function () {
    setTimeout(function(){
      myChart.resize()
    }, 0);
  });
  async function getChartDataFn(index) {
    selectTimeTypeFunc(index)
    const queryObj = {
      id: '{$Think.get.id}',
      switch_id: switch_id[index],
      port_name: name[index],
      start_time: moment(timeArray[index].startTime).valueOf()
    }
    $.ajax({
      type: "post",
      url: '{$Setting.web_url}' + '/dcim/traffic',
      data: queryObj,
      success: function (data) {

        var obj = data.data.traffic || []
        var inArray = []
        var outArray = []
        var xName = []
        var inVal = []
        var outVal = []
        for (const item of obj) {
          if (item.type === 'in') {
            inArray.push(item)
            xName.push(moment(item.time).format('MM-DD HH:mm:ss'))
            inVal.push(item.value)
          } else if (item.type === 'out') {
            outArray.push(item)
            outVal.push(item.value)
          }
        }
        chartFunc(index, xName, inVal, outVal, data.data.unit)
        if (data.status === 200) {
          var obj = data.data.traffic
          var inArray = []
          var outArray = []
          var xName = []
          var inVal = []
          var outVal = []
          for (const item of obj) {
            if (item.type === 'in') {
              inArray.push(item)
              xName.push(moment(item.time).format('MM-DD HH:mm:ss'))
              inVal.push(item.value)
            } else if (item.type === 'out') {
              outArray.push(item)
              outVal.push(item.value)
            }
          }
          chartFunc(index, xName, inVal, outVal, data.data.unit)
        }
      }
    });
  }

  async function getComponentData() {
    const obj = {
      id: "{$Think.get.id}"
    }
    $.ajax({
      type: "GET",
      url: '{$Setting.web_url}' + '/dcim/detail',
      data: obj,
      success: function (data) {
        if (data.status !== 200) {
          return
        }
        chartsData = data.data.switch ? data.data.switch : []
        let str = ``
        for (let i = 0; i < chartsData.length; i++) {
          const item = chartsData[i];
          timeArray.push({
            startTime: '',
            endTime: ''
          })
          typeArray.push({
            type: '7'
          })
          switch_id.push(chartsData[i].switch_id)
          name.push(chartsData[i].name)
          str += `<div
                    class="w-100 h-100">
                    <select class="form-control" id="chartSelect${i}" class="second_type" name="type" onchange="getChartDataFn(${i})">
                      <option value="24">24{$Lang.hour}</option>
                      <option value="3">3{$Lang.day}</option>
                      <option value="7" selected>7{$Lang.day}</option>
                      <option value="30">30{$Lang.day}</option>
                      <option value="999">{$Lang.whole}</option>
                    </select>
                    <div style="height: 500px" class="w-100 h-100 d-flex justify-content-center" id="balanceCharts${i}"></div>
                    </div>`
        }
        $('#home1').append(str);
        for (let j = 0; j < chartsData.length; j++) {
          getChartDataFn(j)
        }
      }
    });
  }

  function selectTimeTypeFunc(index) {
    typeArray[index].type = $(`#chartSelect${index}`).val();

    if (typeArray[index].type === '7') { // 7天
      timeArray[index].startTime = moment(Date.now() - 7 * 24 * 3600 * 1000).format('YYYY-MM-DD')
    } else if (typeArray[index].type === '3') { // 3天
      timeArray[index].startTime = moment(Date.now() - 3 * 24 * 3600 * 1000).format('YYYY-MM-DD')
    } else if (typeArray[index].type === '30') { // 30天
      timeArray[index].startTime = moment(Date.now() - 30 * 24 * 3600 * 1000).format('YYYY-MM-DD')
    } else if (typeArray[index].type === '24') { // 24h
      timeArray[index].startTime = moment(Date.now() - 24 * 3600 * 1000).format('YYYY-MM-DD')
    } else if (typeArray[index].type === '999') { // q全部
      timeArray[index].startTime = ''
    }
  }

  function chartFunc(index, xNameArray, inValArray, outValArray, unitY) {


    var inflow = '{$Lang.inflow_flow}'
    var outflow = '{$Lang.outflow_flow}'
    // 基于准备好的dom，初始化echarts实例
    myChart = echarts.init(document.getElementById('balanceCharts' + index))
    var option = {
      tooltip: {
        show: true,
        backgroundColor: '#fff',
        borderColor: '#eee',
        showContent: true,
        extraCssText: 'box-shadow: 0 1px 9px rgba(0, 0, 0, 0.1);',
        textStyle: {
          color: '#1e1e2d',
          textBorderWidth: 1
        },
        trigger: 'axis',
        axisPointer: {
          color: '#D9DAEA'
        }
      },
      grid: {
        left: '5%',
        right: '5%',
        bottom: '10%',
        top: '8%',
        containLabel: true
      },
      color: ['#007bfc', '#3fbf70'],
      dataZoom: [ // 缩放
        {
          type: 'inside',
          throttle: 50
        }
      ],
      xAxis: {
        splitLine: {
          show: false
        },
        axisLine: {
          lineStyle: {
            color: '#1e1e2d'
          }
        },
        axisTick: {
          show: false
        },
        type: 'category',
        boundaryGap: false,
        data: xNameArray
      },
      yAxis: {
        axisLabel: {
          // formatter: '{value}' + unitY
          formatter: function (value) {
            return value + unitY
          }
        },
        axisLine: {
          show: false
        },
        minorTick: {
          show: false
        },
        axisTick: {
          show: false
        },
        splitLine: {
          lineStyle: {
            color: '#f5f4f8'
          }
        },
        type: 'value'
      },
      series: [{
        name: inflow,
        type: 'line',
        smooth: true,
        data: inValArray
      },
      {
        name: outflow,
        type: 'line',
        smooth: true,
        data: outValArray
      }
      ]
    }
    myChart.setOption(option, true) // true重绘
    window.addEventListener('resize', function () {
      myChart.resize()
    })
  }
</script>

<script>
  // 用量tabs
  let usedChart = null
  let usedStartTime
  let usedEndTime

  $(document).ready(function () {
    if ('{$Detail.host_data.show_traffic_usage}') {
      chartOption()
    }
    if($('#startingTime,#endTime').length>0) getData()
    window.addEventListener('resize', function () {
      usedChart.resize()
    })
  })
  $('#usedLi').on('click', function () {
    setTimeout(function(){
      usedChart.resize()
    }, 0);
  });

  $('#startingTime,#endTime').on('change', function () {
    usedStartTime = $('#startingTime').val()
    usedEndTime = $('#endTime').val()
    getData()
  });
  // 图表配置
  function chartOption() {
    usedChart = echarts.init(document.getElementById('usedChartBox'))
    usedChart.setOption({
      backgroundColor: '#fff',
      title: {
        subtext: '',
        left: 'center',
        textAlign: 'left',
        subtextStyle: {
          lineHeight: 400
        }
      },
      tooltip: {
        backgroundColor: '#fff',
        padding: [10, 20, 10, 8],
        textStyle: {
          color: '#000',
          fontSize: 12
        },
        trigger: 'axis',
        axisPointer: {
          type: 'line',
          lineStyle: {
            color: '#7dcb8f'
          }
        },
        formatter: function (params, ticket, callback) {
          // 
          const res = `
                    <div>
                      <div>`+'{$Lang.traffic_usage}'+`：${params[0].value}GB </div>
                      <div>${params[0].axisValue}</div>
                    </div>
                    `
          return res
        },
        extraCssText: 'box-shadow: 0px 4px 13px 1px rgba(1, 24, 167, 0.1);'
      },
      grid: {
        left: '80',
        top: 20,
        x: 70,
        x2: 50,
        y2: 80
      },
      xAxis: {
        offset: 15,
        type: 'category',
        data: [],
        boundaryGap: false,
        axisTick: {
          show: false
        },
        // 改变x轴颜色
        axisLine: {
          lineStyle: {
            type: 'dashed',
            color: '#ddd',
            width: 1
          }
        },
        axisLabel: {
          show: true,
          textStyle: {
            color: '#999'
          }
        }
      },
      yAxis: {
        type: 'value',
        // 轴网格
        splitLine: {
          show: true,
          lineStyle: {
            color: '#ddd',
            type: 'dashed'
          }
        },
        axisTick: {
          show: false // 轴刻度不显示
        },
        axisLine: {
          show: false
        },
        axisLabel: {
          show: true,
          textStyle: {
            color: '#999'
          },
          formatter: '{value}GB'
        }
      },
      series: [{
        name: '用量',
        type: 'line',
        smooth: true,
        showSymbol: true,
        symbol: 'circle',
        symbolSize: 3,
        // data: ['1200', '1400', '1008', '1411', '1026', '1288', '1300', '800', '1100', '1000', '1118', '123456'],
        data: [],
        areaStyle: {
          normal: {
            color: '#d4d1da',
            opacity: 0.2
          }
        },
        itemStyle: {
          normal: {
            color: '#0061ff' // 主要线条的颜色
          }
        },
        lineStyle: {
          normal: {
            width: 4,
            shadowColor: 'rgba(0,0,0,0.4)',
            shadowBlur: 10,
            shadowOffsetY: 10
          }
        }
      }]
    })
  }

  // 获取数据
  async function getData() {
    usedChart.showLoading({
      text: '{$Lang.data_loading}'+'...',
      color: '#999',
      textStyle: {
        fontSize: 30,
        color: '#444'
      },
      effectOption: {
        backgroundColor: 'rgba(0, 0, 0, 0)'
      }
    })



    const obj = {
      id: '{$Think.get.id}',
      start: usedStartTime,
      end: usedEndTime
    }
    $.ajax({
      type: "get",
      url: '{$Setting.web_url}' + '/dcim/traffic_usage',
      data: obj,
      success: function (data) {

        usedChart.hideLoading()
        if (data.status !== 200) return false
        const xData = []
        const seriesData = [];
        (data.data || []).forEach(item => {
          xData.push(item.time)
          seriesData.push(item.value)
        })
        usedChart.setOption({
          title: {
            subtext: xData.length ? '' : '{$Lang.no_data_available}'
          },
          xAxis: {
            data: xData
          },
          series: [{
            data: seriesData
          }]
        })
        // 如果初始查询没有时间, 则设置默认时间为返回数据的第一个和最后一个时间
        if (!usedStartTime || !usedEndTime) {
          if (data.data.length) {
            usedStartTime = new Date().getFullYear() + '-' + data.data[0].time
            usedEndTime = new Date().getFullYear() + '-' + data.data[data.data.length - 1].time
            $('#startingTime').val(new Date().getFullYear() + '-' + data.data[0].time);
            $('#endTime').val(new Date().getFullYear() + '-' + data.data[data.data.length - 1].time);
          }
        }
      }
    });
  }

  // 分辨率改变, 重绘图表
  function resize() {
    usedChart.resize()
  }

  // 时间选择改变
  function dateChange() {
    const startTimeStamp = new Date(usedStartTime).getTime()
    const endTimeStamp = new Date(usedEndTime).getTime()
    if (usedStartTime && usedEndTime && startTimeStamp < endTimeStamp) {
      getData()
    }
  }
</script>

<script>
  // 获取基础数据
  const obj = {
    host_id: '{$Think.get.id}'
  }
  $.ajax({
    type: "get",
    url: '{$Setting.web_url}' + '/host/dedicatedserver',
    data: obj,
    success: function (data) {
      const totalFlow = data.data.host_data.bwlimit // 总流量
      const usedFlow = data.data.host_data.bwusage // 已用流量
      const remainingFlow = (totalFlow - usedFlow).toFixed(1)
      let percentUsed = 100 - parseInt((usedFlow / totalFlow) * 100) || 0
      $('#totalProgress')
        .css('width', percentUsed + '%')
        .attr('aria-valuenow', percentUsed)
        .text(`${percentUsed}%`);
      
      $('#usedFlowSpan').text(`${usedFlow > 1024 ? ((usedFlow / 1024).toFixed(2) + 'TB') : (usedFlow + 'GB')}`);
      $('#remainingFlow').text(`${remainingFlow > 1024 ? ((remainingFlow / 1024).toFixed(2) + 'TB') : (remainingFlow + 'GB')}`);

      // 产品状态
      $('#statusBox').append(`<span class="sprite2 ${data.data.host_data.domainstatus}"></span>`)
    }
  });
</script>

<script>
  const logObj = {
    id: '{$Think.get.id}',
    action: 'log_page'
  }
  $.ajax({
    type: "get",
    url: '{$Setting.web_url}' + '/servicedetail',
    data: logObj,
    success: function (data) {
      $(data).appendTo('#settings1');
    }
  });
  // 财务的append
  const financeObj = {
    id: '{$Think.get.id}',
    action: 'billing_page'
  }
  $.ajax({
    type: "get",
    url: '{$Setting.web_url}' + '/servicedetail',
    data: financeObj,
    success: function (data) {
      $(data).appendTo('#finance');
    }
  });
</script>

{include file="includes/modal"}
<script>
  var getResintallStatusTimer = null;
  $(function () {
    getResintallStatus('{$Think.get.id}');
  })
</script>

<script>
  var clipboard = null
  var clipboardpoppwd = null
  var ips = {:json_encode($Detail.host_data.assignedips)};
  // console.log('ips: ', ips);
  $(document).on('click', '#copyIPContent', function () {
    $('#popModal').modal('show')
    $('#popTitle').text('IP地址')
    var iplist = ''
    if (clipboard) {
      clipboard.destroy()
    }
    ips.forEach(function(item, index)  {
      iplist += `
        <div>
          <span class="copyIPContent${index}">${item}</span>
          <i class="bx bx-copy pointer text-primary ml-1 btn-copy btnCopyIP${index}" data-clipboard-action="copy" data-clipboard-target=".copyIPContent${index}"></i>
        </div>
      `

      // 复制IP
      clipboard = new ClipboardJS('.btnCopyIP'+index, {
          text: function (trigger) {
            return $('.copyIPContent'+index).text()
          },
          container: document.getElementById('popModal')
        });
        clipboard.on('success', function (e) {
          toastr.success('{$Lang.copy_succeeded}');
        })
    })

    $('#popContent').html(iplist)
  });


  // 复制用户密码
  $(document).on('click', '#logininfo', function () {
    $('#popModal').modal('show')
    $('#popTitle').text('登录信息')

    $('#popContent').html(`
      <div>{$Lang.user_name}：{$Detail.host_data.username}</div>
      <div>
        {$Lang.password}：<span id="poppwd">{$Detail.host_data.password}</span>
        <i class="bx bx-copy pointer text-primary ml-1 btn-copy" id="poppwdcopy" data-clipboard-action="copy" data-clipboard-target="#poppwd"></i>
      </div>
      <div>{$Lang.port}：{if $Detail.host_data.port == '0'}{$Lang.defaults}{else/}{$Detail.host_data.port}{/if}</div>
      {if in_array('crack_pass', array_column($Detail.module_button.control, 'func')) && $Detail.host_data.domainstatus=="Active"}
	  <div>
     
		<button type="button" class="btn btn-primary btn-sm waves-effect waves-light dcim_service_module_button" onclick="dcim_service_module_button($(this), '{$Think.get.id}')"
                  data-func="crack_pass" data-type="default">{$Lang.crack_password}</button>
      </div>
	  {/if}
    `)
  });


  $('#popModal').on('shown.bs.modal',function() {
    if (clipboardpoppwd) {
        clipboardpoppwd.destroy()
      }
     clipboardpoppwd = new ClipboardJS('#poppwdcopy', {
      text: function (trigger) {
        return $('#poppwd').text()
      },
      container: document.getElementById('popModal')
    });
    clipboardpoppwd.on('success', function (e) {
      toastr.success('{$Lang.copy_succeeded}');
    })
  })

 // 破解密码
 $(document).on('blur', '.getCrackPsd', function(){
		veriCrackPsd()
  })
  function veriCrackPsd(){
    let result = checkingPwd($(".getCrackPsd").val(), passwordRules.num, passwordRules.upper, passwordRules.lower, passwordRules.special)
    if(result.flag) {
      $('#password-error-tip').css('display','none');
      $('.getCrackPsd').removeClass("is-invalid");
    }else{
      $("#password-error-tip").html(result.msg);
      $(".getCrackPsd").addClass("is-invalid");
      $('#password-error-tip').css('display','block');
    }
  }
  //重装系统
  $(document).on('blur', '.getRebuildPsd', function(){
		veriRebuildPsd()
  })
  function veriRebuildPsd(){
    let result = checkingPwd($(".getRebuildPsd").val(), passwordRules.num, passwordRules.upper, passwordRules.lower, passwordRules.special)
    if(result.flag) {
      $('#password-error-tip-rebuild').css('display','none');
      $('.getRebuildPsd').removeClass("is-invalid");
    }else{
      $("#password-error-tip-rebuild").html(result.msg);
      $(".getRebuildPsd").addClass("is-invalid");
      $('#password-error-tip-rebuild').css('display','block');
    }
  }

  $(function(){
      $("#crackPsdForm").on('click',".create_random_pass",function(e){
        veriCrackPsd()
      })
      $("#rebuildPsdForm").on('click',".create_random_pass",function(e){
        veriRebuildPsd()
      })
  })
</script>