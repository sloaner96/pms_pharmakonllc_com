<cflocation url="dsp_WorkOnProject.cfm" addtoken="NO">
<cfabort>
<!--- <cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Work on a PIW" showCalendar="0"  bodyPassthrough="onLoad='init()'" doAjax="True">
  <cfoutput>
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
					getproject();
					
				}
				
				/*function getSeriesStatus()
				{
					var Series = DWRUtil.getValue("series");
					
					DWREngine._execute(_cfscriptPMSLocation, null, 'SeriesStatus', Series, SeriesStatusResult);
				    
				}
				
				function SeriesStatusResult(seriesStatusArray)
				{
					DWRUtil.removeAllOptions("status");
					DWRUtil.addOptions("status", seriesStatusArray, "KEY", "VALUE");
				}*/
				
				function getProject()
				{
					var Series = DWRUtil.getValue("series");
					
					alert(Series);
					DWREngine._execute(_cfscriptPMSLocation, null, 'programlookup', Series, ProjectResults);
				    
				}
				
				function ProjectResults(programArray)
				{
					DWRUtil.removeAllOptions("program");
					DWRUtil.addOptions("program", programArray, "KEY", "VALUE");
				}
				
				function init()
				{
					DWRUtil.useLoadingMessage();
					DWREngine._errorHandler =  errorHandler;
					getClient();
					getSeries();
				}
				
			</script>  
			Use the form below to select a project to work on.<br>
			<table border="0" cellpadding="3" cellspacing="0" width="100%">
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
                   <td align="center">Series:</td>
				   <td><select name="series" id="series" style="vertical-align:top;" onchange="getPrograms();"></select></select></td>
                </tr>
				<tr>
                   <td align="center">Status:</td>
				   <td><select name="status" id="status" style="vertical-align:top;" onchange="getPrograms();"></select></select></td>
                </tr>
<!--- 				<cfinvoke component="pms.com.projects" method="getSeriesPrograms" returnvariable="getPrograms">
		<cfinvokeargument name="SeriesID" value="#Arguments.Series#">
		<cfinvokeargument name="Status" value="3">
	</cfinvoke>  --->
	
				<tr>
                   <td align="center">Programs:</td>
				   <td><select name="program" id="program" style="vertical-align:top;"></select></td>
                </tr>
				
            </table> 
			  </cfoutput>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
 --->