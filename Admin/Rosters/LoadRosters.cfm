<!--- 		
<CFTRY>
    <CFOBJECT TYPE="COM" NAME="objDTS" CLASS="DTS.Package" ACTION="CREATE">
    <CFCATCH TYPE = "Object">
        <CFSET error_message = "The DTS Package Object Could Not Be Created.">
    </CFCATCH>
</CFTRY>

<CFTRY>
    <CFSET r = objDTS.LoadfromSQLServer("MOZART.PHARMAKON2.LOCAL","RosterDTS","richie4661",0,"","","","Daily_Roster_Upload1","")>
	
    <CFCATCH>
        <CFSET error_message = "The DTS Package Could Not Be Loaded From the SQL Server at this time.">
    </CFCATCH>
</CFTRY>

<CFIF IsDefined("error_message")>
    <CFOUTPUT>#error_message#</CFOUTPUT><cfabort>
</CFIF>

<cftry>
   <CFSET p = objDTS.Execute()>
  
  <cfcatch>
     The DTS Package caused an error and could not be loaded.<cfabort>
  </cfcatch>
</cftry> --->

<!--- This will begin the processing --->
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Load Rosters">
	
		    <cfquery name="getProcessed" datasource="CBARoster">
			  Update Roster
			  Set Meeting_year = year(apptdate),
			      Meeting_month = month(apptdate),
			      Meeting_day = day(apptdate)
			  Where FileProcessed >= #CreateODBCDate(now())#
			</cfquery>
			 
			<cfquery name="getProcessed" datasource="CBARoster">
			  Select *
			  From Roster
			  Where FileProcessed >= #CreateODBCDate(now())#
			  Order By lastname, firstname
			</cfquery>
