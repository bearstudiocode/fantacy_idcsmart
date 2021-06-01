{include file="includes/modal"}
<script src="{$Setting.web_url}/themes/clientarea/default/assets/js/public.js?v={$Ver}"></script>
<style>
	.novalid {
		min-width: 80px;
    height: 26px;
    line-height: 20px;
    background-color: rgba(253, 254, 254, 0.32);
    box-shadow: 0px 6px 14px 2px rgba(6, 31, 179, 0.26);
    border-radius: 4px;
    color: #fff;
	}
</style>
<div class="card mb-4 bg-primary security-header security-header1 col-md-12">
	<div class="card-body">
		<div class="row align-items-center text-white pl-md-4">
			<div class="col-md-3 col-xl-2 phonehide">
				<div class="security-avatar">
				{php}
                                          $email = $Userinfo['user']['email'];
                                          $b = str_replace('@qq.com','',$email);
    if(stristr($email,'@qq.com')&&is_numeric($b)&&strlen($b)<11&&strlen($b)>4){
        $nk = 'https://s.p.qq.com/pub/get_face?img_type=3&uin='.$b;
        $c = get_headers($nk, true);
        $d = $c['Location'];
        $q = json_encode($d);
        $k = explode("&k=",$q)[1];
        $gravatar = 'https://q.qlogo.cn/g?b=qq&k='.$k.'&s=100';
    }else{

				$getgravatar = md5($Userinfo['user']['email']);
				$gravatar = '//gravatar.loli.net/avatar/'.$getgravatar.'?';
				}
				{/php}
					<img src="{$gravatar}" alt="" class="img-fluid img-thumbnail rounded-circle avatar-lg">
				
				</div>
			</div>
			<div class="col-md-12 col-xl-4">
				<div class="security-info">
					<div class="security-username">
						{$Userinfo.user.username}
						{if $Userinfo.user.certifi.status == '1'}
							<button class="btn btn-success btn-sm">{$Lang.real_name_authentication}</button>
						{else}
							<button class="btn btn-danger btn-sm">{$Lang.no_real_name_authentication}</button>
						{/if}
					</div>
					
					<div class="security-strength">
						<div class="security-label">
							{$Lang.account_security_strength}:
							<span class="security-text">
								{$percentage[0]}
							</span>
						</div>
						<div class="security-text">
						
							<div class="progress">
                                                <div class="progress-bar progress-bar-striped progress-bar-animated bg-danger" role="progressbar" style="width: {$percentage[1]}%" aria-valuenow="25"
									aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-5">
				<div class="security-meta">
					<ul class="list-inline mb-2">
						<li class="list-inline-item">
							<label class="mb-0">{$Lang.mailbox}：</label>
							{if $Userinfo.user.email}
							{$Userinfo.user.email}
							{else}
							{$Lang.unbound}
							{/if}
						</li>
					
						<li class="list-inline-item">
							<label class="mb-0">{$Lang.opening_time}：</label>
							{$Userinfo.user.create_time|date="Y-m-d H:i:s"}
						</li>
						<ul class="list-inline mb-0">
							<li class="list-inline-item">
								<label class="mb-0">{$Lang.mobile_phone}：</label>
								{if $Userinfo.user.phonenumber}
								{$Userinfo.user.phonenumber}
								{else}
								{$Lang.unbound}
								{/if}
							</li>
						</ul>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-sm-8 col-xl-6">
		<div class="card mb-3" style="border-radius:20px">
			<div class="card-body">
				<div class="security-items">

					<div class="security-item">
						<div class="security-item-icon bg-primary">
							<i class="fas fa-fingerprint"></i>
						</div>
						<div class="security-item-info">
							<div class="security-item-text">
								<h4 class="security-item-title">
									{$Lang.login_password}
									{if $Userinfo.user.is_password}
									<small>
										<i class="fas fa-check-circle"></i>
										{$Lang.set}
									</small>
									{/if}
								</h4>
								<div class="security-item-desc">
									{$Lang.regularly_details}
								</div>
							</div>
							{if $Userinfo.user.is_password}
							<a class="btn btn-outline-primary w-md waves-effect waves-light" data-toggle="modal"
								data-target="#modifyPasswordModal" onclick="showPassword()">{$Lang.modify}</a>
							{else}
							<a data-target="#modifyPasswordModal" onclick="showPassword()" data-toggle="modal"
								class="btn btn-outline-primary w-md waves-effect waves-light">{$Lang.set_password}</a>
							{/if}
						</div>
					</div>
					<!-- Security-item END -->
					{if $Userinfo.shd_allow_sms_send}
					<div class="security-item">
						<div class="security-item-icon bg-info">
							<i class="fas fa-mobile"></i>
						</div>
						<div class="security-item-info">
							<div class="security-item-text">
								<h4 class="security-item-title">
									{$Lang.mobile_phone_binding}
									{if $Userinfo.user.phonenumber}
									<small>
										<span class="phonehide">{$Userinfo.user.phonenumber|substr=0,3}****{$Userinfo.user.phonenumber|substr=7,11}</span>
										<i class="fas fa-check-circle"></i>
										{$Lang.set}
									</small>
									{/if}
								</h4>
								<div class="security-item-desc">
									{$Lang.regularly_details}
								</div>
							</div>
							{if $Userinfo.user.phonenumber&&$BindPhoneChange==0}
							<a class="btn btn-outline-primary w-md waves-effect waves-light" data-toggle="modal"
								data-target="#bindPhoneChangeModal1" id="bindPhoneChangeBtn1">{$Lang.modify}</a>
							{elseif $Userinfo.user.phonenumber&&$BindPhoneChange==1}

							<a class="btn btn-outline-primary w-md waves-effect waves-light" data-toggle="modal"
								data-target="#bindPhoneChangeModal2" id="bindPhoneChangeBtn2">{$Lang.modify}</a>
							{else}

							<a class="btn btn-outline-primary w-md waves-effect waves-light" data-toggle="modal"
								data-target="#bindPhoneModal">{$Lang.bind_now}</a>
							{/if}
						</div>
					</div>
					{/if}
					<!-- Security-item END -->

					{if $Userinfo.shd_allow_email_send}
					<div class="security-item">
						<div class="security-item-icon bg-primary">
							<i class="fas fa-envelope"></i>
						</div>
						<div class="security-item-info">
							<div class="security-item-text">
								<h4 class="security-item-title">
									{$Lang.mailbox_binding}
									{if $Userinfo.user.email}
									<small>
										<span class="phonehide">{$Userinfo.user.email}</span>
										<i class="fas fa-check-circle"></i>
										{$Lang.set}
									</small>
									{/if}
								</h4>
								<div class="security-item-desc">
									{$Lang.reset_password_notice}
								</div>
							</div>
							{if $Userinfo.user.email&&$BindEmailChange==0}

							<a class="btn btn-outline-primary w-md waves-effect waves-light" data-toggle="modal"
								data-target="#changeEmailHandleModal1">{$Lang.modify}</a>
							{elseif $Userinfo.user.email&&$BindEmailChange==1 /}

							<a class="btn btn-outline-primary w-md waves-effect waves-light" data-toggle="modal"
								data-target="#changeEmailHandleModal2">{$Lang.modify}</a>
							{else}

							<a class="btn btn-outline-primary w-md waves-effect waves-light" data-toggle="modal"
								data-target="#bindEmailHandleModal">{$Lang.mailbox_binding}</a>
							{/if}
						</div>
					</div>
					{/if}
					<!-- Security-item END -->

					{if $Userinfo.certifi_open}
					<div class="security-item">
						<div class="security-item-icon bg-info">
							<i class="fas fa-portrait"></i>
						</div>
						<div class="security-item-info">
							<div class="security-item-text">
								<h4 class="security-item-title">
									{$Lang.real_name_authentications}
									{if $Userinfo.user.certifi.status==1}
									<small>
										<i class="fas fa-check-circle"></i>
										{$Lang.set}
									</small>
									{/if}
								</h4>
								<div class="security-item-desc">
									{$Lang.personal_security}
								</div>
							</div>
							{if $Userinfo.user.certifi.status == 1}
							<a href="verified" class="btn btn-outline-primary w-md waves-effect waves-light">{$Lang.certified}</a>
							{else}
							<a href="verified" class="btn btn-primary w-md waves-effect waves-light">{$Lang.not_certified}</a>

							{/if}
						</div>
					</div>
					<!-- Security-item END -->
					{/if}

					{if $Userinfo.allow_second_verify}
					<div class="security-item">
						<div class="security-item-icon bg-info">
							<i class="far fa-check"></i>
						</div>
						<div class="security-item-info">
							<div class="security-item-text">
								<h4 class="security-item-title">
									{$Lang.secondary_verification}
									{if $Userinfo.user.second_verify}
									<small>
										<i class="fas fa-check-circle"></i>
										{$Lang.set}
									</small>
									{/if}
								</h4>
								<div class="security-item-desc">
									{$Lang.secondary_verification_details}
								</div>
							</div>
							{if $Userinfo.user.second_verify}

							<a class="btn btn-primary w-md waves-effect waves-light" onclick="closeSecondHandleClick()">{$Lang.close}</a>
							{else}

							<a class="btn btn-primary w-md waves-effect waves-light" data-toggle="modal"
								data-target="#toggleSecondVerifyModalOpen">{$Lang.opens_two}</a>
							{/if}
						</div>
					</div>
					<!-- Security-item END -->
					{/if}

					{if $Userinfo.allow_resource_api}
					<div class="security-item">
						<div class="security-item-icon bg-primary">
							<i class="far fa-link"></i>
						</div>
						<div class="security-item-info">
							<div class="security-item-text">
								<h4 class="security-item-title">
									API
								</h4>
								<div class="security-item-desc">
									{$Lang.administration_details}
								</div>
							</div>

							<a class="btn btn-primary w-md waves-effect waves-light" onclick="showApiPwdHandleClick()">{$Lang.view_secret_key}</a>
						</div>
					</div>
					<!-- Security-item END -->
					{/if}
				</div>
			</div>
		</div>
	</div>
	<div class="col-sm-4 col-xl-6">

		{if $Userinfo.shd_allow_sms_send}
		<div class="card mb-3" style="border-radius:20px">
			<div class="card-body">

				<div class="security-item">
					<div class="security-item-info">
						<div class="security-item-text">
							<h4 class="security-item-title">
								{$Lang.sms_reminder}
							</h4>
							<div class="security-item-desc">
								{$Lang.sms_settings}
							</div>
						</div>
						{if !$Userinfo.user.phonenumber}
						<button data-v-2d646d70="" disabled="disabled" type="button"
							class="btn btn-outline-primary w-md waves-effect waves-light">{$Lang.need_bind_mobile_phone}</button>
						{elseif $Userinfo.user.is_login_sms_reminder==1}

						<a class="btn btn-outline-primary w-md waves-effect waves-light" data-toggle="modal"
							data-target="#loginSmsReminderModal">{$Lang.cancel}</a>
						{else}

						<a class="btn btn-outline-primary w-md waves-effect waves-light" data-toggle="modal"
							data-target="#loginSmsReminderModalOpen">{$Lang.opens_two}</a>
						{/if}
					</div>
				</div>
				<!-- Security-item END -->
 
			</div>
		</div>
		{/if}

		{if $Userinfo.shd_allow_email_send}
		<div class="card mb-3" style="border-radius:20px">
			<div class="card-body">
				<div class="security-item">
					<div class="security-item-info">
						<div class="security-item-text">
							<h4 class="security-item-title">
								{$Lang.email_reminder}
							</h4>
							<div class="security-item-desc">
								{$Lang.mailbox_settings}
							</div>
						</div>
						{if !$Userinfo.user.email}
						<button data-v-2d646d70="" disabled="disabled" type="button"
							class="btn btn-outline-primary w-md waves-effect waves-light">{$Lang.need_bind_mailbox}</button>
						{elseif $Userinfo.user.email_remind==1}

						<a class="btn btn-outline-primary w-md waves-effect waves-light" data-toggle="modal"
							data-target="#loginEmailReminderModal">{$Lang.cancel}</a>
						{else}

						<a class="btn btn-outline-primary w-md waves-effect waves-light" data-toggle="modal"
							data-target="#loginEmailReminderModalOpen">{$Lang.set_up_now}</a>
						{/if}
					</div>
				</div>
				<!-- Security-item END -->

			</div>
		</div>
		{/if}

		{if $Security.oauthBind}
		<div class="card" style="border-radius:20px">
			<div class="card-body">
				<h4 class="card-title mb-4">{$Lang.third_party_login}</h4>
				{foreach $Security.oauthBind as $oauth}
				<div class="security-item">
					<div class="security-item-icon">
						{$oauth.img}
					</div>
					<div class="security-item-info">
						<div class="security-item-text">
							<h4 class="security-item-title">
								{$oauth.name}

							</h4>
							<div class="security-item-desc">
								{if $oauth.oauth=="bind"}
								{$Lang.nickname}：{$oauth.username}
								{elseif $oauth.oauth == 'unbind'}
								{$Lang.unbound}
								{/if}
							</div>
						</div>
						{if $oauth.oauth == 'unbind'}
						<a href="{$oauth.url}" class="btn btn-primary w-md waves-effect waves-light">{$Lang.binding}</a>
						{elseif $oauth.oauth == 'bind'}
						<a href="javascript: getModal('/oauthBind/untie/{$oauth.dirName}', '{$Lang.prompt}', '{$Lang.make_sure_unbind}{$oauth.name}?', {status: 1});"
							class="btn btn-outline-primary w-md waves-effect waves-light">{$Lang.solution}</a>
						{/if}
					</div>
				</div>
				<!-- Security-item END -->

				{/foreach}

			</div>
		</div>
		{else}
		<div class="security-item-image"></div>
		{/if}
	</div>
