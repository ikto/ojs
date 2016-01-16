{**
 * templates/about/submissions.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * About the Journal / Submissions.
 *
 *}
{strip}
{assign var="pageTitle" value="about.submissions"}
{include file="common/header.tpl"}
{/strip}

{if $currentJournal->getSetting('journalPaymentsEnabled') && 
		($currentJournal->getSetting('submissionFeeEnabled') || $currentJournal->getSetting('fastTrackFeeEnabled') || $currentJournal->getSetting('publicationFeeEnabled')) }
	{assign var="authorFees" value=1}
{/if}

<ul class="stay">
	<li> <a href="{url page="about" op="submissions" anchor="onlineSubmissions"}">{translate key="about.onlineSubmissions"}</a></li>
	{if $currentJournal->getLocalizedSetting('authorGuidelines') != ''}<li> <a href="{url page="about" op="submissions" anchor="authorGuidelines"}">{translate key="about.authorGuidelines"}</a></li>{/if}
	{if $currentJournal->getLocalizedSetting('copyrightNotice') != ''}<li> <a href="{url page="about" op="submissions" anchor="copyrightNotice"}">{translate key="about.copyrightNotice"}</a></li>{/if}
	{if $currentJournal->getLocalizedSetting('privacyStatement') != ''}<li> <a href="{url page="about" op="submissions" anchor="privacyStatement"}">{translate key="about.privacyStatement"}</a></li>{/if}
	{if $authorFees}<li> <a href="{url page="about" op="submissions" anchor="authorFees"}">{translate key="about.authorFees"}</a></li>{/if}	
</ul>

<div id="onlineSubmissions" class="col-md-12 mag-innert-left"><h3>{translate key="about.onlineSubmissions"}</h3>
<p class="text">
	{translate key="about.onlineSubmissions.haveAccount" journalTitle=$siteTitle|escape}<br />
	<a href="{url page="login"}">{translate key="about.onlineSubmissions.login"}</a>
</p>
<p class="text">
	{translate key="about.onlineSubmissions.needAccount"}<br />
	<a href="{url page="user" op="register"}">{translate key="about.onlineSubmissions.registration"}</a>
</p>
<p class="text">{translate key="about.onlineSubmissions.registrationRequired"}</p>

<div class="separator">&nbsp;</div>
</div>

{if $currentJournal->getLocalizedSetting('authorGuidelines') != ''}
<div id="authorGuidelines" class="col-md-12 mag-innert-left"><h3>{translate key="about.authorGuidelines"}</h3>
<p class="text">{$currentJournal->getLocalizedSetting('authorGuidelines')|nl2br}</p>

<div class="separator">&nbsp;</div>
</div>
{/if}

{if $submissionChecklist}
	<div id="submissionPreparationChecklist" class="col-md-12 mag-innert-left"><h3>{translate key="about.submissionPreparationChecklist"}</h3>
	<p class="text">{translate key="about.submissionPreparationChecklist.description"}</p>
	<ol>
		{foreach from=$submissionChecklist item=checklistItem}
			<li class="list-group-item1">{$checklistItem.content|nl2br}</li>	
		{/foreach}
	</ol>
	<div class="separator">&nbsp;</div>
	</div>
{/if}{* $submissionChecklist *}

{if $currentJournal->getLocalizedSetting('copyrightNotice') != ''}
<div id="copyrightNotice" class="col-md-12 mag-innert-left"><h3>{translate key="about.copyrightNotice"}</h3>
<p class="text">{$currentJournal->getLocalizedSetting('copyrightNotice')|nl2br}</p>

<div class="separator">&nbsp;</div>
</div>
{/if}

{if $currentJournal->getLocalizedSetting('privacyStatement') != ''}<div id="privacyStatement" class="col-md-12 mag-innert-left"><h3>{translate key="about.privacyStatement"}</h3>
<p class="text">{$currentJournal->getLocalizedSetting('privacyStatement')|nl2br}</p>

<div class="separator">&nbsp;</div>
</div>
{/if}

{if $authorFees}

<div id="authorFees" class="col-md-12 mag-innert-left"><h3>{translate key="manager.payment.authorFees"}</h3>
	<p class="text">{translate key="about.authorFeesMessage"}</p>
	{if $currentJournal->getSetting('submissionFeeEnabled')}
		<p class="text">{$currentJournal->getLocalizedSetting('submissionFeeName')|escape}: {$currentJournal->getSetting('submissionFee')|string_format:"%.2f"} ({$currentJournal->getSetting('currency')})<br />
		{$currentJournal->getLocalizedSetting('submissionFeeDescription')|nl2br}<p>
	{/if}
	{if $currentJournal->getSetting('fastTrackFeeEnabled')}
		<p class="text">{$currentJournal->getLocalizedSetting('fastTrackFeeName')|escape}: {$currentJournal->getSetting('fastTrackFee')|string_format:"%.2f"} ({$currentJournal->getSetting('currency')})<br />
		{$currentJournal->getLocalizedSetting('fastTrackFeeDescription')|nl2br}<p>	
	{/if}
	{if $currentJournal->getSetting('publicationFeeEnabled')}
		<p class="text">{$currentJournal->getLocalizedSetting('publicationFeeName')|escape}: {$currentJournal->getSetting('publicationFee')|string_format:"%.2f"} ({$currentJournal->getSetting('currency')})<br />
		{$currentJournal->getLocalizedSetting('publicationFeeDescription')|nl2br}<p>	
	{/if}
	{if $currentJournal->getLocalizedSetting('waiverPolicy') != ''}
		<p class="text">{$currentJournal->getLocalizedSetting('waiverPolicy')|nl2br}</p>
	{/if}
</div>
{/if}
{include file="common/footer.tpl"}

