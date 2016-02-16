{**
 * templates/about/journalSponsorship.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * About the Journal / Journal Sponsorship.
 *
 *}
{strip}
{assign var="pageTitle" value="about.journalSponsorship"}
{include file="common/header.tpl"}
{/strip}

<div class="col-md-12 mag-innert-left">
	{if not(empty($publisherNote) && empty($publisherInstitution))}
		<div id="publisher" class="col-md-12 contact-in">
			<h5>{translate key="common.publisher"}</h5>

			{if $publisherNote}<p class="para1">{$publisherNote|nl2br}</p>{/if}

			<p class="para1"><a target="_blank" href="{$publisherUrl}">{$publisherInstitution|escape}</a></p>
		</div>
		<div class="separator">&nbsp;</div>
	{/if}

	{if not (empty($sponsorNote) && empty($sponsors))}
		<div id="sponsors" class="col-md-12 contact-in">
			<h5>{translate key="about.sponsors"}</h5>

			{if $sponsorNote}<p class="para1">{$sponsorNote|nl2br}</p>{/if}
			<ul class="list-unstyled">
				{foreach from=$sponsors item=sponsor}
				{if $sponsor.url}
					<li><a target="_blank" href="{$sponsor.url|escape}">{$sponsor.institution|escape}</a></li>
				{else}
					<li>{$sponsor.institution|escape}</li>
				{/if}
				{/foreach}
			</ul>
		</div>
		<div class="separator">&nbsp;</div>
	{/if}

	{if !empty($contributorNote) || (!empty($contributors) && !empty($contributors[0].name))}
		<div id="contributors" class="col-md-12 contact-in">
			<h5>{translate key="about.contributors"}</h5>

			{if $contributorNote}<p class="para1">{$contributorNote|nl2br}</p>{/if}

			<ul class="list-unstyled">
				{foreach from=$contributors item=contributor}
				{if $contributor.name}
					{if $contributor.url}
						<li><a target="_blank" href="{$contributor.url|escape}">{$contributor.name|escape}</a></li>
					{else}
						<li>{$contributor.name|escape}</li>
					{/if}
				{/if}
				{/foreach}
			</ul>
		</div>
	{/if}
</div>

{include file="common/footer.tpl"}