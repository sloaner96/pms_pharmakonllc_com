<!---
---------------------------------------------------------------------------------------------
	TakedaDataHandler.cfc
	FUNCTIONS:
		
	HISTORY:
		bj20060504   - initial code
		bj20060906   - modified to fit new Speaker and PMS database structure.
---------------------------------------------------------------------------------------------
--->
<cfcomponent>

<!---------------------------------------------------------------------
  SPEAKER DATA FUNCTIONS
 ---------------------------------------------------------------------->
	<!--- build the speaker events table --->
	<cffunction access="public" name="buildTakedaSpeakerEvents" returntype="query" displayname="Get Speaker Event Info" output="false">
		<!--- search critieria --->
		<cfargument name="cfcProjectID" type="string" required="Yes">
		<cfargument name="cfcBDate" type="string" required="Yes">
		<cfargument name="cfcEDate" type="string" required="Yes">
		
		<cftry>
		<!--- remove all rows from TakedaSpeakerEvents Table --->
		<cfquery name="RemoveTakedaSpeakerEvents" datasource="#application.speakerDSN#">
			DELETE FROM Speaker.dbo.TakedaSpeakerEvents
		</cfquery>
		
		<!--- Insert selected data into TakedaSpeakerEvents Table --->
		<cfquery name="InsertTakedaSpeakerEvents" datasource="#application.speakerDSN#">
			insert into speaker.dbo.TakedaSpeakerEvents (
				SpeakerClientID
				, EventID
				, StartDate
				, StartTime
				, EndDate
				, EndTime
				, TimeZone
				, SpeakerID )
			select s.SpeakerClientID
				, ss.MeetingCode
				, ss.MeetingDate
				, ss.MtgStartTime
				, ss.MeetingDate
				, ss.MtgEndTime
				, 'EST'
				, ss.SpeakerID
			from PMSProd.dbo.ScheduleSpeaker ss, speaker.dbo.Speaker s 
			where s.speakerid = ss.Speakerid
				and (ss.MeetingDate between '#dateFormat(arguments.cfcBDate, "mm/dd/yyyy")#' and '#dateFormat(arguments.cfcEDate, "mm/dd/yyyy")#')
				and ss.Type = 'SPKR'
				and ss.Confirmed = 1
				and s.speakerid = ss.speakerid
				and s.firstname <> 'Q&A'
				and s.firstname <> 'live'
				<cfif #arguments.cfcProjectID# EQ '0'>
					and left(ss.MeetingCode, 5) IN ('CTAAC', 'CTARA', 'CTAAZ')
				<cfelse>
					and ss.MeetingCode like '#arguments.cfcProjectID#%'
				</cfif>
		</cfquery>
		<!--- get a total record count to return --->
		<cfquery name="countSpeakerEvents" datasource="#application.speakerDSN#">
			select count(*) as eventCount from speaker.dbo.TakedaSpeakerEvents
		</cfquery>

		<cfcatch type="database"><cfinclude template="../error_db_abort.cfm"></cfcatch>
		<cfcatch type="any"><cfinclude template="../error_db_abort.cfm"></cfcatch>
		</cftry>
		
		<!--- return the query result set --->
		<cfreturn countSpeakerEvents>
	</cffunction>

	<!--- Update speaker event table --->
	<cffunction access="public" name="updateTakedaSpeakerEvents" returntype="boolean" displayname="Updates Speaker Event Table" output="false">
		<!--- search critieria --->

		<!---<cftry>--->
		<cfquery name="checkSpeakerEvents" datasource="#application.speakerDSN#">
			select count(*) as itemcount from Speaker.dbo.TakedaSpeakerEvents
		</cfquery>
		<!--- if no existing records, then return false --->
		<cfif #checkSpeakerEvents.itemcount# LT 1>
			<cfreturn false>
		</cfif>
		
		<!--- update each row from matching data in the PIW --->			
		<cfquery name="updateSpeakerEvents" datasource="#application.speakerDSN#">
		update Speaker.dbo.TakedaSpeakerEvents
			set EventTitle = piw.guide_topic
			, EventType = 'teleconference'
			, EventPhone = piw.speaker_listenins
			, ProgramMgrPhone = '8479950509'
			, ProgramMgrFax = '8474130862'
			FROM PMSProd.dbo.piw piw, Speaker.dbo.TakedaSpeakerEvents se
			where piw.project_code = left(se.EventID, 9)
		</cfquery>
			
		<!--- update each row with honoraria amounts from speakerclients table --->			
		<cfquery name="updateSpeakerEvents" datasource="#application.speakerDSN#">
			update Speaker.dbo.TakedaSpeakerEvents
			set Honorarium = sc.EventFee
			from speaker.dbo.SpeakerClients sc, speaker.dbo.Speaker s, speaker.dbo.TakedaSpeakerEvents se
			where left(se.EventID, 9) = left(sc.ClientCode, 9)
				And sc.SpeakerID = se.SpeakerID
				And sc.Type = 'SPKR'
		</cfquery>

		<!--- update TakedaSpeakerEvetns with account contact info --->
		<cfquery name="updateSpeakerEvents" datasource="#application.speakerDSN#">
			update Speaker.dbo.TakedaSpeakerEvents
				SET ProductID = 'Actos'
				, ProgramMgrEmail = 'btuke@cbeck.com'
				, ProgramMgrFirstname = 'Bob'
				, ProgramMgrLastname = 'Tuke'
			where left(EventID, 5) = 'CTAAC'
		</cfquery>
		<cfquery name="updateSpeakerEvents" datasource="#application.speakerDSN#">
			update Speaker.dbo.TakedaSpeakerEvents
				SET ProductID = 'Amitiza'
				, ProgramMgrEmail = 'lstanley@cbeck.com'
				, ProgramMgrFirstname = 'Lauren'
				, ProgramMgrLastname = 'Stanley'
			where left(EventID, 5) = 'CTAAZ'
		</cfquery>
		<cfquery name="updateSpeakerEvents" datasource="#application.speakerDSN#">
			update Speaker.dbo.TakedaSpeakerEvents
				SET ProductID = 'Rozerem'
				, ProgramMgrEmail = 'lstanley@cbeck.com'
				, ProgramMgrFirstname = 'Lauren'
				, ProgramMgrLastname = 'Stanley'
			where left(EventID, 5) = 'CTARA'
		</cfquery>
		<!--- update the status of cancelled events first --->
		<cfquery name="updateSpeakerEvents" datasource="#application.speakerDSN#">
			update Speaker.dbo.TakedaSpeakerEvents
				SET EventStatus = 'Cancelled'
			FROM PMSPROD.dbo.ScheduleMaster sm, speaker.dbo.TakedaSpeakerEvents se
			WHERE sm.MeetingCode = se.EventID
			AND sm.Status = 'c'
		</cfquery>
		<!--- update the status of events which occurred before today as 'Completed' --->
		<cfquery name="updateSpeakerEvents" datasource="#application.speakerDSN#">
			update Speaker.dbo.TakedaSpeakerEvents
				SET EventStatus = 'Completed'
			FROM PMSPROD.dbo.ScheduleMaster sm, speaker.dbo.TakedaSpeakerEvents se
			WHERE sm.MeetingCode = se.EventID
			AND se.EventStatus is null
			AND se.StartDate <= convert(varchar(10),getdate(),101)
		</cfquery>
		<!--- update the status of events which haven't occurred as 'Confirmed' --->
		<cfquery name="updateSpeakerEvents" datasource="#application.speakerDSN#">
			update Speaker.dbo.TakedaSpeakerEvents
				SET EventStatus = 'Confirmed'
			FROM PMSPROD.dbo.ScheduleMaster sm, speaker.dbo.TakedaSpeakerEvents se
			WHERE sm.MeetingCode = se.EventID
			AND (se.EventStatus <> 'Completed' OR se.EventStatus <> 'Cancelled' OR se.EventStatus is null)
			AND se.StartDate > convert(varchar(10),getdate(),101)
		</cfquery>
		
		<!--- run some exception processing on the current data --->
		<!--- look for rows without SpeakerClientID --->
		<cfquery name="updateSpeakerEvents" datasource="#application.speakerDSN#">
			update speaker.dbo.TakedaSpeakerEvents
			set NoSpeakerClientID = 1
			where (SpeakerClientID is null OR len(rtrim(SpeakerClientID)) < 2)
		</cfquery>
		<!--- look for rows without EventTitle --->
		<cfquery name="updateSpeakerEvents" datasource="#application.speakerDSN#">
			update speaker.dbo.TakedaSpeakerEvents
			set NoEventTitle = 1
			where (EventTitle is null OR len(rtrim(EventTitle)) < 2)
		</cfquery>
		<!--- look for rows without EventPhone --->
		<cfquery name="updateSpeakerEvents" datasource="#application.speakerDSN#">
			update speaker.dbo.TakedaSpeakerEvents
			set NoEventPhone = 1
			where (EventPhone is null OR len(rtrim(EventPhone)) < 2)
		</cfquery>
		<!--- look for rows without Honorarium --->
		<cfquery name="updateSpeakerEvents" datasource="#application.speakerDSN#">
			update speaker.dbo.TakedaSpeakerEvents
			set NoHonorarium = 1
			where (Honorarium is null OR Honorarium = 0)
		</cfquery>
		
		<!---
		<cfcatch type="database"><cfinclude template="../error_db_abort.cfm"></cfcatch>
		<cfcatch type="any"><cfinclude template="../error_db_abort.cfm"></cfcatch>
		</cftry>
		--->
		<!--- return the query result set --->
		<cfreturn true>
	</cffunction>

	<!--- get speaker event exceptions --->
	<cffunction access="public" name="expTakedaSpeakerEvents" returntype="query" displayname="Get Speaker Event Exceptions" output="false">
		<!--- search critieria --->
		
		<cftry>
		<cfquery name="expSpeakerEvents" datasource="#application.speakerDSN#">
			select se.SpeakerClientID
				, se.EventID
				, se.StartDate
				, se.StartTime
				, s.FirstName
				, s.LastName
				, NoSpeakerClientID
				, NoEventTitle
				, NoEventPhone
				, NoHonorarium
			from speaker.dbo.TakedaSpeakerEvents se
				, speaker.dbo.Speaker s
			where se.SpeakerID = s.SpeakerID
				AND (se.NoSpeakerClientID = 1
					OR se.NoHonorarium = 1
					OR se.NoEventPhone = 1
					OR se.NoEventTitle = 1)
			order by s.lastname, s.firstname, se.EventID
		</cfquery>
		<cfcatch type="database"><cfinclude template="../error_db_abort.cfm"></cfcatch>
		<cfcatch type="any"><cfinclude template="../error_db_abort.cfm"></cfcatch>
		</cftry>
		<!--- return the query result set --->
		<cfreturn expSpeakerEvents>
	</cffunction>

	<!--- get posted speaker event info --->
	<cffunction access="public" name="getPostedSpeakerEvents" returntype="query" displayname="Get Posted Speaker and Event Info" output="false">

		<cftry>
		<cfquery name="PostedSpeakerEvents" datasource="#application.speakerDSN#">
			select sp.SpeakerClientID
				,sp.EventID
				,sp.EventTitle
				,sp.EventStatus
				,sp.EventType
				,sp.StartDate
				,sp.StartTime
				,sp.EndDate
				,sp.EndTime
				,sp.Honorarium
				,sp.EventPhone
				,sp.EventPhoneCode
				,sp.ProductID
				,sp.TimeZone
				,sp.ProgramMgrEmail
				,sp.ProgramMgrFirstName
				,sp.ProgramMgrLastname
				,sp.ProgramMgrPhone
				,sp.ProgramMgrFax
			from speaker.dbo.TakedaSpeakerEvents sp
			where sp.SpeakerClientID is not null
			and sp.EventPhone is not null
			and sp.eventID is not null
			and sp.eventTitle is not null
			order by sp.SpeakerClientID, sp.eventID
		</cfquery>
		<cfcatch type="database"><cfinclude template="../error_db_abort.cfm"></cfcatch>
		<cfcatch type="any"><cfinclude template="../error_db_abort.cfm"></cfcatch>
		</cftry>
		<!--- return the query result set --->
		<cfreturn PostedSpeakerEvents>
	</cffunction>



