{**
 * templates/install/install.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2000-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Installation form.
 *
 *}
{strip}
{include file="common/header.tpl"}
{/strip}

<script type="text/javascript">
{literal}
<!--
// Ensure that the form submit button cannot be double-clicked
function doSubmit() {
	var installForm = document.getElementById('install');
	if (installForm.installing.value != 1) {
		installForm.installing.value = 1;
		installForm.submit();
	}
	return true;
}
// -->
{/literal}
</script>

{if is_writeable('config.inc.php')}{translate|assign:"writable_config" key="installer.checkYes"}{else}{translate|assign:"writable_config" key="installer.checkNo"}{/if}
{if is_writeable('cache')}{translate|assign:"writable_cache" key="installer.checkYes"}{else}{translate|assign:"writable_cache" key="installer.checkNo"}{/if}
{if is_writeable('public')}{translate|assign:"writable_public" key="installer.checkYes"}{else}{translate|assign:"writable_public" key="installer.checkNo"}{/if}
{if is_writeable('cache/_db')}{translate|assign:"writable_db_cache" key="installer.checkYes"}{else}{translate|assign:"writable_db_cache" key="installer.checkNo"}{/if}
{if is_writeable('cache/t_cache')}{translate|assign:"writable_templates_cache" key="installer.checkYes"}{else}{translate|assign:"writable_templates_cache" key="installer.checkNo"}{/if}
{if is_writeable('cache/t_compile')}{translate|assign:"writable_templates_compile" key="installer.checkYes"}{else}{translate|assign:"writable_templates_compile" key="installer.checkNo"}{/if}

{if !$phpIsSupportedVersion}
	{translate|assign:"wrongPhpText" key="installer.installationWrongPhp"}
{/if}

{url|assign:"upgradeUrl" page="install" op="upgrade"}
{translate key="installer.installationInstructions" version=$version->getVersionString() upgradeUrl=$upgradeUrl baseUrl=$baseUrl writable_config=$writable_config writable_db_cache=$writable_db_cache writable_cache=$writable_cache writable_public=$writable_public writable_templates_cache=$writable_templates_cache writable_templates_compile=$writable_templates_compile phpRequiredVersion=$phpRequiredVersion wrongPhpText=$wrongPhpText phpVersion=$phpVersion}

<div class="separator"></div>

