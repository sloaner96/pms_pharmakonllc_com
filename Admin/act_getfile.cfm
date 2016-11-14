<cfparam name="url.doc" default="0" type="numeric">
<cfobject name="CreativeInfo" component="CreativeInfo">
<cfset MaterialInfo = CreativeInfo.getMaterialFiles(URL.Doc)>

<cfset ThisFilePath = "c:\InetPub\wwwroot\pms.pharmakonllc.com\Uploads\OnlineMaterials\#Trim(MaterialInfo.ProjectCode)#\#trim(MaterialInfo.FileName)#">
<cfif FileExists("#ThisFilePath#")>
  <cfcontent type="application/pdf" file="#ThisFilePath#" deletefile="NO"> 
<cfelse>
    <br><br><br>
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
       <tr>
          <td align="center" style="color:#cc0000; font-weight:bold;">The File you are attempting to download could not be found<br><cfoutput>#ThisFilePath#</cfoutput></td>
      </tr>
   </table>  
   <br><br><br>
   <br><br><br>
   <br><br><br>         

</cfif>