</div>



<!-- start: 修改密码模态框 -->
<div class="modal fade" id="modifyPasswordModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">{if $Userinfo.user.is_password}{$Lang.change_password}{else}{$Lang.set_password}{/if}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form id="modifyPwdForm" class="needs-validation" novalidate>
					{if $Userinfo.user.is_password}
					<div class="form-group row">
						<label class="col-sm-3 col-form-label text-right">{$Lang.original_password}</label>
						<div class="col-sm-8">
							<div class="input-group">
								<input type="password" name="old_password" class="form-control old_password" id="oldPwd"
									placeholder="{$Lang.security_please_enter_password}" required />
								<div class="input-group-append">
									<button type="button" class="btn btn-secondary  old_password_btn">
										<i class="fas fa-eye"></i>
									</button>
								</div>
							</div>
							<input type="hidden" name="flag" vaule="1" />
						</div>
					</div>
					{else/}
					<input type="hidden" name="flag" vaule="2" />
					{/if}
					<div class="form-group row">
						<label class="col-sm-3 col-form-label text-right">{if $Userinfo.user.is_password}{$Lang.new_password}{else}{$Lang.password}{/if}</label>
						<div class="col-sm-8">
							<div class="input-group">
								<input type="password" name="password" class="form-control password" id="pwd"
									placeholder="{if $Userinfo.user.is_password}{$Lang.security_please_new_password}{else}{$Lang.security_please_password}{/if}" required />
								<div class="input-group-append">
									<button type="button" class="btn btn-secondary  password_btn">
										<i class="fas fa-eye"></i>
									</button>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-3 col-form-label text-right">{if
							$Userinfo.user.is_password}{$Lang.repeat_new_password}{else}{$Lang.repeat_then_password}{/if}</label>
						<div class="col-sm-8">
							<div class="input-group">
								<input type="password" name="re_password" class="form-control re_password" id="rePwd"
									placeholder="{if $Userinfo.user.is_password}{$Lang.repeat_new_password}{else}{$Lang.repeat_password}{/if}" required />
								<div class="input-group-append">
									<button type="button" class="btn btn-secondary  re_password_btn">
										<i class="fas fa-eye"></i>
									</button>
								</div>
							</div>
						</div>
					</div>
					{if $Verify.allow_resetpwd_captcha==1&&$Userinfo.user.is_password}
					{include file="includes/verify" type="allow_resetpwd_captcha"}
					{elseif $Verify.allow_setpwd_captcha==1&&!$Userinfo.user.is_password}
					{include file="includes/verify" type="allow_setpwd_captcha"}
					{/if}
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary mr-2" id="modifyPwdSubmit" onclick="modifyPwdCheckForm()">{$Lang.determine}</button>
				<button type="button" class="btn btn-outline-light" data-dismiss="modal">{$Lang.cancel}</button>
			</div>
		</div>
	</div>
