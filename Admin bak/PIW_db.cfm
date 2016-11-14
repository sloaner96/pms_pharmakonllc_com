<!--- 
	*****************************************************************************************
	Name:		
	Function:	
	History:	ts072903  - 
	
	*****************************************************************************************
--->
<CFSET session.project_admin=0>
<CFPARAM NAME="URL.client" DEFAULT="">
<CFPARAM NAME="URL.action" DEFAULT="">

<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="PIW Database Stats" showCalendar="0">

<CFSWITCH EXPRESSION="#URL.action#">
<!--- Case to perform edit action that was selected --->
	<CFCASE VALUE="go_edit">
		<CFSET session.client_code = form.select_client>
		<CFSET session.project_code = form.select_project>
		<CFOUTPUT><META HTTP-EQUIV="REFRESH" CONTENT="0; URL=#form.edit_action#"></CFOUTPUT>
	</CFCASE>

<!--- Default case to present edit selection form to user --->	
	<CFDEFAULTCASE>
				<SCRIPT LANGUAGE="JavaScript">
				//
				function verify(f)
				{
				if (f.client_code.value == '0')
					{
					alert("Please select a Client Code!");
					return false;
					}
				return true;
			}		
			</script>
			<SCRIPT SRC="/includes/libraries/confirm.js"></SCRIPT> 
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
<FORM ACTION="piw_db.cfm?action=go_edit" METHOD="post" name="get_client">
					<!--- Table containing input fields --->
					<TABLE ALIGN="center" BORDER="0" CELLPADDING="0" CELLSPACING="5" WIDTH="500">								
						<TR><TD>&nbsp;</TD></TR>
						<tr>
						<td align=right><SPAN CLASS="required"><b>Select A Client:</b></SPAN></td>
						<CFQUERY DATASOURCE="#application.projdsn#" NAME="qprojects">
							SELECT client_proj, description, client_code 
								FROM client_proj ORDER BY client_code
						</CFQUERY>	
						<td width=225>
							<!--- create dynamically populated select boxes with this custom tag --->
						<cfoutput>
						<CF_TwoSelectsRelated1
							QUERY="qprojects"
							NAME1="select_client"
							NAME2="select_project"
							CLIENT="#url.client#"
							DISPLAY1="client_code"
							DISPLAY2="client_proj"
							VALUE1="client_code"
							VALUE2="client_proj"
							SIZE1="1"
							SIZE2="1"
							HTMLBETWEEN="</td></tr><tr><td align=right><SPAN CLASS=required><b>Select A Project Code:</b></SPAN></td><td>"
							AUTOSELECTFIRST="Yes"
							EMPTYTEXT1="(Select)"
							EMPTYTEXT2="(Select)">
						</cfoutput>
					</tr>
					<TR><TD COLSPAN="2" ALIGN="center">&nbsp;</td></tr>
					<Tr><td COLSPAN="2">
						<table align="center" border="0">
						<TR>
							<TD ALIGN="right"><INPUT TYPE="radio" NAME="edit_action" VALUE="PIW_dbView.cfm" class="invis"></TD>
							<TD>View/Edit Database Information for Project Code</TD>
						</TR>
						<TR>
							<TD ALIGN="right"><INPUT TYPE="radio" NAME="edit_action" VALUE="PIW_dbAdd.cfm" class="invis"></TD>
							<TD>Add Database to a Project Code</TD>
						</TR>
						</table>
					</td></Tr>
					
					<TR><TD COLSPAN="2">&nbsp;</TD></TR>
					<TR>
						<TD ALIGN="Center" COLSPAN="2">
							<table width="100%" border="0" ALIGN="Center">
							  <tr>
								<td ALIGN="Center"><INPUT type="submit" NAME="go" VALUE="  Submit  "></form>&nbsp;</td>
								<td ALIGN="Center"><INPUT type="submit" NAME="submit" VALUE="  Cancel  " onclick="javascript:history.back(-1);s"></td>
							  </tr>
							</table>
					
						</TD>
					</TR>
					</TABLE>
	<!--- </FORM> --->
</CFDEFAULTCASE>
</CFSWITCH>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
