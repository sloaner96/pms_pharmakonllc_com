

<html>
<head>
<title>Project Management System || Venue Search</title>
<script language="JavaScript">
function CheckFields(oForm)
{

	if(oForm.radiobutton[2].checked)
	{
		if(oForm.v_name.value == "" || oForm.v_city.value == "")
		{
			alert("You must enter BOTH a city and venue name.")
			return false;
		}
		else
		{
			return true;
		}
	}
	else if(oForm.radiobutton[1].checked)
	{
		if(oForm.v_city.value == "")
		{
			alert("You must enter a city.");
			return false;
		}
		else
		{
			return true;
		}
	}
	else if(oForm.radiobutton[0].checked)
	{
		if(oForm.v_name.value == "")
		{
			alert("You must enter a venue name.");
			return false;
		}
		else
		{
			return true;
		}
	}

}
</script>
<LINK REL=STYLESHEET HREF="PIW1STYLE.CSS" TYPE="TEXT/CSS">
</head>

<BODY bgcolor="#FFFFFF">
<!--- Sends search criteria to Reports_Details.cfm --->
<form action="venu_summary.cfm" method="post" onsubmit="return CheckFields(this)">
<table width="500px" border="0" cellspacing="0" cellpadding="0" align="center" style="border: solid 1px navy;">
<tr>
	<TD style="padding-bottom: 4px;" class="tdheader"><B>Locate a Venue</B></TD>
</tr>
<tr>
	<td style="padding-bottom: 15px; padding-top: 10px;" align="center">
		<font color="##990000"><strong>Venue Name</strong></font>&nbsp;&nbsp;<input type="text" name="v_name" size="40">
	</td>
</tr>
<tr>
	<td style="padding-bottom: 15px;" align="center">
		<font color="##990000"><strong>Venue City</strong></font>&nbsp;&nbsp;<input type="text" name="v_city" size="40">
	</td>
</tr>
<tr>
	<td style="padding-bottom: 15px;" align="center">
		<font color="##990000"><strong>Search By</strong></font>&nbsp;&nbsp;<input type="radio" name="radiobutton" value="vname" checked>&nbsp; Venue Name &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="radiobutton" value="city"> City&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" name="radiobutton" value="both"> Both
	</td>
</tr>
<tr>
	<td style="padding-bottom: 15px;" align="center"> 
		<input type="Submit" value=" Search " >
	</td>
</tr>	  
</table>

</form>
		
	
	