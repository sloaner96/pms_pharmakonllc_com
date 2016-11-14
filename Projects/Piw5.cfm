<!--- 
	*****************************************************************************************
	Name:		piw5.cfm
	
	Function:	This page is a replica if the paper PIW form, PIW 5 is section 5 
				(Creative Service Info) from the paper PROJECT INTIATION FORM
	History:	TJS071801 - finalized code.
				bj0802901 - revised fscren form layout.
	
	*****************************************************************************************
--->
<CFSWITCH EXPRESSION="#URL.action#">
<!--- 
*************************************************************
	CASE: save
	Saves all data inputted from the above form 
*************************************************************
--->
	<CFCASE VALUE="save">
		<!--- <CFIF IsDefined("form.piwadminedit_note")> --->
		<CFIF IsDefined("session.project_status") AND session.project_status EQ 'active'>
			<!--- Saves/Updates data in the database, note; record is INSERTED into database in PIWadd.cfm so an update may be used --->
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="piwnotecheck">
				SELECT * FROM piw_notes WHERE piw_id = '#session.rowid#' AND note_type = 'PIW5';
			</CFQUERY>
			
			<CFIF piwnotecheck.recordcount EQ 0>
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="INSERTRECORD">
					INSERT piw_notes(piw_id,note_type,note_data) 
					VALUES ('#session.rowid#','PIW5','#Left(form.piwadminedit_note, 500)#')
				</CFQUERY>
			<CFELSE>
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="UPDATERECORD">
					UPDATE piw_notes
						SET piw_id='#session.rowid#', 
							note_type ='PIW5',
							note_data='#Left(form.piwadminedit_note, 500)#',
							entry_date = #createodbcdate(Now())#,
							entry_time = #createodbctime(Now())#,
							entry_userid = #session.userinfo.rowid#
					WHERE piw_id = '#session.rowid#' AND note_type = 'PIW5'
				</CFQUERY>
			</CFIF>
		</CFIF>
		
		<CFPARAM NAME="form.moderator_guide" DEFAULT="0">
		<CFPARAM NAME="form.admin_materials" DEFAULT="0">
		<CFPARAM NAME="form.guidebook" DEFAULT="0">
		<CFPARAM NAME="form.components" DEFAULT="0">
		<CFPARAM NAME="form.guidebook_new" DEFAULT="0">
		<CFPARAM NAME="form.guidebook_revised" DEFAULT="0">
		<CFPARAM NAME="form.guidebook_charts" DEFAULT="0">
		<CFPARAM NAME="form.revise_wording" DEFAULT="0">
		<CFPARAM NAME="form.revise_charts" DEFAULT="0">
		<CFPARAM NAME="form.new_charts" DEFAULT="0">
				
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="UPDATERECORD">
			UPDATE creative_info 
			SET	<CFIF LEN(moderator_guide_date) GT '1'>moderator_guide_date = '#form.moderator_guide_date#', </CFIF>
				<CFIF LEN(admin_materials_date) GT '1'>admin_materials_date = '#form.admin_materials_date#', </CFIF>
				<CFIF LEN(guidebook_date) GT '1'>guidebook_date = '#form.guidebook_date#', </CFIF>
				<CFIF LEN(components_date) GT '1'>components_date = '#form.components_date#', </CFIF>
				guidebook_new = '#form.guidebook_new#', 
				guidebook_revised = '#form.guidebook_revised#', 
				guidebook_charts = '#form.guidebook_charts#', 
				revise_wording = '#form.revise_wording#', 
				revise_charts = '#form.revise_charts#', 
				new_charts = '#form.new_charts#', 
				special_instructions = '#Left(form.special_instructions,500)#'
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
*************************************************************
 CASE: default
