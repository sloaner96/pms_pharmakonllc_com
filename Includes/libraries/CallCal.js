//-------------------------------------------------------------
//	CallCal.js
//  Pulls up calendar for user to select date
//-------------------------------------------------------------				
function CallCal(InputField)
	{
	var datefield = InputField.value;
	if (datefield.length < 1)
		{
		var sRtn;
		sRtn = showModalDialog("Calendar.cfm?Day=&Month=&Year=&no_menu=1","","center=yes;dialogWidth=180pt;dialogHeight=210pt;resizeable: Yes");
			
		if (sRtn!="")
			InputField.value = sRtn;
		}
	else
		{
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
		if (sRtn!="")
			InputField.value = sRtn;
		}
	}
	
