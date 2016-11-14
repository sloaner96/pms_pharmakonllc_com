<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Non-Speaker Add" showCalendar="0">

<script language="JavaScript">
function CheckFields(oForm)
{
	if(oForm.newCode.value.length != 2)
	{
		alert("Please enter a code that is at least two character long");
		return false;
	}
	else
	{
		return true;
	}
}
</script>
<form method="post" action="non_speaker_add2.cfm" onsubmit="return CheckFields(this)">
<TABLE ALIGN="Center" BORDER="0" WIDTH="600px" CELLSPACING="0" CELLPADDING="0">
<TR>
	<TD ALIGN="Center" class="tdheader" colspan="2" ><strong>Current Non-Speaker Programs</strong></TD>
</TR>
<TR>
	<TD ALIGN="Center" style="padding-top: 4px; padding-bottom: 4px; padding-left: 4px; padding-right: 4px; font-size: 12px;" colspan="2">
		Add a code to the non-speaker list of codes.  This will allow speaker meetings to be entered into the system, 
		without a speaker. Please note that this change is relative only to your machine, and will reset when you close your browser.	
	</td>
</tr>
<TR>
	<TD ALIGN="Center" style="padding-top: 4px; padding-bottom: 4px; padding-left: 4px; padding-right: 4px; font-size: 12px;" colspan="2">
		Current Codes:<br>
		<cfoutput><strong>#session.nospeaker#</strong></cfoutput>
	</td>
</tr>
<TR>
	<TD ALIGN="right" style="padding-top: 8px; padding-bottom: 4px; padding-right: 5px;" width="300px">
		<strong>New Code:</strong> 
	</td>
	<TD ALIGN="left" style="padding-top: 4px; padding-bottom: 4px; padding-left: 5px; font-size: 12px;" width="300px" valign="center"> 
		<input type="text" name="newCode" size="5" maxlength="2">
	</td>
</tr>
<TR>
	<TD ALIGN="Center" style="padding-top: 4px; padding-bottom: 4px; font-size: 12px;" colspan="2">
		<input type="submit"  value=" Add New Code ">	
	</td>
</tr>

</TABLE>
</form>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
