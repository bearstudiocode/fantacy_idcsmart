
{include file="includes/tablestyle"}

{include file="includes/deleteConfirm"}
<style>
  .pb-md-36, .py-md-36 {
    padding-bottom: 9rem!important;
  }
  .pt-md-36, .py-md-36 {
    padding-top: 9rem!important;
  }
  .pb-md-30, .py-md-30 {
    padding-bottom: 7.5rem!important;
  }
  .pt-md-30, .py-md-30 {
    padding-top: 7.5rem!important;
  }
  .text-dark-50 {
    color: #7e8299!important;
  }
  .mb-10, .my-10 {
    margin-bottom: 2.5rem!important;
  }
  .border-right-md {
    border-right: 1px solid #ebedf3!important;
  }

  .pl-md-5, .px-md-5 {
    padding-left: 1.25rem!important;
  }

  .pb-9, .py-9 {
      padding-bottom: 2.25rem!important;
  }
  .pt-1, .py-1 {
      padding-top: .25rem!important;
  }
  .table.noborr thead th{
    border: none;
  }
  .box{
    width:100%;
    height: auto;
    background:#fff;
    border-radius:6px;
    padding: 1.25rem;
    font-size:.875rem;
  }
  .head-img {
    height:4.4rem;
  }
  .btnWidth{
    width: 7rem
  }
  .text-style{
    text-align: center;
    display: inline-block;
    font-weight: bold
  }
  .text-img-center{
    padding-top: 1.25rem
  }
</style>

<div class="box" id="pdfCentent">
  <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
    
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="invoice-title">
                                                {if !$Setting.web_logo_home}
                                                <h3>{$Setting.company_name}</h3>
                                                {else/}
                                                <img src="{$Setting.web_logo}" alt="logo" height="24" crossOrigin="Anonymous" />
                                                {/if}
                                                 {if $ViewBilling.detail.status == 'Paid'}
                                                <h4 class="float-right text-primary"><strong>{$Lang.paid}</strong></h4>
                                                 {elseif $ViewBilling.detail.status == 'Unpaid'}
                                                 <h4 class="float-right text-danger"><strong>{$Lang.unpaid}</strong></h4>
                                                 <p class="mb-0"><button class="btn btn-primary btnWidth" id="payamount" onclick="javascript: payamount({$Pay.invoiceid});">{$Lang.pay_immediately}</button></p>
                                                 {elseif $ViewBilling.detail.status == 'Cancelled'}
                                                 <h4 class="float-right text-primary"><strong>{$Lang.cancelled}</strong></h4>
                                                  {elseif $ViewBilling.detail.status == 'Refunded'}
                                                  <h4 class="float-right text-primary"><strong>{$Lang.refunded}</strong></h4>
                                                  {/if}
                                                    <h4 class="font-size-16"><strong># {$ViewBilling.detail.id}</strong></h4>
                                                    <h3 class="mt-0">
                                                        
                                                    </h3>
                                                </div>
                                                <hr>
    </header>
    <main>
      <div class="row">
        <div class="col-sm-6 text-sm-right order-sm-1"> <strong>收款方信息:</strong>
          <address>
            {$ViewBilling.payee}
          </address>
        </div>
        <div class="col-sm-6 order-sm-0"> <strong>支付方信息:</strong>
          <address>
            {$ViewBilling.detail.companyname}<br>
          姓名：{$ViewBilling.detail.username}<br>
          电话：{if $ViewBilling.detail.phonenumber == ""}-
                {else}{$ViewBilling.detail.phonenumber}
                {/if}
          </address>
        </div>
      </div>
      <div class="row">
        <div class="col-sm-6"> <strong>创建时间:</strong><br>
          <span> {$ViewBilling.detail.create_time|date="Y-m-d H:i:s"} </span> <br>
          <br>
        </div>
      </div>
       <div class="row">
                                            <div class="col-12">
                                                <div>
                                                   
                                                    <div class="">
                                                        <div class="table-responsive">
                                                            <table class="table">
                                                                <thead>
                                                                <tr>
                                                                
                                                                    <td><strong>账单详情</strong></td>
                                                                <td class="no-line"></td>
 
                                                                    <td class="text-center"><strong>类型</strong></td>
                                                                    <td class="text-right"><strong>金额</strong>
                                                                    </td>
                                                            
                                                                </tr>
                                                                </thead>
                                                                <tbody>
                                     
                                                                {foreach $ViewBilling.invoice_items as $item}
                                                                <tr>
                                                                 {foreach :explode("\n", $item.description) as $desc}
                                                                    <td>{$desc}</td>
                                                                    {/foreach}
                                                                    <td class="text-center">{$item.type_zh}</td>
                                                                    <td class="text-right">{$ViewBilling.currency.prefix}{$item.amount}{$ViewBilling.currency.suffix}</td>
                                                              
                                                                </tr>
                                                               {/foreach}
                                                              
                                                                <tr>
                                                                    <td class="no-line"></td>
                                                                    <td class="no-line"></td>
                                                                    <td class="no-line text-center">
                                                                        <strong>总计</strong></td>
                                                                    <td class="no-line text-right"><h4 class="m-0">{$ViewBilling.currency.prefix}{$Pay.total}{$ViewBilling.currency.suffix}</h4></td>
                                                                </tr>
                                                                </tbody>
                                                            </table>
                                                        </div>
        
                                                        
                                                </div>
        
                                            </div>
                                        </div> <!-- end row -->
        

      <br>
      {if $ViewBilling.detail.status == 'Paid' || $ViewBilling.detail.status == 'Refunded'}
      <div class="table-responsive d-print-none" style="min-height:auto;">
        <table class="table table-bordered">
          {if $ViewBilling.accounts}
          <thead>
            <tr>
              <td class="text-center"><strong>交易流水号</strong></td>
              <td class="text-center"><strong>金额</strong></td>
              <td class="text-center"><strong>支付方式</strong></td>
              <td class="text-center"><strong>付款时间</strong></td>
            </tr>
          </thead>
          <tbody>
            {foreach $ViewBilling.accounts as $var}
              <tr>
                <td class="text-center">{$var.trans_id}</td>
                <td class="text-center">{$ViewBilling.currency.prefix}{$var.amount_in}{$ViewBilling.currency.suffix}</td>
                <td class="text-center">{$var.gateway}</td>
                <td class="text-center">{$var.pay_time|date="Y-m-d H:i:s"}</td>
              </tr>
            {/foreach}
          </tbody>
          {/if}
        </table>
      </div>
      {/if}
    </main>
  <!-- Footer -->
  <footer class="text-center">
   
    <div class="d-print-none">
                                                            <div class="float-right">
                                                                <a href="javascript:window.print()" class="btn btn-success waves-effect waves-light"><i class="fa fa-print"></i> 打印账单</a>
                                                                <a href="#" class="btn btn-primary waves-effect waves-light pdfdownload"><i class="fa fa-download"></i> 下载账单PDF文件</a>
                                                            </div>
                                                        </div>
                                                  
  </footer>
  </div>
