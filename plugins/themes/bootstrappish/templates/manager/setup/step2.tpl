{**
 * templates/manager/setup/step2.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Step 2 of journal setup.
 *
 *}
{assign var="pageTitle" value="manager.setup.journalPolicies"}
{include file="manager/setup/setupHeader.tpl"}

<form role="form" id="setupForm" method="post" action="{url op="saveSetup" path="2"}">
	
	{include file="common/formErrors.tpl"}

	{if count($formLocales) > 1}
		<div id="locales" class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="20%">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
					<td width="80%" class="value">
						{url|assign:"setupFormUrl" op="setup" path="2" escape=false}
						{form_language_chooser form="setupForm" url=$setupFormUrl}
						<p class="help-block">{translate key="form.formLanguage.description"}</p>
					</td>
				</tr>
			</table>
		</div>
	{/if}
	
	<div id="focusAndScopeDescription" class="col-md-12 mag-innert-left">
		<h3>2.1 {translate key="manager.setup.focusAndScopeOfJournal"}</h3>
		<p class="help-block">{translate key="manager.setup.focusAndScopeDescription"}</p>
		
		<p>
			<div class="form-group"><textarea name="focusScopeDesc[{$formLocale|escape}]" id="focusScopeDesc" rows="12" cols="60" class="form-control">{$focusScopeDesc[$formLocale]|escape}</textarea></div>
		</p>
	</div>

	<div class="separator"></div>

	<div id="peerReviewPolicy" class="col-md-12 mag-innert-left">
		<h3>2.2 {translate key="manager.setup.peerReviewPolicy"}</h3>
	
		<div id="peerReviewDescription">
			<p class="help-block">{translate key="manager.setup.peerReviewDescription"}</p>
			<h4>{translate key="manager.setup.reviewPolicy"}</h4>

			<p><div class="form-group"><textarea name="reviewPolicy[{$formLocale|escape}]" id="reviewPolicy" rows="12" cols="60" class="form-control">{$reviewPolicy[$formLocale]|escape}</textarea></div></p>
		</div>
		
		<div id="reviewGuidelinesInfo">
			<h4>{translate key="manager.setup.reviewGuidelines"}</h4>
			{url|assign:"reviewFormsUrl" op="reviewForms"}
			<p class="help-block">{translate key="manager.setup.reviewGuidelinesDescription" reviewFormsUrl=$reviewFormsUrl}</p>

			<p><div class="form-group"><textarea name="reviewGuidelines[{$formLocale|escape}]" id="reviewGuidelines" rows="12" cols="60" class="form-control">{$reviewGuidelines[$formLocale]|escape}</textarea></div></p>
		</div>
	
		<div id="reviewProcess">
			<h4>{translate key="manager.setup.reviewProcess"}</h4>
			<p class="help-block">{translate key="manager.setup.reviewProcessDescription"}</p>

			<div class="table-responsive">
				<table width="100%" class="table table-striped">
					<tr valign="top">
						<td width="5%" align="right">
							<div class="form-group"><input type="radio" name="mailSubmissionsToReviewers" id="mailSubmissionsToReviewers-0" value="0"{if not $mailSubmissionsToReviewers} checked="checked"{/if} /></div>
						</td>
						<td width="95%" class="value">
							<label class="control-label" for="mailSubmissionsToReviewers-0"><strong>{translate key="manager.setup.reviewProcessStandard"}</strong></label>
							<br />
							<p class="help-block">{translate key="manager.setup.reviewProcessStandardDescription"}</p>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="separator">&nbsp;</td>
					</tr>
					<tr valign="top">
						<td width="5%" align="right">
							<div class="form-group"><input type="radio" name="mailSubmissionsToReviewers" id="mailSubmissionsToReviewers-1" value="1"{if $mailSubmissionsToReviewers} checked="checked"{/if} /></div>
						</td>
						<td width="95%" class="value">
							<label class="control-label" for="mailSubmissionsToReviewers-1"><strong>{translate key="manager.setup.reviewProcessEmail"}</strong></label>
							<br />
							<p class="help-block">{translate key="manager.setup.reviewProcessEmailDescription"}</p>
						</td>
					</tr>
				</table>
			</div>
		</div>
	
		<div id="reviewOptions">
			<h4>{translate key="manager.setup.reviewOptions"}</h4>

			<script type="text/javascript">
				{literal}
				<!--
					function toggleAllowSetInviteReminder(form) {
						form.numDaysBeforeInviteReminder.disabled = !form.numDaysBeforeInviteReminder.disabled;
					}
					function toggleAllowSetSubmitReminder(form) {
						form.numDaysBeforeSubmitReminder.disabled = !form.numDaysBeforeSubmitReminder.disabled;
					}
				// -->
				{/literal}
			</script>

			<p>
				<strong>{translate key="manager.setup.reviewOptions.reviewTime"}</strong><br/>
				<p class="help-block">{translate key="manager.setup.reviewOptions.numWeeksPerReview"}:</p> <div class="form-group"><input type="text" name="numWeeksPerReview" id="numWeeksPerReview" value="{$numWeeksPerReview|escape}" size="2" maxlength="8" class="form-control" /> <p class="help-block">{translate key="common.weeks"}</p></div>
				<p class="help-block">{translate key="common.note"}: {translate key="manager.setup.reviewOptions.noteOnModification"}</p>
			</p>

			<p>
				<strong>{translate key="manager.setup.reviewOptions.reviewerReminders"}</strong><br/>
				<p class="help-block">{translate key="manager.setup.reviewOptions.automatedReminders"}:</p><br/>
				<div class="form-group">
					<input type="checkbox" name="remindForInvite" id="remindForInvite" value="1" onclick="toggleAllowSetInviteReminder(this.form)"{if !$scheduledTasksEnabled} disabled="disabled" {elseif $remindForInvite} checked="checked"{/if} />&nbsp;
					<label class="control-label" for="remindForInvite">{translate key="manager.setup.reviewOptions.remindForInvite1"}</label>
				</div>
				<div class="form-group">
					<select name="numDaysBeforeInviteReminder" size="1" class="form-control"{if not $remindForInvite || !$scheduledTasksEnabled} disabled="disabled"{/if}>
						{section name="inviteDayOptions" start=3 loop=11}
							<option value="{$smarty.section.inviteDayOptions.index}"{if $numDaysBeforeInviteReminder eq $smarty.section.inviteDayOptions.index or ($smarty.section.inviteDayOptions.index eq 5 and not $remindForInvite)} selected="selected"{/if}>{$smarty.section.inviteDayOptions.index}</option>
						{/section}
					</select>
				</div>
				<p class="help-block">{translate key="manager.setup.reviewOptions.remindForInvite2"}</p>
				
				<br/>

				<div class="form-group">
					<input type="checkbox" name="remindForSubmit" id="remindForSubmit" value="1" onclick="toggleAllowSetSubmitReminder(this.form)"{if !$scheduledTasksEnabled} disabled="disabled"{elseif $remindForSubmit} checked="checked"{/if} />&nbsp;
					<label class="control-label" for="remindForSubmit">{translate key="manager.setup.reviewOptions.remindForSubmit1"}</label>
				</div>
				<div class="form-group">
					<select name="numDaysBeforeSubmitReminder" size="1" class="form-control"{if not $remindForSubmit || !$scheduledTasksEnabled} disabled="disabled"{/if}>
						{section name="submitDayOptions" start=0 loop=11}
							<option value="{$smarty.section.submitDayOptions.index}"{if $numDaysBeforeSubmitReminder eq $smarty.section.submitDayOptions.index} selected="selected"{/if}>{$smarty.section.submitDayOptions.index}</option>
						{/section}
					</select>
				</div>
				<p class="help-block">{translate key="manager.setup.reviewOptions.remindForSubmit2"}</p>
				
				{if !$scheduledTasksEnabled}
					<p class="help-block">{translate key="manager.setup.reviewOptions.automatedRemindersDisabled"}</p>
				{/if}
			</p>

			<p>
				<strong>{translate key="manager.setup.reviewOptions.reviewerRatings"}</strong><br/>
				<div class="form-group">
					<input type="checkbox" name="rateReviewerOnQuality" id="rateReviewerOnQuality" value="1"{if $rateReviewerOnQuality} checked="checked"{/if} />&nbsp;
					<label class="control-label" for="rateReviewerOnQuality">{translate key="manager.setup.reviewOptions.onQuality"}</label>
				</div>
			</p>

			<p>
				<strong>{translate key="manager.setup.reviewOptions.reviewerAccess"}</strong><br/>
				<div class="form-group">
					<input type="checkbox" name="reviewerAccessKeysEnabled" id="reviewerAccessKeysEnabled" value="1"{if $reviewerAccessKeysEnabled} checked="checked"{/if} />&nbsp;
					<label class="control-label" for="reviewerAccessKeysEnabled">{translate key="manager.setup.reviewOptions.reviewerAccessKeysEnabled"}</label><br/>
					<p class="help-block">{translate key="manager.setup.reviewOptions.reviewerAccessKeysEnabled.description"}</p><br/>
				</div>
				<div class="form-group">
					<input type="checkbox" name="restrictReviewerFileAccess" id="restrictReviewerFileAccess" value="1"{if $restrictReviewerFileAccess} checked="checked"{/if} />&nbsp;
					<label class="control-label" for="restrictReviewerFileAccess">{translate key="manager.setup.reviewOptions.restrictReviewerFileAccess"}</label>
				</div>
			</p>

			<p>
				<strong>{translate key="manager.setup.reviewOptions.blindReview"}</strong><br/>
				<div class="form-group">
					<input type="checkbox" name="showEnsuringLink" id="showEnsuringLink" value="1"{if $showEnsuringLink} checked="checked"{/if} />&nbsp;
					{get_help_id|assign:"blindReviewHelpId" key="editorial.sectionEditorsRole.review.blindPeerReview" url="true"}
					<label class="control-label" for="showEnsuringLink">{translate key="manager.setup.reviewOptions.showEnsuringLink" blindReviewHelpId=$blindReviewHelpId}</label><br/>
				</div>
			</p>
		</div>
	</div>
	
	<div class="separator"></div>
	
	<div id="privacyStatementInfo" class="col-md-12 mag-innert-left">
		<h3>2.3 {translate key="manager.setup.privacyStatement"}</h3>

		<p><div class="form-group"><textarea name="privacyStatement[{$formLocale|escape}]" id="privacyStatement" rows="12" cols="60" class="form-control">{$privacyStatement[$formLocale]|escape}</textarea></div></p>
	</div>

	<div class="separator"></div>

	<div id="editorDecision" class="col-md-12 mag-innert-left">
		<h3>2.4 {translate key="manager.setup.editorDecision"}</h3>

		<p><div class="form-group"><input type="checkbox" name="notifyAllAuthorsOnDecision" id="notifyAllAuthorsOnDecision" value="1"{if $notifyAllAuthorsOnDecision} checked="checked"{/if} /> <label for="notifyAllAuthorsOnDecision">{translate key="manager.setup.notifyAllAuthorsOnDecision"}</label></div></p>
	</div>
	
	<div class="separator"></div>

	<div id="addItemtoAboutJournal">
		<h3>2.5 {translate key="manager.setup.addItemtoAboutJournal"}</h3>

		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				{foreach name=customAboutItems from=$customAboutItems[$formLocale] key=aboutId item=aboutItem}
					<tr valign="top">
						<td width="5%">{fieldLabel name="customAboutItems-$aboutId-title" key="common.title"}</td>
						<td width="95%" class="value"><div class="form-group"><input type="text" name="customAboutItems[{$formLocale|escape}][{$aboutId|escape}][title]" id="customAboutItems-{$aboutId|escape}-title" value="{$aboutItem.title|escape}" size="40" maxlength="255" class="form-control" />{if $smarty.foreach.customAboutItems.total > 1}</div> <input type="submit" name="delCustomAboutItem[{$aboutId|escape}]" value="{translate key="common.delete"}" class="btn btn-danger" />{/if}</td>
					</tr>
					<tr valign="top">
						<td width="20%">{fieldLabel name="customAboutItems-$aboutId-content" key="manager.setup.aboutItemContent"}</td>
						<td width="80%" class="value"><div class="form-group"><textarea name="customAboutItems[{$formLocale|escape}][{$aboutId|escape}][content]" id="customAboutItems-{$aboutId|escape}-content" rows="12" cols="40" class="form-control">{$aboutItem.content|escape}</textarea></div></td>
					</tr>
					{if !$smarty.foreach.customAboutItems.last}
						<tr valign="top">
							<td colspan="2" class="separator">&nbsp;</td>
						</tr>
					{/if}
					{foreachelse}
						<tr valign="top">
							<td width="20%">{fieldLabel name="customAboutItems-0-title" key="common.title"}</td>
							<td width="80%" class="value"><div class="form-group"><input type="text" name="customAboutItems[{$formLocale|escape}][0][title]" id="customAboutItems-0-title" value="" size="40" maxlength="255" class="form-control" /></div></td>
						</tr>
						<tr valign="top">
							<td width="20%">{fieldLabel name="customAboutItems-0-content" key="manager.setup.aboutItemContent"}</td>
							<td width="80%" class="value"><div class="form-group"><textarea name="customAboutItems[{$formLocale|escape}][0][content]" id="customAboutItems-0-content" rows="12" cols="40" class="form-control"></textarea></div></td>
						</tr>
					{/foreach}
			</table>
		</div>

		<p><input type="submit" name="addCustomAboutItem" value="{translate key="manager.setup.addAboutItem"}" class="btn btn-success" /></p>
	</div>
	
	<div class="separator"></div>

	<div id="journalArchiving" class="col-md-12 mag-innert-left">
		<h3>2.6 {translate key="manager.setup.journalArchiving"}</h3>
		<p class="help-block">{translate key="manager.setup.lockssDescription"}</p>
		
		{url|assign:"lockssExistingArchiveUrl" page="manager" op="email" template="LOCKSS_EXISTING_ARCHIVE"}
		{url|assign:"lockssNewArchiveUrl" page="manager" op="email" template="LOCKSS_NEW_ARCHIVE"}
		<p class="help-block">{translate key="manager.setup.lockssRegister" lockssExistingArchiveUrl=$lockssExistingArchiveUrl lockssNewArchiveUrl=$lockssNewArchiveUrl}</p>

		{url|assign:"lockssUrl" page="gateway" op="lockss"}
		<p><div class="form-group"><input type="checkbox" name="enableLockss" id="enableLockss" value="1"{if $enableLockss} checked="checked"{/if} /> <label class="control-label" for="enableLockss">{translate key="manager.setup.lockssEnable" lockssUrl=$lockssUrl}</label></div></p>

		<p>
			<div class="form-group">
				<textarea name="lockssLicense[{$formLocale|escape}]" id="lockssLicense" rows="6" cols="60" class="form-control">{$lockssLicense[$formLocale]|escape}</textarea>
				<p class="help-block">{translate key="manager.setup.lockssLicenses"}</p>
			</div>
		</p>
	</div>

	<div class="separator"></div>

	<div id="reviewerDatabaseLink" class="col-md-12 mag-innert-left">
		<h3>2.7 {translate key="manager.setup.reviewerDatabaseLink"}</h3>
		<p class="help-block">{translate key="manager.setup.reviewerDatabaseLink.desc"}</p>

		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				{foreach name=reviewerDatabaseLinks from=$reviewerDatabaseLinks key=reviewerDatabaseLinkId item=reviewerDatabaseLink}
					<tr valign="top">
						<td width="5%">{fieldLabel name="reviewerDatabaseLinks-$reviewerDatabaseLinkId-title" key="common.title"}</td>
						<td width="95%" class="value"><div class="form-group"><input type="text" name="reviewerDatabaseLinks[{$reviewerDatabaseLinkId|escape}][title]" id="reviewerDatabaseLinks-{$reviewerDatabaseLinkId|escape}-title" value="{$reviewerDatabaseLink.title|escape}" size="40" maxlength="255" class="form-control" />{if $smarty.foreach.reviewerDatabaseLinks.total > 1}</div> <input type="submit" name="delReviewerDatabaseLink[{$reviewerDatabaseLinkId|escape}]" value="{translate key="common.delete"}" class="btn btn-danger" />{/if}</td>
					</tr>
					<tr valign="top">
						<td width="20%">{fieldLabel name="reviewerDatabaseLinks-$reviewerDatabaseLinkId-url" key="common.url"}</td>
						<td width="80%" class="value"><div class="form-group"><input type="text" name="reviewerDatabaseLinks[{$reviewerDatabaseLinkId|escape}][url]" id="reviewerDatabaseLinks-{$reviewerDatabaseLinkId|escape}-url" value="{$reviewerDatabaseLink.url|escape}" size="40" maxlength="255" class="form-control" /></div></td>
					</tr>
					{if !$smarty.foreach.reviewerDatabaseLinks.last}
						<tr valign="top">
							<td colspan="2" class="separator">&nbsp;</td>
						</tr>
					{/if}
					{foreachelse}
						<tr valign="top">
							<td width="20%">{fieldLabel name="reviewerDatabaseLinks-0-title" key="common.title"}</td>
							<td width="80%" class="value"><div class="form-group"><input type="text" name="reviewerDatabaseLinks[0][title]" id="reviewerDatabaseLinks-0-title" value="" size="40" maxlength="255" class="form-control" /></div></td>
						</tr>
						<tr valign="top">
							<td width="20%">{fieldLabel name="reviewerDatabaseLinks-0-url" key="common.url"}</td>
							<td width="80%" class="value"><div class="form-group"><input type="text" name="reviewerDatabaseLinks[0][url]" id="reviewerDatabaseLinks-0-url" value="" size="40" maxlength="255" class="form-control" /></div></td>
						</tr>
					{/foreach}
			</table>
		</div>

		<p><input type="submit" name="addReviewerDatabaseLink" value="{translate key="manager.setup.addReviewerDatabaseLink"}" class="btn btn-success" /></p>
	</div>
	
	<div class="separator"></div>

	<p><input type="submit" value="{translate key="common.saveAndContinue"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url op="setup" escape=false}'" /></p>

	<p class="help-block">{translate key="common.requiredField"}</p>
</form>

{include file="common/footer.tpl"}