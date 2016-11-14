<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Non-Speaker Override" showCalendar="0">
<form method="post" action="non_speaker_override2.cfm">
<TABLE ALIGN="Center" BORDER="0" WIDTH="600px" CELLSPACING="0" CELLPADDING="0">
<TR>
	<TD ALIGN="Center" class="tdheader" colspan="2"><strong>Current Non-Speaker Programs</strong></TD>
</TR>
<TR>
	<TD ALIGN="Center" style="padding-top: 4px; padding-bottom: 4px; padding-left: 4px; padding-right: 4px; font-size: 12px;" colspan="2">
		The following codes are for programs that do not require speakers.  If you would like to override 
		the system and allow speakers for a particular meeting, UNCHECK the corresponding box. Please note that this 
		change is relative only to your machine, and will reset when you close your browser.	
	</td>
</tr>
<cfset ClientArray = #ListToArray(session.nospeaker, ",")#>

<cfloop index="p" from="1" to="#ArrayLen(ClientArray)#" step="1">
	<TR>
		<TD ALIGN="right" style="padding-top: 4px; padding-bottom: 4px; padding-right: 5px;" width="300px">
			<input type="checkbox" name="nonSpkrCode" value="<cfoutput>#ClientArray[p]#</cfoutput>" checked>
		</td>
		<TD ALIGN="left" style="padding-top: 4px; padding-bottom: 4px; padding-left: 5px; font-size: 12px;" width="300px" valign="center"> 
			&nbsp; <cfoutput>#ClientArray[p]#</cfoutput>
		</td>
	</tr>
</cfloop>

<TR>
	<TD ALIGN="Center" style="padding-top: 4px; padding-bottom: 4px; font-size: 12px;" colspan="2">
		<input type="submit"  value=" Override System ">	
	</td>
</tr>

</TABLE>
</form>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

