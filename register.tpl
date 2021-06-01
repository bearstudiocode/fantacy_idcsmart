{if $ErrorMsg}
{include file="error/alert" value="$ErrorMsg"}
{/if}
{if $SuccessMsg} 
{include file="error/notifications" value="$SuccessMsg"}
{/if}
 {if !$Setting.web_close_mode_message}
<script src="{$Setting.web_url}/themes/clientarea/default/assets/js/public.js?v={$Ver}"></script>

<style>
    .input-group-prepend {
        width: 100px;
    }

  .form-control,.btn-primary,.input-group-append{
    height: 46px;
  }
  .btn-primary{
    line-height: 28px;
  }
</style>
<script>
    var mk = '{$Setting.msfntk}';
</script>

<div class="account-pages my-5 pt-5">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-8 col-lg-6 col-xl-5">
                        <div class="card overflow-hidden" style="border-radius: 30px;">
                            <div class="bg-primary">
                                <div class="text-primary text-center p-4">
                                    <h5 class="text-white font-size-20">{$Lang.register}</h5>
                                    <p class="text-white-50">{$Lang.registertips}</p>
                                    <a href="{$Setting.web_jump_url}" class="logo logo-admin">
                                    <img src="{$Setting.web_logo}" height="24" alt="logo">
                                </a>
                                </div>
                            </div>
    
                            <div class="card-body p-4">
                                <div class="p-3">
                                <ul class="affs-nav nav nav-tabs nav-tabs-custom nav-justified" role="tablist">
                                {if $Register.allow_register_email}
                                <li class="nav-item">
                                    <a class="nav-link fs-14 bg-transparent {if $Get.action=="email" || !$Get.action}active{/if}" data-toggle="tab" href="#email" role="tab" aria-selected="true">{$Lang.email_registration}</a>
                                </li>
                                {/if}
                                {if $Register.allow_register_phone}
                                <li class="nav-item">
                                    <a class="nav-link fs-14 bg-transparent {if (!$Register.allow_register_email && $Register.allow_register_phone) || $Get.action=="phone"}active{/if}" data-toggle="tab" href="#phone" role="tab" aria-selected="false"> {$Lang.mobile_registration}</a>
                                </li>
                                {/if}
                            </ul>
                                   <div class="tab-content">	
									{if $Register.allow_register_email}
									<div id="email" class="tab-pane {if $Get.action=="email" || !$Get.action}active{/if}" role="tabpanel">	
										<form class="form-horizontal mt-4 needs-validation" novalidate method="post" action="/register?action=email">