</div>
<script>
	var _url = '{$Setting.web_url}';
	var phoneType = '{$BindPhoneChange}'
	var is_password = '{$Userinfo.user.is_password}';
	var emailType = '{$BindEmailChange}'
	var WebUrl = '{$Setting.web_url}/';
</script>
<!-- end: 修改密码模态框 -->

<!-- start: 手机绑定模态框 -->
<div class="modal fade" id="bindPhoneModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">{$Lang.mobile_phone_binding}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form>
					<input type="hidden" value="{$Token}" />
					<input type="hidden" name="phone_code" value="+86" />
					<div class="form-group row">
						<label class="col-sm-3 col-form-label text-right">{$Lang.phone_number}</label>
						<div class="col-sm-8">
							<input type="text" name="phone" class="form-control" id="phoneNum" placeholder="{$Lang.input_mobile}" />
						</div>
					</div>
          {if $Verify.allow_phone_bind_captcha==1}
					{include file="includes/verify" type="allow_phone_bind_captcha" id="captchaPhone1"}
					{/if}
					<div class="form-group row">
						<label class="col-sm-3 col-form-label text-right">{$Lang.verification_code}</label>
						<div class="col-sm-8">
							<div class="input-group">
								<input type="text" name="code" class="form-control " id="code" placeholder="{$Lang.please_enter_code}" />
								<div class="input-group-append">
									<button
										onclick="getCheckCode('bind_phone','phone','bind-phone-button','post', undefined, 'bindPhoneModal','captcha_allow_phone_bind_captchacaptchaPhone1')"
										class="btn btn-secondary bind-phone-button" type="button">{$Lang.get_code}</button>
								</div>
							</div>
						</div>
					</div>

				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary mr-2" id="bindPhoneSubmit" onclick="bindPhoneCheckForm()">{$Lang.determine}</button>
				<button type="button" class="btn btn-outline-light" data-dismiss="modal">{$Lang.cancel}</button>
			</div>
		</div>
	</div>
