{**
 * plugins/generic/lucene/templates/additionalSectionMetadata.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * A template to be included via Templates::Manager::Sections::SectionForm::AdditionalMetadata hook.
 *}

<tr valign="top">
	<td>{fieldLabel name="rankingBoost" key="plugins.generic.lucene.sectionForm.rankingBoost"}</td>
	<td class="value">
		<span class="help-block">{translate key="plugins.generic.lucene.sectionForm.rankingBoostInstructions"}</span><br />
		<p><div class="form-group"><select name="rankingBoostOption" size="1" id="rankingBoostOption" class="form-control">
			{html_options options=$rankingBoostOptions selected=$rankingBoostOption}
		</select></div></p>
	</td>
</tr>