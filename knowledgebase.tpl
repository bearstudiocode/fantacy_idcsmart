

 <section data-overlay>
      <div class="container">
        <div class="row mb-4">
       
          <div class="col-xl-9 col-lg-8">
           {if $HelpList}
          {foreach $HelpList as $help}
            <div class="pr-lg-4">
              <a href="./knowledgebaseview?id={$help.id}" class="card card-body justify-content-between bg-primary text-light"  style="border-radius:20px">
                <div class="d-flex justify-content-between mb-3">
                  <div class="text-small d-flex">
                    <div class="mr-2">
                      帮助
                    </div>
                    <span class="opacity-70">{$help.push_time|date='Y-m-d H:i'}</span>
                  </div>
                 
                </div>
                <div>
                  <h2>{$help.title}</h2>
                  
                </div>
              </a>
            </div>
          
{/foreach}
                   {include file="includes/tablefooter" url="knowledgebase"}
                   {else/}
                   
                   <div class="jumbotron jumbotron-fluid" style="background-color:white;border-radius:20px">
  <div class="container">
    <h3 class="display-4">很抱歉~</h3>
    <p class="lead">暂未搜索到任何结果，要不换个关键词试试？</p>
  </div>
</div>
                
                     {/if}
               
          </div>

        
 
         <div class="col-xl-3 col-lg-4">

    <div class="card" style="border-radius:20px">
      <div class="card-body p-4">
        <div class="search-box">
          <p class="text-muted">{$Lang.search}</p>
          <div class="table-search">
            <div class="row justify-content-end">
              <div class="col-sm-12">
                <div class="search-box">
                  <div class="position-relative">
                    <input type="text" class="form-control" id="searchInp" placeholder="按关键字搜索">
                    <i class="bx bx-search-alt search-icon" id="searchIcon"></i>
                  </div>
                </div>
              </div>
            </div>

          </div>
        </div>
        <hr class="my-4">
        <div>
          <p class="text-muted">{$Lang.classification}</p>
          <ul class="list-unstyled font-weight-medium">
            {foreach $HelpCate as $classify}
            <li><a href="./knowledgebase?cate={$classify.id}" class="text-muted py-2 d-block"><i
                  class="mdi mdi-chevron-right mr-1"></i> {$classify.title} <span
                  class="badge badge-soft-success badge-pill float-right ml-1 font-size-12">{$classify.count}
                </span></a></li>
            {/foreach}
          </ul>
        </div>
      </div>
    </div>
    <!-- end card -->
  </div>
</div>
      </div>
        </div>
      </div>
          
    </section>

<script>
  $('#searchInp').on('keydown', function (e) {
      if (e.keyCode == 13) {
        location.href = 'knowledgebase?keywords=' + $('#searchInp').val()
      }
    })
</script>