</div>
<!-- start: 修改手机绑定 -->
<div class="modal fade" id="bindPhoneChangeModal1" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">{$Lang.verify_original_phone}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form>
					<input type="hidden" value="{$Token}" />
					<input type="hidden" name="type" value="{if $BindPhoneChange==0}1{else}2{/if}" />
					<input type="hidden" name="phone_code" value="+86" />
					<div class="form-group row mb-4">
						<label class="col-sm-3 col-form-label text-right">{$Lang.phone_number}</label>
						<div class="col-sm-8">
							{if $Userinfo.user.phonenumber}
							<input type="text" name="tel" readonly id="oldTel"
								value="{$Userinfo.user.phonenumber|substr=0,3}****{$Userinfo.user.phonenumber|substr=7,11}"
								class="form-control" placeholder="{$Lang.input_mobile}" />
							{/if}
						</div>
					</div>
          {if $Verify.allow_phone_bind_captcha==1}
					{include file="includes/verify" type="allow_phone_bind_captcha" id="captchaPhone2"}
					{/if}
					<div class="form-group row mb-0">
						<label class="col-sm-3 col-form-label text-right">{$Lang.verification_code}</label>
						<div class="col-sm-8">
							<div class="input-group">
								<input type="text" name="code" id="bindPhoneChangeCode1" class="form-control " placeholder="{$Lang.please_enter_code}" />
								<div class="input-group-append">
									<button
										onclick="getCheckCode('bind_phone_code','tel','bind-phone-button1','get',1, 'bindPhoneChangeModal1','captcha_allow_phone_bind_captchacaptchaPhone2')"
										class="btn btn-secondary bind-phone-button1" type="button">{$Lang.get_code}</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary mr-2" id="bindPhoneChangeSubmit1" onclick="phoneChangeBtn()">{$Lang.determine}</button>
				<button type="button" class="btn btn-outline-light" data-dismiss="modal">{$Lang.cancel}</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="bindPhoneChangeModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">{$Lang.bind_mobile_phone}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form>
					<input type="hidden" value="{$Token}" />
					<input type="hidden" name="type" value="{if $BindPhoneChange==0}1{else}2{/if}" />
					<input type="hidden" name="phone_code" value="+86" />
					<div class="form-group row mb-4">
						<label class="col-sm-3 col-form-label text-right">{$Lang.phone_number}</label>
						<div class="col-sm-8">
							<input type="text" name="tel" id="newTel" class="form-control" placeholder="{$Lang.input_mobile}" />
						</div>
					</div>
          {if $Verify.allow_phone_bind_captcha==1}
					{include file="includes/verify" type="allow_phone_bind_captcha" id="captchaPhone3"}
					{/if}
					<div class="form-group row mb-0">
						<label class="col-sm-3 col-form-label text-right">{$Lang.verification_code}</label>
						<div class="col-sm-8">
							<div class="input-group">
								<input type="text" name="code" id="bindPhoneChangeCode2" class="form-control " placeholder="{$Lang.please_enter_code}" />
								<div class="input-group-append">
									<button id="bindPhoneChangeCodeBtn2"
										onclick="getCheckCode('bind_phone_code','tel','bind-phone-button2','get',2, 'bindPhoneChangeModal2','captcha_allow_phone_bind_captchacaptchaPhone3')"
										class="btn btn-secondary bind-phone-button2" type="button">{$Lang.get_code}</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary mr-2" id="bindPhoneChangeSubmit2" onclick="phoneChangeBtn2()">{$Lang.determine}</button>
				<button type="button" class="btn btn-outline-light" data-dismiss="modal">{$Lang.cancel}</button>
			</div>
		</div>
	</div>
