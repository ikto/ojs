{**
 * templates/editor/notifyUsers.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Editor's "Notify Users" email template form
 *
 *}
{strip}
{assign var="pageTitle" value="email.compose"}
{assign var="pageCrumbTitle" value="email.email"}
{include file="common/header.tpl"}
{/strip}

<div id="notifyUsers" class="col-md-12 mag-innert-left">
	<form role="form" method="post" action="{$formActionUrl}">
		<input type="hidden" name="continued" value="1"/>
		
		{if $hiddenFormParams}
			{foreach from=$hiddenFormParams item=hiddenFormParam key=key}
				<input type="hidden" name="{$key|escape}" value="{$hiddenFormParam|escape}" />
			{/foreach}
		{/if}

		{include file="common/formErrors.tpl"}

		{foreach from=$errorMessages item=message}
			{if !$notFirstMessage}
				{assign var=notFirstMessage value=1}
				<h4>{translate key="form.errorsOccurred"}</h4>
				<ul class="stay">
			{/if}
			{if $message.type == MAIL_ERROR_INVALID_EMAIL}
				{translate|assign:"message" key="email.invalid" email=$message.address}
				<li>{$message|escape}</li>
			{/if}
		{/foreach}

		{if $notFirstMessage}
			</ul>
			<br/>
		{/if}

		<div id="recipients" class="table-responsive">
			<h3>{translate key="email.recipients"}</h3>
			<table id="recipients" class="table table-striped" width="100%">
			<tr valign="top">
				<td><div class="form-group"><input type="radio" id="allUsers" name="whichUsers" value="allUsers"/></div></td>
				<td>
					<label class="control-label" for="allUsers">{translate key="editor.notifyUsers.allUsers" count=$allUsersCount|default:0}</label>
				</td>
			</tr>
			<tr valign="top">
				<td><div class="form-group"><input type="radio" id="allReaders" name="whichUsers" value="allReaders"/></div></td>
				<td>
					<label class="control-label" for="allReaders">{translate key="editor.notifyUsers.allReaders" count=$allReadersCount|default:0}</label>
				</td>
			</tr>
			<tr valign="top">
				<td><div class="form-group"><input type="radio" id="allAuthors" name="whichUsers" value="allAuthors"/></div></td>
				<td>
					<label class="control-label" for="allAuthors">{translate key="editor.notifyUsers.allAuthors" count=$allAuthorsCount|default:0}</label>
				</td>
			</tr>
			{if $currentJournal->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_SUBSCRIPTION}
				<tr valign="top">
					<td><div class="form-group"><input type="radio" id="allIndividualSubscribers" name="whichUsers" value="allIndividualSubscribers"/></div></td>
					<td>
						<label class="control-label" for="allIndividualSubscribers">{translate key="editor.notifyUsers.allIndividualSubscribers" count=$allIndividualSubscribersCount|default:0}</label>
					</td>
				</tr>
				<tr valign="top">
					<td><div class="form-group"><input type="radio" id="allInstitutionalSubscribers" name="whichUsers" value="allInstitutionalSubscribers"/></div></td>
					<td>
						<label class="control-label" for="allInstitutionalSubscribers">{translate key="editor.notifyUsers.allInstitutionalSubscribers" count=$allInstitutionalSubscribersCount|default:0}</label>
					</td>
				</tr>
			{/if}{* publishingMode is PUBLISHING_MODE_SUBSCRIPTION *}
			{if $senderEmail}
				<tr valign="top">
					<td><div class="form-group"><input type="checkbox" name="ccSelf" /></div></td>
					<td>
						{translate key="email.bccSender" address=$senderEmail|escape}
					</td>
				</tr>
			{/if}
			</table>
		</div>{* recipients *}

		<br/>

		<div id="issue" class="table-responsive">
			<h3>{translate key="issue.issue"}</h3>
			<table class="table table-striped" width="100%">
			<tr valign="top">
				<td width="5%">
					<div class="form-group"><input type="checkbox" name="includeToc" id="includeToc" value="1"/></div>
				</td>
				<td width="75%">
					<div class="form-group">
						<label class="control-label" for="includeToc">{translate key="editor.notifyUsers.includeToc"}</label>&nbsp;
						<select name="issue" id="issue" class="form-control">
							{iterate from=issues item=issue}
								<option {if $issue->getCurrent()}checked {/if}value="{$issue->getId()}">{$issue->getIssueIdentification()|strip_tags|truncate:40:"..."|escape}</option>
							{/iterate}
						</select>
					</div>
				</td>
			</tr>
			</table>
		</div>

		<br/>

		<div class="table-responsive">
			<table id="email" class="table table-striped" width="100%">
				<tr valign="top">
					<td>{translate key="email.from"}</td>
					<td class="value">{$from|escape}</td>
				</tr>
				<tr valign="top">
					<td width="20%">{fieldLabel name="subject" key="email.subject"}</td>
					<td width="80%" class="value"><div class="form-group"><input type="text" id="subject" name="subject" value="{$subject|escape}" size="60" maxlength="120" class="form-control" /></div></td>
				</tr>
				<tr valign="top">
					<td>{fieldLabel name="body" key="email.body"}</td>
					<td class="value"><div class="form-group"><textarea name="body" cols="60" rows="15" class="form-control">{$body|escape}</textarea></div></td>
				</tr>
			</table>
		</div>

		<p><input name="send" type="submit" value="{translate key="email.send"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="history.go(-1)" /></p>
	</form>
</div>

{include file="common/footer.tpl"}