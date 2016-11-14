<cfsilent>
	<CFOBJECT COMPONENT="pms.com.projects"
	          NAME="project">
	  
<cfif Not IsDefined("form.checksubmit")>
   <cfset BeginDate = DateAdd('d', -1, now())>
   <cfset EndDate = CreateODBCDATETIME(now())>
<cfelse>
   <cfset BeginDate = CreateODBCDATETIME(form.begindate)>
   <cfset EndDate = CreateODBCDATETIME(form.enddate)>
</cfif>


<cfset MeetingCodes = Project.getMeetinCodeDateRange(BeginDate, EndDate)>
</cfsilent>
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Rep Update Program" showCalendar="1">
			
	<cfoutput>
	 <br>         
		<table border="0" cellpadding="5" cellspacing="0" width="100%" align="center">
		    <tr>
			  <td>This application will take data from various client tables, and update rep info in the roster table.<br>
			      <strong>HOW TO USE:</strong> To use this application select the begin and end dates for the 
				  programs you would like to update. For your convienience, we have provided popup calendars to help 
				  you choose a date. To use them, simply click on the calendar icon next to the input box, or just 
				  enter the date in the box provided. Once you have the date range you prefer click the "Get Meetings for this Date Range" button, the screen will 
				  refresh and you will be presented with the programs for the date range you specified. To update 
				  these programs, check the box next to the programs and click the "Run Rep Update" Button.</td>
			</tr>
			<tr>
			  <td><hr noshade size="1"></td>
			</tr>
			<tr>
			  <td align="center">
			    <cfform name="changedate" action="dsp_RepUpdate.cfm" method="POST">
				  <input type="hidden" name="checksubmit" value="1">
				    <table border="0" cellpadding="3" cellspacing="0">
	                   <tr>
					       <td><strong>Start Date:</strong></td>
						   <td><cfinput type="text" passthrough='id="begindate" style="font-size:11px;"' name="begindate" value="#DateFormat(begindate, 'mm/dd/yyyy')#" size="10" maxlength="10" required="yes" message="You must include the projected start date">&nbsp;<img src="/images/btn_formcalendar.gif" id="begindateid" border="0" alt="Double-Click to view calendar" onmouseover="Calendar.setup({inputField:'begindate' ,ifFormat:'%m/%d/%Y',showsTime:false,button:'begindateid',singleClick:true,step:1})"></td>
						   <td>&nbsp;</td>
						   <td><strong>End Date:</strong></td>
						   <td><cfinput type="text" passthrough='id="enddate" style="font-size:11px;"' name="enddate" value="#DateFormat(enddate, 'mm/dd/yyyy')#" size="10" maxlength="10" required="yes" message="You must include the projected end date">&nbsp;<img src="/images/btn_formcalendar.gif" id="enddateid" border="0" alt="Double-Click to view calendar" onmouseover="Calendar.setup({inputField:'enddate' ,ifFormat:'%m/%d/%Y',showsTime:false,button:'enddateid',singleClick:true,step:1})"></td>
					   </tr>
						<tr>
						   <td colspan=5><input type="submit" name="thissubmit" value="Get Meetings for this Date Range" onclick="disableIt(document.changedate.thissubmit, 'Please wait while we retreive the meetings');document.changedate.submit();"></td>
						</tr>
	                </table>  
			    </cfform>           
			  </td>
			</tr>
			<tr>
			  <td align="center">
			    <hr noshade size="1">
				<cfif MeetingCodes.recordcount GT 0>
				  <cfform name="repupdate" action="act_repUpdate.cfm?requesttimeout=1000" method="POST">
					 <table border="0" cellpadding="4" cellspacing="0">
				       <tr>
				          <td><strong>Select the type of update to Run:</strong></td>
						  <td><select name="UpdateType">
						        <option value="RO">Roster</option>
								<option value="CI">CI</option>
								
							  </select>
						  </td>
				       </tr>
				     </table><br>

				     <table border="0" cellpadding="0" cellspacing="0">
				       <tr>
				          <td>Check All Programs that you want to update</td>
				       </tr>
				     </table>   
					 <SCRIPT LANGUAGE="JavaScript">
					    function setDates (form) {
					       document.repupdate.begindate.value = document.changedate.begindate.value;
						   document.repupdate.enddate.value = document.changedate.enddate.value;
					     }
					     var checkflag = "false";
						 
						 function check(field) {
						    if (checkflag == "false") {
						         for (i = 0; i < field.length; i++) {
						             field[i].checked = true;}
						             checkflag = "true";
						      return "Uncheck All"; }
						    else {
						         for (i = 0; i < field.length; i++) {
						              field[i].checked = false; }
						              checkflag = "false";
						      return "Check All"; }
						 }
					 </SCRIPT>
				 
					<!--- These values are populated from the script above --->
					<input type="hidden" name="begindate" value="">
					<input type="hidden" name="enddate" value="">        
				    <cfif MeetingCodes.recordcount LTE 5>
					   <cfset ThisMod = 1>
					 <cfelseif MeetingCodes.recordcount GT 5 AND MeetingCodes.recordcount LTE 12>
					   <cfset ThisMod = 2>
					 <cfelseif MeetingCodes.recordcount GT 12 AND MeetingCodes.recordcount LTE 25>
					   <cfset ThisMod = 3>
					 <cfelseif MeetingCodes.recordcount GT 25>
					   <cfset ThisMod = 4>
					 </cfif>
					 
	                 <table border="0" cellpadding="0" cellspacing="0" align="center">
					   <tr>
					       <td><input type="checkbox" value="Check All" onclick="this.value=check(document.repupdate.projectcode)"> <font face="verdana" size="-2"><strong>SELECT/UNSELECT ALL</strong></font></td>
					   </tr>
					 </table>           
					 <table border="0" cellpadding="0" cellspacing="1" bgcolor="000000" bgcolor="100%">
	                   <tr>
					      <td>
						     <table border="0" cellpadding="5" cellspacing="0" width="100%" bgcolor="ffffff">
	                            <cfloop query="MeetingCodes">
						          <cfif meetingcodes.currentrow mod(#ThisMod#) EQ 1><tr></cfif>
						             <td><input type="checkbox" name="projectcode" value="#trim(Project_Code)#"></td>
	                                 <td>#trim(project_code)#</td>
	                               <cfif meetingcodes.currentrow mod(#ThisMod#) EQ 0></tr></cfif>
						        </cfloop>
	                         </table>           
						  </td>
					   </tr>
	                 </table>   <br>
					 <table border="0" cellpadding="0" cellspacing="0" width="100%">
	                   <tr>
				         <td align="center"><input type="submit" name="rpsubmit" value="Run Rep Update >>" onClick="setDates(this.form);disableIt(document.repupdate.rpsubmit, 'Please wait....');document.repupdate.submit();"></td>
			 	       </tr> 
	                 </table>
				 </cfform>   
				 
				 <cfelse>
				   <table border="0" cellpadding="0" cellspacing="0" align="center">
				     <tr>
				       <td><strong style="font-size:11px;color:666666;">There are currently no programs that can be updated for the timeframe specified above.</strong></td>
				      </tr>
				   </table>           
				 </cfif>                
			  </td>
			</tr>
			
			
		 </table>
	</cfoutput>   
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
             
