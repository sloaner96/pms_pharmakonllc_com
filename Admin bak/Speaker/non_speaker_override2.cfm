<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Non-Speaker Override" showCalendar="0">

<cfif IsDefined("session.nospeaker") AND IsDefined("form.nonSpkrCode")>
	<cfset #session.nospeaker# = #form.nonSpkrCode#>
	<TABLE ALIGN="Center" BORDER="0" WIDTH="600px" CELLSPACING="0" CELLPADDING="0">
	<TR>
		<TD ALIGN="Center" class="tdheader" colspan="2"><strong>Non-Speaker Override</strong></TD>
	</TR>
	<TR>
		<TD ALIGN="Center" style="padding-top: 4px; padding-bottom: 4px; padding-left: 4px; padding-right: 4px; font-size: 12px;" colspan="2">
			<strong>Update Successful</strong><br>
			Projects ending in the following codes do not require speakers:<br>
			<cfoutput>#session.nospeaker#</cfoutput>	
		</td>
	</tr>
	<TR>
		<TD ALIGN="Center" style="padding-top: 4px; padding-bottom: 4px; font-size: 12px;" colspan="2">
			<input type="button"  value=" Go Back " onclick="document.location.href='non_speaker_override.cfm'">	
		</td>
	</tr>
	
	</TABLE>
<cfelse>
	<cfinclude template="error_handler.cfm">
</cfif>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
