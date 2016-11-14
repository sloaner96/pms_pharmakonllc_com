<!--------------------
cfc_get_piwinfo.cfc

Used to retreive information relating to the PIW table.

10/26/02 -- Matt Eaves -- Initial Code 
----------------------->

<cfcomponent>
	<cffunction name="getRecruiter" hint="Gets the Recruiter Company for a Project" access="public" output="true" returntype="string">
		<cfargument name="ProjCode" hint="The Project Code" type="string" required="true"/>
			
		<CFQUERY DATASOURCE="#session.dbs#" NAME="getRecru">
			SELECT recruiting_company
			FROM piw
			WHERE project_code = '#arguments.ProjCode#'
		</CFQUERY>
		
		<cfif getRecru.recordcount>
			<cfswitch expression="#getRecru.recruiting_company#">
				<cfcase value="1">
					<cfset Company = "Blitz">
				</cfcase>
				<cfcase value="2">
					<cfset Company = "Synergy">
				</cfcase>
				<cfcase value="3">
					<cfset Company = "Prairie">
				</cfcase>
				<cfdefaultcase>
					<cfset Company = "N/A">
				</cfdefaultcase>
			</cfswitch>
			
			<cfreturn #Company#>
				
		<cfelse>
			<cfset temp = "Error!">
			<cfreturn #temp#>
		</cfif>
	</cffunction>
	
	<cffunction name="getConference" hint="Gets the Conference Company for a Project" access="public" output="true" returntype="string">
		<cfargument name="ProjCode" hint="The Project Code" type="string" required="true"/>
			
		<CFQUERY DATASOURCE="#session.dbs#" NAME="getCon" USERNAME="#session.dbu#" PASSWORD="#session.dbp#">
			SELECT conference_company
			FROM piw
			WHERE project_code = '#arguments.ProjCode#'
		</CFQUERY>
		
		<cfif getCon.recordcount>
			<cfswitch expression="#getCon.conference_company#">
				<cfcase value="1">
					<cfset Company = "Vialog">
				</cfcase>
				<cfcase value="2">
					<cfset Company = "Premiere">
				</cfcase>
				<cfcase value="3">
					<cfset Company = "Prairie">
				</cfcase>
				<cfcase value="4">
					<cfset Company = "ACT">
				</cfcase>
				<cfcase value="5">
					<cfset Company = "Intercall">
				</cfcase>
				<cfdefaultcase>
					<cfset Company = "N/A">
				</cfdefaultcase>
			</cfswitch>
			
			<cfreturn #Company#>
				
		<cfelse>
			
			<cfset temp = "Error!">
			<cfreturn #temp#>
		
		</cfif>
	
	</cffunction>
	