</div>
<!-- start 短信提醒 关闭 -->
<div class="modal fade" id="loginSmsReminderModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">{$Lang.turn_off_sms_alert}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form>
					<input type="hidden" value="{$Token}" />
					<input type="hidden" name="phone_code" value="+86" />
					<div class="form-group row">
						<label class="col-sm-3 col-form-label text-right">{$Lang.phone_number}</label>
						<div class="col-sm-8">
							<input type="text" name="name" readonly
								value="{$Userinfo.user.phonenumber|substr=0,3}****{$Userinfo.user.phonenumber|substr=7,11}"
								class="form-control" placeholder="{$Lang.input_mobile}" />
						</div>
					</div>
          {if $Verify.allow_cancel_sms_captcha==1}
					{include file="includes/verify" type="allow_cancel_sms_captcha" id="captchaSms1"}
					{/if}
					<div class="form-group row">
						<label class="col-sm-3 col-form-label text-right">{$Lang.verification_code}</label>
						<div class="col-sm-8">
							<div class="input-group">
								<input type="text" name="code" class="form-control " id="loginSmsReminderCode" placeholder="{$Lang.please_enter_code}" />
								<div class="input-group-append">
									<button
										onclick="getCheckCode('remind_send','phone','bind-phone-button','get', undefined, 'loginSmsReminderModal',id='captcha_allow_cancel_sms_captchacaptchaSms1')"
										class="btn btn-secondary bind-phone-button" type="button">{$Lang.get_code}</button>
								</div>

							</div>
						</div>
					</div>

				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary mr-2" id="loginSmsReminderSubmit" onclick="loginSmsReminderCheckForm()">{$Lang.determine}</button>
				<button type="button" class="btn btn-outline-light" data-dismiss="modal">{$Lang.cancel}</button>
			</div>
		</div>
	</div>
