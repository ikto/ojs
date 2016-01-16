{**
 * templates/subscription/userInstitutionalSubscriptionForm.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * User purchase institutional subscription form
 *
 *}
{strip}
{assign var="pageTitle" value="user.subscriptions.purchaseInstitutionalSubscription"}
{assign var="pageId" value="user.subscriptions.userInstitutionalSubscriptionForm"}
{include file="common/header.tpl"}
{/strip}

<br/>

{if $subscriptionId}
<form method="post" id="subscriptionForm" action="{url op="payPurchaseSubscription" path="institutional"|to_array:$subscriptionId}">
{else}
<form method="post" id="subscriptionForm" action="{url op="payPurchaseSubscription" path="institutional"}">
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
<tr valign="top">
	<td width="20%">{fieldLabel name="institutionName" required="true" key="user.subscriptions.form.institutionName"}</td>
	<td width="80%" class="value"><input type="text" name="institutionName" id="institutionName" value="{if $institutionName}{$institutionName|escape}{/if}" size="30" maxlength="90" class="textField" /></td>
</tr>
<tr valign="top">
	<td>{fieldLabel name="institutionMailingAddress" key="user.subscriptions.form.institutionMailingAddress"}</td>
	<td class="value"><textarea name="institutionMailingAddress" id="institutionMailingAddress" rows="3" cols="40" class="textArea">{$institutionMailingAddress|escape}</textarea></td>
</tr>
<tr valign="top">
	<td width="20%">{fieldLabel name="domain" key="user.subscriptions.form.domain"}</td>
	<td width="80%" class="value"><input type="text" name="domain" id="domain" value="{if $domain}{$domain|escape}{/if}" size="30" maxlength="90" class="textField" /></td>
</tr>
<tr valign="top">
	<td width="20%">&nbsp;</td>
	<td width="80%"><p class="help-block">{translate key="user.subscriptions.form.domainInstructions"}</p></td>
</tr>

</table>
</div>
<div class="table-responsive">
<table class="table table-striped" width="100%">
	{foreach name=ipRanges from=$ipRanges key=ipRangeIndex item=ipRange}
	<tr valign="top">
		{if $ipRangeIndex == 0}
		<td width="15%">{fieldLabel name="ipRanges" key="user.subscriptions.form.ipRange"}</td>
		{else}
		<td width="15%">&nbsp;</td>
		{/if}
		<td width="5%">{fieldLabel name="ipRanges[$ipRangeIndex]" key="user.subscriptions.form.ipRangeItem}</td>
		<td width="80%" class="value"><input type="text" name="ipRanges[{$ipRangeIndex|escape}]" id="ipRanges-{$ipRangeIndex|escape}" value="{$ipRange|escape}" size="30" maxlength="40" class="textField" />
		{if $smarty.foreach.ipRanges.total > 1}
		<input type="submit" name="delIpRange[{$ipRangeIndex|escape}]" value="{translate key="user.subscriptions.form.deleteIpRange"}" class="btn btn-warning" /></td>
		{else}
		</td>
		{/if}
	</tr>
	{foreachelse}
	<tr valign="top">
		<td width="15%">{fieldLabel name="ipRanges" key="user.subscriptions.form.ipRange"}</td>
		<td width="5%">{fieldLabel name="ipRanges[0]" key="user.subscriptions.form.ipRangeItem}</td>
		<td width="80%" class="value"><input type="text" name="ipRanges[0]" id="ipRanges-0" size="30" maxlength="40" class="textField" /></td>
	</tr>
	{/foreach}
	<tr valign="top">
		<td width="15%">&nbsp;</td>
		<td width="5%">&nbsp;</td>
		<td width="80%"><input type="submit" class="btn btn-success" name="addIpRange" value="{translate key="user.subscriptions.form.addIpRange"}" /></td>
	</tr>
	<tr valign="top">
		<td width="15%">&nbsp;</td>
		<td width="5%">&nbsp;</td>
		<td width="80%"><p class="help-block">{translate key="user.subscriptions.form.ipRangeInstructions"}</p></td>
	</tr>
</table>
</div>

<p><input type="submit" value="{translate key="common.continue"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url page="user" op="subscriptions" escape=false}'" /></p>

</form>

<p><p class="help-block">{translate key="common.requiredField"}</p></p>

{include file="common/footer.tpl"}

