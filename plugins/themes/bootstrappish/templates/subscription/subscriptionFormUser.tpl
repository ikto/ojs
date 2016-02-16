{**
 * templates/subscription/subscriptionFormUser.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common subscription fields
 *
 *}

<tr valign="top">
	<td>&nbsp;</td>
	<td><p class="help-block">{translate key="manager.subscriptions.form.userProfileInstructions"}</p></td>
</tr>
<tr valign="top">
	<td>{fieldLabel name="userSalutation" key="user.salutation"}</td>
	<td class="value"><div class="form-group"><input type="text" name="userSalutation" id="userSalutation" value="{$userSalutation|escape}" size="20" maxlength="40" class="form-control" /></div></td>
</tr>
<tr valign="top">
	<td>{fieldLabel name="userFirstName" required="true" key="user.firstName"}</td>
	<td class="value"><div class="form-group"><input type="text" name="userFirstName" id="userFirstName" value="{$userFirstName|escape}" size="20" maxlength="40" class="form-control" /></div></td>
</tr>
<tr valign="top">
	<td>{fieldLabel name="userMiddleName" key="user.middleName"}</td>
	<td class="value"><div class="form-group"><input type="text" name="userMiddleName" id="userMiddleName" value="{$userMiddleName|escape}" size="20" maxlength="40" class="form-control" /></div></td>
</tr>
<tr valign="top">
	<td>{fieldLabel name="userLastName" required="true" key="user.lastName"}</td>
	<td class="value"><div class="form-group"><input type="text" name="userLastName" id="userLastName" value="{$userLastName|escape}" size="20" maxlength="90" class="form-control" /></div></td>
</tr>
<tr valign="top">
	<td>{fieldLabel name="userInitials" key="user.initials"}</td>
	<td class="value"><div class="form-group"><input type="text" name="userInitials" id="userInitials" value="{$userInitials|escape}" size="5" maxlength="5" class="form-control" />&nbsp;&nbsp;{translate key="user.initialsExample"}</div></td>
</tr>
<tr valign="top">
	<td>{fieldLabel suppressId="true" name="userGender" key="user.gender"}</td>
	<td class="value">
		<div class="form-group">
			<select name="userGender" id="userGender" size="1" class="form-control">
				{html_options_translate options=$genderOptions selected=$userGender}
			</select>
		</div>
	</td>
</tr>
<tr valign="top">
	<td>{fieldLabel name="userAffiliation" key="user.affiliation"}</td>
	<td class="value">
		<div class="form-group">
			<textarea name="userAffiliation[{$formLocale|escape}]" id="userAffiliation" rows="5" cols="40" class="form-control">{$userAffiliation[$formLocale]|escape}</textarea><br/>
			<p class="help-block">{translate key="user.affiliation.description"}</p>
		</div>
	</td>
</tr>
<tr valign="top">
	<td>{fieldLabel name="userUrl" key="user.url"}</td>
	<td class="value"><div class="form-group"><input type="text" name="userUrl" id="userUrl" value="{$userUrl|escape}" size="30" maxlength="90" class="form-control" /></div></td>
</tr>
<tr valign="top">
	<td>{fieldLabel name="userEmail" required="true" key="user.email"}</td>
	<td class="value"><div class="form-group"><input type="text" name="userEmail" id="userEmail" value="{if $userEmail}{$userEmail|escape}{/if}" size="30" maxlength="90" class="form-control" /></div></td>
</tr>
<tr valign="top">
	<td>&nbsp;</td>
	<td class="value">
		<table class="table table-striped" width="100%">
			<tr valign="top">
				<td width="5%"><div class="form-group"><input type="checkbox" name="notifyEmail" id="notifyEmail" value="1"{if $notifyEmail} checked="checked"{/if} /></div></td>
				<td width="95%"><label class="control-label" for="notifyEmail">{translate key="manager.subscriptions.form.notifyEmail"}</label></td>
			</tr>
		</table>
	</td>
</tr>
<tr valign="top">
	<td>{fieldLabel name="userPhone" key="user.phone"}</td>
	<td class="value"><div class="form-group"><input type="text" name="userPhone" id="userPhone" value="{$userPhone|escape}" size="15" maxlength="24" class="form-control" /></div></td>
</tr>
<tr valign="top">
	<td>{fieldLabel name="userFax" key="user.fax"}</td>
	<td class="value"><div class="form-group"><input type="text" name="userFax" id="userFax" value="{$userFax|escape}" size="15" maxlength="24" class="form-control" /></div></td>
</tr>
<tr valign="top">
	<td>{fieldLabel name="userMailingAddress" key="common.mailingAddress"}</td>
	<td class="value"><div class="form-group"><textarea name="userMailingAddress" id="userMailingAddress" rows="3" cols="40" class="form-control">{$userMailingAddress|escape}</textarea></div></td>
</tr>
<tr valign="top">
	<td>{fieldLabel name="userCountry" key="common.country"}</td>
	<td class="value">
		<div class="form-group">
			<select name="userCountry" id="userCountry" class="form-control">
				<option value=""></option>
				{html_options options=$validCountries selected=$userCountry}
			</select>
		</div>
	</td>
</tr>