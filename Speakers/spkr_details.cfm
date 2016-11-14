<!--- sets sortby/order variables to be passed to spkr_Add_Comment.cfm  --->
 <link rel="stylesheet" type="text/css" media="all" href="/includes/styles/schedule.css" title="tas" />
<cfoutput>
<cfif isDefined("form.all_spker")>
<cfset url.speakerid= '#form.all_spker#'></cfif>
</cfoutput>
<cfset sortby = "date_created">
<cfset order = "DESC">

<!--- pulls speaker info --->
<cfquery name="qdetails" DATASOURCE="#application.speakerDSN#" >
	SELECT  s.speakerid, 
	s.lastname, 
	s.firstname, 
	s.middlename, 	
	s.updated, 
	s.updatedby,	
	s.degree, 
	s.sex, 
	s.cv, 
	s.w9, 
	s.travel, 
	s.specialty, 
	s.active,	 
	s.consultagree, 
	s.affil,
	s.taxid, 
	s.active 
	
	FROM   	Speaker s 
	WHERE  	s.speakerid =  #speakerid# AND 
	s.active = 'yes' AND s.type = 'SPKR' 
</cfquery>
	
<!--- pulls userid info --->
<!--- <cfquery name="quserid" datasource="#session.login_dbs#">
	SELECT  user_id.last_name FROM  user_id  WHERE user_id.rowid =  #qdetails.created_by#
</cfquery>	 --->
	 
<!--- pulls userid info --->
<!--- <cfquery name="quserid2" datasource="#session.login_dbs#">
	SELECT  last_name FROM user_id  WHERE rowid = '#qdetails.updated#'
</cfquery> --->	
	
<!--- pulls speaker's address --->
<cfquery name="qaddress" DATASOURCE="#application.speakerDSN#">
	SELECT  
	s.speakerid,
	s.type,
	sa.address1, 
	sa.address2, 
	sa.address3, 
	sa.city, 
	sa.state, 
	sa.zipcode, 
	sa.country, 
	sa.shipaddress1, 
	sa.shipaddress2, 
	sa.shipaddress3, 
	sa.shipcity, 
	sa.shipstate, 
	sa.shipzipcode, 
	sa.shipcountry, 
	sa.timezone 
	FROM    SpeakerAddress sa, Speaker s
	
	WHERE   sa.speakerid =  '#speakerid#' and 
	s.type = 'SPKR' and
	s.speakerid =  '#speakerid#'
	
</cfquery>

 <!--- pulls speaker's comments --->	
<cfquery name="qcomments" DATASOURCE="#application.speakerDSN#">
	SELECT  *
	FROM    comments
	WHERE   clientID =  '#speakerid#' AND type = 'SPKR'
</cfquery>
	
<!--- pulls Contacts for the speaker --->	
<!--- <cfquery name="qContacts" DATASOURCE="#application.speakerDSN#">
	SELECT  Contact_id, Contact_info
	FROM   	Contact_info  
	WHERE  	speakerid =  '#speakerid#' AND 
	type = 'SPKR'
</cfquery> --->
	
	<!--- pulls the phone, fax, email, etc --->
<cfquery name="qphone" DATASOURCE="#application.speakerDSN#">
	SELECT 
	s.type, 
	sa.phone1, 
	sa.phone2, 
	sa.fax1, 
	sa.fax2, 
	sa.cell, 	 
	sa.pager, 	 
	sa.email1, 
	sa.email2	
	FROM    SpeakerAddress sa, Speaker s
	WHERE   
	sa.speakerid = s.speakerid AND
	sa.speakerid = '#speakerid#' AND 
	s.type = 'SPKR' 
</cfquery>
		
<!--- pulls speaker's clients and products and fees 
Query used both projman and speaker dbs--->	
<cfquery name="qgetclients" datasource="#application.speakerDSN#">
	SELECT	 *
	
	FROM 
	SpeakerClients 
	WHERE speakerid = '#speakerid#' 

</cfquery>

<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Speaker Details" showCalendar="0">
<script>

