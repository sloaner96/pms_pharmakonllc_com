<cfcomponent displayname="projects" output="No">
   
   <!--- lock name is the name used to wrap file io/data ops --->
	<cfset LOCK_NAME = "projects_cfc">

	<!--- Constructor --->
	<cfset init()>
				
	<!--- Initialize datasources --->
	<cfset instance.projdsn = "PMS">
	<cfset instance.rosterdsn = "CBARoster">
	
   <!---************************* 
      Initialize the component 
     ************************--->
   <cffunction name="init" output="true" returnType="boolean" access="public"
				hint="Handles initialization.">
	      <cfset instance.initialized = true>
	      <cfreturn instance.initialized />
   </cffunction>
   
  <!---**********************************************
      Get The Distinct Meeting Codes 
	  in subquery for production
   **********************************************----> 
  <cffunction name="getMeetinCodeDateRange" access="public" returntype="query">
	    <cfargument name="begindate" type="date" required="Yes" default="#DateAdd('d', -1, now())#">
		<cfargument name="enddate" type="date" required="Yes" default="#CreateODBCDATETIME(now())#">
		    
			<cfquery name="getMeetingsQ1" datasource="#instance.rosterdsn#">
			    SELECT distinct substring(meetingcode, 1, 9) as project_code 
				FROM roster 
				WHERE apptdate BETWEEN <cfqueryparam value="#Arguments.BeginDate#" cfsqltype="CF_SQL_DATE">
				                    AND <cfqueryparam value="#Arguments.EndDate#" cfsqltype="CF_SQL_DATE"> 
				AND substring(meetingcode,2,2) <> 'XX' 
				order by project_code
			</cfquery>
			
		    <cfquery name="getMeetingsQ2" datasource="#instance.projdsn#">
			    SELECT distinct project_code 
				FROM schedule_meeting_time 
				WHERE meeting_date BETWEEN <cfqueryparam value="#Arguments.BeginDate#" cfsqltype="CF_SQL_DATE">
				                    AND <cfqueryparam value="#Arguments.EndDate#" cfsqltype="CF_SQL_DATE"> 
				AND project_code not in (select distinct substring(meetingcode, 1, 9) 
				                          from Mozart.CBARoster.dbo.roster 
				                          where apptdate between <cfqueryparam value="#Arguments.BeginDate#" cfsqltype="CF_SQL_DATE">
											               and <cfqueryparam value="#Arguments.EndDate#" cfsqltype="CF_SQL_DATE"> ) 
				and substring(project_code,8,2) <> 'LX' 
				order by project_code
			</cfquery>
			
		   <cfquery name="GetMeetingsQ3" datasource="#instance.rosterdsn#">
		        SELECT distinct substring(meetingcode, 1, 9) as project_code 
				FROM roster 
				WHERE apptdate BETWEEN <cfqueryparam value="#Arguments.BeginDate#" cfsqltype="CF_SQL_DATE"> 
				               AND <cfqueryparam value="#Arguments.EndDate#" cfsqltype="CF_SQL_DATE">  
				AND project_code NOT IN (select distinct project_code 
				                         from PMSPROD.dbo.schedule_meeting_time 
				                         where meeting_date  BETWEEN <cfqueryparam value="#Arguments.BeginDate#" cfsqltype="CF_SQL_DATE"> 
										                     AND <cfqueryparam value="#Arguments.EndDate#" cfsqltype="CF_SQL_DATE"> ) 
				ORDER BY project_code
		   </cfquery>
		   
		   <cfset getMeetings = QueryNew('Project_Code')>
		   
		   <cfloop query="GetMeetingsQ1">
		     <cfset temp =  QueryAddrow(GetMeetings)>
			 <cfset temp = QuerySetCell(GetMeetings, 'Project_Code', GetMeetingsQ1.Project_Code)>
		   </cfloop>
		   <cfloop query="GetMeetingsQ2">
		     <cfset temp =  QueryAddrow(GetMeetings)>
			 <cfset temp = QuerySetCell(GetMeetings, 'Project_Code', GetMeetingsQ2.Project_Code)>
		   </cfloop>
		   <cfloop query="GetMeetingsQ3">
		     <cfset temp =  QueryAddrow(GetMeetings)>
			 <cfset temp = QuerySetCell(GetMeetings, 'Project_Code', GetMeetingsQ3.Project_Code)>
		   </cfloop>
		   
	    <cfreturn getMeetings />
  </cffunction>
  
  <!---****************************************
	  Get the meeting type code for a project 
   ****************************************--->
   <cffunction name="getMeetingTypeCode" access="public" returntype="query">
       <cfargument name="Project_code" type="string" required="yes">
	      <cfquery name="getMeetingTypeCode" datasource="#Instance.projdsn#">
				SELECT c.meeting_type, m.meeting_type_value, meeting_type_description
				FROM client_proj c, meeting_type m
				WHERE m.meeting_type = c.meeting_type
				<cfif IsDefined("Arguments.Project_Code")>
					AND c.client_proj = '#Arguments.project_code#'
				</cfif>	
				ORDER BY m.meeting_type_value
		  </cfquery>
		
		<cfreturn getMeetingTypeCode />
   </cffunction>
   
     <!---****************************************
	  Get All the meeting type codes
   ****************************************--->
   <cffunction name="getAllMeetingTypeCode" access="public" returntype="query">
       <cfargument name="Project_code" type="string" required="yes">
	      <cfquery name="getMeetingTypeCode" datasource="#Instance.projdsn#">
				SELECT M.Meeting_Type, m.meeting_type_value, m.meeting_type_description
				FROM meeting_type m
				WHERE m.status = 1
				ORDER BY m.meeting_type_value
		  </cfquery>
		
		<cfreturn getMeetingTypeCode />
   </cffunction>
    <!---*********************** 
	   Get Client Information
	  **********************--->
   <cffunction name="getClients" access="public" returntype="query">
	      <cfargument name="client_id" type="string" required="no"> 
	      
		  <cfquery name="getClient" datasource="#Instance.projdsn#">
			Select ID, client_abbrev, client_name, status
			From Clients
			WHere Status = 1
			<cfif IsDefined("arguments.client_id")>
			  AND ID = <cfqueryparam value="arguments.Client_ID" cfsqltype="cf_sql_integer">
			</cfif>
			Order By client_name
		  </cfquery>	
		  
		 <cfreturn getClient />
   </cffunction>
     <!---*********************** 
	   Get Client Series Information
	  **********************--->
   <cffunction name="getClientSeries" access="public" returntype="query">
	      <cfargument name="SeriesID" type="numeric" required="no"> 
	      <cfargument name="CompanyCode" type="string" required="no"> 
		  <cfargument name="ClientCode" type="string" required="no"> 
		  <cfargument name="ProductCode" type="string" required="no"> 
		  <cfargument name="SeriesBegin" type="date" required="no"> 
		  <cfargument name="SeriesEnd" type="date" required="no"> 
		  <cfargument name="DateBeginOperator" type="string" required="no"> 
		  <cfargument name="DateEndOperator" type="string" required="no"> 
		  
		  <cfset var getseries = "">
		  <cfquery name="getSeries" datasource="#Instance.projdsn#">
			 Select *
			 From ProgramSeries p
			 Where (1 = 1 
			<cfif IsDefined("arguments.SeriesID")>
			 AND SeriesID = #arguments.SeriesID#
			</cfif>
			<cfif IsDefined("arguments.CompanyCode")>
			 AND (SellingCompany = '#arguments.CompanyCode#')
			</cfif>
			<cfif IsDefined("arguments.ClientCode")>
			 AND (ClientCode = '#arguments.ClientCode#')
			</cfif>
			<cfif IsDefined("arguments.ProductCode")>
			 AND ProductCode = '#arguments.ProductCode#'
			</cfif>
			<cfif IsDefined("arguments.SeriesBegin")>
			 AND SeriesBegin <cfif isDefined("dateBeginOperator")>#dateBeginOperator#<cfelse>=</cfif> #createODBCdatetime(arguments.SeriesBegin)#
			</cfif>
			<cfif IsDefined("arguments.SeriesEnd")>
			 AND SeriesEnd <cfif isDefined("dateEndOperator")>#dateEndOperator#<cfelse>=</cfif> #createODBCdatetime(arguments.SeriesEnd)#
			</cfif>)
			order By SellingCompany, ClientCode, ProductCode, SeriesCode, SeriesBegin, SeriesEnd
		  </cfquery>	
		  
		 <cfreturn getSeries />
   </cffunction>
   
   <!---*********************** 
	   Get Series Programs
	  **********************--->
   <cffunction name="getSeriesPrograms" access="public" returntype="query">
	      <cfargument name="SeriesID" type="numeric" required="yes"> 
		  <cfargument name="Status" type="numeric" required="no"> 
		  
		  <cfquery name="getSeries" datasource="#Instance.projdsn#">
			 Select G.SeriesCode as SeriesID, G.ProgramID, P.project_code, P.project_status as status, C.description, P.program_start
			 From ProgramSeriesGroup G, PIW P, Client_Proj C
			 Where G.ProgramID = P.rowid
			 AND P.project_code = C.client_proj
			 AND G.SeriesCode = #arguments.SeriesID#
			 <cfif IsDefined("Arguments.Status")>AND C.Status = #arguments.Status#</cfif>
		  </cfquery>	
		  
		 <cfreturn getSeries />
   </cffunction>
   
      <!---*********************** 
	   Get Series Programs
	  **********************--->
   <cffunction name="getDistinctSeries" access="public" returntype="query">
	      <cfargument name="SeriesID" type="numeric" required="yes"> 
		  
		  <cfquery name="getSeries" datasource="#Instance.projdsn#">
			 Select Distinct P.project_status as status,
			   (Select CodeDesc
			      From Lookup
				  Where CodeGroup = 'PROJECTSTATUS'
				  AND CodeValue = C.Status) as StatusDesc
			 From ProgramSeriesGroup G, PIW P, Client_Proj C
			 Where G.ProgramID = P.rowid
			 AND P.project_code = C.client_proj
			 AND G.SeriesCode = #arguments.SeriesID#
		  </cfquery>	
		  
		 <cfreturn getSeries />
   </cffunction>
   <!---*********************** 
      Get a single Client Code 
     **********************--->
   <cffunction name="getClientCode" access="public" returntype="query">
	      <cfargument name="client_code" type="string" required="yes"> 
	      
		  <cfquery name="ThisClientCode" datasource="#Instance.projdsn#">
				SELECT c.client_code, c.client_code_description, 
				       product_manager, address1, address2, city, 
					   state, zipcode, country, phone, fax, email, createdby, createddate, status
				FROM client_code c 	
				WHERE client_code = '#arguments.client_code#'	
				ORDER BY c.client_code
		  </cfquery>	
		  
		 <cfreturn ThisClientCode />
   </cffunction>
   
   <!---*********************** 
      Get a Client Contacts 
     **********************--->
   <cffunction name="getClientContacts" access="public" returntype="query">
	      <cfargument name="client_code" type="string" required="yes"> 
	      
		  <cfquery name="AllContacts" datasource="#Instance.projdsn#">
			 Select *
			 From ClientContact
			 Where ClientCode = '#arguments.client_code#'
			 order By lastname, firstname, title
		  </cfquery>	
		  
		 <cfreturn AllContacts />
   </cffunction>
   
      <!---*********************** 
      Get a Contact Info
     **********************--->
   <cffunction name="getContactInfo" access="public" returntype="query">
	      <cfargument name="ContactID" type="numeric" required="yes"> 
	      
		  <cfquery name="ContactInfo" datasource="#Instance.projdsn#">
			 Select *
			 From ClientContact
			 Where ContactID = '#arguments.ContactID#'
			 order By lastname, firstname, title
		  </cfquery>	
		  
		 <cfreturn ContactInfo />
   </cffunction> 
  <!---*******************
	  Get All Client Codes for a Specific Client 
	  ******************--->
   <cffunction name="getClientPrograms" access="public" returntype="query">
      <cfargument name="clientAbbr" type="string" required="yes">
	   
	       <cfquery name="clientPrograms" datasource="#Instance.projdsn#">
				SELECT c.client_code, c.client_code_description 
				FROM client_code c 	
				Where Status = 1
				AND substring(client_Code, 2, 2) = '#Arguments.ClientAbbr#'
				ORDER BY c.client_code
		   </cfquery>	
	      
		  <cfreturn clientPrograms />
   </cffunction>
   
    <!---*******************
	  Get All Client Codes 
	  ******************--->
   <cffunction name="getAllClientCode" access="public" returntype="query">
	       <cfquery name="allClientCodes" datasource="#Instance.projdsn#">
				SELECT c.client_code, c.client_code_description 
				FROM client_code c 	
				ORDER BY c.client_code
		   </cfquery>	
	      
		  <cfreturn allClientCodes />
   </cffunction>
   
   <!---********************* 
      Get All Status Codes 
	 ********************--->
   <cffunction name="getStatusCodes" access="public" returntype="query">
      <cfargument name="status_code" type="numeric" required="no">
       <cfquery name="getStatusCode" datasource="#Instance.projdsn#" >
			SELECT CodeValue as status_code, CodeDesc as status_description 
			FROM Lookup
			Where Codegroup = 'PROJECTSTATUS' 
			<cfif IsDefined("arguments.status_code")>
			 AND CodeValue = #arguments.status_code#
			</cfif>
			order by Ranking, CodeValue
	  </cfquery>	
	  
	  <cfreturn getStatusCode />
   </cffunction>
   
   <!---******************************
      Get client project information 
	******************************--->
   <cffunction name="getClientProject" access="public" returntype="query">
      <cfargument name="client_code" type="string" required="yes">
	  <cfargument name="status_code" type="numeric" required="no">
	
		  <cfquery name="getClientInfo" datasource="#Instance.projdsn#">
				SELECT c.client_proj, c.description, c.client_code, c.status,  p.program_start
				FROM client_proj c, piw p 
				WHERE c.client_code = '#trim(arguments.client_code)#' 
				AND c.client_proj = p.project_code
				<cfif IsDefined("arguments.status_code")>
					AND c.status = #status_code#
				</cfif>
				ORDER BY c.client_proj
		</cfquery>
		
	 <cfreturn getClientInfo/>
   </cffunction>
   
   
   <!---*************************
      Get project info 
	*************************--->
   <cffunction name="getProject" access="public" returntype="query">
      <cfargument name="project_code" type="string" required="yes">
	  
	  <CFQUERY NAME="GetProject" DATASOURCE="#Instance.projdsn#">
				SELECT c.corp_value, C.Corp_ID, l.id as clientID, l.client_name, p.project_code, p.account_exec, p.account_supr, 
						p.product, p.client_code, p.guide_writer, p.speaker_listenins , p.guide_topic, p.proj_program_start, 
						p.recruit_start, p.program_start, p.program_end, p.call_inbound, 
						p.call_outbound, r.recruiter_name, p.recruiting_company_phone, 
						o.conf_company_name, p.helpline, p.include_survey, p.survey_comp, 
						p.prog_participants, p.num_meetings, p.participant_target, 
						p.participant_recruit, p.attendee_comp_type, p.attendee_comp, 
						p.survey_comp_type, p.prog_length_hr, p.prog_length_min, p.special_notes, 
						p.target_audience, p.cme_accredited, p.cme_org, p.guidebook_include, 
						p.letter_confirmation, p.letter_thankyou, p.PI,
						p.letter_faxinfosheet, p.letter_other, p.letter_other_description, 
						p.guidebook_to_recruiter, p.speaker_notes, p.attendee_comp_type_id, b.cost_per_attendee, 
						b.direct_mail_costs, b.additional_costs, b.finance_notes, 
						b.client_ap_contact, b.client_ap_phone_fax, b.billing_schedule, 
						re.online_report_heading, re.summary_weekly, re.summary_monthly, re.summary_other, 
						re.summary_other_descrip, re.vm_mgrs, re.vm_reps, re.vm_other, re.vm_other_descrip, re.vm_special,
						re.email_mgrs, re.email_reps, re.email_other, re.email_other_descrip,
						re.client_toll_free, re.special_report, cr.moderator_guide_date, cr.admin_materials_date, 
						cr.guidebook_date, cr.components_date, cr.guidebook_new, 
						cr.guidebook_revised, cr.guidebook_charts, cr.revise_wording, 
						cr.revise_charts, cr.new_charts, cr.special_instructions,
						rc.rep_nom, rc.pa_ok, rc.np_ok, rc.other_ok, rc.other_description, 
						rc.direct_mailers_info, rc.recruit_mailings_info, rc.additional_info, 
						rc.market_drug_info, rc.market_drug_script, ro.roster_notes, 
						p.meeting_type, p.promo_direct_mail, p.promo_direct_mail_date, 
						p.promo_rep_nom, p.promo_rep_nom_date, p.promo_fax, p.promo_fax_date, 
						p.promo_other, p.promo_other_date, promo_other_descrip, 
						m.meeting_type_value, p.meeting_other_notes,
						  (Select Status
						    From client_proj
							Where Rtrim(client_proj) = Rtrim(P.Project_code)) as projstatus
			 		FROM  corp c, piw p, clients l, recruiter r, conference_company o,  
							billing_info b, report_info re, creative_info cr, 
							recruiting_info rc, roster_info ro, meeting_type m 
					WHERE p.project_code = '#arguments.project_code#' 
						AND p.corp_id *= c.corp_id 
						AND p.client *= l.id 
						AND p.recruiting_company *= r.id 
						AND p.conference_company *= o.ID 
						AND b.project_code = p.project_code
						AND re.project_code = p.project_code
						AND cr.project_code = p.project_code 
						AND rc.project_code = p.project_code 
						AND ro.project_code = p.project_code 
						AND p.meeting_type *= m.meeting_type
	</cfquery>
		
	 <cfreturn getProject/>
   </cffunction>
   
   <!---******************** 
      Get Project Notes 
	 *******************--->
   <cffunction name="getProjectNotes" access="public" returntype="query">
      <cfargument name="project_code" type="string" required="yes">
    
     <CFQUERY DATASOURCE="#Instance.projdsn#" NAME="getNotes">
	    select  DISTINCT n.rowid,n.project_code, n.note_type, n.note_data, n.entry_date, n.entry_time, n.entry_userid,  n.subject
		from piw_notes n
		where n.project_code = '#arguments.project_code#'
     </cfquery>
	 
	 <cfreturn getnotes/>
   </cffunction>
   
   <!---****************************************************** 
      Get the Account Exec or Account Supervior for a project 
	 *****************************************************--->
   <cffunction name="getSalesRep" access="public" returntype="query">
     <cfargument name="account_exec" type="numeric" required="no">
     <cfargument name="ShowOnlySupervisor" required="NO" type="boolean">
       
	     <cfquery name="getSalesRep" datasource="#Instance.projdsn#">
			SELECT * 
			FROM salesReps S
			WHERE  Status = 1
			<cfif IsDefined("arguments.ShowOnlySupervisor")>
			  AND  supervisor
			  <cfif Arguments.ShowOnlySupervisor>
			   = 1
			  <cfelse>  
			    = 0
			  </cfif>
			</cfif>
			<cfif IsDefined("Arguments.account_exec")>
			AND S.ID = #Arguments.account_exec#
			</cfif>
		 </cfquery>
		 
		 <cfreturn getSalesRep />
   </cffunction>
   
   <!---************************************** 
      Get the Guide Writer for a project 
	 *************************************--->
   <cffunction name="getGuideWriter" access="public" returntype="query">
      <cfargument name="project_code" type="string" required="no">
    
	  <cfif IsDefined("arguments.project_code")>
	    <CFQUERY NAME="getGuideWriters" DATASOURCE="#Instance.projdsn#">
			SELECT m.Moderator_ID as GuideWriterID, m.first_name, m.last_name, m.Email_address, m.Vmailbox, m.Notes, p.guide_writer
			FROM moderator m, piw p
			WHERE m.moderator_id = p.guide_writer 
			AND p.project_code = '#arguments.project_code#'
	    </cfquery>
	  <cfelse>
	     <CFQUERY NAME="getGuideWriters" DATASOURCE="#Instance.projdsn#">
			SELECT Moderator_ID as GuideWriterID, Last_Name, First_Name, Moderator_initials, Email_address, Vmailbox, Notes, GuideWriter 
			FROM moderator 
			WHERE guidewriter = '1' 
			ORDER BY Last_Name, First_Name
	    </cfquery>
	    
	  </cfif>

	 
	 <cfreturn getGuideWriters />
   </cffunction>
   
   <!---************************************* 
     Get The moderator of a certain project 
	 *************************************--->
   <cffunction name="getPIWModerator" access="public" returntype="query">
       <cfargument name="Project_code" type="string" required="yes">
       <cfquery name="GetModerator" datasource="#Instance.projdsn#">
			SELECT moderator_id 
			FROM  piw_moderators 
			WHERE project_code = '#Arguments.project_code#' 
	   </cfquery>
	   
	   <cfreturn GetModerator />
   </cffunction>
   
    <!---************************************** 
	  Get Honoraria of a certain project 
	  **************************************--->
   <cffunction name="getHonoraria" access="public" returntype="query">
       <cfargument name="HonoriaID" type="string" required="yes">
	   <cfquery name="gethonoraria" datasource="#instance.projdsn#">
			SELECT * 
			FROM honoraria_type 
			WHERE honoraria_id = '#arguments.HonoriaID#'
	   </cfquery>   
		<cfreturn gethonoraria />
   </cffunction>
   
   <!---************************************** 
	  Get Honoraria typest 
	  **************************************--->
   <cffunction name="getHonorariaType" access="public" returntype="query">
	   <cfquery name="gethonoraria" datasource="#instance.projdsn#">
			SELECT * 
			FROM honoraria_type 
			order By honoraria_value, honoraria_id
	   </cfquery>   
		<cfreturn gethonoraria />
   </cffunction>
   
    <!---***************************************
	   Get the Pharmakon staff ID and Type  
	  ***************************************--->
   <cffunction name="getStaffID" access="public" returntype="query">
       <cfargument name="project_code" type="string" required="yes">
	   <cfargument name="StaffType" type="string" required="no">
	   
	    <cfquery name="getspeakerid" datasource="#instance.projdsn#">
			select Distinct staff_id, staff_type
			FROM schedule_meeting_time
			WHERE project_code = '#arguments.project_code#' 
			AND staff_type = #arguments.StaffType#
			AND Staff_ID IS NOT NULL
			AND Staff_ID <> ' '
			ORDER BY staff_id, staff_type
		</cfquery>	  
		<cfreturn getSpeakerID />
   </cffunction>
   
   <!---***************************************** 
       Get Database Stats of a certain project 
	 ****************************************--->
   <cffunction name="getDBStats" access="public" returntype="query">
       <cfargument name="project_code" type="string" required="yes">
	   
		<cfquery name="getdbstats" datasource="#instance.projdsn#">
			SELECT *
			FROM database_info 
			WHERE project_code = '#arguments.project_code#'
			ORDER BY rowid
		</cfquery>  
		<cfreturn getDbStats />
   </cffunction>
   
   <!---************************************** 
     Get Recruiters of a certain project 
	 **************************************--->
   <cffunction name="getRecruiter" access="public" returntype="query">
       <cfargument name="RecruiterID" type="string" required="no">
	   
		<CFQUERY NAME="getRecruiter" DATASOURCE="#instance.ProjDSN#" >
			SELECT ID, recruiter_name 
			FROM recruiter 
			<cfif IsDefined("arguments.RecruiterID")>
			 Where ID = <cfqueryparam value="#Arguments.RecruiterID#" cfsqltype="CF_SQL_INTEGER">
			</cfif>
			ORDER BY recruiter_name
		</CFQUERY>
		<cfreturn getRecruiter />
   </cffunction>
   
     <!---********************************************** 
	    Get Call Conference Company of a certain project 
	   **********************************************--->
   <cffunction name="getConfCompany" access="public" returntype="query">
       <cfargument name="ConferenceComID" type="string" required="no">
	   
		<CFQUERY NAME="getConfCompany" DATASOURCE="#instance.ProjDSN#" >
			SELECT ID, conf_company_name 
			 FROM conference_company 
			<cfif IsDefined("arguments.ConferenceComID")>
			 Where ID = <cfqueryparam value="#Arguments.ConferenceComID#" cfsqltype="CF_SQL_INTEGER">
			</cfif>
			ORDER BY conf_company_name
		</CFQUERY>
		<cfreturn getConfCompany />
   </cffunction>
     <!---********************************************** 
	    Get The Creative Information of a certain project 
	   **********************************************--->
   <cffunction name="GetCreativeInfo" access="public" returntype="query">
       <cfargument name="Project_Code" type="string" required="yes">
	   
		<CFQUERY NAME="GetCreativeInfo" DATASOURCE="#instance.ProjDSN#" >
			Select *
			From creative_info
			Where project_code = '#Arguments.Project_Code#'
		</CFQUERY>
		<cfreturn GetCreativeInfo />
   </cffunction>
   
   
</cfcomponent>