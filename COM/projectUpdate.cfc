<cfcomponent displayname="UpdateProject" hint="The Component Maintains the Project Tables" output="No">
   <!--- lock name is the name used to wrap file io/data ops --->
	<cfset LOCK_NAME = "projectUpdate_cfc">

	<!--- Constructor --->
	<cfset init()>
	
	<!--- Initialize datasources --->
	<cfset instance.projdsn = "PMS">
	
   <!---****************************
     Initialize the component 
	 *******************************--->
   <cffunction name="init" output="true" returnType="boolean" access="public"
				hint="Handles initialization.">
	      <cfset instance.initialized = true>
	      <cfreturn instance.initialized />
   </cffunction>
   
   <!---*****************************************
     Update the Project Information Worksheet Section 1
	 ****************************************--->
   <cffunction name="UpdatePIWSectionOne" access="public" returntype="string">
      <cfargument name="projectCode" type="string" required="Yes">
	  <cfargument name="ThisFormFields" type="struct" required="Yes">
	  
	 <cfset OktoCommit = true> 
	 <cfset Msg ="">
	 
	  <cftransaction action="BEGIN">
	    <cftry>
	      <cfquery name="UpdatePIW" datasource="#Instance.projDSN#">
		    Update PIW
			Set corp_id 			= <cfif Len(Trim(Arguments.ThisFormFields.CorpName)) GT 0><cfqueryparam value="#Arguments.ThisFormFields.CorpName#" cfsqltype="CF_SQL_Integer"><cfelse>NULL</cfif>,
			    project_status      = <cfif Len(Trim(Arguments.ThisFormFields.ProjStatus)) GT 0><cfqueryparam value="#Arguments.ThisFormFields.ProjStatus#" cfsqltype="CF_SQL_Integer"><cfelse>0</cfif>,
				account_exec 		= <cfif Len(Trim(Arguments.ThisFormFields.accountexec)) GT 0><cfqueryparam value="#Arguments.ThisFormFields.accountexec#" cfsqltype="CF_SQL_Integer"><cfelse>NULL</cfif>,
				account_supr 		= <cfif Len(Trim(Arguments.ThisFormFields.accountsupervisor)) GT 0><cfqueryparam value="#Arguments.ThisFormFields.accountsupervisor#" cfsqltype="CF_SQL_Integer"><cfelse>NULL</cfif>,
				client 				= <cfif Len(Trim(Arguments.ThisFormFields.client)) GT 0><cfqueryparam value="#Arguments.ThisFormFields.client#" cfsqltype="CF_SQL_Integer" null="no"><cfelse>NULL</cfif>,
				product 			= <cfif Len(Trim(Arguments.ThisFormFields.product)) GT 0><cfqueryparam value="#Arguments.ThisFormFields.product#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"><cfelse>NULL</cfif>,
				guide_topic 		= <cfif Len(Trim(Arguments.ThisFormFields.GuideTopic)) GT 0><cfqueryparam value="#Arguments.ThisFormFields.GuideTopic#" cfsqltype="CF_SQL_VARCHAR" maxlength="200"><cfelse>NULL</cfif>,
				recruit_start 		= <cfif Len(Trim(Arguments.ThisFormFields.recruitstart)) GT 0><cfqueryparam value="#Arguments.ThisFormFields.recruitstart#" cfsqltype="CF_SQL_DATE"><cfelse>NULL</cfif>,
				proj_program_start 	= <cfif Len(Trim(Arguments.ThisFormFields.ProjProgramStart)) GT 0><cfqueryparam value="#Arguments.ThisFormFields.ProjProgramStart#" cfsqltype="CF_SQL_DATE"><cfelse>NULL</cfif>,
				program_start 		= <cfif Len(Trim(Arguments.ThisFormFields.ActualProgramStart)) GT 0><cfqueryparam value="#Arguments.ThisFormFields.ActualProgramStart#" cfsqltype="CF_SQL_DATE"><cfelse>NULL</cfif>,
				program_end 		= <cfif Len(Trim(Arguments.ThisFormFields.ProgramEnd)) GT 0><cfqueryparam value="#Arguments.ThisFormFields.ProgramEnd#" cfsqltype="CF_SQL_DATE"><cfelse>NULL</cfif>,
				recruiting_company 	= <cfif Len(Trim(Arguments.ThisFormFields.Recruiter)) GT 0><cfqueryparam value="#Arguments.ThisFormFields.Recruiter#" cfsqltype="CF_SQL_INTEGER"><cfelse>NULL</cfif>,
				recruiting_company_phone = <cfif Len(Trim(Arguments.ThisFormFields.RecruiterPhone)) GT 0><cfqueryparam value="#ReplaceList(Arguments.ThisFormFields.RecruiterPhone, '(,),-, ,.,' , '')#" cfsqltype="CF_SQL_VARCHAR" maxlength="17"><cfelse>NULL</cfif>,
				call_inbound 		= <cfif IsDefined("Arguments.ThisFormFields.CallIn")><cfqueryparam value="#Arguments.ThisFormFields.CallIn#" cfsqltype="CF_SQL_BIT"><cfelse><cfqueryparam value="0" cfsqltype="CF_SQL_BIT"></cfif>,
				call_outbound 		= <cfif IsDefined("Arguments.ThisFormFields.CallOut")><cfqueryparam value="#Arguments.ThisFormFields.CallOut#" cfsqltype="CF_SQL_BIT"><cfelse><cfqueryparam value="0" cfsqltype="CF_SQL_BIT"></cfif>,
				conference_company 	= <cfif Len(Trim(Arguments.ThisFormFields.ConfCompany)) GT 0><cfqueryparam value="#Arguments.ThisFormFields.ConfCompany#" cfsqltype="CF_SQL_INTEGER"><cfelse>NULL</cfif>,
				helpline 			= <cfif Len(Trim(Arguments.ThisFormFields.helpline)) GT 0><cfqueryparam value="#ReplaceList(Arguments.ThisFormFields.helpline, '(,),-, ,.,' , '')#" cfsqltype="CF_SQL_VARCHAR" maxlength="15"><cfelse>NULL</cfif>,
				guide_writer 		= <cfif Len(Trim(Arguments.ThisFormFields.guidewriter)) GT 0><cfqueryparam value="#Arguments.ThisFormFields.guidewriter#" cfsqltype="CF_SQL_INTEGER"><cfelse>NULL</cfif>,
				speaker_listenins 	= <cfif Len(Trim(Arguments.ThisFormFields.speakerlistenin)) GT 0><cfqueryparam value="#ReplaceList(Arguments.ThisFormFields.speakerlistenin, '(,),-, ,.,' , '')#" cfsqltype="CF_SQL_VARCHAR" maxlength="17"><cfelse>NULL</cfif>
			Where project_code = <cfqueryparam value="#Arguments.ThisFormFields.projectCode#" cfsqltype="CF_SQL_VARCHAR" maxlength="20">
		  </cfquery>
	      
		  <cfquery name="UpdateStatus" datasource="#Instance.projDSN#">
		    Update client_proj
			Set status = <cfif Len(Trim(Arguments.ThisFormFields.ProjStatus)) GT 0><cfqueryparam value="#Arguments.ThisFormFields.ProjStatus#" cfsqltype="CF_SQL_Integer"><cfelse>0</cfif>
			Where client_proj = <cfqueryparam value="#Arguments.ThisFormFields.projectCode#" cfsqltype="CF_SQL_VARCHAR" maxlength="20">
		  
		  </cfquery>
		
			 <cfcatch type="database">
			    <cfset OktoCommit = false>
				<cftransaction action="Rollback" />
				<cfset Msg = "#CFCATCH.Detail#> #CFCATCH.Message#<br>#CFCATCH.SQLState#">
			  </cfcatch>   
		   </cftry>
		   
		   <cfif OktoCommit>
			 <cftransaction action="COMMIT" />
			 <cfset OktoCommit = true>  
		   </cfif>
		  </cftransaction>
	  <cfreturn msg />
   </cffunction>
   
   
   <!---***************************** 
      Update the Project/Program Information
	  This is the Second Step of the PIW Worksheet
   ******************************--->
   <cffunction name="UpdatePIWSectiontwo" access="public" returntype="string">
      <cfargument name="projectCode" type="string" required="Yes">
	  <cfargument name="ThisFormFields" type="struct" required="Yes">
	  
	  <cfset OktoCommit = true> 
	  <cfset Msg = "">
	  
	  <cftransaction action="BEGIN">
	    <cftry>
	      <cfquery name="UpdatePIW" datasource="#Instance.projDSN#">
		    Update PIW
			Set include_survey	        = <cfif IsDefined("Arguments.ThisFormFields.IncludeSurvey")> <cfqueryparam value="#Arguments.ThisFormFields.IncludeSurvey#" cfsqltype="CF_SQL_BIT"><cfelse>0</cfif>,
			   	survey_comp				= <cfif Len(Trim(Arguments.ThisFormFields.surveycomp)) GT 0><cfqueryparam value="#trim(ReplaceNoCase(Arguments.ThisFormFields.surveycomp, '$', '','ALL'))#" cfsqltype="CF_SQL_MONEY"><cfelse>0</cfif>,
				survey_comp_type		= <cfif Len(Trim(Arguments.ThisFormFields.surveycomptype)) GT 0><cfqueryparam value="#Arguments.ThisFormFields.surveycomptype#" cfsqltype="CF_SQL_Integer"><cfelse>NULL</cfif>,
				attendee_comp			= <cfif Len(Trim(Arguments.ThisFormFields.attendeeHonoraria)) GT 0><cfqueryparam value="#ReplaceNoCase(Arguments.ThisFormFields.attendeeHonoraria, '$', '','ALL')#" cfsqltype="CF_SQL_Integer"><cfelse>0.00</cfif>,
											<!--- if HonorariaType is not blank set attednee_comp_type indicator
												  else set attendee_comp_type to zero (none) --->
				attendee_comp_type 		= <cfif Len(Trim(Arguments.ThisFormFields.HonorariaType)) GT 0>
											<!--- if HonorariaType = 2, attendee_comp_type = 2 (cash)
													else if HonorariatType = 3, attendee_comp_type = 0 (none)
													else attendees_comp_type = 1 (certificate)
											--->
											<cfif Trim(Arguments.ThisFormFields.HonorariaType) EQ 2>2
											<cfelseif Trim(Arguments.ThisFormFields.HonorariaType) EQ 3>0
											<cfelse>1
											</cfif>,
										  <cfelse>0,
										  </cfif>
				attendee_comp_type_id   = <cfif Len(Trim(Arguments.ThisFormFields.HonorariaType)) GT 0><cfqueryparam value="#Arguments.ThisFormFields.HonorariaType#" cfsqltype="CF_SQL_Integer"><cfelse>3</cfif>,
				prog_participants		= <cfif Len(Trim(Arguments.ThisFormFields.programParticpants)) GT 0><cfqueryparam value="#Arguments.ThisFormFields.programParticpants#" cfsqltype="CF_SQL_Integer"><cfelse>NULL</cfif>,
				num_meetings			= <cfif Len(Trim(Arguments.ThisFormFields.MeetingNumber)) GT 0><cfqueryparam value="#Arguments.ThisFormFields.MeetingNumber#" cfsqltype="CF_SQL_Integer"><cfelse>NULL</cfif>,
				participant_target		= <cfif Len(Trim(Arguments.ThisFormFields.TargetParticipant)) GT 0><cfqueryparam value="#Arguments.ThisFormFields.TargetParticipant#" cfsqltype="CF_SQL_Integer"><cfelse>NULL</cfif>,
				participant_recruit		= <cfif Len(Trim(Arguments.ThisFormFields.participantRecruit)) GT 0><cfqueryparam value="#Arguments.ThisFormFields.participantRecruit#" cfsqltype="CF_SQL_Integer"><cfelse>NULL</cfif>,
				prog_length_hr			= <cfif Len(Trim(Arguments.ThisFormFields.ProgLengthHrs)) GT 0><cfqueryparam value="#Arguments.ThisFormFields.ProgLengthHrs#" cfsqltype="CF_SQL_Integer"><cfelse>0</cfif>,
				prog_length_min			= <cfif Len(Trim(Arguments.ThisFormFields.ProgLengthMin)) GT 0><cfqueryparam value="#Arguments.ThisFormFields.ProgLengthMin#" cfsqltype="CF_SQL_Integer"><cfelse>0</cfif>,
				special_notes           = <cfif Len(Trim(Arguments.ThisFormFields.SpecialNotes)) GT 0><cfqueryparam value="#Trim(Arguments.ThisFormFields.SpecialNotes)#" cfsqltype="CF_SQL_varchar"><cfelse>NULL</cfif>,
				target_audience			= <cfif Len(Trim(Arguments.ThisFormFields.TargetAudience)) GT 0><cfqueryparam value="#Trim(Arguments.ThisFormFields.TargetAudience)#" cfsqltype="CF_SQL_varchar"><cfelse>NULL</cfif>,
				cme_accredited 			= <cfif IsDefined("Arguments.ThisFormFields.CMEAccredited")><cfqueryparam value="#Arguments.ThisFormFields.CMEAccredited#" cfsqltype="CF_SQL_BIT"><cfelse>0</cfif>,
				cme_org					= <cfif Len(Trim(Arguments.ThisFormFields.CMEORG)) GT 0><cfqueryparam value="#trim(Arguments.ThisFormFields.CMEORG)#" cfsqltype="CF_SQL_varchar"><cfelse>NULL</cfif>,
				promo_direct_mail 		= <cfif IsDefined("Arguments.ThisFormFields.PromoDirectMail")><cfqueryparam value="#Arguments.ThisFormFields.PromoDirectMail#" cfsqltype="CF_SQL_BIT"><cfelse>0</cfif>,
				promo_direct_mail_date 	= <cfif Len(Trim(Arguments.ThisFormFields.promoDirectMailDate)) GT 0><cfqueryparam value="#createodbcdatetime(Arguments.ThisFormFields.promoDirectMailDate)#" cfsqltype="CF_SQL_timestamp"><cfelse>NULL</cfif>,
				promo_rep_nom			= <cfif isDefined("Arguments.ThisFormFields.promoRepNom")><cfqueryparam value="#Arguments.ThisFormFields.PromoRepNom#" cfsqltype="CF_SQL_BIT"><cfelse>0</cfif>,
				promo_rep_nom_date		= <cfif Len(Trim(Arguments.ThisFormFields.promoRepNomDate)) GT 0><cfqueryparam value="#createodbcdatetime(Arguments.ThisFormFields.promoRepNomDate)#" cfsqltype="CF_SQL_timestamp"><cfelse>NULL</cfif>,
				promo_fax				= <cfif IsDefined("Arguments.ThisFormFields.PromoFax")><cfqueryparam value="#Arguments.ThisFormFields.PromoFax#" cfsqltype="CF_SQL_BIT"><cfelse>0</cfif>,
				promo_fax_date			= <cfif Len(Trim(Arguments.ThisFormFields.PromoFaxDate)) GT 0><cfqueryparam value="#createodbcdatetime(Arguments.ThisFormFields.PromoFaxDate)#" cfsqltype="CF_SQL_timestamp"><cfelse>NULL</cfif>,
				promo_other				= <cfif IsDefined("Arguments.ThisFormFields.promoOther")><cfqueryparam value="#Arguments.ThisFormFields.promoOther#" cfsqltype="CF_SQL_BIT"><cfelse>0</cfif>,
				promo_other_date		= <cfif Len(Trim(Arguments.ThisFormFields.PromoOtherDate)) GT 0><cfqueryparam value="#createodbcdatetime(Arguments.ThisFormFields.PromoOtherDate)#" cfsqltype="CF_SQL_timestamp"><cfelse>NULL</cfif>,
				promo_other_descrip		= <cfif Len(Trim(Arguments.ThisFormFields.PromoOtherDesc)) GT 0><cfqueryparam value="#Trim(Arguments.ThisFormFields.PromoOtherDesc)#" cfsqltype="CF_SQL_varchar"><cfelse>NULL</cfif>,	 
			    letter_confirmation		= <cfif IsDefined("Arguments.ThisFormFields.LetterConfirmation")><cfqueryparam value="#Arguments.ThisFormFields.LetterConfirmation#" cfsqltype="CF_SQL_BIT"><cfelse>0</cfif>,
				letter_thankyou			= <cfif IsDefined("Arguments.ThisFormFields.LetterThankYou")><cfqueryparam value="#Arguments.ThisFormFields.LetterThankYou#" cfsqltype="CF_SQL_BIT"><cfelse>0</cfif>,
				PI 						= <cfif IsDefined("Arguments.ThisFormFields.ProductInformation")><cfqueryparam value="#Arguments.ThisFormFields.ProductInformation#" cfsqltype="CF_SQL_BIT"><cfelse>0</cfif>,
				letter_faxinfosheet		= <cfif IsDefined("Arguments.ThisFormFields.LetterFaxInfo")><cfqueryparam value="#Arguments.ThisFormFields.LetterFaxInfo#" cfsqltype="CF_SQL_BIT"><cfelse>0</cfif>,
				letter_other			= <cfif IsDefined("Arguments.ThisFormFields.letterother")><cfqueryparam value="#Trim(Arguments.ThisFormFields.letterother)#" cfsqltype="CF_SQL_BIT"><cfelse>0</cfif>,
				letter_other_description= <cfif Len(Trim(Arguments.ThisFormFields.OtherNotesConfirm)) GT 0><cfqueryparam value="#Arguments.ThisFormFields.OtherNotesConfirm#" cfsqltype="CF_SQL_varchar"><cfelse>NULL</cfif>,
				guidebook_to_recruiter	= <cfif Len(Trim(Arguments.ThisFormFields.guidebooktorecruiter)) GT 0><cfqueryparam value="#createodbcdatetime(Arguments.ThisFormFields.guidebooktorecruiter)#" cfsqltype="CF_SQL_timestamp"><cfelse>NULL</cfif>,
				speaker_notes			= <cfif Len(Trim(Arguments.ThisFormFields.SpeakerNotes)) GT 0><cfqueryparam value="#Trim(Arguments.ThisFormFields.SpeakerNotes)#" cfsqltype="CF_SQL_VARCHAR"><cfelse>NULL</cfif>
			Where project_code = <cfqueryparam value="#Arguments.ThisFormFields.projectCode#" cfsqltype="CF_SQL_VARCHAR" maxlength="20">
		  </cfquery>
	    
		
		      <cfcatch type="database">
			    <cfset OktoCommit = false>
				<cftransaction action="Rollback" />
				<cfset Msg = "#CFCATCH.Detail#> #CFCATCH.Message#<br>#CFCATCH.SQLState#">
			  </cfcatch>   
		   </cftry>
		   
		   <cfif OktoCommit>
			 <cftransaction action="COMMIT" />
			 <cfset OktoCommit = true>  
		   </cfif>
		  </cftransaction> 
	 
	  <cfreturn Msg />
   </cffunction>
   
   <!---***************************** 
      Update the Repots Information
	  This is the Third Step of the PIW Worksheet
   ******************************--->
   <cffunction name="UpdatePIWSectionThree" access="public" returntype="string">
      <cfargument name="projectCode" type="string" required="Yes">
	  <cfargument name="ThisFormFields" type="struct" required="Yes">
	  
	  <cfset OktoCommit = true> 
	  <cfset Msg = "">
	  
	  <cftransaction action="BEGIN">
	    <cftry>
	      <cfquery name="UpdatePIW" datasource="#Instance.projDSN#">
		    Update report_info
			Set summary_weekly 		  	= <cfif IsDefined("Arguments.ThisFormFields.SummaryWeekly")><cfqueryparam value="#Arguments.ThisFormFields.SummaryWeekly#" cfsqltype="CF_SQL_BIT"><cfelse>0</cfif>,
			    summary_monthly 		= <cfif IsDefined("Arguments.ThisFormFields.SummaryMonthly")><cfqueryparam value="#Arguments.ThisFormFields.SummaryMonthly#" cfsqltype="CF_SQL_BIT"><cfelse>0</cfif>,
				summary_other 			= <cfif IsDefined("Arguments.ThisFormFields.SummaryOther")><cfqueryparam value="#Arguments.ThisFormFields.SummaryOther#" cfsqltype="CF_SQL_BIT"><cfelse>0</cfif>,
				summary_other_descrip 	= <cfif Len(Trim(Arguments.ThisFormFields.summaryOtherDesc)) GT 0><cfqueryparam value="#Trim(Arguments.ThisFormFields.summaryOtherDesc)#" cfsqltype="CF_SQL_VARCHAR"><cfelse>NULL</cfif>,
				vm_mgrs 				= <cfif IsDefined("Arguments.ThisFormFields.VmailRepMgr")><cfqueryparam value="#Arguments.ThisFormFields.VmailRepMgr#" cfsqltype="CF_SQL_BIT"><cfelse>0</cfif>,
				vm_reps 				= <cfif IsDefined("Arguments.ThisFormFields.VmailRepReps")><cfqueryparam value="#Arguments.ThisFormFields.VmailRepReps#" cfsqltype="CF_SQL_BIT"><cfelse>0</cfif>,
				vm_other 				= <cfif IsDefined("Arguments.ThisFormFields.VmailRepOthr")><cfqueryparam value="#Arguments.ThisFormFields.VmailRepOthr#" cfsqltype="CF_SQL_BIT"><cfelse>0</cfif>,
				vm_other_descrip 		= <cfif Len(Trim(Arguments.ThisFormFields.VmailRepOtherDesc)) GT 0><cfqueryparam value="#Trim(Arguments.ThisFormFields.VmailRepOtherDesc)#" cfsqltype="CF_SQL_VARCHAR"><cfelse>NULL</cfif>,
				online_report_heading 	= <cfif Len(Trim(Arguments.ThisFormFields.onlinereport)) GT 0><cfqueryparam value="#Trim(Arguments.ThisFormFields.onlinereport)#" cfsqltype="CF_SQL_VARCHAR"><cfelse>NULL</cfif>,
				email_mgrs 				= <cfif IsDefined("Arguments.ThisFormFields.emailRepMgr")><cfqueryparam value="#Arguments.ThisFormFields.emailRepMgr#" cfsqltype="CF_SQL_BIT"><cfelse>0</cfif>,
				email_reps 				= <cfif IsDefined("Arguments.ThisFormFields.emailRepReps")><cfqueryparam value="#Arguments.ThisFormFields.emailRepReps#" cfsqltype="CF_SQL_BIT"><cfelse>0</cfif>,
				email_other 			= <cfif IsDefined("Arguments.ThisFormFields.emailRepOthr")><cfqueryparam value="#Arguments.ThisFormFields.emailRepOthr#" cfsqltype="CF_SQL_BIT"><cfelse>0</cfif>,
				email_other_descrip 	= <cfif Len(Trim(Arguments.ThisFormFields.emailOtherDesc)) GT 0><cfqueryparam value="#Trim(Arguments.ThisFormFields.emailOtherDesc)#" cfsqltype="CF_SQL_VARCHAR"><cfelse>NULL</cfif>,
				client_toll_free 		= <cfif Len(Trim(Arguments.ThisFormFields.ClientTollFree)) GT 0><cfqueryparam value="#Trim(Arguments.ThisFormFields.ClientTollFree)#" cfsqltype="CF_SQL_VARCHAR"><cfelse>NULL</cfif>,
				special_report 			= <cfif Len(Trim(Arguments.ThisFormFields.SpecialReportingDesc)) GT 0><cfqueryparam value="#Trim(Arguments.ThisFormFields.SpecialReportingDesc)#" cfsqltype="CF_SQL_VARCHAR"><cfelse>NULL</cfif>
			Where project_code = <cfqueryparam value="#Arguments.ThisFormFields.projectCode#" cfsqltype="CF_SQL_VARCHAR" maxlength="20">
		  </cfquery>
	    
		
		      <cfcatch type="database">
			    <cfset OktoCommit = false>
				<cftransaction action="Rollback" />
				<cfset Msg = "#CFCATCH.Detail#> #CFCATCH.Message#<br>#CFCATCH.SQLState#">
			  </cfcatch>   
		   </cftry>
		   
		   <cfif OktoCommit>
			 <cftransaction action="COMMIT" />
			 <cfset OktoCommit = true>  
		   </cfif>
		  </cftransaction> 
	 
	  <cfreturn Msg />
   </cffunction>
   <!---***************************** 
      Update the Project/Program Information
	  This is the Second Step of the PIW Worksheet
   ******************************--->
   <cffunction name="UpdatePIWSectionfour" access="public" returntype="string">
      <cfargument name="projectCode"    type="string" required="yes">
	  <cfargument name="ModGuideDate"   type="date" required="no">
	  <cfargument name="AdminMatDate"   type="date" required="no">
	  <cfargument name="GuideBookDate"  type="date" required="no">
	  <cfargument name="ComponentsDate" type="date" required="no">
	  <cfargument name="guidebookNew"   type="numeric" required="yes">
	  <cfargument name="guidebookRevised"   type="numeric" required="yes">
	  <cfargument name="guidebookCharts"   type="numeric" required="yes">
	  <cfargument name="ReviseWording"   type="numeric" required="yes">
	  <cfargument name="reviseCharts"   type="numeric" required="yes">
	  <cfargument name="newCharts"   type="numeric" required="yes">
	  <cfargument name="SpecialInstr"   type="string" required="no">
	  <cfargument name="AllowOnline"   type="numeric" required="no">
	  <cfargument name="GuideBookFile"   type="string" required="no">
	  <cfargument name="ModGuideFile"   type="string" required="no">
	  <cfargument name="AdminGuideFile"   type="string" required="no">
	  
	  
	  <cfset OktoCommit = true> 
	  <cfset msg = "">
	  
	  <cftransaction action="BEGIN">
	    <cftry>
	      <cfquery name="UpdatePIW" datasource="#Instance.projDSN#">
		    Update creative_info
			   Set moderator_guide_date = <cfif IsDefined("arguments.ModGuideDate")>#CreateODBCDateTime(arguments.ModGuideDate)#<cfelse>NULL</cfif>,
			       admin_materials_date= <cfif IsDefined("arguments.AdminMatDate")>#CreateODBCDateTime(arguments.AdminMatDate)#<cfelse>NULL</cfif>,
				   guidebook_date = <cfif IsDefined("arguments.GuideBookDate")>#CreateODBCDateTime(arguments.GuideBookDate)#<cfelse>NULL</cfif>,
				   components_date = <cfif IsDefined("arguments.ComponentsDate")>#CreateODBCDateTime(arguments.ComponentsDate)#<cfelse>NULL</cfif>,
				   guidebook_new = #arguments.guidebookNew#,
				   guidebook_revised = #arguments.guidebookRevised#,
				   guidebook_charts = #arguments.guidebookCharts#,
				   revise_wording = #arguments.ReviseWording#,
				   revise_charts = #arguments.reviseCharts#,
				   new_charts = #arguments.newCharts#,
				   special_instructions = '#arguments.SpecialInstr#'
			Where Project_Code = '#Arguments.projectCode#'	   
		  </cfquery>
	    
		
		      <cfcatch type="database">
			    <cfset OktoCommit = false>
				<cftransaction action="Rollback" />
				<cfset Msg = "#CFCATCH.Detail#> #CFCATCH.Message#<br>#CFCATCH.SQLState#">
			  </cfcatch>   
		   </cftry>
		   
		   <cfif OktoCommit>
			 <cftransaction action="COMMIT" />
			 <cfset OktoCommit = true>  
		   </cfif>
		  </cftransaction> 
	 
	  <cfreturn Msg />
   </cffunction>
   
   <!---***************************** 
      Update the Project/Program Information
	  This is the Fifth and final Step of the PIW Worksheet
   ******************************--->
   <cffunction name="UpdatePIWSectionFive" access="public" returntype="string">
      <cfargument name="projectCode"  type="string" required="yes">
	  <cfargument name="RecruitMailingInfo"  type="string" required="no">
	  <cfargument name="AddtionalInfo"  type="string" required="no">
	  <cfargument name="DirectMailInfo"  type="string" required="no">
	  <cfargument name="MrktDrugInfo"  type="string" required="no">
	  <cfargument name="MrktDrugScript"  type="string" required="no">	
	  <cfargument name="repnom"  type="numeric" required="yes">
	  <cfargument name="PAOK"  type="numeric" required="yes">
	  <cfargument name="NPOK"  type="numeric" required="yes">
	  <cfargument name="OTHEROK"  type="numeric" required="yes">
	  <cfargument name="OtherDesc"  type="string" required="no">
	  
	  
	  <cfset OktoCommit = true> 
	  <cfset msg = "">
	  
	 <cftransaction action="BEGIN">
	    <cftry> 
	      <cfquery name="UpdatePIW" datasource="#Instance.projDSN#">
		    Update recruiting_info
			   Set rep_nom = #Arguments.repnom#,
			       pa_ok = #Arguments.PAOK#,
				   np_ok = #Arguments.NPOK#,
				   other_ok = #Arguments.OTHEROK#,
				   other_description = <cfif Arguments.OtherDesc NEQ "">'#Arguments.OtherDesc#'<cfelse>NULL</cfif>,
				   direct_mailers_info = <cfif Arguments.DirectMailInfo NEQ "">'#Arguments.DirectMailInfo#'<cfelse>NULL</cfif>,
				   recruit_mailings_info = <cfif Arguments.RecruitMailingInfo NEQ "">'#Arguments.RecruitMailingInfo#'<cfelse>NULL</cfif>,
				   additional_info = <cfif Arguments.AddtionalInfo NEQ "">'#Arguments.AddtionalInfo#'<cfelse>NULL</cfif>,
				   market_drug_info = <cfif Arguments.MrktDrugInfo NEQ "">'#Arguments.MrktDrugInfo#'<cfelse>NULL</cfif>,
				   market_drug_script = <cfif Arguments.MrktDrugScript NEQ "">'#Arguments.MrktDrugScript#'<cfelse>NULL</cfif>
			Where Project_Code = '#Arguments.projectCode#'	   
		  </cfquery>
	    
		
		     <cfcatch type="database">
			    <cfset OktoCommit = false>
				<cftransaction action="Rollback" />
				<cfset Msg = "#CFCATCH.Detail#> #CFCATCH.Message#<br>#CFCATCH.SQLState#">
			  </cfcatch>   
		   </cftry>
		   
		    <cfif OktoCommit>
			 <cftransaction action="COMMIT" />
			 <cfset OktoCommit = true>  
		   </cfif>
		  </cftransaction>
	 
	  <cfreturn Msg />
   </cffunction>
   <!---***************************** 
      This will add a new Contact to the ClientContact Table.
   ******************************--->
   <cffunction name="AddSecondContact" access="public" returntype="Boolean">
       <cfargument name="ClientCode" type="string" required="Yes">
	   <cfargument name="firstname" type="string" required="Yes">
	   <cfargument name="lastname" type="string" required="Yes">
	   <cfargument name="title" type="string" required="no">
	   <cfargument name="phone" type="string" required="Yes">
	   <cfargument name="fax" type="string" required="no">
	   <cfargument name="email" type="string" required="Yes">
	   <cfargument name="mobile" type="string" required="no">
	   <cfargument name="Addr1" type="string" required="no">
	   <cfargument name="addr2" type="string" required="no">
	   <cfargument name="city" type="string" required="no">
	   <cfargument name="state" type="string" required="no">
	   <cfargument name="zipcode" type="string" required="no">
	   
	   <cfset OktoCommit = true> 
	
	    <cftransaction action="BEGIN">
	      <cftry> 
		   <cfquery name="InsertContact" datasource="#Instance.projDSN#">
		     Insert Into ClientContact (
			     ClientCode,
				 FirstName,
				 LastName,
				 Title,
				 Phone,
				 Fax,
				 Email,
				 Mobile,
				 Addr1,
				 Addr2,
				 City,
				 State,
				 Zipcode,
				 DateCreated
			   )
			 Values (
			     '#Trim(Arguments.ClientCode)#',
				 '#Trim(Arguments.Firstname)#',
				 '#Trim(Arguments.Lastname)#',
				 <cfif IsDefined("arguments.Title")>'#Trim(Arguments.Title)#'<cfelse>NULL</cfif>,
				 '#Trim(Arguments.Phone)#',
				 <cfif IsDefined("arguments.Fax")>'#Trim(Arguments.Fax)#'<cfelse>NULL</cfif>,
				 '#Trim(Arguments.Email)#',
				 <cfif IsDefined("arguments.Mobile")>'#Trim(Arguments.Mobile)#'<cfelse>NULL</cfif>,
				 <cfif IsDefined("arguments.Addr1")>'#Trim(Arguments.Addr1)#'<cfelse>NULL</cfif>,
				 <cfif IsDefined("arguments.Addr2")>'#Trim(Arguments.Addr2)#'<cfelse>NULL</cfif>,
				 <cfif IsDefined("arguments.City")>'#Trim(Arguments.City)#'<cfelse>NULL</cfif>,
				 <cfif IsDefined("arguments.State")>'#Trim(Arguments.State)#'<cfelse>NULL</cfif>,
				 <cfif IsDefined("arguments.Zipcode")>'#Trim(Arguments.Zipcode)#'<cfelse>NULL</cfif>,
				 #CreateODBCDateTime(now())#
			   )
		   </cfquery>
	   	      <cfcatch type="database">
			     <cfset OktoCommit = false>
				 <cftransaction action="Rollback" />
				 <cfset Msg = "Error Occured while Adding Contact<br>DETAIL:#CFCatch.Detail#<br>NATIVE:#CFCATCH.NativeErrorCode#<br>SQLSATE:#CFCATCH.SQLState#">
			     <cfmodule template="/pms/ctags/Auditlog.cfm" action="PROJ INSERT CONTACT" message="#Msg#" Status="FAILED" User="0" datasource="#Instance.projDSN#"> 
				 
				 
			  </cfcatch>   
		   </cftry>
		   
		   <cfif OktoCommit>
			 <cftransaction action="COMMIT" />
			 <cfset OktoCommit = true>  
		   </cfif>
		  </cftransaction> 
	  
	  <cfreturn OktoCommit />
   </cffunction>
   
   <!---***************************** 
      This will update the Contact info to the ClientContact Table.
   ******************************--->
   <cffunction name="UpdateSecondContact" access="public" returntype="Boolean">
       <cfargument name="ContactID" type="numeric" required="Yes">
	   <cfargument name="firstname" type="string" required="Yes">
	   <cfargument name="lastname" type="string" required="Yes">
	   <cfargument name="title" type="string" required="no">
	   <cfargument name="phone" type="string" required="Yes">
	   <cfargument name="fax" type="string" required="no">
	   <cfargument name="email" type="string" required="Yes">
	   <cfargument name="mobile" type="string" required="no">
	   <cfargument name="Addr1" type="string" required="no">
	   <cfargument name="addr2" type="string" required="no">
	   <cfargument name="city" type="string" required="no">
	   <cfargument name="state" type="string" required="no">
	   <cfargument name="zipcode" type="string" required="no">
	   
	   <cfset OktoCommit = true> 
	
	    <cftransaction action="BEGIN">
	      <cftry> 
		   <cfquery name="InsertContact" datasource="#Instance.projDSN#">
		     Update ClientContact
			   SET FirstName	= '#trim(Arguments.Firstname)#',
				   LastName		= '#trim(Arguments.Lastname)#',
				   Title		= <cfif IsDefined("arguments.Title")>'#trim(Arguments.Title)#'<cfelse>NULL</cfif>,
				   Phone		= '#Arguments.Phone#',
				   Fax			= <cfif IsDefined("arguments.Fax")>'#Trim(Arguments.Fax)#'<cfelse>NULL</cfif>,
				   Email		= '#Arguments.Email#',
				   Mobile		= <cfif IsDefined("arguments.Mobile")>'#Trim(Arguments.Mobile)#'<cfelse>NULL</cfif>,
				   Addr1		= <cfif IsDefined("arguments.Addr1")>'#Trim(Arguments.Addr1)#'<cfelse>NULL</cfif>,
				   Addr2		= <cfif IsDefined("arguments.Addr2")>'#Trim(Arguments.Addr2)#'<cfelse>NULL</cfif>,
				   City			= <cfif IsDefined("arguments.City")>'#Trim(Arguments.City)#'<cfelse>NULL</cfif>,	
				   State		= <cfif IsDefined("arguments.State")>'#Trim(Arguments.State)#'<cfelse>NULL</cfif>,
				   Zipcode		= <cfif IsDefined("arguments.Zipcode")>'#Trim(Arguments.Zipcode)#'<cfelse>NULL</cfif>,
				   LastUpdated 	= #CreateODBCDateTime(now())#
			Where ContactID = #Arguments.ContactID#	   
		   </cfquery>
	   	      <cfcatch type="database">
			     <cfset OktoCommit = false>
				 <cftransaction action="Rollback" />
				 
				 <cfset Msg = "Error Occured while Adding Contact<br>DETAIL:#CFCatch.Detail#<br>NATIVE:#CFCATCH.NativeErrorCode#<br>SQLSATE:#CFCATCH.SQLState#">
			     <cfmodule template="/pms/ctags/Auditlog.cfm" action="PROJ INSERT CONTACT" message="#Msg#" Status="FAILED" User="0" datasource="#Instance.projDSN#">
				 
			  </cfcatch>   
		   </cftry>
		   
		   <cfif OktoCommit>
			 <cftransaction action="COMMIT" />
			 <cfset OktoCommit = true>  
		   </cfif>
		  </cftransaction> 
	  
	  <cfreturn OktoCommit />
   </cffunction>
   <cffunction name="DeleteContact" access="Public" returnType="Boolean">
     <cfargument name="ContactID" type="numeric" required="yes">
	 <cfquery name="DelContact" datasource="#Instance.ProjDsn#">
	   Delete From ClientContact
	   Where ContactID = #Arguments.ContactID#
	 </cfquery>
	 
	 <cfreturn true />
   </cffunction>
</cfcomponent>