<!----------------------------
cfc_delete_update_meeting.cfc

Sets speaker and moderater to avaialbe then deletes or updates meeting depending on caller.
meeting_time_delete.cfm & meeting_time_edit_popup.cfm use this component.

10/14/02 - Matt Eaves - Intial Code
1/27/02 - Matt Eaves - Added function to handle training table.

----------------------------------------->

<cfcomponent>
	<cffunction name="MakeAvailable" hint="Sets Moderator and Speaker to Available" access="public" output="false">
		<cfargument name="Meeting_Code" hint="The unique meeting code of the meeting" type="string" required="true"/>
		<cfargument name="UserID" hint="User doing the update" type="numeric" required="true"/>
			
		<!---Pull out meeting details for meeting that needs deleting---->
		<CFQUERY DATASOURCE="#session.dbs#" NAME="getMeeting" USERNAME="#session.dbu#" PASSWORD="#session.dbp#">
			SELECT day, start_time, end_time, staff_id, day, month, year
			FROM schedule_meeting_time
			WHERE meeting_code = '#arguments.Meeting_Code#'
		</CFQUERY>
		
		<cfset today = #createodbcdate(Now())#>
		<!---Set up Array to store mod and speaker ID---->
		<!--- <cfset UpdateArray = ArrayNew(1)> --->
		<!--- <cfset a = 1>
		<cfloop query="getMeeting">
		<cfset UpdateArray[a] = #getMeeting.staff_id#>
		<cfset a = a + 1>
		</cfloop> --->		
		
		<!----Perform Update for as many staff found.------>
		<cfloop query="getMeeting">
		<!--- <cfloop from="1" to="#getMeeting.recordcount#" index="x" step="1"> --->
			<cfset xcolumn = #getMeeting.start_time#><!---Set this here so it resets on each loop--->
			<CFQUERY DATASOURCE="#session.spkrdbs#" NAME="UpdateModSpkr" USERNAME="#session.spkrdbu#" PASSWORD="#session.spkrdbp#">
			UPDATE availability_time
				SET <CFLOOP CONDITION="xcolumn LTE getMeeting.end_time">x#xcolumn# = 1, 
						<cfset xcolumn = xcolumn + 50>
							<cfif #Len(xcolumn)# EQ 3>
								<cfset xcolumn = '0#xcolumn#'>
							<cfelseif #Len(xcolumn)# EQ 2>
								<cfset xcolumn = '00#xcolumn#'>
							</cfif>
					</cfloop>updated = #today#, updated_userid = #arguments.UserID#
				WHERE (month = #getMeeting.month# AND year = #getMeeting.year# AND day = #getMeeting.day#) AND owner_id = #getMeeting.staff_id#
				
			</CFQUERY>
			
		</cfloop>
		
	</cffunction>

<!---New Function---->	
	<cffunction name="RemoveMeeting" hint="Deletes the Meeting" access="public" output="false">
		<cfargument name="meeting_code" hint="The Meeting Code of the meeting" type="string" required="true"/>
			
		<!---Delete the Meeting------>
		<CFQUERY DATASOURCE="#session.dbs#" NAME="DeleteMeeting" USERNAME="#session.dbu#" PASSWORD="#session.dbp#">
			DELETE FROM schedule_meeting_time WHERE meeting_code = '#arguments.meeting_code#'
		</CFQUERY>	
		
	</cffunction>
	
<!---New Function---->
	<cffunction name="UpdateMeeting" hint="Updates the Meeting" access="public" output="false">
		<cfargument name="Row_ID" hint="The Row ID of the meeting" type="numeric" required="true"/>
		<cfargument name="Staff_ID" hint="The Staff ID" type="numeric" required="true"/>
		<cfargument name="staff_rowid" hint="The Staff Client Rowid" type="numeric" required="true"/>
		
		<!---Update the Meeting Moderator------>
		<CFQUERY DATASOURCE="#session.dbs#" NAME="UpdateMeetingMod" USERNAME="#session.dbu#" PASSWORD="#session.dbp#">
			UPDATE schedule_meeting_time 
			SET staff_id = #arguments.Staff_ID#, client_rowid = #arguments.staff_rowid#
			WHERE rowid = #arguments.Row_ID#
		</CFQUERY>	
		
	</cffunction>
	
	<cffunction name="UpdateUseType" hint="Updates the Meeting" access="public" output="false">
		<cfargument name="meeting_code" hint="The Row ID of the meeting" type="string" required="true"/>
		<cfargument name="meeting_use" hint="Real Meeting or training" type="numeric" required="true"/>
		
		<!---Update the Meeting Use Code------>
		<CFQUERY DATASOURCE="#session.dbs#" NAME="UpdateMeetingUse" USERNAME="#session.dbu#" PASSWORD="#session.dbp#">
			UPDATE schedule_meeting_time 
			SET use_type = #arguments.meeting_use#
			WHERE meeting_code = '#arguments.meeting_code#'
		</CFQUERY>	
		
	</cffunction>

<!----New Function------>
	<cffunction name="MakeAdditionSpkrAvailable" hint="Makes Additional Speakers Available and Deletes them from Appropriate Table" access="public" output="false">
		<cfargument name="Row_ID" hint="The Row ID of the meeting" type="numeric" required="true"/>
		<cfargument name="UserID" hint="User doing the update" type="numeric" required="true"/>
			
		<!---Pull out meeting details for meeting that needs deleting---->
		<CFQUERY DATASOURCE="#session.dbs#" NAME="getMeeting" USERNAME="#session.dbu#" PASSWORD="#session.dbp#">
			SELECT day, start_time, end_time, day, month, year
			FROM schedule_meeting_time
			WHERE rowid = #arguments.Row_ID#
		</CFQUERY>
		
		<cfset today = #createodbcdate(Now())#>
				
		<CFQUERY DATASOURCE="#session.dbs#" NAME="getAdditionalSpkrs" USERNAME="#session.dbu#" PASSWORD="#session.dbp#">
			SELECT spkrid, row_id
			FROM additional_speakers
			WHERE meeting_rowid = #arguments.Row_ID#
		</CFQUERY>
		
		<cfif getAdditionalSpkrs.recordcount>
			<cfoutput query="getAdditionalSpkrs">
	
				<cfset xcolumn = #getMeeting.start_time#><!---Set this here so it resets on each loop--->
				<CFQUERY DATASOURCE="#session.spkrdbs#" NAME="UpdateSpkr" USERNAME="#session.spkrdbu#" PASSWORD="#session.spkrdbp#">
				UPDATE availability_time
					SET <CFLOOP CONDITION="xcolumn LTE getMeeting.end_time">x#xcolumn# = 1, 
							<cfset xcolumn = xcolumn + 50>
								<cfif #Len(xcolumn)# EQ 3>
									<cfset xcolumn = '0#xcolumn#'>
								<cfelseif #Len(xcolumn)# EQ 2>
									<cfset xcolumn = '00#xcolumn#'>
								</cfif>
						</cfloop>updated = #today#, updated_userid = #arguments.UserID#
					WHERE (month = #getMeeting.month# AND year = #getMeeting.year# AND day = #getMeeting.day#) AND owner_id = #getAdditionalSpkrs.spkrid#
				</CFQUERY>
			
				<!---Delete the additional speaker from the table--->
				<CFQUERY DATASOURCE="#session.dbs#" NAME="DeleteAdditionals" USERNAME="#session.dbu#" PASSWORD="#session.dbp#">
					DELETE FROM additional_speakers WHERE row_id = #getAdditionalSpkrs.row_id#
				</CFQUERY>
			
			</cfoutput>	
		</cfif>
		
	</cffunction>
	
	

<!----New Function------>
	<cffunction name="MakeListenInsAvailable" hint="Makes Listen-Ins Available and Deletes them from Appropriate Table" access="public" output="false">
		<cfargument name="Row_ID" hint="The Row ID of the meeting" type="numeric" required="true"/>
		<cfargument name="UserID" hint="User doing the update" type="numeric" required="true"/>
			
		<!---Pull out meeting details for meeting that needs deleting---->
		<CFQUERY DATASOURCE="#session.dbs#" NAME="getMeeting" USERNAME="#session.dbu#" PASSWORD="#session.dbp#">
			SELECT day, start_time, end_time, day, month, year
			FROM schedule_meeting_time
			WHERE rowid = #arguments.Row_ID#
		</CFQUERY>
		
		<cfset today = #createodbcdate(Now())#>
				
		<CFQUERY DATASOURCE="#session.dbs#" NAME="getListens" USERNAME="#session.dbu#" PASSWORD="#session.dbp#">
			SELECT row_id, modspkrid
			FROM listen_ins
			WHERE meeting_rowid = #arguments.Row_ID#
		</CFQUERY>
		
		<cfif getListens.recordcount>
			<cfoutput query="getListens">
	
				<cfset xcolumn = #getMeeting.start_time#><!---Set this here so it resets on each loop--->
				<CFQUERY DATASOURCE="#session.spkrdbs#" NAME="UpdateModSpkr" USERNAME="#session.spkrdbu#" PASSWORD="#session.spkrdbp#">
				UPDATE availability_time
					SET <CFLOOP CONDITION="xcolumn LTE getMeeting.end_time">x#xcolumn# = 1, 
							<cfset xcolumn = xcolumn + 50>
								<cfif #Len(xcolumn)# EQ 3>
									<cfset xcolumn = '0#xcolumn#'>
								<cfelseif #Len(xcolumn)# EQ 2>
									<cfset xcolumn = '00#xcolumn#'>
								</cfif>
						</cfloop>updated = #today#, updated_userid = #arguments.UserID#
					WHERE (month = #getMeeting.month# AND year = #getMeeting.year# AND day = #getMeeting.day#) AND owner_id = #getListens.modspkrid#
				</CFQUERY>
			
				<!---Delete Listen-Ins from table---->
				<CFQUERY DATASOURCE="#session.dbs#" NAME="DeleteListens" USERNAME="#session.dbu#" PASSWORD="#session.dbp#">
					DELETE FROM listen_ins WHERE row_id = #getListens.row_id#
				</CFQUERY>
			
			</cfoutput>	
		</cfif>
		
	</cffunction>


<!----New Function------>
	<cffunction name="MakeTraineesAvailable" hint="Makes Trainees Available and Deletes them from Appropriate Table" access="public" output="false">
		<cfargument name="Row_ID" hint="The Row ID of the meeting" type="numeric" required="true"/>
		<cfargument name="UserID" hint="User doing the update" type="numeric" required="true"/>
			
		<!---Pull out meeting details for meeting that needs deleting---->
		<CFQUERY DATASOURCE="#session.dbs#" NAME="getMeeting" USERNAME="#session.dbu#" PASSWORD="#session.dbp#">
			SELECT day, start_time, end_time, day, month, year
			FROM schedule_meeting_time
			WHERE rowid = #arguments.Row_ID#
		</CFQUERY>
		
		<cfset today = #createodbcdate(Now())#>
				
		<CFQUERY DATASOURCE="#session.dbs#" NAME="getTrainees" USERNAME="#session.dbu#" PASSWORD="#session.dbp#">
			SELECT row_id, modspkrid
			FROM training
			WHERE meeting_rowid = #arguments.Row_ID#
		</CFQUERY>
		
		<cfif getTrainees.recordcount>
			<cfoutput query="getTrainees">
	
				<cfset xcolumn = #getMeeting.start_time#><!---Set this here so it resets on each loop--->
				<CFQUERY DATASOURCE="#session.spkrdbs#" NAME="UpdateModSpkr" USERNAME="#session.spkrdbu#" PASSWORD="#session.spkrdbp#">
				UPDATE availability_time
					SET <CFLOOP CONDITION="xcolumn LTE getMeeting.end_time">x#xcolumn# = 1, 
							<cfset xcolumn = xcolumn + 50>
								<cfif #Len(xcolumn)# EQ 3>
									<cfset xcolumn = '0#xcolumn#'>
								<cfelseif #Len(xcolumn)# EQ 2>
									<cfset xcolumn = '00#xcolumn#'>
								</cfif>
						</cfloop>updated = #today#, updated_userid = #arguments.UserID#
					WHERE (month = #getMeeting.month# AND year = #getMeeting.year# AND day = #getMeeting.day#) AND owner_id = #getTrainees.modspkrid#
				</CFQUERY>
			
				<!---Delete Listen-Ins from table---->
				<CFQUERY DATASOURCE="#session.dbs#" NAME="DeleteTrainees" USERNAME="#session.dbu#" PASSWORD="#session.dbp#">
					DELETE FROM training WHERE row_id = #getTrainees.row_id#
				</CFQUERY>
			
			</cfoutput>	
		</cfif>
		
	</cffunction>
</cfcomponent>