</div>
<!-- start: 短信提醒 开启 -->
<div class="modal fade" id="loginSmsReminderModalOpen" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">{$Lang.prompt}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="d-flex align-items-center">
					<i class="fas fa-exclamation-circle fs-20 text-warning mr-2"></i>
					{$Lang.on_reminder}
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary mr-2" id="loginSmsReminderSubmitOpen" onclick="smsSubmitOpenBtn()">{$Lang.determine}</button>
				<button type="button" class="btn btn-outline-light" data-dismiss="modal">{$Lang.cancel}</button>
			</div>
		</div>
	</div>
</div>

<!-- end -->


<!-- start: 邮箱绑定 -->
<div class="modal fade" id="bindEmailHandleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">{$Lang.mailbox_binding}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form>
					<input type="hidden" value="{$Token}" />
					<div class="form-group row mb-4">
						<label class="col-sm-3 col-form-label text-right">{$Lang.mailbox}</label>
						<div class="col-sm-8">
							<input type="text" name="email" class="form-control" placeholder="{$Lang.please_input_email}" id="bindEmailHandleEmail" />
						</div>
					</div>
          {if $Verify.allow_email_bind_captcha==1}
					{include file="includes/verify" type="allow_email_bind_captcha" id="captchaEmail1"}
					{/if}
					<div class="form-group row mb-0">
						<label class="col-sm-3 col-form-label text-right">{$Lang.verification_code}</label>
						<div class="col-sm-8">
							<div class="input-group">
								<input type="text" name="code" class="form-control" placeholder="{$Lang.please_enter_code}" id="bindEmailHandleCode" />
								<div class="input-group-append">
									<button class="btn btn-secondary bind-email-button"
										onclick="getCheckCode('bind_email','email','bind-email-button','post', undefined, 'bindEmailHandleModal','captcha_allow_email_bind_captchacaptchaEmail1')"
										type="button" id="button-addon2">{$Lang.get_code}</button>
								</div>
							</div>
						</div>
					</div>

				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary mr-2" id="bindEmailHandleSubmit" onclick="bindEmailHandleCheckForm()">{$Lang.determine}</button>
				<button type="button" class="btn btn-outline-light" data-dismiss="modal">{$Lang.cancel}</button>
			</div>
		</div>
	</div>
