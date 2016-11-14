<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Change Program Code</title>
    <link rel="stylesheet" href="/includes/styles/main.css" type="text/css" media="screen"/>
</head>

<body>
<cfoutput>
<cfif Not IsDefined("form.ClientCode")>
<cfset getAllClients = request.Project.getClients()>
   <form name="getClient" action="popup_changeprogram.cfm" method="POST">
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
<cfelse>
  <cfset session.project_code = form.clientCode>
  
  <p>You have Successfully Changed the program Code to <strong>#form.ClientCode#</strong></p>
  <br><br>
  <a href="" target="_top" onClick="self.close();">Click here</a> to go back to the main window					
</cfif>
</cfoutput>

</body>
</html>
