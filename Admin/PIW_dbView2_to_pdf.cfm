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
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="qdb">
					SELECT * FROM database_info WHERE project_code = '#session.project_code#'  AND rowid = '#session.rowid#';
				</cfquery>
				
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="qfile_format">
					SELECT * FROM file_format_type
				</cfquery>
				
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="qrecruiter">
					SELECT * FROM recruiter
					WHERE id = #qdb.sent_to#
				</cfquery>				
<CF_HTML2PDF3 
myHTMLDOC="C:\CFusionMX\ghtmldoc.exe" 
myPDFPath= "#application.REPORTPATH#\pdf\piw\database_stats"
myPDF= "#session.project_code#_DB_STATS.pdf"
myOptions="--no-toc --no-title --fontsize 10 --top margin .5in
--footer -D1 "
>
<cfoutput>
<table border="1" width="720" cellpadding="10" cellspacing="0" align="center">

		<tr>
			<td colspan="2" align="center">
			<h3><font color="Navy">Below are statistics from project code : <font size="+1"><cfoutput>#session.project_code#</cfoutput></font>'s database.</font>
			</h3>
			&nbsp;</td>
		</tr>
		<tr>
				<td width="280" align="right"><b>Database Received Date:</b></td>
				<td width="440"><cfoutput>#dateFormat(qdb.received_date, "mm/dd/yy")#</cfoutput>&nbsp;&nbsp;</td>
		</tr>
		<tr>
				<td align="right"><b>Received From:</b></td>
				<td><cfoutput>#trim(qdb.received_from)#</cfoutput>&nbsp;</td>
		</tr>
		<tr>
				<td align="right"><b>Received File Name(s):</b></td>
				<td><cfoutput>#trim(qdb.received_filename)#</cfoutput>&nbsp;</td>
		</tr>
		<tr>
				<td align="right"><b>Original Format:</b></td>
				<td>

				<cfloop query="qfile_format">
					<cfoutput><cfif find("#type_id#", qdb.original_format) NEQ 0><cfoutput>#type_description#</cfoutput></cfif></cfoutput>
				</cfloop>
				<cfif find("5", qdb.original_format) NEQ 0><b>Other Format:</b><cfoutput>#qdb.original_format_other#</cfoutput></cfif>
			&nbsp;</td>
		</tr>
		<tr>
					<td align="right"><b>Number of Original Records:</b></td>
					<td><cfoutput>#qdb.total_records#</cfoutput>&nbsp;</td>
		</tr>
				<tr>
					<td align="right"><b>Number of Records Without Phone:</b></td>
					<td>
					<cfif Len(qdb.total_nophone)><cfoutput>#qdb.total_nophone#</cfoutput><cfelse>
					N/A
					</cfif>
					&nbsp;</td>
		</tr>
				<tr>
					<td align="right"><b>Number of Records Without Address:</b></td>
					<td>
					<cfif Len(qdb.total_noaddrs)><cfoutput>#qdb.total_noaddrs#</cfoutput><cfelse>
					N/A
					</cfif>
					&nbsp;</td>
		</tr>
				<tr>
					<td align="right"><b>Number of Records Without Zip Codes:</b></td>
					<td>
					<cfif Len(qdb.total_nozip)><cfoutput>#qdb.total_nozip#</cfoutput><cfelse>
					N/A
					</cfif>
					
					&nbsp;</td>
		</tr>
				<tr>
					<td align="right"><b>Number of Records Without ME Number:</b></td>
					<td>
					<cfif Len(qdb.total_nomenum)><cfoutput>#qdb.total_nomenum#</cfoutput><cfelse>
					N/A
					</cfif>
					
					&nbsp;</td>
		</tr>
				<tr>
					<td align="right"><b>Number of Records Without Decile:</b></td>
					<td>
					<cfif Len(qdb.total_nodecile)><cfoutput>#qdb.total_nodecile#</cfoutput><cfelse>
					N/A
					</cfif>					
					&nbsp;</td>
		</tr>
				<tr>
					<td align="right"><b>Number of Records Without Specialty:</b></td>
					<td>
					<cfif Len(qdb.total_nospecialty)><cfoutput>#qdb.total_nospecialty#</cfoutput><cfelse>
					N/A
					</cfif>
					&nbsp;</td>
		</tr>
				<tr>
					<td align="right"><b>Phids on File:</b></td>
					<td><cfoutput>#qdb.total_matching#</cfoutput>&nbsp;</td>
		</tr>
				<tr>
					<td align="right"><b>Total Duplicates:</b></td>
					<td><cfoutput>#qdb.total_dups#</cfoutput>&nbsp;</td>
		</tr>
				<tr>
					<td align="right"><b>Total Bad Records:</b></td>
					<td><cfoutput>#qdb.total_badrecs#</cfoutput>&nbsp;</td>
		</tr>
				<tr>
					<td align="right"><b>Total Records Sent:</b></td>
					<td><cfoutput>#qdb.total_available#</cfoutput>&nbsp;</td>
		</tr>
				<tr>
					<td align="right"><b>Send Date:</b></td>
					<td><cfoutput>#dateFormat(qdb.date_completed, "mm/dd/yy")#</cfoutput>&nbsp;</td>
		</tr>
				<tr>
					<td align="right"><b>Send By:</b></td>
					<td><cfoutput>#trim(qdb.completed_by)#</cfoutput>&nbsp;</td>
		</tr>
	

				<tr>
					<td align="right"><b>Send To:</b></td>
					<td><cfoutput>#qrecruiter.recruiter_name#</cfoutput>&nbsp;</td>
		</tr>

				<tr>
					<td align="right"><b>File Name Sent:</b></td>
					<td><cfoutput>#trim(qdb.sent_filename)#</cfoutput>&nbsp;</td>
		</tr>
				<tr>
					<td align="right"><b>Notes:</b></td>
					<td><cfoutput>#trim(qdb.db_notes)#</cfoutput>&nbsp;</td>
		</tr>
</table>
</cfoutput>
</CF_HTML2PDF3> 
<cfoutput> 
<cflocation addtoken="no" url="#application.Baseurl#\Reports\Temp\pdf\piw\database_stats\#session.project_code#_DB_STATS.pdf">
</cfoutput>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">