<!----------------------------------------------------------------
	PAYMENTS
------------------------------------------------------------------>
	<!--- build the speaker payments table --->
	<cffunction access="public" name="buildTakedaSpeakerPayments" returntype="query" displayname="Build Speaker Payment Info" output="false">
		<!--- search critieria --->
		<cfargument name="cfcProjectID" type="string" required="Yes">
		<cfargument name="cfcBDate" type="string" required="Yes">
		<cfargument name="cfcEDate" type="string" required="Yes">
		
		<cftry>
		<!--- remove all rows from TakedaSpeakerEvents Table --->
		<cfquery name="RemoveTakedaSpeakerEvents" datasource="#application.speakerDSN#">
			DELETE FROM Speaker.dbo.TakedaSpeakerPayments
		</cfquery>
		
		<!--- Insert selected data into TakedaSpeakerPayments Table --->
		<cfquery name="InsertTakedaSpeakerEvents" datasource="#application.speakerDSN#">
			insert into speaker.dbo.TakedaSpeakerPayments (
				SpeakerClientID
				, EventID
				, EventDate
				, EventTime
				, PaymentType
				, SpeakerID )
			select s.SpeakerClientID
				, ss.MeetingCode
				, ss.MeetingDate
				, ss.MtgStartTime
				, 'Honorarium'
				, ss.SpeakerID
			from PMSProd.dbo.ScheduleSpeaker ss, speaker.dbo.Speaker s 
			where s.speakerid = ss.Speakerid
				and (ss.MeetingDate between '#dateFormat(arguments.cfcBDate, "mm/dd/yyyy")#' and '#dateFormat(arguments.cfcEDate, "mm/dd/yyyy")#')
				and ss.Type = 'SPKR'
				and ss.Confirmed = 1
				and s.speakerid = ss.speakerid
				and s.firstname <> 'Q&A'
				and s.firstname <> 'live'
				<cfif #arguments.cfcProjectID# EQ '0'>
					and left(ss.MeetingCode, 5) IN ('CTAAC', 'CTARA', 'CTAAZ')
				<cfelse>
					and ss.MeetingCode like '#arguments.cfcProjectID#%'
				</cfif>
		</cfquery>
		<!--- get a total record count to return --->
		<cfquery name="countSpeakerPayments" datasource="#application.speakerDSN#">
			select count(*) as eventCount 
			from speaker.dbo.TakedaSpeakerPayments
		</cfquery>
		
		<cfcatch type="database"><cfinclude template="../error_db_abort.cfm"></cfcatch>
		<cfcatch type="any"><cfinclude template="../error_db_abort.cfm"></cfcatch>
		</cftry>
		
		<!--- return the query result set --->
		<cfreturn countSpeakerPayments>
	</cffunction>

	<cffunction access="public" name="updateTakedaSpeakerPayments" returntype="boolean" displayname="Updates Speaker Payment Table" output="false">
		<!--- search critieria --->

		<cftry>
		<cfquery name="checkSpeakerPayments" datasource="#application.speakerDSN#">
			select count(*) as itemcount from Speaker.dbo.TakedaSpeakerPayments
		</cfquery>
		<!--- if no existing records, then return false --->
		<cfif #checkSpeakerPayments.itemcount# LT 1>
			<cfreturn false>
		</cfif>
		
		<!--- update each row from matching data in the PIW --->			
		<cfquery name="updateSpeakerPayments" datasource="#application.speakerDSN#">
		update Speaker.dbo.TakedaSpeakerPayments
			set CheckAmount = sp.CheckAmount
			, CheckNumber = sp.CheckNumber
			, PaymentDate = sp.PaymentDate
			FROM 	PMSProd.dbo.SpeakerPayments sp
				, Speaker.dbo.TakedaSpeakerPayments tsp
			where tsp.EventID = sp.Meetingcode
				AND tsp.speakerID = sp.SpeakerID
				AND sp.CheckNumber IS NOT NULL
				AND sp.CheckNumber <> 0
				AND sp.CheckAmount > 0
				AND sp.PaymentDate IS NOT NULL
		</cfquery>

		<!--- look for rows without SpeakerClientID --->
		<cfquery name="updateSpeakerPayments" datasource="#application.speakerDSN#">
			update speaker.dbo.TakedaSpeakerPayments
			set NoSpeakerClientID = 1
			where (SpeakerClientID is null OR len(rtrim(SpeakerClientID)) < 2)
		</cfquery>
			
		<cfcatch type="database"><cfinclude template="../error_db_abort.cfm"></cfcatch>
		<cfcatch type="any"><cfinclude template="../error_db_abort.cfm"></cfcatch>
		</cftry>
		
		<!--- return true --->
		<cfreturn true>
	</cffunction>
	
	<!--- get speaker event exceptions --->
	<cffunction access="public" name="expTakedaSpeakerPayments" returntype="query" displayname="Get Speaker Payment Exceptions" output="false">
		<!--- search critieria --->

		<cftry>
		<cfquery name="expSpeakerPayments" datasource="#application.speakerDSN#">
			select sp.SpeakerClientID
				, sp.EventID
				, sp.EventDate
				, sp.EventTime
				, s.FirstName
				, s.LastName
				, NoSpeakerClientID
			from speaker.dbo.TakedaSpeakerPayments sp
				, speaker.dbo.Speaker s
			where sp.SpeakerID = s.SpeakerID
				AND sp.NoSpeakerClientID = 1
			order by s.lastname, s.firstname, sp.EventID
		</cfquery>
		<cfcatch type="database"><cfinclude template="../error_db_abort.cfm"></cfcatch>
		<cfcatch type="any"><cfinclude template="../error_db_abort.cfm"></cfcatch>
		</cftry>
		<!--- return the query result set --->
		<cfreturn expSpeakerPayments>
	</cffunction>

	<!--- get speaker payment info --->
	<cffunction access="public" name="getPostedSpeakerPayments" returntype="query" displayname="Get Speaker Payment Info" output="false">

		<cftry>
		<cfquery name="PostedSpeakerPayments" datasource="#application.speakerDSN#">
			select sp.SpeakerClientID
				,sp.EventID
				,sp.CheckNumber
				,sp.CheckAmount
				,sp.PaymentDate
				,sp.PaymentType
			from speaker.dbo.TakedaSpeakerPayments sp
			where sp.CheckAmount > 0 
			and sp.checkAmount is not null
			and (sp.checkNumber is not null or sp.CheckNumber <> 0)
			and sp.paymentdate is not null
			order by sp.SpeakerClientID, sp.eventID
		</cfquery>
		<cfcatch type="database"><cfinclude template="../error_db_abort.cfm"></cfcatch>
		<cfcatch type="any"><cfinclude template="../error_db_abort.cfm"></cfcatch>
		</cftry>

		<!--- return the query result set --->
		<cfreturn PostedSpeakerPayments>
	</cffunction>

