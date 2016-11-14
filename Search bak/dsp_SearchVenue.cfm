<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Search for Venue" showCalendar="0">
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
<br>
	      <p align="center"><font face="verdana" size="-2">Use the form below to search for a venue.</font></p>
	      <form action="/Venue/venu_summary.cfm" method="post" onsubmit="return CheckFields(this)">
			<table width="90%" border="0" cellspacing="0" cellpadding="4" align="center">
				<tr>
					<td align="right"><font color="#990000"><strong>Venue Name</strong></font></td>
					<td width="60%" align="left"><input type="text" name="v_name" size="40"></td>
				</tr>
				<tr>
					<td align="right"><font color="#990000"><strong>Venue City</strong></font></td>
					<td width="60%" align="left"><input type="text" name="v_city" size="40"></td>
				</tr>
				<tr>
					<td align="right"><font color="#990000"><strong>Search By</strong></font></td>
					<td width="60%" align="left"><input type="radio" name="radiobutton" value="vname" checked>&nbsp; Venue Name &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="radiobutton" value="city"> City&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" name="radiobutton" value="both"> Both</td>
				</tr>
				<tr>
					<td align="center" colspan="2"> 
						<input type="Submit" value=" Search " >
					</td>
				</tr>	  
			</table>
				<br>
		  </form>
	   
	   </td>
   </tr>
   
</table>           
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
