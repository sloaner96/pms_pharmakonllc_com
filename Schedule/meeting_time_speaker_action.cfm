<!-------------------------------------
meeting_time_speaker_action.cfm

Sets the speaker to unavailable, inserts record into additional_speakers table in PMSProd

12/13/02 - Matt Eaves - Initial Code

--------------------------------------------->

		
<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetSpkrOwnerID">
	SELECT owner_id 
	FROM speaker_clients
	WHERE rowid = #form.SpkrAdditionalAdd#
</CFQUERY>
<cfset SpeakerID = #GetSpkrOwnerID.owner_id#>


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
	WHERE (month = #form.txtMonth# AND year = #form.txtYear# AND day = #form.txtDay#) AND owner_id = #SpeakerID#
</CFQUERY>

<CFQUERY DATASOURCE="#application.projdsn#" NAME="GetMeetingDateID">			
	SELECT meeting_date_id, meeting_date, use_type
	FROM schedule_meeting_time 
	WHERE rowid = #form.UniqueID#
</CFQUERY>



<!----Insert record ----->
<CFQUERY DATASOURCE="#application.projdsn#" NAME="insertaddspkr">			
					INSERT INTO schedule_meeting_time(meeting_date_id, meeting_code, project_code, moderator_id, speaker_id, staff_id, staff_type, year, month, day, start_time, end_time, meeting_date, mod_client_rowid, client_rowid, use_type)
					VALUES(#GetMeetingDateID.meeting_date_id#, '#trim(form.meeting_code)#', '#session.project_code#', #form.ModerId#, #SpeakerID#, #SpeakerID#, 5,  #form.txtyear#, #form.txtmonth#, #form.txtday#, #form.MilitaryTimeBegin#, #form.MilitaryTimeEnd#, #CreateODBCDate(GetMeetingDateID.meeting_date)#, #form.intModRow#, #form.SpkrAdditionalAdd#, #GetMeetingDateID.use_type#)
				</CFQUERY>
<!--- <cfoutput>
#GetMeetingDateID.meeting_date_id#, '#form.meeting_code#', '#session.project_code#', #form.ModerId#, #form.SpkrId#, #SpeakerID#, 5,  #form.txtyear#, #form.txtmonth#, #form.txtday#, '#form.MilitaryTimeBegin#', '#form.MilitaryTimeEnd#', #GetMeetingDateID.meeting_date#, #form.intModRow#, #form.SpkrAdditionalAdd#
</cfoutput> --->

<cfoutput>
	<cflocation url="meeting_time_speaker_popup.cfm?no_menu=1&year=#form.txtYear#&month=#form.txtMonth#&day=#form.txtDay#&time=#RegTime#&modID=#ModerID#&spkrID=#form.SpkrID#&uniqueID=#UniqueID#&modRowID=#form.intModRow#&spkrRowID=#form.intSpkrRow#&beginM=#MilitaryTimeBegin#&EndM=#MilitaryTimeEnd#&meeting_code=#meeting_code#" addtoken="no">
</cfoutput>