<form role="form" method="post" id="install" action="{url op="install"}">
	<input type="hidden" name="installing" value="0" />
	
	{include file="common/formErrors.tpl"}

	{if $isInstallError}
		<p>
			<p class="help-block">{translate key="installer.installErrorsOccurred"}:</p>
			<ul class="stay">
				<li>{if $dbErrorMsg}{translate key="common.error.databaseError" error=$dbErrorMsg}{else}{translate key=$errorMsg}{/if}</li>
			</ul>
		</p>
	{/if}

	<div id="localeSettings" class="col-md-12 mag-innert-left">
		<h3>{translate key="installer.localeSettings"}</h3>
		<p class="help-block">{translate key="installer.localeSettingsInstructions" supportsMBString=$supportsMBString}</p>

		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="20%">{fieldLabel name="locale" key="locale.primary"}</td>
					<td width="80%" class="value">
						<div class="form-group">
							<select name="locale" id="locale" size="1" class="form-control">
								{html_options options=$localeOptions selected=$locale}
							</select>
							<br />
							<p class="help-block">{translate key="installer.localeInstructions"}</p>
						</div>
					</td>
				</tr>
				<tr valign="top">
					<td>{fieldLabel suppressId="true" name="additionalLocales" key="installer.additionalLocales"}</td>
					<td class="value">
						{foreach from=$localeOptions key=localeKey item=localeName}
							<div class="form-group"><input type="checkbox" name="additionalLocales[]" id="additionalLocales-{$localeKey|escape}" value="{$localeKey|escape}"{if in_array($localeKey, $additionalLocales)} checked="checked"{/if} /> <label for="additionalLocales-{$localeKey|escape}">{$localeName|escape} ({$localeKey|escape})</label></div>
							{if !$localesComplete[$localeKey]}
								<p class="help-block">*</p>
								{assign var=incompleteLocaleFound value=1}
							{/if}<br />
						{/foreach}
						<p class="help-block">{translate key="installer.additionalLocalesInstructions"}</p>
						{if $incompleteLocaleFound}
							<br/>
							<p class="help-block">*</p>&nbsp;{translate key="installer.locale.maybeIncomplete"}
						{/if}{* $incompleteLocaleFound *}
					</td>
				</tr>
				<tr valign="top">
					<td>{fieldLabel name="clientCharset" key="installer.clientCharset"}</td>
					<td class="value">
						<div class="form-group">
							<select name="clientCharset" id="clientCharset" size="1" class="form-control">
								{html_options options=$clientCharsetOptions selected=$clientCharset}
							</select>
							<br />
							<p class="help-block">{translate key="installer.clientCharsetInstructions"}</p>
						</div>
					</td>
				</tr>
				<tr valign="top">
					<td>{fieldLabel name="connectionCharset" key="installer.connectionCharset"}</td>
					<td class="value">
						<div class="form-group">
							<select name="connectionCharset" id="connectionCharset" size="1" class="form-control">
								{html_options options=$connectionCharsetOptions selected=$connectionCharset}
							</select>
							<br />
							<p class="help-block">{translate key="installer.connectionCharsetInstructions"}</p>
						</div>
					</td>
				</tr>
				<tr valign="top">
					<td>{fieldLabel name="databaseCharset" key="installer.databaseCharset"}</td>
					<td class="value">
						<div class="form-group">
							<select name="databaseCharset" id="databaseCharset" size="1" class="form-control">
								{html_options options=$databaseCharsetOptions selected=$databaseCharset}
							</select>
							<br />
							<p class="help-block">{translate key="installer.databaseCharsetInstructions"}</p>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<div class="separator"></div>

	{if !$skipFilesDirSection}
		<div id="fileSettings" class="col-md-12 mag-innert-left">
			<h3>{translate key="installer.fileSettings"}</h3>

			<div class="table-responsive">
				<table width="100%" class="table table-striped">
					<tr valign="top">
						<td width="20%">{fieldLabel name="filesDir" key="installer.filesDir"}</td>
						<td width="80%" class="value">
							<div class="form-group">
								<input type="text" name="filesDir" id="filesDir" value="{$filesDir|escape}" size="60" maxlength="255" class="form-control" />
								<br />
								<p class="help-block">{translate key="installer.filesDirInstructions"}</p>
							</div>
						</td>
					</tr>
					<tr valign="top">
						<td>&nbsp;</td>
						<td class="value">
							<p class="help-block">{translate key="installer.allowFileUploads" allowFileUploads=$allowFileUploads}</p>
							<p class="help-block">{translate key="installer.maxFileUploadSize" maxFileUploadSize=$maxFileUploadSize}</p>
						</td>
					</tr>
				</table>
			</div>

			<div class="separator"></div>

		</div>
	{/if}{* !$skipFilesDirSection *}

	<div id="security" class="col-md-12 mag-innert-left">
		<h3>{translate key="installer.securitySettings"}</h3>

		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="20%">{fieldLabel name="encryption" key="installer.encryption"}</td>
					<td width="80%" class="value">
						<div class="form-group">
							<select name="encryption" id="encryption" size="1" class="form-control">
								{html_options options=$encryptionOptions selected=$encryption}
							</select>
							<br />
							<p class="help-block">{translate key="installer.encryptionInstructions"}</p>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<div class="separator"></div>

	<div id="administratorAccount" class="col-md-12 mag-innert-left">
		<h3>{translate key="installer.administratorAccount"}</h3>
		<p class="help-block">{translate key="installer.administratorAccountInstructions"}</p>

		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="20%">{fieldLabel name="adminUsername" key="user.username"}</td>
					<td width="80%" class="value"><div class="form-group"><input type="text" name="adminUsername" id="adminUsername" value="{$adminUsername|escape}" size="20" maxlength="32" class="form-control" /></div></td>
				</tr>
				<tr valign="top">
					<td>{fieldLabel name="adminPassword" key="user.password"}</td>
					<td class="value"><div class="form-group"><input type="password" name="adminPassword" id="adminPassword" value="{$adminPassword|escape}" size="20" class="form-control" /></div></td>
				</tr>
				<tr valign="top">
					<td></td>
					<td><label class="help-block">{translate key="user.register.passwordLengthRestriction" length=$passwordLength}</label></td>
				</tr>
				<tr valign="top">
					<td>{fieldLabel name="adminPassword2" key="user.repeatPassword"}</td>
					<td class="value"><div class="form-group"><input type="password" name="adminPassword2" id="adminPassword2" value="{$adminPassword2|escape}" size="20" class="form-control" /></div></td>
				</tr>
				<tr valign="top">
					<td width="20%">{fieldLabel name="adminEmail" key="user.email"}</td>
					<td width="80%" class="value"><div class="form-group"><input type="text" name="adminEmail" id="adminEmail" value="{$adminEmail|escape}" size="30" maxlength="90" class="form-control" /></div></td>
				</tr>
			</table>
		</div>
	</div>

	<div class="separator"></div>

	<div id="databaseSettings" class="col-md-12 mag-innert-left">
		<h3>{translate key="installer.databaseSettings"}</h3>
		<p class="help-block">{translate key="installer.databaseSettingsInstructions"}</p>

		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="20%">{fieldLabel name="databaseDriver" key="installer.databaseDriver"}</td>
					<td width="80%" class="value">
						<div class="form-group">
							<select name="databaseDriver" id="databaseDriver" size="1" class="form-control">
								{html_options options=$databaseDriverOptions selected=$databaseDriver}
							</select>
							<br />
							<p class="help-block">{translate key="installer.databaseDriverInstructions"}</p>
						</div>
					</td>
				</tr>
				<tr valign="top">
					<td>{fieldLabel name="databaseHost" key="installer.databaseHost"}</td>
					<td class="value">
						<div class="form-group">
							<input type="text" name="databaseHost" id="databaseHost" value="{$databaseHost|escape}" size="30" maxlength="60" class="form-control" />
							<br />
							<p class="help-block">{translate key="installer.databaseHostInstructions"}</p>
						</div>
					</td>
				</tr>
				<tr valign="top">
					<td>{fieldLabel name="databaseUsername" key="installer.databaseUsername"}</td>
					<td class="value"><div class="form-group"><input type="text" name="databaseUsername" id="databaseUsername" value="{$databaseUsername|escape}" size="30" maxlength="60" class="form-control" /></div></td>
				</tr>
				<tr valign="top">
					<td>{fieldLabel name="databasePassword" key="installer.databasePassword"}</td>
					<td class="value"><div class="form-group"><input type="text" name="databasePassword" id="databasePassword" value="{$databasePassword|escape}" size="30" maxlength="60" class="form-control" /></div></td>
				</tr>
				<tr valign="top">
					<td>{fieldLabel name="databaseName" key="installer.databaseName"}</td>
					<td class="value"><div class="form-group"><input type="text" name="databaseName" id="databaseName" value="{$databaseName|escape}" size="30" maxlength="60" class="form-control" /></div></td>
				</tr>
				<tr valign="top">
					<td>&nbsp;</td>
					<td class="value">
						<div class="form-group"><input type="checkbox" name="createDatabase" id="createDatabase" value="1"{if $createDatabase} checked="checked"{/if} /> <label for="createDatabase">{translate key="installer.createDatabase"}</label></div>
						<br />
						<p class="help-block">{translate key="installer.createDatabaseInstructions"}</p>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<div class="separator"></div>

	<div id="oaiSettings" class="col-md-12 mag-innert-left">
		<h3>{translate key="installer.oaiSettings"}</h3>
			
		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="20%">{fieldLabel name="oaiRepositoryId" key="installer.oaiRepositoryId"}</td>
					<td width="80%" class="value">
						<div class="form-group">
							<input type="text" name="oaiRepositoryId" id="oaiRepositoryId" value="{$oaiRepositoryId|escape}" size="30" maxlength="60" class="form-control" />
							<br />
							<p class="help-block">{translate key="installer.oaiRepositoryIdInstructions"}</p>
						</div>
					</td>
				</tr>
			</table>
		</div>

		<div class="separator"></div>

	</div>

	<div id="beaconDiv" class="col-md-12 mag-innert-left">
		<h3>{translate key="installer.beacon"}</h3>

		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="20%">&nbsp;</td>
					<td width="80%" class="value">
						<div class="form-group">
							<input type="checkbox" name="enableBeacon" id="enableBeacon" {if $enableBeacon}checked="checked" {/if}/>
							{fieldLabel name="enableBeacon" key="installer.beacon.enable"}
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<div class="separator"></div>

	<p><input name="install" type="button" id="install" value="{translate key="installer.installApplication"}" class="btn btn-success" onclick="doSubmit()" /></p>
</form>

{include file="common/footer.tpl"}