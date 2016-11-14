<!-------------------------------------
meeting_time_training_action.cfm

Sets the mod or speaker to unavailable, inserts record into listen_in table in PMSProd

01/27/02 - Matt Eaves - Initial Code
--------------------------------------------->

<!----Check to make sure we have a mod or spkr id to talk to before
we start updating tables.  Set variable to avoid an duplicate code below.
This way one update can hanlde both the moderator and speaker updates----->
<cfif isDefined("URL.type")>
	<cfif #URL.type# EQ "mod">
		<cfset ModSpkrRowID = #form.ModListenAdd#>
		
		<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetModOwnerID">
			SELECT owner_id 
			FROM speaker_clients
			WHERE rowid = #form.ModListenAdd#
		</CFQUERY>
		<cfset ModSpkrID = #GetModOwnerID.owner_id#>
		<cfset typeof = 4><!---Moderators are identified by 1 in the database---->
	
	<cfelseif #URL.type# EQ "spkr">
		<cfset ModSpkrRowID = #form.SpkrListenAdd#>
		
		<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetSpkrOwnerID">
			SELECT owner_id 
			FROM speaker_clients
			WHERE rowid = #form.SpkrListenAdd#
		</CFQUERY>
		<cfset ModSpkrID = #GetSpkrOwnerID.owner_id#>
		<cfset typeof = 7><!---Speakers are identified by 4 in the database---->
	</cfif>
<cfelse>
	<cfoutput>An error has occured.  Please go back.</cfoutput>
	<cfabort>
</cfif>

<cfset today = #createodbcdate(Now())#>

<!--- set the times to unavailable --->
<cfset xcolumn = #form.MilitaryTimeBegin#>
<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="update_newtimes">
	UPDATE availability_time
	SET <CFLOOP CONDITION="xcolumn LTE form.MilitaryTimeEnd">x#xcolumn# = 0, 
		<cfset xcolumn = xcolumn + 50>
			<cfif #Len(xcolumn)# EQ 3>
				<cfset xcolumn = '0#xcolumn#'>
			<cfelseif #Len(xcolumn)# EQ 2>
				<cfset xcolumn = '00#xcolumn#'>
			</cfif>
		</cfloop>updated = #today#, updated_userid = #session.userinfo.rowid#, allday = 2
	WHERE (month = #form.txtMonth# AND year = #form.txtYear# AND day = #form.txtDay#) AND owner_id = #ModSpkrID#
</CFQUERY>

<CFQUERY DATASOURCE="#application.projdsn#" NAME="GetMeetingDateID">			
	SELECT meeting_date_id, meeting_date, use_type
	FROM schedule_meeting_time 
	WHERE rowid = #form.UniqueID#
</CFQUERY>
<cfset MeetingDate = #createodbcdate(GetMeetingDateID.meeting_date)#>

<!----Insert record into listen_in table----->
<!--- <CFQUERY DATASOURCE="#application.projdsn#" NAME="UpdateTraining">			
	INSERT INTO training(meeting_date_id, meeting_rowid, modspkrid, spkr_client_rowid, type, add_meeting_date, updated, updated_userid) 
	VALUES(#GetMeetingDateID.meeting_date_id#, #form.UniqueID#, #ModSpkrID#, #ModSpkrRowID#, #typeof#, #MeetingDate#, #today#, #session.userinfo.rowid#)
</CFQUERY> --->

<CFQUERY DATASOURCE="#application.projdsn#" NAME="InsertTraining">			
					INSERT INTO schedule_meeting_time(meeting_date_id, meeting_code, project_code, moderator_id, speaker_id, staff_id, staff_type, year, month, day, start_time, end_time, meeting_date, mod_client_rowid, client_rowid, use_type)
					VALUES(#GetMeetingDateID.meeting_date_id#, '#form.meeting_code#', '#session.project_code#', #form.ModerId#, #ModSpkrID#, #ModSpkrID#, #typeof#,  #form.txtyear#, #form.txtmonth#, #form.txtday#, #form.MilitaryTimeBegin#, #form.MilitaryTimeEnd#, #CreateODBCDate(GetMeetingDateID.meeting_date)#, #form.intModRow#, #ModSpkrRowID#, #GetMeetingDateID.use_type#)
				</CFQUERY>

<cfoutput>
	<cflocation url="meeting_time_training_popup.cfm?no_menu=1&year=#form.txtYear#&month=#form.txtMonth#&day=#form.txtDay#&time=#RegTime#&modID=#ModerID#&spkrID=#SpkerID#&uniqueID=#UniqueID#&modRowID=#form.intModRow#&spkrRowID=#form.intSpkrRow#&beginM=#MilitaryTimeBegin#&EndM=#MilitaryTimeEnd#&meeting_code=#meeting_code#" addtoken="no">
</cfoutput>