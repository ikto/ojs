{**
 * templates/subscription/individualSubscriptionForm.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Individual subscription form under journal management.
 *
 *}
{strip}
{assign var="pageCrumbTitle" value="$subscriptionTitle"}
{if $subscriptionId}
	{assign var="pageTitle" value="manager.subscriptions.edit"}
	{url|assign:"currentUrl" op="editSubscription" path="individual"|to_array:$subscriptionId userId=$userId}
{else}
	{assign var="pageTitle" value="manager.subscriptions.create"}
	{url|assign:"currentUrl" op="createSubscription" path="individual" userId=$userId}
{/if}
{assign var="pageId" value="manager.subscriptions.individualSubscriptionForm"}
{include file="common/header.tpl"}
{/strip}

<br/>

<form method="post" id="subscriptionForm" action="{url op="updateSubscription" path="individual"}">
{if $subscriptionId}
<input type="hidden" name="subscriptionId" value="{$subscriptionId|escape}" />
{/if}

{include file="common/formErrors.tpl"}

<div class="table-responsive">
<table class="table table-striped" width="100%">
{if count($formLocales) > 1}
	<tr valign="top">
		<td width="20%">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
		<td width="80%" class="value">
			{if $subscriptionId}
				{url|assign:"formUrl" op="editSubscription" path="individual"|to_array:$subscriptionId userId=$userId escape=false}
			{else}
				{url|assign:"formUrl" op="createSubscription" path="individual" escape=false}
			{/if}
			{form_language_chooser form="subscriptionForm" url=$formUrl}
			<p class="help-block">{translate key="form.formLanguage.description"}</p>
		</td>
	</tr>
{/if}
{include file="subscription/subscriptionForm.tpl"}

{* For new subscriptions, select end date for default subscription type *}
{if !$subscriptionId}
	<script type="text/javascript">
	{literal}
	<!--
	chooseEndDate();
	// -->
	{/literal}
	</script>
{/if}
</table>
</div>

<br />
<div class="separator"></div>
<br />

<div class="table-responsive">
<table class="table table-striped" width="100%">
<tr valign="top">
	<td width="20%">{fieldLabel name="userId" required="true" key="manager.subscriptions.form.userId"}</td>
	<td width="80%" class="value">
		{assign var=emailString value="$userFullName <$userEmail>"}
		{url|assign:"url" page="user" op="email" to=$emailString|to_array redirectUrl=$currentUrl}
		{$username|escape}&nbsp;&nbsp;{icon name="mail" url=$url}&nbsp;&nbsp;<a href="{if $subscriptionId}{url op="selectSubscriber" path="individual" subscriptionId=$subscriptionId}{else}{url op="selectSubscriber" path="individual"}{/if}" class="action">{translate key="common.select"}</a>
		<input type="hidden" name="userId" id="userId" value="{$userId|escape}"/>
	</td>
</tr>
{include file="subscription/subscriptionFormUser.tpl"}
</table>
</div>

<br />
<div class="separator"></div>
<br />

<div class="table-responsive">
<table class="table table-striped" width="100%">
<tr valign="top">
	<td width="20%">{fieldLabel name="notes" key="manager.subscriptions.form.notes"}</td>
	<td width="80%" class="value"><textarea name="notes" id="notes" cols="40" rows="6" class="textArea">{$notes|escape}</textarea></td>
</tr>
</table>
</div>

<p><input type="submit" value="{translate key="common.save"}" class="btn btn-success" /> {if not $subscriptionId}<input type="submit" name="createAnother" value="{translate key="manager.subscriptions.form.saveAndCreateAnother"}" class="btn btn-success" /> {/if}<input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url op="subscriptions" path="individual" escape=false}'" /></p>

</form>

<p><p class="help-block">{translate key="common.requiredField"}</p></p>

{include file="common/footer.tpl"}