</div>
<!-- start: 邮箱修改 -->
<div class="modal fade" id="changeEmailHandleModal1" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">{$Lang.verify_original_email}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form>
					<input type="hidden" value="{$Token}" />
					<input type="hidden" name="type" value="{if $BindEmailChange==0}1{else}2{/if}" />
					<div class="form-group row mb-4">
						<label class="col-sm-3 col-form-label text-right">{$Lang.mailbox}</label>
						<div class="col-sm-8">
							<input type="text" name="email" id="changeEmailHandleEmail1" readonly value="{$Userinfo.user.email}"
								class="form-control" placeholder="{$Lang.please_input_email}" />
						</div>
					</div>
          {if $Verify.allow_email_bind_captcha==1}
					{include file="includes/verify" type="allow_email_bind_captcha" id="captchaEmail2"}
					{/if}
					<div class="form-group row mb-0">
						<label class="col-sm-3 col-form-label text-right">{$Lang.verification_code}</label>
						<div class="col-sm-8">
							<div class="input-group">
								<input type="text" name="code" id="changeEmailHandleCode1" class="form-control" placeholder="{$Lang.please_enter_code}" />
								<div class="input-group-append">
									<button class="btn btn-secondary bind-email-button1"
										onclick="getCheckCode('change_email','email','bind-email-button1','post',1, 'changeEmailHandleModal1','captcha_allow_email_bind_captchacaptchaEmail2')"
										type="button" id="button-addon2">{$Lang.get_code}</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary mr-2" id="changeEmailHandleSubmit1" onclick="changeEmailBtn()">{$Lang.determine}</button>
				<button type="button" class="btn btn-outline-light" data-dismiss="modal">{$Lang.cancel}</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="changeEmailHandleModal2" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">{$Lang.bind_new_mailbox}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form>
					<input type="hidden" value="{$Token}" />
					<input type="hidden" name="type" value="{if $BindEmailChange==0}1{else}2{/if}"  id="captcha3"/>
					<div class="form-group row mb-4">
						<label class="col-sm-3 col-form-label text-right">{$Lang.mailbox}</label>
						<div class="col-sm-8">
							<input type="text" name="email" id="changeEmailHandleEmail2" class="form-control" placeholder="{$Lang.please_input_email}" />
						</div>
					</div>
          {if $Verify.allow_email_bind_captcha==1}
					{include file="includes/verify" type="allow_email_bind_captcha" id="captchaEmail3"}
					{/if}
					<div class="form-group row mb-0">
						<label class="col-sm-3 col-form-label text-right">{$Lang.verification_code}</label>
						<div class="col-sm-8">
							<div class="input-group">
								<input type="text" name="code" id="changeEmailHandleCode2" class="form-control" placeholder="{$Lang.please_enter_code}" />
								<div class="input-group-append">
									<button class="btn btn-secondary bind-email-button2"
										onclick="getCheckCode('change_email','email','bind-email-button2','post',2, 'changeEmailHandleModal2','captcha_allow_email_bind_captchacaptchaEmail3')"
										type="button" id="button-addon2">{$Lang.get_code}</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary mr-2" id="changeEmailHandleSubmit2" onclick="changeEmailBtn2()">{$Lang.determine}</button>
				<button type="button" class="btn btn-outline-light" data-dismiss="modal">{$Lang.cancel}</button>
			</div>
		</div>
	</div>
