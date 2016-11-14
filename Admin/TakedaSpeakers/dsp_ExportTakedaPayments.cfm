<!------------------------------------------------------------------------------
	dsp_ExportTakedaEvents.cfm
	Takeda Speaker events Export functions.  This progam pulls scheduled Takeda
	speaker	events and prepares them for export

	HISTORY:
		bj20060502 - initial code.
		bj20060906 - modified for new speaker and pms database structure.
-------------------------------------------------------------------------------->
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Export Takeda Speaker Payments" showCalendar="1">
<!--- get the last event logged --->
<!--- create a data object for the cfc functions for Takeda Speaker handling --->
<cfscript>dataObj = createObject("component","components/TakedaDataHandler");</cfscript>
<cfscript>
		sLog = dataObj.lastEventLog('Payments');
</cfscript>

<form action="act_ExportTakedaPayments.cfm?a=build" method="post" name="build_events">
	<!--- Table with fields to select search criteria.  --->
	<table border="0" cellspacing="4" cellpadding="3" width="100%" align="center">
	<tr>
		<td width="25">&nbsp;</td>
		<td colspan="2" class="ContentCell"><center>Select a Project Code and date range to export speaker scheduled data.</center></td>
	</tr>
	<tr>
		<td width="25">&nbsp;</td>
		<td align="right" colspan="2" class="HeadingCell">
			<b>Click <a href="##" onClick="window.open('dsp_TakedaSpeakerHelp.html','_blank','height=400,width=600,resizable=yes,scrollbars=yes');">Here</a> for Instructions</b>
		</td>
	</tr>
	<tr><td colspan="3">&nbsp;</td></tr>
		<cfoutput>
		<tr>
			<td width="25">&nbsp;</td>
			<td colspan="2" class="ContentCell">
			<center>The last Speaker Payment Export was for dates:
			<b>#dateFormat(sLog.BeginningDate, "mm/dd/yyyy")#</b> <b>thru #dateFormat(sLog.EndingDate, "mm/dd/yyyy")#</b><br>
			<b>#sLog.NumberRows#</b> were Exported to file: <b>#trim(sLog.ExportFileName)#</b> for <b>#sLog.Project#</b> projects
			</center></td>
		</tr>
	</cfoutput>
	<tr><td colspan="3">&nbsp;</td></tr>
	<tr>
		<td>&nbsp;</td>
		<TD class="HeadingCell" align="right">Project</TD>
		<td>
			<select name="project">
				<OPTION value="0">- All Events -
				<OPTION value="CTAAC">CTAAC (Actos)
				<OPTION value="CTAAZ">CTAAZ (Amitiza)
				<OPTION value="CTARA">CTARA (Rozerem)
			</SELECT>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<TD class="HeadingCell" align="right">Beginnging Date</TD>
		<td>
			<input type="text" name="BDate" value="" size="10" maxlength="10">&nbsp;
			<img src="/images/btn_formcalendar.gif" id="bdatebtn" border="0" alt="Click to view calendar" onclick="Calendar.setup({inputField:'bdate' ,ifFormat:'%m/%d/%Y',showsTime:false,button:'bdatebtn',singleClick:true,step:1})">
		</td>
	</tr>
	<cfoutput>
	<tr>
		<td>&nbsp;</td>
		<td class="HeadingCell" align="right">Ending Date</td>
		<td>
			<input type="text" name="EDate" value="#dateFormat(Now(), "mm/dd/yyyy")#" size="10" maxlength="10">&nbsp;
			<img src="/images/btn_formcalendar.gif" id="edatebtn" border="0" alt="Click to view calendar" onclick="Calendar.setup({inputField:'edate' ,ifFormat:'%m/%d/%Y',showsTime:false,button:'edatebtn',singleClick:true,step:1})">
		</td>
	</tr>
	</cfoutput>
	<tr valign=top><td colspan="3"></td></tr>
	<tr>
		<td>&nbsp;</td>
		<td colspan=2 align="center">
			<INPUT TYPE="submit"  NAME="continue" VALUE=" Continue ">
		</td>
	</tr>
	</table>
	</form>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">