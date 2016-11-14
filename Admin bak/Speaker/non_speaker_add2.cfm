<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Non-Speaker Add" showCalendar="0">

<cfif IsDefined("session.nospeaker") AND IsDefined("form.newCode")>
	<cfset NewCode = #UCase(form.newCode)#>
	<cfset temp = #ListFind(session.nospeaker, NewCode, ",")#>
	
	<cfif temp EQ 0><!---Code doesn't exsist, append new code--->
		<cfset session.nospeaker = #ListAppend(session.nospeaker, NewCode, ",")#>
		<cfset session.nospeaker = #ListSort(session.nospeaker, "text", "asc", ",")#>
		<cfset message = "Addition Successful">
	<cfelse><!---Code exsist, dont do anything.--->
		<cfset message = "Code Previously Exsisted">
	</cfif>
	
	<TABLE ALIGN="Center" BORDER="0" WIDTH="600px" CELLSPACING="0" CELLPADDING="0">
		<TR>
			<TD ALIGN="Center" class="tdheader" colspan="2"><strong>New Code Added</strong></TD>
		</TR>
		<TR>
			<TD ALIGN="Center" style="padding-top: 4px; padding-bottom: 4px; padding-left: 4px; padding-right: 4px; font-size: 12px;" colspan="2">
				<strong style="color:#CC0000;"><cfoutput>#message#</cfoutput></strong><br><br>
				Projects ending in the following codes do not require speakers:<br>
				<cfoutput>#session.nospeaker#</cfoutput>	
			</td>
		</tr>
		<TR>
			<TD ALIGN="Center" style="padding-top: 4px; padding-bottom: 4px; font-size: 12px;" colspan="2">
				<input type="button"  value=" Go Back " onclick="javascript:history.back();">	
			</td>
		</tr>	
	</TABLE>
<cfelse>
	<cfinclude template="error_handler.cfm">
</cfif>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

