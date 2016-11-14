<!---
	*****************************************************************************************
	Name:

	Function:
	History:

	*****************************************************************************************
--->

<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="View Database Statistics" showCalendar="0">

	<!-- Save project_code to session depending on comes to this page as a form or URL variable -->
	<CFIF IsDefined("form.project_code")>
		<cfset session.project_code = form.project_code>
	<CFELSEIF IsDefined("URL.project_code")>
		<cfset session.project_code = URL.project_code>
	</CFIF>

	<!-- Save rowid to session depending on comes to this page as a form or URL variable -->
	<CFIF IsDefined("form.rowid")>
		<cfset session.rowid = form.rowid>
	<CFELSEIF IsDefined("URL.rowid")>
		<cfset session.rowid = URL.rowid>
	</CFIF>

<table>
	<CFIF IsDefined("url.no_menu")>
		<!---
		<cfoutput>
		<tr>
			<td width=20>&nbsp;</td>
			<td align="center"><font color="Navy">Below are statistics from project code : <font size="+1">#session.project_code#</font>'s database.</font>
				<br>
				<input type="button" name="print" value="  Print Sheet  " onClick="javascript:window.print()">
				<input type="button" name="close" value="  Close Window  " onClick="javascript:window.close()">
			</td>
		</tr>
		</cfoutput>
		--->
	<CFELSE>
		<cfoutput>
		<tr>
			<td width=20>&nbsp;</td>
			<td align="left">
				<font color="Navy">Below are statistics from project code : <font size="+1">#session.project_code#</font>'s database.</font>
			</td>
		</tr>
		</cfoutput>
	</CFIF>
		<td width=20>&nbsp;</td>
		<td>
			<table width="550" border="0" cellspacing="0" cellpadding="5" align="left">
			<!--- database info section --->
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="qdb">
					SELECT * FROM database_info WHERE project_code = '#session.project_code#'  AND rowid = '#session.rowid#';
				</cfquery>



				<cfoutput>
				<tr BGCOLOR="##99CCFF"><td colspan="2"><font size="2"><b><font color="Navy">Database Information for: #session.project_code#</font></b></font></td></tr>
				<tr BGCOLOR="##e5f6ff">
					<th width="200"><b>Database Received Date:</b></th>
					<td width="350">#dateFormat(qdb.received_date, "mm/dd/yy")#</td>
				</tr>
				<tr>
					<th><b>Received From:</b></th>
					<td>#trim(qdb.received_from)#</td>
				</tr>
				<tr BGCOLOR="##e5f6ff">
					<th><b>Received File Name:</b></th>
					<td>#trim(qdb.received_filename)#</td>
				</tr>
				<tr>
					<th><b>Original Format:</b></th>
					<td>
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="qfile_format">
					SELECT * FROM file_format_type
				</cfquery>


				<cfloop query="qfile_format">
					<cfif find("#type_id#", qdb.original_format) NEQ 0>#type_description#</cfif>
				</cfloop>

				</cfoutput>

				<cfoutput>
				<cfif find("5", qdb.original_format) NEQ 0>
				<b>Other Format:</b> #qdb.original_format_other#</cfif>
				</td>
				</tr>
				<tr BGCOLOR="##e5f6ff">
					<th><b>Number of Original Records:</b></th>
					<td>#qdb.total_records#</td>
				</tr>
				<tr>
					<th><b>Number of Records Without Phone:</b></th>
					<td>
					<cfif Len(qdb.total_nophone)>
					#qdb.total_nophone#
					<cfelse>
					N/A
					</cfif>
					</td>
				</tr>
				<tr BGCOLOR="##e5f6ff">
					<th><b>Number of Records Without Address:</b></th>
					<td>
					<cfif Len(qdb.total_noaddrs)>
					#qdb.total_noaddrs#
					<cfelse>
					N/A
					</cfif>
					</td>
				</tr>
				<tr>
					<th><b>Number of Records Without Zip Codes:</b></th>
					<td>
					<cfif Len(qdb.total_nozip)>
					#qdb.total_nozip#
					<cfelse>
					N/A
					</cfif>

					</td>
				</tr>
				<tr BGCOLOR="##e5f6ff">
					<th><b>Number of Records Without ME Number:</b></th>
					<td>
					<cfif Len(qdb.total_nomenum)>
					#qdb.total_nomenum#
					<cfelse>
					N/A
					</cfif>

					</td>
				</tr>
				<tr>
					<th><b>Number of Records Without Decile:</b></th>
					<td>
					<cfif Len(qdb.total_nodecile)>
					#qdb.total_nodecile#
					<cfelse>
					N/A
					</cfif>
					</td>
				</tr>
				<tr BGCOLOR="##e5f6ff">
					<th><b>Number of Records Without Specialty:</b></th>
					<td>
					<cfif Len(qdb.total_nospecialty)>
					#qdb.total_nospecialty#
					<cfelse>
					N/A
					</cfif>
					</td>
				</tr>
				<tr>
					<th><b>Phids on File:</b></th>
					<td>
					#qdb.total_matching#
					</td>
				</tr>
				<tr BGCOLOR="##e5f6ff">
					<th><b>Total Duplicates:</b></th>
					<td>
					#qdb.total_dups#
					</td>
				</tr>
				<tr>
					<th><b>Total Bad Records:</b></th>
					<td>
					#qdb.total_badrecs#
					</td>
				</tr>
				<tr BGCOLOR="##e5f6ff">
					<th><b>Total Records Sent:</b></th>
					<td>#qdb.total_available#</td>
				</tr>
				<tr>
					<th><b>Send Date:</b></th>
					<td>#dateFormat(qdb.date_completed, "mm/dd/yy")#</td>
				</tr>
				<tr BGCOLOR="##e5f6ff">
					<th><b>Send By:</b></th>
					<td>#trim(qdb.completed_by)#</td>
				</tr>
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="qrecruiter">
					SELECT * FROM recruiter
					WHERE id = #qdb.sent_to#
				</cfquery>
				</cfoutput>
				<cfoutput>
				<tr>
					<th><b>Send To:</b></th>
					<td>#qrecruiter.recruiter_name#</td>
				</tr>
				</cfoutput>
				<cfoutput>
				<tr BGCOLOR="##e5f6ff">
					<th><b>File Name Sent:</b></th>
					<td>#trim(qdb.sent_filename)#</td>
				</tr>
				<tr>
					<th><b>Notes:</b></th>
					<td>#trim(qdb.db_notes)#</td>
				</tr>
				<CFIF IsDefined("url.no_menu")>
					  <tr><td align="right" colspan="2">
					  <br>
					  <input type="button" name="submit" value=" View As PDF  " onClick="javascript:void window.open('PIW_dbView2_to_pdf.cfm?project_code=#Trim(session.project_code)#&rowid=#session.rowid#&no_menu=1','','width=650,scrollbars=yes,location=no');">


						<input type="button" name="print" value="  Print Sheet  " onClick="javascript:window.print()">
						<input type="button" name="close" value="  Close Window  " onClick="javascript:window.close()">
					  </td></tr>
					<cfelse>
					<tr>
					<td>&nbsp;

					</td>
					<td>

					<form action="piwdb2.cfm" onClick="javascript:void window.open('PIW_dbView2.cfm?project_code=#Trim(session.project_code)#&rowid=#session.rowid#&no_menu=1','','width=650,scrollbars=yes,location=no');">
					<input type="button" name="submit" value="  Print This Screen">
					</form>
					<form>
					<INPUT TYPE="button" NAME="submit" VALUE="Back to Database Admin" onClick="window.location = 'piw_db.cfm';">
					</form>
					</td>
				</tr>
				</CFIF>

				</cfoutput>
				<!--- end database info section --->
			</table>
		</td>
	</tr>
</table>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">