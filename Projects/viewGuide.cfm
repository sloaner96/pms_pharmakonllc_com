<cfset getCreative = request.Project.GetCreativeInfo(Session.Project_Code)>

<cfif URL.Type EQ "G">
   <cfset PathtoFile = "#application.SitePath#\Uploads\onlineMaterials\#getCreative.GuideBookFile#"> 
<cfelseIF URL.Type EQ "M">
   <cfset PathtoFile = "#application.SitePath#\Uploads\onlineMaterials\#getCreative.ModeratorGuideFile#"> 
<cfelseIF URL.Type EQ "A">
   <cfset PathtoFile = "#application.SitePath#\Uploads\onlineMaterials\#getCreative.AdminGuideFile#"> 
</cfif>
<cfif FileExists("#PathToFile#")>
   <cfcontent type="application/pdf" file="#PathToFile#" deletefile="NO"> 
<cfelse>
    <strong>Error! The File Could not be Located.</strong>
</cfif>