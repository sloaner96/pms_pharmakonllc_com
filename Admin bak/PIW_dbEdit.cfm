<!--- 
	*****************************************************************************************
	Name:			
	Function:	
	History:	
	
	*****************************************************************************************
--->
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Edit Database Statistics" showCalendar="1">
<cfparam name="URL.action" default="">
<SCRIPT language="JavaScript">
	function validate(f)
	{
	// Make sure none of the required fields are empty
	if (f.no_noaddrs.value == '0' && f.total_noaddrs.value=='0')
		{
		alert("Please Enter Total No Addresses or Check Not Applicable button!");
		return false;
		}
	return true;
	}

	function  _checkLimitContent(_CF_this)
	{
		if (_CF_this.value.length > 500)
		{
			alert("Please limit your notes to 500 characters. \nEvertything typed following this message will be deleted.");
    		return false;
  		}

    	return true;
	}
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

<CFIF IsDefined("form.project_code")><cfset session.project_code = form.project_code>
<CFELSEIF IsDefined("URL.project_code")><cfset session.project_code = URL.project_code>
</CFIF>

<CFIF IsDefined("form.rowid")><cfset session.rowid = form.rowid>
<CFELSEIF IsDefined("URL.rowid")><cfset session.rowid = URL.rowid>
</CFIF>



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
				
				<cfif IsDefined("original_format")>
				original_format = '#form.original_format#',
				<Cfelse>
				original_format = 0,
				</cfif>
				
				<cfif find("5", form.original_format) EQ 0>
				original_format_other = null,
				<cfelse>
				original_format_other = '#trim(left(form.original_format_other, 80))#',
				</cfif>
				<CFIF Len(total_records)>
				total_records = #form.total_records#,
				<cfelse>
				total_records = null,
				</CFIF>
				<CFIF Len(total_available)>
				total_available = #form.total_available#,
				<cfelse>
				total_available = null,
				</CFIF> 
				
				<CFIF Len(form.total_matching)>
				total_matching = #form.total_matching#,
				<cfelse>
				total_matching = null,
				</CFIF>
				<CFIF Len(form.total_dups)>
				total_dups = #form.total_dups#,
				<cfelse>
				total_dups = null,
				</CFIF>
				<CFIF Len(form.total_badrecs)>
				total_badrecs = #form.total_badrecs#,
				<cfelse>
				total_badrecs = null,
				</CFIF>
				
				<cfif Len(form.total_noaddrs)>
					na_noaddrs  = null,
					total_noaddrs = #form.total_noaddrs#,
				<cfelse>
					na_noaddrs  = 1,
					total_noaddrs = null,
				</CFIF>
				
				<CFIF Len(form.total_nophone)>
					na_nophone= null,
					total_nophone = #form.total_nophone#,
					<cfelse>
					na_nophone= 1,
					total_nophone = null,
				</CFIF>
				
								
				
					
				
				<cfif Len(form.total_nozip)>
					na_nozip = null,
					total_nozip = #form.total_nozip#,
				<cfelse>
					na_nozip = 1,
					total_nozip = null,	
				</CFIF>
				
				<cfif Len(form.total_nomenum)>
					na_nomenum = null,
					total_nomenum = #form.total_nomenum#,
				<cfelse>
					na_nomenum = 1,
					total_nomenum = null,				
				</CFIF>	
				
					
					
				<CFIF Len(form.total_nodecile)>
					na_nodecile = null,
					total_nodecile = #form.total_nodecile#,
				<cfelse>
					na_nodecile = 1,
					total_nodecile = null,
				</CFIF>
					
				<CFIF Len(form.total_nospecialty)>
					na_nospecialty = null,
					total_nospecialty = #form.total_nospecialty#,
				<cfelse>
					na_nospecialty = 1,
					total_nospecialty = null,
				</CFIF>
									
				<cfif trim(date_completed) EQ "">
					date_completed = null,
				<cfelse>
					date_completed = '#form.date_completed#',
				</cfif>
				completed_by = '#trim(left(form.completed_by, 50))#',
				sent_to = #form.sent_to#,
				sent_filename = '#trim(left(form.sent_filename, 50))#',
				db_notes = '#trim(Left(form.db_notes,500))#'
			WHERE project_code = '#session.project_code#'
			AND rowid = '#session.rowid#'
		</CFQUERY>
		<!--- update the timestamps in the PIW record --->
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="UPDATERECORD">
			UPDATE piw 
			SET piw_update = #createodbcdate(Now())#,
				piw_update_user = #session.userinfo.rowid#
			WHERE project_code = '#session.project_code#'
		</CFQUERY>
		<!--- return to the PIWedit page --->
		<META http-equiv="REFRESH" CONTENT="0; URL=PIW_db.cfm"> 
	</CFCASE>

	<CFDEFAULTCASE>
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="qdb">
			SELECT * FROM database_info	WHERE project_code = '#session.project_code#' AND rowid = '#session.rowid#';
		</CFQUERY>
		<FORM ACTION="PIW_dbEdit.cfm?action=update" METHOD="post">
		<TABLE ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="100%">
		<cfoutput>
          <TR>
			<TD>
			<!--  -->
				<table width="700" border="0" align="center">
				  <tr>
					<td>
						<TABLE ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="350">
						<tr >
							<td CLASS="header"><strong>Initital Database Information</strong></td>
						</tr>
						<tr>
							<td>
								
								<table width="350" border="0">
									<tr>
										<td width="150"><b>Database Received Date:</b></td>
										<td width="200"><cfmodule template="#Application.tagpath#/ctags/calInput.cfm"
													          inputname="received_date"
															  htmlID="receiveddate"
															  FormValue="#DateFormat(qdb.received_date, 'mm/dd/yyyy')#"
															  imgid="receiveddatebtn"></td>
				                    </tr>
									<tr>
										<td><B>Received From:</b></td>
										<td><input type=text name=received_from value="#trim(qdb.received_from)#" size=30 maxlength=50></td>
									</tr>
									<tr>
										<td><B>Received File Name:</b></td>
										<td><input type=text name=received_filename value="#trim(qdb.received_filename)#" size=30 maxlength=50></td>
									</tr>
									<tr>
									<td valign="top"><B>Number of Original <br>Records in Database:</b>
									</td>
									
									<td>
									<input type=text name=total_records value="#qdb.total_records#" size=10 onKeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;">		
									</td>
									</tr>
									<tr>
										<td>
										<B>Original Format:</b>
										</td>
										<td>
										
										
										<CFSET temp_ff = #qdb.original_format#>
										
										<CFQUERY DATASOURCE="#application.projdsn#" NAME="qfile_format">
											SELECT CodeValue as type_id, CodeDesc as type_Description FROM lookup
											Where Codegroup = 'FILEFORMAT'
										</cfquery>
										<select multiple size="5" name="original_format">
										
										<cfloop query="qfile_format">
											<option value="#type_id#" <cfif find("#type_id#", qdb.original_format) NEQ 0>selected</cfif>>#type_description#</option>
										</cfloop>
										</select>
										</td>
										</tr>
									<tr>
									<td valign="top">&nbsp;
									
									</td>
									<td>(Control + Click for multiple file types)
									
									</td>
								 	</tr>
									<tr>
										<td valign="top">
										<B>Other Format:</b>
										</td>
										<td>
										<input type=text name=original_format_other value="#qdb.original_format_other#" size=30 maxlength=80>
										</td>
								 	</tr>
										
								</table>
							
							</td>
						</tr>
						</TABLE>
					</td>
					<td>
						<TABLE ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="350">
						<tr >
							<td CLASS="header"><strong>Final Database Information</strong></td>
						</tr>
						<tr>
							<td>
							<table>
							<tr>
							<td width="130"><B>Sent Date:</b></td>
							<td width="220"><cfmodule template="#Application.tagpath#/ctags/calInput.cfm"
						          inputname="date_completed"
								  htmlID="datecompleted"
								  FormValue="#DateFormat(qdb.date_completed, 'mm/dd/yyyy')#"
								  imgid="datecompletedbtn"></td>
							</tr>
							<tr>
							<td><B>Sent To:</b></td>
							<td>
							<!--- Pull recrutier names from recruiter table to be used in select statement for recruiter field --->
									</cfoutput>
									<CFQUERY DATASOURCE="#application.projdsn#" NAME="srecruiter">
										SELECT ID, recruiter_name FROM recruiter ORDER BY recruiter_name
									</CFQUERY>
									
									
									
									<CFSET temp_REC_id =qdb.sent_to>
									
									<SELECT NAME="sent_to"  class="invis">
													<OPTION VALUE="0">-- Select --</OPTION>
													<CFOUTPUT QUERY="srecruiter">
														<OPTION VALUE="#srecruiter.ID#" <CFIF srecruiter.ID EQ #TRIM(temp_REC_id)#>Selected</CFIF>>#trim(srecruiter.recruiter_name)#
													</CFOUTPUT>
												</SELECT>
										<cfoutput>
										
							</td>
							</tr>
							<tr>
							<td>
							<B>Sent By:</b>
							</td>
							<td>
							<input type="text" name="completed_by" value="#trim(qdb.completed_by)#" size="30" maxlength="50">
							</td>
							</tr>
							<tr>
							<td><B>File Name:</b>
							</td>
							<td><input type="text" name="sent_filename" value="#trim(qdb.sent_filename)#" size="30" maxlength="50">
							</td>
							</tr>
							
							<tr>
							<td><B>Total Records Sent:</b>
							</td>
							<td><input type="text" name="total_available" value="#qdb.total_available#" size="10" onKeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;">
				
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
						<TABLE ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="600">
						<tr>
							<td CLASS="header"><strong>Database Statistics</strong></td>
						</tr>
						<tr>
							<td>
							<table width="675" border="0">
							<tr>
									<td width="220">&nbsp;</td>
									<td width="80" align="left">&nbsp;</td>
									<td>N/A</td>
									<td width="220">&nbsp;</td>
									<td width="80">&nbsp;</td>
									<td>N/A</td>								
							  </tr>
							  <tr>
									<td width="220"><B>Number of Records Without Phone:</b></td>
									<td width="80"><input type="text" name="total_nophone" value="#qdb.total_nophone#" size=10 onKeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;">
									</td>
									<td><input type="checkbox" name="na_nophone" <CFIF #qdb.na_nophone# eq 1>checked</CFIF>></td>
									<td width="220"><B>Number of Records Without ME ##:</b></td>
									<td width="80"><input type="text" name="total_nomenum" value="#qdb.total_nomenum#" size=10 onKeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;">
									</td>
									<td><input type="checkbox" name="na_nomenum" <CFIF #qdb.na_nomenum# eq 1>checked</CFIF>></td>
							  </tr>							
							  <tr>
									<td><B>Number of Records Without Address:</b></td>
									<td><input type="text" name="total_noaddrs" value="#qdb.total_noaddrs#" size=10 onKeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;">
									</td>
									<td><input type="checkbox" name="na_noaddrs" <CFIF #qdb.na_noaddrs# eq 1>checked</CFIF>></td>
									<td><B>Number of Records Without Decile:</b></td>
									<td><input type="text" name="total_nodecile" value="#qdb.total_nodecile#" size=10 onKeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;">
									</td>
									<td><input type="checkbox" name="na_nodecile" <CFIF #qdb.na_nodecile# eq 1>checked</CFIF>></td>
							  </tr>
							  <tr>
									<td><B>Number of Records Without Zip Code:</b></td>
									<td><input type="text" name="total_nozip" value="#qdb.total_nozip#" size=10 onKeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;">
									</td>
									<td><input type="checkbox" name="na_nozip" <CFIF #qdb.na_nozip# eq 1>checked</CFIF>></td>
									<td><B>Number of Records Without Specialty:</b></td>
									<td><input type=text name="total_nospecialty" value="#qdb.total_nospecialty#" size=10 onKeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;">
									</td>
									<td><input type="checkbox" name="na_nospecialty" <CFIF #qdb.na_nospecialty# eq 1>checked</CFIF>></td>
							  </tr>
							  <tr>
									
									<td colspan="6" align="center">
									<B>Phids on File: </b>
									<input type="text" name="total_matching" value="#qdb.total_matching#" size=10 onKeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;"> 
									<B>Total Duplicates: </b>
									<input type="text" name="total_dups" value="#qdb.total_dups#" size=10 onKeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;">
									<B>Total Bad Records: </b>
									<input type="text" name="total_badrecs" value="#qdb.total_badrecs#" size=10 onKeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;">
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
						<TABLE ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="600">
						<tr >
							<td CLASS="header"><strong>Database Notes For #session.project_code#</strong></td>
						</tr>
						<tr>
							<td align="center">
								<TEXTAREA class="invis" NAME="db_notes" COLS="65" ROWS="4"  onkeyup="return _checkLimitContent(this)">#Trim(qdb.db_notes)#</textarea>
							</td>
						</tr>
						</TABLE>
					
					</td>
				  </TR>
				  <tr>  
					<td align="right">
					<INPUT TYPE="submit" NAME="submit" VALUE="  Finish  ">
					</form>
					</td>
					<td align="left">
					<FORM ACTION="PIW_db.cfm" METHOD="post">
					<INPUT TYPE="submit" NAME="cancel" VALUE="  Cancel  ">
					</form>
					</td>
					</tr>
				</table>
			<!--  -->
			</td>
			
		</tr>
		</cfoutput>
		</TABLE>
	</CFDEFAULTCASE>
</CFSWITCH>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
