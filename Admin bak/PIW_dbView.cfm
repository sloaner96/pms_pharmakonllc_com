<!--- 
	*****************************************************************************************
	Name:View Database Statistics
	Function:
	History:	
					
	*****************************************************************************************
--->

	<!-- Save project_code to session depending on comes to this page as a form or URL variable -->		
	<CFIF IsDefined("form.project_code")>
		<cfset session.project_code = form.project_code>
	<CFELSEIF IsDefined("URL.project_code")>
		<cfset session.project_code = URL.project_code>
	</CFIF>
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="View Database Statistics" showCalendar="0">

<table align="center">
<tr>
	<td width=20>&nbsp;</td>
	<td>
		<!--- database_info query section --->
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="qdb">
			SELECT project_code,received_date,received_from,received_filename,total_records,total_available,rowid 
			FROM database_info 
			WHERE project_code = '#session.project_code#'
			ORDER BY rowid
		</cfquery>

		<cfoutput>
			<!-- CFIF's determine if one or many databases to write letter S etc. -->
			<p align="left"><b><font color="Navy">Below is a list of <CFIF qdb.recordcount EQ 1>a </CFIF>database<CFIF qdb.recordcount GT 1>s</CFIF> with the Project Code<CFIF qdb.recordcount GT 1>s</CFIF> : #session.project_code#.</font></b></p>
		</cfoutput>
	</td>
	</tr>
		<td width=20>&nbsp;</td>
		<td>
			<table width="550" style="border:1px solid black;" cellspacing="0" cellpadding="5">
				<cfoutput>
				<tr BGCOLOR="##99CCFF">
				<td colspan="3"><font size="2"><b><font color="Navy">PIW - View Database Statistics</font></b></font></td></tr>
				<tr>
				<td></td><td></td><td></td>
				</tr>
				<cfloop query="qdb">
					<tr>
						<td>
							<!-- Shows a sampling of the Database, Becuase multiple databases occur with same Project Code  -->
							<font size="2">Project Code: #session.project_code#</font><br>
							<b>Received Date:</b> #dateFormat(qdb.received_date, "mm/dd/yy")#<br>
							<b>Received From:</b> #trim(qdb.received_from)# <br>
							<b>Original File:</b> #trim(qdb.received_filename)#<br>
							<b>Original Total Records:</b> #trim(qdb.total_records)#<br>
							<b>Total Records Sent:</b> #trim(qdb.total_available)#
						</td>
						<td align="center">
							<form action="piw_dbView2.cfm" method="post">
								<input type="hidden" name="project_code" value="#session.project_code#">
								<input type="hidden" name="rowid" value="#qdb.rowid#">
								<INPUT TYPE="submit" NAME="edit" VALUE="View Stats">
							</form>
						</td>
						<td align="center">
							<form action="piw_dbEdit.cfm?project_code=#Trim(session.project_code)#" method="post">
								<input type="hidden" name="project_code" value="#session.project_code#">
								<input type="hidden" name="rowid" value="#qdb.rowid#">
								<INPUT TYPE="submit" NAME="edit" VALUE="Edit Stats">
							</form>
						</td>
					</tr>
					<!-- if not last record put a HR to seperate -->
					<CFIF #qdb.recordcount# NEQ #qdb.currentrow#>
					<tr>
						<td colspan="3">
							<hr>
						</td>
					</tr>
					</CFIF>
				</cfloop>
				</cfoutput>
			</table>		
		</td>
	</tr>
	<tr>
	<td colspan="2">
		<table width="100%" border="0" ALIGN="Center">
		  <tr>
			<td ALIGN="Center"><form method="post" action="PIW_db.cfm" ><INPUT TYPE="submit" NAME="submit" VALUE="  Cancel  "></form>&nbsp;</td>
		  </tr>
		</table>
	</td>
	</tr>
</table>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
