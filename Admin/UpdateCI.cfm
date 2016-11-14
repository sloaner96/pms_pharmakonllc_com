<cfoutput>
<font size="-2" face="arial">
<cfset FileDir = "\\beethoven\USERS\CIDaily\comma">
<!--- Get the Files in the directory and process them --->
	<cfdirectory action="LIST" 
	     directory="#FileDir#" 
		 name="DirFiles" 
         filter="*.txt"
		 sort="dateLastModified"> 
	Getting	List of Files to Process<br>
	Found #DirFiles.RecordCount# Files To process<br>
	<!--- Delete the data out of the CI Dump Area --->
	
	 
	 Deleted Records from Daily_CIUpload<br>
	<cfif DirFiles.RecordCount GT 0> 
	<cfflush interval="15">
	<cfloop query="DirFiles"> 
	<cfquery name="DeleteRec" datasource="CBAROSTER">
	    Delete From Daily_CIUpload
	 </cfquery>
	    <cfset NRecs = 0>
		<!--- Read the Records in and process them into the temp area --->
		<cffile action="READ" file="#FileDir#\#DirFiles.Name#" variable="InData">
		Reading File  (#DirFiles.Name#)<br> 
		 <cfset newFileName = ReplaceNoCase(DirFiles.Name, '.txt', '', 'ALL')>
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
                   <!--- HEADER:: #replaceNoCase(ImpRec, "|", "|<br>", "ALL")#<br><br>  --->
		       <cfelse>

			        <cfset NRecs = NRecs +1>
				<cfif ListLen(ImpRec, "|") EQ 54>
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
				    <cfset ThisRec.BlitzSerialID = ListgetAt(ImpRec, 54, "|")> 
			        <!--- Insert the data into Daily_CIUpload temp table--->
				
				      <cfquery name="InsertCI" datasource="CBAROSTER">
						    Insert Into Daily_CIUpload(
							    PHID,
								MeetingCode,
								MeetingDate,
								MeetingTime,
								FirstName,
								MiddleName,
								LastName,
								OfficeAddr1,
								OfficeAddr2,
								OfficeCity,
								OfficeState,
								OfficeZipCode,
								ShiptoAddr1,
								ShiptoAddr2,
								ShiptoCity,
								ShiptoState,
								ShiptoZipCode,
								Specialty,
								Salutation,
								Degree,
								CETPhone,
								OfficePhone,
								FaxAuthorized,
								Fax,
								emailaddr,
								eGuidebook,
								eGdbkEmailAddr,
								CIStatus,
								ConfirmStatus,
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
								Recruit1,
								Recruit2,
								DateSet,
								Project,
								ContactID,
								ProspectID,
								EventID,
								User1,
								User2,
								User3,
								User4,
								User5,
								User6,
								BlitzSerialID
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
								<cfif Len(Trim(ThisRec.User1)) GT 0>#Trim(ThisRec.User1)#<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.User2)) GT 0>'#Trim(ThisRec.User2)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.User3)) GT 0>'#Trim(ThisRec.User3)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.User4)) GT 0>#Trim(ThisRec.User4)#<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.User5)) GT 0>'#Trim(ThisRec.User5)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.User6)) GT 0>'#Trim(ThisRec.User6)#'<cfelse>NULL</cfif>,
								<cfif Len(Trim(ThisRec.BlitzSerialID)) GT 0>'#Trim(ThisRec.BlitzSerialID)#'<cfelse>NULL</cfif>
							)
						 </cfquery>
						 
					     <cfset delStruct = StructClear(ThisRec)>
					<cfelse>
					   #ImpREC#<br>
					   <br>The Row (#NRecs#) was not a valid row, it did not have 53 columns it had #ListLen(ImpRec, "|")#.<br>
					</cfif>	 
			   </cfif>
		   <cfelse>
		     Blank Row<br>
		   </cfif>
		 </cfloop>
		 Processed #NRecs# Records from this File<br>
		<!--- Get the records just inserted and loop over--->
		  <cfquery name="getTemp" datasource="CBAROSTER">
		    Select *
			From Daily_CIUpload
			Where LoadDate >= #CreateODBCDate(Now())#
			order By MeetingCode, BlitzSerialID, CIStatus, Lastname, firstname, PHID
		  </cfquery>	
		  
		  Matching Records to the CI Database<br>
		   <cfset UpdateRecords = 0>
		   <cfset InsertRecords = 0>
		  <cfset CommitIt ="True">
		    <cftransaction action="BEGIN"> 
			   <cftry> 
		  <cfloop query="getTemp">
			<!--- Check the database to see if a record for this meeting already exists for the user.  --->
			  <cfquery name="MatchDB" datasource="CBAROSTER" timeout="1500">
	           Select *
				From CI_DB
				Where (EventKey = '#getTemp.MeetingCode#'
				AND ((PHID = #getTemp.PHID# AND PHID <> 0 AND PHID IS NOT NULL)
				
				OR (LastName = '#getTemp.LastName#'
				AND FirstName = '#getTemp.FirstName#'
				AND OfficeZip = '#getTemp.OfficeZipCode#')))
			  </cfquery> 		
			  
			   <!--- If the record exists, check the status, if cancelled, 
					      update the record with the status, otherwise insert the record ---> 
			   
			   <cfif MatchDB.recordcount GT 0>
			      <cfquery name="UpdateRec" datasource="CBAROSTER">
				    Update CI_DB
					Set CIStatus = '#getTemp.CIStatus#'
					Where RowID = #MatchDB.RowID#
				  </cfquery>   
				  <cfset UpdateRecords = UpdateRecords + 1>
			   <cfelse>
			     <cfset EvDateTime = "#DateFormat(GetTemp.MeetingDate, 'MM/DD/YYYY')# #trim(getTemp.meetingTime)#">
			      <cfquery name="InsertRec" datasource="CBAROSTER">
				    Insert Into CI_DB(
					    phid,
						EventKey,
						EventDate,
						EventDateTime,
						EventTime,
						FirstName,
						MiddleName,
						LastName,
						OfficeAdd1,
						OfficeAdd2,
						OfficeCity,
						OfficeState,
						OfficeZip,
						ShipAdd1,
						ShipAdd2,
						ShipCity,
						ShipState,
						ShipZip,
						Specialty,
						Salutation,
						Degree,
						CETPHONE,
						OfficePhone,
						FaxAuthorized,
						Fax,
						email,
						eGuidebook,
						eGdbkEmailAddr,
						Status,
						CIStatus,
						ConfirmStatus,
						menum,
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
						DateSet,
						BlitzProject,
						blitz_ContactID,
						BlitzProspectID,
						BlitzEventID,
						User1,
						User2,
						User3,
						User4,
						User5,
						User6,
						BlitzSerialID
					)
					Values(
					    <cfif Len(Trim(GetTemp.phid)) GT 0>#trim(GetTemp.phid)#<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.MeetingCode)) GT 0>'#trim(GetTemp.MeetingCode)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.MeetingDate)) GT 0>#createODBCDate(trim(GetTemp.MeetingDate))#<cfelse>NULL</cfif>,
						<cfif Len(Trim(EvDateTime)) GT 0>#createODBCDatetime(EvDateTime)#<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.MeetingTime)) GT 0>'#trim(GetTemp.MeetingTime)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.FirstName)) GT 0>'#trim(GetTemp.FirstName)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.MiddleName)) GT 0>'#trim(GetTemp.MiddleName)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.LastName)) GT 0>'#trim(GetTemp.LastName)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.OfficeAddr1)) GT 0>'#trim(GetTemp.OfficeAddr1)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.OfficeAddr2))GT 0>'#trim(GetTemp.OfficeAddr2)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.OfficeCity)) GT 0>'#trim(GetTemp.OfficeCity)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.OfficeState)) GT 0>'#Trim(GetTemp.OfficeState)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.OfficeZipCode)) GT 0>'#Trim(GetTemp.OfficeZipCode)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.ShiptoAddr1)) GT 0>'#Trim(GetTemp.ShiptoAddr1)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.ShiptoAddr2)) GT 0>'#Trim(GetTemp.ShiptoAddr2)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.ShiptoCity)) GT 0>'#Trim(GetTemp.ShiptoCity)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.ShiptoState)) GT 0>'#Trim(GetTemp.ShiptoState)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.ShiptoZipCode)) GT 0>'#Trim(GetTemp.ShiptoZipCode)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.Specialty)) GT 0>'#Trim(GetTemp.Specialty)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.Salutation)) GT 0>'#Trim(GetTemp.Salutation)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.Degree)) GT 0>'#Trim(GetTemp.Degree)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.CETPhone)) GT 0>'#Trim(GetTemp.CETPhone)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.OfficePhone)) GT 0>'#Trim(GetTemp.OfficePhone)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.FaxAuthorized)) GT 0>#Trim(GetTemp.FaxAuthorized)#<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.Fax)) GT 0>'#Trim(GetTemp.Fax)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.emailaddr)) GT 0>'#Trim(GetTemp.emailaddr)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.eGuidebook)) GT 0>#Trim(GetTemp.eGuidebook)#<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.eGdbkEmailAddr)) GT 0>'#Trim(GetTemp.eGdbkEmailAddr)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.CIStatus)) GT 0>'#Trim(GetTemp.CIStatus)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.CIStatus)) GT 0>'#Trim(GetTemp.CIStatus)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.ConfirmStatus)) GT 0>'#Trim(GetTemp.ConfirmStatus)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.Menum)) GT 0>'#Trim(GetTemp.Menum)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.Screener1)) GT 0>'#Trim(GetTemp.Screener1)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.Screener2)) GT 0>'#Trim(GetTemp.Screener2)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.Screener3)) GT 0>'#Trim(GetTemp.Screener3)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.Screener4)) GT 0>'#Trim(GetTemp.Screener4)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.Screener5)) GT 0>'#Trim(GetTemp.Screener5)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.Screener6)) GT 0>'#Trim(GetTemp.Screener6)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.Screener7)) GT 0>'#Trim(GetTemp.Screener7)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.Screener8)) GT 0>'#Trim(GetTemp.Screener8)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.Screener9)) GT 0>'#Trim(GetTemp.Screener9)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.Screener10)) GT 0>'#Trim(GetTemp.Screener10)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.Recruit1)) GT 0>#Trim(GetTemp.Recruit1)#<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.Recruit2)) GT 0>#Trim(GetTemp.Recruit2)#<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.DateSet)) GT 0>#CreateODBCDate(Trim(GetTemp.DateSet))#<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.Project)) GT 0>'#Trim(GetTemp.Project)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.ContactID)) GT 0>#Trim(GetTemp.ContactID)#<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.ProspectID)) GT 0>#Trim(GetTemp.ProspectID)#<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.EventID)) GT 0>#Trim(GetTemp.EventID)#<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.User1)) GT 0>#Trim(GetTemp.User1)#<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.User2)) GT 0>'#Trim(GetTemp.User2)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.User3)) GT 0>'#Trim(GetTemp.User3)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.User4)) GT 0>#Trim(GetTemp.User4)#<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.User5)) GT 0>'#Trim(GetTemp.User5)#'<cfelse>NULL</cfif>,
						<cfif Len(Trim(GetTemp.User6)) GT 0>'#Trim(getTemp.User6)#'<cfelse>NULL</cfif>,
					    <cfif Len(Trim(GetTemp.BlitzSerialID)) GT 0>'#Trim(getTemp.BlitzSerialID)#'<cfelse>NULL</cfif>
					)
				  </cfquery>
				  <cfset EvDateTime = "">
				  <cfset InsertRecords = InsertRecords + 1>
			   </cfif>
			   
			   
			   
			   
		   </cfloop>
		   <cfcatch>
			     <cftransaction action="Rollback" /> 
			     <cfset CommitIt ="False">
			   </cfcatch>
			   </cftry>
			   
			   <cfif CommitIt>
			     <cftransaction action="COMMIT" />
			   </cfif>
			   </cftransaction>
		   New Records Inserted: #InsertRecords#<br>
		   Records Updated: #UpdateRecords#<br>
		   
		   <br>
		   
		   Update Complete... Zipping Up File<br>
		
		<cfset ZipFile = "#FileDir#\Processed\ProcessedCI_#newFileName#_#DateFormat(now(), 'mmddyyyy')#_#RandRange(1,1000)#.zip">	 
		<cfset Processedfile = "#FileDir#\#DirFiles.Name#">
		<!--- Zip the file --->
         <cfx_zipman 
		     action="add" 
		     ZIPFILE="#ZipFile#" 
		     INPUT_FILES="#Processedfile#"> 
	    <cffile action="delete" file="#Processedfile#">	
	   File is Zipped an is Located at #ZipFile#<br><br>
	   
<cfmail from="rsloan@pharmakonllc.com" to="rsloan@pharmakonllc.com" subject="Daily CI Uploaded">
The CI was Loaded for today with the following stats.
Loaded #DirFiles.Name#
Found #DirFiles.RecordCount# Files To process
New Records Inserted: #InsertRecords#
Existing Records Updated: #UpdateRecords#

File Zipped up and moved to #ZipFile#  
</cfmail>
     <hr>
    </cfloop>
<cfelse>
There are no files to process.
</cfif>	
</font>

</cfoutput>
