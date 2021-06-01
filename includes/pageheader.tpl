




<div class="container-fluid">
    <!-- start page title -->
    <div class="row">
        <div class="col-12">
            <div class="page-title-box d-flex align-items-center justify-content-between">
                {if $Title == '账单内页'}
                <h4 class="mb-0 font-size-18">账单 - {$Get.id}</h4>
                {else}
                <h4 class="mb-0 font-size-18">{$Title}</h4>
                {/if}
                <div class="page-title-right">
	                {if !$ShowBreadcrumb}
                    {include file="includes/breadcrumb"}
                    {/if}
                </div>

            </div>
        </div>
    </div>
    <!-- end page title -->    
</div>