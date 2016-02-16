{**
 * templates/author/submit/step5.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Step 5 of author article submission.
 *
 *}
{assign var="pageTitle" value="author.submit.step5"}
{include file="author/submit/submitHeader.tpl"}

<p class="help-block">{translate key="author.submit.confirmationDescription" journalTitle=$journal->getLocalizedTitle()}</p>

<form role="form" method="post" action="{url op="saveSubmit" path=$submitStep}">
	<input type="hidden" name="articleId" value="{$articleId|escape}" />
	
	{include file="common/formErrors.tpl"}

	<h3>{translate key="author.submit.filesSummary"}</h3>
	<div class="table-responsive">
		<table class="table table-striped" width="100%">
			<tr>
				<td colspan="5" class="headseparator">&nbsp;</td>
			</tr>
			<tr class="heading" valign="bottom">
				<td width="10%"><label>{translate key="common.id"}</label></td>
				<td width="35%"><label>{translate key="common.originalFileName"}</label></td>
				<td width="25%"><label>{translate key="common.type"}</label></td>
				<td width="20%" class="nowrap"><label>{translate key="common.fileSize"}</label></td>
				<td width="10%" class="nowrap"><label>{translate key="common.dateUploaded"}</label></td>
			</tr>
			<tr>
				<td colspan="5" class="headseparator">&nbsp;</td>
			</tr>
			{foreach from=$files item=file}
				<tr valign="top">
					<td>{$file->getFileId()}</td>
					<td><a class="file" href="{url op="download" path=$articleId|to_array:$file->getFileId()}">{$file->getOriginalFileName()|escape}</a></td>
					<td>{if ($file->getType() == 'supp')}{translate key="article.suppFile"}{else}{translate key="author.submit.submissionFile"}{/if}</td>
					<td>{$file->getNiceFileSize()}</td>
					<td>{$file->getDateUploaded()|date_format:$dateFormatTrunc}</td>
				</tr>
			{foreachelse}
				<tr valign="top">
				<td colspan="5" class="nodata"><p class="help-block">{translate key="author.submit.noFiles"}</p></td>
				</tr>
			{/foreach}
		</table>
	</div>

	<div class="separator"></div>

	{if $authorFees}
		{include file="author/submit/authorFees.tpl" showPayLinks=1}
		{if $currentJournal->getLocalizedSetting('waiverPolicy') != ''}
			{if $manualPayment}
				<h3>{translate key="payment.alreadyPaid"}</h3>
				<div class="table-responsive">
					<table class="table table-striped" width="100%">
						<tr valign="top">
							<td width="5%" align="left"><div class="form-group"><input type="checkbox" name="paymentSent" value="1" {if $paymentSent}checked="checked"{/if} /></div></td>
							<td width="95%">{translate key="payment.paymentSent"}</td>
						</tr>
						<tr>
							<td />
							<td>{translate key="payment.alreadyPaidMessage"}</td>
						<tr>
					</table>
				</div>
			{/if}
			<h3>{translate key="author.submit.requestWaiver"}</h3>
			<div class="table-responsive">
				<table class="table table-striped" width="100%">
					<tr valign="top">
						<td width="5%" align="left"><div class="form-group"><input type="checkbox" name="qualifyForWaiver" value="1" {if $qualifyForWaiver}checked="checked"{/if}/></div></td>
						<td width="95%">{translate key="author.submit.qualifyForWaiver"}</td>
					</tr>
					<tr>
						<td />
						<td>
							<div class="form-group">
								<label class="control-label">{translate key="author.submit.addReasonsForWaiver"}</label><br />
								<textarea name="commentsToEditor" id="commentsToEditor" rows="3" cols="40" class="form-control">{$commentsToEditor|escape}</textarea>
							</div>
						</td>
					</tr>
				</table>
			</div>
		{/if}

		<div class="separator"></div>
	{/if}

	{call_hook name="Templates::Author::Submit::Step5::AdditionalItems"}

	<p><input type="submit" value="{translate key="author.submit.finishSubmission"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="confirmAction('{url page="author"}', '{translate|escape:"jsparam" key="author.submit.cancelSubmission"}')" /></p>
</form>

{include file="common/footer.tpl"}