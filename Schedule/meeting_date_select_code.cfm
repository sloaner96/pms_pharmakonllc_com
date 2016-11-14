<!--- 
	*****************************************************************************************
	Name:		meeting_select_code.cfm
	
	Function:	Allows user to select which project code they would like to do scheduling for.
	History:	8/8/01 - Modified from Piwedit.cfm, CJL
				9/10/02 - changed dsn from hourday to PMSProd
				10/22/05- converted to new look, RWS
	
	*****************************************************************************************
--->
<cfparam name="url.action" default="">
<CFPARAM NAME="URL.client" DEFAULT="">
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Schedule Meeting Date" showCalendar="0">

<CFSWITCH EXPRESSION="#URL.action#">
<!--- Case to perform edit action that was selected --->
	<CFCASE VALUE="go_edit">
		<CFSET session.project_code = form.select_project>
		<CFSET session.client_code = form.select_client>
		<CFOUTPUT>
			<cflocation url="meeting_date_insert.cfm" addtoken="NO">
		</CFOUTPUT>
	</CFCASE>

<!--- Default case to present edit selection form to user --->	
	<CFDEFAULTCASE>
		<!--- Query to grab all Pending Project Codes and Populate a dropdown for the User --->
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="get_projectcode">
			SELECT project_code	FROM piw ORDER BY project_code
		</CFQUERY>
			
		<FORM ACTION="meeting_date_select_code.cfm?action=go_edit" METHOD="post">
		<!--- Table containing input fields --->
		<TABLE ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="100%">
		<TR>
		    <TD align="center">Select Project Code for Date Scheduling</TD></TR>
		<TR>
			<TD align="center">
			<!--- Table containing input fields --->
			<TABLE BORDER="0" CELLPADDING="4" CELLSPACING="0">								
			<TR><TD colspan="2">&nbsp;</TD></TR>
			<tr>
				<td><SPAN CLASS="required"><b>Select A Client:</b></SPAN></td>
					<CFQUERY DATASOURCE="#application.projdsn#" NAME="qprojects">
						SELECT client_proj, description, client_code 
							FROM client_proj ORDER BY client_code
					</CFQUERY>	
					<td>
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
						HTMLBETWEEN="</td></tr><tr><td><b>Select A Project Code:</b></td><td>"
						AUTOSELECTFIRST="Yes"
						EMPTYTEXT1="(Select)"
						EMPTYTEXT2="(Select)">
					</cfoutput>
				</tr>
				<TR>
				  <TD COLSPAN="2" ALIGN="center">&nbsp;</td>
			    </tr>
				<TR>
					<TD>
						<INPUT TYPE="Submit" VALUE="Select" onClick="form.action = 'meeting_date_select_code.cfm?action=go_edit'; form.submit();">
					</td>
					<td>
						<INPUT TYPE="Button" VALUE="Cancel" onClick="form.action = '/index.cfm'; form.submit();">
					</TD>
				</TR>
				</TABLE>
			</TD>
		</TR>
		</TABLE>
	</FORM>
	</CFDEFAULTCASE>
</CFSWITCH>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
