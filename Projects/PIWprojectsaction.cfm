<!---
*********************************************************************************
	PIWprojectsaction.cfm
	
11/6/2001lb
1/23/2002lb changed datasources to pull from client_proj table in hourday. Had to remove cftransaction - can not use two datasources in one transaction 
	
*********************************************************************************
--->	
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Add ProjectCode" showCalendar="0">

<!--- Double check that this code has not already been added --->
<CFQUERY DATASOURCE="#application.projdsn#" NAME="client_code_entered">
	SELECT client_code FROM client_code WHERE client_code = '#url.clientcode#'
</CFQUERY>
<!--- if this is a new client code --->
<CFIF client_code_entered.recordcount EQ 0>
	<!--- Pull name for created_by --->
	<CFQUERY DATASOURCE="#session.login_dbs#" NAME="qcreated_by">
		SELECT first_name, last_name FROM user_id WHERE rowid = #session.userinfo.rowid#
	</CFQUERY>	
	
	<!--- Pull selling company name --->
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="qcorp">
		SELECT corp_id, corp_value, corp_description, corp_abbrev
		FROM corp WHERE corp_abbrev = '#url.corp#' 
	</CFQUERY>	
		
	<!--- Pull client name --->
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="qclient">
		SELECT id, client_abbrev, client_name
		FROM clients WHERE client_abbrev = '#url.client#' 
	</CFQUERY>	

	<!--- Pull product type --->
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="qproducts">
		SELECT product_id, product_description, product_code
		FROM products WHERE product_code = '#url.product#' and client_abbrev = '#URL.client#' 
	</CFQUERY>		

	<!--- Display info for printing --->
	<cfoutput>
		<TABLE ALIGN="center" BORDER="0" CELLPADDING="0" CELLSPACING="5" WIDTH="94%">
		<tr><td colspan="2" align="center"><font color="Navy"><font size="2">Your project has been added. Below are the details. Please print this page for your records.</font></font></td></tr>
		<tr><td></td></tr>
		<tr><td align="right"><b>Created By:</b></td><td>#qcreated_by.first_name# #qcreated_by.last_name#</td></tr>
		<tr><td align="right"><b>Client Code:</b></td><td>#clientcode#</td></tr>
		<tr><td align="right"><b>Selling Company:</b></td><td>#qcorp.corp_value#</td></tr>
		<tr><td align="right"><b>Client:</b></td><td>#qclient.client_name#</td></tr>
		<tr><td align="right"><b>Product:</b></td><td>#qproducts.product_description#</td></tr>
		<tr><td align="right"><b>Contact:</b></td><td>#url.contact_name#</td></tr>
		<tr><td align="right"><b>Address:</b></td><td>#url.contact_add#</td></tr>
		<cfif url.contact_add2 NEQ "">
			<tr><td align="right"></b></td><td>#url.contact_add2#</td></tr>
		</cfif>
		<tr><td align="right"><b></b></td><td>#url.contact_city#, #url.contact_state# #url.contact_zip#</td></tr>
		<tr><td align="right"><b>Contact Phone:</b></td><td>#url.contact_phone#</td></tr>
		<tr><td align="right"><b>Fax:</b></td><td>#url.contact_fax#</td></tr>
		<tr><td align="right"><b>Email:</b></td><td>#url.contact_email#</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td align="right"><b>Meeting Information</b></td></tr>
		<cfset commitIt = "yes">

		<!--- start transaction so no insert or update queries will be done if there is a problem. --->

		<!--- loop through list of meeting types selected by user.  --->	
		<cfloop from="1" to="#ListLen(url.meeting_type)#" index="i">
			<CFTRANSACTION Action="Begin">
			<CFTRY>
			<!--- Pull meeting type information --->
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="qmeeting_types">
				SELECT meeting_type, meeting_type_value, meeting_type_description
				FROM meeting_type
				WHERE meeting_type_value = '#ListGetAt(url.meeting_type,i)#'
			</CFQUERY>	
			<cfcatch type="Database">
				<Cftransaction Action="Rollback"/>
				<CFSET CommitIt = "no">
			</Cfcatch>	
			</CFTRY>
			</cftransaction>	
	
			<!--- set variabe with selling co, client, product, WILDCARD, meeting type. Use this in the query below to pull the max project code (2 underscores is the wildcard --->
			<cfset project_code = #clientcode#&"__"&#ListGetAt(url.meeting_type,i)#>
			
			<!--- Pull last project code to get next number --->
			<CFTRANSACTION Action="Begin">
			<CFTRY>
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="qseqnum">
				SELECT MAX(client_proj) AS maxclient 
				FROM client_proj WHERE client_proj LIKE '#project_code#'
			</CFQUERY>	
			<cfcatch type="Database">
				<Cftransaction Action="Rollback"/>
				<CFSET CommitIt = "no">
			</Cfcatch>
			</cftry>
			</cftransaction>
					
			<!--- MaxClient:#qseqnum.maxclient# --->
			<cfif qseqnum.maxclient NEQ "">
				<!--- pulls the "number" from the maxclient and adds 1 to it. If no record, start at 00 --->
		 		<cfset nextclient = #MID(qseqnum.maxclient,6,2)# + 1>
			<cfelse>
				<cfset nextclient = #clientcode#&"00"&#ListGetAt(url.meeting_type,i)#>
			</cfif>
			 <!--- if the number in the project code is less than 10, add a zero in front to make it two digits --->
		 	<cfif nextclient LT 10>
				<cfset nextclient = 0&#nextclient#>
			</cfif>
			<!--- disects max project code and inserts next number created above --->
			<cfset newclient = #LEFT(qseqnum.maxclient,5)#&#nextclient#&#RIGHT(Trim(qseqnum.maxclient),2)#>
			<!--- create client/product description --->
			<cfset description = (#qcorp.corp_description#&" "&#qclient.client_name#&" "&#qproducts.product_description#&" "&#qmeeting_types.meeting_type_description#)>
	
			<!--- Description:#description# --->
			<CFTRANSACTION Action="Begin">
			<CFTRY>
			<!--- Insert client_proj records in projman DB--->
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="qaddprojcode">
				Insert into client_proj (client_proj, description, client_code, meeting_type)  
					Values('#newclient#', '#description#', '#clientcode#', #qmeeting_types.meeting_type#)  
			</cfquery>
			 <cfcatch type="Database">
				<Cftransaction Action="Rollback"/>
				<CFSET CommitIt = "no">
			</Cfcatch>
			</cftry>
			</cftransaction>
			
			<!--- 
			Insert new PIW for each meeting type and related records 
				The insert command will fire a trigger that perfoms inserts into
				various other related tables.
			--->	
			<CFTRANSACTION Action="Begin">
			<CFTRY>
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="qaddpiw">
				Insert into piw (corp_id, client, product, client_code, piw_update, piw_update_user, project_status, project_code)  
					Values(#qcorp.corp_id#, #qclient.id#, '#qproducts.product_description#', '#clientcode#', #Now()#, #session.userinfo.rowid#, 0, '#newclient#' )  			</cfquery>
			 <cfcatch type="Database">
				<Cftransaction Action="Rollback"/>
				<CFSET CommitIt = "no">
			</Cfcatch>
			</cftry>
			</cftransaction>
	
			<!--- Display meeting information and new project code created above --->
			<tr><td>&nbsp;</td><td><b>#ListGetAt(url.meeting_type,i)#</b> - <b><i>(#newclient#)</i></b></td></tr>
		</cfloop>

		<!--- concoct project_description --->
		<cfset project_description = (#qcorp.corp_description#&" "&#qclient.client_name#&" "&#qproducts.product_description#)>	
		<!--- Insert records --->
		<CFTRANSACTION Action="Begin">
		<CFTRY>
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="qaddclientcode">
			Insert into client_code (client_code, client_code_description, product_manager, address1, address2, city, state, zipcode, phone, fax, email, status, createdby, createddate)  
				Values('#clientcode#', '#project_description#', '#url.contact_name#', '#url.contact_add#', '#url.contact_add2#', '#url.contact_city#', '#url.contact_state#', '#url.contact_zip#', '#url.contact_phone#', '#url.contact_fax#', '#url.contact_email#', '1', #session.userinfo.rowid#, #Now()#)  
		</cfquery> 
		<cfcatch type="Database">
			<Cftransaction Action="Rollback"/>
			<CFSET CommitIt = "no">
		</Cfcatch>
		</cftry>
		</cftransaction>
		<tr><td>&nbsp;</td></tr>
		<TR>
			<form action="dsp_addClientCode.cfm" method="post"><TD ALIGN="LEFT">
			&nbsp;&nbsp;&nbsp;<INPUT TYPE="submit" NAME="submit" VALUE="Add Another Client Code"></TD></form>
			</td>
		</TR> 
		</table>
	</cfoutput>
<cfelse>
	<!--- this is an existing client code --->
	<font size="3">This client code already exists. To add more projects for this client and project, go to <i>Add projects to existing client code</i>. </font>
</cfif>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
