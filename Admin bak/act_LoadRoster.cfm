<cfset FileDir = "\\MOZART\USERS\RosterDaily">
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Rep Update Program" showCalendar="1">
<font size="-2" face="arial">
<cfoutput>
<!--- Get the Files in the directory and process them --->
<cfdirectory action="LIST" 
     directory="#FileDir#" 
	 name="DirFiles" 
        filter="*.txt"
	 sort="dateLastModified"> 
Getting	List of Files to Process<br>
Found #DirFiles.RecordCount# Files To process<br>

<cfloop query="DirFiles">
	    <cfset NRecs = 0>
		<!--- Read the Records in and process them into the temp area --->
		<cffile action="READ" file="#FileDir#\#DirFiles.Name#" variable="InData">
		Reading File<br> 
		 
		 <cfset InData = ReplaceNoCase(InData, ',', ' | ', 'ALL')>
		 <cfset InData = ReplaceNoCase(InData, '"', '', 'ALL')>
		 <cfloop index="ImpRec" list="#InData#" delimiters="#chr(13)##chr(10)#">  
		   
		   <!--- Make sure there is a record here and if it is the first record lets check that everything looks good --->
		   <cfif Len(ImpRec) gt 1> 
			   <cfif FindNoCase('PHID', ImpRec) eq 1>
				  <!--- Check that there are the proper number of columns and that the columns match up --->
				  <!--- <cfloop index="header" list="ImpRec" delimiters=",">
				    <cfswitch expression="#header#">
					  <cfcase value="PHID">
					    
					  </cfcase>
					</cfswitch>
				  </cfloop> --->
                   HEADER:: #replaceNoCase(ImpRec, "|", "|", "ALL")#<br><br> 
		       <cfelse>

			        <cfset NRecs = NRecs +1>
					
					
					<cfset ThisRec.phid			= ListgetAt(ImpRec, 1, "|")>
					<cfset ThisRec.MeetingCode	= ListgetAt(ImpRec, 2, "|")>
					<cfset ThisRec.MeetingDate	= ListgetAt(ImpRec, 3, "|")>
					<cfset ThisRec.MeetingTime	= ListgetAt(ImpRec, 4, "|")>
					<cfset ThisRec.FirstName	= ListgetAt(ImpRec, 5, "|")>
					<cfset ThisRec.MiddleName	= ListgetAt(ImpRec, 6, "|")>
					<cfset ThisRec.LastName		= ListgetAt(ImpRec, 7, "|")>
					<cfset ThisRec.OfficeAdd1	= ListgetAt(ImpRec, 8, "|")>
					<cfset ThisRec.OfficeAdd2	= ListgetAt(ImpRec, 9, "|")>
					<cfset ThisRec.OfficeCity	= ListgetAt(ImpRec, 10, "|")>
					<cfset ThisRec.OfficeState	= ListgetAt(ImpRec, 11, "|")>
					<cfset ThisRec.OfficeZipCode= ListgetAt(ImpRec, 12, "|")>
					<cfset ThisRec.ShiptoAdd1	= ListgetAt(ImpRec, 13, "|")>
					<cfset ThisRec.ShiptoAdd2	= ListgetAt(ImpRec, 14, "|")>
					<cfset ThisRec.ShiptoCity	= ListgetAt(ImpRec, 15, "|")>
					<cfset ThisRec.ShiptoState	= ListgetAt(ImpRec, 16, "|")>
					<cfset ThisRec.ShiptoZipCode= ListgetAt(ImpRec, 17, "|")>
					<cfset ThisRec.Specialty	= ListgetAt(ImpRec, 18, "|")>
					<cfset ThisRec.Salutation	= ListgetAt(ImpRec, 19, "|")>
					<cfset ThisRec.Degree		= ListgetAt(ImpRec, 20, "|")>
					<cfset ThisRec.CETPhone		= ListgetAt(ImpRec, 21, "|")>
					<cfset ThisRec.OfficePhone	= ListgetAt(ImpRec, 22, "|")>
				    <cfset ThisRec.fax      	= ListgetAt(ImpRec, 23, "|")>
					<cfset ThisRec.FaxAuthorized= ListgetAt(ImpRec, 24, "|")>
					<cfset ThisRec.emailaddr	= ListgetAt(ImpRec, 25, "|")>
					<cfset ThisRec.eGuidebook	= ListgetAt(ImpRec, 26, "|")>
					<cfset ThisRec.eGdbkEmailAddr= ListgetAt(ImpRec, 27, "|")>
					<cfset ThisRec.CIStatus		= ListgetAt(ImpRec, 28, "|")>
					<cfset ThisRec.ConfirmStatus= ListgetAt(ImpRec, 29, "|")>
					<cfset ThisRec.Menum		= ListgetAt(ImpRec, 30, "|")>
					<cfset ThisRec.Screener1	= ListgetAt(ImpRec, 31, "|")>
					<cfset ThisRec.Screener2	= ListgetAt(ImpRec, 32, "|")>
					<cfset ThisRec.Screener3	= ListgetAt(ImpRec, 33, "|")>
					<cfset ThisRec.Screener4	= ListgetAt(ImpRec, 34, "|")>
					<cfset ThisRec.Screener5	= ListgetAt(ImpRec, 35, "|")>
					<cfset ThisRec.Screener6	= ListgetAt(ImpRec, 36, "|")>
					<cfset ThisRec.Screener7	= ListgetAt(ImpRec, 37, "|")>
					<cfset ThisRec.Screener8	= ListgetAt(ImpRec, 38, "|")>
					<cfset ThisRec.Screener9	= ListgetAt(ImpRec, 39, "|")>
					<cfset ThisRec.Screener10	= ListgetAt(ImpRec, 40, "|")>
					<cfset ThisRec.Recruit1		= ListgetAt(ImpRec, 41, "|")>
					<cfset ThisRec.Recruit2		= ListgetAt(ImpRec, 42, "|")>
					<cfset ThisRec.DateSet		= ListgetAt(ImpRec, 43, "|")>
					<cfset ThisRec.Project		= ListgetAt(ImpRec, 44, "|")>
					<cfset ThisRec.ContactID	= ListgetAt(ImpRec, 45, "|")>
					<cfset ThisRec.ProspectID	= ListgetAt(ImpRec, 46, "|")>
					<cfset ThisRec.EventID		= ListgetAt(ImpRec, 47, "|")>
					<cfset ThisRec.User1		= ListgetAt(ImpRec, 48, "|")>
					<cfset ThisRec.User2		= ListgetAt(ImpRec, 49, "|")>
					<cfset ThisRec.User3		= ListgetAt(ImpRec, 50, "|")>
					<cfset ThisRec.User4		= ListgetAt(ImpRec, 51, "|")>
					<cfset ThisRec.User5		= ListgetAt(ImpRec, 52, "|")>
					<cfset ThisRec.User6 		= ListgetAt(ImpRec, 53, "|")> 
				    
		            <cfdump var="#thisrec#"> 
					ThisRec.phid: #Len(ThisRec.phid)#<br>
					ThisRec.MeetingCode: #Len(ThisRec.MeetingCode)#<br>
					ThisRec.MeetingDate: #Len(ThisRec.MeetingDate)#<br>
					ThisRec.MeetingTime: #Len(ThisRec.MeetingTime)#<br>
					ThisRec.FirstName: #Len(ThisRec.FirstName)#<br>
					ThisRec.MiddleName: #Len(ThisRec.MiddleName)#<br>
					ThisRec.LastName: #Len(ThisRec.LastName)#<br>
					ThisRec.OfficeAdd1: #Len(ThisRec.OfficeAdd1)#<br>
					ThisRec.OfficeAdd2: #Len(ThisRec.OfficeAdd2)#<br>
					ThisRec.OfficeCity: #Len(ThisRec.OfficeCity)#<br>
					ThisRec.OfficeState: #Len(ThisRec.OfficeState)#<br>
					ThisRec.OfficeZipCode: #Len(ThisRec.OfficeZipCode)#<br>
					ThisRec.ShiptoAdd1: #Len(ThisRec.ShiptoAdd1)#<br>
					ThisRec.ShiptoAdd2: #Len(ThisRec.ShiptoAdd2)#<br>
					ThisRec.ShiptoCity: #Len(ThisRec.ShiptoCity)#<br>
					ThisRec.ShiptoState: #Len(ThisRec.ShiptoState)#<br>
					ThisRec.ShiptoZipCode: #Len(ThisRec.ShiptoZipCode)#<br>
					ThisRec.Specialty: #Len(ThisRec.Specialty)#<br>
					ThisRec.Salutation: #Len(ThisRec.Salutation)#<br>
					ThisRec.Degree: #Len(ThisRec.Degree)#<br>
					ThisRec.CETPhone: #Len(ThisRec.CETPhone)#<br>
					ThisRec.OfficePhone: #Len(ThisRec.OfficePhone)#<br>
				    ThisRec.fax: #Len(ThisRec.fax)#<br>
					ThisRec.FaxAuthorized: #Len(ThisRec.FaxAuthorized)#<br>
					ThisRec.emailaddr: #Len(ThisRec.emailaddr)#<br>
					ThisRec.eGuidebook: #Len(ThisRec.eGuidebook)#<br>
					ThisRec.eGdbkEmailAddr: #Len(ThisRec.eGdbkEmailAddr)#<br>
					ThisRec.CIStatus: #Len(ThisRec.CIStatus)#<br>
					ThisRec.ConfirmStatus: #Len(ThisRec.ConfirmStatus)#<br>
					ThisRec.Menum: #Len(ThisRec.Menum)#<br>
					ThisRec.Screener1: #Len(ThisRec.Screener1)#<br>
					ThisRec.Screener2: #Len(ThisRec.Screener2)#<br>
					ThisRec.Screener3: #Len(ThisRec.Screener3)#<br>
					ThisRec.Screener4: #Len(ThisRec.Screener4)#<br>
					ThisRec.Screener5: #Len(ThisRec.Screener5)#<br>
					ThisRec.Screener6: #Len(ThisRec.Screener6)#<br>
					ThisRec.Screener7: #Len(ThisRec.Screener7)#<br>
					ThisRec.Screener8: #Len(ThisRec.Screener8)#<br>
					ThisRec.Screener9: #Len(ThisRec.Screener9)#<br>
					ThisRec.Screener10: #Len(ThisRec.Screener10)#<br>
					ThisRec.Recruit1: #Len(ThisRec.Recruit1)#<br>
					ThisRec.Recruit2: #Len(ThisRec.Recruit2)#<br>
					ThisRec.DateSet: #Len(ThisRec.DateSet)#<br>
					ThisRec.Project: #Len(ThisRec.Project)#<br>
					ThisRec.ContactID: #Len(ThisRec.ContactID)#<br>
					ThisRec.ProspectID: #Len(ThisRec.ProspectID)#<br>
					ThisRec.EventID: #Len(ThisRec.EventID)#<br>
					ThisRec.User1: #Len(ThisRec.User1)#<br>
					ThisRec.User2: #Len(ThisRec.User2)#<br>
					ThisRec.User3: #Len(ThisRec.User3)#<br>
					ThisRec.User4: #Len(ThisRec.User4)#<br>
					ThisRec.User5: #Len(ThisRec.User5)#<br>
					ThisRec.User6: #Len(ThisRec.User6)#<br><br>
					 
					 
					<!--- Insert the data into Daily_CIUpload temp table--->
				     
				      <cfquery name="InsertRoster" datasource="CBAROSTERBackup">
						    Insert Into Roster(
							    PHID,
								MeetingCode,
								apptdate,
								appttime,
								FirstName,
								MiddleName,
								LastName,
								Office_Addr1,
								Office_Addr2,
								Office_City,
								Office_State,
								Office_ZipCode,
								Shipto_Addr1,
								Shipto_Addr2,
								Shipto_City,
								Shipto_State,
								Shipto_ZipCode,
								prime_Specialty,
								Salutation,
								Degree,
								CET_Phone,
								Office_Phone,
								FaxAuthorized,
								Fax,
								email,
								eGuidebook,
								eGdbkEmailAddr,
								CIStatus,
								Status,
								Menum,
								Screener1,
								Screener2,
								Screener3,
								Screener4,
								Screener5,
								Screener6,
								Screener7,
								Screener8,
								Screener9,
								Screener10,
								rep_nom,
								other_nom,
								meetingDate,
								Project,
								BlitzContactID,
								BlitzProspectID,
								BlitzEventID,
								User1,
								User2,
								User3,
								User4,
								User5,
								User6,
								meeting_year,
								meeting_month,
								meeting_day,
								PHID_OnFile,
								DB_Match,
								Attended,
								FileProcessed
							)
							VALUES(
							    <cfif Len(Trim(ThisRec.phid)) GT 0>#trim(ThisRec.phid)#<cfelse>0</cfif>,
								<cfif Len(Trim(ThisRec.MeetingCode)) GT 0>'#trim(ThisRec.MeetingCode)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.MeetingDate)) GT 0>#CreateODBCDate(trim(ThisRec.MeetingDate))#<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.MeetingTime)) GT 0>'#trim(ThisRec.MeetingTime)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.FirstName)) GT 0>'#trim(ThisRec.FirstName)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.MiddleName)) GT 0>'#trim(ThisRec.MiddleName)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.LastName)) GT 0>'#trim(ThisRec.LastName)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.OfficeAdd1)) GT 0>'#trim(ThisRec.OfficeAdd1)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.OfficeAdd2))GT 0>'#trim(ThisRec.OfficeAdd2)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.OfficeCity)) GT 0>'#trim(ThisRec.OfficeCity)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.OfficeState)) GT 0>'#Trim(ThisRec.OfficeState)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.OfficeZipCode)) GT 0>'#Trim(ThisRec.OfficeZipCode)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.ShiptoAdd1)) GT 0>'#Trim(ThisRec.ShiptoAdd1)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.ShiptoAdd2)) GT 0>'#Trim(ThisRec.ShiptoAdd2)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.ShiptoCity)) GT 0>'#Trim(ThisRec.ShiptoCity)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.ShiptoState)) GT 0>'#Trim(ThisRec.ShiptoState)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.ShiptoZipCode)) GT 0>'#Trim(ThisRec.ShiptoZipCode)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.Specialty)) GT 0>'#Trim(ThisRec.Specialty)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.Salutation)) GT 0>'#Trim(ThisRec.Salutation)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.Degree)) GT 0>'#Trim(ThisRec.Degree)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.CETPhone)) GT 0>'#Trim(ThisRec.CETPhone)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.OfficePhone)) GT 0>'#Trim(ThisRec.OfficePhone)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.FaxAuthorized)) GT 0>#Trim(ThisRec.FaxAuthorized)#<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.Fax)) GT 0>'#Trim(ThisRec.Fax)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.emailaddr)) GT 0>'#Trim(ThisRec.emailaddr)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.eGuidebook)) GT 0>#Trim(ThisRec.eGuidebook)#<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.eGdbkEmailAddr)) GT 0>'#Trim(ThisRec.eGdbkEmailAddr)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.CIStatus)) GT 0>'#Trim(ThisRec.CIStatus)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.ConfirmStatus)) GT 0>'#Trim(ThisRec.ConfirmStatus)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.Menum)) GT 0>'#Trim(ThisRec.Menum)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.Screener1)) GT 0>'#Trim(ThisRec.Screener1)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.Screener2)) GT 0>'#Trim(ThisRec.Screener2)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.Screener3)) GT 0>'#Trim(ThisRec.Screener3)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.Screener4)) GT 0>'#Trim(ThisRec.Screener4)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.Screener5)) GT 0>'#Trim(ThisRec.Screener5)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.Screener6)) GT 0>'#Trim(ThisRec.Screener6)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.Screener7)) GT 0>'#Trim(ThisRec.Screener7)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.Screener8)) GT 0>'#Trim(ThisRec.Screener8)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.Screener9)) GT 0>'#Trim(ThisRec.Screener9)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.Screener10)) GT 0>'#Trim(ThisRec.Screener10)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.Recruit1)) GT 0>#Trim(ThisRec.Recruit1)#<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.Recruit2)) GT 0>#Trim(ThisRec.Recruit2)#<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.DateSet)) GT 0>#CreateODBCDate(Trim(ThisRec.DateSet))#<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.Project)) GT 0>'#Trim(ThisRec.Project)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.ContactID)) GT 0>#Trim(ThisRec.ContactID)#<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.ProspectID)) GT 0>#Trim(ThisRec.ProspectID)#<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.EventID)) GT 0>#Trim(ThisRec.EventID)#<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.ContactID)) GT 0>#Trim(ThisRec.ContactID)#<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.ProspectID)) GT 0>'#Trim(ThisRec.ProspectID)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.User3)) GT 0>'#Trim(ThisRec.User3)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.User4)) GT 0>#Trim(ThisRec.User4)#<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.User5)) GT 0>'#Trim(ThisRec.User5)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.EventID)) GT 0>#Trim(ThisRec.EventID)#<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.MeetingDate)) GT 0>'#year(trim(ThisRec.MeetingDate))#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.MeetingDate)) GT 0>'#Month(trim(ThisRec.MeetingDate))#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.MeetingDate)) GT 0>'#Day(trim(ThisRec.MeetingDate))#'<cfelse>NULL</cfif>,
							    0,
								'0',
								0,
								#CreateODBCDateTime(now())#
							)
						 </cfquery>
					     <cfset delStruct = StructClear(ThisRec)>
			   </cfif>
		   <cfelse>
		     Blank Row<br>
		   </cfif>
		 </cfloop>
		
	
			<cfquery name="getProcessed" datasource="CBARosterBackup">
			  Select *
			  From Roster
			  Where FileProcessed >= #CreateODBCDate(now())#
			  Order By lastname, firstname
			</cfquery>

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
				
				<CFQUERY DATASOURCE="projman" NAME="getMeeting">
					SELECT rowid, staff_id FROM ScheduleSpeaker 
					WHERE project_code = '#sMeetingCode#' 
					AND year = #Getprocessed.meeting_year# 
					AND month = #getProcessed.Meeting_Month#
					AND day = #getProcessed.Meeting_Day# 
					AND start_time = #strMilitaryTime#
					AND status = 0 AND staff_type = 1
				</cfquery> 
				
				<cfset sPreviousMeetingCode = MeetingCodeValue>
				
				
				<cfif getMeeting.recordcount LT 1>
					<cfoutput>
					<strong>Error on Line #getProcessed.CurrentRow#: Could Not Find Meeting #GetProcessed.MeetingCode#<br></strong></cfoutput>
				                   <cfset ThisModeratorName = "N/A"> 
					
				<cfelse>
					<!----Pull the Moderator Name---->
					<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetModerator">
						SELECT firstname, lastname
						FROM Speaker 
						WHERE speakerid = #getMeeting.staff_id#
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
					
					  <cfquery name="UpdateRoster" datasource="CBARosterBackup">
					      Update Roster
						  Set honoraria = '#ThisHonoraria#',
						       honoraria_type = '#ThisHonorariaType#',
							   moderator = '#ThisModeratorName#',
							   conference = '#ThisConferenceCompany#',
							   ApptTime = '#TimeString#'
						  Where RowID = #GetProcessed.RowID#	   
					   </cfquery> 
			
			</cfloop>
		 Processed #NRecs# Records from this File<br><br>
		 Update Complete... Zipping Up File<br>
		
		<cfset ZipFile = "#FileDir#\Processed\ProcessedROSTER_#DateFormat(now(), 'mmddyyyy')#_#RandRange(1,1000)#.zip">	 
		<cfset Processedfile = "#FileDir#\#DirFiles.Name#">
		<!--- Zip the file --->
         <cfx_zipman 
		     action="add" 
		     ZIPFILE="#ZipFile#" 
		     INPUT_FILES="#Processedfile#"> 
	   <cffile action="delete" file="#Processedfile#">	
	   File is Zipped an is Located at #ZipFile#<br><br>
	   
<cfmail from="rsloan@pharmakonllc.com" to="rsloan@pharmakonllc.com" subject="Daily Roster Uploaded">
The Roster was Loaded for today with the following stats.
Loaded #DirFiles.Name#
Found #DirFiles.RecordCount# Files To process
File Zipped up and moved to #ZipFile#
		  
</cfmail>
    </cfloop>

</cfoutput> 
</font>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">