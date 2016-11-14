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
						where rowid = '#qspec_req.requested_by#'
					</CFQUERY>
				
					<cfoutput>
					#trim(srequest.first_name)# #trim(srequest.last_name)#
					</TD>
				</TR>
				<TR ALIGN="left">
					<td align="right"><b>Request Date:</b></td>
					<td colspan="3">
				#dateFormat(qspec_req.request_date, 'mm/dd/yyyy')#
					&nbsp;
					</TD>
				</TR>
				<TR ALIGN="left">
					<td align="right"><b>Request Completion Date:</b></td>
					<td colspan="3">
					#dateFormat(qspec_req.request_comp_date, 'mm/dd/yyyy')#
					&nbsp;
					</TD>
					
				</TR>
				<TR ALIGN="left">
					<td align="right"><b>Client Name:</b>
					<td>
					#qspec_req.client#
					</td>
					<td colspan="2" rowspan="2">
					
					</td>
					</tr>
					<tr>
					<td align=right>
					<b>Project Code:</b></td>
					<td>#qspec_req.project_code#
					</td>
				</TR>
				<TR ALIGN="left">
					<td align="right"><b>Billable?:</b></td>
					<td colspan="3">
					&nbsp;  <cfif #qspec_req.billable# EQ 1>Yes<cfelse>No</cfif>
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
					<textarea cols="80" rows="7" name="description" DISABLED ONFOCUS="if (!document.all && !document.getElementById) this.blur()">#qspec_req.description#</textarea>
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
					<textarea cols="80" rows="7" name="comments" DISABLED ONFOCUS="if (!document.all && !document.getElementById) this.blur()">#qspec_req.comments#</textarea>
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
					<B>Cost estimate</B>
					</td>
					<td align="left" style="margin-right: 1cm">
					hrs: #qspec_req.est_hours#
					
					/ 
					$: #qspec_req.est_dollars#
					
					</td>
					<td align="right">
					<b>Date Promised:</b>
					</td>
					<td>
					#dateFormat(qspec_req.promised_date, 'mm/dd/yyyy')#
					&nbsp;
					
					</td>
					
				</TR>
				<TR ALIGN="left">
					<td style="vertical-align:text-top;"  align="right">
					<B>Actual Cost</B>
					</td>
					<td align="left" style="margin-right: 1cm">
					hrs: #qspec_req.actual_hours#		
					/ 
					$: #qspec_req.actual_dollars#
					
					</td>
					<td align="right">
					<b>Date Completed:</b>
					</td>
					<td>
					#dateFormat(qspec_req.completed_date, 'mm/dd/yyyy')#
					&nbsp;
					
					</td>
					
				</TR>
				<TR ALIGN="left">
					<td style="vertical-align:text-top;"  align="right">
					<B>Received By:</B>
					
					</td>
					<td align="left" style="margin-right: 1cm">
					<!--- dropdown --->
					<CFQUERY DATASOURCE="hourday" NAME="srecieved">
						select rowid, first_name, last_name, user_login, email, user_Dept 
						from user_id 
						where rowid = #qspec_req.received_by#
					</CFQUERY>
				
				#trim(srecieved.first_name)# #trim(srecieved.last_name)#

					</td>
					
					<td align="right">
					<b>Recieved Date:</b>
					</td>
					<td>
					#dateFormat(qspec_req.received_date, 'mm/dd/yyyy')#
					&nbsp;
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
					<td align="left"><input type="reset" name="reset" value=" Clear ">
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