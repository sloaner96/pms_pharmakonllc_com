<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Load Rosters" showCalendar="0">
	<cfoutput><br>
	    <table border="0" cellpadding="4" cellspacing="0" width="100%">
           <tr>
              <td>Use the form below to manually run the roster loading program. This program is expecting a file to be in the users/DaliyRosters folder on the Mozart server. If the file is not there, the program will not run.</td>
           </tr>
		   <tr>
		     <td><a href="act_LoadRoster.cfm">Click here to run Roster Upload.</a></td>
		   </tr>
        </table>           
	</cfoutput>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