*************************************************************
--->
	<CFDEFAULTCASE>
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="form_five">			
			SELECT * FROM creative_info WHERE project_code = '#session.project_code#';
		</cfquery>

		<CFOUTPUT>
		<HTML>
		<HEAD>
		<TITLE>Project Information Workseet - Creative Services Information</TITLE>
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
				if( way == '6')
				{
					form.action = "piw5.cfm?action=save&next_page=6";
				}
				else
				{
					form.action = "piw5.cfm?action=save&next_page=4";
				}
				form.submit();
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
				if (sRtn!="") InputField.value = sRtn;
				}
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
		</SCRIPT>
		</HEAD>
		<BODY BGCOLOR="white">
		<div id="overDiv" style="position:absolute; visibility:hide;z-index:1;"></div>
		<SCRIPT LANGUAGE="JavaScript" SRC="overlib.js"></SCRIPT>
		<FORM NAME="form" ACTION="" METHOD="post">
		<TABLE BGCOLOR="##000080" ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="650">
		<TR>
			<TD CLASS="tdheader">Project Information Worksheet - CREATIVE SERVICES INFORMATION<br>Project Code: #session.project_code#</TD>
		</TR>
		<TR>
			<TD>
			<!--- Table containing input fields --->
			<TABLE ALIGN="center" BORDER="0" CELLPADDING="0" CELLSPACING="8" WIDTH="650">									
			<TR>
				<TD colspan=4 VALIGN="middle"><A HREF="javascript:void(0);" onMouseOver="overlib('Select the dates the following items are to be submitted to Creative Services. If you click in any of the boxes, a calendar will pop up for you to select a date.', CAPTION, 'Initial Submission Date to Creative Services', LEFT, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><B><font color="Black">Initial Submission Date to Creative Services for the following:</font></B>&nbsp;&nbsp;&nbsp;</TD>
			</tr>
			<tr>
				<TD align=right><b>Moderator Discussion Guide Date:</b>&nbsp;</td>
				<td><INPUT TYPE="text" class="text" size=10 NAME="moderator_guide_date" VALUE="#DateFormat(Trim(form_five.moderator_guide_date), 'mm/dd/yyyy')#" onClick="CallCal(this)" onKeypress="if (event.keyCode < 47 || event.keyCode > 57) event.returnValue = false;">
				<img src="images/formcalendar.gif" style="vertical-align:middle">
				</td>
				<td align=right><b>Participant Guidebook Date:</b>&nbsp;</td>
				<td><INPUT TYPE="text" class="text" size=10 NAME="guidebook_date" VALUE="#DateFormat(Trim(form_five.guidebook_date), 'mm/dd/yyyy')#" onClick="CallCal(this)" onKeypress="if (event.keyCode < 47 || event.keyCode > 57) event.returnValue = false;">
				<img src="images/formcalendar.gif" style="vertical-align:middle">
				</td>
			</tr>
			<tr>
				<td align=right><b>Administrative Materials Date:</b>&nbsp;</td>
				<td><INPUT TYPE="text" class="text" size=10 NAME="admin_materials_date" VALUE="#DateFormat(Trim(form_five.admin_materials_date), 'mm/dd/yyyy')#" onClick="CallCal(this)" onKeypress="if (event.keyCode < 47 || event.keyCode > 57) event.returnValue = false;">
				<img src="images/formcalendar.gif" style="vertical-align:middle">
				</td>
				<td align=right><b>Components Date:</b>&nbsp;</td>
				<td><INPUT TYPE="text" class="text" size=10 NAME="components_date" VALUE="#DateFormat(Trim(form_five.components_date), 'mm/dd/yyyy')#" onClick="CallCal(this)" onKeypress="if (event.keyCode < 47 || event.keyCode > 57) event.returnValue = false;">
				<img src="images/formcalendar.gif" style="vertical-align:middle">
				</TD>
			</TR>
			<TR STYLE="vertical-align : bottom">
				<TD align=right VALIGN="Bottom"><A HREF="javascript:void(0);" onMouseOver="overlib('Check the box next to the appropriate guidebook instructions.', CAPTION, 'Guidebook Instructions', LEFT, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><B><font color="Black">Guidebook Instructions:</font></B></TD>
				<TD colspan=3 style="background:##F0F8FF ; border : 1 solid Black;vertical-aling:middle;">
					<INPUT TYPE="checkbox" NAME="guidebook_new" VALUE="1" <CFIF #TRIM(form_five.GUIDEBOOK_NEW)# EQ '1'>Checked</CFIF>>New&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<INPUT TYPE="checkbox" NAME="guidebook_revised" VALUE="1" <CFIF #TRIM(form_five.GUIDEBOOK_REVISED)# EQ '1'>Checked</CFIF>>Revised&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<INPUT TYPE="checkbox" NAME="guidebook_charts" VALUE="1" <CFIF #TRIM(form_five.GUIDEBOOK_CHARTS)# EQ '1'>Checked</CFIF>>Charts From Client
				</TD>
			</TR>
			<TR>
				<TD align=right VALIGN="Bottom"><A HREF="javascript:void(0);" onMouseOver="overlib('Check the box next to the appropriate revisions needed.', CAPTION, 'Revisions on Guidebook', LEFT, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><B><font color="Black">Revisions on Guidebook:</font></B></TD>
				<TD colspan=3 style="background:##F0F8FF ; border : 1 solid Black;vertical-aling:middle;">
					<INPUT TYPE="checkbox" NAME="revise_wording" VALUE="1" <CFIF #TRIM(form_five.REVISE_WORDING)# EQ '1'>Checked</CFIF>>Update Wording&nbsp;&nbsp;&nbsp;&nbsp;
					<INPUT TYPE="checkbox" NAME="revise_charts" VALUE="1" <CFIF #TRIM(form_five.REVISE_CHARTS)# EQ '1'>Checked</CFIF>>Revisions on Charts&nbsp;&nbsp;&nbsp;&nbsp;
					<INPUT TYPE="checkbox" NAME="new_charts" VALUE="1" <CFIF #TRIM(form_five.NEW_CHARTS)# EQ '1'>Checked</CFIF>>Creation of New Charts
				</TD>
			</TR>
			<TR>
				<TD align=right><A HREF="javascript:void(0);" onMouseOver="overlib('Type in any special instructions for Creative Services. This field holds up to 255 characters.', CAPTION, 'Special Instructions for Creative Services', LEFT, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><B><font color="Black">Special Instructions for Creative Services:</font></B><br>(up to 500 characters)</TD>
				<TD colspan=3><TEXTAREA NAME="special_instructions" COLS="60" ROWS="4" onkeyup="return _checkLimitContent(this)">#form_five.special_instructions#</TEXTAREA></TD>
			</TR>
			</CFOUTPUT>
			
			<CFIF IsDefined ("session.project_status") AND (session.project_status EQ "active")>
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="piwnotecheck">
					SELECT * FROM piw_notes WHERE piw_id = '#session.rowid#' AND note_type = 'PIW5'
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
											<td align="left"><input type="button" name="print" value="  Print  " onClick="javascript:void window.open('piw5.cfm?no_menu=1&project_code=#session.project_code#','t','width=785,height=450,menubar=yes,scrollbars=yes,status=yes,toolbar=no,resizable=yes');"></td>
											<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
											<TD><input TYPE="Button" NAME="prev_page" VALUE="Previous Page" onCLick="whichway(4)"></td>
											<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
											<td><input TYPE="Button" NAME="next_page" VALUE="Next Page" onCLick="whichway(6)"></td>
										</tr>
									</Table>
									<cfelse>
									<Table>
										<tr>
											<td><input type="button" name="print" value="  PDF " onClick="javascript:void window.open('piw5_to_pdf.cfm?no_menu=1&project_code=#session.project_code#','t','width=785,height=450,menubar=yes,scrollbars=yes,status=yes,toolbar=no,resizable=yes');"></td>
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
