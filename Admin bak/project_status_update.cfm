<!--- 
	*****************************************************************************************
	Name:		project_status_update.cfm 11/24/2003
	
	Function:	Displays quoted and active project codes and updateable status.
	
	*****************************************************************************************
--->
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Active and Quoted Projects" showCalendar="0">

	
	<!--- set variables to hold sort order --->
	<cfif IsDefined('form.sortedby')>
		<cfset session.sortedby = form.sortedby>
		<cfset session.orderedby = form.orderedby>
	<cfelse>
		<cfparam name="session.sortedby" default="p.project_code">
		<cfparam name="session.orderedby" default="ASC">
	</cfif>



		<!--- Pull projects that are quoted or active --->
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="pullProjects">
			SELECT p.project_code, p.account_exec, p.piw_update, c.status, c.description, c.client_code, c.rowid, cl.client_code_description, s.codeDesc as status_description
			FROM PIW p, client_proj c, client_code cl, Lookup s	
			WHERE p.project_code = c.client_proj 
			AND c.client_code = cl.client_code 
			AND c.status = s.codevalue 
			AND S.CodeGroup = 'PROJECTSTATUS'
			AND (c.status = 0 OR c.status = 1 OR c.status = 2)
			ORDER BY #session.sortedby# #session.orderedby#
		</CFQUERY>
		

<TABLE ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="700">
<form action="project_status_update.cfm" method="post">
<tr>
	<td><p>Below are all Active or Quoted Projects. Change the status of any project that needs to be updated and click the Updated Button<br></p>
		<p>Select the Client Code and/or project status you wish to view from the dropdown boxes below.</p>
		<p>To edit projects that are not currently Quoted or Active, go to <a href="/projects/PIW_EDIT.cfm">Work on A Project</a>.</p>
		<br><br>
		<cfoutput>
				<!--- Display drop downs to control sort order --->
				<form action="project_status_update.cfm" method="post">
					&nbsp;&nbsp;&nbsp;&nbsp;
					Sort Projects by: 
					<select name="sortedby">
						<option value="p.project_code">Project Code</option>
						<option value="s.codeDesc" <cfif session.sortedby EQ 's.status_description'>Selected</cfif>>Status</option>
					</select>
					&nbsp;&nbsp;
					Order: 
					<select name="orderedby">
						<option value="ASC">ASC</option>
						<option value="DESC" <cfif session.orderedby EQ 'DESC'>Selected</cfif>>DESC</option>
					</select>
					&nbsp;&nbsp;
					<input type="submit" value="sort">
					<br><br>
					</td>
				</tr>
				</form>
		</cfoutput>
	</td>
</tr>
<tr>
  <td><hr noshade size="1"></td></td>
</tr>
</form>
<TR>
	<TD>
	<form action="project_status_update2.cfm" name="submitupdate" method="post">
	<!--- Table containing input fields --->
	<TABLE width=600 ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1">	
	<tr>
		<!--- <td class=highlight valign=bottom><font color=teal><b>Client</b></font></td> --->
		<td class=highlight valign=bottom><strong>Project Code</strong></td>
		<td class=highlight valign=bottom><strong>Status</strong></td>
		<td class=highlight valign=bottom><strong>Description</strong></td>
	</tr>
			
	<!--- Display quoted and active projects --->	
	<cfif pullProjects.recordcount LT 1>
		<TR ALIGN="left">
			<td width=10>&nbsp;</td>
			<td colspan=5 class=alert><b>No projects were found which matched your search request...</b></td>
		</TR>
	<cfelse>

		<cfoutput query="pullProjects">
				<TR ALIGN="left" <cfif PullProjects.currentrow MOD(2) EQ 0>bgcolor="##eeeeee"</cfif>>
					<td>#pullProjects.project_code#</td>
					<td>
						<!--- save the original status --->
						<input type="hidden" name="originalstatus#CurrentRow#" value="#pullProjects.status#">
						<!--- save the project code --->
						<input type="hidden" name="project#CurrentRow#" value="#pullProjects.project_code#">
						<!--- select box with status for each project --->
						<select name="status#CurrentRow#">
								<option value="1" <cfif trim(pullProjects.status) EQ 1>Selected</cfif>>Accepted</option>
								<option value="2" <cfif trim(pullProjects.status) EQ 2>Selected</cfif>>Active</option>
								<option value="0" <cfif trim(pullProjects.status) EQ 0>Selected</cfif>>Quoted</option>
								<option value="3" <cfif trim(pullProjects.status) EQ 3>Selected</cfif>>On Hold</option>
								<option value="4" <cfif trim(pullProjects.status) EQ 4>Selected</cfif>>Cancelled</option>
								<option value="5" <cfif trim(pullProjects.status) EQ 5>Selected</cfif>>Completed</option>	
						</select>&nbsp;&nbsp;
						<!--- save project rowid --->
						<input type="hidden" name="rowid#CurrentRow#" value="#pullProjects.rowid#">
					</td>
					<td>#pullProjects.description#</td>
				</TR>	
			</cfoutput>	
	</cfif>
	<tr><td height="50" valign="bottom" colspan="5" align="center"><input name="submit" type="submit" value="Submit Changes"></td></tr>
	<tr><td colspan="5">&nbsp;</td></tr>
	</TABLE>
		<!--- save the record count from this query --->
		<cfoutput><input type="hidden" name="recordsreturned" value="#pullProjects.recordcount#"></cfoutput>
	</form>
	</TD>
</TR>
</TABLE>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

