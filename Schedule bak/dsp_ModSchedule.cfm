<cfparam name="URL.MONTH" default="#Month(now())#">
<cfparam name="URL.YEAR" default="#Year(now())#">

<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Moderator Schedule" bodyPassthrough="onLoad='init()'" doAjax="True">
  
  <table border="0" cellpadding="5" cellspacing="0" width="100%">
      <tr>
         <td width="250">
		    <table border="0" cellpadding="3" cellspacing="0" width="100%">
                <tr>
                   <td><cfmodule template="#Application.TagPath#/ctags/calendarworkon.cfm" month="#url.Month#" year="#url.year#" daylist="" CalTopBground="##b2c4c6" Calwidth="190"></td>
                </tr>
            </table>  
			<br>
			<cfset GetModerators = request.Schedule.getMods()>
			<cfoutput>
			<table border="0" cellpadding="3" cellspacing="0" width="100%">
                <tr class="highlight">
                   <td align="center"><strong>Moderators</strong></td>
                </tr>
				<tr>
                   <td align="center"><select name="moderator" size="10">
				         <cfloop query="GetModerators">
				           <option value="#GetModerators.Moderator_id#">#GetModerators.Last_Name#, #GetModerators.First_Name#</option>
						 </cfloop>
					   </select>
				   </td>
                </tr>
            </table>  
			<br><br>
			  <cfset getCompanies = request.util.getCompany()>
			<script language="javascript">
				function getClient()
				{
					var Company = DWRUtil.getValue("company");
					DWREngine._execute(_cfscriptPMSLocation, null, 'Clientlookup', Company, ClientResult);
				}
				
				function ClientResult(clientArray)
				{
					DWRUtil.removeAllOptions("client");
					DWRUtil.addOptions("client", clientArray, "KEY", "VALUE");
					getSeries();
				}
				
				function getSeries()
				{
					var Company = DWRUtil.getValue("company");
					var Client = DWRUtil.getValue("client");
					
					DWREngine._execute(_cfscriptPMSLocation, null, 'Serieslookup', Company, Client, SeriesResult);
				    
				}
				
				function SeriesResult(seriesArray)
				{
					DWRUtil.removeAllOptions("series");
					DWRUtil.addOptions("series", seriesArray, "KEY", "VALUE");
					getProject();
				}
				
				function getProject()
				{
					var Series = DWRUtil.getValue("series");
					DWREngine._execute(_cfscriptPMSLocation, null, 'programlookup', Series, ProjectResults);
				    
				}
				
				function ProjectResults(projectArray)
				{
					DWRUtil.removeAllOptions("program");
					DWRUtil.addOptions("program", projectArray, "KEY", "VALUE");
					
				}
				
				function init()
				{
					DWRUtil.useLoadingMessage();
					DWREngine._errorHandler =  errorHandler;
					getClient();
					getSeries();
				}
				
			</script>  
			
			<table border="0" cellpadding="3" cellspacing="0" width="250">
                <tr class="highlight">
                   <td align="center" colspan="2"><strong>Projects</strong></td>
                </tr>
				<tr>
                   <td align="center">Company:</td>
				   <td><select name="company" id="company" onchange="getClient();">
				         <cfloop query="getCompanies">
				         <option value="#trim(left(getCompanies.corp_value,1))#">#trim(getCompanies.corp_value)#</option>
					     </cfloop>
					   </select></td>
                </tr>
				<tr>
                   <td align="center">Client:</td>
				   <td><select name="client" id="client" style="vertical-align:top;"  onchange="getSeries();"></select></td>
                </tr>
				<tr>
				   <td align="right"><strong>Series:</strong></td>
				   <td><select name="series" id="series" style="vertical-align:top;" onchange="getProject();"></select></td>
				</tr>
				<tr>
				  <td align="right"><strong>Programs:</strong></td>
				   <td><select name="program" id="program" style="vertical-align:top;"></select></td>
			    </tr>
            </table> 
			  </cfoutput>       
		 </td>
		 <td valign="top">
		    <cfoutput>
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
              <tr>
                 <td>Scheduling Meetings for [MODERATOR NAME] for <span id="project"></span> ON <span id="headdate" class="headdate"></span></td>
              </tr>
            </table><br>        
		    <table border="0" cellpadding="4" cellspacing="0">
               <tr>
                  <td><select name="Time">
				        <cfloop index="t" from="1" to="12">
						  <option value="#t#">#t#</option>
						</cfloop>
					  </select>
				  </td>
				  <td><select name="Time">
				        <cfloop index="m" from="0" to="59" step="15">
						  <option value="#m#">#m#</option>
						</cfloop>
					  </select>
				  </td>
				  <td><input type="radio" name="Meridian" value="AM">AM <input type="radio"  name="Meridian" value="PM">PM</td>
               </tr>
            </table><br><br>
			<table border="0" cellpadding="4" cellspacing="0" width="100%">
			   <tr bgcolor="##444444">
			       <td><strong style="color:##ffffff;">Scheduled Meetings for in #MonthasString(url.Month)#</strong></td>
			   </tr>
			   <tr>
			      <td style="color:##cc0000;">There are currently No Meetings Scheduled in #MonthasString(url.Month)# for [MODERATOR NAME]</td>	    
			   </tr>
			</table>           
			</cfoutput>           
		 </td>
      </tr>
  </table>   
          
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
