
 <cfoutput>
 <link rel="stylesheet" type="text/css" media="all" href="/includes/styles/schedule.css" title="tas" />
 <cfset today = 
	DateFormat(now(), "mm-dd-yyyy")>

 <cfset month = url.month>
<cfset year = url.year>

<cfset firstDay = createDate(year,month,1)>
<cfset firstDOW = dayOfWeek(firstDay)>
<cfset dim = daysInMonth(firstDay)>

<cfset lastMonth = dateAdd("m",-1,firstDay)>
<cfset nextMonth = dateAdd("m",1,firstDay)>

<cfif month(now()) EQ month>
  <cfset IsCurrentMonth = true>
<cfelse>
  <cfset IsCurrentMonth = false>  
</cfif> 

<cfobject component="PMS.COM.Scheduling" name="Schedule"> 
<cfset getactiveProj = Schedule.getactiveProjects()>

 <!--------------------------- 
     get Projects for this Day 
	 --------------------------->
	  
	 <cfset thisMonth = "#url.month#">
	  <cfset thisday = "#url.day#">
	  <cfset thisMonth = "#url.year#"> 
	  
	  <cfset getdate = '#url.month#-#url.day#-#url.year#'> 
	  <cfset thisdate = '#DateFormat(getdate, "mm-dd-yyyy")#'> 
	  
			  <cfquery name="getDayList2" datasource="#application.projdsn#"> 
	     Select left(meetingCode, 9) as projectCode, MtgStartTime, MtgEndTime, ScheduleID, Status, password, user2, user3, Remarks, DateAdded, LastUpdated, DateAdded,
		   (Select Top 1 Staff_ID
		     From ScheduleSpeaker
			 Where project_Code = left(M.meetingCode, 9)			 
			 AND Staff_Type IN (1,3,4)) as ModeratorExists,
		   (Select Top 1 Staff_ID
		     From ScheduleSpeaker
			 Where project_Code = left(M.meetingCode, 9)
			 AND Staff_Type IN (2,5,6,7)) as SpeakerExists   
		  From ScheduleMaster M
		  Where meetingdate = '#thisdate#' and 
		  left(meetingCode, 9) = '#url.projectcode#' and
		  MtgStartTime = '#url.time#'
		
	  </cfquery>
	  	<center><font face="verdana" size="2"> Schedule for  <strong>#thisdate#</strong></font><br>
<font face="verdana" size="2" color="navy"><em>Edit Meeting #url.projectcode#</em></font>
</center> 
	     <table border="1" cellpadding="2" cellspacing="0" width="100%">
		        <tr bgcolor="d3d3d3">
						   <td align="left"><font face="verdana" size="2"><strong>Project</strong></font></td>							 
				    <td align="left"><font face="verdana" size="2"><strong>Date</strong></font></td>
					 <td align="left"><font face="verdana" size="2"><strong>Time</strong></font></td>					  			   
				   </tr>  
				

<cfloop query="getDayList2">
<cfform action="update_Schedule_meeting.cfm" method="POST">
<tr>
<td><font face="verdana" size="1">

<select name="ProjectCode">
													    <cfloop query="getactiveProj">
													       <option value="#getactiveProj.Project_Code#" <cfif #url.projectcode# is #getactiveProj.Project_Code#>Selected</cfif>>#getactiveProj.Project_Code#</option>
													    </cfloop>
													  </select>
									 </font> </td>

 <td>
									 
									    <table border="0" cellpadding="2" cellspacing="0">
                                            <tr>
											   
											   <td><select name="month">
											        <cfloop index="themonth" from="1" to="12">
											        <option value="#themonth#" <cfif month eq themonth>Selected</cfif>>#monthasString(themonth)#</option>
													</cfloop>
												  </select>&nbsp;
											   <select name="day">
											         <cfloop index="theday" from="1" to="#dim#">
											            <option value="#theday#"<cfif day eq theday>Selected</cfif>>#theday#</option>
													 </cfloop>
												  </select>&nbsp;
											   <select name="year">
											        <cfloop index="theyear" from="#year(DateAdd('yyyy', -1, now()))#" to="#Year(DateAdd('yyyy', 3, now()))#">
											          <option value="#theyear#" <cfif year eq theyear>Selected</cfif>>#theyear#</option>
													</cfloop>
												  </select>
		   </td>
											</tr>
                                        </table>           
									  </td>


