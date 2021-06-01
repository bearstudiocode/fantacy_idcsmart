
{if $ErrorMsg}
{include file="error/alert" value="$ErrorMsg"}
{/if}

{if $SuccessMsg}
{include file="error/notifications" value="$SuccessMsg"}
{/if}
  
  {if !$Setting.web_close_mode_message}
<style>
.list-inline-item .icon {
        width: 2rem;
        height: 2rem;
    }
    .social-list-item {
        border: none;
    }
	.allow_login_code_captcha{display:none;}
  .form-control,.input-group-append{
    height: 46px;
  }
</style>
 <script src="{$Setting.web_url}/themes/clientarea/fantacy/assets/js/public.js" type="text/javascript"></script>
 <script type="text/javascript">
    var mk = '{$Setting.msfntk}';
</script>

    <div class="account-pages my-5 pt-5">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-8 col-lg-6 col-xl-5">
                    <div class="card overflow-hidden shadow-sm" style="border-radius: 30px;">
                        <div class="bg-primary">
                            <div class="text-primary text-center p-4">
                                <h5 class="text-white font-size-20">{$Lang.welcomeback}</h5>
                                <p class="text-white-50">{$Lang.loginenjoy}</p>
                                <a href="{$Setting.web_jump_url}" class="logo logo-admin">
                                    <img src="{$Setting.web_logo}" height="24" alt="logo">
                                </a>
                            </div>
                        </div>
         
