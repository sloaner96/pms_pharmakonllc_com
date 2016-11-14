<!---
    $Id: ,v 1.0 2006/00/00 rsloan Exp $
    Copyright (c) 2006 Pharmakon, LLC.

    Description:
        
    Parameters:
        
    Usage:
        
    Documentation:
        
    Based on:
        
--->
<font face="verdana" size="-2">
<cfquery name="getSched" datasource="#application.projdsn#"> 
  Select *
  From dbo.ScheduleMaster
  Order By MeetingCode
</cfquery>

<cfflush interval="10">
<cfoutput query="getSched">
   <cfquery name="getSpkr" datasource="#application.projdsn#"> 
    Select *,
	  (Select firstname+' '+Lastname
	    From Speaker.dbo.Speaker
		Where speakerid = S.Staff_ID
		AND S.Staff_ID <> 0) SpkrName 
    From dbo.ScheduleSpeaker S
	WHere Rtrim(meeting_Code) = '#Trim(getSched.meetingCode)#'
	AND staff_type IN (2,5,6,7)
   </cfquery>
   
   <cfif getSpkr.recordcount GT 0>
     #Left(getSched.meetingCode,9)# #DateFormat(getSched.MeetingDate, 'MM/DD/YYYY')# #TimeFormat(MtgStartTime, 'hh:mm tt')# FOUND<br>
     #getSpkr.staff_id#--#getSpkr.speakerid#:#getSpkr.SpkrName#<br><br>
	 <cfif Len(Trim(getSpkr.SpkrName)) GT 0>
	    <cfquery name="CreateSpkr" datasource="#application.projdsn#"> 
		  Insert Into ScheduleSpeaker(ScheduleID, StaffID, StaffType)
		  Values(#getSched.ScheduleID#, #getSpkr.Staff_ID#, #getSpkr.Staff_Type#)
		</cfquery>
	    
	 </cfif>
   </cfif>
</cfoutput>
</font>