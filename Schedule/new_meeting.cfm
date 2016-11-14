
	<cfoutput>
<link rel=stylesheet type="text/css" media=all href="/includes/styles/schedule.css" title=tas/>
<script type="text/javascript">function openpopup4(popurl){
var winpops=window.open(popurl,"","top=200,left=300,width=540,height=610,scrollbars=yes,resizable=yes")
}
</script>
<script type="text/javascript">function openpopup5(popurl){
var winpops=window.open(popurl,"","top=200,left=300,width=300,height=350,scrollbars=yes,resizable=yes")
}
</script>	

	  <cfquery name="get_projects" datasource="#application.projdsn#"> 
	   Select Distinct
	   project_code, product 
	   From piw		 
	   Where project_status = 2 
	   Order By project_code
	  </cfquery>


	    <cfset today = DateFormat(now(), "mm/dd/yyyy")>    
	    <cfset time = TimeFormat(now(), "hh:mm:tt")>			
		<cfset this_year = #DateFormat(today, "yyyy")#>
		<cfset next_year = #this_year# + 1>
		<cfparam default="" name="url.project">
		
		   
	   <font face="verdana" size="1"><a href="javascript:window.close();">
<u>Close Window</u>
</a></font><br>
	<center>	   
	   <font face="verdana" size="2" color="maroon"><strong>Add New Meeting</strong></font><br><br></center>
		<table border=1 cellpadding=2 cellspacing=0 width="100%">
			<tr bgcolor=d3d3d3>
				<td align=left colspan="2">				   
				   <font face="verdana" size="2"><strong>Project</strong></font>
				</td>
				<td align=left>				   
				   <font face="verdana" size="2"><strong>Date</strong></font>
				</td>
				
			</tr>
		  
			<tr>
				<td colspan="2">				      
				   <cfform method="POST" action="insert_new_meeting.cfm">
				   
				    <select name="project">
					 <cfloop query="get_projects">
	        <option value="#get_projects.project_code#"<cfif #Trim(url.project)# is '#Trim(get_projects.project_code)#'>selected</cfif>>#get_projects.project_code# - #get_projects.product#</option>
		   </cfloop>
	    </select>
					
					
				</td>
				<td>
<select name="month">		
						<option value="01"<cfif #DateFormat(today, "mm")# is 01>selected</cfif>>Jan</option>
						<option value="02"<cfif #DateFormat(today, "mm")# is 02>selected</cfif>>Feb</option>
						<option value="03"<cfif #DateFormat(today, "mm")# is 03>selected</cfif>>Mar</option>
						<option value="04"<cfif #DateFormat(today, "mm")# is 04>selected</cfif>>Apr</option>	
						<option value="05"<cfif #DateFormat(today, "mm")# is 05>selected</cfif>>May</option>	
						<option value="06"<cfif #DateFormat(today, "mm")# is 06>selected</cfif>>Jun</option>	
						<option value="07"<cfif #DateFormat(today, "mm")# is 07>selected</cfif>>Jul</option>	
						<option value="08"<cfif #DateFormat(today, "mm")# is 08>selected</cfif>>Aug</option>	
						<option value="09"<cfif #DateFormat(today, "mm")# is 09>selected</cfif>>Sept</option>	
						<option value="10"<cfif #DateFormat(today, "mm")# is 10>selected</cfif>>Oct</option>	
						<option value="11"<cfif #DateFormat(today, "mm")# is 11>selected</cfif>>Nov</option>
						<option value="12"<cfif #DateFormat(today, "mm")# is 12>selected</cfif>>Dec</option>								
										</select>/
<select name="day">		
						<option value="01" <cfif #DateFormat(today, "dd")# is 01>selected </cfif>>01</option>
						<option value="02" <cfif #DateFormat(today, "dd")# is 02>selected </cfif>>02</option>
						<option value="03" <cfif #DateFormat(today, "dd")# is 03>selected </cfif>>03</option>
						<option value="04" <cfif #DateFormat(today, "dd")# is 04>selected </cfif>>04</option>	
						<option value="05" <cfif #DateFormat(today, "dd")# is 05>selected </cfif>>05</option>	
						<option value="06" <cfif #DateFormat(today, "dd")# is 06>selected </cfif>>06</option>	
						<option value="07" <cfif #DateFormat(today, "dd")# is 07>selected </cfif>>07</option>	
						<option value="08" <cfif #DateFormat(today, "dd")# is 08>selected </cfif>>08</option>	
						<option value="09" <cfif #DateFormat(today, "dd")# is 09>selected </cfif>>09</option>	
						<option value="10" <cfif #DateFormat(today, "dd")# is 10>selected </cfif>>10</option>	
						<option value="11" <cfif #DateFormat(today, "dd")# is 11>selected </cfif>>11</option>
						<option value="12" <cfif #DateFormat(today, "dd")# is 12>selected </cfif>>12</option>	
						<option value="13" <cfif #DateFormat(today, "dd")# is 13>selected </cfif>>13</option>
						<option value="14" <cfif #DateFormat(today, "dd")# is 14>selected </cfif>>14</option>
						<option value="15" <cfif #DateFormat(today, "dd")# is 15>selected </cfif>>15</option>
						<option value="16" <cfif #DateFormat(today, "dd")# is 16>selected </cfif>>16</option>	
						<option value="17" <cfif #DateFormat(today, "dd")# is 17>selected </cfif>>17</option>	
						<option value="18" <cfif #DateFormat(today, "dd")# is 18>selected </cfif>>18</option>	
						<option value="19" <cfif #DateFormat(today, "dd")# is 19>selected </cfif>>19</option>	
						<option value="20" <cfif #DateFormat(today, "dd")# is 20>selected </cfif>>20</option>	
						<option value="21" <cfif #DateFormat(today, "dd")# is 21>selected </cfif>>21</option>	
						<option value="22" <cfif #DateFormat(today, "dd")# is 22>selected </cfif>>22</option>	
						<option value="23" <cfif #DateFormat(today, "dd")# is 23>selected </cfif>>23</option>
						<option value="24" <cfif #DateFormat(today, "dd")# is 24>selected </cfif>>24</option>	
						<option value="25" <cfif #DateFormat(today, "dd")# is 25>selected </cfif>>25</option>	
						<option value="26" <cfif #DateFormat(today, "dd")# is 26>selected </cfif>>26</option>	
						<option value="27" <cfif #DateFormat(today, "dd")# is 27>selected </cfif>>27</option>	
						<option value="28" <cfif #DateFormat(today, "dd")# is 28>selected </cfif>>28</option>	
						<option value="29" <cfif #DateFormat(today, "dd")# is 29>selected </cfif>>29</option>	
						<option value="30" <cfif #DateFormat(today, "dd")# is 30>selected </cfif>>30</option>	
						<option value="31" <cfif #DateFormat(today, "dd")# is 31>selected </cfif>>31</option>
						<option value="32" <cfif #DateFormat(today, "dd")# is 32>selected </cfif>>32</option></select>/
								
