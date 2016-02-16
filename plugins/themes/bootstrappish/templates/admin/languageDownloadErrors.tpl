{**
 * templates/admin/languageDownloadErrors.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display error messages associated with a failed language download.
 *
 *}
{strip}
{assign var="pageTitle" value="common.languages"}
{include file="common/header.tpl"}
{/strip}

<div class="col-md-12 mag-innert-left">
	<h3>{translate key="admin.languages.downloadLocales"}</h3>

	<p class="text">{translate key="admin.languages.downloadFailed"}</p>
	<ul class="stay">
		{foreach from=$errors item=error}<li>{$error}</li>{/foreach}
	</ul>

	<a href="{url op="languages"}" class="action">{translate key="common.languages"}</a>
</div>

{include file="common/footer.tpl"}