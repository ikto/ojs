{**
 * plugins/auth/ldap/settings.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * LDAP authentication source settings.
 *
 *}
<br />
<div id="ldapSettings" class="table-responsive">
<h3>{translate key="plugins.auth.ldap.settings"}</h3>

<table class="table table-striped" width="100%">
	<tr valign="top">
		<td width="20%">{fieldLabel name="hostname" key="plugins.auth.ldap.settings.hostname"}</td>
		<td width="80%" class="value">
			<input type="text" id="hostname" name="settings[hostname]" value="{$settings.hostname|escape}" size="30" maxlength="255" class="textField" />
			<br />
			<p class="help-block">{translate key="plugins.auth.ldap.settings.hostname.description"}</p>
		</td>
	</tr>
	<tr valign="top">
		<td>{fieldLabel name="port" key="plugins.auth.ldap.settings.port"}</td>
		<td class="value">
			<input type="text" id="port" name="settings[port]" value="{$settings.port|escape}" size="8" maxlength="5" class="textField" />
			<br />
			<p class="help-block">{translate key="plugins.auth.ldap.settings.port.description"}</p>
		</td>
	</tr>
	<tr valign="top">
		<td>{fieldLabel name="basedn" key="plugins.auth.ldap.settings.basedn"}</td>
		<td class="value">
			<input type="text" id="basedn" name="settings[basedn]" value="{$settings.basedn|escape}" size="30" maxlength="255" class="textField" />
			<br />
			<p class="help-block">{translate key="plugins.auth.ldap.settings.basedn.description"}</p>
		</td>
	</tr>
	<tr valign="top">
		<td>{fieldLabel name="managerdn" key="plugins.auth.ldap.settings.managerdn"}</td>
		<td class="value">
			<input type="text" id="managerdn" name="settings[managerdn]" value="{$settings.managerdn|escape}" size="30" maxlength="255" class="textField" />
			<br />
			<p class="help-block">{translate key="plugins.auth.ldap.settings.managerdn.description"}</p>
		</td>
	</tr>
	<tr valign="top">
		<td>{fieldLabel name="uid" key="plugins.auth.ldap.settings.uid"}</td>
		<td class="value">
			<input type="text" id="uid" name="settings[uid]" value="{$settings.uid|escape}" size="30" maxlength="255" class="textField" />
			<br />
			<p class="help-block">{translate key="plugins.auth.ldap.settings.uid.description"}</p>
		</td>
	</tr>
	<tr valign="top">
		<td>{fieldLabel name="managerpwd" key="plugins.auth.ldap.settings.managerpwd"}</td>
		<td class="value">
			<input type="password" id="managerpwd" name="settings[managerpwd]" value="{$settings.managerpwd|escape}" size="30" maxlength="255" class="textField" />
			<br />
			<p class="help-block">{translate key="plugins.auth.ldap.settings.managerpwd.description"}</p>
		</td>
	</tr>
	<tr valign="top">
		<td>{fieldLabel name="pwhash" key="plugins.auth.ldap.settings.pwhash"}</td>
		<td class="value">
			<select name="settings[pwhash]" id="pwhash" size="1" class="selectMenu">
				<option value="">CLEARTEXT</option>
				<option value="ssha"{if $settings.pwhash == 'ssha'} selected="selected"{/if}>SSHA</option>
				<option value="sha"{if $settings.pwhash == 'sha'} selected="selected"{/if}>SHA</option>
				<option value="smd5"{if $settings.pwhash == 'smd5'} selected="selected"{/if}>SMD5</option>
				<option value="md5"{if $settings.pwhash == 'md5'} selected="selected"{/if}>MD5</option>
				<option value="crypt"{if $settings.pwhash == 'crypt'} selected="selected"{/if}>CRYPT</option>
			</select>
			<br />
			<p class="help-block">{translate key="plugins.auth.ldap.settings.pwhash.description"}</p>
		</td>
	</tr>
	<tr valign="top">
		<td colspan="2">
			<h4>{translate key="plugins.auth.ldap.settings.saslopt"}</h4>
		</td>
	</tr>
	<tr valign="top">
		<td align="right">
			<input type="checkbox" name="settings[sasl]" id="sasl" value="1"{if $settings.sasl} checked="checked"{/if} />
		</td>
		<td class="value">
			<label class="control-label" for="sasl">{translate key="plugins.auth.ldap.settings.sasl"}</label>
		</td>
	</tr>
	<tr valign="top">
		<td>{fieldLabel name="saslmech" key="plugins.auth.ldap.settings.saslmech"}</td>
		<td class="value">
			<input type="text" id="saslmech" name="settings[saslmech]" value="{$settings.saslmech|escape}" size="30" maxlength="255" class="textField" />
			<br />
			<p class="help-block">{translate key="plugins.auth.ldap.settings.saslmech.description"}</p>
		</td>
	</tr>
	<tr valign="top">
		<td>{fieldLabel name="saslrealm" key="plugins.auth.ldap.settings.saslrealm"}</td>
		<td class="value">
			<input type="text" id="saslrealm" name="settings[saslrealm]" value="{$settings.saslrealm|escape}" size="30" maxlength="255" class="textField" />
		</td>
	</tr>
	<tr valign="top">
		<td>{fieldLabel name="saslauthzid" key="plugins.auth.ldap.settings.saslauthzid"}</td>
		<td class="value">
			<input type="text" id="saslauthzid" name="settings[saslauthzid]" value="{$settings.saslauthzid|escape}" size="30" maxlength="255" class="textField" />
		</td>
	</tr>
	<tr valign="top">
		<td>{fieldLabel name="saslprop" key="plugins.auth.ldap.settings.saslprop"}</td>
		<td class="value">
			<input type="text" id="saslprop" name="settings[saslprop]" value="{$settings.saslprop|escape}" size="30" maxlength="255" class="textField" />
		</td>
	</tr>
</table>
</div>
