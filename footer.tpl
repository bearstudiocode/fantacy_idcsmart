{if $TplName != 'login' && $TplName != 'register' && $TplName != 'pwreset' && $TplName != 'bind'}
</div>
</div>
</div>
  
<footer class="footer">
	<div class="container-fluid">
		<div class="row">
			<div class="col-12">
				&copy; <script>document.write(new Date().getFullYear())</script> {$Setting.company_name}.
			</div>
			<div class="col-12">
				<div class="text-sm-right d-none d-sm-block">
					
				</div>
			</div>
		</div>
	</div>
</footer>
{/if}
<script src="{$Setting.web_url}/themes/clientarea/fantacy/assets/js/app.js?v={$Ver}"></script>

</body>

</html>