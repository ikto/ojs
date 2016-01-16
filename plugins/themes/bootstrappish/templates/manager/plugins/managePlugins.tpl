{**
 * templates/manager/plugins/managePlugins.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * List available import/export plugins.
 *}
{strip}
{assign var="pageTitle" value="manager.plugins.$path"}
{include file="common/header.tpl"}
{/strip}


{if $path == 'install'}
	<div id="install">
		{if !$uploaded}
			<p>{translate key="manager.plugins.installDescription"}</p>
		{/if}

		<form method="post" action="{url path="installPlugin"}" enctype="multipart/form-data">
			{if $error}
				<span class="formError">{translate key="form.errorsOccurred"}:</span>
				<ul class="stay">
					<li>
					{if is_array($message)}
						{translate key=$message[0]} {$message[1]}
					{else}
						{translate key=$message}
					{/if}
					</li>
				</ul>
			{/if}
			{if $uploaded}
				<ul class="stay">
					<li>&#187;&nbsp;
					{if is_array($message)}
						{translate key=$message[0]} {$message[1]}
					{else}
						{translate key=$message}
					{/if}
					</li>
				</ul>
			{/if}

			<br />
			<div class="table-responsive">
			<table class="table table-striped" width="100%">
			<tr>
				<td width="25%">
					{translate key="manager.plugins.uploadPluginDir"}
				</td>
				<td width="75%" class="value">
					<input type="file" class="uploadField" name="newPlugin" id="newPlugin" /> 
					<input name="uploadPlugin" type="submit" value="{translate key="common.continue"}" class="btn btn-success" />
				</td>
			</tr>
			</table>
			</div>
			<p>
		</form>
	</div>
{elseif $path == 'upgrade'}
	<div id="upgrade">
		{if !$uploaded}
			<p>{translate key="manager.plugins.upgradeDescription"}</p>
		{/if}

		<form method="post" action="{url path="upgradePlugin"|to_array:$category:$plugin}" enctype="multipart/form-data">
			{if $error}
				<span class="formError">{translate key="form.errorsOccurred"}:</span>
				<ul class="stay">
					{if is_array($message)}
						{translate key=$message[0]} {$message[1]}
					{else}
						{translate key=$message}
					{/if}
				</ul>
			{/if}
			{if $uploaded}
				<ul class="stay">
					<li>&#187;&nbsp;
					{if is_array($message)}
						{translate key=$message[0]} {$message[1]}
					{else}
						{translate key=$message}
					{/if}
					</li>
				</ul>
			{/if}

			<br />
			<div class="table-responsive">
			<table class="table table-striped" width="100%">
			<tr>
				<td width="25%">
						{translate key="manager.plugins.uploadPluginDir"}
				</td>
				<td width="75%" class="value">
					<input type="file" class="uploadField" name="newPlugin" id="newPlugin" />
					<input name="uploadPlugin" type="submit" value="{translate key="common.continue"}" class="btn btn-success" />
				</td>
			</tr>
			</table>
			</div>
			<p>
		</form>
	</div>
{elseif $path == 'delete'}
	<div id="delete">
		{if !$deleted}
			<p>{translate key="manager.plugins.deleteDescription"}</p>
		{/if}

		{if !$deleted}
			{if !$error}
				<ul class="stay">
					<li>{translate key="manager.plugins.deleteConfirm"}</li>
				</ul>
			{/if}

			<br />
			<form method="post" action="{url path="deletePlugin"|to_array:$category:$plugin}" enctype="multipart/form-data">
				{if $error}
					<span class="formError">{translate key="form.errorsOccurred"}:</span>
					<ul class="stay">
						<li>
						{if is_array($message)}
							{translate key=$message[0]} {$message[1]}
						{else}
							{translate key=$message}
						{/if}
						</li>
					</ul>
				{/if}
				<input type="submit" name="save" class="btn btn-success" value="{translate key="common.delete"}"/> <input type="button" class="btn btn-danger" value="{translate key="common.cancel"}" onclick="history.go(-1)"/>
			</form>
		{else}
			<p>{translate key="manager.plugins.deleteSuccess"}</p>
		{/if}
	</div>
{/if}

{include file="common/footer.tpl"}

