<!----------
meeting_time_listen_delete.cfm

Sets listen in persons time back to available and deletes the record from listen_in table
-------------->


<cfset today = #createodbcdate(Now())#>

<!--- set the times to unavailable --->
<cfset xcolumn = #form.MilitaryTimeBegin#>
<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="update_newtimes">
	UPDATE availability_time
	SET <CFLOOP CONDITION="xcolumn LTE form.MilitaryTimeEnd">x#xcolumn# = 1, 
		<cfset xcolumn = xcolumn + 50>
			<cfif #Len(xcolumn)# EQ 3>
				<cfset xcolumn = '0#xcolumn#'>
			<cfelseif #Len(xcolumn)# EQ 2>
				<cfset xcolumn = '00#xcolumn#'>
			</cfif>
		</cfloop>updated = #today#, updated_userid = #session.userinfo.rowid#, allday = 2
	WHERE (month = #form.txtMonth# AND year = #form.txtYear# AND day = #form.txtDay#) AND owner_id = #form.deleteID#
</CFQUERY>

<!----Insert record into listen_in table----->
<CFQUERY DATASOURCE="#application.projdsn#" NAME="UpdateListens">			
	DELETE FROM schedule_meeting_time WHERE rowid = #form.listeninUnique#
</CFQUERY>

<cfoutput>
	<cflocation url="meeting_time_listen_popup.cfm?no_menu=1&year=#form.txtYear#&month=#form.txtMonth#&day=#form.txtDay#&time=#RegTime#&modID=#ModerID#&spkrID=#SpkerID#&uniqueID=#UniqueID#&modRowID=#form.intModRow#&spkrRowID=#form.intSpkrRow#&beginM=#MilitaryTimeBegin#&EndM=#MilitaryTimeEnd#&meeting_code=#form.meeting_code#" addtoken="no">
</cfoutput>
