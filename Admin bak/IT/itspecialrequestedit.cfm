<!--- 
	*****************************************************************************************
	Name:		
	Function:	
	History:	
	
	*****************************************************************************************
--->
<HTML>
	<HEAD>
		<TITLE>IT Special Request</TITLE>
		<LINK REL="stylesheet" HREF="piw1style.css" TYPE="text/css">
		<style>
		td{vertical-align:middle;}
		</style>
		<SCRIPT language="JavaScript">
		// Pulls up calendar for user to select date
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
		</script>
	</HEAD>

<!-- qspec_req -->

<BODY MARGINWIDTH="0" MARGINHEIGHT="0" STYLE="MARGIN: 0" BGCOLOR="WHITE">
		<br><Br>
		<TABLE BGCOLOR="#000080" ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="600">
		<TR>
			<TD CLASS="tdheader">IT Special Request</TD>
		</TR>		
		<TR>
			<TD>
				<!--- Table containing input fields --->
				<TABLE ALIGN="left" BORDER=0 CELLPADDING="0" CELLSPACING="5" WIDTH="600" >						
				<TR ALIGN="left">
					<td width=150 align="right"><b>Requested By:</b></td>
					<td width=150 colspan="3"><input type="text" name="" value=""></TD>
				</TR>
				<TR ALIGN="left">
					<td align="right"><b>Request Date:</b></td>
					<td colspan="3">
					<input type="text" onClick="CallCal(this)" CLASS="text"  SIZE="10" name="request_date" value="#dateFormat(qspec_req.request_date, 'mm/dd/yyyy')#" onKeypress="if (event.keyCode < 47 || event.keyCode > 57) event.returnValue = false;">
					&nbsp;
					<img src="images/formcalendar.gif" style="vertical-align:middle">
					</TD>
				</TR>
				<TR ALIGN="left">
					<td align="right"><b>Request Completion Date:</b></td>
					<td colspan="3">
					<input type="text" onClick="CallCal(this)" CLASS="text"  SIZE="10" name="request_comp_date" value="#dateFormat(qspec_req.request_comp_date, 'mm/dd/yyyy')#" onKeypress="if (event.keyCode < 47 || event.keyCode > 57) event.returnValue = false;">
					&nbsp;
					<img src="images/formcalendar.gif" style="vertical-align:middle">
					</TD>
					
				</TR>
				<TR ALIGN="left">
					<td align="right"><b>Client Name:</b></td>
					<td colspan="3"><input type="text" name="" value=""></TD>
				</TR>
				<TR ALIGN="left">
					<td align="right"><b>Project Code:</b></td>
					<td colspan="3"><input type="text" name="" value=""></TD>
				</TR>
				<TR ALIGN="left">
					<td align="right"><b>Billable?:</b></td>
					<td colspan="3"><input type="text" name="" value=""></TD>
				</TR>
				<TR ALIGN="left">
					<td colspan=4><hr noshade></td>
				</TR>
				<TR ALIGN="left">
					<td align="left" colspan="4">
					<font size="+1">Description of Request:</font>
					<br> 
					<font size="-1">(Please be as detailed as possible)</font>
					</td>
				</TR>
				<TR ALIGN="left">
					<td align="center" colspan="4">
					<textarea cols="75" rows="5"></textarea>
					</td>
				</TR>
				<TR ALIGN="left">
					<td align="left" colspan="4">
					<font size="+1">IT Comments:</font>
					</td>
				</TR>
				<TR ALIGN="left">
					<td align="center" colspan="4">
					<textarea cols="75" rows="5"></textarea>
					</td>
				</TR>
				<TR ALIGN="left">
					<td colspan=4><hr noshade></td>
				</TR>
				<TR ALIGN="left">
					<td align="right"><b>Cost Estimate (hrs/$):</b></td>
					<td ALIGN="left">hrs: <input type="text" size="5"> <br>&nbsp;&nbsp;&nbsp;$: <input type="text" size="5"></TD>
					<td align="right"><b>Date Promised:</b></td>
					<td><input type="text" onClick="CallCal(this)" CLASS="text"  SIZE="10" name="promised_date" value="#dateFormat(qspec_req.promised_date, 'mm/dd/yyyy')#" onKeypress="if (event.keyCode < 47 || event.keyCode > 57) event.returnValue = false;">
					&nbsp;
					<img src="images/formcalendar.gif" style="vertical-align:middle">
					</TD>
				</TR>
				<TR ALIGN="left">
					<td align="right"><b>Actual Cost (hrs/$):</b></td>
					<td ALIGN="left">hrs: <input type="text" size="5"> <br>&nbsp;&nbsp;&nbsp;$: <input type="text" size="5"></TD>
					<td align="right"><b>Date Completed:</b></td>
					<td><input type="text" onClick="CallCal(this)" CLASS="text"  SIZE="10" name="completed_date" value="#dateFormat(qspec_req.completed_date, 'mm/dd/yyyy')#" onKeypress="if (event.keyCode < 47 || event.keyCode > 57) event.returnValue = false;">
					&nbsp;
					<img src="images/formcalendar.gif" style="vertical-align:middle">
					</TD>
				</TR>
				<TR ALIGN="left">
					<td align="right"><b>Received By:</b></td>
					<td ALIGN="left"><input type="text"></TD>
					<td align="right"><b>Received Date:</b></td>
					<td><input type="text" onClick="CallCal(this)" CLASS="text"  SIZE="10" name="received_date" value="#dateFormat(qspec_req.received_date, 'mm/dd/yyyy')#" onKeypress="if (event.keyCode < 47 || event.keyCode > 57) event.returnValue = false;">
					&nbsp;
					<img src="images/formcalendar.gif" style="vertical-align:middle">
					</TD>
				</TR>
				<TR ALIGN="left">
					<td align="right"><b>Job Number:</b></td>
					<td colspan="3"><input type="text" name="" value=""></TD>
				</TR>
				<!-- form buttons below-->
				<TR>
					<td colspan="2" align="left">
					</td>		
					<td colspan="2" align="right">
					</td>
				</tr>
				</TABLE>
			</TD>
		</TR>
	
	</TABLE>
	</BODY>
</HTML>