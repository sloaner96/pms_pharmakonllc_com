<!--- 
	*****************************************************************************************
	Name:		
	Function:	
	History:	
	
	*****************************************************************************************
--->

<CFPARAM NAME="URL.client" DEFAULT="">

<HTML>
	<HEAD>
		<TITLE>IT Special Request</TITLE>
		<LINK REL="stylesheet" HREF="piw1style.css" TYPE="text/css">
		<style>
		td{vertical-align:middle;}
		</style>
		<SCRIPT language="JavaScript">
		function  _checkLimitContent(_CF_this)
	{
		if (_CF_this.value.length > 512)
		{
			alert("Please limit your notes to 512 characters. \nEvertything typed following this message will be deleted.");
    		return false;
  		}

    	return true;
	}	
		
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
	<cfoutput>
	
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="qspec_req">
			SELECT *
			FROM special_request 
			WHERE job_number = #form.job_number#
		</cfquery>
	</cfoutput>
	
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="qprojects">
		SELECT client_proj, description, client_code 
		FROM client_proj ORDER BY client_code
	</CFQUERY>
<!-- qspec_req -->


	<BODY MARGINWIDTH="0" MARGINHEIGHT="0" STYLE="MARGIN: 0" BGCOLOR="WHITE">
<!---	<CFLOOP query="qprojects"><cfoutput>
	#client_proj#, #description#, #client_code# </cfoutput><br>
	</CFLOOP> --->
		<br>
		<FORM action="IT_SpecialRequestAdminEditAction.cfm" method="post">
		
		<TABLE BGCOLOR="#000080" ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="600">
		
		<TR>
			<TD CLASS="tdheader">IT Edit Special Request</TD>
		</TR>		
		<TR>
			<TD>
				<!--- Table containing input fields --->
				<TABLE ALIGN="left" BORDER=0 CELLPADDING="0" CELLSPACING="5" WIDTH="600" >						
				<TR>
					<td width=150></td>
					<td width=150></td>
					<td width=150></td>
					<td width=150></td>
				</TR>
				<TR ALIGN="left">
				
					<td width=150 align="right"><b>Requested By:</b></td>
					<td width=150 colspan="3">
					<CFQUERY DATASOURCE="hourday" NAME="srequest">
						select rowid, first_name, last_name, user_login, email, user_Dept 
						from user_id 
						where status = 1  
						AND rowid != 167 
						AND rowid != 178
						AND rowid != 147
						AND rowid != 181
						AND rowid != 175
						AND rowid != 4
						order by user_dept
					</CFQUERY>
				
					<SELECT NAME="requested_by">
						<option name="select" value=0>Select your E-mail Address
						<CFOUTPUT QUERY="srequest">
							
							<OPTION VALUE="#srequest.rowid#" <Cfif #srequest.rowid# EQ #qspec_req.requested_by#>selected</Cfif>>#trim(srequest.first_name)# #trim(srequest.last_name)#
						</CFOUTPUT>
					</SELECT>
					
					<cfoutput>
					</TD>
				</TR>
				<TR ALIGN="left">
					<td align="right"><b>Request Date:</b></td>
					<td colspan="3">
					<input type="text" onClick="CallCal(this)" CLASS="text" value="#dateFormat(qspec_req.request_date, 'mm/dd/yyyy')#" SIZE="10" name="request_date" onKeypress="if (event.keyCode < 47 || event.keyCode > 57) event.returnValue = false;">
					&nbsp;
					<img src="images/formcalendar.gif" style="vertical-align:middle">
					</TD>
				</TR>
				<TR ALIGN="left">
					<td align="right"><b>Request Completion Date:</b></td>
					<td colspan="3">
					<input type="text" onClick="CallCal(this)" CLASS="text" value="#dateFormat(qspec_req.request_comp_date, 'mm/dd/yyyy')#" SIZE="10" name="request_comp_date" onKeypress="if (event.keyCode < 47 || event.keyCode > 57) event.returnValue = false;">
					&nbsp;
					<img src="images/formcalendar.gif" style="vertical-align:middle">
					</TD>
					
				</TR>
				<TR ALIGN="left">
					<td align="right"><b>Client Name:</b>
					<td>
					#qspec_req.client#
					</td>
					<td colspan="2" rowspan="2">
					<a href="javascript:void window.open('IT_SpecialRequestAdminEditCC.cfm?no_menu=1&job_number=#trim(qspec_req.job_number)#&client=#trim(qspec_req.client)#&project_code=#trim(qspec_req.project_code)#','t','width=450,height=300,location=yes,menubar=yes,scrollbars=yes,status=yes,toolbar=yes,resizable=yes');"> 
					Change Client or Project Code (Pop-up)</a>
					</td>
					</tr>
					<tr>
					<td align=right>
					<b>Project Code:</b></td>
					<td>#qspec_req.project_code#
					</td>
				</TR>
				<TR ALIGN="left">
					<td align="right"><b>Billable?:  </b></td>
					<td colspan="3">
										&nbsp; Yes <INPUT TYPE="radio" NAME="billable" <cfif #qspec_req.billable# EQ 1>Checked</cfif> VALUE="1" class="invis">
					&nbsp; No <INPUT TYPE="radio" NAME="billable" <cfif #qspec_req.billable# EQ 0>Checked</cfif> VALUE="0" class="invis">
					</TD>
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
					<textarea cols="75" rows="5" name="description" onkeyup="return _checkLimitContent(this)">#qspec_req.description#</textarea>
					</td>
				</TR>
				<TR ALIGN="left">
					<td colspan=4><hr noshade></td>
				</TR>
				<TR ALIGN="left">
					<td align="left" colspan="4">
					<font size="+1">IT Comments:</font>
					</td>
				</TR>
				<TR ALIGN="left">
					<td align="center" colspan="4">
					<textarea cols="75" rows="5" name="comments" onkeyup="return _checkLimitContent(this)">#qspec_req.comments#</textarea>
					</td>
				</TR>
				<TR ALIGN="left">
					<td colspan=4><hr noshade></td>
				</TR>
				<TR ALIGN="left">
					<td align="left" colspan="4">
					<font size="+1">IT Comments:</font>
					</td>
				</TR>
				<TR ALIGN="left">
					<td style="vertical-align:text-top;"  align="right">
					<B>Cost estimate:</B>
					</td>
					<td align="right" style="margin-right: 1cm">
					hrs <input type="text" CLASS="text" name="cost_EstHours" value="#qspec_req.est_hours#" onKeypress="if (event.keyCode < 46 || event.keyCode > 57) event.returnValue = false;">
					
					<br>
					$ <input type="text" CLASS="text" name="cost_EstDollars" value="#qspec_req.est_dollars#" onKeypress="if (event.keyCode < 46 || event.keyCode > 57) event.returnValue = false;">
					
					</td>
					<td align="right">
					<b>Date Promised:</b>
					</td>
					<td>
					<input type="text" onClick="CallCal(this)" CLASS="text" SIZE="10" name="promised_date" value="#dateFormat(qspec_req.promised_date, 'mm/dd/yyyy')#" onKeypress="if (event.keyCode < 47 || event.keyCode > 57) event.returnValue = false;">
					&nbsp;
					<img src="images/formcalendar.gif" style="vertical-align:middle">
					</td>
					
				</TR>
				<TR ALIGN="left">
					<td style="vertical-align:text-top;"  align="right">
					<B>Actual Cost:</B>
					</td>
					<td align="right" style="margin-right: 1cm">
					hrs <input type="text" CLASS="text" name="cost_ActualHours" value="#qspec_req.actual_hours#" onKeypress="if (event.keyCode < 46 || event.keyCode > 57) event.returnValue = false;">
					
					<br>
					$ <input type="text" CLASS="text" name="cost_ActualDollars" value="#qspec_req.actual_dollars#" onKeypress="if (event.keyCode < 46 || event.keyCode > 57) event.returnValue = false;">
					
					</td>
					<td align="right">
					<b>Date Completed:</b>
					</td>
					<td>
					<input type="text" onClick="CallCal(this)" CLASS="text" SIZE="10" value="#dateFormat(qspec_req.completed_date, 'mm/dd/yyyy')#" name="completed_date" onKeypress="if (event.keyCode < 47 || event.keyCode > 57) event.returnValue = false;">
					&nbsp;
					<img src="images/formcalendar.gif" style="vertical-align:middle">
					</td>
					
				</TR>
				<TR ALIGN="left">
					<td style="vertical-align:text-top;"  align="right">
					<B>Received By:</B>
					</cfoutput>
					</td>
					<td align="right" style="margin-right: 1cm">
					<!--- dropdown --->
					<CFQUERY DATASOURCE="hourday" NAME="srecieved">
						select rowid, first_name, last_name, user_login, email, user_Dept 
						from user_id 
						where user_Dept = 'IT'
						AND status = 1 
						AND rowid !=167  
						AND rowid !=147
						order by user_dept
					</CFQUERY>
				
					<SELECT NAME="recieved_by">
						<option name="select" value=0>Select
						<CFOUTPUT QUERY="srecieved">
							<OPTION VALUE="#srecieved.rowid#" <Cfif #srecieved.rowid# EQ #qspec_req.received_by#>selected</Cfif>>#trim(srecieved.first_name)# #trim(srecieved.last_name)#
						</CFOUTPUT>
					</SELECT>
					</td>
					<cfoutput>
					<td align="right">
					<b>Recieved Date:</b>
					</td>
					<td>
					<input type="text" onClick="CallCal(this)" CLASS="text" SIZE="10" value="#dateFormat(qspec_req.received_date, 'mm/dd/yyyy')#"  name="received_date" onKeypress="if (event.keyCode < 47 || event.keyCode > 57) event.returnValue = false;">
					&nbsp;
					<img src="images/formcalendar.gif" style="vertical-align:middle">
					</td>
					
				</TR>
				
				<TR ALIGN="left">
					<td align="left" colspan="4">
					<font size="+1"><input type="hidden" name="job_number" value="#qspec_req.job_number#">
					Job Number: #qspec_req.job_number#</font>
					</td>
				</TR>
				<TR ALIGN="left">
					<td colspan=4><hr noshade><br></td>
				</TR>
				<!-- form buttons below-->
				<TR>
					<td align="left">
					</td>
					<td>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
							
					<td>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
					<td  align="center">
					<INPUT TYPE="submit" NAME="submit" VALUE=" Submit ">
					</td>
					
				</tr>
				</TABLE>
			</TD>
		</TR>
	
	</TABLE>
	</cfoutput>
	</FORM>
	</BODY>
</HTML>