</div>

                                    </div>
                                </div>
                            </div> <!-- end col -->
                        </div></div>       </div> <!-- end col -->
                        </div> <!-- end row -->
{include file="includes/paymodal"}
<script src="{$Setting.web_url}/themes/clientarea/fantacy/assets/libs/html2canvas/html2canvas.min.js?v={$Ver}"></script>
<script src="{$Setting.web_url}/themes/clientarea/fantacy/assets/libs/jspdf/jspdf.umd.min.js?v={$Ver}"></script>
<script>
  /* 原HTML代码
  <div class="card card-custom position-relative overflow-hidden col-md-9" id="pdfCentent">
      <!--begin::Shape-->
      <div class="position-absolute opacity-30" style="left:0;z-index:1">
        <span class="svg-icon svg-icon-10x svg-logo-white">
          <!--begin::Svg Icon | path:/metronic/theme/html/demo1/dist/assets/media/svg/shapes/abstract-8.svg-->
          <svg xmlns="http://www.w3.org/2000/svg" width="176" height="165" viewBox="0 0 176 165" fill="none">
            <g clip-path="url(#clip0)">
              <path d="M-10.001 135.168C-10.001 151.643 3.87924 165.001 20.9985 165.001C38.1196 165.001 51.998 151.643 51.998 135.168C51.998 118.691 38.1196 105.335 20.9985 105.335C3.87924 105.335 -10.001 118.691 -10.001 135.168Z" fill="#AD84FF"></path>
              <path d="M28.749 64.3117C28.749 78.7296 40.8927 90.4163 55.8745 90.4163C70.8563 90.4163 83 78.7296 83 64.3117C83 49.8954 70.8563 38.207 55.8745 38.207C40.8927 38.207 28.749 49.8954 28.749 64.3117Z" fill="#AD84FF"></path>
              <path d="M82.9996 120.249C82.9996 144.964 103.819 165 129.501 165C155.181 165 176 144.964 176 120.249C176 95.5342 155.181 75.5 129.501 75.5C103.819 75.5 82.9996 95.5342 82.9996 120.249Z" fill="#AD84FF"></path>
              <path d="M98.4976 23.2928C98.4976 43.8887 115.848 60.5856 137.249 60.5856C158.65 60.5856 176 43.8887 176 23.2928C176 2.69692 158.65 -14 137.249 -14C115.848 -14 98.4976 2.69692 98.4976 23.2928Z" fill="#AD84FF"></path>
              <path d="M-10.0011 8.37466C-10.0011 20.7322 0.409554 30.7493 13.2503 30.7493C26.0911 30.7493 36.5 20.7322 36.5 8.37466C36.5 -3.98287 26.0911 -14 13.2503 -14C0.409554 -14 -10.0011 -3.98287 -10.0011 8.37466Z" fill="#AD84FF"></path>
              <path d="M-2.24881 82.9565C-2.24881 87.0757 1.22081 90.4147 5.50108 90.4147C9.78135 90.4147 13.251 87.0757 13.251 82.9565C13.251 78.839 9.78135 75.5 5.50108 75.5C1.22081 75.5 -2.24881 78.839 -2.24881 82.9565Z" fill="#AD84FF"></path>
              <path d="M55.8744 12.1044C55.8744 18.2841 61.0788 23.2926 67.5001 23.2926C73.9196 23.2926 79.124 18.2841 79.124 12.1044C79.124 5.92653 73.9196 0.917969 67.5001 0.917969C61.0788 0.917969 55.8744 5.92653 55.8744 12.1044Z" fill="#AD84FF"></path>
            </g>
          </svg>
          <!--end::Svg Icon-->
        </span>
      </div>
      <!--end::Shape-->
      <!--begin::Invoice header-->
      <div class="row justify-content-center py-8 px-8 py-md-36 px-md-0 bg-primary" style="position: relative;">
        <div class="col-md-9">
          <div class="d-flex justify-content-between align-items-md-center flex-column flex-md-row" >
            <div class="d-flex flex-column px-0 order-2 order-md-1" style="z-index:2">
              <span class="font-size-20 font-weight-bold text-white mb-3">{$ViewBilling.detail.username}</span>

              <span class="d-flex flex-column font-size-16 font-weight-bold text-white">
                <span>{$ViewBilling.detail.companyname}</span>
                <span>{$UserInfo.user.address1}</span>
              </span>
            </div>
            <h3 class="display-4 font-weight-bold text-white order-1 order-md-2">
            {if $Pay.PayStatus=='Paid'}
            {$Lang.paid}
            {else}
            {$Lang.unpaid}
            {/if}
            </h3>
          </div>
        </div>

        <i class="bx bx-cloud-download text-white fs-24 pdfdownload pointer" style="position: absolute;right: 20px;bottom: 20px;"></i>
      </div>
      
      <!-- 下载pdf -->
      <!-- <div class="text-right pt-4" style="min-height: 43px;">
        <span class="pdfdownload pointer">
          <i class="bx bx-cloud-download"></i>
          下载
        </span>
      </div> -->
      
      <!--end::Invoice header-->
      <div class="row justify-content-center py-8 px-8 py-md-30 px-md-0">
        <div class="col-md-9">
          <!--begin::Invoice body-->
          <div class="row pb-26">
            <div class="col-md-3 border-right-md pr-md-10 py-md-10">
              <!--begin::Invoice To-->
              <div class="text-dark-50 font-size-lg font-weight-bold mb-3">{$Lang.payment_to}:</div>
              <div class="font-size-lg font-weight-bold mb-10">{$ViewBilling.payee}</div>
              <!--end::Invoice To-->
              <!--begin::Invoice No-->
              <div class="text-dark-50 font-size-lg font-weight-bold mb-3">{$Lang.payment_method}:</div>
              <div class="font-size-lg font-weight-bold mb-10">{$ViewBilling.detail.payment_zh}</div>
              <!--end::Invoice No-->
              <!--begin::Invoice Date-->
              <div class="text-dark-50 font-size-lg font-weight-bold mb-3">{$Lang.billing_time}:</div>
              <div class="font-size-lg font-weight-bold">{if $ViewBilling.detail.paid_time}
              {$ViewBilling.detail.paid_time|date="Y-m-d H:i:s"}<br><br>
            {else}
              -
            {/if}</div>
              <!--end::Invoice Date-->
            </div>
            <div class="col-md-9 py-10 pl-md-10">
              <div class="table-responsive">
                <table class="table noborr">
                  <colgroup>
                    <col width="80px">
                    <col >
                    <col width="120px">
                  </colgroup>
                  <thead>
                    <tr>
                      <th class="pt-1 pb-9 pl-0 pl-md-5 font-weight-bolder text-muted font-size-lg text-uppercase">{$Lang.type}</th>
                      <th class="pt-1 pb-9 text-left font-weight-bolder text-muted font-size-lg text-uppercase">{$Lang.project}</th>
                      <th class="pt-1 pb-9 text-right font-weight-bolder text-muted font-size-lg text-uppercase">{$Lang.amount_money}</th>
                    </tr>
                  </thead>
                  <tbody>
                  {foreach $ViewBilling.invoice_items as $item}
                  <tr>
                      <td class="font-weight-bold pl-0 pl-md-5 pt-7 d-flex align-items-center">{$item.type_zh}</td>
                      <td class="text-left pt-7">
                      {foreach :explode("\n", $item.description) as $desc}
                        <div class="font-weight-bold">{$desc}</div>
                      {/foreach}</td>
                      <td class="text-right pt-7 font-weight-bold">{$ViewBilling.currency.prefix}{$item.amount}{$ViewBilling.currency.suffix}</td>
                  </tr>
                  {/foreach}
                  
                  </tbody>
                </table>
              </div>
            </div>
          </div>
          <!--end::Invoice body-->
          

          {if $ViewBilling.accounts}
          <div class="table-responsive mt-3">
              <table class="table table-bordered mb-0">

                  <thead>
                      <tr>
                          <th>{$Lang.transaction_date}</th>
                          <th>{$Lang.payment_method}</th>
                          <th>{$Lang.transaction_serial_number}</th>
                          <th>{$Lang.amount_money}</th>
                      </tr>
                  </thead>
                  <tbody>
                    {foreach $ViewBilling.accounts as $accounts}
                      <tr class="table-light">
                          <td>{$accounts.pay_time|date="Y-m-d H:i:s"}</td>
                          <td>{$accounts.gateway}</td>
                          <td>{if $accounts.trans_id}{$accounts.trans_id}{else}-{/if}</td>
                          <td>{$accounts.amount_in}</td>
                      </tr>
                    {/foreach}
                    
                  </tbody>
              </table>
          </div>
          {/if}
        </div>
      </div>


      
      
    </div>




	<div class="col-sm-3">
		<div class="card">
			<div class="card-body">
      
       <div id="pay-content">

        </div>
    </div>
		</div>	
	</div>
  */
