{**
 * templates/index/site.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Site index.
 *
 *}
{strip}
{if $siteTitle}
	{assign var="pageTitleTranslated" value=$siteTitle}
{/if}
{include file="common/header.tpl"}
{/strip}

<br />

{if $intro}
	<div class="col-md-12 mag-innert-left">
		{$intro|nl2br}
	</div>
{/if}

<a name="journals"></a>

{if $useAlphalist}
	<p>{foreach from=$alphaList item=letter}<a href="{url searchInitial=$letter sort="title"}">{if $letter == $searchInitial}<strong>{$letter|escape}</strong>{else}{$letter|escape}{/if}</a> {/foreach}<a href="{url}">{if $searchInitial==''}<strong>{translate key="common.all"}</strong>{else}{translate key="common.all"}{/if}</a></p>
{/if}

{iterate from=journals item=journal}
	<div class="col-md-12 mag-innert-left">
		{if $site->getSetting('showThumbnail')}
			{assign var="displayJournalThumbnail" value=$journal->getLocalizedSetting('journalThumbnail')}
			{if $displayJournalThumbnail && is_array($displayJournalThumbnail)}
				{assign var="altText" value=$journal->getLocalizedSetting('journalThumbnailAltText')}
				<div class="col-md-12 mag-innert-left"><a href="{url journal=$journal->getPath()}" class="action"><img class="img-responsive" src="{$journalFilesPath}{$journal->getId()}/{$displayJournalThumbnail.uploadName|escape:"url"}" {if $altText != ''}alt="{$altText|escape}"{else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if} /></a></div>
			{/if}
		{/if}
		{if $site->getSetting('showTitle')}
			<h3>{$journal->getLocalizedTitle()|escape}</h3>
		{/if}
		{if $site->getSetting('showDescription')}
			{if $journal->getLocalizedDescription()}
				<p>{$journal->getLocalizedDescription()|nl2br}</p>
			{/if}
		{/if}
		<br/>
		<p><a target="_blank" href="{url journal=$journal->getPath()}" class="action">{translate key="site.journalView"}</a> | <a target="_blank" href="{url journal=$journal->getPath() page="issue" op="current"}" class="action">{translate key="site.journalCurrent"}</a> | <a target="_blank" href="{url journal=$journal->getPath() page="user" op="register"}" class="action">{translate key="site.journalRegister"}</a></p>
	</div>
{/iterate}

{if $journals->wasEmpty()}
	{translate key="site.noJournals"}
{/if}

<div id="journalListPageInfo" class="col-md-12 mag-innert-left">{page_info iterator=$journals}</div>
<div id="journalListPageLinks" class="col-md-12 mag-innert-left">{page_links anchor="journals" name="journals" iterator=$journals}</div>

<script type="text/javascript">
{literal}
	$('#journalListPageLinks a, #journalListPageLinks strong').addClass('journals-link');
{/literal}
</script>

{include file="common/footer.tpl"}