<div class="p-3">
                        <div class="card-body p-4">
                                      
                         <ul class="affs-nav nav nav-tabs nav-tabs-custom nav-justified" role="tablist">
          
                         <!-- 账号/ID登录 -->
                                {if $Login.allow_login_email}
                                <li class="nav-item">
                                    <a class="nav-link fs-14 bg-transparent {if $Get.action=="email" || !$Get.action}active{/if} " data-toggle="tab" href="#email" role="tab" aria-selected="true">{$Lang.email_login}</a>
                                </li>
                                {/if}
                                {if $Login.allow_login_email==0 && $Login.allow_id==1}
                                <li class="nav-item">
                                    <a class="nav-link fs-14 bg-transparent active" data-toggle="tab" href="#email" role="tab" aria-selected="false">{$Lang.id_login}</a>
                                </li>
                                {/if}
                                {if $Login.allow_login_phone==1}
                                <li class="nav-item">
                                    <a class="nav-link fs-14 bg-transparent {if ($Login.allow_login_phone==1 && $Login.allow_login_email == 0  && $Login.allow_id == 0) || $Get.action=="phone" || $Get.action=="phone_code"}active{/if}" data-toggle="tab" href="#phone" role="tab" aria-selected="false">{$Lang.mobile_login}
                                    </a>
                                </li>
                                {/if}
                                
                            </ul>
                            <div class="tab-content">
									{if $Login.allow_login_email || $Login.allow_id}
									<div id="email" class="tab-pane  {if $Get.action=="email" || !$Get.action}active{/if}" role="tabpanel">
                                <form id="loginform" class="form-horizontal mt-4" method="post" action="/login?action=email">

                                    <div class="form-group">
                                        <label for="username">{if $Login.allow_login_email}{$Lang.mailbox}{else}ID{/if}</label>
                                        <input id="email" type="text" class="form-control" name="email" value="{$Post.email}" placeholder="{$Lang.please_enter_your}{if $Login.allow_login_email}{$Lang.mailbox}{if $Login.allow_id==1}{$Lang.ors}{/if}{/if}{if $Login.allow_id==1}ID{/if}">
                                    </div>

                                    <div class="form-group">
                                        <label for="userpassword">{$Lang.password}</label>
                                        <input id="password" type="password" class="form-control" name="password" placeholder="{$Lang.please_enter_password}">
                                    </div>
{if $Login.allow_login_email_captcha==1 && $Login.is_captcha==1}
											{include file="includes/verify"  type="allow_login_email_captcha" positon="top"}
											{/if}				
                                    <div class="form-group row">
                                        <div class="col-sm-6">
                                            <div class="custom-control custom-checkbox">
                                                <input type="checkbox" class="custom-control-input" id="rememberme">
                                                <label class="custom-control-label" for="rememberme">{$Lang.rememberme}</label>
                                            </div>
                                        </div>
                                       
                                        <div class="col-sm-6 text-right">
                                        {if $Login.second_verify_action_home_login==1}
												<!--二次登录验证-->
												<button class="btn btn-primary w-md waves-effect waves-light"
													type="button"  onclick="loginBefore('email');">{$Lang.sign_in}</button>
												{else/}
                                            <button class="btn btn-primary w-md waves-effect waves-light" type="submit">{$Lang.sign_in}</button>
                                            {/if}
                                        </div>
                                      
                                    </div>

                                    <div class="form-group mt-2 mb-0 row">
                                        <div class="col-12 mt-4">
                                            <a href="pwreset"><i class="mdi mdi-lock"></i> {$Lang.forgetpwd}</a>
                                        </div>
                                    </div>

                                </form>

                            </div>
                            {/if}
                            
                            <!-- 手机号登录 -->
                            {if $Login.allow_login_phone}
              
										<div id="phone" class="tab-pane {if ($Login.allow_login_phone==1 && $Login.allow_login_email == 0  && $Login.allow_id == 0) || $Get.action=="phone" || $Get.action=="phone_code"}active{/if}" role="tabpanel">
										<form method="post" id="form2" class="form-horizontal mt-4" action="/login?action=phone" >

                                   	<div class="form-group">
												<label for="username">{$Lang.phone_number}</label>
												<div class="input-group">
													<div class="input-group-prepend col-xs-12 col-sm-8 col-md-5 col-lg-4" >
														<select class="form-control select2 select2-hidden-accessible"
															data-select2-id="1" tabindex="-1" aria-hidden="true"
															name="phone_code"  value="{$Post.phone_code}"  id="phoneCodeSel">
															{foreach $SmsCountry as $list}
															<option value="{$list.phone_code}" {if $list.phone_code=="+86"}selected {/if}>
																{$list.link}
															</option>
															{/foreach}
														</select>
													</div>
													<input type="text" class="form-control" id="phone" name="phone"  value="{$Post.phone}"  placeholder="{$Lang.please_enter_your_mobile_phone_number}">
												</div>
											</div>

                                    <div class="form-group">
                                        <label for="userpassword">{$Lang.password}</label>
                                        <input id="pwd" type="password" class="form-control" name="password" placeholder="{$Lang.please_enter_password}">
                                    </div>
	{if $Login.allow_login_phone_captcha==1 && $Login.is_captcha==1}
											{include file="includes/verify"  type="allow_login_phone_captcha" positon="top"}
											{/if}
											{if $Login.allow_login_code_captcha==1 && $Login.is_captcha==1}
											{include file="includes/verify"  type="allow_login_code_captcha" positon="top"}
											{/if}
                      
											<div class="form-group allow_login_code_captcha">
												<label for="code">{$Lang.verification_code}</label>
												<div class="input-group">
													<input type="text" class="form-control" id="phoneCodeInp" name="code"  value="{$Post.code}" placeholder="{$Lang.please_enter_code}">
													<div class="input-group-append">
														<button class="btn btn-primary" type="button"   onclick="getCode(this,'login_send','allow_login_code_captcha')">{$Lang.get_code}</button>
														
													</div>
												</div>
											</div>

											
											
											<div class="d-flex justify-content-between align-items-center">
												<div onclick="phoneCheck(this,'allow_login_phone_captcha')" class="text-primary mr-0 pointer" {if $Get.action=="phone_code"} style="display:none;" {/if}>
													{$Lang.verification_code_login}
												</div>
												<div onclick="phoneCheck(this,'allow_login_code_captcha')" class="text-primary mr-0 pointer" {if $Get.action!="phone_code"} style="display:none;" {/if}>
													{$Lang.password_login}
												</div>
                        <a href="pwreset" class="text-primary mr-0">{$Lang.forget_the_password}</a> 
											</div>
                                    <div class="form-group row">
                                        <div class="col-sm-6">
                                            <div class="custom-control custom-checkbox">
                                                <input type="checkbox" class="custom-control-input" id="rememberme2">
                                                <label class="custom-control-label" for="rememberme2">{$Lang.rememberme}</label>
                                            </div>
                                        </div>
                                        <div class="col-sm-6 text-right">
                                        {if $Login.second_verify_action_home_login==1}
												<!--二次登录验证-->
												<button class="btn btn-primary w-md waves-effect waves-light allow_login_phone_captcha" type="button"  onclick="loginBefore('phone');">{$Lang.sign_in}</button>
												<button class="btn btn-primary w-md waves-effect waves-light allow_login_code_captcha" type="submit">{$Lang.sign_in}</button>
												{else/}
                      
                                            <button class="btn btn-primary w-md waves-effect waves-light" type="submit">{$Lang.sign_in}</button>
                                            {/if}
                                        </div>
                                    </div>

                                    <div class="form-group mt-2 mb-0 row">
                                        <div class="col-12 mt-4">
                                            <a href="pwreset"><i class="mdi mdi-lock"></i> {$Lang.forgetpwd}</a>
                                        </div>
                                    </div>

                                

                            </div>
                           
                            
                        </div>

                    </div>
</form> {/if}

