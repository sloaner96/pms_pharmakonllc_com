<cfoutput>
<cfset todaydate = DateFormat(Now(), "m/d/yyyy")>
<cfset todaytime = TimeFormat(Now(), "h:m:s tt")>


<cfif isDefined("form.days")> 
<!--------------------------------------- Days ------------------------------------------------------->

<cfset from_day1 = "#form.startmonth#/#form.startday#/#form.startyear#">
<cfset from_day2 = DateFormat(from_day1, "mm/dd/yyyy")>
<cfset to_day1 = "#form.endmonth#/#form.endday#/#form.endyear#">
<cfset to_day2 = DateFormat(to_day1, "mm/dd/yyyy")>

<cfset i = #DateDiff("d", "#from_day2#", "#to_day2#")#>
<cfset i = i+1>

<cfset days = #DateFormat(from_day2, "m/d/yyyy")#>
<cfset the_day = '#DateFormat(from_day2, "m/d/yyyy")#'>

<cfloop index="i" from="1" to="#i#">

<cfquery name="confirmed_spkr" datasource="#application.projdsn#"> 
Select *   
From ScheduleSpeaker
Where 
speakerID = '#form.speakerid#' and 
MeetingDate = '#DateFormat(the_day, "m/d/yyyy")#'
 </cfquery> 

 <cfif confirmed_spkr.recordcount gte 1>
 
<cflocation url="unavailable_edit.cfm?id=#form.speakerid#&meetingdate=#DateFormat(the_day, "m/d/yyyy")#&conflict=yes&message=day" addtoken="No">
 
 <cfabort>
<cfelse>
<cfquery name="insert_unavailability1" datasource="#application.speakerDSN#">
INSERT into SpeakerAvailable 
       (
		speakerID, 
		availfromdate, 
		availtodate, 
		availfromtime,
		availtotime,
		allday,
		availtype,
		updated,
		updatedby,
		MeetingCode
		)
        VALUES 
        (
		'#form.speakerid#',
		'#DateFormat(the_day, "m/d/yyyy")#',
		'#DateFormat(the_day, "m/d/yyyy")#',	
		'#DateFormat(the_day, "m/d/yyyy")# 12:01 AM',
		'#DateFormat(the_day, "m/d/yyyy")# 11:59 PM',
		'1',
		'#type#',
		'#todaydate# #todaytime#',
		'#session.user#',
		''
				)
</cfquery> 
 </cfif>
 
<cfset the_day = '#DateAdd("d", i, "#days#")#'>

</cfloop>

<!--------------------------------------- Time ------------------------------------------------------->
<cfelseif isDefined("form.time")> 

<cfset from_day1 = "#form.startmonth2#/#form.startday2#/#form.startyear2#">
<cfset from_day2 = DateFormat(from_day1, "mm/dd/yyyy")>
<cfset starttime0= '#form.starthour#:#form.startminute#:00 #form.startam#'>
<cfset starttime = #TimeFormat(starttime0, "h:mm tt")#> 
<cfset endtime0= '#form.tohour#:#form.tominute#:00 #form.toam#'>
<cfset endtime = #TimeFormat(endtime0, "h:mm tt")#> 

<cfquery name="confirmed2_spkr" datasource="#application.projdsn#"> 
Select MeetingDate,speakerID,convert(varchar(10),MtgStartTime,108) as mtgstarttime
From ScheduleSpeaker
Where speakerID = '#form.speakerid#' and  
MeetingDate = '#DateFormat(from_day2, "m/d/yyyy")#' and
substring(convert(varchar(10),mtgstarttime,108),1,5) between '#TimeFormat(starttime, "HH:MM")#' and '#TimeFormat(endtime, "HH:MM")#' 
</cfquery> 


 <cfif confirmed2_spkr.recordcount gte 1>
 
 <cflocation url="unavailable_edit.cfm?id=#form.speakerid#&meetingdate=#DateFormat(from_day2, "m/d/yyyy")#&starttime=#starttime#&endtime=#endtime#&conflict=yes&message=time" addtoken="No"> 
 
 <cfabort>
<cfelse>

 <cfquery name="insert_unavailability1" datasource="#application.speakerDSN#">
INSERT into SpeakerAvailable 
       (
		speakerID, 
		availfromdate, 
		availtodate, 
		availfromtime,
		availtotime,
		allday,
		availtype,
		updated,
		updatedby,
		MeetingCode
		)
        VALUES 
        (
		'#form.speakerid#',
		'#DateFormat(from_day2, "m/d/yyyy")#',
		'#DateFormat(from_day2, "m/d/yyyy")#',	
		'#DateFormat(from_day2, "m/d/yyyy")# #form.starthour#:#form.startminute#:00 #form.startam#',
		'#DateFormat(from_day2, "m/d/yyyy")# #form.tohour#:#form.tominute#:00 #form.toam#',
		'0',
		'#type#',
		'#todaydate# #todaytime#',
		'#session.user#',
		''
				)
</cfquery> 
</cfif>
</cfif>


 <cflocation url="unavailable_edit.cfm?id=#form.speakerid#" addtoken="No"> 
</cfoutput>