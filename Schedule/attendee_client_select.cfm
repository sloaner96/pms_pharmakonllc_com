<!--- 
	*****************************************************************************************
	Name:		attendee_client_select.cfm
	
	Function:	Allows user to select which project code they would like to add attendee counts for.
	History:	
	
	*****************************************************************************************
--->
<cfset thistitle ="Post Attendance for #session.project_code#">

<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="#thistitle#" showCalendar="0">



			
				<!--- fetch all projects to fill select box --->
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="get_projectcode">
					SELECT project_code
					FROM piw
					WHERE project_status = 0	
					ORDER BY project_code
				</CFQUERY>
			
<FORM ACTION="attendee_client_results.cfm" METHOD="post">

		<!--- Table containing input field --->
		<TABLE ALIGN="center" BORDER="0" CELLPADDING="0" CELLSPACING="15" WIDTH="85%">
			<TR>
				<TD ALIGN="center">Select Project Code to Post Attendance:&nbsp;&nbsp;&nbsp;
					<SELECT NAME="project_code" SIZE="1">
					<CFOUTPUT QUERY="get_projectcode">
					<OPTION value="#trim(Project_code)#" <cfif session.project_code EQ trim(get_projectcode.Project_Code)>Selected</cfif>>#trim(Project_code)#</OPTION>
					</CFOUTPUT>
					</SELECT>
				</TD>
			</TR>
			<TR>
				<TD>&nbsp;</TD>
			</TR>
			<TR>
				<TD ALIGN="Center">
					<INPUT TYPE="Submit"  VALUE="Submit">
				</TD>
			</TR>
		</TABLE>
</FORM>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
