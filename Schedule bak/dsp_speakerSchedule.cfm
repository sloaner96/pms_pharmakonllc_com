<cfsilent>
<cfset currentmonth = month(now())>

<cfif IsDefined("url.Month")>
  <cfset startDate = CreateDate(url.year, url.Month, 1)>
<cfelse>
  <cfset startDate = CreateDate(year(now()), month(now()), 1)>  
</cfif>

<cfset DateList = StartDate>


<cfloop index="x" from="1" to="2">
  <cfset DateList = ListAppend(DateList, DateAdd('m', x, StartDate), ',')>
</cfloop>


<cfset enddate =  ListGetAt(DateList, ListLen(DateList), ",")>
<cfif Not IsDefined("session.project")>
  <cfobject name="Session.project" component="pms.com.projects">
</cfif>

<cfobject name="Speaker" component="pms.com.speakers">


<cfif isDefined("form.ClientCode")>
 <cflock scope="session" timeout="5" throwontimeout="no">
   <cfset Session.Project_Code = form.ClientCode>
 </cflock>
</cfif>
</cfsilent>
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Scheduling">
<table border="0" cellpadding="4" cellspacing="1" width="100%" bgcolor="#eeeeee">
   <tr bgcolor="#444444">
     <td bgcolor="#ffffff"><strong Style="color:#eeeeee;">Project Schedules</strong></td>
     <td><strong>Moderator Schedules</strong></td>
	 <td><strong>Speaker Schedules</strong></td>
   </tr>
