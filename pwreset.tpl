{if $ErrorMsg}
{include file="error/alert" value="$ErrorMsg"}
{/if}

{if $SuccessMsg}
{include file="error/notifications" value="$SuccessMsg" url="/clientarea"}
{/if}

<script src="{$Setting.web_url}/themes/clientarea/fantacy/assets/js/public.js?v={$Ver}"></script>
<style>
	.input-group-prepend { 
		width: 100px;  
	}
	.auth-full-bg .bg-overlay {
		background: url({$Setting.web_url}/themes/clientarea/default/assets_custom/img/new-background.jpg)no-repeat left top / 100% 1400px;
		background-size: cover;
		opacity:1;
	}
  .form-control,.input-group-append{
    height: 46px;
  }
</style>
<script>
    var mk = '{$Setting.msfntk}';

</script>


        <div class="account-pages my-5 pt-5">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-8 col-lg-6 col-xl-5">
                        <div class="card overflow-hidden shadow-sm" style="border-radius: 30px;">
                            <div class="bg-primary">
                                <div class="text-primary text-center p-4">
                                    <h5 class="text-white font-size-20 p-2">{$Lang.resetpwd}</h5>
                                    <a href="{$Setting.web_jump_url}" class="logo logo-admin">
                                    <img src="{$Setting.web_logo}" height="24" alt="logo">
                                </a>
                                </div>
                            </div>
    
                            <div class="card-body p-4">
                                
                                <div class="p-3">

                                    <div class="alert alert-success mt-5" role="alert">
                                       {$Lang.resetpwdtips}
                                    </div>
<ul class="affs-nav nav nav-tabs nav-tabs-custom nav-justified" role="tablist">
					{if $Pwreset.allow_login_email}
					<li class="nav-item">
						<a class="nav-link fs-14 bg-transparent active" data-toggle="tab" href="#email" role="tab" aria-selected="true">{$Lang.email_retrieval}</a>
					</li>
					{/if}
					{if $Pwreset.allow_login_phone}
					<li class="nav-item">
						<a class="nav-link fs-14 bg-transparent {if !$Pwreset.allow_login_email && $Pwreset.allow_login_phone}active{/if}" data-toggle="tab" href="#phone" role="tab" aria-selected="false">{$Lang.mobile_phone_retrieval}</a>
					</li>
					{/if}
				</ul>
<div class="tab-content">
{if $Pwreset.allow_login_email}
						<div id="email" class="tab-pane active" role="tabpanel">
							<form class="form-horizontal mt-4" method="post"  action="/pwreset?action=email">
                                    
                                        <div class="form-group">
                                            <label for="username">{$Lang.mailbox}</label>
                                            <input type="text" class="form-control" id="emailInp" name="email" placeholder="{$Lang.please_input_email}" required>
                                        </div>
                {if $Verify.allow_email_forgetpwd_captcha==1}
								{include file="includes/verify"  type="allow_email_forgetpwd_captcha" positon="top"}
								{/if}
								<div class="form-group">
									<label for="code">{$Lang.verification_code}</label>
									<div class="input-group">
										<input type="text" class="form-control" id="code" name="code" placeholder="{$Lang.please_enter_code}" required>
										<div class="input-group-append">
											<button class="btn btn-primary" type="button"  style="line-height:33px;" onclick="getCode(this,'reset_email_send','allow_email_forgetpwd_captcha')">{$Lang.get_code}</button>
										</div>
									</div>
								</div> 
								<div class="form-group">
									<label for="userpassword">{$Lang.password}</label>
									<input type="password" class="form-control" name="password" id="emailPwd" placeholder="{$Lang.please_enter_password}" required>
								</div>
								<div class="form-group">
									<label for="userpassword">{$Lang.confirm_password}</label>
									<input type="password" class="form-control" name="checkPassword" id="emailPwdCheck" placeholder="{$Lang.please_password_again}" required>
								</div>
						
                                        <div class="form-group row  mb-0">
                                            <div class="col-12 text-right">
                                                <button class="btn btn-primary w-md waves-effect waves-light" type="submit">{$Lang.reset}</button>
                                            </div>
                                        </div>
    
                                    </form>
    </div>{/if}
    
    {if $Pwreset.allow_login_phone}
						<div id="phone" class="tab-pane {if !$Pwreset.allow_login_email && $Pwreset.allow_login_phone}active{/if}" role="tabpanel">
							<form method="post"  action="/pwreset?action=phone">
								<div class="form-group"><br>
									<label for="username">{$Lang.phone_number}</label>
									<div class="input-group">

										<div class="input-group-prepend">
											<select class="form-control select2 select2-hidden-accessible" data-select2-id="1" tabindex="-1" aria-hidden="true" name="phone_code" id="phoneCodeSel">
												{foreach $SmsCountry as $list}
												<option value="{$list.phone_code}" {if $list.phone_code=="+86"}selected {/if}>{$list.link}</option>
												{/foreach}
											</select>
										</div> 
									
										<input type="text" class="form-control" id="phoneInp" name="phone" placeholder="{$Lang.please_enter_your_mobile_phone_number}" required>
									</div>
								</div>
								{if $Verify.allow_phone_forgetpwd_captcha==1}
								{include file="includes/verify"  type="allow_phone_forgetpwd_captcha" positon="top"}
								{/if}
								<div class="form-group">
									<label for="code">{$Lang.verification_code}</label>
									<div class="input-group">
										<input type="text" class="form-control" id="code" name="code" placeholder="{$Lang.please_enter_code}" required>
										<div class="input-group-append">
											<button class="btn btn-primary" type="button" style="line-height:33px;" onclick="getCode(this,'reset_phone_send','allow_phone_forgetpwd_captcha')">{$Lang.get_code}</button>
										</div>
									</div>
								</div>
								<div class="form-group">
									<label for="userpassword">{$Lang.password}</label>
									<input type="password" class="form-control" name="password" id="phonePwd" placeholder="{$Lang.please_enter_password}" required>
								</div>
								<div class="form-group">
									<label for="userpassword">{$Lang.confirm_password}</label>
									<input type="password" class="form-control" name="checkPassword" id="phonePwdCheck"  placeholder="{$Lang.please_password_again}" required>
								</div>
						
                                        <div class="form-group row  mb-0">
                                            <div class="col-12 text-right">
                                                <button class="btn btn-primary w-md waves-effect waves-light" type="submit">{$Lang.reset}</button>
                                            </div>
                                        </div>
    
                                    </form>
    </div>{/if}
    
                                </div></div>
                            </div>
    
                        </div>
    
                        <div class="mt-5 text-center">
                        <p>{$Lang.rememberinformation} <a href="login" class="font-weight-medium text-primary"> {$Lang.loginclick} </a> </p>
                        {if $Setting.login_footer}
    <div class="text-center">{$Setting.login_footer}</div>
    {else/}
    
                        <p class="mb-0">© <script>document.write(new Date().getFullYear())</script> {$Setting.company_name}</p>
                        {/if}
                    </div>

    
                    </div>
                </div>
            </div>
        </div>