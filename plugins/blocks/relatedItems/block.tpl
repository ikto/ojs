{**
 * plugins/blocks/relatedItems/block.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Keyword cloud block plugin
 *
 *}

{if $journalRt && $journalRt->getEnabled() && $journalRt->getDefineTerms() && $version}
	
	<script type="text/javascript">
		{literal}initRelatedItems();{/literal}
	</script>

	<h4 class="side">{translate key="plugins.block.relatedItems.title"}</h4>
	<div class="edit-pics" id="sidebarRTRelatedItems">
		<div class="table-responsive">
			<table class="table table-striped" width="100%">
				<tr>
					<td valign="top" style="width:26px;">
						<img src="{$baseUrl}/plugins/blocks/relatedItems/icons/lookupTerms.png" class="articleToolIcon img-responsive" alt=""/>
					</td>
					<td valign="top">
						<div id="relatedItems">
							<ul class="stay">
								{foreach from=$version->getContexts() item=context}
									{if !$context->getDefineTerms()}
										<li><a href="javascript:openRTWindowWithToolbar('{url page="rt" op="context" path=$articleId|to_array:$galleyId:$context->getContextId()}');">{$context->getTitle()|escape}</a></li>
									{/if}
								{/foreach}
							</ul>
						</div>
						<div id="toggleRelatedItems">
							<a id="hideRelatedItems" style="display:none;" href="javascript:void(0)">
								<img src="{$baseUrl}/plugins/blocks/relatedItems/icons/magnifier_zoom_out.png" alt=""/> 
								{translate key="plugins.block.relatedItems.hide"}
							</a>
							<a id="showRelatedItems" href="javascript:void(0)">
								<img src="{$baseUrl}/plugins/blocks/relatedItems/icons/magnifier_zoom_in.png" alt=""/>
								{translate key="plugins.block.relatedItems.show"}
							</a>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
{/if}