<cfoutput>
<cfset todaydate = DateFormat(Now(), "m/d/yyyy")>
<cfset todaytime = TimeFormat(Now(), "h:m:s tt")>


<cfif isDefined("form.days")> 

<cfset from_day1 = "#form.startmonth#/#form.startday#/#form.startyear#">
<cfset from_day2 = DateFormat(from_day1, "mm/dd/yyyy")>
<cfset to_day1 = "#form.endmonth#/#form.endday#/#form.endyear#">
<cfset to_day2 = DateFormat(to_day1, "mm/dd/yyyy")>

<cfquery name="insert_unavailability1" datasource="#application.speakerDSN#">
delete 
from 
SpeakerAvailable
where 
speakerID = '#form.speakerid#' and
availfromdate >= '#from_day2#' and
availtodate <= '#to_day2#'
</cfquery> 


<cfelseif isDefined("form.time")> 

<cfset from_day1 = "#form.startmonth2#/#form.startday2#/#form.startyear2#">
<cfset from_day2 = DateFormat(from_day1, "m/d/yyyy")>
<cfset to_day1 = "#form.startmonth2#/#form.startday2#/#form.startyear2#">
<cfset to_day2 = DateFormat(to_day1, "mm/dd/yyyy")>

<cfquery name="delete_unavailability1" datasource="#application.speakerDSN#">
Delete from SpeakerAvailable 
where
speakerID = '#form.speakerid#' and
availfromdate = '#DateFormat(from_day2, "m/d/yyyy")#' and
availfromtime >= '#DateFormat(from_day2, "m/d/yyyy")# #form.starthour#:#form.startminute#:00 #form.startam#' and
availtotime <= '#DateFormat(to_day2, "m/d/yyyy")# #form.tohour#:#form.tominute#:00 #form.toam#'
</cfquery>  
</cfif>



 <cflocation url="available.cfm?id=#form.speakerid#" addtoken="No">  























</cfoutput>