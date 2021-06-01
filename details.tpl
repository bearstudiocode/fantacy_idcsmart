{if $ErrorMsg}
{include file="error/alert" value="$ErrorMsg"}
{/if}

{if $SuccessMsg}
{include file="error/notifications" value="$SuccessMsg" url=""}
{/if}



                      
                                             
      
                                <div class="card">
                                    <div class="card-body">

                            
                                 <form method="post" id="form-horizontal" class="needs-validation" novalidate>
                                       
                                            <h3>{$Lang.contact_information}</h3>
                                            <fieldset>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label for="email" class="col-lg-3 col-form-label">{$Lang.email_address}</label>
                                                            <div class="col-lg-9">
                                                                <input id="email" name="email" type="text" class="form-control" value="{$Userinfo.user.email}" readonly>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label for="phone" class="col-lg-3 col-form-label">{$Lang.phone_number}</label>
                                                            <div class="col-lg-9">
                                                                <input id="phone" name="phone" type="text" class="form-control" value="{$Userinfo.user.phonenumber}" readonly>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label for="qqnumber" class="col-lg-3 col-form-label">{$Lang.qq_number}</label>
                                                            <div class="col-lg-9">
                                                                <input id="qqnumber" name="qq" type="text" data-parsley-type="number" class="form-control" value="{$Userinfo.user.qq}" oninput="value=value.replace(/[^\d]/g,'')">
                                                            </div>
                                                        </div>
                                                    </div>
                                                   
                                            </fieldset>
                                            <h3>{$Lang.details}</h3>
                                            <fieldset>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label for="realname" class="col-lg-3 col-form-label">{$Lang.real_name}</label>
                                                            <div class="col-lg-9">
                                                                <input id="realname" name="username" type="text" class="form-control" value="{$Userinfo.user.username}" required />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label for="companyname" class="col-lg-3 col-form-label">{$Lang.corporate_name}</label>
                                                            <div class="col-lg-9">
                                                                <input type="text" class="form-control" name="companyname" value="{$Userinfo.user.companyname}"
              placeholder="{$Lang.please_enter_company_name}">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label for="country" class="col-lg-3 col-form-label">{$Lang.country}</label>
                                                            <div class="col-lg-9">
                                                                <select class="form-control" name="country">
              {foreach $Details.areas.country as $country}
              <option {if $country.name==$Userinfo.user.country}selected{/if} value="{$country.name}">{$country.name}{if $country.name=='台湾'}(中国){/if}</option>
              {/foreach}
            </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label for="province" class="col-lg-3 col-form-label">{$Lang.province}</label>
                                                            <div class="col-lg-9">
                                                                <input type="text" class="form-control" name="province" value="{$Userinfo.user.province}">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
        
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label for="city" class="col-lg-3 col-form-label">{$Lang.city}</label>
                                                            <div class="col-lg-9">
                                                                <input type="text" class="form-control" name="city" value="{$Userinfo.user.city}">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label for="region" class="col-lg-3 col-form-label">{$Lang.region}</label>
                                                            <div class="col-lg-9">
                                                                <input type="text" class="form-control" name="region" value="{$Userinfo.user.region}">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                             
                                             <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label for="address1" class="col-lg-3 col-form-label">{$Lang.address}</label>
                                                            <div class="col-lg-9">
                                                                <input type="text" class="form-control" name="address1" value="{$Userinfo.user.address1}">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                            </fieldset>
                                            <h3>{$Lang.other_information}</h3>
                                            <fieldset>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label for="defaultgateway" class="col-lg-3 col-form-label">{$Lang.default_payment}</label>
                                                            <div class="col-lg-9">
                                                                {if $Userinfo.gateways}
            <select class="form-control" name="defaultgateway">
              {foreach $Userinfo.gateways as $gateway}
              <option value="{$gateway.name}" {if $Userinfo.user.defaultgateway==$gateway.name}selected{/if}>
                {$gateway.title}</option>
              {/foreach}
            </select>
            {/if}
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                 
                                              {foreach $Userinfo.customs as $custom}
                             
        <div class="col-md-6">
          <div class="form-group row" data-order="{$custom.sortorder}">
            <label for="formrow-firstname-input" class="col-lg-3 col-form-label">{$custom.fieldname}</label>
            {if $custom.fieldtype == 'dropdown'}
            <select class="form-control" name="custom[{$custom.id}]">
              {foreach :explode(",",$custom.fieldoptions) as $field}
              <option {if $field==$custom.value}selected{/if}>{$field}</option>
              {/foreach}
            </select>
            {elseif $custom.fieldtype == 'text'}
            <div class="col-lg-9">
            <input type="text" class="form-control" name="custom[{$custom.id}]" value="{$custom.value}"
              placeholder="{$custom.description}" {if $custom.required}required{/if} />
            {elseif $custom.fieldtype == 'password'}
            <input type="password" class="form-control" name="custom[{$custom.id}]" value="{$custom.value}"
              placeholder="{$custom.description}" {if $custom.required}required{/if} />
            {elseif $custom.fieldtype == 'link'}
            <input type="text" class="form-control" name="custom[{$custom.id}]" value="{$custom.value}"
              placeholder="{$custom.description}" {if $custom.required}required{/if} />
            {elseif $custom.fieldtype == 'tickbox'}
            <div class="custom-control custom-checkbox">
              <input type="checkbox" class="custom-control-input" id="custom[{$custom.id}]" name="custom[{$custom.id}]">
              <label class="custom-control-label" for="custom[{$custom.id}]">{$custom.description}</label>
            </div>
            {elseif $custom.fieldtype == 'textarea'}
            <textarea class="form-control" name="custom[{$custom.id}]" rows="5"
              placeholder="{$custom.description}">{$custom.value}</textarea>
            {/if}
          </div>
        </div></div>
        {/foreach}
                                          </fieldset>
                                            <h3>营销信息</h3>
                                            <fieldset>
                                                <div class="p-3">
                                                <label for="formrow-firstname-input">{$Lang.marketing_information}</label>
                                                    <div class="custom-control custom-checkbox">
                                                        <input type="checkbox" class="custom-control-input" id="marketing_emails_opt_in"
                name="marketing_emails_opt_in" value="1" {if $Userinfo.user.marketing_emails_opt_in==1}
                checked="checked" {/if}>
                                                        <label class="custom-control-label" for="marketing_emails_opt_in">{$Lang.accept_marketing_information}</label>
                                                    </div>
                                                </div>
                                            </fieldset>
           
            <button type="submit" class="btn btn-primary w-xl submitBtn">{$Lang.submit}</button>

        
        
                                    </div>
                                </div>
          
                                 </form>   
                            </div>
                        </div>
                        <!-- end row -->

        
                 <div class="rightbar-overlay"></div>

                <!-- Right bar overlay-->
       

        <!-- JAVASCRIPT -->
      