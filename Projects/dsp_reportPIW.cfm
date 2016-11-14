<cfsilent>

<cfparam name="url.action" default="">

<CFIF IsDefined("form.project_code")>
  <cfset session.project_code = form.project_code>
<CFELSEIF IsDefined("URL.project_code")>
  <cfset session.project_code = URL.project_code>
</CFIF>


<cfset qpiw = request.Project.getProject(Session.project_code)>
<!---<cfinvoke component="pms.com.projects" method="getProject" project_code='#session.project_code#' returnvariable="qpiw">--->

<!--- save client_code from query above --->
<cfset session.client_code = qpiw.client_code>

<!--- get info from the notes table --->
<cfset qgetnotes = request.Project.getProjectNotes(Session.project_code)>

<!---<cfinvoke component="pms.com.projects" method="getProjectNotes" project_code='#session.project_code#' returnvariable="qgetnotes">--->
</cfsilent>
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Project Initiation WorkSheet for #session.project_code#" showCalendar="1">

<br>
<table border="0" cellpadding="0" cellspacing="0" align="center" width="100%">
  <tr>
    <td align="center">
	    <p>The information below is the complete PIW record. To make changes to the PIW record click the EDIT button below.</p>
		<table border="0" width="80%" cellspacing="1" cellpadding="5" class="reporttext">
		<cfoutput>
		<cfif url.action EQ "Edit" and url.Section EQ 1>
		   <tr>
		     <td class="highlightEdit" colspan="2"><strong style="font-color:##eeeeee;">Editing Project Information Worksheet</strong></td>
		   </tr>
		   <tr>
		     <td colspan="2" align="left"><cfinclude template="dsp_EditPIW.cfm"></td>
		   </tr>
		<cfelse>
			<!---*************************
				contact info section
			***************************--->
			<tr class="highlight">
				<td colspan="2">
					<font size="2"><b><font color="Navy">Project Information Worksheet</font></b>&nbsp;<font size="-2"><a href="dsp_reportPIW.cfm?project_code=#Session.Project_Code#&action=Edit&Section=1##sec1" name="sec1">[EDIT]</a></font>
				</td>
			</tr>
			<tr class="highlight2">
				<td width="40%"><b>Client Code:</b></td>
				<td>#qpiw.client_code#</td>
			</tr>
			<cfset getStatuslabel = request.util.getProjStatusCodes(qpiw.projstatus)>
			<!---<cfinvoke component="pms.com.utilities" method="getProjStatusCodes" StatusID='#qpiw.projstatus#' returnvariable="getStatuslabel">--->
			<tr>
				<td width="40%"><b>Project Status:</b></td>
				<td>#getStatuslabel.codeDesc#</td>
			</tr>
			<tr class="highlight2">
				<td><b>Selling Corporation:</b></td>
				<td>#qpiw.corp_value#</td>
			</tr>
			<cfif qpiw.account_exec NEQ "">
				<cfset ae = qpiw.account_exec>
			<cfelse>
				<cfset ae = 0>
			</cfif>

			<cfset qAE = request.Project.getSalesRep(ae)>
			<!---<cfinvoke component="pms.com.projects" method="getSalesRep" account_exec='#ae#' returnvariable="qAE">--->
			<tr>
				<td><b>Account Executive:</b></td>
				<td>#qAE.repfirstname#&nbsp;#qAE.replastname#</td>
			</tr>
			<cfif qpiw.account_supr NEQ "">
				<cfset as = qpiw.account_supr>
			<cfelse>
				<cfset as = 0>
			</cfif>
			<!--- Get Account Supervisor--->
			<cfset qaccount_supr =  request.Project.getSalesRep(as)>
			<!---<cfinvoke component="pms.com.projects" method="getSalesRep" account_exec='#ae#' returnvariable="qAE">--->

			<tr class="highlight2">
				<td><b>Account Supervisor:</b></td>
				<td>#qaccount_supr.repfirstname#&nbsp;#qaccount_supr.replastname#</td>
			</tr>
			<tr>
				<td><b>Client:</b></td>
				<td>#qpiw.client_name#</td>
			</tr>
			<tr class="highlight2">
				<td><b>Product:</b></td>
				<td>#qpiw.product#</td>
			</tr>
			<tr>
				<td><b>Guide Topic/Headline:</b></td>
				<td>#qpiw.guide_topic#</td>
			</tr>
			<tr class="highlight2">
				<td><b>Recruit Start Date:</b></td>
				<td>#DateFormat(qpiw.recruit_start, "mm/dd/yyyy")#</td>
			</tr>
			<tr>
				<td><b>Projected Program Start Date:</b></td>
				<td>#DateFormat(qpiw.proj_program_start, "mm/dd/yyyy")#</td>
			</tr>
			<tr class="highlight2">
				<td><b>Actual Program Start Date:</b></td>
				<td>#DateFormat(qpiw.program_start, "mm/dd/yyyy")#</td>
			</tr>
			<tr>
				<td><b>Program End Date:</b></td>
				<td>#DateFormat(qpiw.program_end, "mm/dd/yyyy")#</td>
			</tr>
			<tr class="highlight2">
				<td><b>Recruiting Company:</b></td>
				<td>#qpiw.recruiter_name#</td>
			</tr>
			<tr>
				<td><b>Recruiting Company Phone:</b></td>
				<cfif #len(trim(qpiw.recruiting_company_phone))# EQ 10>
					<td>(#Left(qpiw.recruiting_company_phone,3)#)#Mid(qpiw.recruiting_company_phone,4,3)#-#Mid(qpiw.recruiting_company_phone,7,11)#</td>
				<cfelse>
					<td>#qpiw.recruiting_company_phone#</td>
				</cfif>
			</tr>
			<tr class="highlight2">
				<td><b>Call In or Call Out Program:</b></td>
				<td>
					<cfif qpiw.call_inbound EQ 1>call in</cfif>
					<cfif qpiw.call_outbound EQ 1>call out</cfif>
				</td>
			</tr>
			<tr>
				<td><b>Conference Company:</b></td>
				<td>#qpiw.conf_company_name#</td>
			</tr>
			<tr class="highlight2">
				<td><b>800## Helpline/Disconnect:</b></td>
				<cfif #len(trim(qpiw.helpline))# EQ 10>
					<td>(#Left(qpiw.helpline,3)#)#Mid(qpiw.helpline,4,3)#-#Mid(qpiw.helpline,7,11)#</td>
				<cfelse>
					<td>#qpiw.helpline#</td>
				</cfif>
			</tr>

			<cfset qguidewriters =  request.Project.getGuideWriter(session.project_code)>
			<!---<cfinvoke component="pms.com.projects" method="getGuideWriter" project_code='#session.project_code#' returnvariable="qguidewriters">--->


			<tr>
				<td><b>Guide Writer:</b></td>
				<td>#trim(qguidewriters.first_name)# #trim(qguidewriters.last_name)#</td>
			</tr>
		    <!--- Get Moderator --->
		    <cfset gmods = request.Project.getPIWModerator(session.project_code)>
		    <!---<cfinvoke component="pms.com.projects" method="getPIWModerator" project_code='#session.project_code#' returnvariable="gmods">--->

		    <tr  class="highlight2">
				<td><b>Speaker ListenIn:</b></td>
				<cfif len(trim(qpiw.speaker_listenins)) EQ 10>
					<cfset speakerListenIn = "(#Left(qpiw.speaker_listenins,3)#) #Mid(qpiw.speaker_listenins,4,3)#-#Mid(qpiw.speaker_listenins,7,11)#">
				<cfelseif len(trim(qpiw.speaker_listenins)) LT 10>
				    <cfset speakerListenIn = qpiw.speaker_listenins>
				<cfelse>
					<cfset speakerListenIn = "">
				</cfif>
				<td>#trim(speakerListenIn)#</td>
			</tr>
			<!--- end of contact info section --->
		  </cfif>
		  <!--- **************************************
		      project/program section
		  *************************************** --->
		  <cfif url.action EQ "Edit" and url.Section EQ 2>
		   <tr>
		     <td class="highlightEdit" colspan="2"><strong style="font-color:##eeeeee;">Editing Project Information Worksheet</strong></td>
		   </tr>
		   <tr>
		     <td colspan="2" align="left"><cfinclude template="dsp_EditPIW.cfm"></td>
		   </tr>
		  <cfelse>
			<cfset meeting_type_code = request.Project.getMeetingTypeCode(session.project_code)>
			<!---<cfinvoke component="pms.com.projects" method="getMeetingTypeCode" project_code='#session.project_code#' returnvariable="meeting_type_code">--->


			<tr class="highlight"><td colspan="2"><font size="2"><b>Project/Program</b></font>&nbsp;<font size="-2"><a href="dsp_reportPIW.cfm?project_code=#Session.Project_Code#&action=Edit&Section=2##sec2" name="sec2">[EDIT]</a></font></td></tr>
			<tr class="highlight2">
				<td><b>Meeting Type:</b></td>
				<td>#meeting_type_code.meeting_type_value# - #meeting_type_code.meeting_type_description#<!--- #trim(meeting_type_value)# --->
					<cfif qpiw.meeting_type EQ 99>&nbsp;&nbsp;*#qpiw.meeting_other_notes#</cfif>
				</td>
			</tr>
			<tr>
				<td><b>Particpants Per Program:</b></td>
				<td>#qpiw.prog_participants#</td>
			</tr>
			<tr class="highlight2">
				<td><b>## of Meetings per Project:</b></td>
				<td>#qpiw.num_meetings#</td>
			</tr>
			<tr>
				<td><b>Meeting Participant Target:</b></td>
				<td>#qpiw.participant_target#</td>
			</tr>
			<tr class="highlight2">
				<td><b>Meeting Participant Recruit:</b></td>
				<td>#qpiw.participant_recruit#</td>
			</tr>
			<tr>
				<td><b>Length of Program:</b></td>
				<td>#qpiw.prog_length_hr#
					<cfif qpiw.prog_length_hr NEQ "">hrs</cfif>&nbsp;#qpiw.prog_length_min#
					<cfif qpiw.prog_length_min NEQ "">minutes</cfif>
				</td>
			</tr>
			<tr class="highlight2">
				<td><b>Special Notes:</b></td>
				<td>#qpiw.special_notes#</td>
			</tr>
			<tr>
				<td><b>Target Audience:</b></td>
				<td>#qpiw.target_audience#</td>
			</tr class="highlight2">
			<tr class="highlight2">
				<td><b>CME Accredited:</b></td>
				<td><cfif qpiw.cme_accredited EQ 0>no</cfif><cfif qpiw.cme_accredited EQ 1>yes</cfif></td>
			</tr>
			<tr>
				<td><b>CME Accredited Organization:</b></td>
				<td>#qpiw.cme_org#</td>
			</tr>
			<tr class="highlight2">
				<td><b>Type of Promotion:</b></td>
				<td><cfif qpiw.promo_direct_mail EQ 1>Direct Mail&nbsp;#DateFormat(qpiw.promo_direct_mail_date, "mm/dd/yyyy")#<br></cfif>
					<cfif qpiw.promo_rep_nom EQ 1>Rep Nomination&nbsp;#DateFormat(qpiw.promo_rep_nom_date, "mm/dd/yyyy")#<br></cfif>
					<cfif qpiw.promo_fax EQ 1>Fax&nbsp;#DateFormat(qpiw.promo_fax_date, "mm/dd/yyyy")#<br></cfif>
					<cfif qpiw.promo_other EQ 1>Other:&nbsp;&nbsp;#DateFormat(qpiw.promo_direct_mail_date, "mm/dd/yyyy")#<br></cfif>
				</td>
			</tr>
			<tr><td><b>Other Promotion Notes:</b></td><td>#qpiw.promo_other_descrip#<br></td></tr>
			<tr class="highlight2">
				<td><b>Other Materials to Be Included with Guidebook:</b></td>
				<td>#qpiw.guidebook_include#</td>
			</tr>
			<tr>
				<td><b>Confirmation Letter:</b></td>
				<td><cfif qpiw.letter_confirmation EQ 0>no</cfif><cfif qpiw.letter_confirmation EQ 1>yes</cfif></td>
			</tr>
			<tr class="highlight2">
				<td><b>Thank You Letter:</b></td>
				<td><cfif qpiw.letter_thankyou EQ 0>no</cfif><cfif qpiw.letter_thankyou EQ 1>yes</cfif></td>
			</tr>
			<tr>
				<td><b>Product Information:</b></td>
				<td><cfif qpiw.PI EQ 0>no</cfif><cfif qpiw.PI EQ 1>yes</cfif></td>
			</tr>
			<!--- <tr>
				<td><b>Fact Sheet:</b></td>
				<td><cfif letter_factsheet EQ 0>no</cfif><cfif letter_factsheet EQ 1>yes</cfif></td>
			</tr> --->
			<tr class="highlight2">
				<td><b>Fax Info Sheet:</b></td>
				<td><cfif qpiw.letter_faxinfosheet EQ 0>no</cfif><cfif qpiw.letter_faxinfosheet EQ 1>yes</cfif></td>
			</tr>
			<tr>
				<td><b>Other Notes for Confirmation:</b></td>
				<td>#qpiw.letter_other_description#</td>
			</tr>
			<tr class="highlight2">
				<td><b>Materials to Recruiter:</b></td>
				<td>
				<cfif qpiw.guidebook_to_recruiter NEQ ''>
				 #DateFormat(qpiw.guidebook_to_recruiter, "mm/dd/yyyy")#
				<cfelse>
				 #qpiw.guidebook_to_recruiter#
				</cfif>
				</td>
			</tr>
			<tr>
				<td><b>Speaker Names and Compensation:</b></td>
				<td>#qpiw.speaker_notes#</td>
			</tr>
			<!--- get Honoraria Type --->
			  <cfset qattendee_comp_type = request.Project.getHonoraria(qpiw.attendee_comp_type_id)>
		      <cfset qsurvey_comp_type = request.Project.getHonoraria(qpiw.survey_comp_type)>

		     <!---<cfinvoke component="pms.com.projects" method="getHonoraria" HONORIAID ='#qpiw.attendee_comp_type_id#' returnvariable="qattendee_comp_type">
		     <cfinvoke component="pms.com.projects" method="getHonoraria" HONORIAID ='#qpiw.survey_comp_type#' returnvariable="qsurvey_comp_type">
		     --->

			<tr class="highlight2">
				<td><b>Attendee Honorarium Amt:</b></td>
				<td>#dollarformat(qpiw.attendee_comp)#&nbsp;#qattendee_comp_type.honoraria_name#</td>
			</tr>
			<tr>
				<td><b>Survey Compensation:</b></td><td>#DollarFormat(qpiw.survey_comp)#&nbsp;#qsurvey_comp_type.honoraria_name#</td>
			</tr>
			<tr class="highlight2">
				<td><b>Survey To Be Included:</b></td><td><cfif qpiw.include_survey EQ 0>no</cfif><cfif qpiw.include_survey EQ 1>yes</cfif></td>
			</tr>
		   </cfif>
			<!---********************************
			  bill/finance section, When Needed
			  *******************************--->

		   <!--- *******************************
			    reporting needs section
			*********************************--->
			<cfif url.action EQ "Edit" and url.Section EQ 3>
			   <tr>
			     <td class="highlightEdit" colspan="2"><strong style="font-color:##eeeeee;">Editing Project Reporting Needs</strong></td>
			   </tr>
			   <tr>
			     <td colspan="2" align="left"><cfinclude template="dsp_EditPIW.cfm"></td>
			   </tr>
			<cfelse>

			<tr class="highlight"><td colspan="2"><font size="2"><b>Reporting Needs</b></font>&nbsp;<font size="-2"><a href="dsp_reportPIW.cfm?project_code=#Session.Project_Code#&action=Edit&Section=3##sec3" name="sec3">[EDIT]</a></font></td></tr>
			<tr class="highlight2">
				<td><b>Written Summary Reports:</b></td>
				<td><cfif qpiw.summary_weekly EQ 1>Weekly<cfif qpiw.summary_monthly EQ 1>,</cfif>&nbsp;</cfif>
					<cfif qpiw.summary_monthly EQ 1>Monthly<cfif qpiw.summary_other EQ 1>,</cfif>&nbsp;</cfif>
					<cfif qpiw.summary_other EQ 1>Others&nbsp;</cfif>
				</td>
			</tr>
			<tr>
				<td><b>Notes for Written Reporting:</b></td>
				<td>#qpiw.summary_other_descrip#
				</td>
			</tr>
			<tr class="highlight2">
				<td><b>Voice Mail Reporting To:</b></td>
				<td><cfif qpiw.vm_mgrs EQ 1>Managers<cfif qpiw.vm_reps EQ 1>,</cfif>&nbsp;</cfif>
					<cfif qpiw.vm_reps EQ 1>Reps<cfif qpiw.vm_other EQ 1>,</cfif>&nbsp;</cfif>
					<cfif qpiw.vm_other EQ 1>Others&nbsp;</cfif>
				</td>
			</tr>
			<tr>
				<td><b>Notes for Voice Mail Reporting:</b></td>
				<td>#qpiw.vm_other_descrip#
				</td>
			</tr>
			<tr class="highlight2">
				<td><b>Online Report Heading:</b></td>
				<td>#qpiw.online_report_heading#
				</td>
			</tr>
			<!--- <tr class="highlight2">
				<td><b>Special Voice Mail Reporting:</b></td>
				<td>#qpiw.vm_special#
				</td>
			</tr> --->
			<tr>
				<td><b>E-Mail Reporting To:</b></td>
				<td><cfif qpiw.email_mgrs EQ 1>Managers<cfif qpiw.email_reps EQ 1>,</cfif>&nbsp;</cfif>
					<cfif qpiw.email_reps EQ 1>Reps<cfif qpiw.email_other EQ 1>,</cfif>&nbsp;</cfif>
					<cfif qpiw.email_other EQ 1>Others:&nbsp;</cfif>
				</td>
			</tr>
			<tr class="highlight2">
				<td><b>Notes for E-Mail Reporting:</b></td>
				<td>#qpiw.email_other_descrip#
				</td>
			</tr>
			<tr>
				<td><b>Client Toll Free ## for Moderators to Conduct VM:</b></td>
				<cfif #len(trim(qpiw.client_toll_free))# EQ 10>
					<td>(#Left(qpiw.client_toll_free,3)#)#Mid(qpiw.client_toll_free,4,3)#-#Mid(qpiw.client_toll_free,7,11)#</td>
				<cfelse><td>#qpiw.client_toll_free#</td>
				</cfif>
			</tr>
			<tr class="highlight2">
				<td><b>Special Reporting:</b></td>
				<td>#qpiw.special_report#</td>
			</tr>

			</cfif>

			<!---*********************************
			   creative services section
			   *******************************--->
			<cfif url.action EQ "Edit" and url.Section EQ 4>
			   <tr>
			     <td class="highlightEdit" colspan="2"><strong style="font-color:##eeeeee;">Editing Project Creative Services</strong></td>
			   </tr>
			   <tr>
			     <td colspan="2" align="left"><cfinclude template="dsp_EditPIW.cfm"></td>
			   </tr>
			<cfelse>
				<tr class="highlight">
					<td colspan="2"><font size="2"><b>Creative Services Information</b></font>&nbsp;<font size="-2"><a href="dsp_reportPIW.cfm?project_code=#Session.Project_Code#&action=Edit&Section=4##sec4" name="sec4">[EDIT]</a></font></td>
				</tr>
				<tr class="highlight2">
					<td><b>Initial Submission Date to<br>Creative Services Dept for the Following:</b></td>
					<td><cfif qpiw.moderator_guide_date NEQ "">*Moderator Discussion Guide&nbsp;#DateFormat(qpiw.moderator_guide_date, "mm/dd/yyyy")#<br></cfif><cfif qpiw.admin_materials_date NEQ "">*Admin Materials&nbsp;#DateFormat(qpiw.admin_materials_date, "mm/dd/yyyy")#<br></cfif><cfif qpiw.guidebook_date NEQ "">*Participant Guidebook&nbsp;#DateFormat(qpiw.guidebook_date, "mm/dd/yyyy")#<br></cfif>
						<cfif qpiw.components_date NEQ "">*Components&nbsp;#DateFormat(qpiw.components_date, "mm/dd/yyyy")#</cfif>
					</td>
				</tr>
				<tr>
					<td><b>Guidebook Instructions:</b></td>
					<td><cfif qpiw.guidebook_new EQ 1>new</cfif>
						<cfif qpiw.guidebook_revised EQ 1>
							<cfif qpiw.guidebook_new EQ 1>,&nbsp;</cfif>revised</cfif>
						<cfif qpiw.guidebook_charts EQ 1>
						<cfif qpiw.guidebook_revised EQ 1 or guidebook_new EQ 1>,&nbsp;</cfif>charts from client
						</cfif>
					</td>
				</tr>
				<tr class="highlight2">
					<td><b>Revisions on Guidebook:</b></td><td><cfif qpiw.revise_wording EQ 1>update wording</cfif><cfif qpiw.revise_charts EQ 1><cfif qpiw.revise_wording EQ 1>,&nbsp;</cfif>revisions on charts</cfif><cfif qpiw.new_charts EQ 1><cfif qpiw.revise_wording EQ 1 or qpiw.revise_charts EQ 1>,&nbsp;</cfif>creation of new charts</cfif></td>
				</tr>
				<tr>
					<td><b>Special Instructions for Creative Services:</b></td>
					<td>#qpiw.special_instructions#</td>
				</tr>
			</cfif>

				<!---************************
				   Recruiting Information
				  ************************--->
			    <cfif url.action EQ "Edit" and url.Section EQ 5>
			       <tr>
			         <td class="highlightEdit" colspan="2"><strong style="font-color:##eeeeee;">Editing Recruiting Information</strong></td>
			       </tr>
			       <tr>
			          <td colspan="2" align="left"><cfinclude template="dsp_EditPIW.cfm"></td>
			       </tr>
			    <cfelse>
				   <tr class="highlight"><td colspan="2"><b><font size="2">Recruiting Information</font></b>&nbsp;<font size="-2"><a href="dsp_reportPIW.cfm?project_code=#Session.Project_Code#&action=Edit&Section=5##sec5" name="sec5">[EDIT]</a></font></td></tr>
				   <tr class="highlight2">
					  <td><b>Will there be an initial recruitment mailing? Any subsequent mailings?:</b></td>
					  <td>#qpiw.recruit_mailings_info#</td>
				   </tr>
				   <tr>
					  <td><b>Recruiting Strategy:</b></td>
					  <td>#qpiw.additional_info#</td>
				   </tr>
				   <tr class="highlight2">
					  <td><b>What are guidelines for physicians who are generated from direct mailers?:</b></td>
					  <td>#qpiw.direct_mailers_info#</td>
				   </tr>
				   <tr>
					  <td><b>General Market/Drug Information for Recruiter:</b></td>
					  <td>#qpiw.market_drug_info#</td>
				   </tr>
				   <tr class="highlight2">
					  <td><b>General Market/Drug Information for <u>SCRIPT</u> for Recruiter:</b></td>
					  <td>#qpiw.market_drug_script#</td>
				   </tr>
				   <tr>
					  <td><b>Allowed to participate in meetings:</b></td>
					  <td><cfif qpiw.rep_nom EQ 1>Physicians who call in from Rep Nominations<br></cfif>
						  <cfif qpiw.pa_ok EQ 1>Physician Assistants<br></cfif><cfif qpiw.np_ok EQ 1>Nurse Practitioners<br></cfif>
						  <cfif qpiw.other_ok EQ 1>Other&nbsp;- </cfif>#qpiw.other_description#<br>
					  </td>
				   </tr>
		      </cfif>
			</cfoutput>

			<!--- *****************************
				Additional Project Notes
			 ******************************--->
			<CFIF qgetnotes.RecordCount GT 0>
				<cfif url.action EQ "Edit" and url.Section EQ 6>

					   <tr>
				         <td class="highlightEdit" colspan="2"><strong style="font-color:##eeeeee;">Editing Addition Comments</strong></td>
				       </tr>

				       <tr>
				          <td colspan="2" align="left"><cfinclude template="dsp_EditPIW.cfm"></td>
				       </tr>
				    <cfelse>

						<cfoutput>
						<tr class="highlight">
							<td colspan="2"><font size="2"><b>Additional Project Notes:</b></font>&nbsp;<font size="-2"><a href="##sec6" onclick="window.open('/Projects/NotesList.cfm?no_menu=1&project_code=#Session.Project_Code#','notes','resizable=yes,scrollbars=auto,menubar=no,status=no,width=500,height=300,top=50,left=50');" name="sec6">[EDIT]</a></font></td>
						</tr>
						</cfoutput>

						<cfloop query="qgetnotes">
						<cfoutput>
						<tr class="highlight2">
							<td colspan="2">
							<!--- #note_data# --->
							#qgetnotes.subject# - #qgetnotes.note_data# - #qgetnotes.note_type#<Br>
							#qgetnotes.note_data#
							<Br>
							<cfset quser = request.util.getuser(qgetnotes.entry_userid)>
							BY:
							#quser.first_name#
							&nbsp;
							#quser.last_name#
							&nbsp; @
							(#DateFormat(qgetnotes.entry_date, "mm/dd/yyyy")#)
							<br>
							</td>
						</tr>
						</cfoutput>
						</cfloop>

				</cfif>
			</CFIF>
			<!--- *****************************
				Project Moderator/Speaker Sections
				These will open up poups that will display
				the moderator information, We should be able to
				Link these to the scheduling module.
			 ******************************--->
			<tr class="highlight">
				<td colspan="2"><font size="2"><b>Project Moderators/Speakers</b></font></td>
			</tr>
			<cfoutput>
				<tr class="highlight2">
					<td><b>Assigned Moderators:</b></td>
					<td><a href="javascript:void window.open('mod_popup.cfm?no_menu=1&project_code=#session.project_code#','t','width=400,height=200,menubar=no,scrollbars=yes,status=no,toolbar=no,resizable=yes');">View Moderators</a><!--- &nbsp;|&nbsp;<a href="javascript:void window.open('popup_AddModerator.cfm?project_code=#session.project_code#','p','width=400,height=200,menubar=no,scrollbars=yes,status=no,toolbar=no,resizable=yes');">Add New Moderators</a> ---></td>
				</tr>
				<tr>
					<td><b>Assigned Speakers:</b></td>
					<td><a href="javascript:void window.open('spkr_popup.cfm?no_menu=1&project_code=#session.project_code#','t','width=400,height=200,menubar=no,scrollbars=yes,status=no,toolbar=no,resizable=yes');">View Speakers</a><!--- &nbsp;|&nbsp;<a href="javascript:void window.open('popup_AddSpeaker.cfm?project_code=#session.project_code#','p','width=400,height=200,menubar=no,scrollbars=yes,status=no,toolbar=no,resizable=yes');">Add New Speakers</a> ---></td>
				</tr>

			<cfset qdb = request.Project.getDBStats(session.project_code)>
			<!---<cfinvoke component="pms.com.projects" method="getDBStats" project_code='#session.project_code#' returnvariable="qdb">--->
			<cfif qdb.received_filename neq "">
			  <tr class="highlight">
				<td colspan="2"><font size="2"><font color="Navy"><b>Database Statistics</b></font></font></td>
			  </tr>
			  <tr class="highlight2">
				<td><b>Database Statistics:</b></td>
				<td><a href="javascript:void window.open('report_dbstats_popup.cfm?no_menu=1&project_code=#session.project_code#','t','width=400,height=200,menubar=no,scrollbars=no,status=no,toolbar=no,resizable=yes');">View Database Statistics</a></td>
				</tr>
			</cfif>
			</cfoutput>

			<!--- <cfif IsDefined("report")>
				<tr><td>&nbsp;</td></tr>
				<tr>
					<td><img src="/images/btn_print" alt="print this page" onclick="self.print();"></td>
					<form action="index.cfm">
					<td>
						<INPUT TYPE="submit" NAME="list" VALUE="Back to Project List"></form>
				  	</td>
				  	<form action="report_piw_search.cfm">
				  <td><INPUT CLASS="button" TYPE="submit" NAME="submit" VALUE="  Back  "></form>
				  </td>
			  </tr>
			<cfelse>
			  <tr><td>&nbsp;</td></tr>
				<tr align="center">
					<CFIF IsDefined("url.no_menu")>
					<td>
						<INPUT TYPE="image" src="/images/btn_print.gif" NAME="print" VALUE="Print" onClick="javascript:window.print();"></form>
					</td>
					<td>
						<INPUT TYPE="submit" NAME="list" VALUE=" Close " onClick="javascript:window.close();"></form>
					</td>
					<cfelse>
						<cfoutput>
							<td colspan="2">
								<table border="0" width="100%">
									<tr>
										<td align="center" style="vertical-align:top"><form><input type="button" name="print" value=" Print Screen" onClick="javascript:void window.open('report_piw.cfm?no_menu=1&project_code=#session.project_code#','t','width=600,height=screen.availHeight,menubar=yes,scrollbars=yes,status=yes,toolbar=no,resizable=yes');"></form></td>
										<td align="center" style="vertical-align:top"><form><input type="button" name="print" value=" View PDF In Browser " onClick="javascript:void window.open('piw_report_to_pdf.cfm?no_menu=1&project_code=#session.project_code#','t','menubar=no,scrollbars=yes,status=yes,toolbar=yes,location=yes,resizable=yes');"></form> </td>
										<td align="center" style="vertical-align:top"><form><input type="button" name="print" value=" Email PDF " onClick="javascript:void window.open('piw_report_pdf_emailpopup.cfm?no_menu=1&project_code=#session.project_code#','t','width=650,height=500,menubar=no,scrollbars=yes,location=yes,status=yes,toolbar=no,resizable=yes');"></form></td>
									</tr>
								</table>
							</td>
						</cfoutput>
					</CFIF>

			  </tr>
			</cfif> --->
		</table>
   </td>
  </tr>
</table>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">


