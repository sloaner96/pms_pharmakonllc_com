<!----------------------------------------
meeting_time_delete.cfm

Deletes meeting time out of schedule_meeting_time based on row_id,
It also moves the moderator and speaker back to available for that time

-------------------------------------------------->

<cfscript>
	oDelete = createObject("component","pms.com.cfc_delete_update_meeting");
	oDelete.MakeAvailable(meeting_code="#form.meeting_code#",UserID="#session.userinfo.rowid#");
	oDelete.MakeAdditionSpkrAvailable(Row_ID="#form.UniqueID#",UserID="#session.userinfo.rowid#");
	oDelete.MakeListenInsAvailable(Row_ID="#form.UniqueID#",UserID="#session.userinfo.rowid#");
	oDelete.MakeTraineesAvailable(Row_ID="#form.UniqueID#",UserID="#session.userinfo.rowid#");
	DeleteMeeting = oDelete.RemoveMeeting("#form.meeting_code#");
</cfscript>


<!--- runs function to edit number of meetings in meeting summary table --->
<cfinvoke
	component="pms.com.cfc_meeting_summary"
	method="updateSummary"
	action="delete"
	project_code="#session.project_code#"
	meeting_date="#form.meetingdate#"
	meeting_year="#form._year#"
>

<cflocation url="meeting_time_add.cfm?no_menu=1&month=#form._month#&year=#form._year#&day=#form._day#" addtoken="no">



