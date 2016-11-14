<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Conference Company Rosters" showCalendar="0">
<SCRIPT SRC="/includes/libraries/PIW1checker.js"></SCRIPT>
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

<table align="center" cellpadding="4" cellspacing="0" border="0">
<cfoutput>
<FORM NAME="conf_dates" ACTION="" METHOD="post">
</cfoutput>
<tr>
	<td>Please select the beginning and ending dates for the conference company rosters, then click the <i> Start </i> button to begin processing.</td>
</tr>
<tr height=20>
  <td>&nbsp;</td>
</tr>
<TR>
	<td align="center"><B>Begin Date:</B>&nbsp;&nbsp;&nbsp;&nbsp;
	<cfmodule template="#Application.tagpath#/ctags/calInput.cfm"
	          inputname="begin_date"
			  htmlID="begindate"
			  FormValue="#DateFormat(now(), 'mm/dd/yyyy')#"
			  imgid="begindatebtn">
	 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<B>End Date:</B>&nbsp;&nbsp;&nbsp;&nbsp;
	<cfmodule template="#Application.tagpath#/ctags/calInput.cfm"
	          inputname="end_date"
			  htmlID="enddate"
			  FormValue="#DateFormat(now(), 'mm/dd/yyyy')#"
			  imgid="enddatebtn"></TD> 
</tr>
<tr height=20>
    <td>&nbsp;</td>
</tr>
<cfoutput>
<tr>
	<TD ALIGN="center"><input TYPE="Button" NAME="run" VALUE=" Start " onClick="conf_dates.action = 'roster_conf_roster2.cfm?a=1&#Rand()#'; conf_dates.submit(); "></TD>
</tr>
</cfoutput>
</form>
</table>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

