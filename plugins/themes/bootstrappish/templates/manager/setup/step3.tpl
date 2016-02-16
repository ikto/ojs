{**
 * templates/manager/setup/step3.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Step 3 of journal setup.
 *}
{assign var="pageTitle" value="manager.setup.guidingSubmissions"}
{include file="manager/setup/setupHeader.tpl"}

<form role="form" id="setupForm" method="post" action="{url op="saveSetup" path="3"}">
	
	{include file="common/formErrors.tpl"}

	{if count($formLocales) > 1}
		<div id="locale" class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="20%">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
					<td width="80%" class="value">
						{url|assign:"setupFormUrl" op="setup" path="3" escape=false}
						{form_language_chooser form="setupForm" url=$setupFormUrl}
						<p class="help-block">{translate key="form.formLanguage.description"}</p>
					</td>
				</tr>
			</table>
		</div>
	{/if}

	<div id="authorGuidelinesInfo" class="col-md-12 mag-innert-left">
		<h3>3.1 {translate key="manager.setup.authorGuidelines"}</h3>
		<p class="help-block">{translate key="manager.setup.authorGuidelinesDescription"}</p>

		<p>
			<div class="form-group"><textarea name="authorGuidelines[{$formLocale|escape}]" id="authorGuidelines" rows="12" cols="60" class="form-control">{$authorGuidelines[$formLocale]|escape}</textarea></div>
		</p>
	</div>

	<div id="submissionPreparationChecklist" class="col-md-12 mag-innert-left">
		<h4>{translate key="manager.setup.submissionPreparationChecklist"}</h4>
		<p class="help-block">{translate key="manager.setup.submissionPreparationChecklistDescription"}</p>

		{foreach name=checklist from=$submissionChecklist[$formLocale] key=checklistId item=checklistItem}
			{if !$notFirstChecklistItem}
				{assign var=notFirstChecklistItem value=1}
				<div class="table-responsive">
					<table width="100%" class="table table-striped">
						<tr valign="top">
							<td width="5%">{translate key="common.order"}</td>
							<td width="95%" colspan="2">&nbsp;</td>
						</tr>
			{/if}
						<tr valign="top">
							<td width="5%"><div class="form-group"><input type="text" name="submissionChecklist[{$formLocale|escape}][{$checklistId|escape}][order]" value="{$checklistItem.order|escape}" size="3" maxlength="2" class="form-control" /></div></td>
							<td class="value"><div class="form-group"><textarea name="submissionChecklist[{$formLocale|escape}][{$checklistId|escape}][content]" id="submissionChecklist-{$checklistId|escape}" rows="3" cols="40" class="form-control">{$checklistItem.content|escape}</textarea></div></td>
							<td width="100%"><input type="submit" name="delChecklist[{$checklistId|escape}]" value="{translate key="common.delete"}" class="btn btn-danger" /></td>
						</tr>
		{/foreach}

		{if $notFirstChecklistItem}
					</table>
				</div>
		{/if}

		<p><input type="submit" name="addChecklist" value="{translate key="manager.setup.addChecklistItem"}" class="btn btn-success" /></p>
	</div>

	<div class="separator"></div>

	<div id="authorCopyrightNotice" class="col-md-12 mag-innert-left">
		<h3>3.2 {translate key="manager.setup.authorCopyrightNotice"}</h3>
		{url|assign:"sampleCopyrightWordingUrl" page="information" op="sampleCopyrightWording"}
		<p class="help-block">{translate key="manager.setup.authorCopyrightNoticeDescription" sampleCopyrightWordingUrl=$sampleCopyrightWordingUrl}</p>

		<p><div class="form-group"><textarea name="copyrightNotice[{$formLocale|escape}]" id="copyrightNotice" rows="12" cols="60" class="form-control">{$copyrightNotice[$formLocale]|escape}</textarea></div></p>

		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="5%">
						<div class="form-group"><input type="checkbox" name="copyrightNoticeAgree" id="copyrightNoticeAgree" value="1"{if $copyrightNoticeAgree} checked="checked"{/if} /></div>
					</td>
					<td width="95%" class="value">
						<label class="control-label" for="copyrightNoticeAgree">{translate key="manager.setup.authorCopyrightNoticeAgree"}</label>
					</td>
				</tr>
				<tr valign="top">
					<td>
						<div class="form-group"><input type="checkbox" name="includeCreativeCommons" id="includeCreativeCommons" value="1"{if $includeCreativeCommons} checked="checked"{/if} /></div>
					</td>
					<td class="value">
						<label class="control-label" for="includeCreativeCommons">{translate key="manager.setup.includeCreativeCommons"}</label>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<div class="separator"></div>

	<div id="competingInterests" class="col-md-12 mag-innert-left">
		<h3>3.3 {translate key="manager.setup.competingInterests"}</h3>
		<p class="help-block">{translate key="manager.setup.competingInterests.description"}</p>

		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="5%">
						<div class="form-group"><input type="checkbox" name="requireAuthorCompetingInterests" id="requireAuthorCompetingInterests" value="1"{if $requireAuthorCompetingInterests} checked="checked"{/if} /></div>
					</td>
					<td class="value" width="95%">
						<label class="control-label" for="requireAuthorCompetingInterests">{translate key="manager.setup.competingInterests.requireAuthors"}</label>
					</td>
				</tr>
				<tr valign="top">
					<td>
						<div class="form-group"><input type="checkbox" name="requireReviewerCompetingInterests" id="requireReviewerCompetingInterests" value="1"{if $requireReviewerCompetingInterests} checked="checked"{/if} /></div>
					</td>
					<td class="value">
						<label class="control-label" for="requireReviewerCompetingInterests">{translate key="manager.setup.competingInterests.requireReviewers"}</label>
					</td>
				</tr>
			</table>
		</div>

		<h4>{translate key="manager.setup.competingInterests.guidelines"}</h4>
		<p><div class="form-group"><textarea name="competingInterestGuidelines[{$formLocale|escape}]" id="competingInterestGuidelines" rows="12" cols="60" class="form-control">{$competingInterestGuidelines[$formLocale]|escape}</textarea></div></p>
	</div>

	<div class="separator"></div>

	<div id="forAuthorsToIndexTheirWork" class="col-md-12 mag-innert-left">
		<h3>3.4 {translate key="manager.setup.forAuthorsToIndexTheirWork"}</h3>
		<p class="help-block">{translate key="manager.setup.forAuthorsToIndexTheirWorkDescription"}</p>

		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="5%" valign="bottom"><div class="form-group"><input type="checkbox" name="metaDiscipline" id="metaDiscipline" value="1"{if $metaDiscipline} checked="checked"{/if} /></div></td>
					<td width="95%" class="value">
						<h4>{fieldLabel name="metaDiscipline" key="manager.setup.discipline"}</h4>
					</td>
				</tr>
				<tr valign="top">
					<td>&nbsp;</td>
					<td class="value">
						<p class="help-block">{translate key="manager.setup.disciplineDescription"}</p><br/>
						<p class="help-block">{translate key="manager.setup.disciplineProvideExamples"}:</p>
						<br />
						<div class="form-group"><input type="text" name="metaDisciplineExamples[{$formLocale|escape}]" id="metaDisciplineExamples" value="{$metaDisciplineExamples[$formLocale]|escape}" size="60" maxlength="255" class="form-control" /></div>
						<br />
						<p class="help-block">{translate key="manager.setup.disciplineExamples"}</p>
					</td>
				</tr>

				<tr>
					<td class="separator" colspan="2"><br />&nbsp;</td>
				</tr>

				<tr valign="top">
					<td width="5%" valign="bottom"><div class="form-group"><input type="checkbox" name="metaSubjectClass" id="metaSubjectClass" value="1"{if $metaSubjectClass} checked="checked"{/if} /></div></td>
					<td width="95%" class="value">
						<h4>{fieldLabel name="metaSubjectClass" key="manager.setup.subjectClassification"}</h4>
					</td>
				</tr>
				<tr valign="top">
					<td>&nbsp;</td>
					<td class="value">
						<table width="100%" class="table table-striped">
							<tr valign="top">
								<td width="10%">{fieldLabel name="metaSubjectClassTitle" key="common.title"}</td>
								<td width="90%"><div class="form-group"><input type="text" name="metaSubjectClassTitle[{$formLocale|escape}]" id="metaSubjectClassTitle" value="{$metaSubjectClassTitle[$formLocale]|escape}" size="40" maxlength="255" class="form-control" /></div></td>
							</tr>
							<tr valign="top">
								<td width="10%">{fieldLabel name="metaSubjectClassUrl" key="common.url"}</td>
								<td width="90%"><div class="form-group"><input type="text" name="metaSubjectClassUrl[{$formLocale|escape}]" id="metaSubjectClassUrl" value="{$metaSubjectClassUrl[$formLocale]|escape}" size="40" maxlength="255" class="form-control" /></div></td>
							</tr>
						</table>
						<p class="help-block">{translate key="manager.setup.subjectClassificationExamples"}</p>
					</td>
				</tr>

				<tr>
					<td class="separator" colspan="2"><br />&nbsp;</td>
				</tr>

				<tr valign="top">
					<td width="5%" valign="bottom"><div class="form-group"><input type="checkbox" name="metaSubject" id="metaSubject" value="1"{if $metaSubject} checked="checked"{/if} /></div></td>
					<td width="95%" class="value">
						<h4>{fieldLabel name="metaSubject" key="manager.setup.subjectKeywordTopic"}</h4>
					</td>
				</tr>
				<tr valign="top">
					<td>&nbsp;</td>
					<td class="value">
						<p class="help-block">{translate key="manager.setup.subjectProvideExamples"}:</p>
						<br />
						<div class="form-group"><input type="text" name="metaSubjectExamples[{$formLocale|escape}]" id="metaSubjectExamples" value="{$metaSubjectExamples[$formLocale]|escape}" size="60" maxlength="255" class="form-control" /></div>
						<br />
						<p class="help-block">{translate key="manager.setup.subjectExamples"}</p>
					</td>
				</tr>

				<tr>
					<td class="separator" colspan="2"><br />&nbsp;</td>
				</tr>

				<tr valign="top">
					<td width="5%" valign="bottom"><div class="form-group"><input type="checkbox" name="metaCoverage" id="metaCoverage" value="1"{if $metaCoverage} checked="checked"{/if} /></div></td>
					<td width="95%" class="value">
						<h4>{fieldLabel name="metaCoverage" key="manager.setup.coverage"}</h4>
					</td>
				</tr>
				<tr>
					<td class="separator" colspan="2">&nbsp;</td>
				</tr>
				<tr valign="top">
					<td>&nbsp;</td>
					<td class="value">
						<p class="help-block">{translate key="manager.setup.coverageDescription"}</p><br/>
						<p class="help-block">{translate key="manager.setup.coverageGeoProvideExamples"}:</p>
						<br />
						<div class="form-group"><input type="text" name="metaCoverageGeoExamples[{$formLocale|escape}]" id="metaCoverageGeoExamples" value="{$metaCoverageGeoExamples[$formLocale]|escape}" size="60" maxlength="255" class="form-control" /></div>
						<br />
						<p class="help-block">{translate key="manager.setup.coverageGeoExamples"}</p>
					</td>
				</tr>
				<tr>
					<td class="separator" colspan="2">&nbsp;</td>
				</tr>
				<tr valign="top">
					<td>&nbsp;</td>
					<td class="value">
						<p class="help-block">{translate key="manager.setup.coverageChronProvideExamples"}:</p>
						<br />
						<div class="form-group"><input type="text" name="metaCoverageChronExamples[{$formLocale|escape}]" id="metaCoverageChronExamples" value="{$metaCoverageChronExamples[$formLocale]|escape}" size="60" maxlength="255" class="form-control" /></div>
						<br />
						<p class="help-block">{translate key="manager.setup.coverageChronExamples"}</p>
					</td>
				</tr>
				<tr>
					<td class="separator" colspan="2">&nbsp;</td>
				</tr>
				<tr valign="top">
					<td>&nbsp;</td>
					<td class="value">
						<p class="help-block">{translate key="manager.setup.coverageResearchSampleProvideExamples"}:</p>
						<br />
						<div class="form-group"><input type="text" name="metaCoverageResearchSampleExamples[{$formLocale|escape}]" id="metaCoverageResearchSampleExamples" value="{$metaCoverageResearchSampleExamples[$formLocale]|escape}" size="60" maxlength="255" class="form-control" /></div>
						<br />
						<p class="help-block">{translate key="manager.setup.coverageResearchSampleExamples"}</p>
					</td>
				</tr>

				<tr>
					<td class="separator" colspan="2"><br />&nbsp;</td>
				</tr>

				<tr valign="top">
					<td width="5%" valign="bottom"><div class="form-group"><input type="checkbox" name="metaType" id="metaType" value="1"{if $metaType} checked="checked"{/if} /></div></td>
					<td width="95%" class="value">
						<h4>{fieldLabel name="metaType" key="manager.setup.typeMethodApproach"}</h4>
					</td>
				</tr>
				<tr valign="top">
					<td>&nbsp;</td>
					<td class="value">
						<p class="help-block">{translate key="manager.setup.typeProvideExamples"}:</p>
						<br />
						<div class="form-group"><input type="text" name="metaTypeExamples[{$formLocale|escape}]" id="metaTypeExamples" value="{$metaTypeExamples[$formLocale]|escape}" size="60" maxlength="255" class="form-control" /></div>
						<br />
						<p class="help-block">{translate key="manager.setup.typeExamples"}</p>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<div class="separator"></div>

	<div id="registerJournalForIndexing" class="col-md-12 mag-innert-left">
		<h3>3.5 {translate key="manager.setup.registerJournalForIndexing"}</h3>

		{url|assign:"oaiUrl" page="oai"}
		<p class="help-block">{translate key="manager.setup.registerJournalForIndexingDescription" oaiUrl=$oaiUrl siteUrl=$baseUrl}</p>
	</div>

	<div class="separator"></div>

	<div id="notifications" class="col-md-12 mag-innert-left">
		<h3>3.6 {translate key="manager.setup.notifications"}</h3>
		<p class="help-block">{translate key="manager.setup.notifications.description"}</p>

		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td><div class="form-group"><input {if !$submissionAckEnabled}disabled="disabled" {/if}type="checkbox" name="copySubmissionAckPrimaryContact" id="copySubmissionAckPrimaryContact" value="true" {if $copySubmissionAckPrimaryContact}checked="checked"{/if}/></div></td>
					<td class="value">{fieldLabel name="copySubmissionAckPrimaryContact" key="manager.setup.notifications.copyPrimaryContact"}</td>
				</tr>
				<tr valign="top">
					<td><div class="form-group"><input {if !$submissionAckEnabled}disabled="disabled" {/if}type="checkbox" name="copySubmissionAckSpecified" id="copySubmissionAckSpecified" value="true" {if $copySubmissionAckSpecified}checked="checked"{/if}/></div></td>
					<td class="value">{fieldLabel name="copySubmissionAckAddress" key="manager.setup.notifications.copySpecifiedAddress"}&nbsp;&nbsp;<input {if !$submissionAckEnabled}disabled="disabled" {/if}type="text" class="textField" id="copySubmissionAckAddress" name="copySubmissionAckAddress" value="{$copySubmissionAckAddress|escape}"/></td>
				</tr>
				{if !$submissionAckEnabled}
					<tr valign="top">
						<td>&nbsp;</td>
						{url|assign:"preparedEmailsUrl" op="emails"}
						<td>{translate key="manager.setup.notifications.submissionAckDisabled" preparedEmailsUrl=$preparedEmailsUrl}</td>
					</tr>
				{/if}
			</table>
		</div>
	</div>

	<div class="separator"></div>

	<div id="citationAssistant" class="col-md-12 mag-innert-left">
		<h3>3.7 {translate key="manager.setup.citationAssistant"}</h3>

		<a name="metaCitationEditing"></a>
		{if $citationEditorError}
			<p class="help-block">{translate key=$citationEditorError}</p>
		{else}
			<p class="help-block">{translate key="manager.setup.metaCitationsDescription"}</p>
			<div class="table-responsive">
				<table width="100%" class="table table-striped">
					<tr valign="top">
						<td width="5%">
							<div class="form-group"><input type="checkbox" name="metaCitations" id="metaCitations" value="1"{if $metaCitations} checked="checked"{/if} /></div>
						</td>
						<td width="95%" class="value">
							<label class="control-label" for="metaCitations">{translate key="manager.setup.citations"}</label>
						</td>
					</tr>
				</table>
			</div>

			<div id="citationFilterSetupToggle" {if !$metaCitations}style="visible: none"{/if}>
				<h4>{translate key="manager.setup.citationFilterParser"}</h4>
				<p class="help-block">{translate key="manager.setup.citationFilterParserDescription"}</p>
				{load_url_in_div id="parserFilterGridContainer" loadMessageId="manager.setup.filter.parser.grid.loadMessage" url="$parserFilterGridUrl"}

				<h4>{translate key="manager.setup.citationFilterLookup"}</h4>
				<p class="help-block">{translate key="manager.setup.citationFilterLookupDescription"}</p>
				{load_url_in_div id="lookupFilterGridContainer" loadMessageId="manager.setup.filter.lookup.grid.loadMessage" url="$lookupFilterGridUrl"}
				<h4>{translate key="manager.setup.citationOutput"}</h4>
				<p class="help-block">{translate key="manager.setup.citationOutputStyleDescription"}</p>
				{fbvElement type="select" id="metaCitationOutputFilterSelect" name="metaCitationOutputFilterId"
						from=$metaCitationOutputFilters translate=false selected=$metaCitationOutputFilterId|escape
						defaultValue="-1" defaultLabel="manager.setup.filter.pleaseSelect"|translate}
			</div>
		
			<script type='text/javascript'>
			{literal}
			$(function(){
				// jQuerify DOM elements
				$metaCitationsCheckbox = $('#metaCitations');
				$metaCitationsSetupBox = $('#citationFilterSetupToggle');

				// Set the initial state
				initialCheckboxState = $metaCitationsCheckbox.attr('checked');
				if (initialCheckboxState) {
					$metaCitationsSetupBox.css('display', 'block');
				} else {
					$metaCitationsSetupBox.css('display', 'none');
				}

				// Toggle the settings box.
				// NB: Has to be click() rather than change() to work in IE.
				$metaCitationsCheckbox.click(function(){
					checkboxState = $metaCitationsCheckbox.attr('checked');
					toggleState = ($metaCitationsSetupBox.css('display') === 'block');
					if (checkboxState !== toggleState) {
						$metaCitationsSetupBox.toggle(300);
					}
				});
			});
			{/literal}
			</script>
		{/if}
	</div>

	<div class="separator"></div>

	<p><input type="submit" value="{translate key="common.saveAndContinue"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url op="setup" escape=false}'" /></p>

	<p class="help-block">{translate key="common.requiredField"}</p>
</form>

{include file="common/footer.tpl"}