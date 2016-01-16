{**
 * templates/about/aboutThisPublishingSystem.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * About the Journal / About This Publishing System.
 *
 * TODO: Display the image describing the system.
 *
 *}
{strip}
{assign var="pageTitle" value="about.aboutThisPublishingSystem"}
{include file="common/header.tpl"}
{/strip}

<div class="col-md-12 mag-innert-left">
<p class="text">
{if $currentJournal}
	{translate key="about.aboutOJSJournal" ojsVersion=$ojsVersion}
{else}
	{translate key="about.aboutOJSSite" ojsVersion=$ojsVersion}
{/if}
</p>

<p class="text">
	<img class="img-responsive" src="{$baseUrl}/{$edProcessFile}" alt="{translate key="about.aboutThisPublishingSystem.altText"}" />
</p>
</div>

{include file="common/footer.tpl"}

