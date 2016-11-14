<!--- 
	*****************************************************************************************
	Name:		meeting_select_code.cfm
	
	Function:	Allows user to select which project code they would like to do scheduling for.
	History:	8/8/01 - Modified from Piwedit.cfm, CJL
	
	*****************************************************************************************
--->
<cfparam name="URL.Action" default="">  
<CFSWITCH EXPRESSION="#URL.action#">

<!--- Case to perform edit action that was selected --->
	<CFCASE VALUE="go_edit">
	
		<CFSET session.project_code = form.project_code>
	
		<CFOUTPUT>
			<META HTTP-EQUIV="REFRESH" CONTENT="0; URL=meeting_time_list.cfm">
		</CFOUTPUT>
		
	</CFCASE>

<!--- Default case to present edit selection form to user --->	
	<CFDEFAULTCASE>
		<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Meeting Time Schedule" showCalendar="0">

			
				<!--- Query to grab all Active Project Codes and Populate a dropdown for the User --->
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="get_projectcode">
					SELECT project_code
					FROM piw
					WHERE project_status IN(0,1,2,5)	
					ORDER BY project_code
				</CFQUERY>
			
				<FORM ACTION="meeting_select_code.cfm?action=go_edit" METHOD="post">
	
								<!--- Table containing input fields --->
								<TABLE ALIGN="center" BORDER="0" CELLPADDING="0" CELLSPACING="15" WIDTH="85%">
									<TR>
								   		<TD ALIGN="center">Select Project Code for Time Scheduling:&nbsp;&nbsp;&nbsp;
											<SELECT NAME="project_code" SIZE="1">
												<CFOUTPUT QUERY="get_projectcode">
													<OPTION <CFIF (isDefined("session.project_code")) AND (session.project_code EQ trim(Project_code))>SELECTED</CFIF>>#trim(Project_code)#</OPTION>
												</CFOUTPUT>
											</SELECT>
										</TD>
									</TR>
									
									<TR>
										<TD>&nbsp;</TD>
									</TR>
																	
									<TR>
										<TD ALIGN="Center">
											<INPUT TYPE="Submit"  VALUE="Schedule" onClick="form.action = 'meeting_time_select_code.cfm?action=go_edit'; form.submit();">&nbsp;&nbsp;&nbsp;&nbsp;<INPUT TYPE="Button"  VALUE="Cancel" onClick="form.action = 'index.cfm'; form.submit();">
										</TD>
									</TR>
								</TABLE>
				</FORM>
			<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
	</CFDEFAULTCASE>
</CFSWITCH>