<!--- 
	*****************************************************************************************
	Name:		edit_db.cfm
	
	Function:	This page allows the user to edit the Database information for a certain 
				project. This page accepts the input and also updates the database.
	History:	7/18/01, finalized code	TJS
	
	*****************************************************************************************
--->
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Add Database Statistics" showCalendar="0">

<SCRIPT language="JavaScript">
// Pulls up calendar for user to select date
function CallCal(InputField)
	{
	var datefield = InputField.value;
		
	if (datefield.length < 1)
		{
		var sRtn;
		sRtn = showModalDialog("Calendar.cfm?Day=&Month=&Year=&no_menu=1","","center=yes;dialogWidth=180pt;dialogHeight=210pt;resizeable: Yes");

		if (sRtn!="")
			InputField.value = sRtn;
		}
	else
		{
		// Find the first forward slash in the date string
		var index = datefield.indexOf("/", 0);
					
		// Grab all the numbers before the first forward slash
		var month = datefield.substr(0, index);
						
		// Find the second forward slash
		var index2 = (datefield.indexOf("/", index+1) - 1)
					
		// Get the numbers after the first forward slash but before the second one
		var day = datefield.substr((index+1), (index2 - index));
						
		// Find the last forward slash
		var index = datefield.lastIndexOf("/");
						
		// Get the numbers after the third (i.e. last) forward slash
		var year = datefield.substr((index+1), (datefield.length-1));
							
		// Call the calendar.cfm file passing the values previously obtained
		var sRtn;
		sRtn = showModalDialog("Calendar.cfm?Day=" + day + "&Month=" + month + "&Year=" + year + "&no_menu=1","","center=yes;dialogWidth=180pt;dialogHeight=210pt;resizeable: Yes");
			
		// Return the selected date to the input field
		if (sRtn!="")
			InputField.value = sRtn;
		}
	}