<!----------------------------------------------------------------
	EVENT LOG
------------------------------------------------------------------>
	<!--- write an event log record --->
	<cffunction access="public" name="writeEventLog" returntype="boolean" displayname="Writes a log record" output="false">
		<!--- search critieria --->
		<cfargument name="cfcType" type="string" required="Yes">
		<cfargument name="cfcBDate" type="string" required="Yes">
		<cfargument name="cfcEDate" type="string" required="Yes">
		<cfargument name="cfcProject" type="string" required="Yes">
		<cfargument name="cfcNumRows" type="numeric" required="Yes">
		<cfargument name="cfcFilename" type="string" required="Yes">
		
		<cftry>
		<!--- Insert selected data into TakedaSpeakerPayments Table --->
		<cfquery name="EventLog" datasource="#application.speakerDSN#">
		insert into speaker.dbo.TakedaSpeakerLog (
			ReportType
			, BeginningDate
			, EndingDate
			, NumberRows
			, ExportFilename
			, Project )
		values (
			'#arguments.cfcType#'
			, '#arguments.cfcBDate#'
			, '#arguments.cfcEDate#'
			, #arguments.cfcNumRows#
			, '#arguments.cfcFilename#'
			, <cfif #arguments.cfcProject# EQ "0"> 'All' <cfelse> '#arguments.cfcProject#' </cfif>
			)
		</cfquery>
	
		<cfcatch type="database"><cfinclude template="../error_db_abort.cfm"></cfcatch>
		<cfcatch type="any"><cfinclude template="../error_db_abort.cfm"></cfcatch>
		</cftry>
		
		<!--- return the query result set --->
		<cfreturn True>
	</cffunction>

	<!--- get last event log record --->
	<cffunction access="public" name="lastEventLog" returntype="query" displayname="get last log record" output="false">
		<!--- search critieria --->
		<cfargument name="cfcType" type="string" required="Yes">
		
		<cftry>
		<!--- get last event log row --->
		<cfquery name="maxRow" datasource="#application.speakerDSN#">
			select Max(rowid) as rowid
			from Speaker.dbo.TakedaSpeakerLog
			where ReportType = '#arguments.cfcType#'
		</cfquery>
	
		<cfquery name="LogRow" datasource="#application.speakerDSN#">
			select ReportType
				, BeginningDate
				, EndingDate
				, NumberRows
				, ExportFilename
				, Project
			from Speaker.dbo.TakedaSpeakerLog
			where rowid = #maxRow.rowid#
		</cfquery>

		<cfcatch type="database"><cfinclude template="../error_db_abort.cfm"></cfcatch>
		<cfcatch type="any"><cfinclude template="../error_db_abort.cfm"></cfcatch>
		</cftry>
		
		<!--- return the query result set --->
		<cfreturn LogRow>
	</cffunction>

</cfcomponent>