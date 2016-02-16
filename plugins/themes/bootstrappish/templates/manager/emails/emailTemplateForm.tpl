{**
 * templates/manager/emails/emailTemplateForm.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Basic journal settings under site administration.
 *
 *}
{strip}
{if !$isNewTemplate}
	{assign var="pageTitle" value="manager.emails.editEmail"}
{else}
	{assign var="pageTitle" value="manager.emails.createEmail"}
{/if}
{include file="common/header.tpl"}
{/strip}

<div id="emailTemplateForm" class="col-md-12 mag-innert-left">
	<form role="form" method="post" action="{url op="updateEmail"}">
		<input type="hidden" name="emailId" value="{$emailId|escape}" />
		<input type="hidden" name="journalId" value="{$journalId|escape}" />
		
		{if !$isNewTemplate}
			<input type="hidden" name="emailKey" value="{$emailKey|escape}" />
		{/if}

		{if $description}
			<p class="help-block">{$description|escape}</p>
		{/if}

		<br/>

		{include file="common/formErrors.tpl"}

		<div class="table-responsive">
			<table class="table table-striped" width="100%">
				{if $isNewTemplate}
					<tr valign="top">
						<td width="20%">{fieldLabel name="emailKey" key="manager.emails.emailKey"}</td>
						<td width="80%" class="value"><div class="form-group"><input type="text" name="emailKey" value="{$emailKey|escape}" id="emailKey" size="20" maxlength="120" class="form-control" /></div><br/>&nbsp;</td>
					</tr>
				{/if}

				{foreach from=$supportedLocales item=localeName key=localeKey}
					<tr valign="top">
						<td colspan="2">
							<h3>{translate key="manager.emails.emailTemplate"} ({$localeName|escape})</h3>
						</td>
					</tr>

					<tr valign="top">
						<td width="20%">{fieldLabel name="subject-$localeKey" key="email.subject"}</td>
						<td width="80%" class="value"><div class="form-group"><input type="text" name="subject[{$localeKey|escape}]" id="subject-{$localeKey|escape}" value="{$subject.$localeKey|escape}" size="70" maxlength="120" class="form-control" /></div></td>
					</tr>
					<tr valign="top">
						<td>{fieldLabel name="body-$localeKey" key="email.body"}</td>
						<td class="value"><div class="form-group"><textarea name="body[{$localeKey|escape}]" id="body-{$localeKey|escape}" cols="70" rows="20" class="form-control">{$body.$localeKey|escape}</textarea></div></td>
					</tr>
				{foreachelse}
					<tr valign="top">
						<td colspan="2">
							<h3>{translate key="manager.emails.emailTemplate"}</h3>
						</td>
					</tr>

					<tr valign="top">
						<td width="20%">{fieldLabel name="subject-$currentLocale" key="email.subject"}</td>
						<td width="80%" class="value"><div class="form-group"><input type="text" name="subject[{$currentLocale|escape}]" id="subject-{$currentLocale|escape}" value="{$subject.$currentLocale|escape}" size="70" maxlength="120" class="form-control" /></div></td>
					</tr>
					<tr valign="top">
						<td>{fieldLabel name="body-$currentLocale" key="email.body"}</td>
						<td class="value"><div class="form-group"><textarea name="body[{$currentLocale|escape}]" id="body-{$currentLocale|escape}" cols="70" rows="20" class="form-control">{$body.$currentLocale|escape}</textarea></div></td>
					</tr>
				{/foreach}
			</table>
		</div>

		{if $canDisable}
			<p><div class="form-group"><input type="checkbox" name="enabled" id="emailEnabled" value="1"{if $enabled} checked="checked"{/if} /> <label class="control-label" for="emailEnabled">{translate key="manager.emails.enabled"}</label></div></p>
		{/if}

		<p><input type="submit" value="{translate key="common.save"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url op="emails" escape=false}'" /> <input type="reset" class="btn btn-warning" /></p>
	</form>
</div>

{include file="common/footer.tpl"}