</script>
</HEAD>
<BODY>
<CFSWITCH EXPRESSION="#URL.action#">
	<!--- Case for submitting the information just entered --->
	<CFCASE VALUE="update">
		<!--- update database_info table --->
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="update_database_info">
			UPDATE database_info 
				SET	
				<cfif trim(received_date) EQ "">
					received_date = null,
				<cfelse>
					received_date = '#form.received_date#',
				</cfif>
				received_from = '#trim(left(form.received_from, 50))#',
				received_filename = '#trim(left(form.received_filename, 50))#',
				<cfif trim(requested_date) EQ "">
					requested_date = null,
				<cfelse>
					requested_date = '#form.requested_date#',
				</cfif>
				original_format = #form.original_format#,
				original_format_other = '#trim(left(form.original_format_other, 80))#',
				requested_format = #form.requested_format#,
				requested_format_other = '#trim(left(form.requested_format_other, 80))#',
				<cfif form.total_records GT 0>
					total_records = #form.total_records#,
				<cfelse>
					total_records = 0,
				</cfif>
	
				<cfif form.total_phone GT 0>
					total_phone = #form.total_phone#,
				<cfelse>
					total_phone = 0,
				</cfif>
				
				<cfif total_nophone GT 0>
					total_nophone = #form.total_nophone#,
				<cfelse>
					total_nophone = 0,
				</cfif>
				
				<cfif total_addrs1 GT 0>
					total_addrs1 = #form.total_addrs1#,
				<cfelse>
					total_addrs1 = 0,
				</cfif>
				
				<cfif total_noaddrs1 GT 0>
					total_noaddrs1 = #form.total_noaddrs1#,
				<cfelse>
					total_noaddrs1 = 0,
				</cfif>
				
				<cfif total_state GT 0>
					total_state = #form.total_state#,
				<cfelse>
					total_state = 0,
				</cfif>
				
				<cfif total_nostate GT 0>
					total_nostate = #form.total_nostate#,
				<cfelse>
					total_nostate = 0,
				</cfif>
				
				<cfif total_zip GT 0>
					total_zip = #form.total_zip#,
				<cfelse>
					total_zip = 0,
				</cfif>
				
				<cfif total_nozip GT 0>
					total_nozip = #form.total_nozip#,
				<cfelse>
					total_nozip = 0,
				</cfif>
				
				<cfif total_menum GT 0>
					total_menum = #form.total_menum#,
				<cfelse>
					total_menum = 0,
				</cfif>
				
				<cfif total_nomenum GT 0>
					total_nomenum = #form.total_nomenum#,
				<cfelse>
					total_nomenum = 0,
				</cfif>
				
				<cfif total_decile GT 0>
					total_decile = #form.total_decile#,
				<cfelse>
					total_decile = 0,
				</cfif>
				
				<cfif total_nodecile GT 0>
					total_nodecile = #form.total_nodecile#,
				<cfelse>
					total_nodecile = 0,
				</cfif>
				
				<cfif total_specialty GT 0>
					total_specialty = #form.total_specialty#,
				<cfelse>
					total_specialty = 0,
				</cfif>
				
				<cfif total_nospecialty GT 0>
					total_nospecialty = #form.total_nospecialty#,
				<cfelse>
					total_nospecialty = 0,
				</cfif>
				
				<cfif total_sent GT 0>
					total_sent = #form.total_sent#,
				<cfelse>
					total_sent = 0,
				</cfif>
				<cfif trim(sent_date) EQ "">
					sent_date = null,
				<cfelse>
					sent_date = '#form.sent_date#',
				</cfif>
				sent_by = '#trim(left(form.sent_by, 50))#',
				sent_to = '#trim(left(form.sent_to, 50))#',
				sent_filename = '#trim(left(form.sent_filename, 50))#', --->
				db_notes = '#trim(Left(form.db_notes,500))#'
			WHERE project_code = '#session.project_code#'
		</CFQUERY>
		<!--- update the timestamps in the PIW record --->
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="UPDATERECORD">
			UPDATE piw 
			SET piw_update = #createodbcdate(Now())#,
				piw_update_user = #session.userinfo.rowid#
			WHERE project_code = '#session.project_code#';
		</CFQUERY>
		<!--- return to the PIWedit page --->
		<META http-equiv="REFRESH" CONTENT="0; URL=PIWedit.cfm">
	</CFCASE>

	<CFDEFAULTCASE>
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="qdb">
			SELECT * FROM database_info	WHERE project_code = '#session.project_code#';
		</CFQUERY>
		<FORM ACTION="PIWedit_db.cfm?action=update" METHOD="post">
		<TABLE BGCOLOR="##000080" ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="700">
		<cfoutput>
		<TR><TD CLASS="tdheader">Project Initiation Worksheet - PIW DATABASE EDIT<br>Project Code: #session.project_code#</TD></TR>
		<TR>
			<TD>
			<!--- Table containing input fields --->
			<TABLE ALIGN="center" BORDER="0" CELLPADDING="0" CELLSPACING="2" WIDTH=650>		
			<tr height=20><td colspan=4>&nbsp;</td></tr>						
			<TR ALIGN="center"> 
				<TD ALIGN="right"><B>Database Received Date:</B></td>
				<td align=left><input type=text name=received_date onClick="CallCal(this)" CLASS="text"  SIZE="10" value="" size=10 onKeypress="if (event.keyCode < 47 || event.keyCode > 57) event.returnValue = false;"></td>
				<TD ALIGN="right"><B>Received From:</B></td>
				<td align=left><input type=text name=received_from value="" size=30 maxlength=50></td>
			</TR>
			<TR ALIGN="center"> 
				<TD ALIGN="right"><B>File Name:</B></td>
				<td align=left><input type=text name=received_filename value="" size=30 maxlength=50></td>
				<TD ALIGN="right"><B>Requested Date:</B></td>
				<td align=left><input type=text name=requested_date onClick="CallCal(this)" CLASS="text"  SIZE="10" value="" size=10 onKeypress="if (event.keyCode < 47 || event.keyCode > 57) event.returnValue = false;" size=10 maxlength=10></td>
			</TR>
			<TR ALIGN="center"> 
				<TD ALIGN="right"><B>Sent Date:</B></td>
				<td align=left><input type=text name=sent_date onClick="CallCal(this)" CLASS="text"  SIZE="10" value="" size=10 onKeypress="if (event.keyCode < 47 || event.keyCode > 57) event.returnValue = false;" size=10 maxlength=10></td>
				<td colspan=2>&nbsp;</td>
			</TR>
			<TR ALIGN="center"> 
				<TD ALIGN="right"><B>Sent To:</B></td>
				<td align=left><input type=text name=sent_to value="" size=30 maxlength=50></td>
				<TD ALIGN="right"><B>Sent By:</B></td>
				<td align=left><input type=text name=sent_by value="" size=30 maxlength=50></td>
			</TR>
			<TR ALIGN="center"> 
				<TD ALIGN="right"><B>File Name:</B></td>
				<td align=left><input type=text name=sent_filename value="" size=30 maxlength=50></td>
				<TD ALIGN="right"><B>Total Sent:</B></td>
				<td align=left><input type=text name=total_sent value="" size=10></td>
			</TR>
			<TR ALIGN="center"> 
				<TD ALIGN="right"><B>Original Format:</B></td>
				<td align=left>
					<!--- default is Excel format --->
					<input type=radio name=original_format value="1">&nbsp;<b>Excel</b>&nbsp;&nbsp;
					<input type=radio name=original_format value="2">&nbsp;<b>Text</b>&nbsp;&nbsp;
					<input type=radio name=original_format value="3">&nbsp;<b>MDB</b>&nbsp;&nbsp;
					<input type=radio name=original_format value="4">&nbsp;<b>Other</b>
				</td>
				<td><b>Other:</b></td>
				<td><input type=text name=original_format_other value="" size=30 maxlength=80></td>
			</tr>
			<TR ALIGN="center"> 
				<TD ALIGN="right"><B>Requested Format:</B></td>
				<td align=left>
					<!--- default is Excel format --->
					<input type=radio name=requested_format value="1">&nbsp;<b>Excel</b>&nbsp;&nbsp;
					<input type=radio name=requested_format value="2">&nbsp;<b>Text</b>&nbsp;&nbsp;
					<input type=radio name=requested_format value="3">&nbsp;<b>MDB</b>&nbsp;&nbsp;
					<input type=radio name=requested_format value="4">&nbsp;<b>Other</b>
				</td>
				<td><b>Other:</b></td>
				<td><input type=text name=requested_format_other value="" size=30 maxlength=80></td>
			</TR>
			<TR ALIGN="center"> 
				<TD ALIGN="right"><B>Total Records in Database:</B></td>
				<td align=left><input type=text name=total_records value="" size=10></td>
				<td colspan=2>&nbsp;</td>
			</TR>
			<TR ALIGN="center"> 
				<TD ALIGN="right"><B>Total With Phone:</B></td>
				<td align=left><input type=text name=total_phone value="" size=10></td>
				<TD ALIGN="right"><B>Total Without Phone:</B></td>
				<td align=left><input type=text name=total_nophone value="" size=10></td>
			</TR>
			<TR ALIGN="center"> 
				<TD ALIGN="right"><B>Total With Address:</B></td>
				<td align=left><input type=text name=total_addrs1 value="" size=10></td>
				<TD ALIGN="right"><B>Total Without Address:</B></td>
				<td align=left><input type=text name=total_noaddrs1 value="" size=10></td>
			</TR>
			<TR ALIGN="center"> 
				<TD ALIGN="right"><B>Total With State:</B></td>
				<td align=left><input type=text name=total_state value="" size=10></td>
				<TD ALIGN="right"><B>Total Without State:</B></td>
				<td align=left><input type=text name=total_nostate value="" size=10></td>
			</TR>
			<TR ALIGN="center"> 
				<TD ALIGN="right"><B>Total With Zip Code:</B></td>
				<td align=left><input type=text name=total_zip value="" size=10></td>
				<TD ALIGN="right"><B>Total Without Zip Code:</B></td>
				<td align=left><input type=text name=total_nozip value="" size=10></td>
			</TR>
			<TR ALIGN="center"> 
				<TD ALIGN="right"><B>Total With ME ##:</B></td>
				<td align=left><input type=text name=total_menum value="" size=10></td>
				<TD ALIGN="right"><B>Total Without ME ##:</B></td>
				<td align=left><input type=text name=total_nomenum value="" size=10></td>
			</TR>
			<TR ALIGN="center"> 
				<TD ALIGN="right"><B>Total With Decile:</B></td>
				<td align=left><input type=text name=total_decile value="" size=10></td>
				<TD ALIGN="right"><B>Total Without Decile:</B></td>
				<td align=left><input type=text name=total_nodecile value="" size=10></td>
			</TR>
			<TR ALIGN="center"> 
				<TD ALIGN="right"><B>Total With Specialty:</B></td>
				<td align=left><input type=text name=total_specialty value="" size=10></td>
				<TD ALIGN="right"><B>Total Without Specialty:</B></td>
				<td align=left><input type=text name=total_nospecialty value="" size=10></td>
			</TR>
			<TR ALIGN="center"> 
				<TD colspan=4 ALIGN="center"><B>Database Notes For #session.project_code#</B></td>
			</TR>
			</cfoutput>
			<TR ALIGN="center"> 
				<TD colspan=4 ALIGN="center">&nbsp;&nbsp;&nbsp;<TEXTAREA NAME="db_notes" COLS="64" ROWS="4"></textarea></td>


			
			</TR>
			<tr height=20><td colspan=4>&nbsp;</td></tr>
			<TR>
		   		<TD colspan=2 ALIGN="center"><INPUT  TYPE="submit" NAME="submit" VALUE="  Finish  "></TD>
				</form>
				<FORM ACTION="PIWedit.cfm" METHOD="post">
		   		<TD colspan=2 ALIGN="center"><INPUT  TYPE="submit" NAME="cancel" VALUE="  Cancel  "></TD>
				</form>
			</TR>
			<tr height=20><td colspan=4>&nbsp;</td></tr>
			</TABLE>
			</TD>
		</TR>
		</TABLE>
	</CFDEFAULTCASE>
</CFSWITCH>

<cfmodule template="#Application.tagpath#/ctags/footer.cfm">