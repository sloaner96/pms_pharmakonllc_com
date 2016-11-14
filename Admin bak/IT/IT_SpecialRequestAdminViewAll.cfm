<!--- 
	*****************************************************************************************
	Name:
	Function:
	History:	
					
	*****************************************************************************************
--->
<HTML>
<HEAD>
<TITLE>IT Special Request</TITLE>
<LINK REL=stylesheet HREF="piw1style1.css" TYPE="text/css">
	<!-- Save project_code to session depending on comes to this page as a form or URL variable -->		
	<CFIF IsDefined("form.project_code")>
		<cfset session.project_code = form.project_code>
	<CFELSEIF IsDefined("URL.project_code")>
		<cfset session.project_code = URL.project_code>
	</CFIF>
</HEAD>
<!--- database_info query section --->
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="qspec_req">
			SELECT job_number, client, project_code, requested_by
			FROM special_request 
		</cfquery>
<BODY>
<table align="center">
		<td width=20>&nbsp;</td>
		<td>
			<table width="550" style="border:1px solid black;" cellspacing="0" cellpadding="5">
				<cfoutput>
				<tr BGCOLOR="##99CCFF">
				<td colspan="3" class="tdheader">IT Special Request Administrator View All</td></tr>
				<tr>
				<td></td><td></td><td></td>
				</tr>
				<cfloop query="qspec_req">
					<tr>
						<td>
							<!-- Shows a sampling of the Database, Becuase multiple databases occur with same Project Code  -->
							<font size="2">Job Number: #job_number#</font><br>
							<b>Client Code:</b> #client#<br>
							<b>Project Code:</b> #project_code#<br>
							
							<b>Requested By:</b>
							<CFQUERY DATASOURCE="hourday" NAME="srequest">
								select rowid, first_name, last_name, email 
								from user_id 
								where rowid = #trim(requested_by)#
							</CFQUERY>
							<cfoutput>#srequest.first_name# #srequest.last_name#<Br>
							<font size="2">#srequest.email#</font> </cfoutput><br>
						</td>
						<td>
							<form action="IT_SpecialRequestAdminViewOne.cfm" method="post"> 
								<input type="hidden" name="job_number" value="#job_number#">
								<INPUT TYPE="submit" NAME="edit" VALUE="View">
							</form>
						</td>
						<td>
							<form action="IT_SpecialRequestAdminEdit.cfm" method="post">
								<input type="hidden" name="job_number" value="#job_number#">
								<INPUT TYPE="submit" NAME="edit" VALUE="Edit">
							</form>
						</td>
					</tr>
					<!-- if not last record put a HR to seperate -->
					<CFIF #qspec_req.recordcount# NEQ #qspec_req.currentrow#>
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
</table>
</BODY>
</HTML>