function OpenWindow()
{
	window.open('/schedule/schedule_time_list.cfm?&id=<cfoutput>#speakerid#</cfoutput>&no_menu=1','','height=500,width=750,toolbar=0,status=no,resizable=yes,menubar=no,locationbar=0,scrollbars=yes', "_blank");
}
//-->
</script>	
<br>
<p>Click on edit to update information about the speaker.</p>
<table border="0" cellpadding="3" cellspacing="1" width="95%" bgcolor="#000000" align="center">
   <tr>
     <td bgcolor="#666666">&nbsp;</td>
   </tr>
   <tr>
       <td bgcolor="#ffffff">
			<table border="0" cellspacing="0" cellpadding="2" align="center" width="100%">
				<cfoutput query="qdetails">
				  <tr>
					 <td><b>Speaker Name:</b></td>
					 <td></td>
					 <td colspan="3"><b style="font-size:14px;">#qdetails.firstname#&nbsp;#qdetails.middlename#&nbsp;#qdetails.lastname#&nbsp;#qdetails.degree#&nbsp;&nbsp;</b><A HREF="spkr_edit.cfm?speakerid=#qdetails.speakerid#"><u><strong>[Edit]</strong></u></a></td>
					</tr>
					<tr BGCOLOR="##eeeeee">
						<td width="200"><strong>Speaker ID:</strong></th>
						<td width="10"></td>
						<td width="200">#qdetails.speakerid#</td>
						<td width="50">&nbsp;</td>
						<td width="50">&nbsp;</td>
					</tr>
					<!--- pulls description for inactive code --->
									<tr>
						<td><b>Active:</b></td>
						<td></td>
						<td colspan="3">#qdetails.active#</td>
					</tr>
				</cfoutput>
					<tr>
						<td valign="top"><b>Clients:</b></td>
						<td></td>
						<td colspan="3">
						<!--- displays speaker's clients and products grouped on clients --->
						<cfoutput query="qgetclients">
						<cfquery name="get_desc" datasource="#application.projdsn#"> 
