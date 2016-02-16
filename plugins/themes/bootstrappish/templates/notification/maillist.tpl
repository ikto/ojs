{**
 * templates/notification/maillist.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Displays the notification settings page and unchecks  
 *
 *}
{strip}
{assign var="pageTitle" value="notification.mailList"}
{include file="common/header.tpl"}
{/strip}

<p class="help-block">{translate key="notification.mailListDescription"}</p>

{if $isError}
	<p>
		<span class="help-block">{translate key="form.errorsOccurred"}:</span>
		<ul class="stay">
			{foreach key=field item=message from=$errors}
				<li>{$message}</li>
			{/foreach}
		</ul>
	</p>
{/if}

{if $success}
	<p><span class="help-block">{translate key="$success"}</span></p>
{/if}

<form role="form" id="notificationSettings" method="post" action="{url op="saveSubscribeMailList"}">
	<div class="table-responsive">
		<table class="table table-striped" width="100%">
			<tr valign="top">
				<td width="5%">{fieldLabel name="email" key="user.email"}</td>
				<td class="value" width="45%"><div class="form-group"><input type="text" id="email" name="email" size="30" maxlength="90" class="form-control" /></div></td>
			</tr>
			<tr valign="top">
				<td width="5%">{fieldLabel name="confirmEmail" key="user.confirmEmail"}</td>
				<td class="value" width="45%"><div class="form-group"><input type="text" id="confirmEmail" name="confirmEmail" size="30" maxlength="90" class="form-control" /></div></td>
			</tr>
			{if $captchaEnabled}
				<tr>
					<td valign="top">{fieldLabel name="captcha" required="true" key="common.captchaField"}</td>
					<td class="value">
						<img class="img-responsive" src="{url page="user" op="viewCaptcha" path=$captchaId}" alt="{translate key="common.captchaField.altText"}" /><br />
						<p class="help-block">{translate key="common.captchaField.description"}</p><br />
						<div class="form-group"><input name="captcha" id="captcha" value="" size="20" maxlength="32" class="form-control" /></div>
						<input type="hidden" name="captchaId" value="{$captchaId|escape:"quoted"}" />
					</td>
				</tr>
			{/if}{* $captchaEnabled *}
			<tr valign="top">
				<td width="5%">&nbsp;</td>
				<td><p><input type="submit" value="{translate key="form.submit"}" class="btn btn-success" /></p></td>
			</tr>
		</table>
	</div>
</form>

<h5 style="margin-left:10%">{translate key="notification.mailList.register"}</h5>
<ul class="stay" style="margin-left:10%">
	{if $settings.allowRegReviewer}
		{url|assign:"url" page="user" op="register"}
		<li>{translate key="notification.mailList.review" reviewUrl=$url} </li>
	{/if}
	{if $settings.allowRegAuthor}
		{url|assign:"url" page="information" op="authors"}
		<li>{translate key="notification.mailList.submit" submitUrl=$url} </li>
	{/if}
	{if $settings.subscriptionsEnabled}
		{url|assign:"url" page="user" op="register"}
		<li>{translate key="notification.mailList.protectedContent" subscribeUrl=$url}
	{/if}
	<li><a href="{url page="about" op="submissions" anchor="privacyStatement"}">{translate key="about.privacyStatement"}</a></li>
<ul class="stay">

</form>

{include file="common/footer.tpl"}