<!---New Function---->
	<cffunction name="getModSpker" hint="Pulls the Moderator and/or Speaker Name" access="public" output="true" returntype="string">
		<cfargument name="cfcId" hint="The Moderator/Speaker ID" type="numeric" required="true"/>
			
		<CFQUERY DATASOURCE="#session.spkrdbs#" NAME="GetName" USERNAME="#session.spkrdbu#" PASSWORD="#session.spkrdbp#">
			SELECT DISTINCT firstname, lastname
			FROM spkr_table
			WHERE speaker_id = #arguments.cfcId# 
		</CFQUERY>
		
		
		<cfif getName.recordcount>
		<cfoutput query="GetName">
			<cfset Name = (#GetName.firstname# & ' ' & #GetName.lastname#)>
		</cfoutput>	
			<cfreturn #Name#>
				
		<cfelseif #arguments.cfcId# EQ 1>
		
			<cfset temp = "N/A">
			<cfreturn #temp#>
		
		<cfelse>
		
			<cfset temp = "Error!">
			<cfreturn #temp#>
			
		</cfif>
	</cffunction>
	

<!---New Function---->
	<cffunction name="getHonoraria" hint="Returns the Honoraria Amount the spkr/mod is getting paid" access="public" output="true" returntype="numeric">
		<cfargument name="cfcRowID" hint="The Row id that is associated with speaker_clients" type="numeric" required="true"/>
			
		<CFQUERY DATASOURCE="#session.spkrdbs#" NAME="GetFee" USERNAME="#session.spkrdbu#" PASSWORD="#session.spkrdbp#">
			SELECT fee 
			FROM speaker_clients
			WHERE rowid = #arguments.cfcRowID# 
		</CFQUERY>
		
		<cfif GetFee.recordcount>
			<cfreturn #GetFee.fee#>
		<cfelse>
			<cfreturn 0>
		</cfif>
		
	</cffunction>

<!---New Function---->
	<cffunction name="getAdditionalListenHono" hint="Gets honoraria associated with additional listen-ins" access="public" output="true" returntype="numeric">
		<cfargument name="cfcMeetingRowID" hint="Rowid from Schedule_Meeting_Time" type="numeric" required="true"/>
		
		<!---Because we don't know how many listen-ins a particular meeting will have, we query the table 
		and store the honoraria amounts in an variable.  The total of the variable is returned to the calling funtion. 
		This is done because if we have three listen ins, they are stored in the Excel or HTML <td> cell as 
		listen1, listen2, listen3.  We dont want to individually list each hono, so we present it as a total so 
		it can be totaled at the end.--->
		
		<CFQUERY DATASOURCE="#session.dbs#" NAME="GetRowIDs" USERNAME="#session.dbu#" PASSWORD="#session.dbp#">
			SELECT spkr_client_rowid 
			FROM listen_ins
			WHERE meeting_rowid = #arguments.cfcMeetingRowID# 
		</CFQUERY>
		
		<cfset HonoTotal = 0>
		
		<cfif GetRowIDs.recordcount>
			<cfoutput query="GetRowIDs">
				<cfscript>
					honoAmount = this.getHonoraria(cfcRowID="#GetRowIDs.spkr_client_rowid#");
				</cfscript>
				<cfset HonoTotal = #HonoTotal# + #honoAmount#>
			</cfoutput>
		</cfif>
				
		<cfreturn #HonoTotal#>
		
	</cffunction>

	
<!---New Function---->
	<cffunction name="getAdditionalSpeakerHono" hint="Gets honoraria associated with additional speakers" access="public" output="true" returntype="numeric">
		<cfargument name="cfcMeetingRowID" hint="Rowid from Schedule_Meeting_Time" type="numeric" required="true"/>
		
		<!---Because we don't know how many additional speakers a particular meeting will have, we query the table 
		and store the honoraria amounts in an variable.  The total of the variable is returned to the calling funtion. 
		This is done because if we have three additional speakers, they are stored in the Excel or HTML <td> cell as 
		speaker1, speaker2, speaker3.  We dont want to individually list each hono, so we present it as a total so 
		it can be totaled at the end.--->
		
		<CFQUERY DATASOURCE="#session.dbs#" NAME="GetRowIDs" USERNAME="#session.dbu#" PASSWORD="#session.dbp#">
			SELECT spkr_client_rowid 
			FROM additional_speakers
			WHERE meeting_rowid = #arguments.cfcMeetingRowID# 
		</CFQUERY>
		
		<cfset HonoTotal = 0>
		
		<cfif GetRowIDs.recordcount>
			<cfoutput query="GetRowIDs">
				<cfscript>
					honoAmount = this.getHonoraria(cfcRowID="#GetRowIDs.spkr_client_rowid#");
				</cfscript>
				<cfset HonoTotal = #HonoTotal# + #honoAmount#>
			</cfoutput>
		</cfif>
				
		<cfreturn #HonoTotal#>
		
	</cffunction>




<!---New Function---->
	<cffunction name="getRate" hint="Calculates the Show / No Show Rate" access="public" output="true" returntype="numeric">
		<cfargument name="cfcValue" hint="Decimal Value that is Stored in Database" type="numeric" required="true"/>
			
		<cfset rate = #arguments.cfcValue# * 100>
		<cfset rate = #DecimalFormat(rate)#>
		
		<cfreturn rate>
		
	</cffunction>
	
<!---New Function---->
	<cffunction name="getModListens" hint="Returns Listen Ins for Moderator" access="public" output="true" returntype="string">
		<cfargument name="cfcRowID" hint="Row ID for Current Record" type="numeric" required="true"/>
			
		<CFQUERY DATASOURCE="#session.dbs#" NAME="GetListen" USERNAME="#session.dbu#" PASSWORD="#session.dbp#">
			SELECT modspkrid
			FROM listen_ins 
			WHERE meeting_rowid = #arguments.cfcRowID# 
			AND type = 1
		</CFQUERY>
		
		<cfif GetListen.recordcount>
			
			<cfset listens = ArrayNew(1)>
			
			<cfloop query="GetListen">
				<CFQUERY DATASOURCE="#session.spkrdbs#" NAME="GetModerator" USERNAME="#session.spkrdbu#" PASSWORD="#session.spkrdbp#">
					SELECT firstname, lastname
					FROM spkr_table
					WHERE speaker_id = #GetListen.modspkrid#
				</CFQUERY>
				<cfset temp = #GetModerator.firstname# & " " & #GetModerator.lastname#>
				<cfset listens[currentRow] = temp>	
			</cfloop>
		
		<cfelse>
			<cfset listens = ArrayNew(1)>
			<cfset listens[1] = ''>
			<cfset TheListenIns = listens[1]>
		</cfif>
		
		<cfset TheListenIns = #ArrayToList(listens, ", ")#>
		
		<cfreturn #TheListenIns#>
		
	</cffunction>
	
<!---New Function---->	
	<cffunction name="getSpkrListens" hint="Returns Listen Ins for Client" access="public" output="true" returntype="string">
		<cfargument name="cfcRowID" hint="Row ID for Current Record" type="numeric" required="true"/>
			
		<CFQUERY DATASOURCE="#session.dbs#" NAME="GetListen" USERNAME="#session.dbu#" PASSWORD="#session.dbp#">
			SELECT modspkrid
			FROM listen_ins 
			WHERE meeting_rowid = #arguments.cfcRowID# 
			AND type = 2
		</CFQUERY>
		
		<cfif GetListen.recordcount>
			
			<cfset listens = ArrayNew(1)>
			
			<cfloop query="GetListen">
				<CFQUERY DATASOURCE="#session.spkrdbs#" NAME="GetSpeaker" USERNAME="#session.spkrdbu#" PASSWORD="#session.spkrdbp#">
					SELECT firstname, lastname
					FROM spkr_table
					WHERE speaker_id = #GetListen.modspkrid#
				</CFQUERY>
				<cfset temp = #GetSpeaker.firstname# & " " & #GetSpeaker.lastname#>
				<cfset listens[currentRow] = temp>	
			</cfloop>
		
		<cfelse>
			<cfset listens = ArrayNew(1)>
			<cfset listens[1] = ''>
			<cfset TheListenIns = listens[1]>
		</cfif>
		
		<cfset TheListenIns = #ArrayToList(listens, ", ")#>
		
		<cfreturn #TheListenIns#>
		
	</cffunction>
	
<!---New Function---->	
	<cffunction name="getTrainees" hint="Returns Trainees" access="public" output="true" returntype="string">
		<cfargument name="cfcRowID" hint="Row ID for Current Record" type="numeric" required="true"/>
			
		<CFQUERY DATASOURCE="#session.dbs#" NAME="GetTrain" USERNAME="#session.dbu#" PASSWORD="#session.dbp#">
			SELECT modspkrid
			FROM training 
			WHERE meeting_rowid = #arguments.cfcRowID# 
		</CFQUERY>
		
		<cfif GetTrain.recordcount>
			
			<cfset trainees = ArrayNew(1)>
			
			<cfloop query="GetTrain">
				<CFQUERY DATASOURCE="#session.spkrdbs#" NAME="GetPersonTrained" USERNAME="#session.spkrdbu#" PASSWORD="#session.spkrdbp#">
					SELECT firstname, lastname
					FROM spkr_table
					WHERE speaker_id = #GetTrain.modspkrid#
				</CFQUERY>
				<cfset temp = #GetPersonTrained.firstname# & " " & #GetPersonTrained.lastname#>
				<cfset trainees[currentRow] = temp>	
			</cfloop>
		
		<cfelse>
			<cfset trainees = ArrayNew(1)>
			<cfset trainees[1] = ''>
		</cfif>
		
		<cfset TheTrainees = #ArrayToList(trainees, ", ")#>
		
		<cfreturn #TheTrainees#>
		
	</cffunction>
	
	
	
<!---New Function---->
	<cffunction name="getTraineesHono" hint="Gets honoraria associated with trainees" access="public" output="true" returntype="numeric">
		<cfargument name="cfcMeetingRowID" hint="Rowid from Schedule_Meeting_Time" type="numeric" required="true"/>
		
		<!---Because we don't know how many trainees a particular meeting will have, we query the table 
		and store the honoraria amounts in an variable.  The total of the variable is returned to the calling funtion. 
		This is done because if we have three additional trainees, they are stored in the Excel or HTML <td> cell as 
		trainee1, trainee2, trainee3.  We dont want to individually list each hono, so we present it as a total so 
		it can be totaled at the end.--->
		
		<CFQUERY DATASOURCE="#session.dbs#" NAME="GetRowIDs" USERNAME="#session.dbu#" PASSWORD="#session.dbp#">
			SELECT spkr_client_rowid 
			FROM training
			WHERE meeting_rowid = #arguments.cfcMeetingRowID# 
		</CFQUERY>
		
		<cfset HonoTotal = 0>
		
		<cfif GetRowIDs.recordcount>
			<cfoutput query="GetRowIDs">
				<cfscript>
					honoAmount = this.getHonoraria(cfcRowID="#GetRowIDs.spkr_client_rowid#");
				</cfscript>
				<cfset HonoTotal = #HonoTotal# + #honoAmount#>
			</cfoutput>
		</cfif>
				
		<cfreturn #HonoTotal#>
		
	</cffunction>

</cfcomponent>

