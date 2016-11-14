
<CFOBJECT COMPONENT="pms.com.SeriesAdmin"
		   NAME="SeriesAdmin">
		   
<cfparam name="url.SeriesID" default="0">
<!--- Get Series Info --->
<cfset getSeriesInfo = SeriesAdmin.GetSeriesInfo(URL.SeriesID)>
<!--- Get Eligible Programs --->
<cfset EligiblePrograms = SeriesAdmin.GetEligibleProg(URL.SeriesID)>
<!--- Get Existing Programs --->
<cfset ExistingPrograms = SeriesAdmin.GetSeriesPrograms(URL.SeriesID)>

<cfset TitleText = "Add programs to the Series (#getSeriesInfo.SellingCompany##getSeriesInfo.ClientCode##getSeriesInfo.ProductCode##getSeriesInfo.SeriesCode#) #getSeriesInfo.SeriesLabel#">
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="#TitleText#" showCalendar="1">
<div align="right" style="padding-top:10px; padding-bottom:5px;"><a href="index.cfm"><< Back to Series Admin Home</a></div>
<cfoutput>
    <cfform name="projseries" action="act_maintainSeries.cfm?action=UPDATESERIESPROG" method="POST">
	  <input type="hidden" name="SeriesID" value="#URL.SeriesID#">
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
      <tr>
         <td>Use the form below to add Programs to this Series. To add a program click the checkbox next to the program you would like to add, when you are ready click that "Add to Series" button in the middle and programs will be added to the </td>
      </tr>
   </table>   <br> 
   <table border="0" cellpadding="5" cellspacing="0" align="center">
      
	  <tr>
        <cfif EligiblePrograms.recordcount GT 0>
			<td valign="top"><select name="availPrograms" size="10" multiple>
			      <cfloop query="EligiblePrograms">
			       <option value="#EligiblePrograms.RowID#">#EligiblePrograms.ProjectCode#</option>
				  </cfloop> 
				</select>
			</td>
			<td><input type="image" src="/images/moveright.gif" alt="Add program"></td>
		<cfelse>	
	        <td style="color:##777777;" valign="top">There are no additional programs<br> to add to this Series.</td>
		</cfif>
	    <td valign="top" align="center">
		  <table border="0" cellpadding="3" cellspacing="0">
		   <cfif ExistingPrograms.recordcount GT 0>
	           <cfloop query="ExistingPrograms">
				   <tr>
		             <td align="center" width="14" style="border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: ##eee;"><a href="act_maintainSeries.cfm?action=Delete&SeriesID=#URL.SeriesID#&SGroupID=#ExistingPrograms.SeriesGroupID#"><img src="/Images/btn_smalldelete.jpg" width="12" height="12" alt="Remove #ExistingPrograms.ProjectCode#" border="0" align="absmiddle"></a></td>
					 <td style="border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: ##eee;">#ExistingPrograms.ProjectCode#</td>
		           </tr>
			   </cfloop>
		   <cfelse> 
		     <tr>
			   <td style="color:##777777;" valign="top">There are currently no programs in this series.</td>
			 </tr>
		   </cfif>
          </table>           
		</td>
      </tr>
   </table>                            
  </cfform>	   
</cfoutput>     
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">	
