{**
 * templates/user/registerSite.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Site registration.
 *
 *}
{strip}
{include file="common/header.tpl"}
{/strip}

<div id="journals" class="col-md-12 mag-innert-left">
	{iterate from=journals item=journal}
		{if !$notFirstJournal}
			<p class="help-block">{translate key="user.register.selectJournal"}:</p>
			<ul class="list-unstyled">
			{assign var=notFirstJournal value=1}
		{/if}
		<li class="list-group-item"><a target="_blank" href="{url journal=$journal->getPath() page="user" op="register"}">{$journal->getLocalizedTitle()|escape}</a></li>
	{/iterate}
	{if $journals->wasEmpty()}
		{translate key="user.register.noJournals"}
	{else}
		</ul>
	{/if}
</div>

{include file="common/footer.tpl"}