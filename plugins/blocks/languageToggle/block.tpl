{**
 * plugins/blocks/languageToggle/block.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site sidebar menu -- language toggle.
 *
 *}

{if $enableLanguageToggle}
<h4 class="side">{translate key="common.language"}</h4>
<div class="edit-pics" id="sidebarLanguageToggle">
	<script type="text/javascript">
		<!--
		function changeLanguage() {ldelim}
			var e = document.getElementById('languageSelect');
			var new_locale = e.options[e.selectedIndex].value;

			var redirect_url = '{url|escape:"javascript" page="user" op="setLocale" path="NEW_LOCALE" source=$smarty.server.REQUEST_URI escape=false}';
			redirect_url = redirect_url.replace("NEW_LOCALE", new_locale);

			window.location.href = redirect_url;
		{rdelim}
		//-->
	</script>
	<form action="#">
	<div class="table-responsive">
	<table class="table table-striped">
	<tr>
		<td><label class="control-label" for="languageSelect">{translate key="plugins.block.languageToggle.selectLabel"}</label></td>
		<td><select id="languageSelect" {if $isPostRequest}disabled="disabled" {/if}size="1" name="locale" class="selectMenu">{html_options options=$languageToggleLocales selected=$currentLocale}</select></td>
	</tr>
	<tr>
		<td><input type="submit" class="btn btn-success" value="{translate key='form.submit'}" onclick="changeLanguage(); return false;" /></td>
	</tr>
	</table>
	</div>
	</form>
</div>
{/if}
