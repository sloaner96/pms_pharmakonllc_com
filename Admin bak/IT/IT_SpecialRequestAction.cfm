<CFQUERY DATASOURCE="#application.projdsn#" NAME="insert_database_info">
				INSERT INTO special_request
				(requested_by, request_date, request_comp_date, client, project_code, billable, description)
				VALUES (
				'#trim(left(form.requested_by, 30))#',
				
				
				<cfif trim(request_date) EQ "">
					null,
				<cfelse>
					'#form.request_date#',
				</cfif>
				
				<cfif trim(request_comp_date) EQ "">
					null,
				<cfelse>
					'#form.request_comp_date#',
				</cfif>
				
				'#trim(left(form.select_client, 30))#',
				'#trim(left(form.select_project, 15))#',
				#form.billable#,
				'#trim(left(form.description, 50))#'
				)
		</CFQUERY>
	
	<CFQUERY DATASOURCE="hourday" NAME="semail">
		select first_name, last_name, email
		from user_id 
		where rowid= #form.requested_by#;
	</CFQUERY>

<cftransaction>
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="qjust_entered">
				Select Max(job_number) as mjn
				from special_request
	</CFQUERY>
</cftransaction>	
	
	
	<!--- bjurevicius --->
	<CFIF IsDefined("form.cc")><br>
	<CFMAIL to="tswift@pharmakonllc.com" from="#semail.email#" CC="#semail.email#" Subject="IT Special Request has been added!" server="MAIL.PHARMAKONLLC.COM">
		IT SPECIAL REQUEST FORM
		To: IT DEPARTMENT 
		Requested By: #trim(semail.first_name)# #trim(semail.last_name)# - #trim(semail.email)#
		Request Date: #trim(form.request_date)#
		Request Completed Date: #trim(form.request_comp_date)#
		Client Name: #trim(form.select_client)#
		Project Code: #trim(form.select_project)#
		Billable: <cfif form.billable eq 1>Yes
		<cfelse>No
		</cfif>
		Description: #trim(form.description)#
		Job Number: #trim(qjust_entered.mjn)#
    </CFMAIL>
	<CFELSE>
	<CFMAIL to="tswift@pharmakonllc.com" from="#semail.email#" Subject="IT Special Request has been added!" server="MAIL.PHARMAKONLLC.COM">
		IT SPECIAL REQUEST FORM
		To: IT DEPARTMENT 
		Requested By: #trim(semail.first_name)# #trim(semail.last_name)# - #trim(semail.email)#
		Request Date: #trim(form.request_date)#
		Request Completed Date: #trim(form.request_comp_date)#
		Client Name: #trim(form.select_client)#
		Project Code: #trim(form.select_project)#
		Billable: <cfif form.billable eq 1>Yes
		<cfelse>No
		</cfif>
		Description: #trim(form.description)#
		Job Number: #trim(qjust_entered.mjn)#
    </CFMAIL>
	</CFIF>

		
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
				Requested By: #trim(semail.first_name)# #trim(semail.last_name)# - #trim(semail.email)#<br>
				Request Date: #trim(form.request_date)#<br>
				Request Completed Date: #trim(form.request_comp_date)#<br>
				Client Name: #trim(form.select_client)#<br>
				Project Code: #trim(form.select_project)#<br>
				Billable: <cfif form.billable eq 1>Yes<br>
				<cfelse>No<br>
				</cfif>
				Description: #trim(form.description)#<br>
				<!-- Job Number: #trim(qjust_entered.mjn)# -->
			</cfoutput>
			<br><a href="index.cfm"><font size="+2">Home</font></a>
			</div>
			
		</BODY>
</html>