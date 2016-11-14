<!---
    $Id: ,v 1.0 2000/00/00 rsloan Exp $
    Copyright (c) 2005 Pharmakon, LLC.

    Description:
        
    Parameters:
        
    Usage:
        
    Documentation:
        
    Based on:
        
--->
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Maintain Program Series" showCalendar="0"  bodyPassthrough="onLoad='init()'" doAjax="True">
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
					//getProject();
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
				
				function goToProject()
				{
					var Series = DWRUtil.getValue("series");
					var sendTo = "dsp_EditSeries.cfm?seriesID=" + Series;
					window.location = sendTo;
				    
				}
				function init()
				{
					DWRUtil.useLoadingMessage();
					DWREngine._errorHandler =  errorHandler;
					getClient();
					getSeries();
				}
				
			</script>    
   <cfoutput>
   <table border="0" cellpadding="3" cellspacing="0" width="100%">
     <tr>
       <td><a href="dsp_addSeries.cfm"><strong>Add a new Series >></strong></a></td>
     </tr>
	 <tr>
	   <td>
	     
	       <table border="0" cellpadding="4" cellspacing="0">
              <tr>
			    <td align="center" colspan="2">Use the form below to select a program to work on.</td>
			  </tr>
				<tr>
			       <td align="right"><strong>Company:</strong></td>
				   <td><select name="company" id="company" onchange="getClient();">
				         <cfloop query="getCompanies">
				         <option value="#trim(left(getCompanies.corp_value,1))#">#trim(getCompanies.corp_value)#</option>
					     </cfloop>
					   </select></td>
			    </tr>
				<tr>
			       <td align="right"><strong>Client:</strong></td>
				   <td><select name="client" id="client" style="vertical-align:top;"  onchange="getSeries();"></select></td>
			    </tr>
				<tr>
			       <td align="right"><strong>Series:</strong></td>
				   <td><select name="series" id="series" style="vertical-align:top;"></select></td>
			    </tr>
				<tr>
				  <td align="center" colspan="2"><input type="submit" name="submit" id="submitbtn" value="Work on Project" onClick="goToProject();"></td>
				</tr>
           </table>  
		       
	   </td>
	 </tr>
   </table>           
   </cfoutput>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">	