<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript">
function CheckDates(oForm)
{
	var Bdate = oForm.begin_date.value;
	var Edate = oForm.end_date.value
	var B_ASCIICode = Bdate.charCodeAt();
	var E_ASCIICode = Edate.charCodeAt();
	
	if(Bdate == "" || B_ASCIICode == 32)
	{
		alert("Please enter a begining date.");
		return false;
	}
	else if(Edate == "" || E_ASCIICode == 32)
	{
		alert("Please enter an ending date.");
		return false;
	}
	else
	{
		return true;
	}
}
</script>
<SCRIPT SRC="/includes/libraries/CallCal.js"></SCRIPT>
</head>

<body>

<cfset beginingdate = #DateAdd("d", -7, Now())#>
<cfset endingdate = Now()>
<form action="report_mod_ind3.cfm" method="post">
<table border="0" cellpadding="4" cellspacing="0">
<tr>
	<td>
		<font color="##990000"><strong>Begining Date</strong></font>&nbsp;&nbsp;
		<input type="text" name="begin_date" size="12" maxlength="12" onClick="CallCal(this)" value="<cfoutput>#DateFormat(beginingdate, "mm/dd/yyyy")#</cfoutput>">
		&nbsp; &nbsp;
		<font color="##990000"><strong>Ending Date</strong></font>&nbsp;&nbsp;<cfoutput>#DateFormat(endingdate, "mm/dd/yyyy")#</cfoutput>
		<input type="hidden" name="end_date" value="<cfoutput>#DateFormat(endingdate, "mm/dd/yyyy")#</cfoutput>">	
	</td>
</tr>
<tr>
	<td><input type="submit" value=" Submit "></td>
</tr>
</table>
</form>
</body>
</html>
