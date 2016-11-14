<HTML>
	<HEAD>
		<TITLE>IT Special Request</TITLE>
		<LINK REL="stylesheet" HREF="piw1style.css" TYPE="text/css">
		<BODY>
			<div style="margin:10px 10px 10px 10px;">
			Your email has been sent to the IT department and contains the following information:<br>
			<cfoutput>
			<br>
				<B>IT Special Request Form</B><br><Br>
				To: IT DEPARTMENT <br>
				Requested By: #trim(url.first_name)# #trim(url.last_name)# - #trim(url.email)#<br>
				Request Date: #trim(url.request_date)#<br>
				Request Completed Date: #trim(url.request_comp_date)#<br>
				Client Name: #trim(url.select_client)#<br>
				Project Code: #trim(url.select_project)#<br>
				Billable: <cfif url.billable eq 1>Yes<br>
				<cfelse>No<br>
				</cfif>
				Description: #trim(url.description)#<br>
				<!--- Job Number: #trim(qjust_entered.mjn)# --->
			</cfoutput>
			<br><a href="index.cfm"><font size="+2">Home</font></a>
			</div>
			
		</BODY>
</html>