<td><font face="verdana" size="1">
Start Time:<font face="verdana" size="1"><span style="color:##5f5f5f;"></span></font>

									    <table border=0" cellpadding="2" cellspacing="0">
                                          <tr>
											  
											  <td><select name="StartHour">
										        <cfloop index="t" from="1" to="12">
													  <option value="#t#"<cfif #t# eq #TimeFormat(getDayList2.MtgStartTime, 'h')#>Selected</cfif>>#t#</option>
													</cfloop>
												  </select>
											  </td>
											  <td><select name="StartMinute">
											        <cfloop index="m" from="0" to="59" step="15">
													  <option value="#m#"<cfif #m# eq #TimeFormat(getDayList2.MtgStartTime, 'mm')#>Selected</cfif>>#m#</option>
													</cfloop>
												  </select>
											  </td>
											  <td><font face="verdana" size="1">
<input type="radio" name="startMeridian" value="AM"<cfif #TimeFormat(getDayList2.MtgStartTime, 'tt')# eq 'AM'>checked</cfif>>am 

<input type="radio" name="startMeridian" value="PM" <cfif #TimeFormat(getDayList2.MtgStartTime, 'tt')# eq 'PM'>checked</cfif>>pm</font></td>
											</tr> 
                                        </table>           
									End Time:
								
									    <table border="0" cellpadding="2" cellspacing="0">
                                           <tr>  
											 
											  <td><select name="EndHour">
											        <cfloop index="t" from="1" to="12">
													  <option value="#t#"<cfif #t# eq #TimeFormat(getDayList2.MtgEndTime, 'h')#>Selected</cfif>>#t#</option>
													</cfloop>
												  </select>
											  </td>
											  <td><select name="EndMinute">
											        <cfloop index="m" from="0" to="59" step="15">
													  <option value="#m#"<cfif #m# eq #TimeFormat(getDayList2.MtgEndTime, 'mm')#>Selected</cfif>>#m#</option>
													</cfloop>
												  </select>
											  </td>
											  <td><font face="verdana" size="1"><input type="radio" name="endMeridian" value="AM"<cfif #TimeFormat(getDayList2.MtgEndTime, 'tt')# eq 'AM'>checked</cfif>>am <input type="radio"  name="endMeridian" value="PM"<cfif #TimeFormat(getDayList2.MtgEndTime, 'tt')# eq 'PM'>checked</cfif>>pm</font></td>
											</tr>
                                        </table>           
									  </td> </tr>
									 <tr bgcolor="d3d3d3">
						   <td align="left"><font face="verdana" size="2"><strong>User 1</strong></font></td>        
								   <td align="left" nowrap><font face="verdana" size="2"><strong>User 2</strong></font></td>
				    <td align="left"><font face="verdana" size="2"><strong>User 3</strong></font></td>
								  			   
				   </tr>    
						<tr><td>
									
									<input type="text" name="password" value="#getDayList2.password#" size="15" maxlength="100"></td>
									
								
								<td>	
								<input type="text" name="user2" value="#getDayList2.password#" size="15" maxlength="100"></td>
									
									
								<td>
								<input type="text" name="user3" value="#getDayList2.password#" size="15" maxlength="100"></td>
									
									
									
							
							
									</tr>		
									
								 <tr bgcolor="d3d3d3">
									<td align="left"><font face="verdana" size="2"><strong>Status</strong></font></td><td align="left"><font face="verdana" size="2"><strong>Notes</strong></font></td><td align="left"><font face="verdana" size="2"><strong>Last Updated</strong></font></td>
									</tr>
									<tr>
									
			


