{**
 * lib/pkp/templates/common/formErrors.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2000-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * List errors that occurred during form processing.
 *}

{if $isError}
	<div id="formErrors" class="col-md-12 mag-innert-left">
		<p>
			<span class="help-block">{translate key="form.errorsOccurred"}:</span>
			<ul class="stay">
				{foreach key=field item=message from=$errors}
					<li><a href="#{$field|escape}">{$message}</a></li>
				{/foreach}
			</ul>
		</p>
	</div>
	
	<script type="text/javascript">
	{literal}
		<!--
		// Jump to form errors.
		window.location.hash="formErrors";
		// -->
	{/literal}
	</script>
{/if}