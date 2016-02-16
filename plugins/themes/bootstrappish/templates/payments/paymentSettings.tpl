{**
 * templates/payments/paymentSettings.tpl
 *
 * Copyright (c) 2006-2009 Gunther Eysenbach, Juan Pablo Alperin, MJ Suhonos
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form for payment settings.
 *}
{strip}
{assign var="pageTitle" value="manager.payment.feePaymentOptions"}
{include file="common/header.tpl"}
{/strip}

<div id="paymentSettings" class="col-md-12 mag-innert-left">
	<ul class="stay">
		<li class="current"><a href="{url op="payments"}">{translate key="manager.payment.options"}</a></li>
		<li><a href="{url op="payMethodSettings"}">{translate key="manager.payment.paymentMethods"}</a></li>
		<li><a href="{url op="viewPayments"}">{translate key="manager.payment.records"}</a></li>
	</ul>

	<br />

	<form role="form" name="paymentSettingsForm" method="post" action="{url op="savePaymentSettings"}">
		{if count($formLocales) > 1}
			<div id="locales" class="table-responsive">
				<table width="100%" class="table table-striped">
					<tr valign="top">
						<td width="20%">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
						<td width="80%" class="value">
							{url|assign:"paymentSettingsFormUrl" op="payments" escape=false}
							{form_language_chooser form="paymentSettingsForm" url=$paymentSettingsFormUrl}
							<p class="help-block">{translate key="form.formLanguage.description"}</p>
						</td>
					</tr>
				</table>
			</div>
		{/if}

		{include file="common/formErrors.tpl"}

		<div id="generalOptions" class="col-md-12 mag-innert-left">
			<h3>{translate key="manager.payment.generalOptions"}</h3>
			<div class="table-responsive">
				<table width="100%" class="table table-striped">
					<tr>
						<td width="20%"><div class="form-group"><input type="checkbox" name="journalPaymentsEnabled" id="journalPaymentsEnabled" value="1"{if $journalPaymentsEnabled} checked="checked"{/if} /></div></td>
						<td class="value" width="80%">{fieldLabel name="journalPaymentsEnabled" key="manager.payment.options.enablePayments"}</td>
					</tr>
					<tr>
						<td width="20%">{fieldLabel name="currency" key="manager.payment.currency"}</td>
						<td class="value" width="80%"><div class="form-group"><select name="currency" id="currency" class="form-control">{html_options options=$validCurrencies selected=$currency}</select></div></td>
					</tr>
					<tr>
						<td width="20%"></td>
						<td width="80%">{translate key="manager.payment.currencymessage"}</td>
					</tr>
				</table>
			</div>
		</div>
		
		<div id="authorFees" class="col-md-12 mag-innert-left">
			<h3>{translate key="manager.payment.authorFees"}</h3>
			<p class="help-block">{translate key="manager.payment.authorFeesDescription"}</p>
			
			<div class="table-responsive">
				<table width="100%" class="table table-striped">
					<tr>
						<td width="20%"><div class="form-group"><input type="checkbox" name="submissionFeeEnabled" id="submissionFeeEnabled" value="1"{if $submissionFeeEnabled} checked="checked"{/if} /></div></td>
						<td width="80%">{fieldLabel name="submissionFeeEnabled" key="manager.payment.options.submissionFee"}</td>
					</tr>
					<tr>
						<td width="20%">{fieldLabel name="submissionFee" key="manager.payment.options.fee"}</td>
						<td class="value" width="80%"><div class="form-group"><input type="text" class="form-control" name="submissionFee" id="submissionFee" size="10" value="{$submissionFee|escape}" /></div></td>
					</tr>
					<tr>
						<td width="20%">{fieldLabel name="submissionFeeName" key="manager.payment.options.feeName"}</td>
						<td class="value" width="80%"><div class="form-group"><input type="text" class="form-control" name="submissionFeeName[{$formLocale|escape}]" id="submissionFeeName" size="50" value="{$submissionFeeName[$formLocale]|escape}" /></div></td>
					</tr>
					<tr>
						<td width="20%">{fieldLabel name="submissionFeeDescription" key="manager.payment.options.feeDescription"}</td>
						<td class="value" width="80%"><div class="form-group"><textarea class="form-control" name="submissionFeeDescription[{$formLocale|escape}]" id="submissionFeeDescription" rows="2" cols="50">{$submissionFeeDescription[$formLocale]|escape}</textarea></div></td>
					</tr>
					<tr>
						<td width="20%"><div class="form-group"><input type="checkbox" name="fastTrackFeeEnabled" id="fastTrackFeeEnabled" value="1"{if $fastTrackFeeEnabled} checked="checked"{/if} /></div></td>
						<td width="80%">{fieldLabel name="fastTrackFeeEnabled" key="manager.payment.options.fastTrackFee"}</td>
					</tr>
					<tr>
						<td width="20%">{fieldLabel name="fastTrackFee" key="manager.payment.options.fee"}</td>
						<td class="value" width="80%"><div class="form-group"><input type="text" class="form-control" name="fastTrackFee" id="fastTrackFee" size="10" value="{$fastTrackFee|escape}" /></div></td>
					</tr>
					<tr>
						<td width="20%">{fieldLabel name="fastTrackFeeName" key="manager.payment.options.feeName"}</td>
						<td class="value" width="80%"><div class="form-group"><input type="text" class="form-control" name="fastTrackFeeName[{$formLocale|escape}]" id="fastTrackFeeName" size="50" value="{$fastTrackFeeName[$formLocale]|escape}" /></div></td>
					</tr>
					<tr>
						<td width="20%">{fieldLabel name="fastTrackFeeDescription" key="manager.payment.options.feeDescription"}</td>
						<td class="value" width="80%"><div class="form-group"><textarea class="form-control" name="fastTrackFeeDescription[{$formLocale|escape}]" id="fastTrackFeeDescription" rows="2" cols="50">{$fastTrackFeeDescription[$formLocale]|escape}</textarea></div></td>
					</tr>
					<tr>
						<td width="20%"><div class="form-group"><input type="checkbox" name="publicationFeeEnabled" id="publicationFeeEnabled" value="1"{if $publicationFeeEnabled} checked="checked"{/if} /></div></td>
						<td width="80%">{fieldLabel name="publicationFeeEnabled" key="manager.payment.options.publicationFee"}</td>
					</tr>
					<tr>
						<td width="20%">{fieldLabel name="publicationFee" key="manager.payment.options.fee"}</td>
						<td class="value" width="80%"><div class="form-group"><input type="text" class="form-control" name="publicationFee" id="publicationFee" size="10" value="{$publicationFee|escape}" /></div></td>
					</tr>
					<tr>
						<td width="20%">{fieldLabel name="publicationFeeName" key="manager.payment.options.feeName"}</td>
						<td class="value" width="80%"><div class="form-group"><input type="text" class="form-control" name="publicationFeeName[{$formLocale|escape}]" id="publicationFeeName" size="50" value="{$publicationFeeName[$formLocale]|escape}" /></div></td>
					</tr>
					<tr>
						<td width="20%">{fieldLabel name="publicationFeeDescription" key="manager.payment.options.feeDescription"}</td>
						<td class="value" width="80%"><div class="form-group"><textarea class="form-control" name="publicationFeeDescription[{$formLocale|escape}]" id="publicationFeeDescription" rows="2" cols="50">{$publicationFeeDescription[$formLocale]|escape}</textarea></div></td>
					</tr>
					<tr>
						<td width="20%">{fieldLabel name="waiverPolicy" key="manager.payment.options.waiverPolicy"}</td>
						<td class="value" width="80%"><div class="form-group"><textarea class="form-control" name="waiverPolicy[{$formLocale|escape}]" id="waiverPolicy" rows="2" cols="50">{$waiverPolicy[$formLocale]|escape}</textarea></div></td>
					</tr>
				</table>
			</div>
		</div>

		<div id="readerFees">
			<h3>{translate key="manager.payment.readerFees"}</h3>
			<p class="help-block">{translate key="manager.payment.readerFeesDescription"}</p>

			<div class="table-responsive">
				<table width="100%" class="table table-striped">
					<tr>
						<td class="value" width="20%"><div class="form-group"><input type="checkbox" name="acceptSubscriptionPayments" id="acceptSubscriptionPayments" value="1"{if $acceptSubscriptionPayments} checked="checked"{/if} /></div></td>
						<td width="80%">{fieldLabel name="acceptSubscriptionPayments" key="manager.payment.options.acceptSubscriptionPayments"}</td>
					</tr>
					<tr>
						<td width="20%"><div class="form-group"><input type="checkbox" name="purchaseIssueFeeEnabled" id="purchaseIssueFeeEnabled" value="1"{if $purchaseIssueFeeEnabled} checked="checked"{/if} /></div></td>
						<td width="80%">{fieldLabel name="purchaseIssueFeeEnabled" key="manager.payment.options.purchaseIssueFee"}</td>
					</tr>
					<tr>
						<td width="20%">{fieldLabel name="purchaseIssueFee" key="manager.payment.options.fee"}</td>
						<td class="value" width="80%"><div class="form-group"><input type="text" class="form-control" name="purchaseIssueFee" id="purchaseIssueFee" size="10" value="{$purchaseIssueFee|escape}" /></div></td>
					</tr>
					<tr>
						<td width="20%">{fieldLabel name="purchaseIssueFeeName" key="manager.payment.options.feeName"}</td>
						<td class="value" width="80%"><div class="form-group"><input type="text" class="form-control" name="purchaseIssueFeeName[{$formLocale|escape}]" id="purchaseIssueFeeName" size="50" value="{$purchaseIssueFeeName[$formLocale]|escape}" /></div></td>
					</tr>
					<tr>
						<td width="20%">{fieldLabel name="purchaseIssueFeeDescription" key="manager.payment.options.feeDescription"}</td>
						<td class="value" width="80%"><div class="form-group"><textarea class="form-control" name="purchaseIssueFeeDescription[{$formLocale|escape}]" id="purchaseIssueFeeDescription" rows="2" cols="50">{$purchaseIssueFeeDescription[$formLocale]|escape}</textarea></div></td>
					</tr>
					<tr>
						<td width="20%"><div class="form-group"><input type="checkbox" name="purchaseArticleFeeEnabled" id="purchaseArticleFeeEnabled" value="1"{if $purchaseArticleFeeEnabled} checked="checked"{/if} /></div></td>
						<td width="80%">{fieldLabel name="purchaseArticleFeeEnabled" key="manager.payment.options.purchaseArticleFee"}</td>
					</tr>
					<tr>
						<td width="20%">{fieldLabel name="purchaseArticleFee" key="manager.payment.options.fee"}</td>
						<td class="value" width="80%"><div class="form-group"><input type="text" class="form-control" name="purchaseArticleFee" id="purchaseArticleFee" size="10" value="{$purchaseArticleFee|escape}" /></div></td>
					</tr>
					<tr>
						<td width="20%">{fieldLabel name="purchaseArticleFeeName" key="manager.payment.options.feeName"}</td>
						<td class="value" width="80%"><div class="form-group"><input type="text" class="form-control" name="purchaseArticleFeeName[{$formLocale|escape}]" id="purchaseArticleFeeName" size="50" value="{$purchaseArticleFeeName[$formLocale]|escape}" /></div></td>
					</tr>
					<tr>
						<td width="20%">{fieldLabel name="purchaseArticleFeeDescription" key="manager.payment.options.feeDescription"}</td>
						<td class="value" width="80%"><div class="form-group"><textarea class="form-control" name="purchaseArticleFeeDescription[{$formLocale|escape}]" id="purchaseArticleFeeDescription" rows="2" cols="50">{$purchaseArticleFeeDescription[$formLocale]|escape}</textarea></div></td>
					</tr>
					<tr>
						<td class="value" width="20%"><div class="form-group"><input type="checkbox" name="restrictOnlyPdf" id="restrictOnlyPdf" value="1"{if $restrictOnlyPdf} checked="checked"{/if} /></div></td>
						<td width="80%">{fieldLabel name="restrictOnlyPdf" key="manager.payment.options.onlypdf"}</td>
					</tr>
				</table>
			</div>
		</div>

		<div id="generalFees">
			<h3>{translate key="manager.payment.generalFees"}</h3>
			<p class="help-block">{translate key="manager.payment.generalFeesDescription"}</p>

			<div class="table-responsive">
				<table width="100%" class="table table-striped">
					<tr>
						<td width="20%"><div class="form-group"><input type="checkbox" name="membershipFeeEnabled" id="membershipFeeEnabled" value="1"{if $membershipFeeEnabled} checked="checked"{/if} /></div></td>
						<td width="80%">{fieldLabel name="membershipFeeEnabled" key="manager.payment.options.membershipFee"}</td>
					</tr>
					<tr>
						<td width="20%">{fieldLabel name="membershipFee" key="manager.payment.options.fee"}</td>
						<td class="value" width="80%"><div class="form-group"><input type="text" class="form-control" name="membershipFee" id="membershipFee" size="10" value="{$membershipFee|escape}" /></div></td>
					</tr>
					<tr>
						<td width="20%">{fieldLabel name="membershipFeeName" key="manager.payment.options.feeName"}</td>
						<td class="value" width="80%"><div class="form-group"><input type="text" class="form-control" name="membershipFeeName[{$formLocale|escape}]" id="membershipFeeName" size="50" value="{$membershipFeeName[$formLocale]|escape}" /></div></td>
					</tr>
					<tr>
						<td width="20%">{fieldLabel name="membershipFeeDescription" key="manager.payment.options.feeDescription"}</td>
						<td class="value" width="80%"><div class="form-group"><textarea class="form-control" name="membershipFeeDescription[{$formLocale|escape}]" id="membershipFeeDescription" rows="2" cols="50">{$membershipFeeDescription[$formLocale]|escape}</textarea></div></td>
					</tr>
					<tr>
						<td width="20%"><div class="form-group"><input type="checkbox" name="donationFeeEnabled" id="donationFeeEnabled" value="1"{if $donationFeeEnabled} checked="checked"{/if} /></div></td>
						<td width="80%">{fieldLabel name="donationFeeEnabled" key="manager.payment.options.donationFee"}</td>
					</tr>
					<tr>
						<td width="20%">{fieldLabel name="donationFeeName" key="manager.payment.options.feeName"}</td>
						<td class="value" width="80%"><div class="form-group"><input type="text" class="form-control" name="donationFeeName[{$formLocale|escape}]" id="donationFeeName" size="50" value="{$donationFeeName[$formLocale]|escape}" /></div></td>
					</tr>
					<tr>
						<td width="20%">{fieldLabel name="donationFeeDescription" key="manager.payment.options.feeDescription"}</td>
						<td class="value" width="80%"><div class="form-group"><textarea class="form-control" name="donationFeeDescription[{$formLocale|escape}]" id="donationFeeDescription" rows="2" cols="50">{$donationFeeDescription[$formLocale]|escape}</textarea></div></td>
					</tr>
				</table>
			</div>
		</div>

		<div id="gifts">
			<h3>{translate key="manager.payment.giftFees"}</h3>
			<p class="help-block">{translate key="manager.payment.giftFeesDescription"}</p>

			<div class="table-responsive">
				<table width="100%" class="table table-striped">
					<tr>
						<td class="value" width="20%"><div class="form-group"><input type="checkbox" name="acceptGiftSubscriptionPayments" id="acceptGiftSubscriptionPayments" value="1"{if $acceptGiftSubscriptionPayments} checked="checked"{/if} /></div></td>
						<td width="80%">{fieldLabel name="acceptGiftSubscriptionPayments" key="manager.payment.options.acceptGiftSubscriptionPayments"}</td>
					</tr>
				</table>
			</div>
		</div>
	
		<p><input type="submit" value="{translate key="common.save"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url page="manager"}'" /></p>
	</form>
</div>

{include file="common/footer.tpl"}