{if $Oauth}
<br>
                            <div class="mb-4 text-center">
                                <h5 class="font-size-14 mb-3">{$Lang.use_other_login}</h5>
 <div height="20px">
                                <ul class="list-inline">
                                    {foreach $Oauth as $list}
                                    <li class="list-inline-item">
                                        <a href="{$list.url}" class="social-list-item text-white" target="blank">
                                            {$list.img}
                                        </a>
                                    </li>
                                    {/foreach}
                                </ul>
                            </div></div>
                            {/if}
                    


                </div>
            </div>
            <div class="mt-5 text-center">
                        <p>{$Lang.noaccount} <a href="register" class="font-weight-medium text-primary"> {$Lang.signup} </a> </p>
                        {if $Setting.login_footer}
    <div class="text-center">{$Setting.login_footer}</div>
    {else/}
    
                        <p class="mb-0">© <script>document.write(new Date().getFullYear())</script> {$Setting.company_name}</p>
                        {/if}
                    </div>
        </div>
    </div>

{if $Login.second_verify_action_home_login==1}
<!--登录二次验证 模态框-->
<div class="modal fade" id="secondVerifyModal" tabindex="-1" role="dialog" aria-labelledby="secondVerifyModal"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">{$Lang.secondary_verification}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form>
					<input type="hidden" value="{$Token}" />
					<input type="hidden" value="closed" name="action" />
					<div class="form-group row mb-4">
						<label class="col-sm-3 col-form-label text-right">{$Lang.verification_method}</label>
						<div class="col-sm-8">
							<select class="form-control" class="second_type" name="type" id="secondVerifyType">
								
							</select>
						</div>
					</div>
            	<!--忘记密码-->
                       
					<div class="form-group row mb-0">
						<label class="col-sm-3 col-form-label text-right">{$Lang.verification_code}</label>
						<div class="col-sm-8">
							<div class="input-group">
								<input type="text" name="code" id="secondVerifyCode" class="form-control" placeholder="{$Lang.please_enter_code}" />
								<div class="input-group-append" id="getCodeBox">
									<button class="btn btn-secondary"  type="button"  onclick="getCode(this,'login/second_verify_send')" type="button">{$Lang.get_code}</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-outline-light" data-dismiss="modal">{$Lang.cancel}</button>
				<button type="button" class="btn btn-primary mr-2" id="secondVerifySubmit">{$Lang.determine}</button>
			</div>
		</div>
	</div>
</div>
{/if}
<script type="text/javascript">
{if $Get.action=="phone_code"} 
phoneCheck("","allow_login_phone_captcha")
{else/} 
phoneCheck("","allow_login_code_captcha")
{/if}
</script>
<script>
//Rememberme1
  window.onload = function(){
    var fantacyForm = document.getElementById('loginform');
    var fantacyUser = document.getElementById('email');
    var fantacyPswd = document.getElementById('password');
    var fantacyRemember = document.getElementById('rememberme');
    //密码cookie存在则填充
    if(getCookie('email') && getCookie('password')){
      fantacyUser.value = getCookie('email');
      fantacyPswd.value = getCookie('password');
      fantacyRemember.checked = true;
    }
    fantacyRemember.onchange = function(){
      if(!this.checked){
        delCookie('email');
        delCookie('password');
      }
    };
    fantacyForm.onsubmit = function(){
      if(rememberme.checked){ 
        setCookie('email',fantacyUser.value,7); //保存帐号到cookie，有效期7天
        setCookie('password',fantacyPswd.value,7); //保存密码到cookie，有效期7天
      }
    };
  };

//Rememberme 2
  window.onload = function(){
    var fantacyForm2 = document.getElementById('form2');
    var fantacyUser2 = document.getElementById('phone');
    var fantacyPswd2 = document.getElementById('pwd');
    var fantacyRemember2 = document.getElementById('rememberme2');
    //密码cookie存在则填充
    if(getCookie('phone') && getCookie('pwd')){
      fantacyUser2.value = getCookie('phone');
      fantacyPswd2.value = getCookie('pwd');
      fantacyRemember2.checked = true;
    }
    fantacyRemember2.onchange = function(){
      if(!this.checked){
        delCookie('phone');
        delCookie('pwd');
      }
    };
    fantacyForm2.onsubmit = function(){
      if(rememberme2.checked){ 
        setCookie('phone',fantacyUser2.value,7); //保存帐号到cookie，有效期7天
        setCookie('pwd',fantacyPswd2.value,7); //保存密码到cookie，有效期7天
      }
    };
  };
  //设置cookie
  function setCookie(name,value,day){
    var date = new Date();
    date.setDate(date.getDate() + day);
    document.cookie = name + '=' + value + ';expires='+ date;
  };
  //获取cookie
  function getCookie(name){
    var reg = RegExp(name+'=([^;]+)');
    var arr = document.cookie.match(reg);
    if(arr){
      return arr[1];
    }else{
      return '';
    }
  };
  //删除cookie
  function delCookie(name){
    setCookie(name,null,-1);
  };
</script>
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