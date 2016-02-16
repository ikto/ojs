{**
 * templates/comment/comment.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Article reader comment editing
 *
 *}
{strip}
{assign var="pageTitle" value="comments.enterComment"}
{include file="common/header.tpl"}
{/strip}

<script type="text/javascript">
<!--
{literal}
function handleAnonymousCheckbox(theBox) {
	var submitForm = document.getElementById('submit');
	if (theBox.checked) {
		submitForm.posterName.disabled = false;
		submitForm.posterEmail.disabled = false;
		submitForm.posterName.value = "";
		submitForm.posterEmail.value = "";
		submitForm.posterName.focus();
	} else {
		submitForm.posterName.disabled = true;
		submitForm.posterEmail.disabled = true;
		{/literal}{if $isUserLoggedIn && ($enableComments == COMMENTS_ANONYMOUS || $enableComments == COMMENTS_UNAUTHENTICATED)}
		submitForm.posterName.value = "{$userName|escape}";
		submitForm.posterEmail.value = "{$userEmail|escape}";
		{/if}{literal}
	}
}
// -->
{/literal}
</script>

{include file="common/formErrors.tpl"}

{assign var=parentId value=$parentId|default:"0"}

<div id="commentForm" class="col-md-12 mag-innert-left">
	<form role="form" id="submit" action="{if $commentId}{url op="edit" path=$articleId|to_array:$galleyId:$commentId}{else}{url op="add" path=$articleId|to_array:$galleyId:$parentId:"save"}{/if}" method="post">
		<div class="table-responsive">
			<table class="table table-striped" width="100%">
				<tr valign="top">
					<td width="20%"><label class="control-label" for="posterName">{translate key="comments.name"}</label></td>
					<td class="value" width="80%"><div class="form-group"><input type="text" class="form-control" name="posterName" id="posterName" value="{$posterName|escape}" size="40" maxlength="90" /></div></td>
				</tr>
				<tr valign="top">
					<td><label class="control-label" for="posterEmail">{translate key="comments.email"}</label></td>
					<td class="value"><div class="form-group"><input type="text" class="form-control" name="posterEmail" id="posterEmail" value="{$posterEmail|escape}" size="40" maxlength="90" /></div></td>
				</tr>
				{if $isUserLoggedIn && ($enableComments == COMMENTS_ANONYMOUS || $enableComments == COMMENTS_UNAUTHENTICATED)}
					<tr valign="top">
						<td>&nbsp;</td>
						<td class="value">
							<div class="form-group">
								<input type="checkbox" name="anonymous" id="anonymous" onclick="handleAnonymousCheckbox(this)">
								<label class="control-label" for="anonymous">{translate key="comments.postAnonymously"}</label>
							</div>
						</td>
					</tr>
				{/if}
				<tr valign="top">
					<td><label class="control-label" for="title">{translate key="comments.title"}</label></td>
					<td class="value"><div class="form-group"><input type="text" class="form-control" name="title" id="title" value="{$title|escape}" size="60" maxlength="255" /></td>
				</tr>
				<tr valign="top">
					<td width="20%"><label class="control-label" for="commentBody">{translate key="comments.body"}</label></td>
					<td width="80%" class="value">
						<div class="form-group"><textarea class="form-control" name="body" id="commentBody" rows="5" cols="60">{$commentBody|escape}</textarea></div>
					</td>
				</tr>

				{if $captchaEnabled}
					<tr valign="top">
						{if $reCaptchaEnabled}
						<td valign="top">{fieldLabel name="recaptcha_challenge_field" required="true" key="common.captchaField"}</td>
						<td class="value">
							{$reCaptchaHtml}
						</td>
						{else}
						<td valign="top">{fieldLabel name="captcha" required="true" key="common.captchaField"}</td>
						<td class="value">
							<img class="img-responsive" src="{url page="user" op="viewCaptcha" path=$captchaId}" alt="{translate key="common.captchaField.altText"}" /><br />
							<p class="help-block">{translate key="common.captchaField.description"}</p><br />
							<div class="form-group"><input name="captcha" id="captcha" value="" size="20" maxlength="32" class="form-control" /></div>
							<input type="hidden" name="captchaId" value="{$captchaId|escape:"quoted"}" />
						</td>
						{/if}
					</tr>
				{/if}
			</table>
		</div>
		
		<p><input type="submit" value="{translate key="common.save"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="location.href='{url page="comment" op="view" path=$articleId|to_array:$galleyId:$parentId}';" /></p>
	</form>
</div>

{include file="common/footer.tpl"}