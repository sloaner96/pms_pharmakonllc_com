<cfoutput>

<cfset today = DateFormat(now(), "m/d/yyyy")>	
<cfset twomonths = dateAdd('m', -2, today)>   
<cfset time = TimeFormat(now(), "h:mm:ss tt")>

 <cfquery name="delete_old_data" datasource="#application.projdsn#">
			delete
			from schedule
			where Date <= '#DateFormat(twomonths, "m/d/yyyy")#'
		</cfquery> 
		
		
<!---Update Meetings --->
<cfquery name="data" datasource="#application.projdsn#">
select * 
from ScheduleMaster
where 
MeetingDate >= '#DateFormat(twomonths, "m/d/yyyy")#'
order by projectid
</cfquery>

<cfloop query="data">
<cfquery name="get_desc" datasource="#application.projdsn#"> 
Select project_code, product
		     From PIW
			Where project_code = '#data.projectid#'
			 </cfquery> 

<cfquery name="insert" datasource="#application.projdsn#">
INSERT into Schedule 
       (
		Project, 
		MeetingCode, 
		Date, 
		Time 
		
		)
        VALUES 
        (
		'#get_desc.product#', 
		'#data.projectid#',
		'#DateFormat(data.MeetingDate, "m/d/yyyy")#',		
		'#DateFormat(data.MeetingDate, "m/d/yyyy")# #TimeFormat(data.MtgStartTime, "h:mm:ss tt")#'
		)
</cfquery>

</cfloop>  
 
 
<!--- Update Mods Lead--->

 <cfquery name="data2" datasource="#application.projdsn#">
select * 
from ScheduleSpeaker
Where 
type ='MOD' and Activitytype= 'Lead' and
MeetingDate >= '#DateFormat(twomonths, "m/d/yyyy")#'
</cfquery>

<cfloop query="data2">
 
 <cfquery name="getmod1id" datasource="#application.speakerDSN#">
select speakerid, firstname, lastname
from Speaker	
where 
speakerid = '#data2.speakerid#' and type ='MOD'
</cfquery>
<cfquery name="update" datasource="#application.projdsn#">
        UPDATE Schedule 
		SET
		Moderator1FirstName = '#getmod1id.firstname#', 
		Moderator1LastName = '#getmod1id.lastname#' 				
		Where 
        MeetingCode = '#Left(data2.MeetingCode, 9)#' and
		Date = '#DateFormat(data2.Meetingdate, "m/d/yyyy")#' and 
		Time = '#DateFormat(data2.Meetingdate, "m/d/yyyy")# #TimeFormat(data2.MtgStartTime, "h:mm:ss tt")#'
      </cfquery>
</cfloop> 

<!--- Update Mods Listen--->

 <cfquery name="data3" datasource="#application.projdsn#">
select * 
from ScheduleSpeaker
Where 
type ='MOD' and Activitytype= 'Listen' and
MeetingDate >= '#DateFormat(twomonths, "m/d/yyyy")#'
</cfquery>

<cfloop query="data3">
 
 <cfquery name="getmod2id" datasource="#application.speakerDSN#">
select speakerid, firstname, lastname
from Speaker	
where 
speakerid = '#data3.speakerid#' and type ='MOD'
</cfquery>
<cfquery name="update" datasource="#application.projdsn#">
        UPDATE Schedule 
		SET
		Moderator2FirstName = '#getmod2id.firstname#', 
		Moderator2LastName = '#getmod2id.lastname#' 				
		Where 
        MeetingCode = '#Left(data3.MeetingCode, 9)#' and
		Date = '#DateFormat(data3.Meetingdate, "m/d/yyyy")#' and
		Time = '#DateFormat(data3.Meetingdate, "m/d/yyyy")# #TimeFormat(data3.MtgStartTime, "h:mm:ss tt")#'
      </cfquery>
</cfloop> 

 
<!--- Update Speakers Lead--->

<cfquery name="data4" datasource="#application.projdsn#">
select * 
from ScheduleSpeaker
Where 
type ='SPKR' and Activitytype= 'Lead' and
MeetingDate >= '#DateFormat(twomonths, "m/d/yyyy")#'
</cfquery>

<cfloop query="data4">
 
 <cfquery name="getspkr1id" datasource="#application.speakerDSN#">
select speakerid, firstname, lastname
from Speaker	
where 
speakerid = '#data4.speakerid#' and type ='SPKR'
</cfquery>
<cfquery name="update" datasource="#application.projdsn#">
        UPDATE Schedule 
		SET
		Speaker1FirstName = '#getspkr1id.firstname#', 
		Speaker1LastName = '#getspkr1id.lastname#' 				
		Where 
        MeetingCode = '#Left(data4.MeetingCode, 9)#' and
		Date = '#DateFormat(data4.Meetingdate, "m/d/yyyy")#' and
		Time = '#DateFormat(data4.Meetingdate, "m/d/yyyy")# #TimeFormat(data4.MtgStartTime, "h:mm:ss tt")#'
      </cfquery>
</cfloop>

<!--- Update Speakers Listen--->

 <cfquery name="data5" datasource="#application.projdsn#">
select * 
from ScheduleSpeaker
Where 
type ='SPKR' and Activitytype= 'Listen' and
MeetingDate >= '#DateFormat(twomonths, "m/d/yyyy")#'
</cfquery>

<cfloop query="data5">
 
 <cfquery name="getspkr2id" datasource="#application.speakerDSN#">
select speakerid, firstname, lastname
from Speaker	
where 
speakerid = '#data5.speakerid#' and type ='SPKR'
</cfquery>
<cfquery name="update" datasource="application.projdsn">
        UPDATE Schedule 
		SET
		Speaker2FirstName = '#getspkr2id.firstname#', 
		Speaker2LastName = '#getspkr2id.lastname#' 				
		Where 
        MeetingCode = '#Left(data5.MeetingCode, 9)#' and
		Date = '#DateFormat(data5.Meetingdate, "m/d/yyyy")#' and
		Time = '#DateFormat(data4.Meetingdate, "m/d/yyyy")# #TimeFormat(data5.MtgStartTime, "h:mm:ss tt")#'
      </cfquery>
</cfloop>
 
  
  
   <cflocation url="grid/index.cfm?startdate=#url.startdate#&enddate=#url.enddate#&projectfilter=#url.projectfilter#" addtoken="No"> 
</cfoutput> 