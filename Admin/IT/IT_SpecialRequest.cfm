<!--- 
	*****************************************************************************************
	Name:		
	Function:	
	History:	
	
	*****************************************************************************************
--->

<CFPARAM NAME="URL.client" DEFAULT="">

<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="IT Special Requests" showCalendar="0">

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
		<FORM action="IT_SpecialRequestAction.cfm?scheduler=1" method="post">
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
					<td width=150>
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
							
							<OPTION VALUE="#srequest.rowid#">#trim(srequest.first_name)# #trim(srequest.last_name)#
						</CFOUTPUT>
					</SELECT>
					</TD>
					<td align="left" colspan="2">CC yourself:<input type="checkbox" name="cc" value="" class="invis"></td>
				</TR>
				<TR ALIGN="left">
					<td align="right"><b>Request Date:</b></td>
					<td colspan="3">
					<input type="text" onClick="CallCal(this)" CLASS="text"  SIZE="10" name="request_date" value="" onKeypress="if (event.keyCode < 47 || event.keyCode > 57) event.returnValue = false;">
					&nbsp;
					<img src="images/formcalendar.gif" style="vertical-align:middle">
					</TD>
				</TR>
				<TR ALIGN="left">
					<td align="right"><b>Request Completion Date:</b></td>
					<td colspan="3">
					<input type="text" onClick="CallCal(this)" CLASS="text"  SIZE="10" name="request_comp_date" value="" onKeypress="if (event.keyCode < 47 || event.keyCode > 57) event.returnValue = false;">
					&nbsp;
					<img src="images/formcalendar.gif" style="vertical-align:middle">
					</TD>
					
				</TR>
				<TR ALIGN="left">
					<td align="right"><b>Client Name:</b>
					<td colspan="3">
					<cfoutput>
						<CF_TwoSelectsRelated1
							QUERY="qprojects"
							NAME1="select_client"
							NAME2="select_project"
							CLIENT="#url.client#"
							DISPLAY1="description"
							DISPLAY2="client_proj"
							VALUE1="client_code"
							VALUE2="client_proj"
							SIZE1="1"
							SIZE2="1"
							HTMLBETWEEN="</td></tr><tr><td align=right><b>Project Code:</b></td><td colspan=3>"
							AUTOSELECTFIRST="Yes"
							EMPTYTEXT1="(Select)"
							EMPTYTEXT2="(Select)">
						</cfoutput>
					</td>
					</TD>
				</TR>
				<TR ALIGN="left">
					<td align="right"><b>Billable?:</b></td>
					<td colspan="3">
					&nbsp; Yes <INPUT TYPE="radio" NAME="billable" VALUE="1" class="invis">
					&nbsp; No <INPUT TYPE="radio" NAME="billable" VALUE="0" class="invis">
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
					<textarea cols="75" rows="5" name="description" onkeyup="return _checkLimitContent(this)"></textarea>
					</td>
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
	</FORM>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
