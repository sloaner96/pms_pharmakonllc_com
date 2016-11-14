<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Upload Certificate Redemption Data" showCalendar="0">

<SCRIPT SRC="/includes/libraries/PIW1checker.js"></SCRIPT>
</head>
<body>
<table>
<cfoutput>
<FORM NAME="redeem" ACTION="" METHOD="post">
</cfoutput>
<tr>
	<td width=50>&nbsp;</td>
	<td colspan=3>Click the <i><b>Continue</b></i> button to begin redeemed certificate processing.<br><br> All records in the <i>cert_redeem</i> database file will be loaded...</td>
</tr>
<tr height=20><td colspan=3>&nbsp;</td></tr>
<tr>
	<td width=50>&nbsp;</td>
	<TD ALIGN="right"><input TYPE="Button"  NAME="run" VALUE=" Continue" onClick="redeem.action = 'roster_cert_redeem2.cfm?a=1&#Rand()#'; redeem.submit();"></TD>
	<td>&nbsp;</td>
</tr>
<tr height=20><td colspan=3>&nbsp;</td></tr>
</form>
</table>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