</script>

<script>
  var _url = '{$Setting.web_url}';

  $(function() {
    $(document).on('click', '.pdfdownload', function () {
      let targetElement = document.getElementById('pdfCentent')
      let scrollHeight = targetElement.getBoundingClientRect().top + window.scrollY;
      window.scroll({
        top: scrollHeight
      });
      $(this).hide();
      $(".printicon").hide();
      setTimeout(function(){
        $(".pdfdownload").show();
        $(".printicon").show();
      }, 100);
      toastr.success('{$Lang.please_wait_while_building}...')
      html2canvas(document.getElementById('pdfCentent'), {
        allowTaint: true
      }).then(function (canvas) {
        let contentWidth = canvas.width
        let contentHeight = canvas.height
        let pageHeight = contentWidth / 592.28 * 841.89
        let leftHeight = contentHeight
        let position = 0
        let imgWidth = 595.28
        let imgHeight = 592.28 / contentWidth * contentHeight
        let pageData = canvas.toDataURL('image/jpeg', 1.0)
        let PDF = new jsPDF('', 'pt', 'a4')
        if (leftHeight < pageHeight) {
          PDF.addImage(pageData, 'JPEG', 0, 0, imgWidth, imgHeight)
        } else {
          while (leftHeight > 0) {
            PDF.addImage(pageData, 'JPEG', 0, position, imgWidth, imgHeight)
            leftHeight -= pageHeight
            position -= 841.89
            if (leftHeight > 0) {
              PDF.addPage()
            }
          }
        }
        PDF.save('{$Lang.bill}#{$Think.get.id}_' + new Date().getTime())
      })
    });
  })
