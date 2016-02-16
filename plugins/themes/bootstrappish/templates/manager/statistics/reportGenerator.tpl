{**
 * templates/manager/statistics/reportGenerator.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the report generator.
 *
 *}

<div id="statistics" class="col-md-12 mag-innert-left">
	<h3>{translate key="manager.statistics.reports"}</h3>
	<p class="help-block">{translate key="manager.statistics.reports.description"}</p>

	<form role="form" method="post" action="{url op="reportGenerator"}">
		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="25%">{translate key="manager.statistics.reports.reportType"}</td>
					<td width="75%" class="value"> <div class="form-group"><select name="reportType" id="reportType" class="form-control">{html_options_translate options=$reportTypes}</select></div></td>
				</tr>
				<tr valign="top">
					<td>{translate key="search.dateFrom"}</td>
					<td class="value">{html_select_date prefix="dateFrom" time="--" all_extra="class=\"form-control\"" year_empty="" month_empty="" day_empty="" start_year="-5" end_year="+1"}</td>
				</tr>
				<tr valign="top">
					<td>{translate key="search.dateTo"}</td>
					<td class="value">
						{html_select_date prefix="dateTo" time="--" all_extra="class=\"form-control\"" year_empty="" month_empty="" day_empty="" start_year="-5" end_year="+1"}
						<input type="hidden" name="dateToHour" value="23" />
						<input type="hidden" name="dateToMinute" value="59" />
						<input type="hidden" name="dateToSecond" value="59" />
					</td>
				</tr>
			</table>
		</div>

		<input type="submit" class="btn btn-success" value="{translate key="manager.statistics.reports.generate"}"/>
	</form>
</div>