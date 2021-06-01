
                        <div class="row align-items-center">
                            <div class="col-sm-6">
                                <div class="page-title-box">
                                    <h4 class="font-size-18">{$Title}</h4>
                                    
                                </div>
                            </div>
 </div>
 <div class="row">
                            <div class="col-md-12 col-xl-4">
                                <div style="height:100px;border-radius:10px" class="card mini-stat bg-primary text-white">
                                    <div class="card-body">
                                        <div class="mb-3">
                                            <div class="float-left mini-stat-img mr-4" style="height:auto">
                                                <img src="themes/clientarea/fantacy/assets/images/services-icon/01.png" alt="">
                                            </div>
                                            <h5 class="font-size-16 text-uppercase mt-0 text-white-50">{$Lang.number_of_products}</h5>
                                            <h4 class="font-weight-medium font-size-24">{$ClientArea.index.host}<small> {$Lang.per}</small></h4>
                                        
                                        </div>
                                       
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-md-12 col-xl-4">
                            <a href="billing"> 
                                <div style="height:100px;border-radius:10px" class="card mini-stat bg-primary text-white">
                                    <div class="card-body">
                                        <div class="mb-3">
                                            <div class="float-left mini-stat-img mr-4">
                                                <img src="themes/clientarea/fantacy/assets/images/services-icon/02.png" alt="">
                                            </div>
                                            <h5 class="font-size-16 text-uppercase mt-0 text-white-50">{$Lang.unpaid_order}</h5>
                                            <h4 class="font-weight-medium font-size-24">{$ClientArea.index.order_count}<small> {$Lang.per}</small></h4>
                                         
                                        </div>
                                        
                                    </div>
                                </div>
                                </a>
                            </div>
                            
                            <div class="col-md-12 col-xl-4">
                            <a href="supporttickets">
                                <div style="height:100px;border-radius:10px" class="card mini-stat bg-primary text-white">
                                    <div class="card-body">
                                        <div class="mb-3">
                                            <div class="float-left mini-stat-img mr-4">
                                                <img src="themes/clientarea/fantacy/assets/images/services-icon/03.png" alt="">
                                            </div>
                                            <h5 class="font-size-16 text-uppercase mt-0 text-white-50">{$Lang.pending_work_order}</h5>
                                            <h4 class="font-weight-medium font-size-24">{$ClientArea.index.ticket_count}<small> {$Lang.per}</small></h4>
                                    
                                        </div>
                                       
                                    </div>
                                </div>
                                </a>
                            </div>
                            
                        </div>
                        
                        
                        



                                         
<div class="row">
<div class="col-md-12 col-xl-4">

                                <div class="card directory-card" style="border-radius:10px">
                                    <div class="card-body">
                                    <img class="img-fluid rounded mr-2 mo-mb-2 col-md-12" alt="200x200" width="600" src="{$Setting.web_url}/themes/clientarea/fantacy/assets/images/aside_user_image.jpg">
                                        <div class="media">
                                          {php}
                                          $email = $Userinfo['user']['email'];
                                          $b=str_replace('@qq.com','',$email);
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
                                            <div class="media-body ml-3">
                                                <h5 class="text-primary font-size-18 mt-0 mb-1">{$Userinfo.user.username} [ID:{$Userinfo.user.id}]</h5>
                                                <p class="mb-1">{if !$Userinfo.user.client_group}{$Lang.member}{else/}{$Userinfo.user.client_group}{/if}</p>
                                                <p class="mb-1">{if !$Userinfo.user.email}{$Userinfo.user.phonenumber}{else/}{$Userinfo.user.email}{/if}</p>
                                                    <p class="mb-1"><a href="verified"><button type="button" class="btn btn-primary btn-sm waves-effect waves-light">{if $Userinfo.user.certifi.type == 'certifi_company' && $Userinfo.user.certifi.status == 1}{$Lang.companyverify}{/if}{if $Userinfo.user.certifi.type == 'certifi_person' && $Userinfo.user.certifi.status == 1}{$Lang.personverify}{/if}{if $Userinfo.user.certifi.status == 2}{$Lang.noverify}{/if}</button></a></p>
                                            </div>
                                        
                                            <ul class="list-unstyled social-links float-right">
                                                <li><a href="security" class="{if $Userinfo.user.certifi.status!=1}btn-secondary{else/}btn-primary{/if}"><i class="mdi mdi-card-bulleted-settings-outline"></i></a></li>
                                                <li><a href="security" class="{if !$Userinfo.user.phonenumber}btn-secondary{else/}btn-primary{/if}"><i class="mdi mdi-phone"></i></a></li>
                                                <li><a href="security" class="{if !$Userinfo.user.email}btn-secondary{else/}btn-primary{/if}"><i class="mdi mdi-at"></i></a></li>
                                            </ul>
                                          </div>
                         
                                    </div>
                              </div></div>
                              
         
                    

