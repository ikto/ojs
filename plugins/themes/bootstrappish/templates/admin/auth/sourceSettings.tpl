{**
 * templates/admin/auth/sourceSettings.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Authentication source settings under site administration.
 *
 *}
{strip}
{assign var="pageTitle" value="admin.authSources"}
{include file="common/header.tpl"}
{/strip}

<br />

<div id="sourceSettings" class="col-md-12 mag-innert-left">
	<form role="form" method="post" action="{url op="updateAuthSource" path=$authId}">
		<div class="form-group">
			{fieldLabel name="title" key="common.title"}
			<input type="text" id="title" name="title" value="{$title|escape}" maxlength="120" class="form-control" />
		</div>
		
		<h4>{translate key="common.options"}</h4>
		
		<div class="form-group">
			<input type="checkbox" name="settings[syncProfiles]" id="syncProfiles" value="1"{if $settings.syncProfiles} checked="checked"{/if} />
			<label class="control-label" for="syncProfiles">{translate key="admin.auth.enableSyncProfiles"}</label>	    
		</div>
			 
		<div class="form-group">
			<input type="checkbox" name="settings[syncPasswords]" id="syncPasswords" value="1"{if $settings.syncPasswords} checked="checked"{/if} />
			<label for="syncPasswords" class="control-label">{translate key="admin.auth.enableSyncPasswords"}</label>
		</div>
		
		<div class="form-group">
			<input type="checkbox" name="settings[createUsers]" id="createUsers" value="1"{if $settings.createUsers} checked="checked"{/if} />
			<label for="createUsers" class="control-label">{translate key="admin.auth.enableCreateUsers"}</label>
		</div>
		
		{if $pluginTemplate}{include file=$pluginTemplate}{/if}

		<p><input type="submit" value="{translate key="common.save"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url op="auth" escape=false}'" /></p>
	</form>
</div>

{include file="common/footer.tpl"}