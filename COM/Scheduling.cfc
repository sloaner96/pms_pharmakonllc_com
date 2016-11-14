<cfcomponent name="utilities" output="NO" displayname="utilities">

   <!--- lock name is the name used to wrap file io/data ops --->
	<cfset LOCK_NAME = "util_cfc">
   <!--- Initialize datasources --->
	<cfset instance.projdsn = "PMS">
	
   <!--- Constructor --->
	<cfset init()>
	
   <!--------------------------- 
     Initialize the component 
	 --------------------------->
   <cffunction name="init" returnType="boolean" access="public">
	      <cfset instance.initialized = true>
	      <cfreturn instance.initialized />
   </cffunction>
   
   <cffunction name="excel2Query" returnType="query" access="public">
     <cfargument name="thisFile" required="YES" type="String">
	 <cfargument name="FirstRowISHeader" required="NO" type="boolean" default="false">
	 <cfargument name="SheetName" required="NO" type="String">
	 <cfargument name="SheetNum" required="NO" type="String">
	 <cfargument name="StartRow" required="NO" type="String" default="1">
	 <cfargument name="MaxRow" required="NO" type="String">
	 <cfargument name="LongNames" required="NO" type="boolean" default="true">
	 
     <cfx_excel2query
        file="#Arguments.thisfile#"
        firstRowIsHeader="#Arguments.FirstRowISHeader#"
        startRow="#Arguments.StartRow#"
        longNames="#Arguments.LongNames#"
        r_qResults="ThisOBJ"> 
	  
      <cfreturn thisOBJ />
   </cffunction>
   
    <!--------------------------- 
     get Moderators 
	 --------------------------->
   <cffunction name="getMods" returnType="query" access="public">
      
	  <cfset var qMods = "">
	  <cfquery name="qMods" datasource="#instance.projdsn#">
	     Select * From Moderator
		 order By last_name, First_name
	  </cfquery>
      
	  <cfreturn qMods />
   </cffunction> 
   
   <cffunction name="getMtgMods" returnType="query" access="public">
      <cfargument name="ScheduleID" type="numeric" required="Yes">
	  
	  <cfset var Mods = "">
	  <cfquery name="Mods" datasource="#instance.projdsn#">
	     Select StaffSchedID, StaffID, StaffType,
		   (Select first_name+' '+last_name
		     From User_ID
			 Where mod_id = StaffID) as ModName,
		   (Select CodeDesc
		     From Lookup
			 Where Codevalue = StaffType
			 AND CodeGroup = 'STAFFCODES') as StaffDesc	 
		 From dbo.ScheduleSpeaker
		 Where ScheduleID = #Arguments.ScheduleID#
		 AND StaffType IN (1,3,4)
		 order By StaffType, 4
	  </cfquery>
      
	  <cfreturn Mods />
   </cffunction> 
   
    <!--------------------------- 
     get Speakers
	 --------------------------->
   <cffunction name="getSpeakers" returnType="query" access="public">
      
	  <cfset var qMods = "">
	  <cfquery name="qMods" datasource="#instance.projdsn#">
	     Select * From Moderator
		 order By last_name, First_name
	  </cfquery>
      
	  <cfreturn qMods />
   </cffunction> 
   
   <cffunction name="getMtgSpkr" returnType="query" access="public">
      <cfargument name="ScheduleID" type="numeric" required="Yes">
	  
	  <cfset var spkr = "">
	  <cfquery name="spkr" datasource="#instance.projdsn#">
	     Select StaffSchedID, StaffID, StaffType, 
		   (Select firstname+' '+Lastname
	          From Speaker.dbo.Speaker
		      Where speakerid = S.StaffID) as SpkrName,
		   (Select CodeDesc
		     From Lookup
			 Where Codevalue = StaffType
			 AND CodeGroup = 'STAFFCODES') as StaffDesc	 
		 From dbo.ScheduleSpeaker S
		 Where ScheduleID = #Arguments.ScheduleID#
		 AND StaffType IN (2,5,6,7)
		 order By StaffType, 4
	  </cfquery>
      
	  <cfreturn spkr />
   </cffunction> 
    <!--------------------------- 
     get active Projects
	 --------------------------->
   <cffunction name="getactiveProjects" returnType="query" access="public">
      
	  <cfset var getproj = "">
	  <cfquery name="getproj" datasource="#instance.projdsn#">
	     Select project_code 
		 From piw
		 Where project_status IN (2, 3)
		 Order By project_code
	  </cfquery>
      
	  <cfreturn getproj />
   </cffunction> 
     <!--------------------------- 
     get Projects for a specific Day 
	 --------------------------->
   <cffunction name="DownloadSchedule" returnType="query" access="public">
      <cfargument name="thisMonth" required="YES" type="numeric">
	  <cfargument name="thisYear" required="YES" type="numeric">
	  <cfargument name="ProjectCode" required="NO" type="String">
	  
	  <cfset var getdownload = "">
	  
	  <cfquery name="getdownload" datasource="#instance.projdsn#">
	   Select left(meetingCode, 9) as projectCode, MtgStartTime, MtgEndTime, ScheduleID, Status, password, Remarks, DateAdded, LastUpdated, DateAdded, meetingCode, UpdatedBy, MeetingDate,
		   (Select CodeDesc
		      From Lookup
			  Where CodeGroup = 'MTGSTATUS'
			  AND CodeValue = M.Status) as MtgStatus,
		   (Select speaker_listenins
		      From PIW
			  Where project_code = left(M.meetingCode, 9)) as ListenIN,
		   (Select helpline
		     From PIW
			  Where project_code = left(M.meetingCode, 9)) as DialIN,	     	
		   (Select Top 1 SpeakerID
		      From ScheduleSpeaker
			  Where ScheduleID = M.ScheduleID
			  AND Type = 'MOD') as ModeratorExists,
		   (Select Top 1 SpeakerID
		      From ScheduleSpeaker
			  Where ScheduleID = M.ScheduleID
			  AND Type = 'SPKR') as SpeakerExists			  
		  From ScheduleMaster M
		  Where Month(meetingdate) = #arguments.ThisMonth#
		  AND Year(MeetingDate) = #arguments.ThisYear#
		  <cfif IsDefined("arguments.ProjectCode")>
		   AND Left(meetingCode, 9) = '#Trim(arguments.ProjectCode)#'
		  </cfif>
		  Order By MeetingDate, MtgStartTime, Status
	  </cfquery>
      
	  <cfreturn getdownload />
   </cffunction> 
   <!--------------------------- 
     get Projects for a specific Day 
	 --------------------------->
   <cffunction name="getMonthProjects" returnType="query" access="public">
      <cfargument name="thisMonth" required="YES" type="numeric">
	  <cfargument name="thisYear" required="YES" type="numeric">
	  <cfargument name="ProjectCode" required="NO" type="String">
	  
	  <cfset var getmonthproj = "">
	  
	  <cfquery name="getmonthproj" datasource="#instance.projdsn#">
	  Select left(meetingCode, 9) as projectCode, MtgStartTime, MtgEndTime, ScheduleID, Status, meetingcode, meetingdate,
		   (Select Top 1 SpeakerID
		     From ScheduleSpeaker
			 Where ScheduleID = M.ScheduleID			 
			 AND Type = 'MOD') as ModeratorExists,
		   (Select Top 1 SpeakerID
		     From ScheduleSpeaker
			 Where ScheduleID = M.ScheduleID	
			 AND Type = 'SPKR') as SpeakerExists   
		  From ScheduleMaster M
		  Where Month(meetingdate) = #arguments.ThisMonth#
		  AND Year(MeetingDate) = #arguments.ThisYear#
		  <cfif IsDefined("arguments.ProjectCode")>
		   AND Left(meetingCode, 9) = '#Trim(arguments.ProjectCode)#'
		  </cfif>
		  Order By MtgStartTime, Status
	  </cfquery>
      
	  <cfreturn getmonthproj />
   </cffunction> 
   
   
    <!--------------------------- 
     get Projects for a specific Day 
	 --------------------------->
   <cffunction name="getDayProjects" returnType="query" access="public">
      <cfargument name="thisMonth" required="YES" type="numeric">
	  <cfargument name="thisDay" required="YES" type="numeric">
	  <cfargument name="thisYear" required="YES" type="numeric">
	  <cfargument name="ProjectCode" required="NO" type="String">
	  
	  <cfset var thisdate = CreateDate(arguments.thisyear, arguments.thismonth, arguments.thisday)> 
	  
	  
	  <cfset var getdayproj = "">
	  <cfquery name="getdayproj" datasource="#instance.projdsn#">
	   Select left(meetingCode, 9) as projectCode, MtgStartTime, MtgEndTime, ScheduleID, Status, meetingcode, meetingdate,
		   (Select Top 1 SpeakerID
		     From ScheduleSpeaker
			 Where ScheduleID = M.ScheduleID			 
			 AND Type = 'MOD') as ModeratorExists,
		   (Select Top 1 SpeakerID
		     From ScheduleSpeaker
			 Where ScheduleID = M.ScheduleID	
			 AND Type = 'SPKR') as SpeakerExists  
		  From ScheduleMaster M
		  Where meetingdate = #CreateODBCDate(ThisDate)#
		  <cfif IsDefined("arguments.ProjectCode")>
		   AND Left(meetingCode, 9) = '#Trim(arguments.ProjectCode)#'
		  </cfif>
		  Order By MtgStartTime, Status
	  </cfquery>
      
	  <cfreturn getdayproj />
   </cffunction> 
   
    <!--------------------------- 
     get a single project for a day
	 --------------------------->
   <cffunction name="getDaySingleProjects" returnType="query" access="public">
      <cfargument name="thisMonth" required="YES" type="numeric">
	  <cfargument name="thisDay" required="YES" type="numeric">
	  <cfargument name="thisYear" required="YES" type="numeric">
	  <cfargument name="projectCode" required="YES" type="string">
	  
	  <cfset var thisdate = CreateDate(arguments.thisyear, arguments.thismonth, arguments.thisday)> 
	  
	  
	  <cfset var getdayproj = "">
	  <cfquery name="getdayproj" datasource="#instance.projdsn#">
	   Select left(meetingCode, 9) as projectCode, MtgStartTime, MtgEndTime, ScheduleID, Status, meetingcode, meetingdate,
		   (Select Top 1 SpeakerID
		     From ScheduleSpeaker
			 Where ScheduleID = M.ScheduleID			 
			 AND Type = 'MOD') as ModeratorExists,
		   (Select Top 1 SpeakerID
		     From ScheduleSpeaker
			 Where ScheduleID = M.ScheduleID	
			 AND Type = 'SPKR') as SpeakerExists  
		  From ScheduleMaster M
		  Where meetingdate = #CreateODBCDate(ThisDate)#
		  AND left(MeetingCode, 9) = '#Arguments.projectCode#'
		  Order By MtgStartTime, Status
	  </cfquery>
      
	  <cfreturn getdayproj />
   </cffunction>
   
    <!--------------------------- 
     get specific projects for a time 
	 --------------------------->
   <cffunction name="getTimeProjects" returnType="query" access="public">
      <cfargument name="thisMonth" required="YES" type="numeric">
	  <cfargument name="thisDay" required="YES" type="numeric">
	  <cfargument name="thisYear" required="YES" type="numeric">
	  <cfargument name="thisTime" required="NO" type="numeric">
	  <cfargument name="projectCode" required="no" type="string">
	   <cfset var getdayproj = "">
	  <cfif IsDefined("arguments.thisTime")>
	    <cfset thisdate = CreateDateTime(arguments.thisyear, arguments.thismonth, arguments.thisday, TimeFormat(Arguments.thisTime, 'HH'), TimeFormat(Arguments.thisTime, 'mm'), 0)> 
	  <cfelse>
	     <cfset thisdate = CreateDate(arguments.thisyear, arguments.thismonth, arguments.thisday)>     
	  </cfif>
	  
	 
	  <cfquery name="getdayproj" datasource="#instance.projdsn#">
	 Select left(meetingCode, 9) as projectCode, MtgStartTime, MtgEndTime, ScheduleID, Status, meetingcode, meetingdate,
		   (Select Top 1 SpeakerID
		     From ScheduleSpeaker
			 Where ScheduleID = M.ScheduleID			 
			 AND Type = 'MOD') as ModeratorExists,
		   (Select Top 1 SpeakerID
		     From ScheduleSpeaker
			 Where ScheduleID = M.ScheduleID	
			 AND Type = 'SPKR') as SpeakerExists  
		  From ScheduleMaster M
		  Where 
		  <cfif IsDefined("arguments.thisTime")>
		    MtgStartTime = #CreateODBCDateTime(ThisDate)#
		  <cfelse>
		    MeetingDate = #CreateODBCDateTime(ThisDate)#
		  </cfif>
		  <cfif IsDefined("Arguments.projectCode")>
		   AND left(MeetingCode, 9) = '#Arguments.projectCode#'
		  </cfif>
		  Order By MtgStartTime, 1, Status
	  </cfquery>
      
	  <cfreturn getdayproj />
   </cffunction>
   
    <!--------------------------- 
     Insert a schedule
	 --------------------------->
   <cffunction name="CreateSchedule" returnType="void" access="public">
      <cfargument name="PROJECTCODE" type="string" required="YES">
	  <cfargument name="MTGDATE"     type="date" required="YES">
	  <cfargument name="STARTTIME"   type="date" required="YES">
	  <cfargument name="ENDTIME"     type="date" required="yes">
	  <cfargument name="USER1"       type="string" required="NO">
	  <cfargument name="USER2"       type="string" required="NO">
	  <cfargument name="USER3"       type="numeric" required="NO">
	  <cfargument name="COMMENTS"       type="string" required="NO">
	  <cfargument name="ADDEDBY"     type="numeric" required="YES">
	  
	  <cfset var newcode = CreateMeetingCode(Trim(arguments.projectcode), CreateODBCDATETIME(arguments.Mtgdate), CreateODBCDATETIME(arguments.starttime))>
	  
	  <cfquery name="createproj" datasource="#instance.projdsn#">
	      Insert Into ScheduleMaster(
	          meetingCode,
			  MeetingDate,
			  MtgStartTime,
			  MtgEndTime,
			  Status,
			  Remarks,
			  User1,
			  User2,
			  User3,
			  DateAdded,
			  AddedBy
		   )
		   VALUES(
		      '#newcode#',
			  #Arguments.MtgDate#,
			  #Arguments.StartTime#,
			  #Arguments.EndTime#,
			  0,
			  <cfif IsDefined("arguments.comments")>'#arguments.comments#'<cfelse>NULL</cfif>,
			  <cfif IsDefined("arguments.User1")>'#arguments.User1#'<cfelse>NULL</cfif>,
			  <cfif IsDefined("arguments.user2")>'#arguments.user2#'<cfelse>NULL</cfif>,
			  <cfif IsDefined("arguments.user3")>#arguments.user3#<cfelse>NULL</cfif>,
			  #CreateODBCDateTime(now())#,
			  #Arguments.addedby#
		   )
	  </cfquery> 
   </cffunction>
   
    <!--------------------------- 
     update a schedule 
	 --------------------------->
   <cffunction name="UpdateSchedule" returnType="void" access="public">
     <cfargument name="SCHEDULEID"   type="numeric" required="YES">  
      <cfargument name="PROJECTCODE" type="string" required="YES">
	  <cfargument name="MTGDATE"     type="date" required="YES">
	  <cfargument name="STARTTIME"   type="date" required="YES">
	  <cfargument name="ENDTIME"     type="date" required="yes">
	  <cfargument name="USER1"       type="string" required="NO">
	  <cfargument name="USER2"       type="string" required="NO">
	  <cfargument name="USER3"       type="numeric" required="NO">
	  <cfargument name="COMMENTS"    type="string" required="NO">
	  <cfargument name="updatedby"   type="numeric" required="YES">
	  
	  
	  <cfquery name="updproj" datasource="#instance.projdsn#">
	      UPDATE ScheduleMaster
	        SET  meetingCode ='#Arguments.ProjectCode#',
			     MeetingDate = #Arguments.MtgDate#,
			     MtgStartTime = #Arguments.StartTime#,
			     MtgEndTime = #Arguments.EndTime#,
			     Remarks = <cfif IsDefined("arguments.comments")>'#arguments.comments#'<cfelse>NULL</cfif>,
			     User1 =<cfif IsDefined("arguments.User1")>'#arguments.User1#'<cfelse>NULL</cfif>,
			     User2 =<cfif IsDefined("arguments.user2")>'#arguments.user2#'<cfelse>NULL</cfif>,
			     User3 = <cfif IsDefined("arguments.user3")>#arguments.user3#<cfelse>NULL</cfif>,
		         LastUpdated = #CreateODBCDateTime(now())#,
				 UpdatedBy = #Arguments.updatedby#
		  WHERE ScheduleID = #Arguments.ScheduleID#
	  </cfquery> 
   </cffunction>
   
   <!--------------------------- 
     delete a schedule 
	 --------------------------->
   <cffunction name="deleteSchedule" returnType="void" access="public">
     <cfargument name="SCHEDULEID"  type="numeric" required="YES" >
	  
	  
	  <cfquery name="delproj" datasource="#instance.projdsn#">
	     Delete From ScheduleMaster
		  WHERE ScheduleID = #Arguments.ScheduleID#
	  </cfquery> 
   </cffunction>
   
   <!--------------------------- 
     create a meeting code 
	 --------------------------->
   <cffunction name="CreateMeetingCode" returnType="string" access="public">
      <cfargument name="PROJECTCODE" type="string" required="YES">
	  <cfargument name="StartDate" type="date" required="YES">
	  <cfargument name="StartTime" type="date" required="YES">
	  
		  <cfset var mtgcode = trim(arguments.ProjectCode)>
		  <cfset var mtgdate = dateformat(arguments.startdate, 'mdyyyy')>
		  <cfset var mtgstarttime = timeformat(arguments.starttime, 'HHmm')>
		  <cfset var newcode = mtgcode & mtgdate & mtgstarttime & "1">
	  
	  <cfreturn newcode /> 
   </cffunction>
   
   <!--------------------------- 
     Add STaff To ScheduleSpeaker Table
	 --------------------------->
   <cffunction name="AddStaff" access="public" returnType="void">
     <cfargument name="ScheduleID" type="Numeric" required="YES">
	 <cfargument name="StaffID" type="Numeric" required="YES">
	 <cfargument name="StaffType" type="String" required="YES">
	 
	 <cfquery name="insertStaff" datasource="#instance.projdsn#">
	    Insert into ScheduleSpeaker(ScheduleID, StaffID, StaffType)
		Values(#Arguments.ScheduleID#, #Arguments.StaffID#, '#Arguments.StaffType#')
	 </cfquery>   
		
   </cffunction>
   
   <!--------------------------- 
     Update STaff in ScheduleSpeaker Table
	 --------------------------->
   <cffunction name="EditStaff" access="public" returnType="void">
     <cfargument name="StaffSchedID" type="Numeric" required="YES">
	 <cfargument name="ScheduleID" type="Numeric" required="YES">
	 <cfargument name="StaffID" type="Numeric" required="YES">
	 <cfargument name="StaffType" type="String" required="YES">
	 
	 <cfquery name="UpdateStaff" datasource="#instance.projdsn#">
	    Update ScheduleSpeaker
		  Set ScheduleID = #Arguments.ScheduleID#, 
		      StaffID = #Arguments.StaffID#, 
			  StaffType = '#Arguments.StaffType#' 
		Where StaffSchedID = #Arguments.StaffSchedID#
	 </cfquery>   
   </cffunction>
   
   <!--------------------------- 
     Remove STaff in ScheduleSpeaker Table
	 --------------------------->
   <cffunction name="RemoveStaff" access="public" returnType="void">
     <cfargument name="StaffSchedID" type="Numeric" required="YES">
	 <cfargument name="ScheduleID" type="Numeric" required="YES">
	 
	 <cfquery name="DeleteStaff" datasource="#instance.projdsn#">
	    Delete From ScheduleSpeaker
		Where StaffSchedID = #Arguments.StaffSchedID#
		AND ScheduleID = #Arguments.ScheduleID#,
	 </cfquery>   
   </cffunction>
   
   <!--------------------------- 
     Select all Project STaff
	 --------------------------->
   <cffunction name="getAllStaff" access="public" returnType="query">
	 <cfargument name="ScheduleID" type="Numeric" required="YES">
	 
	 <cfquery name="getall" datasource="#instance.projdsn#">
	    Select  T.Firstname, T.lastname, C.Fee, S.StaffID
		  (Select CodeDesc 
		     From Lookup
			 Where CodeGroup = 'STAFFCODES'
			 AND CodeValue = S.StaffType) as StaffTypeDesc
		From ScheduleSpeaker S, speaker.dbo.Speaker T, speaker.dbo.speaker_clients C
		Where S.ScheduleID = #Arguments.ScheduleID#
		AND S.StaffID = T.speakerid
		AND T.speakerid = C.speakerid
		AND C.client_code = (Select Left(meetingcode, 5) as projCode
		                       From ScheduleMaster
							   Where ScheduleID = S.ScheduleID)
		Order By S.StaffType, T.LastName, T.FirstName
	 </cfquery>  
	 
	 
	 <cfreturn getall /> 
   </cffunction>
   
   <!--------------------------- 
     Check Staff Availability
	 --------------------------->
   <cffunction name="CheckAvailability" access="public" returnType="Boolean">
	 <cfargument name="ScheduleID" type="Numeric" required="YES">
	 <cfargument name="StaffID" type="Numeric" required="YES">
	 <cfargument name="MeetingDate" type="Date" required="YES">
	 <cfargument name="MeetingStartTime" type="Date" required="YES">
	 <cfargument name="MeetingEndTime" type="Date" required="YES">
	 
	 <cfset var available = True>
	 
	 <cfquery name="CheckAvail" datasource="#instance.projdsn#">
	    Select *
		From ScheduleAvailability
		Where StaffID = #Arguments.StaffID#
		AND AvailableStartDate = ##
	 </cfquery>   
	 
	 <cfquery name="CheckConflict" datasource="#instance.projdsn#">
	    Delete From ScheduleSpeaker
		Where StaffSchedID = #Arguments.StaffSchedID#
		AND ScheduleID = #Arguments.ScheduleID#,
	 </cfquery>   
	 
	 <cfquery name="CheckOverlap" datasource="#instance.projdsn#">
	    Delete From ScheduleSpeaker
		Where StaffSchedID = #Arguments.StaffSchedID#
		AND ScheduleID = #Arguments.ScheduleID#,
	 </cfquery>   
	 
	 
   </cffunction>
   
   
 </cfcomponent>