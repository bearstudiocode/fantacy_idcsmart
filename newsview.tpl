
<style>
    .newscontent img {
        width: 90%;
    height: 50%;
    }

    .newscontent p {
    word-wrap: break-word;
        white-space: normal;
    }

</style>

 <div class="card" style="border-radius:20px">
 <section class="pb-0 pb-5">
     
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-lg-10 col-xl-8">
            <div class="d-flex justify-content-between align-items-center mb-3">
              <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                  <li class="breadcrumb-item">
                    <a href="news">站点新闻</a>
                  </li>
                  <li class="breadcrumb-item">
                    <a>{$ViewAnnouncement.cate_name}</a>
                  </li>
                </ol>
              </nav>
              
            </div>
            <h1 class="text-center">{$ViewAnnouncement.title}</h1>
            <div class="">
      
              <div class="text-center">
                <div>作者:<a>{$ViewAnnouncement.author}</a>
                </div>
                <div class="text-small text-muted">{$ViewAnnouncement.push_time | date='Y-m-d H:i'}</div>
              </div>

            </div>
          </div>
        </div>
      </div>
    </section>
    <section class="p-0" data-reading-position>
   
      <div class="container">
        <div class="row justify-content-center position-relative">
          
        </div>
        <div class="row justify-content-center">
          <div class="col-xl-7 col-lg-8 col-md-10">
            <article class="article">
          <pre class="newscontent">
                                            {$ViewAnnouncement.content|raw}
                                            </pre>
              
             
            </article>
             <div
                                    class="mt-4 d-flex {if !$ViewAnnouncement.prev && $ViewAnnouncement.next}justify-content-end{else}justify-content-between{/if}">
                                    {if $ViewAnnouncement.prev}
                                    <a href="newsview?id={$ViewAnnouncement.prev.id}" class="btn btn-primary">上一篇: {$ViewAnnouncement.prev.title}</a>
                                    {/if}

                                    {if $ViewAnnouncement.next}
                                    <a href="newsview?id={$ViewAnnouncement.next.id}" class="btn btn-primary">下一篇: {$ViewAnnouncement.next.title}</a>
                                    {/if}
                                </div>
          </div>
             
        </div>
     
      </div> 
     
    </section>
    <br><br>
   </div>
     