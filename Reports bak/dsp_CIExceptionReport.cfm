<!---
    $Id: ,v 1.0 2005/10/12 rsloan Exp $
    Copyright (c) 2005 Pharmakon, LLC.

    Description: Admin Report for the CI's which sees if a doctor has been recuited
        
    Parameters:
        
    Usage: This is the front-end Form and the Display Page, It is toggled by the form variables    
--->

<!--- Pull programs and dates --->
<cfset getPrograms = request.reports.getActiveProjects()>
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="CI Exception Report" showCalendar="1">
<br>
	     Use the form below to view duplicate entries for a single individual.<br>
		 <strong style="color:#CC0000;">* Required</strong>  
	     <cfform name="CIReport" action="dsp_CIExceptionReport.cfm" method="POST">
		       <table border="0" cellpadding="4" cellspacing="0">
	              <tr>
	                 <td><strong>Choose a Program Code:</strong><strong style="color:#CC0000;">*</strong></td>
					 <td><select name="ProgCode">
					       <cfoutput query="getPrograms">
					        <option value="#Trim(getprograms.MeetingCode)#">#Getprograms.MeetingCode#</option>
						   </cfoutput>	
						 </select>
					 </td>
	              </tr>
				  <tr>
	                 <td><strong>Choose a Date Range:</strong><strong style="color:#CC0000;">*</strong></td>
					 <td>
					    <table border="0" cellpadding="3" cellspacing="0" width="100%">
	                       <tr>
	                          <td>From: <cfinput type="text" 
							   name="FromDate" 
							   passthrough='id="fromdate" 
							   style="font-size:11px;"' 
							   value="#DateFormat(now(), 'mm/dd/yyyy')#" 
							   size="10" maxlength="10">&nbsp;
							   <img src="/images/btn_formcalendar.gif" 
							     id="frombtn" 
								 border="0" 
								 alt="Click to view calendar" 
								 onclick="Calendar.setup({inputField:'fromdate' ,ifFormat:'%m/%d/%Y',showsTime:false,button:'frombtn',singleClick:true,step:1})"></td>
	                        <td>To: <cfinput type="text" 
							   name="toDate" 
							   passthrough='id="todate" 
							   style="font-size:11px;"' 
							   value="#DateFormat(dateAdd('d', 60, now()), 'mm/dd/yyyy')#" 
							   size="10" maxlength="10">&nbsp;
							   <img src="/images/btn_formcalendar.gif" 
							     id="tobtn" 
								 border="0" 
								 alt="Click to view calendar" 
								 onclick="Calendar.setup({inputField:'todate' ,ifFormat:'%m/%d/%Y',showsTime:false,button:'tobtn',singleClick:true,step:1})"></td>
						   </tr>
	                    </table>           
					 </td>
	              </tr>
				  <tr>
				    <td><strong>Enter a Phid:</strong></td>
					<td><input type="text" name="Phid" value=""></td>
				  </tr>
				  <tr>
				    <td>&nbsp;</td>
				  </tr>
				  <tr>
				    <td colspan="2" align="center"><input type="submit" name="submit" value="search"></td>
				  </tr>
	           </table>   
		  </cfform>    
		  <cfif IsDefined("form.ProgCode")>
		    <cfif Len(trim(form.Phid)) GT 0>
		     <cfset getDups = request.reports.getPhidDups(form.ProgCode, form.fromdate, form.todate, form.Phid)>
			<cfelse> 
			 <cfset getDups = request.reports.getDups(form.ProgCode, form.fromdate, form.todate)>
			</cfif> 
		     <hr noshade size="1">
			 <table border="0" cellpadding="4" cellspacing="0" width="100%">
                 <tr bgcolor="#d4dcdf">
				   <td><cfoutput><strong style="color:##003366; font-family:arial; font-size:14px;">CI Exceptions for #form.ProgCode# </strong></cfoutput></td>
				 </tr>
				 <cfif getDups.Recordcount GT 0>
					 <cfoutput query="getDups" group="Phid">
					   <tr bgcolor="##eeeeee">
	                      <td><strong>(#getDups.Phid#) #getDups.firstname# #getDups.Lastname#<cfif getdups.degree NEQ "">, #GetDups.Degree#</cfif></strong></td>
	                   </tr>
					   <cfoutput>
					     <tr>
						   <td>
						      <table border="0" cellpadding="3" cellspacing="0">
                                <tr>
						          <td width="180"><a href="dsp_viewCI.cfm?ci=#getDups.rowID#">#trim(getDups.EventKey)#</a></td>
						          <td width="180">#dateFormat(getDups.EventDate, 'MM/DD/YYYY')#-#getDups.EventTime#</td>
						          <td>#getDups.CIStatus#</td>
						        </tr>
                              </table>           
						   </td>
						 </tr>
					   </cfoutput>
					   <tr>
					     <td colspan="3">&nbsp;</td>
					   </tr>
					 </cfoutput>
				 <cfelse>
				   <tr>
				     <td align="center"><strong style="color:#cc0000;">There are no duplicates for this meeting</strong></td>
				   </tr>	 
				 </cfif>
             </table> 
		  </cfif>     
          	
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
