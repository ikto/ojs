{**
 * templates/about/history.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * About the Journal => History
 *
 *}
{strip}
{assign var="pageTitle" value="about.history"}
{include file="common/header.tpl"}
{/strip}

<div class="col-md-12 mag-innert-left">
	<p class="text">
		{$history}
	</p>
</div>

{include file="common/footer.tpl"}