
<!DOCTYPE html>
<html lang="zh-CN">

<head>
	<meta charset="utf-8" />
	<title>{$Title} | {$Setting.company_name}</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta content="{$Setting.web_seo_desc}" name="description" />
	<meta content="{$Setting.web_seo_keywords}" name="keywords" />
	<meta content="{$Setting.company_name}" name="author" />

	{include file="includes/head"}
  <script> 
	var setting_web_url = '{$Setting.web_url}'
  var language={:json_encode($_LANG)};
</script>
<style>
    .logo-lg img{
      width:150px;
      height:auto;
    }
</style>
</head>


<body data-sidebar="dark">
	{if $TplName != 'login' && $TplName != 'register' && $TplName != 'pwreset' && $TplName != 'bind'}
<div id="layout-wrapper">

            <header id="page-topbar">
                <div class="navbar-header">
                    <div class="d-flex">
                        <!-- LOGO -->
                        <div class="navbar-brand-box">
                               {php}
                            $webname = mb_substr($Setting['company_name'],0,1,'utf-8');
                            {/php}
                            <a href="{$Setting.web_jump_url}" class="logo logo-light">
                            {if !$Setting.web_logo_home}
                           
                                <span class="logo-sm">
                                  <img height="20px">
                                    <h4 class="text-white" style="margin-top:-45px;" >{$webname}</h4>
                                </span>
                                <span class="logo-lg">
                                    <img height="20px">
                                    	<h4 class="text-white" style="margin-top:-45px">{$Setting.company_name}</h4>
                                </span>
                                {else/}
                               <span class="logo-sm">
                                  <img height="20px">
                                    <h4 class="text-white" style="margin-top:-45px;" >{$webname}</h4>
                                </span>
						<span class="logo-lg">
							<img src="{$Setting.system_url}/{$Setting.web_logo_home}" alt="" height="18px">
					
						</span>
						{/if}
						
                                
                            </a>
                        </div>
			
				
				
				<button type="button" class="btn btn-sm px-3 font-size-16 header-item waves-effect" id="vertical-menu-btn">
					<i class="fa fa-fw fa-bars"></i>
				</button>


			</div>

			<div class="d-flex">


				<div class="dropdown d-inline-block d-lg-none ml-2 phonehide">
					<button type="button" class="btn header-item noti-icon waves-effect" id="page-header-search-dropdown"
						data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<i class="mdi mdi-magnify"></i>
					</button>
					<div class="dropdown-menu dropdown-menu-lg dropdown-menu-right p-0"
						aria-labelledby="page-header-search-dropdown">

						<form class="p-3">
							<div class="form-group m-0">
								<div class="input-group">
									<input type="text" class="form-control" placeholder="Search ..." aria-label="Recipient's username">
									<div class="input-group-append">
										<button class="btn btn-primary" type="submit">
											<i class="mdi mdi-magnify"></i>
										</button>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>

				<!-- 多语言 -->
				{if $Setting.allow_user_language}
				<div class="dropdown d-inline-block">
					<button type="button" class="btn header-item waves-effect" data-toggle="dropdown" aria-haspopup="true"
						aria-expanded="false">
						<img id="header-lang-img" src="{$Setting.web_url}/upload/common/country/{$LanguageCheck.display_flag}.png" alt="Header Language" height="16">  <span class="mdi mdi-chevron-down"></span>
					</button>
					<div class="dropdown-menu dropdown-menu-right">

						{php}
							$parse = parse_url(request()->url());
							$path=$parse['path'];
							$query=$parse['query'];
							$query = preg_replace('/&language=[a-zA-Z0-9_-]+/','',$query);
						{/php}
						<!-- item-->
						{if $path=="/addons"}
							{foreach $Language as $key=>$list}
								<a href="?{$query}&language={$key}" class="dropdown-item notify-item language" data-lang="zh-cn">
									<img src="{$Setting.web_url}/upload/common/country/{$list.display_flag}.png" alt="user-image"
										 class="mr-1" height="12"> <span class="align-middle">{$list.display_name}</span>
								</a>
							{/foreach}
							{else/}
							{foreach $Language as $key=>$list}
								<a href="?language={$key}" class="dropdown-item notify-item language" data-lang="zh-cn">
									<img src="{$Setting.web_url}/upload/common/country/{$list.display_flag}.png" alt="user-image"
										 class="mr-1" height="12"> <span class="align-middle">{$list.display_name}</span>
								</a>
							{/foreach}
						{/if}

					</div>
				</div>
				{/if}
        <div class="dropdown d-none d-lg-inline-block">
                            <button type="button" class="btn header-item noti-icon waves-effect" data-toggle="fullscreen">
                                <i class="mdi mdi-fullscreen"></i>
                            </button>
                        </div>
				<!-- 购物车 -->
				<div class="dropdown d-inline-block">
					<button type="button" class="btn header-item noti-icon waves-effect">
						<a href="cart?action=viewcart"><i class="mdi mdi-weather-cloudy
" style="margin-top: 8px;"></i></a>
							<!-- {if count($CartShopData) != '0'}
							<span class="badge badge-danger badge-pill">{:count($CartShopData)}</span>
							{/if} -->
					</button>
				</div> 

				<!-- 消息 -->
		<div class="dropdown d-inline-block">
					
						<button type="button" class="btn header-item noti-icon waves-effect"><a href="message">
							<i class="mdi mdi-bell-outline"></i></a>
							{if $Setting.unread_num != '0'}
                                <span class="badge badge-danger badge-pill">{$Setting.unread_num}
							</span>
							{/if}	
						</button>
				
			</div>

				<!-- 个人中心 -->
				{if $Userinfo}
				<div class="dropdown d-inline-block">
					<button type="button" class="btn header-item waves-effect" id="page-header-user-dropdown"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
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
						<img src="{$gravatar}" alt="" class="img-fluid img-thumbnail rounded-circle avatar-sm">
							
					
						<span class="d-none d-xl-inline-block ml-1" key="t-henry">{$Userinfo.user.username}</span>
						<i class="mdi mdi-chevron-down d-none d-xl-inline-block"></i>
					
                         
					</button>
					<div class="dropdown-menu dropdown-menu-right">
				
				
				<!-- item-->
                                <a class="dropdown-item" href="details"><i class="mdi mdi-account-circle font-size-17 align-middle mr-1"></i> {$Lang.personal_information}</a>
                                <a class="dropdown-item" href="security"><i class="mdi mdi-wallet font-size-17 align-middle mr-1"></i> {$Lang.security_center}</a>
                                <a class="dropdown-item d-block" href="message"><i class="mdi mdi-settings font-size-17 align-middle mr-1"></i> {$Lang.message_center}</a>
                                <a class="dropdown-item" href="verified"><i class="mdi mdi-lock-open-outline font-size-17 align-middle mr-1"></i> {$Lang.real_name_authentications}</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item text-danger" href="logout"><i class="bx bx-power-off font-size-17 align-middle mr-1 text-danger"></i> {$Lang.log_out}</a>
                            </div>
                        </div>

                       
            
                    </div>
                </div>
				{else}
				<div class="pointer d-flex align-items-center">
					<a href="/login" class="text-dark">{$Lang.please_login}</a>
				</div>
				{/if}

			</div>
		</div>
	</header>

	{include file="includes/menu"}

	<div class="main-content">
		<div class="page-content">
			{if $TplName != 'clientarea'}
			{include file="includes/pageheader"}
			{/if}
			<div class="container-fluid">
				{/if}