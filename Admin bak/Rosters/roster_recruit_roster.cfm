<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Recruiter Attendance Rosters" showCalendar="0">

	<cfoutput>
	<SCRIPT>
	// Pulls up calendar for user to select date
	function CallCal(InputField) {
		var datefield = InputField.value;
		if (datefield.length < 1) {
			var sRtn;						
			sRtn = showModalDialog("Calendar.cfm?Day=&Month=&Year=&no_menu=1","","center=yes;dialogWidth=180pt;dialogHeight=210pt;resizeable: Yes");
			if (sRtn!="")
			InputField.value = sRtn;
		}
		else {
			// Find the first forward slash in the date string
			var index = datefield.indexOf("/", 0);
						
			// Grab all the numbers before the first forward slash
			var month = datefield.substr(0, index);
						
			// Find the second forward slash
			var index2 = (datefield.indexOf("/", index+1) - 1)
						
			// Get the numbers after the first forward slash but before the second one
			var day = datefield.substr((index+1), (index2 - index));
					
			// Find the last forward slash
			var index = datefield.lastIndexOf("/");
						
			// Get the numbers after the third (i.e. last) forward slash
			var year = datefield.substr((index+1), (datefield.length-1));
				
			// Call the calendar.cfm file passing the values previously obtained
			var sRtn;
			sRtn = showModalDialog("Calendar.cfm?Day=" + day + "&Month=" + month + "&Year=" + year + "&no_menu=1","","center=yes;dialogWidth=180pt;dialogHeight=210pt;resizeable: Yes");
				
			// Return the selected date to the input field
			if (sRtn!="") InputField.value = sRtn;
		}
	}
		
</script>
</cfoutput>
<!--- Pull recruiter info for dropdown box --->
<CFQUERY DATASOURCE="#application.projdsn#" NAME="q1">
	select recruiter_name from recruiter
</CFQUERY>

<table>
<cfoutput>
<FORM NAME="recruit_dates" ACTION="" METHOD="post">
</cfoutput>
<tr>
	<td width=50>&nbsp;</td>
	<td colspan=3>Please select the beginning and ending dates for the recruiter attendance roster, select the recruiter, then click the <i> Run Report </i> button to begin processing.</td>
</tr>
<tr height=20><td colspan=3>&nbsp;</td></tr>
<tr>
  <td colspan="3" align="center"><B>Begin Date:</B>&nbsp;&nbsp;&nbsp;&nbsp;
	<cfmodule template="#Application.tagpath#/ctags/calInput.cfm"
	          inputname="begin_date"
			  htmlID="begindate"
			  FormValue="#DateFormat(dateadd('d', -1, now()), 'mm/dd/yyyy')#"
			  imgid="begindatebtn">
	 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<B>End Date:</B>&nbsp;&nbsp;&nbsp;&nbsp;
	<cfmodule template="#Application.tagpath#/ctags/calInput.cfm"
	          inputname="end_date"
			  htmlID="enddate"
			  FormValue="#DateFormat(dateadd('d', -1, now()), 'mm/dd/yyyy')#"
			  imgid="enddatebtn"></td>
</tr>
<TR>
	<td width=50></td>
	<!--- Beginning date --->
	<TD align=right><B>Recruiter:</font></B>&nbsp;</td>
	<td>
		<select name=recruiter>
			<cfoutput query="q1">
			<option value="#trim(q1.recruiter_name)#">#trim(q1.recruiter_name)#</option>		
			</cfoutput>
		</select>
</tr>
<tr height=20><td colspan=3>&nbsp;</td></tr>
<tr>
	<td width=50>&nbsp;</td>
	<TD ALIGN="right"><input TYPE="Button"  NAME="runreport" VALUE=" Run Report " onClick="recruit_dates.action = 'roster_recruit_roster2.cfm?a=1&#Rand()#'; recruit_dates.submit(); "></TD>
	<td>&nbsp;</td>
</tr>
</form>
</table>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

