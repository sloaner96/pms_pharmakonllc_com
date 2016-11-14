<!---
*********************************************************************************
	PIWadd4.cfm
	
11/6/2001lb
1/23/2002lb changed datasource to pull from hourday; had to remove cftransaction - cant have one transaction for two datasources
	
*********************************************************************************
--->	
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Add New Project Code" showCalendar="0">

	<!--- Pull name for created_by --->
	<CFQUERY DATASOURCE="#session.login_dbs#" NAME="qcreated_by" USERNAME="#session.login_dbu#" PASSWORD="#session.login_dbp#">
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
	<TABLE ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="90%">
		<tr><td>
		<TABLE ALIGN="center" BORDER="0" CELLPADDING="4" CELLSPACING="5" WIDTH="94%">
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
		<tr><td align="right"><b>Contact Phone:</b></td>
			<td>
			
			<cfif  Len(Trim(url.contact_phone)) EQ 10>
							(#Left(url.contact_phone, 3)#) #Mid(url.contact_phone, 4, 3)# - #Mid(url.contact_phone, 6,4)# 
							<CFELSE>
							#trim(url.contact_phone)#
							</cfif>
			</td></tr>
			<tr><td align="right"><b>Fax:</b></td>
			<td>
			<cfif  Len(Trim(url.contact_fax)) EQ 10>
							(#Left(url.contact_fax, 3)#) #Mid(url.contact_fax, 4, 3)# - #Mid(url.contact_fax, 6,4)# 
							<CFELSE>
							#trim(url.contact_fax)#
							</cfif>
			</td></tr>
		<tr><td align="right"><b>Email:</b></td><td>#url.contact_email#</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td align="right"><b>Meeting Information</b></td></tr>
		<cfset commitIt = "yes">

		<!--- start transaction so no insert or update queries will be done if there is a problem. --->
		<!--- <CFTRANSACTION Action="Begin">	 --->
		<!--- loop through list of meeting types selected by user.  --->	
		<cfloop from="1" to="#ListLen(url.meeting_type)#" index="i">
		<!--- 	<CFTRY>	 --->
			<!--- Pull meeting type information --->
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="qmeeting_types">
				SELECT meeting_type, meeting_type_value, meeting_type_description
				FROM meeting_type
				WHERE meeting_type_value = '#ListGetAt(url.meeting_type,i)#'
			</CFQUERY>	
			<!--- <cfcatch type="Database">
				<Cftransaction Action="Rollback"/>
				<CFSET CommitIt = "no">
			</Cfcatch>	
			</CFTRY>	 --->
	
			<!--- set variabe with selling co, client, product, WILDCARD, meeting type. Use this in the query below to pull the max project code (2 underscores is the wildcard --->
			<cfset project_code = #clientcode#&"__"&#ListGetAt(url.meeting_type,i)#>
			<!--- <CFTRY>	  --->
			<!--- Pull last project code to get next number --->
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="qseqnum">
				SELECT MAX(client_proj) AS maxclient 
				FROM client_proj WHERE client_proj LIKE '#project_code#'
			</CFQUERY>	
			 <!--- <cfcatch type="Database">
				<Cftransaction Action="Rollback"/>
				<CFSET CommitIt = "no">
			</Cfcatch>
			</cftry> --->
			
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
			<!--- <CFTRY> --->
			<!--- Insert records --->
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="qaddprojcode">
				Insert into client_proj (client_proj, description, client_code, meeting_type)  
					Values('#newclient#', '#description#', '#clientcode#', #qmeeting_types.meeting_type#)  
			</cfquery>
			 <!--- <cfcatch type="Database">
				<Cftransaction Action="Rollback"/>
				<CFSET CommitIt = "no">
			</Cfcatch>
			</cftry> --->
		
			
			<!--- <CFTRY> --->
			<!--- NEW CLONING CODE --->
			<cfif URL.CloneFrom is "0">
			<!--- 
			Insert new PIW for each meeting type and related records 
				The insert command will fire a trigger that perfoms inserts into
				various other related tables.
			--->	
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="qaddpiw">
					Insert into piw (corp_id, client, product, client_code, piw_update, piw_update_user, project_status, project_code)  
						Values(#qcorp.corp_id#, #qclient.id#, '#trim(qproducts.product_description)#', '#trim(clientcode)#', #Now()#, #session.userinfo.rowid#, 0, '#trim(newclient)#' )  			
				</cfquery>
			<cfelse>
			    <cfquery name="getTemplate" datasource="#Application.projdsn#">
				   Select *
				   From PIW
				   Where project_code = '#trim(URL.CloneFrom)#'
				</cfquery>
				
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="qaddpiw">
					Insert into piw (
					  corp_id, 
					  client, 
					  product, 
					  client_code, 
					  piw_update_user, 
					  project_status, 
					  project_code,
					  account_exec,
					  account_supr,
					  guide_topic,
					  recruiting_company,
					  recruiting_company_phone,
					  call_inbound,
					  call_outbound,
					  conference_company,
					  helpline,
					  speaker_listenins,
					  guide_writer,
					  meeting_type,
					  include_survey,
					  survey_comp,
					  survey_comp_type,
					  attendee_comp,
                      special_notes,
					  target_audience,
					  cme_accredited,
					  cme_org,
					  promo_direct_mail,
					  promo_rep_nom,
					  promo_fax,
					  promo_other,
					  promo_other_descrip,
					  re_recruit,
					  guidebook_include,
					  letter_confirmation,
					  letter_thankyou,
					  PI,
					  letter_factsheet,
					  letter_faxinfosheet,
					  letter_other,
					  letter_other_description,
					  total_cert_honoraria,
					  total_cash_honoraria,
					  attendee_comp_type,
					  attendee_comp_type_id,
					  project_code_desc,
					  piw_update
					  )  
					Values(
					  #qcorp.corp_id#, 
					  #qclient.id#, 
					  '#trim(qproducts.product_description)#', 
					  '#clientcode#',  
					  #session.userinfo.rowid#, 
					  0, 
					  '#trim(newclient)#',
					  <cfif Len(Trim(getTemplate.account_exec)) GT 0>#getTemplate.account_exec#<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.account_supr)) GT 0>#getTemplate.account_supr#<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.guide_topic)) GT 0>'#getTemplate.guide_topic#'<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.recruiting_company)) GT 0>#getTemplate.recruiting_company#<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.recruiting_company_phone)) GT 0>'#getTemplate.recruiting_company_phone#'<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.call_inbound)) GT 0>#getTemplate.call_inbound#<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.call_outbound)) GT 0>#getTemplate.call_outbound#<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.conference_company)) GT 0>#getTemplate.conference_company#<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.helpline)) GT 0>'#getTemplate.helpline#'<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.speaker_listenins)) GT 0>'#getTemplate.speaker_listenins#'<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.guide_writer)) GT 0>#getTemplate.guide_writer#<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.meeting_type)) GT 0>#getTemplate.meeting_type#<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.include_survey)) GT 0>#getTemplate.include_survey#<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.survey_comp)) GT 0>'#getTemplate.survey_comp#'<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.survey_comp_type)) GT 0>#getTemplate.survey_comp_type#<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.attendee_comp)) GT 0>'#getTemplate.attendee_comp#'<cfelse>NULL</cfif>,
                      <cfif Len(Trim(getTemplate.special_notes)) GT 0>'#getTemplate.special_notes#'<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.target_audience)) GT 0>'#getTemplate.target_audience#'<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.cme_accredited)) GT 0>#getTemplate.cme_accredited#<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.cme_org)) GT 0>'#getTemplate.cme_org#'<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.promo_direct_mail)) GT 0>#getTemplate.promo_direct_mail#<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.promo_rep_nom)) GT 0>#getTemplate.promo_rep_nom#<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.promo_fax)) GT 0>#getTemplate.promo_fax#<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.promo_other)) GT 0>#getTemplate.promo_other#<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.promo_other_descrip)) GT 0>'#getTemplate.promo_other_descrip#'<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.re_recruit)) GT 0>#getTemplate.re_recruit#<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.guidebook_include)) GT 0>'#getTemplate.guidebook_include#'<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.letter_confirmation)) GT 0>#getTemplate.letter_confirmation#<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.letter_thankyou)) GT 0>#getTemplate.letter_thankyou#<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.PI)) GT 0>#getTemplate.PI#<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.letter_factsheet)) GT 0>#getTemplate.letter_factsheet#<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.letter_faxinfosheet)) GT 0>#getTemplate.letter_faxinfosheet#<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.letter_other)) GT 0> #getTemplate.letter_other#<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.letter_other_description)) GT 0>'#getTemplate.letter_other_description#'<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.total_cert_honoraria)) GT 0>#getTemplate.total_cert_honoraria#<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.total_cash_honoraria)) GT 0>#getTemplate.total_cash_honoraria#<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.attendee_comp_type)) GT 0>#getTemplate.attendee_comp_type#<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.attendee_comp_type_id)) GT 0>#getTemplate.attendee_comp_type_id#<cfelse>NULL</cfif>,
					  <cfif Len(Trim(getTemplate.project_code_desc)) GT 0>'#getTemplate.project_code_desc#'<cfelse>NULL</cfif>,
					  #Now()# 
					   )  			
				</cfquery>
				
				
				
			</cfif>
			
			<!--- Add to Program Series --->
				
				<cfquery name="getProjID" datasource="#Application.projdsn#">
				  Select RowID
				  From PIW
				  Where project_code = '#trim(newclient)#'
				</cfquery>
				
				<cfif URL.Series NEQ 0>
					<cfquery name="InsertProj" datasource="#Application.projdsn#">
					  Insert Into ProgramSeriesGroup(SeriesCode, ProgramID)
					  Values(#URL.Series#, #getProjID.RowID#)
					</cfquery>
				</cfif>
			<!---  <cfcatch type="Database">
				<Cftransaction Action="Rollback"/>
				<CFSET CommitIt = "no">
			</Cfcatch>
			</cftry> --->

			<!--- Display meeting information and new project code created above --->
			<tr><td>&nbsp;</td><td><b>#ListGetAt(url.meeting_type,i)#</b> - <b><i>(#newclient#)</i></b></td></tr>
		</cfloop>

		<tr><td>&nbsp;</td></tr>
		<TR>
			<td align="right"><b>
			<form action="PIWadd.cfm" method="post"><TD ALIGN="LEFT">
			&nbsp;&nbsp;&nbsp;<INPUT TYPE="submit" NAME="submit" VALUE="Add Another Project Code"></TD></form>
			</td>
		</TR> 
		<!--- </cftransaction> --->
		</table>
		</td></tr>
	</table>
	</cfoutput>
	<!--- <cfif commitIt EQ "no">
		This Client Code has not been added. Please contact IT for assistance.
	</cfif> --->
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">