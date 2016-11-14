<cfoutput>
<!--- #DateFormat(session.MeetingDate, "m/d/yyyy")# #TimeFormat(session.start_time, "h:mm:ss tt")#
<cfabort> --->

 <cfif IsDefined("url.delete")>
  <cfquery name="delete" datasource="#application.projdsn#">
	      Delete
		  from  ScheduleMaster	        
		  WHERE meetingCode = '#url.meetingCode#'
	  </cfquery>
	  
	   <cfquery name="speakrs" datasource="#application.projdsn#">
	    Delete
		From ScheduleSpeaker
		WHERE meetingCode = '#url.meetingCode#'
	
	 </cfquery>      
	
		  
 <cflocation url="zoom_Schedule.cfm?day=#url.day#&month=#url.month#&year=#url.year#&message=deleted" addtoken="No">
<cfabort>
</cfif>


<cfset date = DateFormat(now(), "mm/dd/yyyy")>
<cfset time = timeFormat(now(), "hh:mm:tt")>
<cfset update_log = '#date# #time#'>

<cfif IsDefined("FORM.MOD")>
 <cfquery name="insert_MOD" datasource="#application.projdsn#"> 
	      Insert Into ScheduleSpeaker(   
	ScheduleID,
	MeetingCode,
	MeetingDate,
	MtgStartTime,
	MtgEndTime,	
	SpeakerID,
	Type,
	activityType,	  
	Confirmed
	   
 ) 		
			VALUES(
	'#Session.ScheduleID#',
	'#session.meetingCode#',
	'#session.MeetingDate#',
	'#session.start_time#',
	'#session.end_time#',	
	'#Form.MOD#',
	'MOD',
	'Lead',
	'0'
			)
	  </cfquery> 	
	      <!--- Inserted Lead Mod <br> --->
		  
		     <cfquery name="update_log" datasource="#application.projdsn#"> 
	      UPDATE ScheduleMaster
	        SET  LastUpdated = '#update_log#', 
				 UpdatedBy = '#session.user#'
		  WHERE meetingCode = '#session.meetingCode#'
	  </cfquery>  
	   <!--- Updated Log <br> --->	  
		  </cfif>	  
		  	  
		 <cfif  IsDefined("FORM.MOD_list")>
		  <cfquery name="insert_MOD" datasource="#application.projdsn#"> 
	     Insert Into ScheduleSpeaker(   
	ScheduleID,
	MeetingCode,
	MeetingDate,
	MtgStartTime,
	MtgEndTime,	
	SpeakerID,
	Type,
	activityType,	  
	Confirmed		   
 ) 		
			VALUES(
	'#Session.ScheduleID#',
	'#session.meetingCode#',
	'#session.MeetingDate#',
	'#session.start_time#',
	'#session.end_time#',	
	'#Form.MOD_list#',
	'MOD',
	'Listen',
	'0'
			)
	  </cfquery> 
	
	      <!--- Inserted Mod Listener<br> --->
		  
    <cfquery name="update_log" datasource="#application.projdsn#"> 
	      UPDATE ScheduleMaster
	        SET  LastUpdated = '#update_log#', 
				 UpdatedBy = '#session.user#'
		  WHERE meetingCode = '#session.meetingCode#'
	  </cfquery>  
		  
		</cfif>  
		 
		   <cfif  IsDefined("FORM.SPKR")>
		   <cfquery name="insert_speaker" datasource="#application.projdsn#"> 
	     	      	     Insert Into ScheduleSpeaker(   
	ScheduleID,
	MeetingCode,
	MeetingDate,
	MtgStartTime,
	MtgEndTime,	
	SpeakerID,
	Type,
	activityType,	  
	Confirmed		   
 ) 		
			VALUES(
	'#Session.ScheduleID#',
	'#session.meetingCode#',
	'#session.MeetingDate#',
	'#session.start_time#',
	'#session.end_time#',	
	'#Form.SPKR#',
	'SPKR',
	'Lead',
	'0'
			)
	  </cfquery> 
	<!--- Inserted Speaker <br> --->
	
 <cfquery name="update_log" datasource="#application.projdsn#"> 
	      UPDATE ScheduleMaster
	        SET  LastUpdated = '#update_log#', 
				 UpdatedBy = '#session.user#'
		  WHERE meetingCode = '#session.meetingCode#'
	  </cfquery>  
	
	</cfif>	
				  
		<cfif  IsDefined("FORM.SPKR_lis")>  
		   <cfquery name="insert_speaker" datasource="#application.projdsn#"> 
	     	      	      Insert Into ScheduleSpeaker(   
	ScheduleID,
	MeetingCode,
	MeetingDate,
	MtgStartTime,
	MtgEndTime,	
	SpeakerID,
	Type,
	activityType,	  
	Confirmed		   
 ) 		
			VALUES(
	'#Session.ScheduleID#',
	'#session.meetingCode#',
	'#session.MeetingDate#',
	'#session.start_time#',
	'#session.end_time#',	
	'#Form.SPKR_lis#',
	'SPKR',
	'Listen',
	'0'
			)
	  </cfquery> 
	<!--- Inserted Speaker Listener<br> --->
	
	 <cfquery name="update_log" datasource="#application.projdsn#"> 
	      UPDATE ScheduleMaster
	        SET  LastUpdated = '#update_log#', 
				 UpdatedBy = '#session.user#'
		  WHERE meetingCode = '#session.meetingCode#'
	  </cfquery>  
	</cfif>
	
	
	             <!---Delete Entry  --->			
			<cfif IsDefined("url.delete_speaker")>
	  <cfquery name="delete_lead_mod" datasource="#application.projdsn#"> 
	    Delete 
		From ScheduleSpeaker		
		Where ScheduleID = '#session.ScheduleID#' and
		SpeakerId ='#url.delete_speaker#' and activityType = '#url.activityType#'
		
	 </cfquery>   	
	 <cfquery name="update_log" datasource="#application.projdsn#"> 
	      UPDATE ScheduleMaster
	        SET  LastUpdated = '#update_log#', 
				 UpdatedBy = '#session.user#'
		  WHERE meetingCode = '#session.meetingCode#'
	 </cfquery>  
	 
	   		
