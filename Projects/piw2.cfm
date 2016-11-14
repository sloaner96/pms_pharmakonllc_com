<!---
	*****************************************************************************************
	Name:		piw2.cfm

	Function:	This page is a replica if the paper PIW form, PIW 2 is section 2
				(project/program info) from the paper PROJECT INTIATION FORM
	History:	7/18/01, finalized code	TJS

	*****************************************************************************************
--->
<!--- CFSWITCH statement to allow entering and saving of data in same CF form file --->
<CFSWITCH EXPRESSION="#URL.action#">
	<!--- Saves all data inputted from the above form --->
	<CFCASE VALUE="save">
		<!--- <CFIF IsDefined("form.piwadminedit_note")> --->
		<CFIF IsDefined("session.project_status") AND session.project_status EQ 'active'>
			<!--- Saves/Updates data in the database, note; record is INSERTED into database in PIWadd.cfm so an update may be used --->
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="piwnotecheck">
				SELECT * FROM piw_notes WHERE piw_id = '#session.rowid#' AND note_type = 'PIW2';
			</CFQUERY>

			<CFIF piwnotecheck.recordcount EQ 0>
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="INSERTRECORD">
					INSERT piw_notes(piw_id,note_type,note_data)
					VALUES ('#session.rowid#','PIW2','#Left(form.piwadminedit_note, 500)#')
				</CFQUERY>
			<CFELSE>
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="UPDATERECORD">
					UPDATE piw_notes
					SET piw_id='#session.rowid#',
						note_type ='PIW2',
						note_data='#Left(form.piwadminedit_note, 500)#',
						entry_date = #createodbcdate(Now())#,
						entry_time = #createodbctime(Now())#,
						entry_userid = #session.userinfo.rowid#
					WHERE piw_id = '#session.rowid#' AND note_type = 'PIW2'
				</CFQUERY>
			</CFIF>
		</CFIF>

		<cfparam name="form.promodirectmail" default=0><!--- type="numeric" --->
		<CFPARAM NAME="form.promorepnom" DEFAULT="0">
		<CFPARAM NAME="form.promofax" DEFAULT="0">
		<CFPARAM NAME="form.promoother" DEFAULT="0">
		<CFPARAM NAME="form.letter_confirmation" DEFAULT="0">
		<CFPARAM NAME="form.letter_thankyou" DEFAULT="0">
		<CFPARAM NAME="form.PI" DEFAULT="0">
		<CFPARAM NAME="form.letter_faxinfosheet" DEFAULT="0">
		<CFPARAM NAME="form.letter_other" DEFAULT="0">
		<CFPARAM NAME="form.include_survey" DEFAULT="0">
		<CFPARAM NAME="form.re_recruit" DEFAULT="0">

		<CFset iAttendeeCompType="0">

		<cfif form.attendee_comp_type EQ 1><cfset iAttendeeCompType = "1"></cfif>
		<cfif form.attendee_comp_type EQ 2><cfset iAttendeeCompType = "2"></cfif>
		<cfif form.attendee_comp_type EQ 3><cfset iAttendeeCompType = "0"></cfif>
		<cfif form.attendee_comp_type EQ 4><cfset iAttendeeCompType = "1"></cfif>
		<cfif form.attendee_comp_type EQ 5><cfset iAttendeeCompType = "1"></cfif>

		<!--- Updates the fields for the associated project in the database --->
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="UPDATERECORD">
		UPDATE piw
		SET	<!--- meeting_type = '#form.meeting_type#', --->
			<!--- meeting_other_notes = '#Left(form.meeting_other_notes,200)#', --->
			target_audience = '#Left(form.target_audience,500)#',
			prog_participants = '#RTrim(form.prog_participants)#',
			num_meetings = '#RTrim(form.num_meetings)#',
			participant_target = '#RTrim(form.participant_target)#',
			participant_recruit = '#RTrim(form.participant_recruit)#',
			prog_length_hr = '#RTrim(form.prog_length_hr)#',
			prog_length_min = '#RTrim(form.prog_length_min)#',
			special_notes  = '#Left(form.special_notes,500)#',
			cme_accredited = '#RTrim(form.cme_accredited)#',
			cme_org = '#Left(form.cme_org,30)#',
			Promo_direct_mail = '#form.promodirectmail#',
			promo_rep_nom = '#form.promorepnom#',
			promo_fax = #form.promofax#,
			promo_other = #form.promoother#,
			promo_other_descrip = '#Left(form.promo_other_descrip,80)#',
			re_recruit = '#form.re_recruit#',
			guidebook_include = '#Left(form.guidebook_include, 500)#',
			letter_faxinfosheet = '#form.letter_faxinfosheet#',
			PI = '#form.PI#',
			letter_thankyou = '#form.letter_thankyou#',
			letter_confirmation = '#form.letter_confirmation#',
			letter_other = '#form.letter_other#',
			letter_other_description = '#Left(form.letter_other_description,80)#',
			<!--- If a date not selected, leaves as null in the database --->
			<CFIF LEN(guidebook_to_recruiter) GT '1'>guidebook_to_recruiter = '#form.guidebook_to_recruiter#', </CFIF>
			<CFIF LEN(promodirectmaildate) GT '1'>promo_direct_mail_date = '#form.promodirectmaildate#', </CFIF>
			<CFIF LEN(promorepnomdate) GT '1'>promo_rep_nom_date = '#form.promorepnomdate#', </CFIF>
			<CFIF LEN(promofaxdate) GT '1'>promo_fax_date = '#form.promofaxdate#', </CFIF>
			<CFIF LEN(promootherdate) GT '1'>promo_other_date = '#form.promootherdate#', </CFIF>
			include_survey = '#form.include_survey#',
			attendee_comp = #Left(form.attendee_comp,8)#,
			attendee_comp_type = #iAttendeeCompType#,
			attendee_comp_type_id = '#form.attendee_comp_type#',
			survey_comp = #Left(form.survey_comp,8)#,
			survey_comp_type = #form.survey_comp_type#,
			speaker_notes = '#Left(form.speaker_notes,200)#',
			piw_update = #createodbcdate(Now())#,
			piw_update_user = #session.userinfo.rowid#
			WHERE project_code = '#session.project_code#';
		</CFQUERY>
		<CFIF "session.project_status" EQ "active">
		<!--- Saves/Updates data in the database, note; record is INSERTED into database in PIWadd.cfm so an update may be used --->
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="UPDATERECORD">
				INSERT piw_notes(piw_id,note_type,note_data)
				VALUES ('#form.rowid#','PIW2 General Info 2','#Left(form.piwadminedit_note, 500)#')
			</CFQUERY>
		</CFIF>
		<CFOUTPUT><META HTTP-EQUIV="refresh" CONTENT="0; Url=piw#URL.next_page#.cfm"></CFOUTPUT>
	</CFCASE>
