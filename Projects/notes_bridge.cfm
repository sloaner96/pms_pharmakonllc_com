
<!----------------------------------------------------------------------------
 spkr_edit_bridge.cfm 
 This page closes the  popup pages and refreshes the speaker details page
 ------------------------------------------------------------------------------
 --->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Notes Bridge</title>
<script>
function Openme(newin) {
        notes=window.open(newin,"notes","resizable=yes,scrollbars=auto,menubar=no,status=no,width=500,height=300,top=50,left=50")
	   //self.close(); 
	}
</script>
</head>
<cfoutput>
<cfif IsDefined("form.select_project")>
	<body onload="Openme('NotesList.cfm?no_menu=1&project_code=#form.select_project#&client_code=#form.select_client#')">	
<cfelse>	
	<body onload="Openme('NotesList.cfm?no_menu=1&project_code=#session.project_code#&client_code=#session.client_code#')">
</cfif>
</body>
</cfoutput>
<CFOUTPUT><META HTTP-EQUIV="REFRESH" CONTENT="0; URL=NotesSelect.cfm"></CFOUTPUT>
</html>