</table>            
<table border="0" cellpadding="0" cellspacing="0" width="100%">
   <tr>
       <td width="599" valign="top">
	     <cfoutput>
		    <br>
			<cfif IsDefined("session.project_code") AND Session.Project_code NEQ "">
			Scheduling Meetings for <strong>#session.project_code#</strong> <a href="popup_changeprogram.cfm" target="_blank" style="font-size:10px; font-family:">[CHANGE]</a><br>
			<cfelse>
			   <cfset getAllClients = request.Project.getClients()>
				   <form name="getClient" action="dsp_speakerSchedule.cfm" method="POST">
					  	<table border="0" cellpadding="0" cellspacing="5">						
		                  <cfif Not IsDefined("form.Client")>
							   <tr>
							      <td><strong>Please Select a Client to View:</strong></td>
							   </tr>
							   <tr>
							     <td><select name="Client" onchange="javascript:form.submit();">
								       <option value=""></option>
									   <cfloop query="getAllClients">
									    <option value="#getAllClients.client_abbrev#">#getAllClients.client_name#</option>
									   </cfloop>
								     </select>
								 </td>
							   </tr>
						   <cfelse>
						      <cfset getClientsPrograms = request.Project.getClientPrograms(form.client)>
							    <tr>
							      <td><strong>Please Select a Client Program to Schedule:</strong></td>
							   </tr>
							   <tr>
							     <td><select name="ClientCode" onchange="javascript:form.submit();">
									   <cfloop query="getClientsPrograms">
									    <option value="#getClientsPrograms.client_code#">#getClientsPrograms.client_code_description#</option>
									   </cfloop>
								     </select>
								 </td>
							   </tr>  
						   </cfif>
						</table>
				    </form>	           
			</cfif>
			<br>
		     <table border="0" cellpadding="0" cellspacing="1" width="80%" bgcolor="##003366">
	           <tr>
			     <td class="Appointmenthead">New Meeting Schedule</td>
			   </tr>
			   <tr>
	             <td bgcolor="##ffffff">
				   <table border="0" cellpadding="4" cellspacing="0" width="100%" class="Appointmentbody">
	                  <tr>
					    <td></td>
					  </tr>
					 <tr>
					   <td colspan=2>
					    <form name="" action="dsp_speakerSchedule.cfm" method="POST">
						     <table border="0" cellpadding="4" cellspacing="0">
	        					<tr>
				                    <td><select name="year">
									      <cfloop index="year" from="#Evaluate(year(now())-1)#" to="#evaluate(year(now())+3)#">
									      <option value="#year#" <cfif year EQ year(now())>Selected</cfif>>#Year#</option>
										  </cfloop>
										</select>
									</td>
									<td><select name="month">
									      <cfloop index="month" from="1" to="12">
									      <option value="#month#" <cfif month EQ month(now())>Selected</cfif>>#MonthasString(month)#</option>
										  </cfloop>
										</select>
									</td>	
									<td><select name="day">
									      <cfloop index="day" from="1" to="31">
									      <option value="#day#" <cfif day EQ day(now())>Selected</cfif>>#day#</option>
										  </cfloop>
										</select>
										
									</td>
									<td><input type="submit" name="submit" value="go"></td>
									<td style="font-color:##606060;">(Today is #DateFormat(now(), 'dd mmmm, yyyy')#)</td>
		                       </tr>
	   						</table>   
						</form>        
					   </td>
					 </tr>
					 <cfif isDefined("form.day")>
					   <cfset getSpeakers = Speaker.getProjectSpeaker(Session.Project_code, form.year, form.month, form.day)>
						 <cfif getSpeakers.recordcount GT 0>
						  <tr>
						    <td width="20%">Select&nbsp;a&nbsp;Speaker:</td>
							<td><select name="Speaker">
							      <cfloop query="getSpeakers">
				                    <option value="speaker_id">#lastname#, #firstname#</option>
								  </cfloop>
								</select>
							 </td>
						  </tr>
						  <tr>
						    <td align="right" colspan="2"><input type="image" src="/Images/btn_scheduleSpeaker.gif" width="114" height="19" alt="Click to Schedule this speaker" border="0"></td>
						  </tr> 
						 <cfelse>
						   <tr>
						     <td class="errorText" align="center">There are no speakers available for this date.</td>
						   </tr> 
						 </cfif> 
					  </cfif>
	               </table>           
				 </td>
	           </tr>
	         </table>
			  <br><br>
			 <table border="0" cellpadding="0" cellspacing="1" width="80%" bgcolor="##9acd32">
			   <tr>
			       <td style="font-size:14px; font-family:arial; padding-left:8px; padding-top:5px; padding-bottom:5px;"><strong>Today's Meetings</strong></td>
			   </tr>
			   <tr>
			     <td bgcolor="##ffffff">
				   <table border="0" cellpadding="4" cellspacing="0" width="100%" class="Appointmentbody">
				      <tr>
				         <td>This is where the Meetings that will happen today will go</td>
				      </tr>
				   </table>           
				 </td>
			   </tr>
			 </table> 
			 <br><br>
			 <table border="0" cellpadding="0" cellspacing="1" width="80%" bgcolor="##ffcc00">
			   <tr>
			       <td style="font-size:14px; font-family:arial; padding-left:8px; padding-top:5px; padding-bottom:5px;"><strong>Upcoming Meetings</strong></td>
			   </tr>
			   <tr>
			     <td bgcolor="##ffffff">
				   <table border="0" cellpadding="4" cellspacing="0" width="100%" class="Appointmentbody">
				      <tr>
				         <td>This is where the upcoming meetings for the next 14 days will go</td>
				      </tr>
				   </table>           
				 </td>
			   </tr>
			 </table>           
		 </cfoutput>          
	   </td>
	   <td width="1" background="/Images/vertdivider.gif"><br><img src="" width="1" height="1" alt="" border="0"></td> 
	   <td align="right" width="200" valign="top"><br>
	     <cfoutput>
		 <table border="0" cellpadding="0" cellspacing="0" width="100%">
		   <tr>
		      <td align="center"><a href="dsp_speakerSchedule.cfm?month=#Month(DateAdd('m', -1, StartDate))#&Year=#Year(DateAdd('m', -1, StartDate))#"><img src="/Images/Btn_upparrow.gif" width="57" height="10" alt="View Previous Months" border="0"></a></td>
		   </tr>
		 </table>  
		 <br>         
	     <cfloop index="x" list="#DateList#" delimiters=",">
	        <cfmodule template="#Application.TagPath#/ctags/calendar.cfm" month="#Month(X)#" year="#year(x)#" daylist=""><br>
		 </cfloop>
		 <br> 
		  <table border="0" cellpadding="0" cellspacing="0" width="100%">
		   <tr>
		      <td align="center"><a href="dsp_speakerSchedule.cfm?month=#Month(DateAdd('m', 1, EndDate))#&Year=#Year(DateAdd('m', 1, EndDate))#"><img src="/Images/Btn_downarrow.gif" width="57" height="10" alt="View Future Months" border="0"></a></td>
		   </tr>
		 </table>
		 </cfoutput>  
	   </td>
      </tr>
   </table>           


<cfmodule template="#Application.tagpath#/ctags/footer.cfm">