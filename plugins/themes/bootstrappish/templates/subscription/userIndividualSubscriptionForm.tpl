{**
 * templates/subscription/userIndividualSubscriptionForm.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * User purchase individual subscription form
 *
 *}
{strip}
{assign var="pageTitle" value="user.subscriptions.purchaseIndividualSubscription"}
{assign var="pageId" value="user.subscriptions.userIndividualSubscriptionForm"}
{include file="common/header.tpl"}
{/strip}

<br/>

{if $subscriptionId}
<form method="post" id="subscriptionForm" action="{url op="payPurchaseSubscription" path="individual"|to_array:$subscriptionId}">
{else}
<form method="post" id="subscriptionForm" action="{url op="payPurchaseSubscription" path="individual"}">
{/if}

{include file="common/formErrors.tpl"}

<div class="table-responsive">
<table class="table table-striped" width="100%">
<tr valign="top">
	<td width="20%">{fieldLabel name="typeId" required="true" key="user.subscriptions.form.typeId"}</td>
	<td width="80%" class="value"><select name="typeId" id="typeId" class="selectMenu">
		{foreach from=$subscriptionTypes item=subscriptionType}
			<option value="{$subscriptionType->getTypeId()}"{if $typeId == $subscriptionType->getTypeId()} selected="selected"{/if}>{$subscriptionType->getSummaryString()|escape}</option>
		{/foreach}
	</select></td>
</tr>
<tr valign="top">
	<td>{fieldLabel name="membership" key="user.subscriptions.form.membership"}</td>
	<td class="value">
		<input type="text" name="membership" value="{$membership|escape}" id="membership" size="30" maxlength="40" class="textField" />
	</td>
</tr>
<tr valign="top">
	<td>&nbsp;</td>
	<td><p class="help-block">{translate key="user.subscriptions.form.membershipInstructions"}</p></td>
</tr>
</table>
</div>

<p><input type="submit" value="{translate key="common.continue"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url page="user" op="subscriptions" escape=false}'" /></p>

</form>

<p><p class="help-block">{translate key="common.requiredField"}</p></p>

{include file="common/footer.tpl"}