<td> <select name="Status">
		   <option value="0" <cfif #getDayList2.Status# is 0>Selected</cfif>>0</option>
		   <option value="1" <cfif #getDayList2.Status# is 1>Selected</cfif>>1</option>
		   <option value="2" <cfif #getDayList2.Status# is 2>Selected</cfif>>2</option>
			    </select>
</td> 				
									
								<td>	
									
									<textarea name="remarks" rows="3" cols="20">#Trim(Remarks)#
																		</textarea></td>
							<td>
							<font face="verdana" size="2" color="Navy"><strong><cfif #getDayList2.LastUpdated# is ''>#DATEFORMAT(getDayList2.DateAdded, "mm-dd-yyyy")# #TIMEFORMAT(getDayList2.DateAdded, "h:mm tt")#<cfelse>#DATEFORMAT(getDayList2.LastUpdated, "mm-dd-yyyy")# #TIMEFORMAT(getDayList2.LastUpdated, "h:mm tt")#</cfif></strong></font><br>
							</td>											
																		
									
									</tr> 
									
									
									
																		
									  
									  <tr bgcolor="d3d3d3">
									  <td colspan ="2"><font face="verdana" size="2"><strong>Add Speaker</strong></font></td><td><font face="verdana" size="2"><strong>Add Moderator</strong></font></td>
									  
									 <tr>
									<td colspan="2">
									<cfif  #getDayList2.SpeakerExists# is ''>
	   <cfset #getDayList2.SpeakerExists# = 0></cfif>
<cfif  #getDayList2.ModeratorExists# is ''>
	   <cfset #getDayList2.ModeratorExists# = 0></cfif> 
		
	<cfquery name="speakers" datasource="#application.speakerDSN#">
	     Select
		  sp.speakerid, 
		  sp.firstname, 
		  sp.lastname      	  
		  From 
		  Speaker sp		  
		  Where 		 		 
		  type = 'SPKR'
		  Order by lastname
          </cfquery>   
		  <cfquery name="current_speaker" datasource="#application.speakerDSN#">
	     Select
		  sp.speakerid, 
		  sp.firstname, 
		  sp.lastname      	  
		  From 
		  Speaker sp		  
		  Where 		 	
		  sp.speakerid = '#getDayList2.SpeakerExists#' and	 
		  type = 'SPKR'
          </cfquery> 
		  
		   	
	   <select name="SPKR">
													    <cfloop query="speakers">
													       <option value="#speakerid#" <cfif #speakers.speakerid# is #current_speaker.speakerid#>Selected</cfif>>#UCase(lastname)#, #UCase(firstname)#</option>
													    </cfloop>
													  </select>

 
									
									
									</td> 
		<td>
		<cfquery name="mods" datasource="#application.speakerDSN#">
	     Select
		  sp.speakerid, 
		  sp.firstname, 
		  sp.lastname      	  
		  From 
		  Speaker sp		  
		  Where 		 		 
		  type = 'MOD'
		  Order by lastname
          </cfquery>   
		  <cfquery name="current_mod" datasource="#application.speakerDSN#">
	     Select
		  sp.speakerid, 
		  sp.firstname, 
		  sp.lastname      	  
		  From 
		  Speaker sp		  
		  Where 		 	
		  sp.speakerid = '#getDayList2.ModeratorExists#' and	 
		  type = 'MOD'
          </cfquery> 
		
		 <select name="MOD">
													    <cfloop query="mods">
													       <option value="#speakerid#" <cfif #speakerid# is #current_mod.speakerid#>Selected</cfif>>#UCase(lastname)#, #UCase(firstname)#</option>
													    </cfloop>
													  </select>
		</td>							 
	</tr>
	<tr>
	<td colspan ="3"><br><input type="submit" value="Update">&nbsp;&nbsp;<input type="reset" name="Reset"></td>

									 </tr> 

</cfform></cfloop></table>
</cfoutput>