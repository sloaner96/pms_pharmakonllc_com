<cfif IsDefined("URL.PID")>
	<cfset ProgramID = URL.PID>
<cfelseif IsDefined("Form.PID")>
    <cfset ProgramID = Form.PID>
<cfelse>
    <cfset ProgramID = "">
</cfif>
<!--- Initialize the object --->
<cfobject name="CreativeInfo" component="pms.com.CreativeInfo">
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Healthcare Discussions Document Admin" showCalendar="0">
 
<!--- Get the Active and Accepted programs for the pulldown--->
<cfset getActivePrograms = CreativeInfo.GetActivePrograms()>

<table border="0" cellpadding="4" cellspacing="0" width="100%">
   <tr>
       <td style="font-family:verdana; font-size:10px;">The form below will allow you to add/edit and delete guidebooks from the project and from the <a href="http://www.HealthCareDiscussions.com" target="_blank" style="text-decoration:underline;">HealthCareDiscussions.com</a> website. To Add or Update a document, click the browse button and search for the file on your desktop or the network drive. <em><strong>Note:</strong> Files are synced nightly with the Healthcare Discussions site, they are NOT automatically uploaded to the website.</em></td>
   </tr>
</table>           
<hr noshade size=2>
<form name="changethis" action="dsp_adminCreative.cfm" method="POST">
	<table border="0" cellpadding="4" cellspacing="0" align="center">
	  <tr>
	     <td style="font-family:verdana; font-size:10px;"><strong>Select an Active Project:</strong></td>
		 <td><select name="PID" onchange="this.form.submit();">
		        <option value="">-- Select One --</option>
		       <cfoutput query="getActivePrograms"> 
			     <option value="#Trim(getActivePrograms.client_proj)#" <cfif Trim(getActivePrograms.client_proj) EQ Trim(ProgramID)>Selected</cfif>>#Trim(getActivePrograms.client_proj)#</option>
			   </cfoutput>
			 </select>
		 </td>
	  </tr>
	</table>           
</form>
<cfif ProgramID NEQ "">
   <cfset GetGuideInfo = CreativeInfo.getCreativeInfo(ProgramID)>
   <cfoutput>
	    <table border="0" cellpadding="0" cellspacing="0" width="95%" align="center">
	      <tr>
	        <td style="font-family:verdana; font-size:10px;"><strong><a href="dsp_AddCreativeMaterials.cfm?PID=#ProgramID#">Add New Materials</a></strong></td>
	      </tr>
	   </table><br>  
   </cfoutput>         
	<table border="0" cellpadding="3" cellspacing="1" width="95%" bgcolor="#eeeeee" align="center">
      <tr bgcolor="#003366">
	      <td></td>
          <td><strong style="color:#ffffff;font-family:arial; font-size:11px;">Title</strong></td>
		  <td><strong style="color:#ffffff;font-family:arial; font-size:11px;">Material Type</strong></td>
		  <td><strong style="color:#ffffff;font-family:arial; font-size:11px;">FileName</strong></td>
		  <td><strong style="color:#ffffff;font-family:arial; font-size:11px;">FileSize</strong></td>
		  <td><strong style="color:#ffffff;font-family:arial; font-size:11px;">Added</strong></td>
		  <td><strong style="color:#ffffff;font-family:arial; font-size:11px;">Updated</strong></td>
		  <td><strong style="color:#ffffff;font-family:arial; font-size:11px;">LastSync</strong></td>
      </tr>
	  <cfoutput query="GetGuideInfo">
	    <tr bgcolor="##ffffff">
		   <td style="font-family:verdana; font-size:10px;"><a href="DSP_EditCreativeMaterials.cfm?PID=#GetGuideInfo.ProjectCode#&MaterialID=#GetGuideInfo.MaterialID#">[EDIT]</a>&nbsp;<a href="Act_AdminCreative.cfm?Action=Delete&ProjectCode=#GetGuideInfo.ProjectCode#&MaterialID=#GetGuideInfo.MaterialID#" style="color:##cc0000;">[DELETE]</a></td>
           <td style="font-family:verdana; font-size:11px;">#GetGuideInfo.MaterialTitle#</td>
		   <td style="font-family:verdana; font-size:11px;"><cfif GetGuideInfo.MaterialType EQ "A">Admin<cfelseif GetGuideInfo.MaterialType EQ "M">Moderator<cfelseif GetGuideInfo.MaterialType EQ "G">GuideBook</cfif></td>
		   <td style="font-family:verdana; font-size:11px;"><a href="act_getFile.cfm?doc=#GetGuideInfo.MaterialID#" target="_blank">#GetGuideInfo.FileName#</a></td>
		   <td style="font-family:verdana; font-size:11px;">#GetGuideInfo.FileSize# KB</td>
		   <td style="font-family:verdana; font-size:11px;">#DateFormat(GetGuideInfo.DateAdded, 'MM/DD/YYYY')#</td>
		   <td style="font-family:verdana; font-size:11px;">#DateFormat(GetGuideInfo.lastUpdated, 'MM/DD/YYYY')#</td>
		   <td style="font-family:verdana; font-size:11px;">#DateFormat(GetGuideInfo.LastSync, 'MM/DD/YYYY')# #TimeFormat(GetGuideInfo.LastSync, 'hh:mm tt')#</td>
        </tr>
	  </cfoutput>
    </table>           
</cfif>


<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