<div class="col-md-12 col-xl-4">
<div class="card" style="border-radius:10px">
                                   
                                    <div class="card-body">
                                    
                                        <h4 class="card-title mt-0"><i class="ti-bookmark"></i> {$Lang.creditnowtext}</h4><br>
                                        <p class="card-text"><h2>{$ClientArea.index.client.credit}</h2></p>
                                        
                                        {if $ClientArea.index.allow_recharge == '1'}
          <a href="{$Setting.web_url}/addfunds" class="btn btn-primary waves-effect waves-light">{$Lang.recharge}</a>
          {/if}<br><br>
                      <div class="">
                                            <div class="alert alert-primary mb-0" role="alert">
                                           <i class="fab fa-waze"></i>
                                                {$Lang.younowcan} <strong><a href="transaction">{$Lang.clickthis}</a></strong> {$Lang.viewallrecord}
 
                                            </div>
                                        </div>
                                    </div>
                         
                                </div> </div>
                                <div class="col-md-12 col-xl-4">
                                 <div class="card" style="border-radius:10px">
                       
                                    <div class="card-body">
                                   
                                        <h4 class="card-title mb-4"><i class="ti-ruler-alt-2
"></i> {$Lang.accountqk}</h4><br><br>

                                        <div class="row justify-content-center">
                                            <div class="col-sm-4">
                                                <div class="text-center">
                                                    <h5 class="mb-0 font-size-20">{$ClientArea.index.intotal}</h5>
                                                <p class="text-muted">{$Lang.consumption_this_month}</p>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div class="text-center">
                                                    <h5 class="mb-0 font-size-20">{$ClientArea.index.invoice_unpaid}</h5>
                                                    <p class="text-muted">{$Lang.nownopay}</p>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div class="text-center">
                                                    <h5 class="mb-0 font-size-20">{if $Userinfo.shd_allow_email_send == 1}{$Lang.isopen}{else/}{$Lang.noopen}{/if}</h5>
                                                <p class="text-muted">{$Lang.nowemailnotify}</p>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div class="text-center">
                                                    <h5 class="mb-0 font-size-20">{if $Userinfo.user.second_verify == 1}{$Lang.isopen}{else/}{$Lang.noopen}{/if}</h5>
                                                <p class="text-muted">{$Lang.secondverify}</p>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div class="text-center">
                                                    <h5 class="mb-0 font-size-20">{if $Userinfo.user.status == 1}{$Lang.isopen1}{else/}{$Lang.noopen1}{/if}</h5>
                                                <p class="text-muted">{$Lang.accountstatus}</p>
                                                </div>
                                            </div>
                                             <div class="col-sm-4">
                                                <div class="text-center">
                                                    <h5 class="mb-0 font-size-20">{$Userinfo.sale_name}</h5>
                                                <p class="text-muted">{$Lang.customerjl}</p>
                                                </div>
                                            </div>
                                        </div>
     
                                       <br>
        
                                    </div>
                                </div>
                              </div></div>
                            
                                 
                                   
<div class="row">

  <div class="col-md-12 col-xl-4">
    <div class="card card-body user-center_h300" style="border-radius:10px">

      <h4 class="card-title mt-0">{$Lang.products_launched_all}</h4>
      <div class="user-center_product_grid mt-3">
        {foreach $ClientArea.index.host_nav as $list}
        <a href="service?groupid={$list.id}" class="btn btn-light waves-effect">
          <span class="btn btn-primary btn-sm waves-effect waves-light">
            <i class="mdi mdi-server"></i>
            {$list.groupname}({$list.count})
          </span>
          
        </a>
        {/foreach}
      </div>
    </div>
  </div>
<!-- start：公告通知 -->
  <div class="col-md-12 col-xl-4">
    <div class="card card-body user-center_h300" style="border-radius:10px">
      <h4 class="mb-4 card-title d-flex justify-content-between">
        <span>{$Lang.announcement}</span>
        <a href="news" class="btn btn-primary btn-sm waves-effect">{$Lang.view_more}</a>
      </h4>
      <div class="user-center_notice h100p">
        <ul class="user-center_notice_ul pl-0">
          {if $ClientArea.index.news}
          {foreach $ClientArea.index.news as $list}
          <li class="user-center_notice_item">
            <span class="notice_item_time text-black-50">{$list.push_time|date="Y-m-d H:i"}</span>
            <a href="newsview?id={$list.id}" class="notice_item_title">{$list.title}</a>
          </li>
          {/foreach}
          {else}
          <tr>
            <td colspan="2">
              <div class="no-data">{$Lang.nothing}</div>
            </td>
          </tr>
          {/if}
        </ul>
      </div>
    </div>
  </div>
  
   <section class="col-md-12 col-xl-4">
    <div class="card card-body user-center_h300" style="border-radius:10px">
      <h4 class="mb-4 card-title d-flex justify-content-between">
        <span>{$Lang.affinformation}</span>
        <a href="affiliates" class="btn btn-primary btn-sm waves-effect">{$Lang.viewdetails}</a>
      </h4>
      <div class="user-center_notice h100p">
        <ul class="user-center_notice_ul pl-0">
