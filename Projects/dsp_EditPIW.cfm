
<cfoutput>
<cfform name="editsection" action="act_EditPIW.cfm?Section=#url.section#" method="POST" enctype="multipart/form-data">
<input type="hidden" name="projectCode" value="#Session.Project_code#">
<input type="hidden" name="section" value="#url.section#">
<!--- contact info section ---> 
<b style="color:##ff0000;">* Required Fields</b>
<cfswitch expression="#url.section#">
  <cfcase value="1">
     <a name="sec1"></a>
		 <table border="0" cellpadding="3" cellspacing="1" width="100%" bgcolor="##666666">
			
			<tr>
				<td width="40%" bgcolor="##eeeeee"><b>Client Code:</b></td>
				<td bgcolor="##f7f7f7">#qpiw.client_code#</td>
			</tr>
			<cfset getStatus = request.util.getProjStatusCodes()>
			<tr>
				<td bgcolor="##eeeeee"><b>Project Status:</b><b style="color:##ff0000;">*</b></td>
				<td bgcolor="##f7f7f7"><select name="ProjStatus">
				       <cfloop query="getStatus">
				        <option value="#getStatus.codevalue#" <cfif getStatus.codevalue EQ qpiw.projstatus> Selected</cfif>>#getStatus.codeDesc#</option>
				       </cfloop>
				    </select></td>
			</tr>
			<cfset getCorp = request.util.getCompany()>
			<tr>
				<td bgcolor="##eeeeee"><b>Selling Corporation:</b><b style="color:##ff0000;">*</b></td>
				<td bgcolor="##f7f7f7"><select name="corpName">
				       <option value="">-- Select One --</option>
				       <cfloop query="getCorp">
				        <option value="#getCorp.Corp_id#" <cfif getCorp.Corp_ID EQ qpiw.corp_id> Selected</cfif>>#getCorp.Corp_Value#</option>
				       </cfloop>
				    </select></td>
			</tr>
			<cfif qpiw.account_exec NEQ "">
				<cfset ae = qpiw.account_exec>
			<cfelse>
				<cfset ae = 0>
			</cfif>
			<cfset getAllAE = request.Project.getSalesRep()>
			<cfset qAE = request.Project.getSalesRep(ae)>
			
			<tr>
				<td bgcolor="##eeeeee"><b>Account Executive:</b><b style="color:##ff0000;">*</b></td>
				<td bgcolor="##f7f7f7"><select name="accountExec">
				       <option value="">-- Select One --</option>
				       <cfloop query="getAllAE">
				        <option value="#getAllAE.ID#" <cfif ae EQ getAllAE.ID>Selected</cfif>>#getAllAE.repfirstname# #getAllAE.replastname#</option>
				       </cfloop>
				    </select>
				</td>
			</tr>
			<cfif qpiw.account_supr NEQ "">
				<cfset as = qpiw.account_supr>
			<cfelse>
				<cfset as = 0>
			</cfif>
			<!--- Get Account Supervisor--->
			<cfset GetAllSupervisor =  request.Project.getSalesRep(ShowOnlySupervisor=true)>
			<cfset qaccount_supr =  request.Project.getSalesRep(as)>
			<tr>
				<td bgcolor="##eeeeee"><b>Account Supervisor:</b><b style="color:##ff0000;">*</b></td>
				<td bgcolor="##f7f7f7"><select name="accountSupervisor">
				       <option value="">-- Select One --</option>
				       <cfloop query="GetAllSupervisor">
				        <option value="#GetAllSupervisor.ID#" <cfif GetAllSupervisor.ID EQ qaccount_supr.ID>Selected</cfif>>#GetAllSupervisor.repfirstname# #GetAllSupervisor.replastname#</option>
				       </cfloop>
				    </select>
				</td>
			</tr>
			<cfset GetAllClients = request.Project.getClients()>
			<tr>
				<td bgcolor="##eeeeee"><b>Client:</b><b style="color:##ff0000;">*</b></td>
				<td bgcolor="##f7f7f7"><select name="Client">
				       <option value="">-- Select One --</option>
				       <cfloop query="GetAllClients">
				        <option value="#GetAllClients.ID#" <cfif GetAllClients.ID EQ qpiw.clientID>Selected</cfif>>#GetAllClients.client_name#</option>
				       </cfloop>
				    </select>
				
				</td>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>Product:</b><b style="color:##ff0000;">*</b></td>
				<td bgcolor="##f7f7f7"><cfinput type="text" passthrough='id="product" style="font-size:11px;"' name="Product" value="#Trim(qpiw.product)#" size="25" maxlength="50"></td>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>Guide Topic/Headline:</b><b style="color:##ff0000;">*</b></td>
				<td bgcolor="##f7f7f7"><textarea name="guidetopic" cols="50" rows="2" style="font-family:verdana; font-size:11px" wrap="virtual" onKeyUp="if (this.value.length > 200) { alert('200 chars max'); this.value = this.value.substring(0,199); }">#trim(qpiw.guide_topic)#</textarea></td>
			</tr>
	
			<tr>
				<td bgcolor="##eeeeee"><b>Recruit Start Date:</b><b style="color:##ff0000;">*</b></td>
				<td bgcolor="##f7f7f7"><cfinput type="text" passthrough='id="recstart" style="font-size:11px;"' name="recruitstart" value="#DateFormat(qpiw.recruit_start, 'mm/dd/yyyy')#" size="10" maxlength="10" required="yes" message="You must include the Recruiting start date">&nbsp;<img src="/images/btn_formcalendar.gif" id="recstartbtn" border="0" alt="Click to view calendar" onclick="Calendar.setup({inputField:'recstart' ,ifFormat:'%m/%d/%Y',showsTime:false,button:'recstartbtn',singleClick:true,step:1})"></td>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>Projected Program Start Date:</b><b style="color:##ff0000;">*</b></td>
				<td bgcolor="##f7f7f7"><cfinput type="text" passthrough='id="projprogramstart" style="font-size:11px;"' name="ProjProgramStart" value="#DateFormat(qpiw.proj_program_start, 'mm/dd/yyyy')#" size="10" maxlength="10" required="yes" message="You must include the projected start date">&nbsp;<img src="/images/btn_formcalendar.gif" id="projstartbtn" border="0" alt="Click to view calendar" onclick="Calendar.setup({inputField:'projprogramstart' ,ifFormat:'%m/%d/%Y',showsTime:false,button:'projstartbtn',singleClick:true,step:1})"></td>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>Actual Program Start Date:</b></td>
				<td bgcolor="##f7f7f7"><cfinput type="text" name="ActualProgramStart" passthrough='id="accprogramstart" style="font-size:11px;"' value="#DateFormat(qpiw.program_start, 'mm/dd/yyyy')#" size="10" maxlength="10">&nbsp;<img src="/images/btn_formcalendar.gif" id="programstartbtn" border="0" alt="Click to view calendar" onclick="Calendar.setup({inputField:'accprogramstart' ,ifFormat:'%m/%d/%Y',showsTime:false,button:'programstartbtn',singleClick:true,step:1})"></td>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>Program End Date:</b><b style="color:##ff0000;">*</b></td>
				<td bgcolor="##f7f7f7"><cfinput type="text" name="ProgramEnd" passthrough='id="projprogramend" style="font-size:11px;"' value="#DateFormat(qpiw.program_end, 'mm/dd/yyyy')#" size="10" maxlength="10">&nbsp;<img src="/images/btn_formcalendar.gif" id="programendbtn" border="0" alt="Click to view calendar" onclick="Calendar.setup({inputField:'projprogramend' ,ifFormat:'%m/%d/%Y',showsTime:false,button:'programendbtn',singleClick:true,step:1})"></td>
			</tr>
			<cfset getAllRecruiters = request.Project.getRecruiter()>
			
			<tr>
				<td bgcolor="##eeeeee"><b>Recruiting Company:</b><b style="color:##ff0000;">*</b></td>
				<td bgcolor="##f7f7f7"><select name="Recruiter">
				     <option value="">-- Select One --</option>
				     <cfloop query="getAllRecruiters">
					   <option value="#getAllRecruiters.ID#" <cfif trim(getAllRecruiters.recruiter_name) EQ trim(qpiw.recruiter_name)>Selected</cfif>>#getAllRecruiters.recruiter_name#</option>
					 </cfloop>
				   </select></td>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>Recruiting Company Phone:</b></td>
				<cfif len(trim(qpiw.recruiting_company_phone)) EQ 10>
					<cfset recruitingPhone = "(#Left(qpiw.recruiting_company_phone,3)#) #Mid(qpiw.recruiting_company_phone,4,3)#-#Mid(qpiw.recruiting_company_phone,7,11)#">
				<cfelseif len(trim(qpiw.recruiting_company_phone)) LT 10>
				    <cfset recruitingPhone = qpiw.recruiting_company_phone>
				<cfelse>
					<cfset recruitingPhone = ""> 
				</cfif>	
				<td bgcolor="##f7f7f7"><input type="text" name="RecruiterPhone" value="#trim(recruitingPhone)#" size="16" maxlength="16"></td>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>Call Program:</b></td>
				<td bgcolor="##f7f7f7"><input type="checkbox" name="CallIn" value="1" <cfif qpiw.call_inbound EQ 1>checked</cfif>> Call In<br>
					<input type="checkbox" name="CallOut" value="1" <cfif qpiw.call_outbound EQ 1>checked</cfif>> Call Out<br>
				</td>
			</tr>
			<cfset getAllConfCompany = request.Project.getConfCompany()>
			
			<tr>
				<td bgcolor="##eeeeee"><b>Conference Company:</b><b style="color:##ff0000;">*</b></td>
				<td bgcolor="##f7f7f7"><select name="ConfCompany">
				     <option value="">-- Select One --</option>
				     <cfloop query="getAllConfCompany">
					   <option value="#getAllConfCompany.ID#" <cfif trim(getAllConfCompany.conf_company_name) EQ trim(qpiw.conf_company_name)>Selected</cfif>>#getAllConfCompany.conf_company_name#</option>
					 </cfloop>
				   </select>
				</td>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>800## Helpline/Disconnect:</b></td>
							<cfif len(trim(qpiw.helpline)) EQ 10>
					<cfset helpPhone = "(#Left(qpiw.helpline,3)#) #Mid(qpiw.helpline,4,3)#-#Mid(qpiw.helpline,7,11)#">
				<cfelseif len(trim(qpiw.helpline)) LT 10>
				    <cfset helpPhone = qpiw.helpline>
				<cfelse>
					<cfset helpPhone = ""> 
				</cfif>	
				<td bgcolor="##f7f7f7"><input type="text" name="helpline" value="#trim(helpPhone)#" size="16" maxlength="16"></td>
			</tr>
			<cfset getAllguidewriters =  request.Project.getGuideWriter()> 
			<cfset qguidewriters =  request.Project.getGuideWriter(session.project_code)> 
		
			<tr>
				<td bgcolor="##eeeeee"><b>Guide Writer:</b></td>
				<td bgcolor="##f7f7f7"><select name="GuideWriter">
				     <option value="">-- Select One --</option>
				     <cfloop query="getAllguidewriters">
					   <option value="#getAllguidewriters.GuideWriterID#" <cfif getAllguidewriters.GuideWriterID EQ qguidewriters.GuideWriterID>Selected</cfif>>#getAllguidewriters.first_Name# #getAllguidewriters.last_name#</option>
					 </cfloop>
				   </select>
				</td>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>Speaker ListenIn:</b></td>
				<cfif len(trim(qpiw.speaker_listenins)) EQ 10>
					<cfset speakerListenIn = "(#Left(qpiw.speaker_listenins,3)#) #Mid(qpiw.speaker_listenins,4,3)#-#Mid(qpiw.speaker_listenins,7,11)#">
				<cfelseif len(trim(qpiw.speaker_listenins)) LT 10>
				    <cfset speakerListenIn = qpiw.speaker_listenins>
				<cfelse>
					<cfset speakerListenIn = ""> 
				</cfif>	
				<td bgcolor="##f7f7f7"><input type="text" name="speakerListenIn" value="#trim(speakerListenIn)#" size="16" maxlength="16"></td>
			</tr>
			<tr>
			  <td colspan="2"  bgcolor="##ffffff" align="center"><input type="submit" name="submit" value="Save >>"></td>
			</tr>
		</table> 
  </cfcase>
  
  <cfcase value="2">
	  <a name="sec2"></a>
	   <table border="0" cellpadding="3" cellspacing="1" width="100%" bgcolor="##666666">
	     <!--- **************************************
		      project/program section
		  *************************************** --->
			<cfset meeting_type_code = request.Project.getMeetingTypeCode(session.project_code)>
			<cfset AllMeetingCodes = request.Project.getAllMeetingTypeCode(session.project_code)>
			
			<tr>
				<td bgcolor="##eeeeee" width="40%"><b>Meeting Type:</b></td>
				<td bgcolor="##f7f7f7">#meeting_type_code.meeting_type_value# - #meeting_type_code.meeting_type_description#
					<!--- <cfif meeting_type EQ 99>&nbsp;&nbsp;*#meeting_other_notes#</cfif> --->
				</td>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>Particpants Per Program:</b><b style="color:##ff0000;">*</b></td>
				<td bgcolor="##f7f7f7"><input type="text" name="programParticpants" value="#Trim(qpiw.prog_participants)#" size="4" maxlength="5"></td>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>## of Meetings per Project:</b><b style="color:##ff0000;">*</b></td>
				<td bgcolor="##f7f7f7"><input type="text" name="MeetingNumber" value="#Trim(qpiw.num_meetings)#" size="4" maxlength="5"></td>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>Meeting Participant Target:</b><b style="color:##ff0000;">*</b></td>
				<td bgcolor="##f7f7f7"><input type="text" name="TargetParticipant" value="#Trim(qpiw.participant_target)#" size="5" maxlength="6"></td>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>Meeting Participant Recruit:</b><b style="color:##ff0000;">*</b></td>
				<td bgcolor="##f7f7f7"><input type="text" name="ParticipantRecruit" value="#Trim(qpiw.participant_recruit)#" size="5" maxlength="6"></td>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>Length of Program:</b><b style="color:##ff0000;">*</b></td>
				<td bgcolor="##f7f7f7"><input type="text" name="ProgLengthHrs" value="#Trim(qpiw.prog_length_hr)#" size="2" mexlength="2"> Hours&nbsp;&nbsp;<input type="text" name="ProgLengthMin" value="#Trim(qpiw.prog_length_min)#" size="2" mexlength="2"> Minutes</td>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>Special Notes:</b></td>
				<td bgcolor="##f7f7f7"><input type="text" name="SpecialNotes" value="#trim(qpiw.special_notes)#" size="50" maxlength="500"></td>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>Target Audience:</b></td>
				<td bgcolor="##f7f7f7"><input type="text" name="TargetAudience" value="#trim(qpiw.target_audience)#" size="50" maxlength="500"></td>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>CME Accredited:</b></td>
				<td bgcolor="##f7f7f7"><input type="radio" name="CMEAccredited" value="1" <cfif qpiw.cme_accredited EQ 1>checked</cfif>> Yes&nbsp;&nbsp;<input type="radio" name="CMEAccredited" value="0" <cfif qpiw.cme_accredited EQ 0>checked</cfif>> No</td>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>CME Accredited Organization:</b></td>
				<td bgcolor="##f7f7f7"><input type="text" name="CMEOrg" value="#trim(qpiw.cme_org)#" size="50" maxlength="50"></td>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>Type of Promotion:</b></td>
				<td bgcolor="##f7f7f7">
				  <table border="0" cellpadding="3" cellspacing="0" width="100%">
					 <tr>
				        <td><input type="checkbox" name="PromoDirectMail" value="1" <cfif qpiw.promo_direct_mail EQ 1>checked</cfif>> Direct Mail</td>
						<td width="5">&nbsp;</td>
						<td><strong>Date Sent:</strong>
						<cfinput type="text" 
						   name="promoDirectMailDate" 
						   passthrough='id="directmaildate" 
						   style="font-size:11px;"' 
						   value="#DateFormat(qpiw.promo_direct_mail_date, 'mm/dd/yyyy')#" 
						   size="10" maxlength="10">&nbsp;
						   <img src="/images/btn_formcalendar.gif" 
						     id="directmailbtn" 
							 border="0" 
							 alt="Click to view calendar" 
							 onclick="Calendar.setup({inputField:'directmaildate' ,ifFormat:'%m/%d/%Y',showsTime:false,button:'directmailbtn',singleClick:true,step:1})"></td>
				     </tr>
					 <tr>
				        <td><input type="checkbox" name="PromoRepNom" value="1" <cfif qpiw.promo_rep_nom EQ 1>checked</cfif>> Rep Nomination</td>
						<td width="5">&nbsp;</td>
						<td><strong>Date Sent:</strong>
						<cfinput type="text" 
						    name="promorepnomdate" 
							passthrough='id="promorepnomdate" 
							style="font-size:11px;"' 
							value="#DateFormat(qpiw.promo_rep_nom_date, 'mm/dd/yyyy')#" 
							size="10" maxlength="10">&nbsp;
							<img src="/images/btn_formcalendar.gif" 
							    id="promorepnombtn" 
								border="0" 
								alt="Click to view calendar" 
								onclick="Calendar.setup({inputField:'promorepnomdate' ,ifFormat:'%m/%d/%Y',showsTime:false,button:'promorepnombtn',singleClick:true,step:1})">
						</td>
				     </tr>
					 <tr>
				        <td><input type="checkbox" name="PromoFax" value="1" <cfif qpiw.promo_fax EQ 1>checked</cfif>> Fax</td>
						<td width="5">&nbsp;</td>
						<td><strong>Date Sent:</strong> 
						
						<cfinput type="text" 
						    name="promofaxdate" 
							passthrough='id="promofaxdate" 
							style="font-size:11px;"' 
							value="#DateFormat(qpiw.promo_fax_date, 'mm/dd/yyyy')#" 
							size="10" maxlength="10">&nbsp;
							<img src="/images/btn_formcalendar.gif" 
							    id="promofaxbtn" 
								border="0" 
								alt="Click to view calendar" 
								onclick="Calendar.setup({inputField:'promofaxdate' ,ifFormat:'%m/%d/%Y',showsTime:false,button:'promofaxbtn',singleClick:true,step:1})">
						</td>
				     </tr>
					 <tr>
				        <td><input type="checkbox" name="PromoOther" value="1" <cfif qpiw.promo_other EQ 1>checked</cfif>> Other</td>
						<td width="5">&nbsp;</td>
						<td><strong>Date Sent:</strong> 
						<cfinput type="text" 
						    name="promootherdate" 
							passthrough='id="promootherdate" 
							style="font-size:11px;"' 
							value="#DateFormat(qpiw.promo_other_date, 'mm/dd/yyyy')#" 
							size="10" maxlength="10">&nbsp;
							<img src="/images/btn_formcalendar.gif" 
							    id="promootherbtn" 
								border="0" 
								alt="Click to view calendar" 
								onclick="Calendar.setup({inputField:'promootherdate' ,ifFormat:'%m/%d/%Y',showsTime:false,button:'promootherbtn',singleClick:true,step:1})">
					     </td>
				     </tr>
				   </table>           
				</td>
			</tr>
			<tr>
			    <td bgcolor="##eeeeee"><b>Other Promotion Notes:</b></td>
			    <td bgcolor="##f7f7f7"><input type="text" name="PromoOtherDesc" value="#trim(qpiw.promo_other_descrip)#" size="40" maxlength="80"></td></tr>
			<tr>
				<td bgcolor="##eeeeee"><b>Other Materials to Be Included with Guidebook:</b></td>
				<td bgcolor="##f7f7f7"><input type="text" name="GuideBook" value="#trim(qpiw.guidebook_include)#" size="50" maxlength="500"></td>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>Confirmation Letter:</b></td>
				<td bgcolor="##f7f7f7"><input type="radio" name="LetterConfirmation" value="1" <cfif qpiw.letter_confirmation EQ 1>checked</cfif>> Yes&nbsp;&nbsp;<input type="radio" name="LetterConfirmation" value="0" <cfif qpiw.letter_confirmation EQ 0>checked<cfelseif qpiw.letter_confirmation EQ "">checked</cfif>> No</td>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>Thank You Letter:</b></td>
				<td bgcolor="##f7f7f7"><input type="radio" name="LetterThankYou" value="1" <cfif qpiw.letter_thankyou EQ 1>checked</cfif>> Yes&nbsp;&nbsp;<input type="radio" name="LetterThankYou" value="0" <cfif qpiw.letter_thankyou EQ 0>checked<cfelseif qpiw.letter_thankyou EQ "">checked</cfif>> No</td>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>Product Information:</b></td>
				<td bgcolor="##f7f7f7"><input type="radio" name="ProductInformation" value="1" <cfif qpiw.PI EQ 1>checked</cfif>> Yes&nbsp;&nbsp;<input type="radio" name="ProductInformation" value="0" <cfif qpiw.PI EQ 0>checked<cfelseif qpiw.PI EQ "">checked</cfif>> No</td>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>Fax Info Sheet:</b></td>
				<td bgcolor="##f7f7f7"><input type="radio" name="LetterFaxInfo" value="1" <cfif qpiw.letter_faxinfosheet EQ 1>checked</cfif>> Yes&nbsp;&nbsp;<input type="radio" name="LetterFaxInfo" value="0" <cfif qpiw.letter_faxinfosheet EQ 0>checked<cfelseif qpiw.letter_faxinfosheet EQ "">checked</cfif>> No</td>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>Other:</b></td>
				<td bgcolor="##f7f7f7"><input type="radio" name="LetterOther" value="1" <cfif qpiw.letter_other EQ 1>checked</cfif>> Yes&nbsp;&nbsp;<input type="radio" name="LetterFaxInfo" value="0" <cfif qpiw.letter_other EQ 0>checked<cfelseif qpiw.letter_other EQ "">checked</cfif>> No</td>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>Other Notes for Confirmation:</b></td>
				<td bgcolor="##f7f7f7"><input type="text" name="OtherNotesConfirm" value="#trim(qpiw.letter_other_description)#" size="50" maxlength="200"></td>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>Materials to Recruiter:</b></td>
				<td bgcolor="##f7f7f7">
							<cfinput type="text" 
						    name="guidebooktorecruiter" 
							passthrough='id="guidebooktorecruiter" 
							style="font-size:11px;"' 
							value="#DateFormat(qpiw.guidebook_to_recruiter, 'mm/dd/yyyy')#" 
							size="10" maxlength="10">&nbsp;
							<img src="/images/btn_formcalendar.gif" 
							    id="materialstoecbtn" 
								border="0" 
								alt="Click to view calendar" 
								onclick="Calendar.setup({inputField:'guidebooktorecruiter' ,ifFormat:'%m/%d/%Y',showsTime:false,button:'materialstoecbtn',singleClick:true,step:1})">
              </td>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>Speaker Names and Compensation:</b></td>
				<td bgcolor="##f7f7f7"><input type="text" name="SpeakerNotes" value="#qpiw.speaker_notes#" size="50" maxlength="200"></td>
			</tr>
			<!--- get Honoraria Type --->
			  <cfset getHonorariaType = request.Project.getHonorariaType()>
			<tr>
				<td bgcolor="##eeeeee"><b>Attendee Honorarium Amt:</b><b style="color:##ff0000;">*</b></td>
				<td bgcolor="##f7f7f7">
				   <table border="0" cellpadding="4" cellspacing="0">
                      <tr>
                          <td><input type="text" name="attendeeHonoraria" value="#DollarFormat(qpiw.attendee_comp)#" size="12" maxlength="12"></td>
						  <td><select name="HonorariaType">
						       <cfloop query="getHonorariaType">
						        <option value="#getHonorariaType.honoraria_id#" <cfif qpiw.attendee_comp_type_id EQ getHonorariaType.honoraria_id>Selected</cfif>>#getHonorariaType.honoraria_name#</option>
						       </cfloop> 
							  </select></td>
				      </tr>
				   </table>           
			   </td>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>Survey Compensation:</b><b style="color:##ff0000;">*</b></td>
				<td bgcolor="##f7f7f7">
				   <table border="0" cellpadding="4" cellspacing="0">
                      <tr>
                          <td><input type="text" name="surveyComp" value="#DollarFormat(qpiw.survey_comp)#" size="12" maxlength="12"></td>
						  <td><select name="SurveyCompType">
						       <cfloop query="getHonorariaType">
						        <option value="#getHonorariaType.honoraria_value#" <cfif qpiw.survey_comp_type EQ getHonorariaType.honoraria_value>Selected</cfif>>#getHonorariaType.honoraria_name#</option>
						       </cfloop> 
							  </select></td>
				      </tr>
				   </table> 
				</td>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>Survey To Be Included:</b></td>
				<td bgcolor="##f7f7f7"><input type="radio" name="IncludeSurvey" value="1" <cfif qpiw.include_survey EQ 1>checked</cfif>> Yes&nbsp;&nbsp;<input type="radio" name="IncludeSurvey" value="0" <cfif qpiw.include_survey EQ 0>checked</cfif>> No</td>
			</tr>
			<tr>
			  <td colspan="2" bgcolor="##ffffff" align="center"><input type="submit" name="submit" value="Save >>"></td>
			</tr>
        </table> 
	 </cfcase>
	 <cfcase value="3">
	 <a name="sec3"></a>
	   <table border="0" cellpadding="3" cellspacing="1" width="100%" bgcolor="##666666">
	 <!--- reporting needs section --->
	     <tr>
		    <td bgcolor="##eeeeee" width="40%"><b>Online Report Heading:</b></td>
				<td bgcolor="##f7f7f7"><input type="text" name="onlinereport" value="#trim(qpiw.online_report_heading)#" size="25" maxlength="50"> <em style="color:##777;">(50 character max)</em></td>
				
		 </tr>
         <tr>
				<td bgcolor="##eeeeee" width="40%"><b>Written Summary Reports:</b></td>
				<td bgcolor="##f7f7f7">
				<input type="checkbox" name="SummaryWeekly" value="1" <cfif qpiw.summary_weekly EQ 1>checked</cfif>>&nbsp;Weekly<br>
				<input type="checkbox" name="SummaryMonthly" value="1" <cfif qpiw.summary_monthly EQ 1>checked</cfif>>&nbsp;Monthly<br>
				<input type="checkbox" name="SummaryOther" value="1" <cfif qpiw.summary_other EQ 1>checked</cfif>>&nbsp;Other<br>
				</td>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>Notes for Written Reporting:</b></td>
				<td bgcolor="##f7f7f7"><input type="text" name="summaryOtherDesc" value="#Trim(qpiw.summary_other_descrip)#" size="50" maxlength="255"></td>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>Voice Mail Reporting To:</b></td>
				<td bgcolor="##f7f7f7">
				    <input type="checkbox" name="VmailRepMgr" value="1" <cfif qpiw.vm_mgrs EQ 1>checked</cfif>>&nbsp;Managers<br>
					<input type="checkbox" name="VmailRepReps" value="1" <cfif qpiw.vm_reps EQ 1>checked</cfif>>&nbsp;Reps<br>
					<input type="checkbox" name="VmailRepOthr" value="1" <cfif qpiw.vm_other EQ 1>checked</cfif>>&nbsp;Other<br>
				</td>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>Notes for Voice Mail Reporting:</b></td>
				<td bgcolor="##f7f7f7"><input type="text" name="VmailRepOtherDesc" value="#Trim(qpiw.vm_other_descrip)#" size="50" maxlength="255"></td>
			</tr>
			<!--- <tr>
				<td bgcolor="##eeeeee"><b>Special Voice Mail Reporting:</b></td>
				<td bgcolor="##f7f7f7"><input type="text" name="VmailSpecialDesc" value="#trim(qpiw.vm_special)#" size="50" maxlength="255"></td>
			</tr> --->
			<tr>
				<td bgcolor="##eeeeee"><b>E-Mail Reporting To:</b></td>
				<td bgcolor="##f7f7f7">
				  <input type="checkbox" name="emailRepMgr" value="1" <cfif qpiw.email_mgrs EQ 1>checked</cfif>>&nbsp;Managers<br>
					<input type="checkbox" name="emailRepReps" value="1" <cfif qpiw.email_reps EQ 1>checked</cfif>>&nbsp;Reps<br>
					<input type="checkbox" name="emailRepOthr" value="1" <cfif qpiw.email_other EQ 1>checked</cfif>>&nbsp;Other<br>
				</td>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>Notes for E-Mail Reporting:</b></td>
				<td bgcolor="##f7f7f7"><input type="text" name="emailOtherDesc" value="#trim(qpiw.email_other_descrip)#" size="50" maxlength="255"></td>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>Client Toll Free ## for Moderators to Conduct VM:</b></td>
				<cfif len(trim(qpiw.client_toll_free)) EQ 10>
					<td bgcolor="##f7f7f7"><input type="text" name="ClientTollFree" value="(#Left(qpiw.client_toll_free,3)#)#Mid(qpiw.client_toll_free,4,3)#-#Mid(qpiw.client_toll_free,7,11)#" size="15" maxlength="15"></td>
				<cfelse>
				    <td bgcolor="##f7f7f7"><input type="text" name="ClientTollFree" value="#trim(qpiw.client_toll_free)#" size="15" maxlength="15"></td>
				</cfif>
			</tr>
			<tr>
				<td bgcolor="##eeeeee"><b>Special Reporting:</b></td>
				<td bgcolor="##f7f7f7"><input type="text" name="SpecialReportingDesc" value="#trim(qpiw.special_report)#" size="50" maxlength="255"></td>
			</tr> 
			<tr>
			  <td colspan="2" align="center" bgcolor="##ffffff"><input type="submit" name="submit" value="Save >>"></td>
			</tr>
		 </table>  	
	 </cfcase>
	 
	 <cfcase value="4">
	 <a name="sec4"></a>
	   <table border="0" cellpadding="3" cellspacing="1" width="100%" bgcolor="##666666">
	       <tr>
			 <td bgcolor="##eeeeee" width="40%"><b>Initial Submission Date to<br>
			                           Creative Services Dept for the Following:</b>
			 </td>
			 <td bgcolor="##f7f7f7">
			   <table border="0" cellpadding="0" cellspacing="0" width="100%">
                 <tr>
                    <td>Moderator Discussion Guide</td>
					<!--- <td><input type="text" name="ModDiscGuideDate" value="#DateFormat(moderator_guide_date, 'mm/dd/yyyy')#" size="12" maxlength="15"> </td> --->
                    <td><cfinput type="text" name="ModDiscGuideDate" passthrough='id="ModDiscGuideDate" style="font-size:11px;"' value="#DateFormat(qpiw.moderator_guide_date, 'mm/dd/yyyy')#" size="10" maxlength="10">&nbsp;<img src="/images/btn_formcalendar.gif" id="modguidebtn" border="0" alt="Click to view calendar" onclick="Calendar.setup({inputField:'ModDiscGuideDate' ,ifFormat:'%m/%d/%Y',showsTime:false,button:'modguidebtn',singleclick:true,step:1})"></td>
				 </tr>
				 <tr>
                    <td>Admin Materials</td>
					<!--- <td><input type="text" name="AdminMaterialsDate" value="#DateFormat(admin_materials_date, "mm/dd/yyyy")#" size="12" maxlength="15"></td> --->
                    <td><cfinput type="text" name="AdminMaterialsDate" passthrough='id="AdminMaterialsDate" style="font-size:11px;"' value="#DateFormat(qpiw.admin_materials_date, 'mm/dd/yyyy')#" size="10" maxlength="10">&nbsp;<img src="/images/btn_formcalendar.gif" id="adminguidebtn" border="0" alt="Click to view calendar" onclick="Calendar.setup({inputField:'AdminMaterialsDate' ,ifFormat:'%m/%d/%Y',showsTime:false,button:'adminguidebtn',singleclick:true,step:1})"></td>
				 </tr>
				 <tr>
                    <td>Participant Guidebook</td>
					<!--- <td><input type="text" name="GuidebookDate" value="#DateFormat(guidebook_date, "mm/dd/yyyy")#" size="12" maxlength="15"></td> --->
                    <td><cfinput type="text" name="GuidebookDate" passthrough='id="GuidebookDate" style="font-size:11px;"' value="#DateFormat(qpiw.guidebook_date, 'mm/dd/yyyy')#" size="10" maxlength="10">&nbsp;<img src="/images/btn_formcalendar.gif" id="guidebookbtn" border="0" alt="Click to view calendar" onclick="Calendar.setup({inputField:'GuidebookDate' ,ifFormat:'%m/%d/%Y',showsTime:false,button:'guidebookbtn',singleclick:true,step:1})"></td>
				 </tr>
				 <tr>
                    <td>Components</td>
					<!--- <td><input type="text" name="ComponentsDate" value="#DateFormat(components_date, "mm/dd/yyyy")#" size="12" maxlength="15"></td> --->
                    <td><cfinput type="text" name="ComponentsDate" passthrough='id="ComponentsDate" style="font-size:11px;"' value="#DateFormat(qpiw.components_date, 'mm/dd/yyyy')#" size="10" maxlength="10">&nbsp;<img src="/images/btn_formcalendar.gif" id="comdatebtn" border="0" alt="Click to view calendar" onclick="Calendar.setup({inputField:'ComponentsDate' ,ifFormat:'%m/%d/%Y',showsTime:false,button:'comdatebtn',singleclick:true,step:1})"></td>
				 </tr>
               </table>           
			 </td>
		   </tr>
		   <tr>
			 <td bgcolor="##eeeeee"><b>Guidebook Instructions:</b></td>
			 <td bgcolor="##f7f7f7"><input type="Checkbox" name="guidebooknew" value="1" <cfif qpiw.guidebook_new EQ 1>Checked</cfif>> New&nbsp;&nbsp;<input type="Checkbox" name="guidebookRevised" value="1"> Revised&nbsp;&nbsp;<input type="Checkbox" name="guidebookcharts" value="1"> Charts from Client&nbsp;&nbsp;
			 </td>
		   </tr>
		   <tr>
			 <td bgcolor="##eeeeee"><b>Revisions on Guidebook:</b></td>
			 <td bgcolor="##f7f7f7"><input type="Checkbox" name="GuideBookReviseWording" value="1"> Update Wording&nbsp;&nbsp;<input type="Checkbox" name="guidebookChartRevised" value="1"> Revise Charts&nbsp;&nbsp;<input type="Checkbox" name="guidebooknewcharts" value="1"> Create New Charts&nbsp;&nbsp;
			   <cfif qpiw.revise_wording EQ 1>update wording</cfif>
			   <cfif qpiw.revise_charts EQ 1>
			       <cfif qpiw.revise_wording EQ 1>,&nbsp;</cfif>
				   revisions on charts</cfif>
				   <cfif qpiw.new_charts EQ 1>
				      <cfif qpiw.revise_wording EQ 1 or qpiw.revise_charts EQ 1>,&nbsp;</cfif>
					    creation of new charts
				   </cfif>
			 </td>
		   </tr>
		   <tr>
			 <td bgcolor="##eeeeee"><b>Special Instructions for Creative Services:</b></td>
			 <td bgcolor="##f7f7f7"><input type="text" name="SpecialInstructions" value="#trim(qpiw.special_instructions)#" size="50" maxlength="255"></td>
		   </tr>
		   <tr>
			 <td colspan="2" align="center" bgcolor="##ffffff"><input type="submit" name="submit" value="Save >>"></td>
		   </tr>
		 </table>  	
	 </cfcase>
	 <cfcase value="5">
	 <a name="sec5"></a>
	   <!--- <tr class="highlight2">


	
				   <tr>
					  <td><b>Allowed to participate in meetings:</b></td>
					  <td><cfif rep_nom EQ 1>Physicians who call in from Rep Nominations<br></cfif>
						  <cfif pa_ok EQ 1>Physician Assistants<br></cfif><cfif np_ok EQ 1>Nurse Practitioners<br></cfif>
						  <cfif other_ok EQ 1>Other&nbsp;- </cfif>#other_description#<br>
					  </td>
				   </tr> --->
	   <table border="0" cellpadding="3" cellspacing="1" width="100%" bgcolor="##666666">
	 <!--- reporting needs section --->
         <tr>
			<td bgcolor="##eeeeee" width="40%"><b>Will there be an initial recruitment mailing? Any subsequent mailings?:</b></td>
			<td bgcolor="##f7f7f7"><input type="text" name="RecruitMailingInfo" value="#Trim(qpiw.recruit_mailings_info)#" size="40" maxlength="255"></td>
		 </tr>
		 <tr>
			<td bgcolor="##eeeeee" width="40%"><b>Recruiting Strategy:</b></td>
			<td bgcolor="##f7f7f7"><input type="text" name="AddtionalInfo" value="#Trim(qpiw.additional_info)#" size="40" maxlength="255"></td>
		 </tr>
		 <tr>
			 <td bgcolor="##eeeeee" width="40%"><b>What are guidelines for physicians who are generated from direct mailers?:</b></td>
			 <td bgcolor="##f7f7f7"><input type="text" name="DirectMailInfo" value="#Trim(qpiw.direct_mailers_info)#" size="40" maxlength="255"></td>
		 </tr>
		 <tr>
			 <td bgcolor="##eeeeee" width="40%"><b>General Market/Drug Information for Recruiter:</b></td>
			 <td bgcolor="##f7f7f7"><input type="text" name="MrktDrugInfo" value="#Trim(qpiw.market_drug_info)#" size="40" maxlength="255"></td>
		 </tr>
		 <tr>
			 <td bgcolor="##eeeeee" width="40%"><b>General Market/Drug Information for <u>SCRIPT</u> for Recruiter:</b></td>
			 <td bgcolor="##f7f7f7"><input type="text" name="MrktDrugScript" value="#Trim(qpiw.market_drug_script)#" size="40" maxlength="255"></td>
		 </tr>	
		 <tr>
		   <td bgcolor="##eeeeee" width="40%"><b>Allowed to participate in meetings:</b></td>
		   <td bgcolor="##f7f7f7"><input type="checkbox" name="repnom" value="1" <cfif qpiw.rep_nom EQ 1>checked</cfif>>&nbsp;Physicians who call in from Rep Nominations<br>
			   <input type="checkbox" name="PAOK" value="1" <cfif qpiw.pa_ok EQ 1>checked</cfif>>&nbsp;Physician Assistants<br>
			   <input type="checkbox" name="NPOK" value="1" <cfif qpiw.np_ok EQ 1>checked</cfif>>&nbsp;Nurse Practitioners<br>
			   <input type="checkbox" name="OTHEROK" value="1" <cfif qpiw.other_ok EQ 1>checked</cfif>>&nbsp;Other&nbsp;<br>
			   
			   Other Desc: <input type="text" name="OtherDesc" value="#Trim(qpiw.other_description)#" size="40" maxlength="255">
		   </td>
		 </tr>  
	     <tr>
		   <td colspan="2" align="center" bgcolor="##ffffff"><input type="submit" name="submit" value="Save >>"></td>
	     </tr>
	   </table>  	
	 </cfcase>
	 <cfcase value="6">
	 <a name="sec6"></a>
	   <!--- <tr class="highlight2">


	
				   <tr>
					  <td><b>Allowed to participate in meetings:</b></td>
					  <td><cfif rep_nom EQ 1>Physicians who call in from Rep Nominations<br></cfif>
						  <cfif pa_ok EQ 1>Physician Assistants<br></cfif><cfif np_ok EQ 1>Nurse Practitioners<br></cfif>
						  <cfif other_ok EQ 1>Other&nbsp;- </cfif>#other_description#<br>
					  </td>
				   </tr> --->
	   <table border="0" cellpadding="3" cellspacing="1" width="100%" bgcolor="##666666">
	 <!--- reporting needs section --->
         <tr>
			<td bgcolor="##eeeeee" width="40%"><b>Comments:</b></td>
			<td bgcolor="##f7f7f7"></td>
		 </tr> 
	     <tr>
		   <td colspan="2" align="center" bgcolor="##ffffff"><input type="submit" name="submit" value="Save >>"></td>
	     </tr>
	   </table>  	
	 </cfcase>
   </cfswitch>	
 </cfform>
</cfoutput>