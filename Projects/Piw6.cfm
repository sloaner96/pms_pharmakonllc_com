<!--- 
	*****************************************************************************************
	Name:		piw6.cfm
	
	Function:	This page is a replica if the paper PIW form, PIW 6 is section 6 
				(Additional Notes) from the paper PROJECT INTIATION FORM
	History:	TJS071801 - finalized code
				bj083001 - revised screen form layout.
	
	*****************************************************************************************
--->
<CFSWITCH EXPRESSION="#URL.action#">
<!--- 
*********************************************************
	CASE: save
	Saves all data inputted from the above form 
*********************************************************
--->
	<CFCASE VALUE="save">
		<!--- <CFIF IsDefined("form.piwadminedit_note")> --->
		<CFIF IsDefined("session.project_status") AND session.project_status EQ 'active'>
			<!--- Saves/Updates data in the database, note; record is INSERTED into database in PIWadd.cfm so an update may be used --->
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="piwnotecheck">
				SELECT * FROM piw_notes	WHERE piw_id = '#session.rowid#' AND note_type = 'PIW6';
			</CFQUERY>
			
			<CFIF piwnotecheck.recordcount EQ 0>
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="INSERTRECORD">
					INSERT piw_notes(piw_id,note_type,note_data) 
					VALUES ('#session.rowid#','PIW6','#Left(form.piwadminedit_note, 500)#')
				</CFQUERY>
			<CFELSE>
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="UPDATERECORD">
					UPDATE piw_notes
					SET piw_id='#session.rowid#', 
						note_type ='PIW6',
						note_data='#Left(form.piwadminedit_note, 500)#',
						entry_date = #createodbcdate(Now())#,
						entry_time = #createodbctime(Now())#,
						entry_userid = #session.userinfo.rowid#
					WHERE piw_id = '#session.rowid#' AND note_type = 'PIW6'
				</CFQUERY>
			</CFIF>
		</CFIF>
		
		<CFPARAM NAME="form.rep_nom" DEFAULT="0">
		<CFPARAM NAME="form.pa_ok" DEFAULT="0">
		<CFPARAM NAME="form.NP_ok" DEFAULT="0">
		<CFPARAM NAME="form.other_ok" DEFAULT="0">
		
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="UPDATERECORD">
			UPDATE recruiting_info
			SET	rep_nom = #form.rep_nom#, 
				PA_OK = #form.PA_OK#,
				NP_OK = #form.NP_OK#,
				other_OK = #form.other_OK#, 
				
				recruit_mailings_info = '#Left(form.recruit_mailings_info,500)#', 
				additional_info = '#Left(form.additional_info,500)#',
				 
				market_drug_info = '#Left(form.market_drug_info,500)#',	
				<!--- direct_mailers_info = '#Left(form.direct_mailers_info,500)#', 
				market_drug_script = '#Left(form.market_drug_script,255)#', --->
				other_description = '#Left(form.other_description,255)#'<!--- ,
				special_reporting = '#Left(form.special_reporting,500)#' --->
			WHERE project_code = '#session.project_code#';
		</CFQUERY>
		
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="UPDATERECORD">
			UPDATE piw 
			SET piw_update = #createodbcdatetime(Now())#,
				piw_update_user = #session.userinfo.rowid#
			WHERE project_code = '#session.project_code#';
		</CFQUERY>
		
		<CFOUTPUT><META HTTP-EQUIV="refresh" CONTENT="0; Url=#URL.next_page#.cfm"></CFOUTPUT>
	</CFCASE>
<!--- 
*********************************************************
	CASE: default
	default functionality