<cfif #Left(url.delete_speaker, 1)# is 0>
			
<cfelse>
	 <cfquery name="delete_avail" datasource="#application.speakerDSN#">			 
	     delete from SpeakerAvailable
	     where
		 speakerID =  '#url.delete_speaker#' and
		 availtodate =  '#DateFormat(session.MeetingDate, "m/d/yyyy")#' and
		 availfromtime = '#DateFormat(session.MeetingDate, "m/d/yyyy")# #TimeFormat(session.start_time, "h:mm:ss tt")#'
	  </cfquery>
</cfif></cfif>
	 
	   <!---Confirm Entry  --->
	
			<cfif IsDefined("url.confirm_speaker")>  
	   <cfquery name="confirm" datasource="#application.projdsn#"> 
	     UPDATE ScheduleSpeaker
		 
	        SET  <cfif url.Confirmed is 0>Confirmed = '1'<cfelse> Confirmed = '0'</cfif>							 
		  Where ScheduleID = '#session.ScheduleID#' and
		SpeakerId ='#url.confirm_speaker#' and activityType = '#url.activityType#'
	 </cfquery>
 
			 
	  <cfquery name="insert_unavailability1" datasource="#application.speakerDSN#">
INSERT into SpeakerAvailable 
       (speakerID, availfromdate, availtodate, availfromtime, availtotime, allday, availtype, updated, updatedby, MeetingCode)
VALUES ('#url.confirm_speaker#', '#DateFormat(session.MeetingDate, "m/d/yyyy")#', '#DateFormat(session.MeetingDate, "m/d/yyyy")# ', '#DateFormat(session.MeetingDate, "m/d/yyyy")# #TimeFormat(session.start_time, "hh:mm:ss tt")#', '#DateFormat(session.MeetingDate, "m/d/yyyy")# #TimeFormat(session.end_time, "hh:mm:ss tt")#', '0', 'NA', '#update_log#', '#session.user#', '#session.meetingCode#')
     </cfquery>  	
			 
	 		     <cfquery name="update_log" datasource="#application.projdsn#"> 
	      UPDATE ScheduleMaster
	        SET  LastUpdated = '#update_log#', 
				 UpdatedBy = '#session.user#'
		  WHERE meetingCode = '#session.meetingCode#'
	  </cfquery>  
	    <!--- Updated Log <br> --->
	 
	 <!--- Deleted Entry <br> ---> 
	 </cfif>
	 	              <!--- Update Meeting --->
		  
		<cfif  IsDefined("FORM.update_master")>    
		   
      <cfquery name="updproj" datasource="#application.projdsn#"> 
	      UPDATE ScheduleMaster
	        SET  Status ='#Form.Status#',
			     Remarks = '#Form.Remarks#',
			     password ='#Form.password#',
			     LastUpdated = '#update_log#', 
				 UpdatedBy = '#session.user#'
		  WHERE meetingCode = '#session.meetingCode#'
	  </cfquery>  
	    <!--- Updated Meeting <br> --->
	  </cfif>
	  
	  
 <cflocation url="edit_Schedule.cfm?day=#session.day#&month=#session.month#&year=#session.year#&meetingcode=#session.meetingCode#" addtoken="No">  
	
		  </cfoutput>
		  
		  