<select name="year">		
						<option value="#this_year#">#this_year#</option>
						<option value="#next_year#">#next_year#</option></select> 
				</td>
				
			</tr>
			<tr bgcolor=d3d3d3>
			<td align=left>				   
				   <font face="verdana" size="2"><strong>Time</strong></font>
				</td>
				<td align=left>				   
				   <font face="verdana" size="2"><strong>Password</strong></font>
				</td>
				<td align=left colspan=2 nowrap>				   
				   <font face="verdana" size="2"><strong>Status</strong></font>
				</td>
			</tr>
			<tr>
			<td>
			
			<table border=1 cellpadding=2 cellspacing=0>
						<tr>
							<td>							   
							   <font face="verdana" size="1">Start Time:</font> </td>
							   <td>
<select name="start_hour">
						<option value="12">12</option>
						<option value="01">1</option>
						<option value="02">2</option>
						<option value="03">3</option>
						<option value="04">4</option>	
						<option value="05">5</option>	
						<option value="06">6</option>	
						<option value="07">7</option>	
						<option value="08">8</option>	
						<option value="09">9</option>	
						<option value="10">10</option>	
						<option value="11">11</option>								
										</select>:

<select name="start_minute">
						<option value="00">00</option>
						<option value="15">15</option>
						<option value="30">30</option>
						<option value="45">45</option>					
										</select>

<select name="start_day_night">
						<option value="AM">AM</option>
						<option value="PM">PM</option>
										</select>
							</td>							
						</tr>
						<!--- <tr>
							<td>	<br>					   
							   <font face="verdana" size="1">End Time:</font></td>
							   <td><br>
							   <select name="end_hour">
						<option value="12">12</option>
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>	
						<option value="5">5</option>	
						<option value="6">6</option>	
						<option value="7">7</option>	
						<option value="8">8</option>	
						<option value="9">9</option>	
						<option value="10">10</option>	
						<option value="11">11</option>								
										</select>:

<select name="end_minute">
						<option value="00">00</option>
						<option value="15">15</option>
						<option value="30">30</option>
						<option value="45">45</option>					
										</select>

<select name="end_day_night">
						<option value="AM">AM</option>
						<option value="PM">PM</option>
										</select>
							</td>
							
						</tr> --->
					</table>
			</td>
			
				<td>
				   <input type="text" name="password" size="15" maxlength="100">
				</td>
				<td colspan=2>
					<select name="Status">
						<option value="A">Active</option>
						<option value="C">Canceled</option>
						<option value="CPS">Canceled Pay Speaker</option>
						<option value="CPA">Canceled Pay All</option>
						<option value="CPI">Canceled Pay Invitees</option>
						<option value="P">Pending</option>
					</select>
				</td>
			</tr>
			<tr bgcolor=d3d3d3>
				<td align=left>				   
				   <font face="verdana" size="2"><strong>Notes</strong></font></td>
				   <td align=left colspan="2">				   
				   <font face="verdana" size="2"><strong>Meeting / Training</strong></font>
				</td>
			</tr>
			<tr>
				<td>
					<textarea cols="20" rows="3" name="remarks"></textarea> </td>
					
					<td><select name="meetingtraining">
						<option value="no" selected>Meeting</option>
						<option value="yes">Training</option>
						</select>
				</td>
</td>
				<td align=center><br>
				   <input type="submit" value="Add Meeting">&nbsp;&nbsp;
				   <input type="reset" name="Reset">

				</td>
			</tr></cfform>
			
			<cfif IsDefined("url.added")>
			
			<tr><td colspan="3"><br><br> <font face="verdana" size="2">
			Meeting <em><strong>#url.MeetingCode#</strong></em> <font color="FF0000">has been added</font>, <a href="edit_Schedule.cfm?meetingcode=#url.MeetingCode#&day=#url.day#&month=#url.month#&year=#url.year#"><u>Click here</u></a> to edit this meeting, or add Moderators and Speakers.</font>
					<br><br>
			</td></tr>
			</cfif>
			
		</table>
	</cfoutput>
