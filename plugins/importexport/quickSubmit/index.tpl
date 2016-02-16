{**
 * plugins/importexport/quickSubmit/index.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Template for one-page submission form
 *
 *}
{strip}
{assign var="pageTitle" value="plugins.importexport.quickSubmit.displayName"}
{include file="common/header.tpl"}
{/strip}

{literal}
<script type="text/javascript">
<!--
// Move author up/down
function moveAuthor(dir, authorIndex) {
	var form = document.getElementById('submit');
	form.moveAuthor.value = 1;
	form.moveAuthorDir.value = dir;
	form.moveAuthorIndex.value = authorIndex;
	form.submit();
}

// Update the required attribute of the abstract field
function updateAbstractRequired() {
	var a = {{/literal}{foreach from=$sectionAbstractsRequired key=rSectionId item=rAbstractRequired}{$rSectionId|escape}: {$rAbstractRequired|escape}, {/foreach}{literal}};
	var selectedIndex = document.getElementById('submit').sectionId.selectedIndex;
	var sectionId = document.getElementById('submit').sectionId.options[selectedIndex].value;
	var abstractRequired = a[sectionId];
	var e = document.getElementById("abstractRequiredAsterisk");
	e.style.visibility = abstractRequired?"visible":"hidden";
}
// -->
</script>
{/literal}

<p class="help-block">{translate key="plugins.importexport.quickSubmit.descriptionLong"}</p>