<cfoutput>Pulled #GetProcessed.recordCount# Records to update<br><br></cfoutput>
			<cfloop query="GetProcessed">
			   <cfset thisModeratorName = "">
			   <cfset ThisConferenceCompany = "">
			   <cfset ThisHonorariaType = "">
			   <cfset ThisHonoraria = "">
			 
			   <cfset MeetingCodeValue = trim(GetProcessed.meetingcode)>
			   <cfset sMeetingCode = Mid(MeetingCodeValue, 1, 9)>
			   <cfset sClientCode = Mid(MeetingCodeValue, 1, 5)>
			  
			   <!--- <cfset TimeString = GetProcessed.ApptTime>  --->
			
			   <cfset TimeString = Right(MeetingCodeValue,4)>
			   <cfset TimeString = Left(TimeString, 2) & ":" & Mid(TimeString, 3, 1) & "0" & "PM"> 
			   <cfset sCivTime = TimeString>
			   <cfset sTimeLength = Len(sCivTime)>
				
			   <cfif sTimeLength EQ 7>		
			
					<cfset BMeridiem = Mid(sCivTime, 6, 2)>
					<cfset BHour = Mid(sCivTime, 1, 2)>
					<cfset BMinute = Mid(sCivTime, 4, 2)>
					
					<cfif BMeridiem EQ 'AM'>
						<cfswitch expression="#BHour#">
							<cfcase value="01"><cfset MilitaryHour = "0100"></cfcase>
							<cfcase value="02"><cfset MilitaryHour = "0200"></cfcase>
							<cfcase value="03"><cfset MilitaryHour = "0300"></cfcase>
							<cfcase value="04"><cfset MilitaryHour = "0400"></cfcase>
							<cfcase value="05"><cfset MilitaryHour = "0500"></cfcase>
							<cfcase value="06"><cfset MilitaryHour = "0600"></cfcase>
							<cfcase value="07"><cfset MilitaryHour = "0700"></cfcase>
							<cfcase value="08"><cfset MilitaryHour = "0800"></cfcase>
							<cfcase value="09"><cfset MilitaryHour = "0900"></cfcase>
							<cfcase value="10"><cfset MilitaryHour = "1000"></cfcase>
							<cfcase value="11"><cfset MilitaryHour = "1100"></cfcase>
							<cfcase value="12"><cfset MilitaryHour = "2400"></cfcase>
						</cfswitch>
					<cfelse>
						<cfswitch expression="#BHour#">
							<cfcase value="12"><cfset MilitaryHour = "1200"></cfcase>
							<cfcase value="01"><cfset MilitaryHour = "1300"></cfcase>
							<cfcase value="02"><cfset MilitaryHour = "1400"></cfcase>
							<cfcase value="03"><cfset MilitaryHour = "1500"></cfcase>
							<cfcase value="04"><cfset MilitaryHour = "1600"></cfcase>
							<cfcase value="05"><cfset MilitaryHour = "1700"></cfcase>
							<cfcase value="06"><cfset MilitaryHour = "1800"></cfcase>
							<cfcase value="07"><cfset MilitaryHour = "1900"></cfcase>
							<cfcase value="08"><cfset MilitaryHour = "2000"></cfcase>
							<cfcase value="09"><cfset MilitaryHour = "2100"></cfcase>
							<cfcase value="10"><cfset MilitaryHour = "2200"></cfcase>
							<cfcase value="11"><cfset MilitaryHour = "2300"></cfcase>
						</cfswitch>
					</cfif>
					
					<cfif BMinute EQ "30">
						<cfset MilitaryMinute = "50">
					<cfelse>
						<cfset MilitaryMinute = "00">
					</cfif>
			
					<cfset sTheTime = MilitaryHour + MilitaryMinute>
					<cfset MilTime = sTheTime>		
			       <cfset strMilitaryTime = trim(MilTime)>
				  <cfelse>
				    <cfset strMilitaryTime = 0000>	
				  </cfif>			
				
				<CFQUERY DATASOURCE="PMS" NAME="getMeeting">
					SELECT rowid, staff_id FROM schedule_meeting_time 
					WHERE project_code = '#Trim(sMeetingCode)#' 
					AND year = #Getprocessed.meeting_year# 
					AND month = #getProcessed.Meeting_Month#
					AND day = #getProcessed.Meeting_Day# 
					AND start_time = '#strMilitaryTime#'
					AND status = 0 
					AND staff_type = 1
				</cfquery> 
				
				<cfset sPreviousMeetingCode = MeetingCodeValue>
				
				
				<cfif getMeeting.recordcount LT 1>
					<cfoutput>
					 
					<strong>Error on Line #getProcessed.CurrentRow#: Could Not Find Meeting #GetProcessed.MeetingCode# at #strMilitaryTime#<br></strong></cfoutput>
				    <cfset ThisModeratorName = "N/A"> 
					
				<cfelse>
					<!----Pull the Moderator Name---->
					<CFQUERY DATASOURCE="#session.spkrdbs#" NAME="GetModerator">
						SELECT firstname, lastname
						FROM spkr_table 
						WHERE speaker_id = #getMeeting.staff_id#
					</CFQUERY>
					<cfif GetModerator.recordcount LT 1>
						<cfoutput><strong>Error on Line #getProcessed.CurrentRow#: Could Not Find Moderator for Meeting #GetProcessed.MeetingCode#<br></strong></cfoutput>
				
						<!--- bj20050307 - removed error logging, program was abending on this statement.
						<cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output="Function: CheckMeetingCode_AppendPIWInfo() || Error: Moderator assignment could not be located. || Meeting: #sMeetingCode# || Record: #h#">
						--->
						<cfset ThisModeratorName = "N/A">
					<cfelse>
					
				
						<cfset ThisModeratorName = trim(GetModerator.firstname) & " " & trim(GetModerator.lastname)>
					</cfif>		
				</cfif>				
					<!----Pull the Conference Company---->
					<CFQUERY DATASOURCE="Projman" NAME="getConferenceCompany">
						SELECT p.conference_company, c.conf_company_name 
						FROM piw p, conference_company c
						WHERE project_code = '#sMeetingCode#' 
						AND p.conference_company = c.id  
					</cfquery>
					<!----Set the Conference Company Name to the Array--->
					
					<cfif getConferenceCompany.recordcount LT 1>
						<cfoutput><strong>Error on Line #getProcessed.CurrentRow#: Could Not Find Conference Company for Meeting #GetProcessed.MeetingCode#<br></strong></cfoutput>
				
						
						<cfset ThisConferenceCompany = "N/A">
					<cfelse>
						<cfset ThisConferenceCompany = getConferenceCompany.conf_company_name>
					</cfif>
					
					
					<!----Pull the Honoraria Type---->
					<CFQUERY DATASOURCE="Projman" NAME="getHonType">
						SELECT attendee_comp_type 
						FROM piw 
						WHERE project_code = '#sMeetingCode#'  
					</cfquery>
					
					<!----Set the Honoraria Type to the Array--->
				
					<cfif getHonType.recordcount LT 1>
						<cfoutput><strong>Error on Line #getProcessed.CurrentRow#: Could Not Find Honoraria type for Meeting #GetProcessed.MeetingCode#<br></strong></cfoutput>
				                    <cfset ThisHonorariaType= "N/A">
					<cfelseif getHonType.attendee_comp_type EQ "">
						<cfoutput><strong>Error on Line #getProcessed.CurrentRow#: Could Not Find Honoraria type for Meeting #GetProcessed.MeetingCode#<br></strong></cfoutput>
				
						<cfset ThisHonorariaType = "N/A">
					<cfelse>
						<cfset ThisHonorariaType  = getHonType.attendee_comp_type>
					</cfif>
				
									
					
					<!----Pull the Honoraria---->
					<CFQUERY DATASOURCE="Projman" NAME="GetHonoraria">
						SELECT attendee_comp
						FROM piw 
						WHERE project_code = '#sMeetingCode#' 
					</CFQUERY>
					
					<!---Ensure that we can find the honoraria fee.  If not put a error in the log file, and just make it empty string.--->
				
					<cfif GetHonoraria.recordcount LT 1>
						<cfset ThisHonoraria = "N/A">
					<cfelseif GetHonoraria.attendee_comp EQ "">
						<cfset ThisHonoraria = "N/A">
					<cfelse>
						<cfset ThisHonoraria = GetHonoraria.attendee_comp>
					</cfif>
					
					  <cfquery name="UpdateRoster" datasource="CBARoster">
					      Update Roster
						  Set honoraria = '#ThisHonoraria#',
						       honoraria_type = '#ThisHonorariaType#',
							   moderator = '#ThisModeratorName#',
							   conference = '#ThisConferenceCompany#',
							   ApptTime = '#TimeString#'
						  Where RowID = #GetProcessed.RowID#	   
					   </cfquery> 
			
			</cfloop>
<!--- 		 Processed #NRecs# Records from this File<br><br>
		 Update Complete... Zipping Up File<br>
		
		<cfset ZipFile = "#FileDir#\Processed\ProcessedROSTER_#DateFormat(now(), 'mmddyyyy')#_#RandRange(1,1000)#.zip">	 
		<cfset Processedfile = "#FileDir#\#DirFiles.Name#">
		<!--- Zip the file --->
         <cfx_zipman 
		     ACTION="add" 
		     ZIPFILE="#ZipFile#" 
		     INPUT_FILES="#Processedfile#"> 
	   <cffile action="delete" file="#Processedfile#">	
	   File is Zipped an is Located at #ZipFile#<br><br>
	   
<cfmail from="rsloan@pharmakonllc.com" to="rsloan@pharmakonllc.com" subject="Daily Roster Uploaded">
The Roster was Loaded for today with the following stats.
Loaded #DirFiles.Name#
Found #DirFiles.RecordCount# Files To process
File Zipped up and moved to #ZipFile#
		  
</cfmail> --->
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">