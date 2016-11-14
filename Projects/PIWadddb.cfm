<!--- 
	*****************************************************************************************
	Name:		
	Function:	
	History:	
	
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
	<CFCASE VALUE="insert">
	
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="insert_database_info">
					INSERT INTO database_info
					(
					project_code, received_date, received_from, received_filename, 
					original_format, original_format_other, total_records, total_nophone,
					total_noaddrs,total_nozip, total_nomenum,total_nodecile, 
					total_nospecialty, total_available,	date_completed, completed_by, 
					sent_to, sent_filename, db_notes
					) 
					VALUES (
					'#session.project_code#',		
				<cfif trim(received_date) EQ "">
					null,
				<cfelse>
					'#form.received_date#',
				</cfif>
				'#trim(left(form.received_from, 50))#',
				'#trim(left(form.received_filename, 50))#',

				#form.original_format#,
				<cfif #form.original_format# neq 5>
				null,
				<cfelse>
				'#trim(left(form.original_format_other, 80))#',
				</cfif>

				<cfif form.total_records GT 0>
					#form.total_records#,
				<cfelse>
					0,
				</cfif>
					
				<cfif total_nophone GT 0>
					#form.total_nophone#,
				<cfelse>
					0,
				</cfif>
								
				<cfif total_noaddrs  GT 0>
					#form.total_noaddrs #,
				<cfelse>
					0,
				</cfif>
												
				<cfif total_nozip GT 0>
					#form.total_nozip#,
				<cfelse>
					0,
				</cfif>
								
				<cfif total_nomenum GT 0>
					#form.total_nomenum#,
				<cfelse>
					0,
				</cfif>
								
				<cfif total_nodecile GT 0>
					#form.total_nodecile#,
				<cfelse>
					0,
				</cfif>
								
				<cfif total_nospecialty GT 0>
					#form.total_nospecialty#,
				<cfelse>
					0,
				</cfif>
				
				<cfif total_available GT 0>
					#form.total_available#,
				<cfelse>
					0,
				</cfif>
				<cfif trim(date_completed) EQ "">
					null,
				<cfelse>
					'#form.date_completed#',
				</cfif>
				'#trim(left(form.completed_by, 50))#',
				'#form.sent_to#', 
				'#trim(left(form.sent_filename, 50))#', 
				'#trim(Left(form.db_notes,500))#'
				)
		</CFQUERY>
		<!--- update the timestamps in the PIW record --->
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="UPDATERECORD">
			UPDATE piw 
			SET piw_update = #createodbcdate(Now())#,
				piw_update_user = #session.userinfo.rowid#
			WHERE project_code = '#session.project_code#';
		</CFQUERY>
		<!--- return to the PIWedit page --->
		<META http-equiv="REFRESH" CONTENT="0; URL=PIW_db.cfm">
	</CFCASE>

	<CFDEFAULTCASE>
		<FORM ACTION="PIWadddb.cfm?action=insert" METHOD="post">
		<TABLE BGCOLOR="##000080" ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="700">
		<cfoutput>
		<TR><TD CLASS="tdheader">Project Information Worksheet - Add Database Statistics <br>Project Code: #session.project_code#</TD></TR>
		<TR>
			<TD>
			<!--- Table containing input fields --->
				
				<table width="700" border="0" align="center">
				  <tr>
					<td>
						<TABLE BGCOLOR="##000080" ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="350">
						<tr >
							<td CLASS="tdheader">Initital Database Information</td>
						</tr>
						<tr>
							<td>
								
								<table width="350" border="0">
									<tr>
										<td width="150"><b>Database Received Date:</b></td>
										<td width="200"><input type=text name=received_date onClick="CallCal(this)" CLASS="text"  SIZE="10" value="" onKeypress="if (event.keyCode < 47 || event.keyCode > 57) event.returnValue = false;">
													<img src="images/formcalendar.gif" style="vertical-align:middle"></td>
									</tr>
									<tr>
										<td><B>Received From:</b></td>
										<td><input type=text name=received_from value="" size=30 maxlength=50></td>
									</tr>
									<tr>
										<td><B>Received File Name:</b></td>
										<td><input type=text name=received_filename value="" size=30 maxlength=50></td>
									</tr>
									<tr>
										<td colspan="2">
										<B>Original Format:</b>
										
										</CFOUTPUT>
										<CFQUERY DATASOURCE="#application.projdsn#" NAME="qfile_format">
											SELECT * FROM file_format_type
										</cfquery>
										<cfloop query="qfile_format">
											<CFOUTPUT>
											<CFIF #type_description# NEQ "OTHER"> 
											<input type=radio name=original_format value="#type_id#" class="invis"> #type_description#
											<CFELSE>
											</td>
									 </tr>
									 <tr>
										<td colspan="2">
											<input type=radio name=original_format value="#type_id#" class="invis"> #type_description#
											<b>Other</b><input type=text name=original_format_other value="" size=30 maxlength=80>
										</td>
									</tr>
											</CFIF>
											
											</CFOUTPUT>
										</cfloop>
										
										
										
											
										
								</table>
							
							</td>
						</tr>
						</TABLE>
					</td>
					<td>
						<TABLE BGCOLOR="##000080" ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="350">
						<tr >
							<td CLASS="tdheader">Final Database Information</td>
						</tr>
						<tr>
							<td>
							<table>
							<tr>
							<td width="80"><B>Sent Date:</b></td>
							<td width="270"><input type=text name=date_completed onClick="CallCal(this)" CLASS="text"  SIZE="10" value="" onKeypress="if (event.keyCode < 47 || event.keyCode > 57) event.returnValue = false;" maxlength=10>
				<img src="images/formcalendar.gif" style="vertical-align:middle"></td>
							</tr>
							<tr>
							<td><B>Sent To:</b></td>
							<td>
							<!--- Pull recrutier names from recruiter table to be used in select statement for recruiter field --->
									
									<CFQUERY DATASOURCE="hourday" NAME="srecruiter" dbname="hourday">
										SELECT ID, recruiter_name FROM recruiter ORDER BY recruiter_name
									</CFQUERY>
								
									<SELECT NAME="sent_to">
													<CFOUTPUT QUERY="srecruiter">
														<OPTION VALUE="#srecruiter.ID#"<CFIF #srecruiter.ID# EQ 1> checked</CFIF>>#trim(srecruiter.recruiter_name)#
													</CFOUTPUT>
												</SELECT>
										
										
							</td>
							</tr>
							<tr>
							<td>
							<B>Sent By:</b>
							</td>
							<td>
							<input type=text name=completed_by value="" size=30 maxlength=50>
							</td>
							</tr>
							<tr>
							<td><B>File Name:</b>
							</td>
							<td><input type=text name=sent_filename value="" size=30 maxlength=50>
							</td>
							</tr>
							
							<tr>
							<td><B>Total Sent:</b>
							</td>
							<td><input type=text name=total_available value="" size=10 onKeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;">
				
							</td>
							</tr>
							</table>
						
						</td>
						</tr>
						</TABLE>
					</td>
				  </tr>
				  <tr>
					<td colspan="2">
						<TABLE BGCOLOR="##000080" ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="600">
						<tr>
							<td CLASS="tdheader">Database Statistics</td>
						</tr>
						<tr>
							<td>
							<table width="600" border="0">
							  <tr>
									<td width="220"><B>Total Original Records in Database:</b></td>
									<td width="80"><input type=text name=total_records value="" size=10 onKeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;">
									</td>
									
									<td width="220"><B>Total Without ME ##:</b></td>
									<td width="80"><input type=text name=total_nomenum value="" size=10 onKeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;">
									</td>
							  </tr>							
							  <tr>
									<td><B>Total Without Phone:</b></td>
									<td><input type=text name=total_nophone value="" size=10 onKeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;">
									</td>
									
									<td><B>Total Without Decile:</b></td>
									<td><input type=text name=total_nodecile value="" size=10 onKeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;">
									</td>
									
							  </tr>
							  <tr>
									<td><B>Total Without Address:</b></td>
									<td><input type=text name=total_noaddrs value="" size=10 onKeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;">
									</td>
									
									<td><B>Total Without Specialty:</b></td>
									<td><input type=text name=total_nospecialty value="" size=10 onKeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;">
									</td>
							  </tr>
							  <tr>
									<td><B>Total Without Zip Code:</b></td>
									<td colspan="3"><input type=text name=total_nozip value="" size=10 onKeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;">
									</td>
							  </tr>
							</table>
						
							</td>
						</tr>
						</TABLE>
					
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<TABLE BGCOLOR="##000080" ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="600">
						<tr >
							<td CLASS="tdheader">Database Notes For #session.project_code#</td>
						</tr>
						<tr>
							<td align="center">
								<TEXTAREA NAME="db_notes" COLS="65" ROWS="4"></textarea>
							</td>
						</tr>
						</TABLE>
					
					</td>
				  </TR>
				  <tr>  
					<td align="right">
					<INPUT  TYPE="submit" NAME="submit" VALUE="  Finish  ">
					</form>
					</td>
					<td align="left">
					<FORM ACTION="PIWedit.cfm" METHOD="post">
					<INPUT  TYPE="submit" NAME="cancel" VALUE="  Cancel  ">
					</form>
					</td>
					</tr>
				</table>
				
				
			</TD>
		</TR>
		</TABLE>
	</CFDEFAULTCASE>
</CFSWITCH>

<cfmodule template="#Application.tagpath#/ctags/footer.cfm">