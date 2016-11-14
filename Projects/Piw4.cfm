<!--- 
	*****************************************************************************************
	Name:		piw4.cfm
	
	Function:	This page is a replica if the paper PIW form, PIW 4 is section 4 
				(Reporting Needs) from the paper PROJECT INTIATION FORM
	History:	7/18/01, finalized code	TJS
	
	*****************************************************************************************
--->
<!--- CFSWITCH statement to allow entering and saving of data in same CF form file --->
<CFSWITCH EXPRESSION="#URL.action#">
<!--- 
********************************************************
	CASE: save
	Saves all data input from the above form 
********************************************************
--->
	<CFCASE VALUE="save">
		<!--- <CFIF IsDefined("form.piwadminedit_note")> --->
		<CFIF IsDefined("session.project_status") AND session.project_status EQ 'active'>
			<!--- Saves/Updates data in the database, note; record is INSERTED into database in PIWadd.cfm so an update may be used --->
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="piwnotecheck">
				SELECT * FROM piw_notes WHERE piw_id = '#session.rowid#' AND note_type = 'PIW4';
			</CFQUERY>
			
			<CFIF piwnotecheck.recordcount EQ 0>
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="INSERTRECORD">
					INSERT piw_notes(piw_id,note_type,note_data) 
					VALUES ('#session.rowid#','PIW4','#Left(form.piwadminedit_note, 500)#')
				</CFQUERY>
			<CFELSE>
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="UPDATERECORD">
					UPDATE piw_notes
					SET piw_id='#session.rowid#', 
						note_type ='PIW4',
						note_data='#Left(form.piwadminedit_note, 500)#',
						entry_date = #createodbcdate(Now())#,
						entry_time = #createodbctime(Now())#,
						entry_userid = #session.userinfo.rowid#
					WHERE piw_id = '#session.rowid#' AND note_type = 'PIW4'
				</CFQUERY>
			</CFIF>
		</CFIF>
		
		<CFPARAM NAME="form.summary_weekly" DEFAULT="0">
		<!--- <CFPARAM NAME="form.summary_monthly" DEFAULT="0"> --->
		<CFPARAM NAME="form.summary_other" DEFAULT="0">
		<CFPARAM NAME="form.vm_mgrs" DEFAULT="0">
		<CFPARAM NAME="form.vm_reps" DEFAULT="0">
		<CFPARAM NAME="form.vm_other" DEFAULT="0">
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="UPDATERECORD">
			UPDATE report_info 
			SET	summary_weekly = '#form.summary_weekly#', 
				<!--- summary_monthly =  '#form.summary_monthly#',  --->
				summary_other =  '#form.summary_other#', 
				summary_other_descrip = '#Left(form.summary_other_descrip,255)#', 
				vm_mgrs = '#form.vm_mgrs#', 
				vm_reps = '#form.vm_reps#', 
				vm_other ='#form.vm_other#', 
				vm_other_descrip = '#Left(form.vm_other_descrip,255)#',
				vm_special = '#Left(form.vm_special,255)#', 
				client_toll_free =  '#Left(form.client_toll_free,50)#', 
				special_report = '#Left(form.special_report,255)#'
			WHERE project_code = '#session.project_code#';
		</CFQUERY>
		
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="UPDATERECORD">
			UPDATE piw 
			SET piw_update = #createodbcdate(Now())#,
				piw_update_user = #session.userinfo.rowid#
			WHERE project_code = '#session.project_code#';
		</CFQUERY>

		<CFOUTPUT><META HTTP-EQUIV="refresh" CONTENT="0; Url=piw#URL.next_page#.cfm"></CFOUTPUT>
	</CFCASE>
<!---	
***********************************************************
 Default case 
