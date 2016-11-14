
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Upload Certificate Issuance Data" showCalendar="0">

<table>
<cfoutput>
<FORM NAME="issue" ACTION="" METHOD="post">
</cfoutput>
<tr>
	<td width=50>&nbsp;</td>
	<td colspan=3>Click the <i><b>Continue</b></i> button to begin issued certificate processing.<br><br> All records in the <i>cert_issued</i> database file will be loaded...</td>
</tr>
<tr height=20><td colspan=3>&nbsp;</td></tr>
<tr>
	<td width=50>&nbsp;</td>
	<TD ALIGN="right"><input TYPE="Button"  NAME="run" VALUE=" Continue" onClick="issue.action = 'roster_cert_issue2.cfm?a=1&#Rand()#'; issue.submit();"></TD>
	<td>&nbsp;</td>
</tr>
<tr height=20><td colspan=3>&nbsp;</td></tr>
</form>
</table>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