Select project_code, product
		     From PIW
			Where Left(project_code, 5) = '#clientcode#'
			 </cfquery> 
						
							<b>#clientcode#-</b>&nbsp;#get_desc.product#&nbsp;#DollarFormat(EventFee)#&nbsp;&nbsp;<cfif #trim(notes)# IS NOT ""> <img name="commentgif" src="../images/page.gif"></cfif><br>
						</cfoutput>
						</td>
					</tr>
					<tr BGCOLOR="#eeeeee">
						<td><b>Region:</b></td>
						<cfoutput query="qdetails">
						<!--- pulls description for travel code --->
							<cfquery name="qregion" DATASOURCE="#application.speakerDSN#">
								SELECT description
								FROM codes
								WHERE code_type = 'TRAVL' AND code = '#qdetails.travel#'
							</cfquery>
							<td></td>
							<td colspan="3">#qregion.description#</td>
						</tr>
					<!--- pulls description for specialty code --->
					<cfquery name="qspecialty" DATASOURCE="#application.speakerDSN#">
						SELECT description
						FROM codes
						WHERE code_type = 'SPEC' AND code = '#qdetails.specialty#'
						</cfquery>
					<tr>
						<td><b>Specialty:</b></td>
						<td></td>
						<td colspan="3">#qspecialty.description#</td>
					</tr>
					<tr BGCOLOR="##eeeeee">
						<td><b>Sex:</b></td>
						<td></td>
						<td colspan="3">#qdetails.sex#</td>
					</tr>
					<tr>
						<Td><b>SS/Tax ID:</b></td>
						<td></td>
						<td colspan="3">#qdetails.taxid#</td>
					</tr>
					<tr BGCOLOR="##eeeeee">
						<td><b>Affil/Creds:</b><br></th>
						<td></td>
						<td colspan="3">#qdetails.affil#</td>
				</cfoutput>
					</tr>
				    <cfoutput query="qaddress">
					   <tr>
					      <td valign="top"><b> Addresses:</b></td><td>&nbsp;</td>
					      <td colspan="4" align="left"><b>Mail To:<br></b>#qaddress.address1#
					      <cfif qaddress.address2 NEQ ""><br>#qaddress.address2#</cfif><cfif qaddress.address3 NEQ ""><br>#qaddress.address3#</cfif><cfif qaddress.city NEQ ""><br>#qaddress.city#</cfif><cfif qaddress.state NEQ "">&nbsp;&nbsp;#qaddress.state#</cfif><cfif qaddress.zipcode NEQ "">&nbsp;&nbsp;#qaddress.zipcode#</cfif><cfif qaddress.country NEQ ""><br>#qaddress.country#</cfif></td>
				       </tr>
				       <tr>
					      <td></td>
					      <td></td>
					      <td colspan="3" align="left"><b>Shipping Address:<br></b>#qaddress.shipaddress1#
					      <cfif qaddress.shipaddress2 NEQ ""><br>#qaddress.shipaddress2#</cfif><cfif qaddress.shipaddress3 NEQ ""><br>#qaddress.shipaddress3#</cfif><cfif qaddress.shipcity NEQ ""><br>#qaddress.shipcity#</cfif><cfif qaddress.shipstate NEQ "">&nbsp;&nbsp;#qaddress.shipstate#</cfif><cfif qaddress.shipzipcode NEQ "">&nbsp;&nbsp;#qaddress.shipzipcode#</cfif><cfif qaddress.shipcountry NEQ ""><br>#qaddress.shipcountry#</cfif></td>
				       </tr>
				       <tr bgcolor="##eeeeee">
					      <td valign="top"><strong>Hours from Eastern Time:</strong></td>
					      <td>&nbsp;</td>
					      <td colspan=3>#qaddress.timezone#</td>
				       </tr>
				    </cfoutput>
				    
				    <cfoutput query="qphone">
				      <tr>
					    <td valign="top"><b>Phone Numbers:</b></a></td><td>&nbsp;</td>
				        <td colspan="4"><cfif qphone.phone1 NEQ "">#qphone.phone1#&nbsp;<b>-Primary Phone</b></cfif>
						  <cfif qphone.phone2 NEQ ""><br>#qphone.phone2#&nbsp;<b>-Secondary Phone</b></cfif>
					    <cfif qphone.fax1 NEQ ""><br>#qphone.fax1#&nbsp;<b>-Primary Fax</b></cfif>
						  <cfif qphone.fax2 NEQ ""><br>#qphone.fax2#&nbsp;<b>-Secondary Fax</b></cfif>
					    <cfif qphone.cell NEQ ""><br>#qphone.cell#&nbsp;<b>-Cell</b></cfif>
					    <cfif qphone.pager NEQ ""><br>#qphone.pager#&nbsp;<b>-Pager</b></cfif>				    
					    <cfif qphone.email1 NEQ ""><br><a href="mailto:#qphone.email1#">#qphone.email1#</a>&nbsp;<b>-Primary E-mail</b></cfif>
					    <cfif qphone.email2 NEQ ""><br><a href="mailto:#qphone.email2#">#qphone.email2#</a>&nbsp;<b>-Secondary E-mail</b></cfif></td>
				      </tr>	
				    </cfoutput>
				    <!--- <cfoutput query="qContacts"> --->
					<!---    <tr>
						  <td><b>Contact Info:</b></td>
						  <td></td>
						  <td colspan="3">qContacts.Contact_info</td>
					   </tr> --->
				    <!--- </cfoutput> --->
				    <cfoutput query="qdetails">
						<tr BGCOLOR="##eeeeee">
							<td><b>CV Date Rcvd:</b></td><td>&nbsp;</td>
							<td colspan="3">#DateFormat(qdetails.cv, "m/d/yyyy")#</td>
						</tr>
						<tr>
							<td><b>W9 Date Rcvd:</b><td>&nbsp;</td>
							
							<td colspan="3">#DateFormat(qdetails.w9, "m/d/yyyy")#</td>
						</tr>
						<tr>
						  <td colspan="5">
						</tr>
						<tr BGCOLOR="##eeeeee">
							<td><b>Contryes Date Rcvd:</b></td><td>&nbsp;</td>
							<td></td>
							<td colspan="3">#DateFormat(qdetails.consultagree, "m/d/yyyy")#</td>
						</tr>
				<cfif qcomments.recordcount GT 0> 
				<tr>
					<td><b>View Comments:</b></td><td>&nbsp;</td>
					<td colspan="5">
				</tr>
				<cfelse>
				<tr>
					<td><b>Add Comments:</b></td><td>&nbsp;</td>
					<td colspan="5">
				</tr>
				</cfif>
				</cfoutput>
				<tr BGCOLOR="#eeeeee">
					<td><b>Availability:</b></a></td>
					<td></td>
					<td colspan="3"><a href="javascript:OpenWindow()"><strong><u>Check Availability</u></strong></a><br><br></td>
				</tr>
			    <tr>
				  <td bgcolor="#939393" align="center" colspan="5">
			         <cfoutput>
						<table border="0" cellpadding="4" cellspacing="0" bgcolor="##939393" align="center">        
							<tr>
								<td align="left"><b>Date Created:</b></td>
								<td align="left">#dateFormat(qdetails.updated,"m/dd/yyyy")#</td>
								<td align="left"><!--- <b>Created By:</b> ---></td>
								<td><!--- #trim(quserid.last_name)# ---></td>	
							</tr>
							<!--- <tr>
								<td align="left"><b>Date Updated:</b></td>
								<td align="left">dateFormat(qdetails.date_updated,"m/dd/yyyy")</b></td>
								<td align="left"><b>Updated By:</b></td>
								<td align="left">trim(quserid2.last_name)</b></td>
							</tr> --->
						</table>  
			         </cfoutput> 
			      </td>
				</tr>
			</table>
        </td>
      </tr>
   </table>       <br><br>          
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
