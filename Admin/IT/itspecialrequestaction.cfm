



<CFQUERY DATASOURCE="#application.projdsn#" NAME="insert_database_info">
				INSERT INTO special_request
				(
				requested_by, request_date, request_comp_date, client, project_code, billable, description,
				comments
				
				)
				
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
				'#trim(left(form.description, 50))#',
				'#trim(left(form.comments, 50))#'
				)
		</CFQUERY>
	
	<CFQUERY DATASOURCE="hourday" NAME="semail">
		select first_name, last_name, email
		from user_id 
		where rowid= #form.requested_by#;
	</CFQUERY>
	
	<CFMAIL to="tswift@pharmakonllc.com" from="""#semail.first_name#, #semail.last_name#"" <#semail.email#>" Subject="IT Special Request has been added!" server="MAIL.PHARMAKONLLC.COM">
    From: #semail.first_name#, #semail.last_name#,
	Summary:
	'#trim(left(form.description, 50))#',
	'#trim(left(form.comments, 50))#'
    </CFMAIL>	
		
<HTML>
	<HEAD>
		<TITLE>IT Special Request</TITLE>
		<LINK REL="stylesheet" HREF="piw1style.css" TYPE="text/css">
		<BODY>
		DONE!
		</BODY>
</html>