{**
 * templates/author/submit/complete.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * The submission process has been completed; notify the author.
 *
 *}
{strip}
{assign var="pageTitle" value="author.track"}
{include file="common/header.tpl"}
{/strip}

<div id="submissionComplete" class="col-md-12 mag-innert-left">
	<p class="help-block">{translate key="author.submit.submissionComplete" journalTitle=$journal->getLocalizedTitle()}</p>

	{if $canExpedite}
		{url|assign:"expediteUrl" op="expediteSubmission" articleId=$articleId}
		<p class="help-block">{translate key="author.submit.expedite" expediteUrl=$expediteUrl}</p>
	{/if}
	{if $paymentButtonsTemplate }
		{include file=$paymentButtonsTemplate orientation="vertical"}
	{/if}

	<p class="help-block">&#187; <a href="{url op="index"}">{translate key="author.track"}</a></p>
</div>

{include file="common/footer.tpl"}