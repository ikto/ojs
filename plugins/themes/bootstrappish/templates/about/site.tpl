{**
 * templates/about/site.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * About the Journal site.
 *
 *}
{strip}
{assign var="pageTitle" value="about.aboutSite"}
{include file="common/header.tpl"}
{/strip}

{if !empty($about)}
	<div id="about" class="col-md-12 mag-innert-left">
	<p class="text">{$about|nl2br}</p>
	</div>
{/if}

<div id="journals" class="col-md-12 mag-innert-left">
<h3>{translate key="journal.journals"}</h3>
<ul class="stay">
{iterate from=journals item=journal}
	<li class="list-group-item"> <a href="{url journal=$journal->getPath() page="about" op="index"}">{$journal->getLocalizedTitle()|escape}</a></li>
{/iterate}
</ul>
</div>

<div id="journals" class="col-md-12 mag-innert-left">
<a href="{url op="aboutThisPublishingSystem"}">{translate key="about.aboutThisPublishingSystem"}</a>
</div>

{include file="common/footer.tpl"}