***********************************************************
--->
<CFDEFAULTCASE>
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="form_four">			
			SELECT * FROM report_info WHERE project_code = '#session.project_code#';
		</CFQUERY>

		<CFOUTPUT>
		<HTML>
		<HEAD>
		<TITLE>Project Initiation Form - Reporting Needs</TITLE>
		<LINK REL="stylesheet" HREF="piw1style.css" TYPE="text/css">
		<!--- <SCRIPT SRC="confirm.js"></SCRIPT>
		<SCRIPT SRC="textareacheck.js"></SCRIPT> --->
		<SCRIPT>
			// Determines which page to load based on what button was selected at bottom of page
			function whichway(way)
			{
				<CFIF IsDefined ("session.project_status") AND (session.project_status EQ "active")>	
					if (!form.piwadminedit_note.value)
					{
					alert("Please justify the editing of this form.");
					return false;
					}
				</CFIF>
				if( way == '6')
				{
					form.action = "piw4.cfm?action=save&next_page=6";
				}
				else
				{
					form.action = "piw4.cfm?action=save&next_page=2";
				}
				form.submit();
			}
			
			function  _checkLimitContent(_CF_this)
			{
				if (_CF_this.value.length > 255)
				{
					alert("You have now entered 255 Characters. \nEvertything typed following this message will be deleted.");
					return false;
				}
				return true;
			}
		</SCRIPT>
		</HEAD>
		<BODY BGCOLOR="white">
		<div id="overDiv" style="position:absolute; visibility:hide;z-index:1;"></div>
		<SCRIPT LANGUAGE="JavaScript" SRC="overlib.js"></SCRIPT>
		<FORM NAME="form" ACTION="" METHOD="post">
		<TABLE BGCOLOR="##000080" ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="650">
		<TR><TD CLASS="tdheader">Project Information Worksheet - REPORTING NEEDS<br>Project Code: #session.project_code#</TD>
		</TR>
		<TR>
			<TD>
			<!--- Table containing input fields --->
			<TABLE ALIGN="center" BORDER="0" CELLPADDING="0" CELLSPACING="8" WIDTH="650">									
			<TR>
				<TD align=right><A HREF="javascript:void(0);" onMouseOver="overlib('Check the box next to the appropriate written report schedule.', CAPTION, 'Written Summary Reports', LEFT, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><B><font color="Black">Written Summary Reports:</font></B></TD>
				<TD colspan=2 style="background:##F0F8FF ; border : 1 solid Black;">
					<INPUT TYPE="checkbox" NAME="summary_weekly" VALUE="1" <CFIF #TRIM(form_four.SUMMARY_WEEKLY)# EQ '1'>Checked</CFIF>>Weekly<!--- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<INPUT TYPE="checkbox" NAME="summary_monthly" VALUE="1" <CFIF #TRIM(form_four.SUMMARY_MONTHLY)# EQ '1'>Checked</CFIF>>Monthly --->&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<INPUT TYPE="checkbox" NAME="summary_other" VALUE="1" <CFIF #TRIM(form_four.SUMMARY_OTHER)# EQ '1'>Checked</CFIF>>Other
				</TD>
			</TR>
			<TR>
				<TD align=right><A HREF="javascript:void(0);" onMouseOver="overlib('If OTHER Reporting was selected above, use this field to describe what other schedule of reporting is needed. This field can hold up to 255 characters.', CAPTION, 'Notes for Other Written Reporting', LEFT, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><B><font color="Black">Notes for Other Written Reporting:</font></B><br>(up to 255 characters)</TD>
				<TD colspan=2>
					<TEXTAREA NAME="summary_other_descrip" COLS="75" ROWS="4" onkeyup="return _checkLimitContent(this)">#form_four.summary_other_descrip#</TEXTAREA>								
				</TD>
			</TR>
			<TR style="vertical-aling:middle;">
				<TD align=right><A HREF="javascript:void(0);" onMouseOver="overlib('Check the box next to the appropriate people to receive voice mail reporting', CAPTION, 'Voice Mail Reporting', LEFT, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><B><font color="Black">Voice Mail Reporting:</font></B></TD>
				<TD colspan=2 style="background:##F0F8FF ; border : 1 solid Black;vertical-aling:middle;">
					<INPUT TYPE="checkbox" NAME="vm_mgrs" VALUE="1" <CFIF #TRIM(form_four.VM_MGRS)# EQ '1'>Checked</CFIF>>Business Mgrs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<INPUT TYPE="checkbox" NAME="vm_reps" VALUE="1" <CFIF #TRIM(form_four.VM_REPS)# EQ '1'>Checked</CFIF>>Sales Reps&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<INPUT TYPE="checkbox" NAME="vm_other" VALUE="1" <CFIF #TRIM(form_four.VM_OTHER)# EQ '1'>Checked</CFIF>>Other
				</TD>
			</TR>
			<TR>
				<td align=right><A HREF="javascript:void(0);" onMouseOver="overlib('If OTHER Voice Mail Reporting was selected above, use this field to describe who else needs voice mail reporting. This field can hold up to 255 characters.', CAPTION, 'Notes for Other Voice Mail Reporting', LEFT, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><B><font color="Black">Notes for Other Voice Mail Reporting:</font></B><br>(up to 255 characters)</TD>
				<TD colspan=2>
					<TEXTAREA NAME="vm_other_descrip" COLS="75" ROWS="4" onkeyup="return _checkLimitContent(this)">#form_four.vm_other_descrip#</TEXTAREA>
				</TD>
			</TR>
			<TR>
				<td align=right><A HREF="javascript:void(0);" onMouseOver="overlib('Describe any additional Voice Mail Requirements. This field can hold up to 255 characters.', CAPTION, 'Special Voice Mail Requirements', LEFT, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><B><font color="Black">Any Special Voice Mail Requirements:</font></B><br>(up to 255 characters)</TD>
				<TD colspan=2>
					<TEXTAREA NAME="vm_special" COLS="75" ROWS="4" onkeyup="return _checkLimitContent(this)">#form_four.vm_special#</TEXTAREA>
				</TD>
			</TR>
			<TR>
				<TD align=right><A HREF="javascript:void(0);" onMouseOver="overlib('Type in the phone number that moderators are to use to conduct voice mail reporting. Use only numbers. /nExample: (123) 456-7890 /nEnter: 1234567890', CAPTION, 'Client Toll Free Number', LEFT, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><B><font color="Black">Client Toll-Free Number for Moderators to Conduct Voice Mail To:</font></B></TD>
				<TD colspan=2>
					<INPUT CLASS="text" NAME="client_toll_free" VALUE="#form_four.client_toll_free#"  MAXLENGTH="11" TYPE="text" SIZE="15" onKeypress="if ((event.keyCode < 48 || event.keyCode > 57) && (event.keyCode!=46)) event.returnValue = false;">
				</TD>
			</TR>
			<TR>
				<TD align=right><A HREF="javascript:void(0);" onMouseOver="overlib('Type in any specail reporting that was not indicated on this form. This form can hold up to 255 characters.', CAPTION, 'Special Reporting', LEFT, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><B><font color="Black">Any Special Reporting, Please Explain:</font></B><br>(up to 255 characters)</TD>
				<TD colspan=2>
					<TEXTAREA NAME="special_report" COLS="75" ROWS="4" onkeyup="return _checkLimitContent(this)">#form_four.special_report#</TEXTAREA>
				</TD>
			</TR>
			<TR><TD COLSPAN="3">&nbsp;</TD></TR>
		</CFOUTPUT>
		<CFIF IsDefined ("session.project_status") AND (session.project_status EQ "active")>
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="piwnotecheck">
				SELECT * FROM piw_notes WHERE piw_id = '#session.rowid#' AND note_type = 'PIW4'
			</CFQUERY>
			<TR>
				<TD align=right STYLE="vertical-align : middle;"><SPAN CLASS="required"><B>EDIT PIW COMMENTS:</B></SPAN>&nbsp;</TD>
				<TD COLSPAN="5"><TEXTAREA STYLE="vertical-align : middle;" NAME="piwadminedit_note" COLS="60" ROWS="4"><CFIF IsDefined ("session.project_status") AND piwnotecheck.recordcount NEQ 0><CFOUTPUT>#TRIM(piwnotecheck.note_data)#</CFOUTPUT></CFIF></TEXTAREA></TD>
					<CFOUTPUT><INPUT TYPE="hidden" VAlue="session.rowid" NAME="rowid"></CFOUTPUT>
			</TR>
		</CFIF>
			<TR>
					<TD colspan=6 width="100%">
						
					
					<cfoutput>
						<table align="center">
							<tr>
								<td>	
									<br>
									<cfif NOT isdefined("URL.no_menu")>
									<Table border=0 width="100%">
										<tr>
											<td align="left"><input type="button" name="print" value="  Print  " onClick="javascript:void window.open('piw4.cfm?no_menu=1&project_code=#session.project_code#','t','width=785,height=450,menubar=yes,scrollbars=yes,status=yes,toolbar=no,resizable=yes');"></td>
											<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
											<TD><input TYPE="Button" NAME="prev_page" VALUE="Previous Page" onCLick="whichway(2)"></td>
											<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
											<td><input TYPE="Button" NAME="next_page" VALUE="Next Page" onCLick="whichway(6)"></td>
										</tr>
									</Table>
									<cfelse>
									<Table>
										<tr>
											<td><input type="button" name="print" value="  PDF " onClick="javascript:void window.open('piw4_to_pdf.cfm?no_menu=1&project_code=#session.project_code#','t','width=785,height=450,menubar=yes,scrollbars=yes,status=yes,toolbar=no,resizable=yes');"></td>
											<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
											<td><input type="button" name=print value="  Print  " onClick="javascript:window.print()"></td>
										</tr>
									</Table>
									</cfif>
								
								</TD>
							</TR>
						</TABLE>
					</cfoutput> 
					
					
					
					</TD>
				</TR>
			</TABLE>
		</TD>
	</TR>
	</TABLE>
	</FORM>
	</BODY>
	</HTML>
	</CFDEFAULTCASE>
</CFSWITCH>

