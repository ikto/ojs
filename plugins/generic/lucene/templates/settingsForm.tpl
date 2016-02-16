{**
 * plugins/generic/lucene/templates/settingsForm.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Lucene plugin settings
 *}
{strip}
{assign var="pageTitle" value="plugins.generic.lucene.settings.luceneSettings"}
{include file="common/header.tpl"}
{/strip}

<div id="luceneSettings" class="col-md-12 mag-innert-left">

	<form role="form" method="post" action="{plugin_url path="settings"}">
	
		{include file="common/formErrors.tpl"}

		<h3>{translate key="plugins.generic.lucene.settings.solrServerSettings"}</h3>
		<div id="description"><p class="help-block">{translate key="plugins.generic.lucene.settings.description"}</p></div>
		
		<div class="separator"></div>
		
		<br />

		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="20%">{fieldLabel name="searchEndpoint" required="true" key="plugins.generic.lucene.settings.searchEndpoint"}</td>
					<td class="value"><div class="form-group"><input type="text" name="searchEndpoint" id="searchEndpoint" value="{$searchEndpoint|escape}" size="45" maxlength="255" class="form-control" /></div>
						<br />
						<span class="help-block">{translate key="plugins.generic.lucene.settings.searchEndpointInstructions"}</span>
					</td>
				</tr>
				<tr valign="top">
					<td>{fieldLabel name="username" required="true" key="plugins.generic.lucene.settings.username"}</td>
					<td class="value"><div class="form-group"><input type="text" name="username" id="username" value="{$username|escape}" size="15" maxlength="25" class="form-control" /></div>
						<br />
						<span class="help-block">{translate key="plugins.generic.lucene.settings.usernameInstructions"}</span>
					</td>
				</tr>
				<tr valign="top">
					<td>{fieldLabel name="password" required="true" key="plugins.generic.lucene.settings.password"}</td>
					<td class="value"><div class="form-group"><input type="password" name="password" id="password" value="{$password|escape}" size="15" maxlength="25" class="form-control" /></div>
						<br />
						<span class="help-block">{translate key="plugins.generic.lucene.settings.passwordInstructions"}</span>
					</td>
				</tr>
				<tr valign="top">
					<td>{fieldLabel name="instId" required="true" key="plugins.generic.lucene.settings.instId"}</td>
					<td class="value"><div class="form-group"><input type="text" name="instId" id="instId" value="{$instId|escape}" size="15" maxlength="25" class="form-control" /></div>
						<br />
						<span class="help-block">{translate key="plugins.generic.lucene.settings.instIdInstructions"}</span>
					</td>
				</tr>
			</table>
		</div>
	
		<br />

		<h3>{translate key="plugins.generic.lucene.settings.searchFeatures"}</h3>
		<div id="featureDescription"><p class="help-block">{translate key="plugins.generic.lucene.settings.featureDescription"}</p></div>
	
		<div class="separator"></div>
	
		<br />

		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="5%" align="right"><div class="form-group"><input type="checkbox" name="autosuggest" id="autosuggest" {if $autosuggest}checked="checked" {/if}/></div></td>
					<td class="value">
						<label class="control-label" for="autosuggest">{translate key="plugins.generic.lucene.settings.autosuggest"}</label><br/>
						<br/>
						<div class="form-group">
							<select name="autosuggestType" id="autosuggestType" class="form-control">
								{html_options options=$autosuggestTypes selected=$autosuggestType}
							</select>
						</div>
						<p class="help-block">{translate key="plugins.generic.lucene.settings.autosuggestTypeExplanation"}</p>
					</td>
				</tr>
				<tr valign="top">
					<td align="right"><div class="form-group"><input type="checkbox" name="highlighting" id="highlighting" {if $highlighting}checked="checked" {/if}/></div></td>
					<td class="value">
						<label class="control-label" for="highlighting">{translate key="plugins.generic.lucene.settings.highlighting"}</label>
					</td>
				</tr>
				<tr valign="top">
					<script type="text/javascript">
					{literal}
						$(function() {
							var $facetingCheckbox = $('#faceting');
							var facetCategoryClass = '.plugins_generic_lucene_facetCategory';

							/**
							 * Toggling the faceting checkbox will (de-)select
							 * all facet categories.
							 */
							function toggleFaceting() {
								$(facetCategoryClass).each(function(index) {
									$(this).attr('checked', $facetingCheckbox.attr('checked'));
								});
							}
							$facetingCheckbox.click(toggleFaceting);

							/**
							 * Toggling a facet category checkbox will update
							 * the state fo the faceting checkbox: One or more
							 * selected facet categories will enable faceting.
							 * Faceting will be disabled when no category is
							 * being selected.
							 */
							function checkFacetingState() {
								var facetingEnabled = false;
								$(facetCategoryClass).each(function(index) {
									if (this.checked) facetingEnabled = true;
								});
								var facetingChecked = (facetingEnabled ? 'checked' : '');
								$facetingCheckbox.attr('checked', facetingChecked);
							 }
							 $(facetCategoryClass).click(checkFacetingState);
							 checkFacetingState();
						});
					{/literal}
					</script>
					<td align="right"><div class="form-group"><input type="checkbox" name="faceting" id="faceting" /></div></td>
					<td class="value">
						<label class="control-label" for="faceting">{translate key="plugins.generic.lucene.settings.faceting"}</label><br/>
						<p>
							{translate key="plugins.generic.lucene.settings.facetingSelectCategory"}:<br/>
							<div class="form-group"><input type="checkbox" class="plugins_generic_lucene_facetCategory" name="facetCategoryDiscipline" id="facetCategoryDiscipline" {if $facetCategoryDiscipline}checked="checked" {/if}/>&nbsp;{translate key="plugins.generic.lucene.faceting.discipline}</div>
							<div class="form-group"><input type="checkbox" class="plugins_generic_lucene_facetCategory" name="facetCategorySubject" id="facetCategorySubject" {if $facetCategorySubject}checked="checked" {/if}/>&nbsp;{translate key="plugins.generic.lucene.faceting.subject}</div>
							<div class="form-group"><input type="checkbox" class="plugins_generic_lucene_facetCategory" name="facetCategoryType" id="facetCategoryType" {if $facetCategoryType}checked="checked" {/if}/>&nbsp;{translate key="plugins.generic.lucene.faceting.type}</div>
							<div class="form-group"><input type="checkbox" class="plugins_generic_lucene_facetCategory" name="facetCategoryCoverage" id="facetCategoryCoverage" {if $facetCategoryCoverage}checked="checked" {/if}/>&nbsp;{translate key="plugins.generic.lucene.faceting.coverage}</div>
							<div class="form-group"><input type="checkbox" class="plugins_generic_lucene_facetCategory" name="facetCategoryJournalTitle" id="facetCategoryJournalTitle" {if $facetCategoryJournalTitle}checked="checked" {/if}/>&nbsp;{translate key="plugins.generic.lucene.faceting.journalTitle}</div>
							<div class="form-group"><input type="checkbox" class="plugins_generic_lucene_facetCategory" name="facetCategoryAuthors" id="facetCategoryAuthors" {if $facetCategoryAuthors}checked="checked" {/if}/>&nbsp;{translate key="plugins.generic.lucene.faceting.authors}</div>
							<div class="form-group"><input type="checkbox" class="plugins_generic_lucene_facetCategory" name="facetCategoryPublicationDate" id="facetCategoryPublicationDate" {if $facetCategoryPublicationDate}checked="checked" {/if}/>&nbsp;{translate key="plugins.generic.lucene.faceting.publicationDate}</div>
						</p>
					</td>
				</tr>
				<tr valign="top">
					<td align="right"><div class="form-group"><input type="checkbox" name="spellcheck" id="spellcheck" {if $spellcheck}checked="checked" {/if}/></div></td>
					<td class="value">
						<label class="control-label" for="spellcheck">{translate key="plugins.generic.lucene.settings.spellcheck"}</label>
					</td>
				</tr>
				<tr valign="top">
					<td align="right"><div class="form-group"><input type="checkbox" name="simdocs" id="simdocs" {if $simdocs}checked="checked" {/if}/></div></td>
					<td class="value">
						<label class="control-label" for="simdocs">{translate key="plugins.generic.lucene.settings.simdocs"}</label>
					</td>
				</tr>
				<tr valign="top">
					<td align="right"><div class="form-group"><input type="checkbox" name="customRanking" id="customRanking" {if $customRanking}checked="checked" {/if}/></div></td>
					<td class="value">
						<label class="control-label" for="customRanking">{translate key="plugins.generic.lucene.settings.customRanking"}</label>
					</td>
				</tr>
				<tr valign="top">
					<td align="right"><div class="form-group"><input type="checkbox" name="pullIndexing" id="pullIndexing" {if $pullIndexing}checked="checked" {/if}/></div></td>
					<td class="value">
						<label class="control-label" for="pullIndexing">{translate key="plugins.generic.lucene.settings.pullIndexing"}</label>
					</td>
				</tr>
			</table>
		</div>

		<br/>

		<input type="submit" name="save" class="btn btn-success" value="{translate key="common.save"}"/><input type="button" class="btn btn-danger" value="{translate key="common.cancel"}" onclick="history.go(-1)"/>
	</form>
</div>

<p><span class="help-block">{translate key="common.requiredField"}</span></p>

{include file="common/footer.tpl"}