<form role="form" enctype="multipart/form-data" id="submit" method="post" action="{plugin_url path="saveSubmit"}">

	{include file="common/formErrors.tpl"}

	{if count($formLocales) > 1}
		<div id="locales" class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="20%">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
					<td width="80%" class="value">
						{plugin_url|assign:"quickSubmitUrl" escape=false}
						{* Maintain localized author info across requests *}
						{foreach from=$authors key=authorIndex item=author}
							{if $currentJournal->getSetting('requireAuthorCompetingInterests')}
								{foreach from=$author.competingInterests key="thisLocale" item="thisCompetingInterests"}
									{if $thisLocale != $formLocale}<input type="hidden" name="authors[{$authorIndex|escape}][competingInterests][{$thisLocale|escape}]" value="{$thisCompetingInterests|escape}" />{/if}
								{/foreach}
							{/if}
							{foreach from=$author.biography key="thisLocale" item="thisBiography"}
								{if $thisLocale != $formLocale}<input type="hidden" name="authors[{$authorIndex|escape}][biography][{$thisLocale|escape}]" value="{$thisBiography|escape}" />{/if}
							{/foreach}
							{foreach from=$author.affiliation key="thisLocale" item="thisAffiliation"}
								{if $thisLocale != $formLocale}<input type="hidden" name="authors[{$authorIndex|escape}][affiliation][{$thisLocale|escape}]" value="{$thisAffiliation|escape}" />{/if}
							{/foreach}
						{/foreach}
						{form_language_chooser form="submit" url=$quickSubmitUrl}
						<span class="help-block">{translate key="form.formLanguage.description"}</span>
					</td>
				</tr>
			</table>
		</div>
	{/if}

	<div id="chooseDestination" class="col-md-12 mag-innert-left">
		<h3>{translate key="plugins.importexport.quickSubmit.chooseDestination"}</h3>
		<p class="help-block">{translate key="plugins.importexport.quickSubmit.chooseDestinationDescription"}</p>

		<div class="table-responsive">
			<table class="table table-striped" width="100%">
				<tr valign="top">
					<td width="5%">
						<div class="form-group"><input type="radio" name="destination" id="destinationUnpublished" value="queue" {if not $publishToIssue} checked="checked"{/if}{if $enablePageNumber} onclick="document.getElementById('submit').pages.disabled = true;document.getElementById('submit').pagesHidden.value = document.getElementById('submit').pages.value; document.getElementById('submit').pages.value = '';"{/if}/></div>
					</td>
					<td colspan="2" class="value" width="95%">{fieldLabel name="destinationUnpublished" key="plugins.importexport.quickSubmit.leaveUnpublished"}</td>
				</tr>
				<tr valign="top">
					<td rowspan="2">
						<div class="form-group"><input type="radio" id="destinationIssue" name="destination" value="issue" {if $publishToIssue} checked="checked"{/if}{if $enablePageNumber} onclick="document.getElementById('submit').pages.disabled = false;document.getElementById('submit').pages.value = document.getElementById('submit').pagesHidden.value;"{/if}/></div>
					</td>
					<td width="20%" class="value">
						{fieldLabel name="destinationIssue" key="plugins.importexport.quickSubmit.addToExisting"}
					</td>
					<td class="value">
						<div class="form-group"><select name="issueId" id="issueId" size="1" class="form-control">{html_options options=$issueOptions selected=$issueNumber}</select></div>
					</td>
				</tr>
				<tr valign="top">
					<td>
						<label class="control-label" for="issueId">{translate key="editor.issues.published"}</label>
					</td>
					<td class="value">
						{* Find good values for starting and ending year options *}
						{assign var=currentYear value=$smarty.now|date_format:"%Y"}
						{if $datePublished}
							{assign var=publishedYear value=$datePublished|date_format:"%Y"}
							{math|assign:"minYear" equation="min(x,y)-10" x=$publishedYear y=$currentYear}
							{math|assign:"maxYear" equation="max(x,y)+2" x=$publishedYear y=$currentYear}
						{else}
							{* No issue publication date info *}
							{math|assign:"minYear" equation="x-10" x=$currentYear}
							{math|assign:"maxYear" equation="x+2" x=$currentYear}
						{/if}
						{html_select_date prefix="datePublished" time=$datePublished|default:"---" all_extra="class=\"form-control\"" start_year=$minYear end_year=$maxYear year_empty="common.year"|translate month_empty="common.month"|translate day_empty="common.day"|translate}
					</td>
				</tr>
				{if $enablePageNumber}
					<tr valign="top">
						<td>&nbsp;</td>
						<td colspan="2" class="value">
							<div class="form-group">
								{fieldLabel name="pages" key="editor.issues.pages"}&nbsp;
								<input name="pages" id="pages" {if $publishToIssue}value="{$pages|escape}" {else}disabled="disabled" {/if}size="20" maxlength="40" class="form-control" />
							</div>
							<input type="hidden" name="pagesHidden" value="{$pages|escape}" />
						</td>
					</tr>
				{/if}{* $enablePageNumber *}
			</table>
		</div>
	</div> <!-- /chooseDestination -->

	<div class="separator"></div>

	<br />

	<div id="submission" class="col-md-12 mag-innert-left">
		<h3>{translate key="plugins.importexport.quickSubmit.submissionData"}</h3>
	
		<div id="section" class="col-md-12 mag-innert-left">
			{if count($sectionOptions) == 2}
				{* If there's only one section, force it and skip the section parts
				   of the interface. *}
				{foreach from=$sectionOptions item=val key=key}
					<input type="hidden" name="sectionId" value="{$key|escape}" />
					{assign var=abstractRequired value=$sectionAbstractsRequired[$key]}
				{/foreach}
			{else}{* if count($sectionOptions) == 2 *}
				<h4>{translate key="author.submit.journalSection"}</h4>

				{url|assign:"url" page="about"}
				<p class="help-block">{translate key="author.submit.journalSectionDescription" aboutUrl=$url}</p>

				<div class="table-responsive">
					<table class="table table-striped" width="100%">
						<tr valign="top">
							<td width="30%">{fieldLabel name="sectionId" required="true" key="section.section"}</td>
							<td width="70%" class="value"><div class="form-group"><select name="sectionId" id="sectionId" size="1" class="form-control" onchange="updateAbstractRequired()">{html_options options=$sectionOptions selected=$sectionId}</select></div></td>
						</tr>
					</table>
				</div>
			{/if}{* if count($sectionOptions) == 2 *}
		</div> <!-- /section -->

		{if count($supportedSubmissionLocaleNames) == 1}
			{* There is only one supported submission locale; choose it invisibly *}
			{foreach from=$supportedSubmissionLocaleNames item=localeName key=locale}
				<input type="hidden" name="locale" value="{$locale|escape}" />
			{/foreach}
		{else}
			{* There are several submission locales available; allow choice *}
			<div id="submissionLocale" class="col-md-12 mag-innert-left">
				<h4>{translate key="author.submit.submissionLocale"}</h4>
				<p class="help-block">{translate key="author.submit.submissionLocaleDescription"}</p>

				<div class="table-responsive">
					<table class="table table-striped" width="100%">
						<tr valign="top">
							<td width="30%">{fieldLabel name="locale" required="true" key="article.language"}</td>
							<td width="70%" class="value"><div class="form-group"><select name="locale" id="locale" size="1" class="form-control">{html_options options=$supportedSubmissionLocaleNames selected=$locale}</select></div></td>
						</tr>
					</table>
				</div>
			</div>{* submissionLocale *}
		{/if}{* count($supportedSubmissionLocaleNames) == 1 *}

		<div id="submissionFile" class="col-md-12 mag-innert-left">
			<h4>{translate key="author.submit.submissionFile"}</h4>
			
			<div class="table-responsive">
				<table class="table table-striped" width="100%">
					{if $submissionFile}
						<tr valign="top">
							<td width="30%">{translate key="common.originalFileName"}</td>
							<td width="70%" class="value">{$submissionFile->getOriginalFileName()|escape}</td>
						</tr>
						<tr valign="top">
							<td width="30%">{translate key="common.fileSize"}</td>
							<td width="70%" class="value">{$submissionFile->getNiceFileSize()}</td>
						</tr>
						<tr valign="top">
							<td width="30%">{translate key="common.dateUploaded"}</td>
							<td width="70%" class="value">{$submissionFile->getDateUploaded()|date_format:$datetimeFormatShort}</td>
						</tr>
					{else}
						<tr valign="top">
							<td colspan="2" class="nodata"><p class="help-block">{translate key="plugins.importexport.quickSubmit.submissionDescription"}</p></td>
						</tr>
					{/if}
				</table>
			</div>
		</div> <!-- /submissionFile -->

		<div id="addSubmissionFile" class="col-md-12 mag-innert-left">
			<input type="hidden" name="tempFileId[{$formLocale|escape}]" id="tempFileId" value="{$tempFileId[$formLocale]|escape}" />
			
			<div class="table-responsive">
				<table class="table table-striped" width="100%">
					<tr>
						<td width="30%">
							{if $submissionFile}
								{fieldLabel name="submissionFile" key="author.submit.replaceSubmissionFile"}
							{else}
								{fieldLabel name="submissionFile" key="author.submit.uploadSubmissionFile"}
							{/if}
						</td>
						<td width="70%" class="value">
							<div class="form-group"><input type="file" class="form-control" name="submissionFile" id="submissionFileUpload" /></div> <input name="uploadSubmissionFile" type="submit" class="btn btn-success" value="{translate key="common.upload"}" />
						</td>
					</tr>
				</table>
			</div>
		</div>  <!-- /addSubmissionFile -->

		<div id="authors" class="col-md-12 mag-innert-left">
			<h4>{translate key="article.authors"}</h4>
			<input type="hidden" name="moveAuthor" value="0" />
			<input type="hidden" name="moveAuthorDir" value="" />
			<input type="hidden" name="moveAuthorIndex" value="" />

			{foreach name=authors from=$authors key=authorIndex item=author}
				<input type="hidden" name="authors[{$authorIndex|escape}][authorId]" value="{$author.authorId|escape}" />
				<input type="hidden" name="authors[{$authorIndex|escape}][seq]" value="{$authorIndex+1}" />
				{if $smarty.foreach.authors.total <= 1}
					<input type="hidden" name="primaryContact" value="{$authorIndex|escape}" />
				{/if}

				<div class="table-responsive">
					<table width="100%" class="table table-striped">
						<tr valign="top">
							<td width="30%">{fieldLabel name="authors-$authorIndex-firstName" required="true" key="user.firstName"}</td>
							<td width="70%" class="value"><div class="form-group"><input type="text" class="form-control" name="authors[{$authorIndex|escape}][firstName]" id="authors-{$authorIndex|escape}-firstName" value="{$author.firstName|escape}" size="20" maxlength="40" /></div></td>
						</tr>
						<tr valign="top">
							<td width="30%">{fieldLabel name="authors-$authorIndex-middleName" key="user.middleName"}</td>
							<td width="70%" class="value"><div class="form-group"><input type="text" class="form-control" name="authors[{$authorIndex|escape}][middleName]" id="authors-{$authorIndex|escape}-middleName" value="{$author.middleName|escape}" size="20" maxlength="40" /></div></td>
						</tr>
						<tr valign="top">
							<td width="30%">{fieldLabel name="authors-$authorIndex-lastName" required="true" key="user.lastName"}</td>
							<td width="70%" class="value"><div class="form-group"><input type="text" class="form-control" name="authors[{$authorIndex|escape}][lastName]" id="authors-{$authorIndex|escape}-lastName" value="{$author.lastName|escape}" size="20" maxlength="90" /></div></td>
						</tr>
						<tr valign="top">
							<td width="30%">{fieldLabel name="authors-$authorIndex-email" required="true" key="user.email"}</td>
							<td width="70%" class="value"><div class="form-group"><input type="text" class="form-control" name="authors[{$authorIndex|escape}][email]" id="authors-{$authorIndex|escape}-email" value="{$author.email|escape}" size="30" maxlength="90" /></div></td>
						</tr>
						<tr valign="top">
							<td width="20%">{fieldLabel name="authors-$authorIndex-orcid" key="user.orcid"}</td>
							<td width="80%" class="value"><div class="form-group"><input type="text" class="form-control" name="authors[{$authorIndex|escape}][orcid]" id="authors-{$authorIndex|escape}-orcid" value="{$author.orcid|escape}" size="30" maxlength="90" /></div><p class="help-block">{translate key="user.orcid.description"}</p></td>
						</tr>
						<tr valign="top">
							<td>{fieldLabel name="authors-$authorIndex-url" key="user.url"}</td>
							<td class="value"><div class="form-group"><input type="text" name="authors[{$authorIndex|escape}][url]" id="authors-{$authorIndex|escape}-url" value="{$author.url|escape}" size="30" maxlength="255" class="form-control" /></div></td>
						</tr>
						<tr valign="top">
							<td width="30%">{fieldLabel name="authors-$authorIndex-affiliation" key="user.affiliation"}</td>
							<td width="70%" class="value"><div class="form-group"><textarea name="authors[{$authorIndex|escape}][affiliation][{$formLocale|escape}]" class="form-control" id="authors-{$authorIndex|escape}-affiliation" rows="5" cols="40">{$author.affiliation[$formLocale]|escape}</textarea></div></td>
						</tr>
						<tr valign="top">
							<td width="30%">{fieldLabel name="authors-$authorIndex-country" key="common.country"}</td>
							<td width="70%" class="value">
								<div class="form-group">
									<select name="authors[{$authorIndex|escape}][country]" id="authors-{$authorIndex|escape}-country" class="form-control">
										<option value=""></option>
										{html_options options=$countries selected=$author.country}
									</select>
								</div>
							</td>
						</tr>
						{if $journal->getSetting('requireAuthorCompetingInterests')}
							<tr valign="top">
								<td width="30%">{fieldLabel name="authors-$authorIndex-competingInterests" key="author.competingInterests" competingInterestGuidelinesUrl=$competingInterestGuidelinesUrl}</td>
								<td width="70%" class="value"><div class="form-group"><textarea name="authors[{$authorIndex|escape}][competingInterests][{$formLocale|escape}]" class="form-control" id="authors-{$authorIndex|escape}-competingInterests" rows="5" cols="40">{$author.competingInterests[$formLocale]|escape}</textarea></div></td>
							</tr>
						{/if}{* requireAuthorCompetingInterests *}
						<tr valign="top">
							<td width="30%">{fieldLabel name="authors-$authorIndex-biography" key="user.biography"}<br />{translate key="user.biography.description"}</td>
							<td width="70%" class="value"><div class="form-group"><textarea name="authors[{$authorIndex|escape}][biography][{$formLocale|escape}]" class="form-control" id="authors-{$authorIndex|escape}-biography" rows="5" cols="40">{$author.biography[$formLocale]|escape}</textarea></div></td>
						</tr>
						{if $smarty.foreach.authors.total > 1}
							<tr valign="top">
								<td colspan="2">
									<a href="javascript:moveAuthor('u', '{$authorIndex|escape}')" class="action">&uarr;</a> <a href="javascript:moveAuthor('d', '{$authorIndex|escape}')" class="action">&darr;</a>
									<p class="help-block">{translate key="author.submit.reorderInstructions"}</p>
								</td>
							</tr>
							<tr valign="top">
								<td width="70%" class="value" colspan="2"><div class="form-group"><input type="radio" id="primaryContact" name="primaryContact" value="{$authorIndex|escape}"{if $primaryContact == $authorIndex} checked="checked"{/if} /> {fieldLabel name="primaryContact" key="author.submit.selectPrincipalContact"}</div> <input type="submit" name="delAuthor[{$authorIndex|escape}]" value="{translate key="author.submit.deleteAuthor"}" class="btn btn-danger" /></td>
							</tr>
							<tr>
								<td colspan="2"><br/></td>
							</tr>
						{/if}
					</table>
				</div>

				{if !$smarty.foreach.authors.last}<div class="separator" style="width:70%"></div>{/if}
			{foreachelse}
				<input type="hidden" name="authors[0][authorId]" value="0" />
				<input type="hidden" name="primaryContact" value="0" />
				<input type="hidden" name="authors[0][seq]" value="1" />
				
				<div class="table-responsive">
					<table width="100%" class="table table-striped">
						<tr valign="top">
							<td width="30%">{fieldLabel name="authors-0-firstName" required="true" key="user.firstName"}</td>
							<td width="70%" class="value"><div class="form-group"><input type="text" class="form-control" name="authors[0][firstName]" id="authors-0-firstName" size="20" maxlength="40" /></div></td>
						</tr>
						<tr valign="top">
							<td width="30%">{fieldLabel name="authors-0-middleName" key="user.middleName"}</td>
							<td width="70%" class="value"><div class="form-group"><input type="text" class="form-control" name="authors[0][middleName]" id="authors-0-middleName" size="20" maxlength="40" /></div></td>
						</tr>
						<tr valign="top">
							<td width="30%">{fieldLabel name="authors-0-lastName" required="true" key="user.lastName"}</td>
							<td width="70%" class="value"><div class="form-group"><input type="text" class="form-control" name="authors[0][lastName]" id="authors-0-lastName" size="20" maxlength="90" /></div></td>
						</tr>
						<tr valign="top">
							<td width="30%">{fieldLabel name="authors-0-affiliation" key="user.affiliation"}</td>
							<td width="70%" class="value"><div class="form-group"><textarea name="authors[0][affiliation][{$formLocale|escape}]" class="form-control" id="authors-0-affiliation" rows="5" cols="40"></textarea></div></td>
						</tr>
						<tr valign="top">
							<td width="30%">{fieldLabel name="authors-0-country" key="common.country"}</td>
							<td width="70%" class="value">
								<div class="form-group">
									<select name="authors[0][country]" id="authors-0-country" class="form-control">
										<option value=""></option>
										{html_options options=$countries}
									</select>
								</div>
							</td>
						</tr>
						<tr valign="top">
							<td width="30%">{fieldLabel name="authors-0-email" required="true" key="user.email"}</td>
							<td width="70%" class="value"><div class="form-group"><input type="text" class="form-control" name="authors[0][email]" id="authors-0-email" size="30" maxlength="90" /></div></td>
						</tr>
						<tr valign="top">
							<td width="20%">{fieldLabel name="authors-0-orcid" key="user.orcid"}</td>
							<td width="80%" class="value"><div class="form-group"><input type="text" class="form-control" name="authors[0][orcid]" id="authors-0-orcid" size="30" maxlength="90" /></div><p class="help-block">{translate key="user.orcid.description"}</p></td>
						</tr>
						<tr valign="top">
							<td width="30%">{fieldLabel name="authors-0-url" key="user.url"}</td>
							<td width="70%" class="value"><div class="form-group"><input type="text" class="form-control" name="authors[0][url]" id="authors-0-url" size="30" maxlength="255" /></div></td>
						</tr>
						{if $journal->getSetting('requireAuthorCompetingInterests')}
							<tr valign="top">
								<td width="30%">{fieldLabel name="authors-0-competingInterests" key="author.competingInterests" competingInterestGuidelinesUrl=$competingInterestGuidelinesUrl}</td>
								<td width="70%" class="value"><div class="form-group"><textarea name="authors[0][competingInterests][{$formLocale|escape}]" class="form-control" id="authors-0-competingInterests" rows="5" cols="40"></textarea></div></td>
							</tr>
						{/if}
						<tr valign="top">
							<td width="30%">{fieldLabel name="authors-0-biography" key="user.biography"}<label class="help-block">{translate key="user.biography.description"}</label></td>
							<td width="70%" class="value"><div class="form-group"><textarea name="authors[0][biography][{$formLocale|escape}]" class="form-control" id="authors-0-biography" rows="5" cols="40"></textarea></div></td>
						</tr>
					</table>
				</div>
			{/foreach}

			<p><input type="submit" class="btn btn-success" name="addAuthor" value="{translate key="author.submit.addAuthor"}" /></p>
		</div> <!-- /authors -->

		<div id="titleAndAbstract" class="col-md-12 mag-innert-left">
			<h4>{translate key="submission.titleAndAbstract"}</h4>

			<div class="table-responsive">
				<table width="100%" class="table table-striped">
					<tr valign="top">
						<td width="30%">{fieldLabel name="title" required="true" key="article.title"}</td>
						<td width="70%" class="value"><div class="form-group"><input type="text" class="form-control" name="title[{$formLocale|escape}]" id="title" value="{$title[$formLocale]|escape}" size="60" /></div></td>
					</tr>
					<tr valign="top">
						{if $sectionAbstractsRequired[$sectionId]}
							{* If a section is already chosen, respect the "required" flag *}
							{assign var=abstractRequired value="true"}
						{/if}
						<td width="30%">{fieldLabel name="abstract" key="article.abstract" required=$abstractRequired}<span id="abstractRequiredAsterisk" style="visibility: hidden;">*</div></td>
						<td width="70%" class="value"><div class="form-group"><textarea name="abstract[{$formLocale|escape}]" id="abstract" class="form-control" rows="15" cols="60">{$abstract[$formLocale]|escape}</textarea></div></td>
					</tr>
				</table>
			</div>
		</div> <!-- /titleAndAbstract -->

		<div id="indexing" class="col-md-12 mag-innert-left">
			<h4>{translate key="submission.indexing"}</h4>
			{if $journal->getSetting('metaDiscipline') || $journal->getSetting('metaSubjectClass') || $journal->getSetting('metaSubject') || $journal->getSetting('metaCoverage') || $journal->getSetting('metaType')}<p class="help-block">{translate key="author.submit.submissionIndexingDescription"}</p>{/if}
			
			<div class="table-responsive">
				<table width="100%" class="table table-striped">
					{if $journal->getSetting('metaDiscipline')}
						<tr valign="top">
							<td{if $journal->getLocalizedSetting('metaDisciplineExamples') != ''} rowspan="2"{/if} width="30%">{fieldLabel name="discipline" key="article.discipline"}</td>
							<td width="70%" class="value"><div class="form-group"><input type="text" class="form-control" name="discipline[{$formLocale|escape}]" id="discipline" value="{$discipline[$formLocale]|escape}" size="40" maxlength="255" /></div></td>
						</tr>
						{if $journal->getLocalizedSetting('metaDisciplineExamples')}
							<tr valign="top">
								<td><span class="help-block">{$journal->getLocalizedSetting('metaDisciplineExamples')|escape}</span></td>
							</tr>
						{/if}
						<tr valign="top">
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
					{/if}

					{if $journal->getSetting('metaSubjectClass')}
						<tr valign="top">
							<td rowspan="2" width="30%">{fieldLabel name="subjectClass" key="article.subjectClassification"}</td>
							<td width="70%" class="value"><div class="form-group"><input type="text" class="form-control" name="subjectClass[{$formLocale|escape}]" id="subjectClass" value="{$subjectClass[$formLocale]|escape}" size="40" maxlength="255" /></div></td>
						</tr>
						<tr valign="top">
							<td width="30%"><a href="{$journal->getLocalizedSetting('metaSubjectClassUrl')|escape}" target="_blank">{$journal->getLocalizedSetting('metaSubjectClassTitle')|escape}</a></td>
						</tr>
						<tr valign="top">
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
					{/if}

					{if $journal->getSetting('metaSubject')}
						<tr valign="top">
							<td{if $journal->getLocalizedSetting('metaSubjectExamples') != ''} rowspan="2"{/if} width="30%">{fieldLabel name="subject" key="article.subject"}</td>
							<td width="70%" class="value"><div class="form-group"><input type="text" class="form-control" name="subject[{$formLocale|escape}]" id="subject" value="{$subject[$formLocale]|escape}" size="40" maxlength="255" /></div></td>
						</tr>
						{if $journal->getLocalizedSetting('metaSubjectExamples') != ''}
							<tr valign="top">
								<td><span class="help-block">{$journal->getLocalizedSetting('metaSubjectExamples')|escape}</span></td>
							</tr>
						{/if}
						<tr valign="top">
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
					{/if}

					{if $journal->getSetting('metaCoverage')}
						<tr valign="top">
							<td{if $journal->getLocalizedSetting('metaCoverageGeoExamples') != ''} rowspan="2"{/if} width="30%">{fieldLabel name="coverageGeo" key="article.coverageGeo"}</td>
							<td width="70%" class="value"><div class="form-group"><input type="text" class="form-control" name="coverageGeo[{$formLocale|escape}]" id="coverageGeo" value="{$coverageGeo[$formLocale]|escape}" size="40" maxlength="255" /></div></td>
						</tr>
						{if $journal->getLocalizedSetting('metaCoverageGeoExamples')}
							<tr valign="top">
								<td><span class="help-block">{$journal->getLocalizedSetting('metaCoverageGeoExamples')|escape}</span></td>
							</tr>
						{/if}
						<tr valign="top">
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						<tr valign="top">
							<td{if $journal->getLocalizedSetting('metaCoverageChronExamples') != ''} rowspan="2"{/if} width="30%">{fieldLabel name="coverageChron" key="article.coverageChron"}</td>
							<td width="70%" class="value"><div class="form-group"><input type="text" class="form-control" name="coverageChron[{$formLocale|escape}]" id="coverageChron" value="{$coverageChron[$formLocale]|escape}" size="40" maxlength="255" /></div></td>
						</tr>
						{if $journal->getLocalizedSetting('metaCoverageChronExamples') != ''}
							<tr valign="top">
								<td><span class="help-block">{$journal->getLocalizedSetting('metaCoverageChronExamples')|escape}</span></td>
							</tr>
						{/if}
						<tr valign="top">
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						<tr valign="top">
							<td{if $journal->getLocalizedSetting('metaCoverageResearchSampleExamples') != ''} rowspan="2"{/if} width="30%">{fieldLabel name="coverageSample" key="article.coverageSample"}</td>
							<td width="70%" class="value"><div class="form-group"><input type="text" class="form-control" name="coverageSample[{$formLocale|escape}]" id="coverageSample" value="{$coverageSample[$formLocale]|escape}" size="40" maxlength="255" /></div></td>
						</tr>
						{if $journal->getLocalizedSetting('metaCoverageResearchSampleExamples') != ''}
							<tr valign="top">
								<td><span class="help-block">{$journal->getLocalizedSetting('metaCoverageResearchSampleExamples')|escape}</span></td>
							</tr>
						{/if}
						<tr valign="top">
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
					{/if}

					{if $journal->getSetting('metaType')}
						<tr valign="top">
							<td width="30%" {if $journal->getLocalizedSetting('metaTypeExamples') != ''}rowspan="2" {/if}>{fieldLabel name="type" key="article.type"}</td>
							<td width="70%" class="value"><div class="form-group"><input type="text" class="form-control" name="type[{$formLocale|escape}]" id="type" value="{$type[$formLocale]|escape}" size="40" maxlength="255" /></div></td>
						</tr>

						{if $journal->getLocalizedSetting('metaTypeExamples') != ''}
							<tr valign="top">
								<td><span class="help-block">{$journal->getLocalizedSetting('metaTypeExamples')|escape}</span></td>
							</tr>
						{/if}
						<tr valign="top">
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
					{/if}

					<tr valign="top">
						<td rowspan="2" width="30%">{fieldLabel name="language" key="article.language"}</td>
						<td width="70%" class="value"><div class="form-group"><input type="text" class="form-control" name="language" id="language" value="{$language|escape}" size="5" maxlength="10" /></div></td>
					</tr>
					<tr valign="top">
						<td><span class="help-block">{translate key="author.submit.languageInstructions"}</span></td>
					</tr>
				</table>
			</div>
		</div> <!-- /indexing -->

		<div id="submissionSupportingAgencies" class="col-md-12 mag-innert-left">
			<h3>{translate key="author.submit.submissionSupportingAgencies"}</h3>
			<p class="help-block">{translate key="author.submit.submissionSupportingAgenciesDescription"}</p>

			<div class="table-responsive">
				<table width="100%" class="table table-striped">
					<tr valign="top">
						<td width="30%">{fieldLabel name="sponsor" key="submission.agencies"}</td>
						<td width="70%" class="value"><div class="form-group"><input type="text" class="form-control" name="sponsor[{$formLocale|escape}]" id="sponsor" value="{$sponsor[$formLocale]|escape}" size="60" maxlength="255" /></div></td>
					</tr>
				</table>
			</div>
		</div> <!-- /submissionSupportingAgencies -->

		{if $journal->getSetting('metaCitations')}
			<div id="metaCitations" class="col-md-12 mag-innert-left">
				<h4>{translate key="submission.citations"}</h4>
				<p class="help-block">{translate key="author.submit.submissionCitations"}</p>

				<div class="table-responsive">
					<table width="100%" class="table table-striped">
						<tr valign="top">
							<td width="30%">{fieldLabel name="citations" key="submission.citations"}</td>
							<td width="70%" class="value"><div class="form-group"><textarea name="citations" id="citations" class="form-control" rows="15" cols="60">{$citations|escape}</textarea></div></td>
						</tr>
					</table>
				</div>
			</div> <!-- /metaCitations -->
		{/if}
	</div> <!-- /submission -->

	<div class="separator"></div>

	<p><input type="submit" value="{translate key="common.saveAndContinue"}" class="btn btn-success" />
	<input type="submit" class="btn btn-success" name="createAnother" value="{translate key="plugins.importexport.quickSubmit.saveAndCreateAnother"}" />
	<input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="confirmAction('{url page="author"}', '{translate|escape:"jsparam" key="author.submit.cancelSubmission"}')" /></p>

	<p><span class="help-block">{translate key="common.requiredField"}</span></p>
</form>

{if $scrollToAuthor}
	{literal}
	<script type="text/javascript">
		var authors = document.getElementById('authors');
		authors.scrollIntoView(false);
	</script>
	{/literal}
{/if}

{include file="common/footer.tpl"}