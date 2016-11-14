<cfoutput>

<cfset today = DateFormat(now(), "m/d/yyyy")> 
<cfset time = TimeFormat(now(), "h:mm:ss tt")>  

<!--- Create Meeting Code --->
<cfset MeetingCodeDate = '#Right(form.year, 2)##form.month##form.day#'>

<cfset MeetingCodeTime = '#form.start_hour##Left(form.start_minute, 1)#A'>

<cfset MeetingCode = '#trim(form.project)##trim(MeetingCodeDate)#-#trim(MeetingCodeTime)#'>
<!--- end --->

<!--- Create Meeting Date --->
<cfif #Left(form.month, 1)# is 0>
<cfset month = '#Right(form.month, 1)#'>
<cfelse>
<cfset month = '#form.month#'>
</cfif>

<cfif #Left(form.day, 1)# is 0>
<cfset day = '#Right(form.day, 1)#'>
<cfelse>
<cfset day = '#form.day#'>
</cfif>
<cfset MeetingDate = '#month#/#day#/#form.year#'>
<!--- end --->

<!--- Create Meeting Time --->
<cfif #Left(form.start_hour, 1)# is 0>
<cfset start_hour = '#Right(form.start_hour, 1)#'>
<cfelse>
<cfset start_hour = '#form.start_hour#'>
</cfif>
<cfset start_time = '#MeetingDate# #start_hour#:#form.start_minute#:00 #form.start_day_night#'>

<!--- <cfif #Left(form.end_hour, 1)# is 0>
<cfset end_hour = '#Right(form.end_hour, 1)#'>
<cfelse>
<cfset end_hour = '#form.end_hour#'>
</cfif>
<cfset end_time = '#MeetingDate# #end_hour#:#form.end_minute#:00 #form.end_day_night#'> --->
<!--- end --->

<cfscript>hour_end = #TimeFormat(start_time, "h:mm:ss tt")#;    
    new_hour = createTimeSpan(0,1,0,0);    
    end_time0 = hour_end + new_hour;
</cfscript>

<cfset end_time = '#MeetingDate# #TimeFormat(end_time0, "h:mm:ss tt")#'>

<!--- Get Phone Numbers --->
<cfquery name="get_phone" datasource="#application.projdsn#"> 
	   Select speaker_listenins, helpline
		      From PIW
			  Where project_code = '#Trim(form.project)#'	  
	  </cfquery>
	  <!--- end --->

<!--- Insert into Scedule Master --->
  <cfquery name="insert_meeting" datasource="#application.projdsn#"> 
	      Insert Into ScheduleMaster(   
	projectid,
	MeetingCode,
	MeetingDate,
	MtgStartTime,
	MtgEndTime,
	Status,	
	Training,
	Remarks,
	Password,
	LeaderPhone,
	ParticipantPhone,
	DateAdded,
	AddedBy,
	LastUpdated,
	UpdatedBy
	   
 ) 		
			VALUES(
    '#form.project#',
	'#MeetingCode#',
	'#MeetingDate#',
	'#start_time#',
	'#end_time#',
	'#form.Status#',
	'#form.meetingtraining#',
	'#form.remarks#',
	'#form.password#',
	'#get_phone.speaker_listenins#',
	'#get_phone.helpline#',
	'#today# #time#',
	'#session.user#',
	'',
	'#session.user#'
			)
	  </cfquery> 

<!--- end --->

<!--- Go To meeting Edit Page --->


 <cflocation url="new_meeting.cfm?added=yes&project=#Trim(form.project)#&meetingcode=#MeetingCode#&month=#DateFormat(MeetingDate, "m")#&year=#DateFormat(MeetingDate, "yyyy")#&day=#DateFormat(MeetingDate, "d")#" addtoken="No"> 
</cfoutput> 