*********************************************************
--->
	<CFDEFAULTCASE>
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="form_six">			
			SELECT * FROM recruiting_info WHERE project_code = '#session.project_code#';
		</CFQUERY>
		
		<CFOUTPUT>
		<HTML>
		<HEAD>
		<TITLE>Project Information Worksheet - Recruiting Information</TITLE>
		<LINK REL="stylesheet" HREF="piw1style.css" TYPE="text/css">
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
			if( way == '7')
			{
				form.action = "piw6.cfm?action=save&next_page=report_piw";
			}
			else
			{
				form.action = "piw6.cfm?action=save&next_page=piw4";
			}
			
			form.submit();
		}
		
		function  _checkLimitContent(_CF_this)
		{
			if (_CF_this.value.length > 500)
			{
				alert("You have now entered 500 Characters. \nEvertything typed following this message will be deleted.");
				return false;
			}
			return true;
		}
		function  _checkLimitContent2(_CF_this)
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
		<TR><TD CLASS="tdheader">Project Initiation Form - RECRUITING INFORMATION<br>Project Code: #session.project_code#</TD></TR>
		<TR>
			<TD>
			<!--- Table containing input fields --->
			<TABLE ALIGN="center" BORDER="0" CELLPADDING="0" CELLSPACING="11" WIDTH="650">								
			<TR>
				<TD ALIGN="center">
				<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="10">
				<TR>
					<TD align=right STYLE="vertical-align : middle;"><A HREF="javascript:void(0);" onMouseOver="overlib('Type any information about initial and subsequent recruitment mailings. This field can hold up to 255 characters.', CAPTION, 'Recruitment Mailings', LEFT, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><B><font color="Black">Will there be an initial recruitment mailing? Any subsequent mailings?</font></B><br>(up to 500 characters)&nbsp;</TD>
					<TD><TEXTAREA STYLE="vertical-align : middle;" NAME="recruit_mailings_info" COLS="60" ROWS="4" onkeyup="return _checkLimitContent(this)">#Trim(form_six.recruit_mailings_info)#</TEXTAREA></TD>
				</TR>
				<TR>
					<TD align=right STYLE="vertical-align : middle;"><A HREF="javascript:void(0);" onMouseOver="overlib('Type in any additional information needed for recruitment. This field can hold up to 255 characters.', CAPTION, 'Additional Information', LEFT, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><B><font color="Black">Recruiting Strategy:</font></B><br>(up to 500 characters)&nbsp;</TD>
					<TD><TEXTAREA STYLE="vertical-align : middle;" NAME="additional_info" COLS="60" ROWS="4" onkeyup="return _checkLimitContent(this)">#Trim(form_six.additional_info)#</TEXTAREA></TD>
				</TR>
				<!--- <TR>
					<TD align=right STYLE="vertical-align : middle;"><A HREF="javascript:void(0);" onMouseOver="overlib('Type in any guidelines for physicians who are generated from direct mailers. This field holds up to 255 characters.', CAPTION, 'Direct Mailer Physicians', LEFT, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><B><font color="Black">What are the guidelines (if any) for physicians who are generated from direct mailers (or claim they were sent a mailer)?</font></B><br>(up to 500 characters)&nbsp;</TD>
					<TD><TEXTAREA STYLE="vertical-align : middle;" NAME="direct_mailers_info" COLS="60" ROWS="4" onkeyup="return _checkLimitContent(this)">#Trim(form_six.direct_mailers_info)#</TEXTAREA></TD>
				</TR> --->
				<TR>
					<TD><B><FONT COLOR="##6699FF">ADDITIONAL NOTES:</FONT></B><BR></TD>
					<td>&nbsp;</td>
				</TR>
				 <TR>
					<TD align=right STYLE="vertical-align : middle;"><A HREF="javascript:void(0);" onMouseOver="overlib('Type in any information about the product that would be helpful to the recruiter. This field can hold up to 255 characters.', CAPTION, 'General Market/Drug Information', LEFT, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><B><font color="Black">General Market/Drug Information for Recruiter:</font></B>&nbsp;<br>(up to 500 characters)&nbsp;</TD>							    
					<TD><TEXTAREA STYLE="vertical-align : middle;" NAME="market_drug_info" COLS="60" ROWS="4" onkeyup="return _checkLimitContent(this)">#Trim(form_six.market_drug_info)#</TEXTAREA></TD>
				</TR>
				<!--- <TR>
					<TD align=right STYLE="vertical-align : middle;"><A HREF="javascript:void(0);" onMouseOver="overlib('Type in any product information for the script. This field can hold up to 255 characters.', CAPTION, 'General Market/Drug Info for Script', LEFT, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><B><font color="Black">General Market/Drug Information for <U>SCRIPT</U> for Recruiter:</font></B><br>(up to 255 characters)&nbsp;</TD>
					<TD><TEXTAREA STYLE="vertical-align : middle;" NAME="market_drug_script" COLS="60" ROWS="4" onkeyup="return _checkLimitContent2(this)">#Trim(form_six.market_drug_script)#</TEXTAREA></TD>
				</TR> --->
				<TR>
					<TD align=right><A HREF="javascript:void(0);" onMouseOver="overlib('Check the box next to those allowed to participate in this program. You may check as many as needed.', CAPTION, 'Select those allowed to participate', LEFT, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><B><font color="Black">Select those allowed to participate in meetings:</font></B>&nbsp;</TD>
					<TD VALIGN="middle" style="background:##F0F8FF ; border : 1 solid Black;vertical-aling:middle;">
						<INPUT NAME="rep_nom" TYPE="checkbox" VALUE="1" <CFIF #TRIM(form_six.REP_NOM)# EQ '1'>Checked</CFIF>>Rep Nominations&nbsp;&nbsp;&nbsp;&nbsp;
						<BR><INPUT NAME="PA_ok" TYPE="checkbox" VALUE="1" <CFIF #TRIM(form_six.PA_OK)# EQ '1'>Checked</CFIF>>Physician Assistants&nbsp;&nbsp;&nbsp;&nbsp;
						<BR><INPUT NAME="NP_ok" TYPE="checkbox" VALUE="1" <CFIF #TRIM(form_six.NP_OK)# EQ '1'>Checked</CFIF>>Nurse Practitioners&nbsp;&nbsp;&nbsp;&nbsp;
						<BR><INPUT NAME="other_ok" TYPE="checkbox" VALUE="1" <CFIF #TRIM(form_six.other_OK)# EQ '1'>Checked</CFIF>>Other
					</TD>
				</TR>
				<TR>
					<TD align=right STYLE="vertical-align : middle;"><A HREF="javascript:void(0);" onMouseOver="overlib('If OTHER participant was selected above, use this field to describe whom else may attend. This field can hold up to 255 characters.', CAPTION, 'Other Participant Description', LEFT, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><B><font color="Black">Other Participant Description</font></B><br>(up to 255 characters)&nbsp;</TD>
					<TD><TEXTAREA STYLE="vertical-align : middle;" NAME="other_description" COLS="60" ROWS="4" onkeyup="return _checkLimitContent2(this)">#Trim(form_six.other_description)#</TEXTAREA></TD>
				</TR>
				</CFOUTPUT>
					<CFIF IsDefined ("session.project_status") AND (session.project_status EQ "active")>
						<CFQUERY DATASOURCE="#application.projdsn#" NAME="piwnotecheck">
							SELECT * FROM piw_notes WHERE piw_id = '#session.rowid#' AND note_type = 'PIW6'
						</CFQUERY>
				<TR>
					<TD align=right STYLE="vertical-align : middle;"><SPAN CLASS="required"><B>EDIT PIW COMMENTS:</B></SPAN>&nbsp;</TD>
					<TD COLSPAN="5"><TEXTAREA STYLE="vertical-align : middle;" NAME="piwadminedit_note" COLS="60" ROWS="4"><CFIF IsDefined ("session.project_status") AND piwnotecheck.recordcount NEQ 0><CFOUTPUT>#piwnotecheck.note_data#</CFOUTPUT></CFIF></TEXTAREA></TD>
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
											<td align="left"><input type="button" name="print" value="  Print  " onClick="javascript:void window.open('piw6.cfm?no_menu=1&project_code=#session.project_code#','t','width=785,height=450,menubar=yes,scrollbars=yes,status=yes,toolbar=no,resizable=yes');"></td>
											<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
											<TD><input TYPE="Button" NAME="prev_page" VALUE="Previous Page" onCLick="whichway(4)"></td>
											<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
											<td><input TYPE="Button" NAME="next_page" VALUE="Done. View Report." onCLick="whichway(7)"></td>
										</tr>
									</Table>
									<cfelse>
									<Table>
										<tr>
											<td><input type="button" name="print" value="  PDF " onClick="javascript:void window.open('piw6_to_pdf.cfm?no_menu=1&project_code=#session.project_code#','t','width=785,height=450,menubar=yes,scrollbars=yes,status=yes,toolbar=no,resizable=yes');"></td>
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
</TD>
</TR>
</TABLE>
</FORM>
</BODY>
</HTML>
</CFDEFAULTCASE>
</CFSWITCH>
