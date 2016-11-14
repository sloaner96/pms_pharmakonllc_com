<!--- 
	*****************************************************************************************
	Name:		
	Function:	
	History:	
	
	*****************************************************************************************
--->
<HTML>
<HEAD>
<TITLE>Project Information Worksheet - Add Database Statistics</TITLE>
<LINK REL=stylesheet HREF="piw1style.css" TYPE="text/css">
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
	
	function  _checkLimitContent(_CF_this)
	{
		if (_CF_this.value.length > 500)
		{
			alert("Please limit your notes to 500 characters. \nEvertything typed following this message will be deleted.");
    		return false;
  		}

    	return true;
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
					original_format, original_format_other, total_records, total_nophone, na_nophone,
					total_noaddrs, na_noaddrs, total_nozip, na_nozip, total_nomenum, na_nomenum, total_nodecile, na_nodecile,
					total_nospecialty, na_nospecialty, total_available, total_matching, total_dups, total_badrecs, date_completed, 
					completed_by, sent_to, sent_filename, db_notes
					) 
					VALUES (
					'#session.project_code#',		
				<cfif trim(received_date) EQ "">
					null,
				<cfelse>
					'#form.received_date#',
				</cfif>
				'#trim(left(form.received_from, 50))#',
				'#trim(left(form.received_filename, 250))#',

				'#form.original_format#',
				<cfif Original_format neq 5>
				null,
				<cfelse>
				'#trim(left(form.original_format_other, 80))#',
				</cfif>
				
				'#form.total_records#',
				<CFIF Len(form.total_nophone)>
					#form.total_nophone#,
					null,
					<cfelse>
					null,
					1,
				</CFIF>
				
				<CFIF Len(form.total_noaddrs)>
					#form.total_noaddrs#,
					null,
					<cfelse>
					null,
					1,
				</CFIF>
				
				<CFIF Len(form.total_nozip)>
					#form.total_nozip#,
					null,
					<cfelse>
					null,
					1,
				</CFIF>
				
				<CFIF Len(form.total_nomenum)>
					#form.total_nomenum#,
					null,
					<cfelse>
					null,
					1,
				</CFIF>
								
				<CFIF Len(form.total_nodecile)>
					#form.total_nodecile#,
					null,
					<cfelse>
					null,
					1,
				</CFIF>
											
				<CFIF Len(form.total_nospecialty)>
					#form.total_nospecialty#,
					null,
					<cfelse>
					null,
					1,
				</CFIF>
				
				<CFIF Len(form.total_available)>
				#form.total_available#,
				<cfelse>
				null,
				</CFIF>
				
				<CFIF Len(form.total_matching)>
				#form.total_matching#,
				<cfelse>
				null,
				</CFIF>
				
				<CFIF Len(form.total_dups)>
				#form.total_dups#,
				<cfelse>
				null,
				</CFIF>
				
				<CFIF Len(form.total_badrecs)>
				#form.total_badrecs#,
				<cfelse>
				null,
				</CFIF>
							
				
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
		<FORM ACTION="PIW_dbAdd.cfm?action=insert" METHOD="post">
		<TABLE BGCOLOR="##000080" ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="700">
		<TR><TD CLASS="tdheader">PIW DATABASE EDIT - Project Code: <cfoutput>#session.project_code#</cfoutput>
		<TR>
			<TD>
			<!--  -->
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
										<td width="200"><input type=text name=received_date onClick="CallCal(this)" SIZE="10" onKeypress="if (event.keyCode < 47 || event.keyCode > 57) event.returnValue = false;">
													<img src="images/formcalendar.gif" style="vertical-align:middle"></td>
									</tr>
									<tr>
										<td><B>Received From:</b></td>
										<td><input type=text name=received_from size=30 maxlength=50></td>
									</tr>
									<tr>
										<td><B>Received File Name:</b></td>
										<td><input type=text name=received_filename size=30 maxlength=50></td>
									</tr>
									<tr>
									<td valign="top"><B>Number of Original <br>Records in Database:</b>
									</td>
									<td>
									<input type=text name=total_records size=10 onKeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;">		
									</td>
									</tr>
									<tr>
										<td>
										<B>Original Format: </b>
										</td>
										<td>
										
										
										
										<cfoutput>
										<CFQUERY DATASOURCE="#application.projdsn#" NAME="qfile_format">
											SELECT * FROM file_format_type
										</cfquery>
										<select multiple size="5" name="original_format">
										
										<cfloop query="qfile_format">
											<option value="#type_id#">#type_description#</option>
										</cfloop>
										</select>
										</cfoutput>
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
										<B>Other Format:</b> <br>(Use this field if OTHER is selected as an option.)
										</td>
										<td>
										<input type=text name=original_format_other size=30 maxlength=80>
										</td>
								 	</tr>
										
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
							<td width="130"><B>Sent Date:</b></td>
							<td width="220"><input type=text name=date_completed onClick="CallCal(this)"  SIZE="10"  onKeypress="if (event.keyCode < 47 || event.keyCode > 57) event.returnValue = false;" maxlength=10>
				<img src="images/formcalendar.gif" style="vertical-align:middle"></td>
							</tr>
							<tr>
							<td><B>Sent To:</b></td>
							<td>
							<!--- Pull recrutier names from recruiter table to be used in select statement for recruiter field --->
								
									<CFQUERY DATASOURCE="#application.projdsn#" NAME="srecruiter">
										SELECT ID, recruiter_name FROM recruiter ORDER BY recruiter_name
									</CFQUERY>
									
									
									<SELECT NAME="sent_to"  class="invis">
													<OPTION VALUE="0">-- Select --</OPTION>
													<CFOUTPUT QUERY="srecruiter">
														<OPTION VALUE="#srecruiter.ID#">#trim(srecruiter.recruiter_name)#
													</CFOUTPUT>
												</SELECT>
						
										
							</td>
							</tr>
							<tr>
							<td>
							<B>Sent By:</b>
							</td>
							<td>
							<input type=text name=completed_by size=30 maxlength=50>
							</td>
							</tr>
							<tr>
							<td><B>File Name:</b>
							</td>
							<td><input type=text name=sent_filename size=30 maxlength=50>
							</td>
							</tr>
							
							<tr>
							<td><B>Total Records Sent:</b>
							</td>
							<td><input type=text name=total_available size=10 onKeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;">
				
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
									<td width="80"><input type=text name=total_nophone size=10 onKeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;">
									</td>
									<td><input type="checkbox" name="na_nophone"></td>
									<td width="220"><B>Number of Records Without ME ##:</b></td>
									<td width="80"><input type=text name=total_nomenum size=10 onKeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;">
									</td>
									<td><input type="checkbox" name="na_nomenum"></td>
							  </tr>							
							  <tr>
									<td><B>Number of Records Without Address:</b></td>
									<td><input type=text name=total_noaddrs size=10 onKeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;">
									</td>
									<td><input type="checkbox" name="na_noaddrs"></td>
									<td><B>Number of Records Without Decile:</b></td>
									<td><input type=text name=total_nodecile size=10 onKeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;">
									</td>
									<td><input type="checkbox" name="na_nodecile"></td>
							  </tr>
							  <tr>
									<td><B>Number of Records Without Zip Code:</b></td>
									<td><input type=text name=total_nozip size=10 onKeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;">
									</td>
									<td><input type="checkbox" name="na_nozip"></td>
									<td><B>Number of Records Without Specialty:</b></td>
									<td><input type=text name=total_nospecialty size=10 onKeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;">
									</td>
									<td><input type="checkbox" name="na_nospecialty"></td>
							  </tr>
							  <tr>
									
									<td colspan="6" align="center">
									<B>Phids on File: </b>
									<input type="text" name="total_matching"size=10 onKeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;"> 
									<B>Total Duplicates: </b>
									<input type="text" name="total_dups" size=10 onKeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;">
									<B>Total Bad Records: </b>
									<input type="text" name="total_badrecs" size=10 onKeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;">
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
							<td CLASS="tdheader">Database Notes For <cfoutput>#session.project_code#</cfoutput></td>
						</tr>
						<tr>
							<td align="center">
								<TEXTAREA class="invis" NAME="db_notes" COLS="65" ROWS="4" onkeyup="return _checkLimitContent(this)"></textarea>
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
		</TABLE>
	</CFDEFAULTCASE>
</CFSWITCH>
</BODY>
</HTML>