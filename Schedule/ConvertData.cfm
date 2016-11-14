<cfquery name="getOLDMOD" datasource="#application.projdsn#"> 
  Select Rtrim(meeting_code) as meeting_code, [year], [month], [day], start_time, end_time, remarks, rowID
  From ScheduleSpeaker
  Where [Year] > = 2006
  Order By Meeting_Code
</cfquery> 

<!--- <cfquery name="getOLDSPKR" datasource="#application.projdsn#"> 
  Select *
  From ScheduleSpeaker
  Where [Year] > = 2006
  <!--- AND Staff_Type IN (1, 3, 4) --->
  AND Staff_Type IN (2, 5, 6, 7)
  Order By [month], [day], Project_Code
</cfquery>  ---> 

<cfoutput query="getOLDMOD">
  <cfset properDate = CreateDate(getOLDMOD.year, getOLDMOD.month, getOLDMOD.day)>
    
	
  <cfset startHour = left(getOLDMOD.start_time, 2)>
	
	<cfset startMinutes = right(getOLDMOD.start_time, 2)>
	<cfif StartMinutes EQ 50>
	  <cfset StartMinutes = 30>
	</cfif>
	<cfif StartHour LTE 23>
		<cfset StartTimeString = "#startHour#:#startMinutes#">
		<cfset StartTime = CreateODBCTime(StartTimeString)>
		<cfset StartTime = TimeFormat(StartTime, 'hh:mm tt')>
	<cfelse>
	   <cfset StartTimeString = "00:#startMinutes#">
	   <cfset StartTime = CreateODBCTime(StartTimeString)>
	   <cfset StartTime = TimeFormat(StartTime, 'hh:mm tt')>
	</cfif>
	
	<cfset EndHour = left(getOLDMOD.End_time, 2)>
	<cfset EndMinutes = right(getOLDMOD.End_time, 2)>
	<cfif EndMinutes EQ 50>
	  <cfset EndMinutes = 30>
	</cfif>
	<cfif EndHour LTE 23>
	 <cfset EndTimeString = "#EndHour#:#EndMinutes#">
	 <cfset EndTime = CreateODBCTime(EndTimeString)>
	 <cfset EndTime = TimeFormat(EndTime, 'hh:mm tt')>
	<cfelse>
	  <cfset EndTimeString = "00:#EndMinutes#">
	 <cfset EndTime = CreateODBCTime(EndTimeString)>
	 <cfset EndTime = TimeFormat(EndTime, 'hh:mm tt')> 
	</cfif>
    
	<cfset ProperStartDate = "#DateFormat(ProperDate, 'MM/DD/YYYY')# #StartTime#"> 
	<cfset ProperEndDate = "#DateFormat(ProperDate, 'MM/DD/YYYY')# #EndTime#">
	
	
	<!--- Check to see if there is a meeting for this code and this time already in the database, if so don't add a new one. --->
	<cfquery name="chkDup" datasource="#application.projdsn#"> 
	   Select ScheduleID
	   From ScheduleMaster
	   Where meetingcode = '#Trim(getOLDMOD.meeting_code)#'
	   AND meetingdate = #CreateODBCDATE(properDate)#
	   AND mtgStartTime = #CreateODBCDATETime(properStartDate)#
	</cfquery>
	
	<cfif chkdup.recordcount EQ 0>
	ADDED '#Trim(getOLDMOD.meeting_code)#' ,#ProperStartDate#- #ProperEndDate#<br>
	<cfquery name="AddSchedule" datasource="#application.projdsn#"> 
	  Insert Into dbo.ScheduleMaster(
	       meetingCode, 
		   MeetingDate, 
		   MtgStartTime, 
		   MtgEndTime, 
		   Status, 
		   Remarks, 
		   DateAdded, 
		   AddedBy
		   )
	  VALUES(
	       '#Trim(getOLDMOD.meeting_code)#',
	        #CreateODBCDATE(properDate)#,
			#CreateODBCDATETime(properStartDate)#,
			#CreateODBCDATETime(properEndDate)# ,
			1,
			<cfif Len(Trim(getOLDMOD.remarks)) GT 0>'#Trim(getOLDMOD.remarks)#'<cfelse>NULL</cfif>,
			#CreateODBCDateTime(Now())#,
			0
	  )
	SELECT @@IDENTITY AS NewID
	</cfquery>
	
	<cfquery name="AddID" datasource="#application.projdsn#"> 
	   Update dbo.ScheduleSpeaker
	   Set NEWSchedID = #AddSchedule.NEWID#
	   Where RowID = #getOLDMOD.RowID#
	</cfquery>
	<cfelse>
	   	<cfquery name="AddID" datasource="#application.projdsn#"> 
	      Update dbo.ScheduleSpeaker
	      Set NEWSchedID = #chkdup.ScheduleID#
	      Where RowID = #getOLDMOD.RowID#
	    </cfquery>
	</cfif>
</cfoutput>
