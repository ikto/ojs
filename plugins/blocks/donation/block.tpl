{**
 * plugins/blocks/donation/block.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site sidebar menu -- donation links.
 *
 *}
{if $donationEnabled}
<h4 class="side">Donation</h4>
<div class="edit-pics" id="sidebarDonation">
	<p class="help-block"><a href="{url page="donations"}">{translate key="payment.type.donation"}</a></p>
</div>
{/if}