<div class="form-group">
												<label for="email">{$Lang.mailbox}</label>
												<input type="text" class="form-control" id="emailInp" name="email"
													placeholder="{$Lang.please_input_email}" value="{$Post.email}" required>
												<div class="invalid-feedback">{$Lang.please_input_email}</div>
											</div>
											{if $Verify.allow_register_email_captcha==1}
											{include file="includes/verify"  type="allow_register_email_captcha" positon="top"}
											{/if}
											{if $Register.allow_email_register_code==1}
											<div class="form-group">
												<label for="code">{$Lang.verification_code}</label>
												<div class="input-group">
													<input type="text" class="form-control" id="code" name="code"
														placeholder="{$Lang.please_enter_code}" value="{$Post.code}" required>
													<div class="input-group-append">
														<button class="btn btn-primary" type="button"  onclick="getCode(this,'register_email_send','allow_register_email_captcha')">{$Lang.get_code}</button>
													</div>
												</div>
											</div>
											{/if}
											<div class="form-group">
												<label for="password">{$Lang.password}</label>
												<input type="password" class="form-control" name="password"
													id="emailPwd" placeholder="{$Lang.please_enter_password}" required>
											</div>
											<div class="form-group">
												<label for="checkPassword">{$Lang.confirm_password}</label>
												<input type="password" class="form-control" name="checkPassword"
													id="emailPwdCheck" placeholder="{$Lang.please_password_again}" required>
											</div>
											{foreach $Register.login_register_custom_require as $custom}
											<div class="form-group">
												<label for="{$custom.name}">{$Register[login_register_custom_require_list][$custom.name]}</label>
												<input type="{if $custom.name=='password'}password{else}text{/if}" class="form-control" name="{$custom.name}" id="{$custom.name}" value="{$Post[$custom.name]}" >
											</div>
											{/foreach}

											{foreach $Register.fields as $k => $list}
												<div class="form-group">
													<label for="{$list.id}">{$list.fieldname}</label>
													{if $list.fieldtype == 'dropdown'}
														<!-- 下拉 -->
														<select name="fields[{$list.id}]" class="form-control ">
															{foreach $list.dropdown_option as $key => $val}
																<option value="{$key}" {if(isset($_fields[$key]))} selected {/if}>{$val}</option>
															{/foreach}
														</select>
													{elseif $list.fieldtype == 'password'}
														<!-- 密码 -->
														<input name="fields[{$list.id}]" type="password" {if(isset($_fields[$list['id']]))} value="{$_fields[$list['id']]}" {/if}class="form-control" placeholder="{$Lang.custom_password_box}" />
													{elseif $list.fieldtype == 'text' || $list.fieldtype == 'link'}
														<!-- 文本框、链接 -->
														<input name="fields[{$list.id}]" type="text" class="form-control" {if(isset($_fields[$list['id']]))} value="{$_fields[$list['id']]}" {/if} placeholder="{$list.fieldname}" />
													{elseif $list.fieldtype == 'tickbox'}
														<!-- 选项框 -->
														<input type="checkbox" name="fields[{$list.id}]" {if(isset($_fields[$list['id']]))} checked {/if}>{$list.fieldname}
													{elseif $list.fieldtype == 'textarea'}
														<!-- 文本域 -->
														<textarea name="fields[{$list.id}]" cols="30" rows="10" class="form-control">{if(isset($_fields[$list['id']]))} {$_fields[$list['id']]} {/if}</textarea>
													{/if}
												</div>
											{/foreach}
											<!--销售-->
											{if $setsaler == '2'}
											<div class="form-group">
												<label for="checkPassword">{$Lang.sales_representative}</label>
												<select name="sale_id" class="form-control">
													<option value="0">{$Lang.nothing}</option>
													{foreach $saler as $list}
													<option {if $list.id==$Post.id}selected{/if} value="{$list.id}">{$list.user_nickname}</option>
													{/foreach}
												</select>
											</div>
											{/if}
											<div class="form-group row">
                                        <div class="col-sm-12">
                                            <div class="custom-control custom-checkbox">
                                                <input type="checkbox" class="custom-control-input" id="agreePrivacy">
                                                <label class="custom-control-label" for="agreePrivacy">{$Lang.have_read_agree}
                                            <a href="{$Setting.web_tos_url}" class="font-weight-medium text-primary"
                                                target="_blank">{$Lang.terms_service}</a>
                                            {$Lang.ands}
                                            <a href="{$Setting.web_privacy_url}" class="font-weight-medium text-primary"
                                                target="_blank">{$Lang.privacy_policy}</a></label>
                                            </div>
                                        </div></div>
                                        <div class="form-group row">
                                            <div class="col-12 text-right">
                                                <button class="btn btn-primary w-md waves-effect waves-light" type="submit" onclick="if(!beforeSubmit(this)){ return false;}">{$Lang.register}</button>
                                            </div>
                                        </div>
    
                                       
    
                                    </form>
  
                                </div>
                              {/if}   
                              {if $Register.allow_register_phone}
									<div id="phone" class="tab-pane {if (!$Register.allow_register_email && $Register.allow_register_phone) || $Get.action=="phone"}active{/if}" role="tabpanel">	
										<form class="class="form-horizontal mt-4 needs-validation" novalidate method="post" action="/register?action=phone">
											<div class="form-group"><br>
												<label for="username">{$Lang.phone_number}</label>
												<div class="input-group">
													<div class="input-group-prepend">
														<select class="form-control select2 select2-hidden-accessible"
															data-select2-id="1" tabindex="-1" aria-hidden="true"
															name="phone_code" value="{$Post.phone_code}" id="phoneCodeSel">
															{foreach $SmsCountry as $list}
															<option value="{$list.phone_code}"  {if $list.phone_code=="+86"}selected {/if}>
																{$list.link}
															</option>
															{/foreach}
														</select>
													</div>
													<input type="text" class="form-control" id="phoneInp" name="phone"
														placeholder="{$Lang.please_enter_your_mobile_phone_number}"  value="{$Post.phone}" required>
												</div>
											</div>
											{if $Verify.allow_register_phone_captcha==1}
											{include file="includes/verify"  type="allow_register_phone_captcha" positon="top"}
											{/if}
											<div class="form-group">
												<label for="code">{$Lang.verification_code}</label>
												<div class="input-group">
													<input type="text" class="form-control" id="code" name="code"
														placeholder="{$Lang.please_enter_code}" value="{$Post.code}" required>
													<div class="input-group-append"> 
														<button class="btn btn-primary" type="button"  onclick="getCode(this,'register_phone_send','allow_register_phone_captcha')">{$Lang.get_code}</button>
													</div>
												</div>
											</div>
											<div class="form-group">
												<label for="password">{$Lang.password}</label>
												<input type="password" class="form-control" name="password" 
													id="emailPwd" placeholder="{$Lang.please_enter_password}" required>
											</div>
											<div class="form-group">
												<label for="checkPassword">{$Lang.confirm_password}</label>
												<input type="password" class="form-control" name="checkPassword" 
													id="emailPwdCheck" placeholder="{$Lang.please_password_again}" required>
											</div>
											{foreach $Register.login_register_custom_require as $custom}
											<div class="form-group">
												<label for="{$custom.name}">{$Register[login_register_custom_require_list][$custom.name]}</label>
												<input type="{if $custom.name=='password'}password{else}text{/if}" class="form-control" name="{$custom.name}" id="{$custom.name}"  value="{$Post[$custom.name]}" >
											</div>
											{/foreach}

											{foreach $Register.fields as $k => $list}
											<div class="form-group">
												<label for="{$list.id}">{$list.fieldname}</label>															
												{if $list.fieldtype == 'dropdown'}
													<!-- 下拉 -->
													<select name="fields[{$list.id}]" class="form-control ">
														{foreach $list.dropdown_option as $key => $val}
															<option value="{$key}" {if(isset($_fields[$key]))} selected {/if}>{$val}</option>
														{/foreach}
													</select>
												{elseif $list.fieldtype == 'password'}
												<!-- 密码 -->
													<input name="fields[{$list.id}]" type="password" {if(isset($_fields[$list['id']]))} value="{$_fields[$list['id']]}" {/if}class="form-control" placeholder="{$Lang.custom_password_box}" />
												{elseif $list.fieldtype == 'text' || $list.fieldtype == 'link'}
													<!-- 文本框、链接 -->
													<input name="fields[{$list.id}]" type="text" class="form-control" {if(isset($_fields[$list['id']]))} value="{$_fields[$list['id']]}" {/if} placeholder="{$list.fieldname}" />
												{elseif $list.fieldtype == 'tickbox'}
													<!-- 选项框 -->
													<input type="checkbox" name="fields[{$list.id}]" {if(isset($_fields[$list['id']]))} checked {/if}>{$list.fieldname}
												{elseif $list.fieldtype == 'textarea'}
													<!-- 文本域 -->
													<textarea name="fields[{$list.id}]" cols="30" rows="10" class="form-control">{if(isset($_fields[$list['id']]))} {$_fields[$list['id']]} {/if}</textarea>
												{/if}												
											</div>														
											{/foreach}
											<!--销售-->
											{if $setsaler == '2'}
											<div class="form-group">
												<label for="checkPassword">{$Lang.sales_representative}</label>
												<select name="sale_id" class="form-control">
													<option value="0">{$Lang.nothing}</option>
													{foreach $saler as $list}
													<option value="{$list.id}" {if($Post.sale_id==$list.id)}selected{/if}>{$list.user_nickname}</option>
													{/foreach}
												</select>
											</div>
											{/if}
											<div class="form-group row">
                                        <div class="col-sm-12">
                                            <div class="custom-control custom-checkbox">
                                                <input type="checkbox" class="custom-control-input" id="agreePrivacy">
                                                <label class="custom-control-label" for="agreePrivacy">{$Lang.have_read_agree}
                                            <a href="{$Setting.web_tos_url}" class="font-weight-medium text-primary"
                                                target="_blank">{$Lang.terms_service}</a>
                                            {$Lang.ands}
                                            <a href="{$Setting.web_privacy_url}" class="font-weight-medium text-primary"
                                                target="_blank">{$Lang.privacy_policy}</a></label>
                                            </div>
                                        </div></div>
											 <div class="form-group row">
                                            <div class="col-12 text-right">
                                                <button class="btn btn-primary w-md waves-effect waves-light" type="submit" onclick="if(!beforeSubmit(this)){ return false;}">{$Lang.register}</button>
                                            </div>
                                        </div>
    

										</form>
									</div>
									{/if}
									
									 
									</div>
                       
    
                        </div>
    
                       
    
    
                    </div>
                </div>
                <div class="mt-5 text-center">
                        <p>{$Lang.alreadyhaveaccount} <a href="login" class="font-weight-medium text-primary"> {$Lang.loginclick} </a> </p>
                        {if $Setting.login_footer}
    <div class="text-center">{$Setting.login_footer}</div>
    {else/}
    
                        <p class="mb-0">© <script>document.write(new Date().getFullYear())</script> {$Setting.company_name}</p>
                        {/if}
                    </div>
            </div>
        </div>
        {else/}
  <div class="authentication-bg d-flex align-items-center pb-0 vh-100">
            <div class="content-center w-100">
                    <div class="container">
                        <div class="card mo-mt-2">
                            <div class="card-body">
                                <div class="row align-items-center">
                                    <div class="col-lg-4 ml-auto">
                                        <div class="ex-page-content">
                                            <h1 class="text-dark display-1 mt-4">很抱歉!</h1>
                                            <h4 class="mb-4">我们当前正在维护中,原因为:</h4>
                                            <p class="mb-5">{$Setting.web_close_mode_message}</p>
                                            <a class="btn btn-primary mb-5 waves-effect waves-light" href="mailto:{$Setting.company_email}"><i class="mdi mdi-email"></i> 您可以通过电子邮件联系我们</a>
                                        </div>
                            
                                    </div>
                                    <div class="col-lg-5 mx-auto">
                                        <img src="/themes/clientarea/fantacy/assets/images/error.png" alt="" class="img-fluid mx-auto d-block">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end card -->
                    </div>
                    <!-- end container -->
            </div>

        </div>

{/if}