</script>
<script>
  function getQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]);
    return null;
  }

  window.onload = function() {
    //来自购物车页面就自动唤醒支付窗口
    var wakeup = getQueryString("wakeup");
    if (wakeup == 1) {
        $("#payamount").click();
        var payStatus = '{$ViewBilling.detail.status}';
        if(payStatus == 'Paid'){
          setTimeout(function () {
            $('#pay .close').click();
            let invoiceid = '{$Pay.invoiceid}'
            $.post('{$Setting.web_url}/check_order', {id:'{$Pay.invoiceid}'},
                function(data){
                    if(data.status==1000){
                        $("#myLargeModalLabel").html("账单 - "+invoiceid);
                        if (data.data){
                            location.href = data.data
                        } else if ('{$ReturnUrl}') {
                            location.href = '{$ReturnUrl}'
                        } else if ('{$ViewBilling.detail.url}') { // 账单有回跳地址 优先处理
                            location.href = '{$ViewBilling.detail.url}'
                        } else if ('{$ViewBilling.invoice_items.0.hid}' == '0') {
                            location.href = 'service?groupid={$ViewBilling.invoice_items.0.groupid}'
                        } else {
                            location.href = 'servicedetail?id={$ViewBilling.invoice_items.0.hid}'
                        }
                    }

                }
            )
          },3000)
      }
    }
  }
</script>


<script src="{$Setting.web_url}/themes/clientarea/fantacy/assets/js/billing.js?v={$Ver}"></script>
