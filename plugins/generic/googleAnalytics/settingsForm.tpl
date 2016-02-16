{**
 * plugins/generic/googleAnalytics/settingsForm.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Google Analytics plugin settings
 *
 *}
{strip}
{assign var="pageTitle" value="plugins.generic.googleAnalytics.manager.googleAnalyticsSettings"}
{include file="common/header.tpl"}
{/strip}

<div id="googleAnalyticsSettings" class="col-md-12 mag-innert-left">
	<div id="description"><p class="help-block">{translate key="plugins.generic.googleAnalytics.manager.settings.description"}</p></div>

	<div class="separator"></div>

	<br />

	<form role="form" method="post" action="{plugin_url path="settings"}">
		
		{include file="common/formErrors.tpl"}

		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="20%">{fieldLabel name="googleAnalyticsSiteId" required="true" key="plugins.generic.googleAnalytics.manager.settings.googleAnalyticsSiteId"}</td>
					<td width="80%" class="value"><div class="form-group"><input type="text" name="googleAnalyticsSiteId" id="googleAnalyticsSiteId" value="{$googleAnalyticsSiteId|escape}" size="15" maxlength="25" class="form-control" /></div>
						<br />
						<span class="help-block">{translate key="plugins.generic.googleAnalytics.manager.settings.googleAnalyticsSiteIdInstructions"}</span>
					</td>
				</tr>
				<tr valign="top">
					<td width="20%">{fieldLabel name="trackingCode-urchin" required="true" key="plugins.generic.googleAnalytics.manager.settings.trackingCode"}</td>
					<td width="80%" class="value">
						<div class="form-group"><input type="radio" name="trackingCode" id="trackingCode-urchin" value="urchin" {if $trackingCode eq "urchin" || $trackingCode eq ""}checked="checked" {/if}/> {fieldLabel name="trackingCode-urchin" key="plugins.generic.googleAnalytics.manager.settings.urchin"}</div>
						<div class="form-group"><input type="radio" name="trackingCode" id="trackingCode-ga" value="ga" {if $trackingCode eq "ga"}checked="checked" {/if}/> {fieldLabel name="trackingCode-ga" key="plugins.generic.googleAnalytics.manager.settings.ga"}</div>
						<div class="form-group"><input type="radio" name="trackingCode" id="trackingCode-analytics" value="analytics" {if $trackingCode eq "analytics"}checked="checked" {/if}/> {fieldLabel name="trackingCode-analytics" key="plugins.generic.googleAnalytics.manager.settings.analytics"}</div>
					</td>
				</tr>
				{if $siteAdmin}
					<tr valign="top">
						<td width="20%">{fieldLabel name="enableSite" key="plugins.generic.googleAnalytics.manager.settings.enableSite"}</td>
						<td width="80%" class="value">
							<div>
								<span class="help-block">{translate key="plugins.generic.googleAnalytics.manager.settings.enableSiteInstructions"}</span>
							</div>
							<div class="form-group"><input type="radio" name="enableSite" id="enableSite-true" value="{$smarty.const.GOOGLE_ANALYTICS_SITE_ENABLE}" {if $trackingCode eq GOOGLE_ANALYTICS_SITE_ENABLE}checked="checked" {/if}/> {fieldLabel name="enableSite-true" key="plugins.generic.googleAnalytics.manager.settings.siteEnable"}</div>
							<div>
								<div class="form-group"><input type="radio" name="enableSite" id="enableSite-unchanged" value="{$smarty.const.GOOGLE_ANALYTICS_SITE_UNCHANGED}" {if $trackingCode eq GOOGLE_ANALYTICS_SITE_UNCHANGED || $trackingCode eq ""}checked="checked" {/if}/> {fieldLabel name="enableSite-unchanged" key="plugins.generic.googleAnalytics.manager.settings.siteUnchanged"}</div>
								<dl>
									<dt>{translate key="plugins.generic.googleAnalytics.manager.settings.googleAnalyticsSiteId"}</dt>
									<dd>{$siteGoogleAnalyticsSiteId|escape}</dd>
									<dt>{translate key="plugins.generic.googleAnalytics.manager.settings.trackingCode"}</dt>
									<dd>
										{if $siteTrackingCode eq "analytics"}{translate key="plugins.generic.googleAnalytics.manager.settings.analytics"}
										{elseif $siteTrackingCode eq "ga"}{translate key="plugins.generic.googleAnalytics.manager.settings.ga"}
										{elseif $siteTrackingCode eq "urchin"}{translate key="plugins.generic.googleAnalytics.manager.settings.urchin"}
										{else}{$siteTrackingCode}
										{/if}
									</dd>
								</dl>
							</div>
							{if $siteEnabled}
								<div class="form-group"><input type="radio" name="enableSite" id="enableSite-false" value="{$smarty.const.GOOGLE_ANALYTICS_SITE_DISABLE}" {if $trackingCode eq GOOGLE_ANALYTICS_SITE_DISABLE}checked="checked" {/if}/> {fieldLabel name="enableSite-false" key="plugins.generic.googleAnalytics.manager.settings.siteDisable"}</div>
							{/if}
						</td>
					</tr>
				{/if}
			</table>
		</div>

		<br/>

		<input type="submit" name="save" class="btn btn-success" value="{translate key="common.save"}"/><input type="button" class="btn btn-danger" value="{translate key="common.cancel"}" onclick="history.go(-1)"/>
	</form>
</div>

<p><span class="help-block">{translate key="common.requiredField"}</span></p>

{include file="common/footer.tpl"}