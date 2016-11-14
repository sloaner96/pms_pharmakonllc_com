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
   <cfquery name="getMod" datasource="#application.projdsn#"> 
    Select *,
	  (Select Top 1 first_name+' '+Last_name as name
	     From dbo.User_ID
		 Where mod_id = S.Staff_ID
		 AND S.Staff_ID IS NOT NULL
		 AND S.Staff_ID <> 0) ModName
    From dbo.ScheduleSpeaker S
	WHere Rtrim(meeting_Code) = '#Trim(getSched.meetingCode)#'
	AND staff_type IN (1,3,4)
   </cfquery>
   
   <cfif getMod.recordcount GT 0>
     #Left(getSched.meetingCode,9)# #DateFormat(getSched.MeetingDate, 'MM/DD/YYYY')# #TimeFormat(MtgStartTime, 'hh:mm tt')# FOUND<br>
     #getMod.ModName#<br><br>
	 <cfif Len(Trim(getMod.ModName)) GT 0>
	    <cfquery name="CreateMOD" datasource="#application.projdsn#"> 
		  Insert Into ScheduleSpeaker(ScheduleID, StaffID, StaffType)
		  Values(#getSched.ScheduleID#, #getMod.Staff_ID#, #getMod.Staff_Type#)
		</cfquery>
	    
	 </cfif>
   </cfif>
</cfoutput>
</font>