<div class="text-center"><br>
          <button type="button" class="btn btn-primary btn-lg waves-effect waves-light">{$Lang.affstatus}:{if $ClientArea.aff_msg.affStatus == 1}{$Lang.isactive}{else/}{$Lang.noactive}{/if}</button><br><br>
                                            <button type="button" class="btn btn-secondary btn-lg waves-effect">{$Lang.affnum}{$ClientArea.aff_msg.affNum}</button></div>
        </ul>
      </div>
    </div>
  </section>
</div>

<div class="row">
                            <div class="col-xl-8">
                                <div class="card" style="border-radius:10px">
                                    <div class="card-body">
                                        <h4 class="card-title mb-4">{$Lang.myservers}</h4>
                                        <div class="table-responsive">
                                            <table class="table table-hover table-centered table-nowrap mb-0">
                                                <thead>
                                                    <tr>
                                                        <th scope="col">ID</th>
                                                        <th scope="col">{$Lang.status}</th>
                                                        <th scope="col">{$Lang.hostname}</th>
                                                        <th scope="col">{$Lang.expiredate}</th>
                                                        <th scope="col">{$Lang.thisbill}</th>
                                                        <th scope="col">{$Lang.ipaddress}</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                {foreach $ClientArea.hostlist as $vo}
                                                    <tr>
                                                        <th scope="row">{$vo.id}</th>
                                                        <td>
                                                            <div>
                                                         <span class="badge badge-success">{$vo.domainstatus_desc}</span>
                                                            </div>
                                                        </td>
                                                        <td><a href="servicedetail?id={$vo.id}">{$vo.productname}[{$vo.domain}]</a></td>
                                                        <td>{if $vo.nextduedate == 0}{$Lang.noexpire}{else/}{php}echo date("Y-m-d H:i",$vo['nextduedate']);{/php}{/if}</td>
                                                        <td>{$vo.price_desc}/{$vo.cycle_desc}</td>
                                                        <td>{if !$vo.deditatedip}{$Lang.null}{else/}{$vo.deditatedip}{/if}</td>
                                                      
                                                    </tr>
                                         {/foreach}
                                                </tbody>
                                            </table>
                                            
                                        </div>
                         
                                                 <div class="table-footer">
                  <div class="table-pagination">
                    <div class="table-pageinfo mr-2">
                      <span>{$Lang.gong} {$ClientArea.index.host} {$Lang.tiao}</span>
                      <span class="mx-2">
                        {$Lang.perpage}
                        <select name="limit" id="limitSel">
                          <option value="10" {if $ClientArea.limit==10}selected{/if}>10</option>
                          <option value="15" {if $ClientArea.limit==15}selected{/if}>15</option>
                          <option value="20" {if $ClientArea.limit==20}selected{/if}>20</option>
                          <option value="50" {if $ClientArea.limit==50}selected{/if}>50</option>
                          <option value="100" {if $ClientArea.limit==100}selected{/if}>100</option>
                        </select>
                        {$Lang.tiao}
                      </span>
                    </div>
                    <ul class="pagination pagination-sm">
                      {foreach $ClientArea.pages as $v}
                        <a href="clientarea?page={$v}&limit={$ClientArea.limit}">{$v}</a>
                      {/foreach}
                    </ul>
                  </div>
                </div>
                                        
                                    </div>
                                </div>
                            </div>
                           <div class="col-md-12 col-xl-4">
                                 <div class="card" style="border-radius:10px">
                                    <img class="card-img img-fluid" style="height:255px;border-radius:10px" src="{$Setting.web_url}/themes/clientarea/fantacy/assets/images/sec1.jpg" alt="Card image">
                                    <div class="card-img-overlay">
                                        <h1 class="text-white text-center">{$Lang.sectitle}</h1>
                                        <h4 class="card-text text-light text-center">{$Lang.sectext}</h4>
                                        <p class="card-text"><br>
                                            <div class="text-center"><a href="security" class="btn btn-primary btn-lg">{$Lang.go}</a></div>
                                        </p>
                                    </div>
                                </div></div>
                        <!-- end row -->


  
</div>

