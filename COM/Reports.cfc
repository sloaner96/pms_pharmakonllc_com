<!---
    $Id: ,v 1.0 2005/10/12 rsloan Exp $
    Copyright (c) 2005 Pharmakon, LLC.

    Description: This component will be used to drive reports in the PMS systsm
        
    Parameters: Various, based on function. It does set the datasources, 
	            file paths, etc. used in a instance variable and initializes the component
        
    Usage: 
        
    Documentation: Self-Documenting cfc
        
    Changes:    
--->
<cfcomponent displayname="reports" hint="This component contains functions for reporting">
    <!--- lock name is the name used to wrap file io/data ops --->
	<cfset LOCK_NAME = "reports_cfc">

				
	<cfset instance = structnew()>
	
	<!--- Initialize datasources --->
	<cfset instance.projdsn = "projman">
	<cfset instance.rosterdsn = "CBARoster">
	<cfset instance.DBMaster = "DBMASTER">
	
	<cfset instance.FilePath = "c:\inetpub\wwwroot\pms_PharmakonLLC_Com">
	
	<!--- Constructor --->
	<cfset init()>
	
   <!---************************* 
      Initialize the component 
     ************************--->
   <cffunction name="init" returnType="boolean" access="public"
				hint="Handles initialization.">
	      <cfset instance.initialized = true>
	      <cfreturn instance.initialized />
   </cffunction>
   
   <cffunction name="getActiveProjects" access="public" returnType="Query">
        
		<cfset var getproj="">
		<cfquery name="getproj" datasource="#instance.rosterdsn#">
		   Select Distinct Left(eventKey,9) as MeetingCode,
		     (Select Max(EventDate) as Maximumdate
		        From CI_DB
		        Where left(eventKey, 9) = Left(c.eventKey,9)) as MaxDate 
		   From CI_DB C
		   Where eventDate >= #createodbcDateTime(now())# 
		   order by 1
		</cfquery>
		
		<cfreturn getproj />
   </cffunction>
   
   <cffunction name="getPhidDups" access="public" returnType="Query">
      <cfargument name="programCode" type="string" required="YES">
	  <cfargument name="StartDate" type="date" required="YES">
	  <cfargument name="EndDate" type="date" required="YES">
	  <cfargument name="Phid" type="string" required="YES">
	    
		<cfset var getPhidDup="">
		<cfquery name="getPhidDup" datasource="#instance.rosterdsn#">
		   Select rowID, EventKey, EventDate, EventTime, Phid, Firstname, Lastname, Degree, CIStatus 
		   From CI_DB
		   Where Left(EventKey, 9) = '#Arguments.ProgramCode#'
		   AND Phid = '#Arguments.Phid#'
		   AND EventDate >= #CreateODBCDate(Arguments.startDate)#
		   AND EventDate <= #CreateODBCDate(Arguments.EndDate)#
		   AND CIStatus <> 'Cancelled'
		   AND (Select Count(*)
		           From CI_DB
				   Where Phid = C.Phid
				   AND Left(EventKey, 9) = Left(C.EventKey, 9)
				   AND EventDate >= #CreateODBCDate(Arguments.startDate)#
				   AND CIStatus <> 'Cancelled') > 1
		   Order By EventKey, EventDate
		</cfquery>
		
		<cfreturn getPhidDup />
   </cffunction>
   
    <cffunction name="getDups" access="public" returnType="Query">
      <cfargument name="programCode" type="string" required="YES">
	  <cfargument name="StartDate" type="date" required="YES">
	  <cfargument name="EndDate" type="date" required="YES">
	    
		<cfset var getDup="">
		<cfquery name="getDup" datasource="#instance.rosterdsn#">
		   Select rowID, EventKey, EventDate, EventTime, Phid, Firstname, Lastname, Degree, CIStatus 
		   From CI_DB C
		   Where Left(EventKey, 9) = '#Arguments.ProgramCode#'
		   AND EventDate >= #CreateODBCDate(Arguments.startDate)#
		   AND EventDate <= #CreateODBCDate(Arguments.EndDate)#
		   AND CIStatus <> 'Cancelled'
		   AND (Select Count(*)
		           From CI_DB
				   Where Phid = C.Phid
				   AND Left(EventKey, 9) = Left(C.EventKey, 9)
				   AND EventDate >= #CreateODBCDate(Arguments.startDate)#
				   AND CIStatus <> 'Cancelled') > 1
		   Order By lastname, firstname, EventKey, EventDate
		</cfquery>
		
		<cfreturn getDup />
   </cffunction>
   
   <cffunction name="getCI" access="public" returnType="Query">
      <cfargument name="CIID" type="numeric" required="YES">
	  
	    
		<cfset var getCIData ="">
		<cfquery name="getCIData" datasource="#instance.rosterdsn#">
		   Select * 
		   From CI_DB C
		   Where rowID = #Arguments.CIID#
		</cfquery>
		
		<cfreturn getCIData />
   </cffunction>
   
   <cffunction name="getNom" access="public" returnType="String">
      <cfargument name="NomType" type="string" required="YES">
	  <cfargument name="NomID" type="numeric" required="YES">
	  
	    
		<cfset var getnomName ="">
		<cfquery name="getnomName" datasource="#instance.projdsn#">
		   Select CODEDESC
		   From lookup
		   Where Codegroup = <cfif arguments.NomType EQ "REP">'BLITZREPNOM'<cfelse>'BLITZOTHRNOM'</cfif>
		   AND CodeValue = '#arguments.NomID#'
		</cfquery>
		
		<cfreturn getnomName.codeDesc />
   </cffunction>
   
   <cffunction name="GetEmailsSentByUser" access="public" returnType="Query">
	  <cfargument name="StartDate" type="date" required="NO">
	  <cfargument name="EndDate" type="date" required="NO">
	  <cfargument name="ProjectCode" type="string" required="NO">
	  
	  <cfset var thisemails ="">
	  
	  <cfquery name="thisemails" datasource="#instance.rosterdsn#">
		     Select C.EventKey, Left(C.eventkey, 9) as ProjectCode, C.EventDateTime, C.firstname, C.lastname, C.Status,
				 (Select Count(LogID)
				    FROM PMSPROD.dbo.MaterialLog M
				    Where M.Phid = C.Phid
				    AND M.MeetingCode = Left(C.eventKey, 9)
				    AND M.LogType = 'DWNLD') as FileDownload,
				 (Select Max(DateSent)
				    From PMSPROD.dbo.ConfirmEmailsSent
				    Where Phid = C.Phid
			        AND CIRowID = C.RowID) as DateSent,   
			     (Select count(SentID)
				    From PMSPROD.dbo.ConfirmEmailsSent
				    Where Phid = C.Phid
			        AND CIRowID = C.RowID) as TimesSent,    
				 (Select Count(LogID)
				    FROM PMSPROD.dbo.MaterialLog M
				    Where M.Phid = C.Phid
				     AND M.MeetingCode = Left(C.eventKey, 9)
				     AND M.LogType = 'Plogn') as LoggedIN, 
				 (Select attended
				    From DBMASTER.dbo.Roster R
				     Where R.Phid = C.Phid
				      AND R.meetingcode = C.EventKey) as Attended
			 From CI_DB C
			 Where C.eGuidebook = 1
		     AND C.CIStatus IN ('Scheduled', 'Rescheduled') 
			 AND Exists (Select Top 1 *
			              From PMSPROD.dbo.ConfirmEmailsSent
			              Where Phid = C.Phid
			              AND CIRowID = C.RowID)
			 <cfif IsDefined("arguments.ProjectCode")>
			   AND Left(C.eventKey, 9) = '#Arguments.ProjectCode#'
			 </cfif>
			 <cfif ISDefined("arguments.StartDate")>
			   AND eventDateTime >= #CreateODBCDate(arguments.StartDate)#
			 </cfif>
			 <cfif ISDefined("arguments.EndDate")>
			   AND eventDateTime <= #CreateODBCDate(arguments.EndDate)#
			 </cfif>
			 
			Order By 2, C.EventDateTime, C.Lastname, DateSent
	  </cfquery>
	  
	  <cfreturn thisemails/>
   </cffunction>
   
   <cffunction name="GetEmailsSentByproduct" access="public" returnType="Query">
	  <cfargument name="StartDate" type="date" required="NO">
	  <cfargument name="EndDate" type="date" required="NO">
	  <cfargument name="ProjectCode" type="string" required="NO">
	  
	  <cfset var thisemails ="">
	  
	  <cfquery name="thisemails" datasource="#instance.projdsn#">
	        Select ProjectCode,
			  (Select Count(Distinct PHID)
				    FROM MaterialLog M
				    Where M.MeetingCode = E.ProjectCode
				    AND M.LogType = 'DWNLD'
					AND DateAdded >= #CreateODBCDate(arguments.StartDate)#
					AND DateAdded <= #CreateODBCDate(arguments.EndDate)#
				    AND Exists(Select Top 1 *
			                     From ConfirmEmailsSent
			                     Where Phid = M.Phid)) as FileDownload, 
			  (Select Count(Distinct PHID)
				    FROM MaterialLog M
				    Where M.MeetingCode = E.ProjectCode
				     AND M.LogType = 'Plogn'
					 AND DateAdded >= #CreateODBCDate(arguments.StartDate)#
					 AND DateAdded <= #CreateODBCDate(arguments.EndDate)#
				     AND Exists(Select Top 1 *
			                      From ConfirmEmailsSent
			                      Where Phid = M.Phid)) as LoggedIN,
			  (Select Count(Distinct Phid)
			         From ConfirmEmailsSent S
					 Where EmailSent = 1
					 AND ProgramID = E.ProjectCode
					 AND CIROWID IN (Select RowID
					                   From cbaroster.dbo.CI_DB
									   Where RowID = S.CIROWID
									   AND EventDate >= #CreateODBCDate(arguments.StartDate)#
									   AND EventDate <= #CreateODBCDate(arguments.EndDate)#)) as FirstEmailSent,
			  (Select Count(Distinct Phid)
			         From ConfirmEmailsSent S
					 Where EmailSent = 2
					 AND ProgramID = E.ProjectCode
					 AND CIROWID IN (Select RowID
					                   From cbaroster.dbo.CI_DB
									   Where RowID = S.CIROWID
									   AND EventDate >= #CreateODBCDate(arguments.StartDate)#
									   AND EventDate <= #CreateODBCDate(arguments.EndDate)#)) as SecondEmailSent,
			  (Select Count(Distinct Phid)
			         From ConfirmEmailsSent S
					 Where EmailSent = 4
					 AND ProgramID = E.ProjectCode
					 AND CIROWID IN (Select RowID
					                   From cbaroster.dbo.CI_DB
									   Where RowID = S.CIROWID
									   AND EventDate >= #CreateODBCDate(arguments.StartDate)#
									   AND EventDate <= #CreateODBCDate(arguments.EndDate)#)) as ThirdThnkSent,
			  (Select Count(Distinct Phid)
			         From ConfirmEmailsSent S
					 Where EmailSent = 3
					 AND ProgramID = E.ProjectCode
					 AND CIROWID IN (Select RowID
					                   From cbaroster.dbo.CI_DB
									   Where RowID = S.CIROWID
									   AND EventDate >= #CreateODBCDate(arguments.StartDate)#
									   AND EventDate <= #CreateODBCDate(arguments.EndDate)#)) as ThirdRemindSent				   					 
			From ConfirmationEmail E
			Where ApprovalDate IS NOT NULL
	  </cfquery>
	  
	  <cfreturn thisemails />
   </cffunction>
   
   <cffunction name="getAttendedCount" access="public" returnType="Query">
      <cfargument name="StartDate" type="date" required="NO">
	  <cfargument name="EndDate" type="date" required="NO">
      <cfargument name="ProjectCode" type="String" required="YES">
	  
	  <cfset var attendCount = "">
	  
	  <cfquery name="attendCount" datasource="#instance.DBMaster#">
	     Select Count(R.projectid) as AttendedProg
		 From Roster R
		 Where Attended = 0
		 AND projectid = '#Arguments.ProjectCode#'
		 <cfif IsDefined("arguments.StartDate")>
		 AND EventDate >= #CreateODBCDate(arguments.StartDate)#
		 </cfif>
		 <cfif IsDefined("arguments.EndDate")>
		 AND EventDate <= #CreateODBCDate(arguments.EndDate)# 
		 </cfif>
		 AND Exists (Select Top 1 C.RowID
		              From mozart.PMSPROD.dbo.confirmEmailsSent S, mozart.CBARoster.dbo.CI_DB C
					  Where S.Phid = R.Phid
					  AND C.RowID = S.CIROWID
					  AND Left(EventKey,9) = R.ProjectID)
	  </cfquery>
	  
	  <cfreturn attendCount />
   </cffunction>
   
   <cffunction name="getTotalEguide" access="public" returnType="Query" >
      <cfargument name="StartDate" type="date" required="NO">
	  <cfargument name="EndDate" type="date" required="NO">
      <cfargument name="ProjectCode" type="String" required="NO">
	  
	  <cfset var geteguidecount = "">
	   
	   <cfquery name="geteguidecount" datasource="#instance.rosterdsn#">
		  Select Count(Distinct PHID) as TotaleGuide
		  From ci_db
		  Where eGuidebook = 1
		  AND CIStatus IN ('Scheduled', 'Rescheduled')
		  AND PHID <> 0
		  <cfif IsDefined("arguments.StartDate")>
		   AND EventDate >= #CreateODBCDate(Arguments.StartDate)#
		  </cfif>
		  <cfif IsDefined("arguments.EndDate")>
		   AND EventDate <= #CreateODBCDate(Arguments.EndDate)#
		  </cfif>
		  <cfif IsDefined("arguments.ProjectCode")>
		   AND Left(eventkey,9) = '#Arguments.ProjectCode#'
		  </cfif>
		  AND Left(eventkey,9) IN (Select ProjectCode
		                                 From PMSPROD.DBO.ConfirmationEmail
										 Where ApprovalDate IS NOT NULL)

	   </cfquery>
	   
	   <cfreturn geteguidecount />
   </cffunction>
   
   <cffunction name="getTotalCI" access="public" returnType="Query" >
      <cfargument name="StartDate" type="date" required="NO">
	  <cfargument name="EndDate" type="date" required="NO">
      <cfargument name="ProjectCode" type="String" required="NO">
	  
	  <cfset var getcicount = "">
	   
	   <cfquery name="getcicount" datasource="#instance.rosterdsn#">
		  Select Count(distinct PHID) as TotalCI
		  From ci_db
		  Where CIStatus IN ('Scheduled', 'Rescheduled')
		  <cfif IsDefined("arguments.StartDate")>
		   AND EventDate >= #CreateODBCDate(Arguments.StartDate)#
		  </cfif>
		  <cfif IsDefined("arguments.EndDate")>
		   AND EventDate <= #CreateODBCDate(Arguments.EndDate)#
		  </cfif>
		  <cfif IsDefined("arguments.ProjectCode")>
		   AND Left(eventkey,9) = '#Arguments.ProjectCode#'
		  </cfif>
	
	   </cfquery>
	   
	   <cfreturn getcicount />
   </cffunction>
   
   <cffunction name="getActiveConfirms" access="public" returnType="Query" >
	   <cfset var getActiveProj="">
	   
	   <cfquery name="getActiveProj" datasource="#instance.ProjDSN#">
		  Select Distinct ProjectCode
		  From dbo.ConfirmationEmail
		  Where testemailSent IS NOT NULL
		  AND ApprovalDate IS NOT NULL
		  AND StartDate <= #CreateODBCDate(Now())#
		  AND EndDate >= #CreateODBCDate(Now())#
		  order By ProjectCode
	   </cfquery>
	   
	   <cfreturn getActiveProj />
   </cffunction>
</cfcomponent>