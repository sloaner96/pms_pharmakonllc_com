<!--- 
	*****************************************************************************************
	Name:		PIWadd.cfm
	
	Function:	Populates a dropdown for the User to select the Project Code for the project
				that they wish to add information to, sends Project Code to piw1.cfm to begin
				the process.
	History:	7/18/01, finalized code	TJS
	
	*****************************************************************************************
--->
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Add New Project Code" showCalendar="0">

<CFQUERY DATASOURCE="#application.projdsn#" NAME="qcc">
	EXEC GET_CLIENT_CODES
</CFQUERY>
<script language="JavaScript">
<cfoutput>
var arr = new Array();
// load the cliet codes in the array when the page loads.
function load_array()
{
	<cfloop from="1" to = "#qcc.recordcount#" index = "x">
		arr[#x#] = '#qcc.client_code_description[x]#';
	</cfloop>
}

// show the item description in a text box
function show_descrip(f)
{
	var len = get_client.select_client.length;
	for( x=1; x<len; x++)
		{
		if(get_client.select_client.selectedIndex == x) 
			{
			get_client.client_description.value = arr[x];
			//alert(arr[x]);
			}
		}
	return true;
}
</cfoutput>
</script>
</HEAD>
<BODY onLoad="load_array();">	
<FORM ACTION="PIWadd2.cfm" METHOD="post" name="get_client">
<TABLE ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1">
<TR>
	<TD>
		<TABLE WIDTH="100%">
		<TR>
			<TD VALIGN="bottom" align=right><SPAN CLASS="required"><b>Select A Client Code:</b></SPAN></TD>
			<TD>
				<cfoutput>
				<select name="select_client" onChange="return show_descrip(this);">
				</cfoutput>
					<option value="0">-- Select --</option>
					<cfoutput query="qcc">
						<option value="#qcc.client_code#">#qcc.client_code#</option>
					</cfoutput>
				</select>
			</TD>
		</TR>
		<tr>
			<td colspan=2><input type=text size=50 name=client_description value=""  onfocus="" disabled></td>
		</tr>
		<TR>
			<TD ALIGN="center"><BR><INPUT TYPE="hidden" NAME="clear" VALUE=1><INPUT TYPE="submit" NAME="Select" VALUE="  Select  "></TD>
			</form>
			<FORM ACTION="index.cfm" METHOD="post">
			<TD ALIGN="center"><BR><INPUT TYPE="hidden" NAME="clear" VALUE=1><INPUT TYPE="submit" NAME="Cancel" VALUE="  Cancel  "></TD>
			</form>
		</TR>
		</TABLE>
	</TD>
</TR>
</FORM>
</TABLE>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