</div>
<!-- start: 邮箱提醒 关闭 -->
<div class="modal fade" id="loginEmailReminderModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">{$Lang.off_reminder}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form>
					<input type="hidden" value="{$Token}" />
					<div class="form-group row mb-4">
						<label class="col-sm-3 col-form-label text-right">{$Lang.mailbox}</label>
						<div class="col-sm-8">
							<input type="text" name="email" readonly value="{$Userinfo.user.email}" class="form-control"
								placeholder="{$Lang.please_input_email}" />
						</div>
					</div>
          {if $Verify.allow_cancel_email_captcha==1}
					{include file="includes/verify" type="allow_cancel_email_captcha"}
					{/if}
					<div class="form-group row mb-0">
						<label class="col-sm-3 col-form-label text-right">{$Lang.verification_code}</label>
						<div class="col-sm-8">
							<div class="input-group">
								<input type="text" name="code" id="loginEmailReminderCode" class="form-control" placeholder="{$Lang.please_enter_code}" />
								<div class="input-group-append">
									<button class="btn btn-secondary bind-email-button bind-email-button"
										onclick="getCheckCode('remind_email_send','email','bind-email-button','get', undefined, 'loginEmailReminderModal','captcha_allow_cancel_email_captcha')"
										type="button" id="button-addon2">{$Lang.get_code}</button>
								</div>
							</div>
						</div>
					</div>

				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary mr-2" id="loginEmailReminderSubmit" onclick="loginEmailReminderCheckForm()">{$Lang.determine}</button>
				<button type="button" class="btn btn-outline-light" data-dismiss="modal">{$Lang.cancel}</button>
			</div>
		</div>
	</div>
</div>
<!-- start: 邮箱提醒 开启 -->
<div class="modal fade" id="loginEmailReminderModalOpen" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">{$Lang.prompt}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="d-flex align-items-center">
					<i class="fas fa-exclamation-circle fs-20 text-warning mr-2"></i>
					{$Lang.open_mailbox_reminder}
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary mr-2" id="loginEmailReminderSubmitOpen" onclick="loginEmailReminderSubmitOpen()">{$Lang.determine}</button>
				<button type="button" class="btn btn-outline-light" data-dismiss="modal">{$Lang.cancel}</button>
			</div>
		</div>
	</div>
</div>
<!-- start: 二次验证 开启 -->
<div class="modal fade" id="toggleSecondVerifyModalOpen" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">{$Lang.prompt}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="d-flex align-items-center">
					<i class="fas fa-exclamation-circle fs-20 text-warning mr-2"></i>
					{$Lang.determine_verification}
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-outline-light" data-dismiss="modal">{$Lang.cancel}</button>
				<button type="button" class="btn btn-primary mr-2" id="toggleSecondVerifySubmitOpen" onclick="toggleSecondVerifySubmitOpen()">{$Lang.determine}</button>
			</div>
		</div>
	</div>
</div>

<!-- start: api -->
<div class="modal fade" id="getapiModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">{$Lang.modify_key}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form>
					<div class="form-group row">
						<label class="col-sm-2 col-form-label text-right">{$Lang.api_key}</label>
						<div class="col-sm-9">
							<div class="input-group">
								<input id="copy-apiss" type="password" name="api" value="{$Userinfo.user.api_password}"
									data-clipboard-text="{$Userinfo.user.api_password}" class="form-control api_passwordss"
									placeholder="{$Lang.please_enter_code}" />
								<div class="input-group-append">
									<button type="button" class="btn btn-secondary btn-password">
										<i class="fas fa-eye"></i>
									</button>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group row mb-0">
						<label class="col-sm-2"></label>
						<div class="col-sm-8">
							<button type="button" class="btn btn-default btn-sm btn-copies w-xs mr-1"
								data-clipboard-target="#copy-apiss" id="btn-copies" onclick="cpBtn()">
								{$Lang.copy}
							</button>
							<button type="button" onClick="getApiPwd()" class="btn btn-default btn-sm btn-random w-xs">
								{$Lang.reset}
							</button>
						</div>
					</div>
				</form>
				<script src="{$Setting.web_url}/themes/clientarea/default/assets/libs/clipboard/clipboard.min.js"></script>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary mr-2" id="getapiModalSubmit" onclick="getapiModalCheckForm()">{$Lang.determine}</button>
				<button type="button" class="btn btn-outline-light" data-dismiss="modal">{$Lang.cancel}</button>
			</div>
		</div>
	</div>
</div>

<script src="{$Setting.web_url}/themes/clientarea/default/assets/js/security.js?v={$Ver}"></script>