<!---
**********************************************************************
 default case function
**********************************************************************
--->
<CFDEFAULTCASE>
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="form_two">
		SELECT * FROM piw WHERE project_code = '#session.project_code#';
	</CFQUERY>

	<CFOUTPUT QUERY="form_two">
	<HTML>
	<HEAD>
	<TITLE>Project Initiation Form - PROJECT/PROGRAM INFORMATION</TITLE>
	<LINK REL=stylesheet HREF="piw1style.css" TYPE="text/css">
	<SCRIPT SRC="PIW2checker.js"></SCRIPT>
	<SCRIPT>
		// Pulls up calendar for user to select date
		function CallCal(InputField)
		{
			var datefield = InputField.value;
			if (datefield.length < 10)
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
		if( way == '4')
			{
			form.action = "piw2.cfm?action=save&next_page=4";
			if(validate(form))
			{
			form.submit();
			}
		}
		else
		{
			form.action = "piw2.cfm?action=save&next_page=1";
			if(validate(form))
			{
			form.submit();
			}
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
	function  _checkLimitContent2(_CF_this)
	{
		if (_CF_this.value.length > 80)
		{
			alert("You have now entered 80 Characters. \nEvertything typed following this message will be deleted.");
			return false;
		}

		return true;
	}
	function  _checkLimitContent3(_CF_this)
	{
		if (_CF_this.value.length > 200)
		{
			alert("You have now entered 200 Characters. \nEvertything typed following this message will be deleted.");
			return false;
		}

		return true;
	}
	</SCRIPT>
	</cfoutput>
	<BODY>
	<div id="overDiv" style="position:absolute; visibility:hide;z-index:1;"></div>
	<SCRIPT LANGUAGE="JavaScript" SRC="overlib.js"></SCRIPT>
	<FORM NAME="form" ACTION="" METHOD="post">
	<cfoutput>
	<TABLE BGCOLOR="000080" ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="720">
	<TR><TD CLASS="tdheader" COLSPAN="2">Project Information Worksheet -PROJECT/PROGRAM<br>Project Code: #session.project_code#</TD></TR>
	</cfoutput>
	<TR>
		<TD COLSPAN="2">
			<!--- Table containing input fields --->
			<TABLE ALIGN="center" BORDER="0" CELLPADDING="0" CELLSPACING="5" WIDTH="700">
			<TR>
				<td align=right><B>Meeting Type:</B></td>
				<td colspan=5>
					<CFQUERY DATASOURCE="#application.projdsn#" NAME="meeting_type_code">
						SELECT c.meeting_type, m.meeting_type_value, meeting_type_description
						FROM client_proj c, meeting_type m
						WHERE c.client_proj = '#session.project_code#'
							AND m.meeting_type = c.meeting_type
						ORDER BY m.meeting_type_value
					</cfquery>
					<cfoutput>
						#meeting_type_code.meeting_type_value# - #meeting_type_code.meeting_type_description#
					</cfoutput>
				 </TD>
			</TR>
			<CFOUTPUT>
			<TR>
	    		<TD align=right><B><A HREF="javascript:void(0);" onMouseOver="overlib('Please type in the number of participants that are expected per meeting.', CAPTION, 'Participants Per Program', LEFT, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><font color="Black">Participants Per Program:</font></B>&nbsp;</td>
				<td><INPUT NAME="prog_participants" CLASS="text" VALUE="#form_two.prog_participants#" TYPE="text" maxlength="4" SIZE="4"></td>
				<td align=right><B><A HREF="javascript:void(0);" onMouseOver="overlib('Type in the number of meetings to be scheduled per project.', CAPTION, 'Meetings Per Project', LEFT, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><font color="Black">Meetings per project:</font></B>&nbsp;</td>
				<td><INPUT NAME="num_meetings" CLASS="text" VALUE="#form_two.num_meetings#" TYPE="text" maxlength="4" SIZE="4"></td>
				<td colspan=2>&nbsp;</td>
			</tr>
			<tr>
				<td align=right><B><A HREF="javascript:void(0);" onMouseOver="overlib('Type in the target number of participants per meeting', CAPTION, 'Meeting Participant Target', LEFT, ABOVE, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><font color="Black">Meeting Participant Target:</font></B>&nbsp;</td>
				<td><INPUT NAME="participant_target" CLASS="text" VALUE="#form_two.participant_target#" TYPE="text" maxlength="4" SIZE="4"></td>
				<td align=right><A HREF="javascript:void(0);" onMouseOver="overlib('Type in the number of participants to be recruited to reach the meeting participant target.', CAPTION, 'Meeting Participant Recruit', LEFT, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><B><font color="Black">Meeting Participant Recruit:</font></B>&nbsp;</td>
				<td><INPUT NAME="participant_recruit" CLASS="text" VALUE="#form_two.participant_recruit#" TYPE="text" maxlength="4" SIZE="4"></TD>
				<td colspan=2>&nbsp;</td>
			</TR>
			<tr>
				<td align=right><A HREF="javascript:void(0);" onMouseOver="overlib('Please select length of the meeting by selecting hours and/or minutes from the drop down boxes.', CAPTION, 'Length of Program', LEFT, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><B><font color="Black">Length of Program:</font></B>&nbsp;</td>
				<td colspan=5 style="vertical-align:middle;">
					<SELECT NAME="prog_length_hr">
						<OPTION VALUE=""></OPTION>
						<OPTION VALUE="01" <CFIF form_two.prog_length_hr EQ 01>Selected</CFIF>>01</OPTION>
						<OPTION VALUE="02" <CFIF form_two.prog_length_hr EQ 02>Selected</CFIF>>02</OPTION>
						<OPTION VALUE="03" <CFIF form_two.prog_length_hr EQ 03>Selected</CFIF>>03</OPTION>
						<OPTION VALUE="04" <CFIF form_two.prog_length_hr EQ 04>Selected</CFIF>>04</OPTION>
						<OPTION VALUE="05" <CFIF form_two.prog_length_hr EQ 05>Selected</CFIF>>05</OPTION>
						<OPTION VALUE="06" <CFIF form_two.prog_length_hr EQ 06>Selected</CFIF>>06</OPTION>
						<OPTION VALUE="07" <CFIF form_two.prog_length_hr EQ 07>Selected</CFIF>>07</OPTION>
						<OPTION VALUE="08" <CFIF form_two.prog_length_hr EQ 08>Selected</CFIF>>08</OPTION>
						<OPTION VALUE="09" <CFIF form_two.prog_length_hr EQ 09>Selected</CFIF>>09</OPTION>
						<OPTION VALUE="10" <CFIF form_two.prog_length_hr EQ 10>Selected</CFIF>>10</OPTION>
						<OPTION VALUE="11" <CFIF form_two.prog_length_hr EQ 11>Selected</CFIF>>11</OPTION>
						<OPTION VALUE="12" <CFIF form_two.prog_length_hr EQ 12>Selected</CFIF>>12</OPTION>
					</SELECT> hours
					<SELECT NAME="prog_length_min">
						<OPTION VALUE=""></OPTION>
						<OPTION VALUE="00"<CFIF form_two.prog_length_min EQ 00>Selected</CFIF>>00</OPTION>
						<OPTION VALUE="15" <CFIF form_two.prog_length_min EQ 15>Selected</CFIF>>15</OPTION>
						<OPTION VALUE="30" <CFIF form_two.prog_length_min EQ 30>Selected</CFIF>>30</OPTION>
						<OPTION VALUE="45" <CFIF form_two.prog_length_min EQ 45>Selected</CFIF>>45</OPTION>
						</SELECT> minutes
				</TD>
			</TR>
			<TR>
				<TD align=right><A HREF="javascript:void(0);" onMouseOver="overlib('Type in any special notes concerning program participants or program time. This field can hold up to 500 characters.', CAPTION, 'Any Special Notes', LEFT, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><B><font color="Black">Any Special Notes:</font></B>&nbsp;<br>(up to 500 characters)</td>
				<td colspan=5><TEXTAREA STYLE="vertical-align : middle;" NAME="special_notes" COLS="75" ROWS="4" onkeyup="return _checkLimitContent(this)">#form_two.special_notes#</TEXTAREA></TD>
			</TR>
			<TR>
				<TD align=right><SPAN CLASS="required"><A HREF="javascript:void(0);" onMouseOver="overlib('Please type in the specialties or jobs of the attendees wanted for the target audience. This field is required. This field can hold up to 500 characters.', CAPTION, 'Target Audience', LEFT, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><B><font color="Red">Target Audience:</font></SPAN></B>&nbsp;<br>(up to 500 characters)</td>
				<td colspan=5><TEXTAREA NAME="target_audience" COLS="75" ROWS="4" onkeyup="return _checkLimitContent(this)">#Trim(form_two.target_audience)#</TEXTAREA></TD>
			</TR>
			<TR>
				<TD align=right><A HREF="javascript:void(0);" onMouseOver="overlib('If this program is CME Accredited, select the radio button labeled YES. If the program is not CME Accredited, select the radio button labeled NO.', CAPTION, 'CME Accredited', LEFT, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><B><font color="Black">CME Accredited:</font></B>&nbsp;</td>
				<td colspan=5 VALIGN="middle">
					NO<INPUT TYPE="radio" NAME="cme_accredited" VALUE="0"  <CFIF form_two.cme_accredited EQ 0 >checked</CFIF>>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					YES<INPUT TYPE="radio" NAME="cme_accredited" VALUE="1" <CFIF form_two.cme_accredited EQ 1>checked</CFIF>>
				</TD>
			</TR>
			<TR>
				<TD align=right><A HREF="javascript:void(0);" onMouseOver="overlib('If this program is CME Accredited, use this field to type in the name of the Accredited Organization. This field can hold up to 30 characters.', CAPTION, 'Accredited Organization Name', LEFT, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><B><font color="Black">If CME, Name of Accredited Organization:</font></B>&nbsp;</td>
				<td colspan=5><INPUT NAME="cme_org" CLASS="text" VALUE="#Trim(form_two.cme_org)#" TYPE="text" maxlength="100" SIZE="100"></TD>
			</TR>
			<TR>
				<TD align=right><A HREF="javascript:void(0);" onMouseOver="overlib('Check the box to the left of any promotion enhancements you require. You may check as many boxes as needed. The larger boxes to the right of the promotion enhancements are date fields you may use to insert the date the promotion enhancements are to begin. If you click in these boxes, a calendar will pop up for you to select a date. ', CAPTION, 'Type of Promotion Enhancements', LEFT, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><B><font color="Black">Type of Promotion Enhancement:</font></B>&nbsp;</td>
				<td colspan=5>
					<TABLE>
					<TR>
						<TD><INPUT NAME="promodirectmail" VALUE=1 TYPE="checkbox" <CFIF #Trim(form_two.promo_direct_mail)# EQ 1>Checked</CFIF>>&nbsp;&nbsp;&nbsp;Direct Mail</TD>
						<TD><INPUT NAME="promodirectmaildate" CLASS="text" VALUE="#DateFormat(form_two.promo_direct_mail_date, "MM/DD/YYYY")#" TYPE="text" SIZE="10" onClick="CallCal(this)" onKeypress="if (event.keyCode < 47 || event.keyCode > 57) event.returnValue = false;">
						<img src="images/formcalendar.gif" style="vertical-align:middle">
						</TD>
					</TR>
					<TR>
						<TD><INPUT NAME="promorepnom" VALUE=1 TYPE="checkbox"  VALUE=1 <CFIF #Trim(form_two.promo_rep_nom)# EQ '1'>Checked</CFIF>>&nbsp;&nbsp;&nbsp;Rep. Nomination&nbsp;&nbsp;&nbsp;</TD>
						<TD><INPUT NAME="promorepnomdate" CLASS="text" VALUE="#DateFormat(form_two.promo_rep_nom_date, "MM/DD/YYYY")#" TYPE="text" SIZE="10" onClick="CallCal(this)" onKeypress="if (event.keyCode < 47 || event.keyCode > 57) event.returnValue = false;"> <img src="images/formcalendar.gif" style="vertical-align:middle"></TD>
					</TR>
					<TR>
						<TD><INPUT NAME="promofax" VALUE=1 TYPE="checkbox" <CFIF #Trim(form_two.promo_fax)# EQ '1'>Checked</CFIF>>&nbsp;&nbsp;&nbsp;Fax</TD>
						<TD><INPUT NAME="promofaxdate" CLASS="text" VALUE="#DateFormat(form_two.promo_fax_date, "MM/DD/YYYY")#" TYPE="text" SIZE="10" onClick="CallCal(this)" onKeypress="if (event.keyCode < 47 || event.keyCode > 57) event.returnValue = false;"> <img src="images/formcalendar.gif" style="vertical-align:middle"></TD>
					</TR>
					<TR>
						<TD><INPUT NAME="promoother" VALUE=1 TYPE="checkbox" <CFIF #Trim(form_two.promo_other)# EQ '1'>Checked</CFIF>>&nbsp;&nbsp;&nbsp;Other</TD>
						<TD><INPUT NAME="promootherdate" CLASS="text" VALUE="#DateFormat(form_two.promo_other_date, "MM/DD/YYYY")#" TYPE="text" SIZE="10" onClick="CallCal(this)" onKeypress="if (event.keyCode < 47 || event.keyCode > 57) event.returnValue = false;"> <img src="images/formcalendar.gif" style="vertical-align:middle"></TD>
					</TR>
					</TABLE>
				</TD>
			</TR>
			<TR>
				<TD align=right><A HREF="javascript:void(0);" onMouseOver="overlib('If you select Other as a promotion enhancement, use this field to list the details of this promotion enhancement. This field can hold up to 80 characters.', CAPTION, 'If Other, Explain', LEFT, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><B><font color="Black">If Other, Explain:</font></B><br>(up to 80 characters)&nbsp;</td>
				<td colspan=5><TEXTAREA NAME="promo_other_descrip" COLS="75" ROWS="2" onkeyup="return _checkLimitContent2(this)">#Trim(form_two.promo_other_descrip)#</TEXTAREA></TD>
			</TR>
			<TR>
				<TD align=right><A HREF="javascript:void(0);" onMouseOver="overlib('Check this box if attendees can participate more than once in the program. If they are not allowed to participate more than once, do not check the box.', CAPTION, 'Participate More Than Once.', LEFT, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><B><font color="Black">Participate More Than Once:</font></B>&nbsp;</td>
				<td colspan=5><INPUT TYPE="checkbox" NAME="re_recruit" VALUE="1" <CFIF #Trim(form_two.re_recruit)# EQ '1'>Checked</CFIF>></td>
			</TR>
			<TR>
				<TD align=right><A HREF="javascript:void(0);" onMouseOver="overlib('List the other materials to be included with the guidebook. This field can hold up to 30 characters', CAPTION, 'Other Materials Inclueded With Guidebook', LEFT, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><B><font color="Black">Other Materials Included With Guidebook:</font></B><br>(up to 500 characters)&nbsp;</td>
				<td colspan=5><TEXTAREA NAME="guidebook_include" COLS="75" ROWS="4" onkeyup="return _checkLimitContent(this)">#Trim(form_two.guidebook_include)#</TEXTAREA></TD>
			</TR>
			<TR>
				<TD align=right><A HREF="javascript:void(0);" onMouseOver="overlib('Check the boxes next to any Administration Materials to be included. You may check as many boxes as needed.', CAPTION, 'Administration Materials', LEFT, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><B><font color="Black">Administration Materials:</font></B>&nbsp;</td>
				<td colspan=5 style="background:##F0F8FF ; border : 1 solid Black;"><INPUT TYPE="checkbox" NAME="letter_confirmation" VALUE="1" <CFIF #Trim(form_two.letter_confirmation)# EQ '1'>Checked</CFIF>>&nbsp;Confirmation Letter
							&nbsp;&nbsp;&nbsp;&nbsp;<INPUT NAME="letter_thankyou" TYPE="checkbox" VALUE="1"  <CFIF #Trim(form_two.letter_thankyou)# EQ '1'>Checked</CFIF>>&nbsp;Thank You Letters
							&nbsp;&nbsp;&nbsp;&nbsp;<INPUT NAME="PI" TYPE="checkbox" VALUE="1"  <CFIF #Trim(form_two.PI)# EQ '1'>Checked</CFIF>>&nbsp;PI
							&nbsp;&nbsp;&nbsp;&nbsp;<INPUT NAME="letter_faxinfosheet" TYPE="checkbox" VALUE="1"  <CFIF #Trim(form_two.letter_faxinfosheet)# EQ '1'>Checked</CFIF>>&nbsp;Fax Info Sheet
							&nbsp;&nbsp;&nbsp;&nbsp;<INPUT NAME="letter_other" TYPE="checkbox" VALUE="1"  <CFIF #Trim(form_two.letter_other)# EQ '1'>Checked</CFIF>>&nbsp;Other
				</TD>
			</TR>
			<TR>
			   <TD align=right><A HREF="javascript:void(0);" onMouseOver="overlib('Type in any other material to be include with the fulfillment pacakage that was not listed above. This field can hold up to 80 characters.', CAPTION, 'Other Material With Fulfillment Package', LEFT, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><B><font color="Black">Any other material to be included with the fulfillment package:</font></B><br>(up to 80 characters)&nbsp;</td>
			   <td colspan=5><TEXTAREA NAME="letter_other_description" COLS="75" ROWS="2" onkeyup="return _checkLimitContent2(this)">#Trim(form_two.letter_other_description)#</TEXTAREA></TD>
			</TR>
			<TR>
				<!--- materials to recruiter date--->
				<TD align=right><A HREF="javascript:void(0);" onMouseOver="overlib('Select the date materials are to go to the recruiter. If you click in this field, a calendar will pop up for you to select a date.', CAPTION, 'Materials to Recruiter', LEFT, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()" onClick="CallCal()"><B><font color="Black">Materials to Recruiter Date:</font></B>&nbsp;</td>
				<td><INPUT NAME="guidebook_to_recruiter" CLASS="text" VALUE="#DateFormat(form_two.guidebook_to_recruiter, "MM/DD/YYYY")#" TYPE="text" SIZE="10" onClick="CallCal(this)" onKeypress="if (event.keyCode < 47 || event.keyCode > 57) event.returnValue = false;">
				<img src="images/formcalendar.gif" style="vertical-align:middle">
				</TD>
				<td colspan=4>&nbsp;</td>
			</TR>
			<TR>
		   		<TD align=right><A HREF="javascript:void(0);" onMouseOver="overlib('Type in the names of the speakers and their compensation amounts.', CAPTION, 'Speaker Names and Compensation', LEFT, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><B><font color="Black">Speaker names and compensation:</font></B><br>(up to 200 characters)&nbsp;</td>
				<td colspan=5><TEXTAREA NAME="speaker_notes" COLS="75" ROWS="4" onkeyup="return _checkLimitContent3(this)">#Trim(form_two.speaker_notes)#</TEXTAREA></TD>
			</TR>
			<tr>
				<TD align=right><A HREF="javascript:void(0);" onMouseOver="overlib('Check this box if the survey is to be included. Do not check the box if the survey should not be included.', CAPTION, 'Survey Included', LEFT, ABOVE, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><B><font color="Black">Survey Included:</font></B>&nbsp;<INPUT TYPE="checkbox" NAME="include_survey" VALUE="1" <CFIF #form_two.include_survey# EQ '1'>Checked</CFIF>></TD>
				<td align=left><A HREF="javascript:void(0);" onMouseOver="overlib('Select the compensation amount and type in the drop downs. Both of the fields are required.', CAPTION, 'Attendee Comp', LEFT, ABOVE, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><B><font color="Red">&nbsp;Attendee comp</font></B>&nbsp;
					<br>&nbsp;&nbsp;&nbsp;&nbsp;
					<SELECT NAME="attendee_comp">
						<OPTION VALUE="" <CFIF #form_two.attendee_comp# EQ "">Selected</CFIF>>(Select)</OPTION>
						<OPTION VALUE="0" <CFIF #form_two.attendee_comp# EQ 0>Selected</CFIF>>None</OPTION>
						<OPTION VALUE="50" <CFIF #form_two.attendee_comp# EQ 50>Selected</CFIF>>50</OPTION>
						<OPTION VALUE="75" <CFIF #form_two.attendee_comp# EQ 75>Selected</CFIF>>75</OPTION>
						<OPTION VALUE="100" <CFIF #form_two.attendee_comp# EQ 100>Selected</CFIF>>100</OPTION>
						<OPTION VALUE="150" <CFIF #form_two.attendee_comp# EQ 150>Selected</CFIF>>150</OPTION>
						<OPTION VALUE="175" <CFIF #form_two.attendee_comp# EQ 175>Selected</CFIF>>175</OPTION>
						<OPTION VALUE="200" <CFIF #form_two.attendee_comp# EQ 200>Selected</CFIF>>200</OPTION>
						<OPTION VALUE="250" <CFIF #form_two.attendee_comp# EQ 250>Selected</CFIF>>250</OPTION>
					</SELECT>

					<!---<CFSET temp_honararia=#attendee_comp_type#> --->
					</CFOUTPUT>
						<CFQUERY DATASOURCE="#application.projdsn#" NAME="honoraria_code">
							SELECT honoraria_id, honoraria_name	FROM honoraria_type ORDER by honoraria_id;
						</CFQUERY>
						<SELECT NAME="attendee_comp_type" SIZE="1">
						<OPTION VALUE="">(Select)</OPTION>
							<CFOUTPUT QUERY="honoraria_code">
								<OPTION VALUE="#honoraria_id#" <cfif #form_two.attendee_comp_type_id# EQ #honoraria_id#> SELECTED</cfif>>#honoraria_name#
							</CFOUTPUT>
						</SELECT>
					</TD>
					<CFOUTPUT QUERY="form_two">
					<td align=left style="margin-top: 5cm;"><A HREF="javascript:void(0);" onMouseOver="overlib('Select the compensation amount and type in the drop downs.', CAPTION, 'Survey Comp', LEFT, ABOVE, CSSCLASS, BGCLASS, 'mouseover', CAPTIONFONTCLASS, 'mouseoverfont')" onMouseOut="nd()"><B><font color="Black">&nbsp;Survey Comp</font></B>&nbsp;
						<br>&nbsp;&nbsp;&nbsp;
						<SELECT NAME="survey_comp">
							<OPTION VALUE="" <CFIF #survey_comp# EQ "">Selected</CFIF>>(Select)</OPTION>
							<OPTION VALUE="0" <CFIF #survey_comp# EQ 0>Selected</CFIF>>None</OPTION>
							<OPTION VALUE="25" <CFIF #survey_comp# EQ 25>Selected</CFIF>>25</OPTION>
							<OPTION VALUE="50" <CFIF #survey_comp# EQ 50>Selected</CFIF>>50</OPTION>
							<OPTION VALUE="75" <CFIF #survey_comp# EQ 75>Selected</CFIF>>75</OPTION>
							<OPTION VALUE="100" <CFIF #survey_comp# EQ 100>Selected</CFIF>>100</OPTION>
							<OPTION VALUE="150" <CFIF #survey_comp# EQ 150>Selected</CFIF>>150</OPTION>
							<OPTION VALUE="200" <CFIF #survey_comp# EQ 200>Selected</CFIF>>200</OPTION>
							<OPTION VALUE="250" <CFIF #survey_comp# EQ 250>Selected</CFIF>>250</OPTION>
						</SELECT>
					</CFOUTPUT>
					<CFQUERY DATASOURCE="#application.projdsn#" NAME="honoraria_code">
						SELECT honoraria_id, honoraria_name FROM honoraria_type ORDER by honoraria_id;
					</CFQUERY>
					<SELECT NAME="survey_comp_type" SIZE="1">
					<OPTION VALUE="" Selected>(Select)</OPTION>
						<CFOUTPUT QUERY="honoraria_code">
							<OPTION VALUE="#honoraria_id#" <cfif #form_two.survey_comp_type# EQ #honoraria_id#> SELECTED</cfif>>#honoraria_name#
						</CFOUTPUT>
					</SELECT>
					</TD>
				</TR>
					<CFIF IsDefined ("session.project_status") AND (session.project_status EQ "active")>
						<CFQUERY DATASOURCE="#application.projdsn#" NAME="piwnotecheck">
							SELECT * FROM piw_notes	WHERE piw_id = '#session.rowid#' AND note_type = 'PIW2'
						</CFQUERY>
				<TR>
					<TD align=right STYLE="vertical-align : middle;"><SPAN CLASS="required"><B>EDIT PIW COMMENTS:</B></SPAN>&nbsp;</TD>
					<TD COLSPAN="5"><TEXTAREA STYLE="vertical-align : middle;" NAME="piwadminedit_note" COLS="60" ROWS="4"><CFIF IsDefined ("session.project_status") AND piwnotecheck.recordcount NEQ 0><CFOUTPUT>#TRIM(piwnotecheck.note_data)#</CFOUTPUT></CFIF></TEXTAREA></TD>
						<CFOUTPUT><INPUT TYPE="hidden" VALUE=session.rowid NAME="rowid"></CFOUTPUT>
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
											<td align="left"><input type="button" name="print" value="  Print  " onClick="javascript:void window.open('piw2.cfm?no_menu=1&project_code=#session.project_code#','t','width=785,height=450,menubar=yes,scrollbars=yes,status=yes,toolbar=no,resizable=yes');"></td>
											<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
											<TD><input TYPE="Button" NAME="prev_page" VALUE="Previous Page" onCLick="whichway(1)"></td>
											<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
											<td><input TYPE="Button" NAME="next_page" VALUE="Next Page" onCLick="whichway(4)"></td>
										</tr>
									</Table>
									<cfelse>
									<Table>
										<tr>
											<td><input type="button" name="print" value="  PDF " onClick="javascript:void window.open('piw2_to_pdf.cfm?no_menu=1&project_code=#session.project_code#','t','width=785,height=450,menubar=yes,scrollbars=yes,status=yes,toolbar=no,resizable=yes');"></td>
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
