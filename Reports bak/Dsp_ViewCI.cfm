<!---
    $Id: ,v 1.0 2005/10/14 rsloan Exp $
    Copyright (c) 2005 Pharmakon, LLC.

    Description: This is a general template that you can view the contents of a CI record.
        
    Parameters: URL.CI, must be passed
        
        
--->
<cfif Not IsDefined("URL.CI")>
  <cflocation url="#CGI.HTTP_REFERER#?e=99" addtoken="NO">
</cfif> 

<!--- Include Phone Format UDF --->
<cfinclude template="/PMS/includes/libraries/FormatPhone.cfm">

<!--- Get the CI Record from the reports cfc by passing it the rowid. --->
<cfset getCIData = request.reports.getCI(url.ci)>

<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="View Confirmed Invitee information" showCalendar="0">
<br>
<div align="right"><a href="#" onclick="javascript:history.back(-1);"><< Back</a></div>
<cfoutput query="getCIData">
	<table border="0" cellpadding="4" cellspacing="0" width="100%">
	  <tr>
	      <td><strong>Date Loaded:</strong> #dateformat(getCIData.ci_load_date, 'MM/DD/YYYY')# at #Timeformat(getCIData.ci_load_date, 'hh:mm tt')#</td>
	  </tr>
	  <tr>
	    <td bgcolor="##999999"><strong style="font-size:12px;">PROGRAM INFO</strong></td>
	  </tr>
	  <tr>
	    <td>
		  <table border="0" cellpadding="3" cellspacing="0">
              <tr>
			    <td><strong>Program:</strong></td>
				<td>#Left(getCIData.EventKey, 9)#</td>
			  </tr>
			  <tr>
			    <td><strong>Date &amp; Time:</strong></td>
				<td>#DateFormat(getCIData.EventDate, 'MM/DD/YYYY')# - #EventTime#</td>
			  </tr> 
			  <tr>
			    <td><strong>CI Status:</strong></td>
				<td>#getCIData.CIStatus#</td>
			  </tr>
          </table>           
		</td>
	  </tr>
	  <tr>
	    <td>&nbsp;</td>
	  </tr>
	  <tr>
	    <td bgcolor="##999999"><strong>ATTENDEE INFO</strong></td>
	  </tr>
	  <tr>
	    <td>
		  <table border="0" cellpadding="3" cellspacing="0">
			<tr>
			   <td><strong>Attendee Name:</strong></td>
               <td>(#getCIData.Phid#) <cfif getCIData.Salutation NEQ "">#getCIData.Salutation# </cfif>#getCIData.FirstName# <cfif getCIData.MiddleName NEQ "">#getCIData.MiddleName# </cfif>#getCIData.LastName#<cfif getCIData.Degree NEQ "">, #getCIData.Degree#</cfif></td>
            </tr>
			<tr>
			   <td><strong>Specialty:</strong></td>
			   <td>#getCIData.Specialty#</td>
			</tr>
			<tr>
			   <td><strong>ME Number:</strong></td>
			   <td>#getCIData.meNUM#</td>
			</tr>
			
			<tr>
			  <td valign="top"><strong>Phone:</strong></td>
			  <td>#FormatPhone(trim(getCIData.OfficePhone))# <strong style="color:##a7a7a7; font-weight:normal;">(Office Phone)</strong><br>
			      #FormatPhone(trim(getCIData.Fax))# <strong style="color:##a7a7a7; font-weight:normal;">(Fax)</strong> <cfif FaxAuthorized EQ 1><strong style="color:##006600; font-weight:normal;">Fax Authorized<cfelse><strong style="color:##cc0000; font-weight:normal;">Fax NOT Authorized</strong></cfif><br>
				  #FormatPhone(trim(getCIData.CETPhone))# <strong style="color:##a7a7a7; font-weight:normal;">(CET PHONE)</strong></td>
			</tr>
			<tr>
			  <td valign="top"><strong>Email:</strong></td>
			  <td><cfif getCIData.Email NEQ ""><a href="mailto:#getCIData.email#">#getCIData.Email#</a><cfelse><strong style="color:##990033; font-weight:normal;">Not provided</strong></cfif> <strong style="color:##a7a7a7; font-weight:normal;">(Main Email)</strong>
			      <cfif getCIData.egdbkEmailAddr NEQ ""><br>#getCIData.egdbkEmailAddr# <strong style="color:##a7a7a7; font-weight:normal;">(eGuidebook Email)</strong> <cfif eGuidebook EQ 1><strong style="color:##006600; font-weight:normal;">Would Like eGuidebook</strong></cfif></cfif></td>
			</tr>
			<tr>
			   <td valign="top"><strong>Office Address:</strong></td>
			   <td>#getCIData.OfficeAdd1#<br>
			       <cfif getCIData.OfficeAdd2 NEQ "">#getCIData.OfficeAdd2#<br></cfif>
				   #getCIData.OfficeCity#, #getCIData.OfficeState# #getCIData.OfficeZip#</td>
			</tr>
			<tr>
			   <td valign="top"><strong>ShipTo Address:</strong></td>
			   <td>#getCIData.ShipAdd1#<br>
			       <cfif getCIData.ShipAdd2 NEQ "">#getCIData.ShipAdd2#<br></cfif>
				   #getCIData.ShipCity#, #getCIData.ShipState# #getCIData.ShipZip#</td>
			</tr>
          </table>           
		</td>
	  </tr>
	  <tr>
	    <td>&nbsp;</td>
	  </tr>
	  <tr>
	    <td bgcolor="##999999"><strong>SCREENER QUESTIONS</strong></td>
	  </tr>
	  <tr>
	    <td>
		  <table border="0" cellpadding="3" cellspacing="0">
            <cfloop index="i" from="1" to="10">
		 	  <cfif Len(Trim(Evaluate("getCIData.Screener#i#"))) GT 0>
			  <tr>
                <td><strong>Screener #i#:</strong></td>
			    <td>#Evaluate("getCIData.Screener#i#")#</td>
              </tr>
			  </cfif>
			</cfloop>
          </table>
		</td>
	  </tr>
	  <tr>
	    <td>&nbsp;</td>
	  </tr>
	  <tr>
	    <td bgcolor="##999999"><strong>RECRUITER FIELDS</strong></td>
	  </tr>
	  <tr>
	    <td>
		  <cfset otherNomName = request.reports.getNom('OTR', getCIData.other_nom)>
		  <cfset RepNomName = request.reports.getNom('REP', getCIData.rep_nom)>
		  
		  <table border="0" cellpadding="3" cellspacing="0">
            <tr>
               <td><strong>Other Nom:</strong></td>
			   <td>#getCIData.other_nom#-#otherNomName#</td>
            </tr>
			<tr>
               <td><strong>Rep Nom:</strong></td>
			   <td>#getCIData.rep_nom#-#RepNomName#</td>
            </tr>
			<tr>
               <td><strong>Blitz ContactID:</strong></td>
			   <td>#getCIData.blitz_contactid#</td>
            </tr>
			<tr>
               <td><strong>Blitz ProspectID:</strong></td>
			   <td>#getCIData.BlitzProspectID#</td>
            </tr>
			<tr>
               <td><strong>Blitz Project:</strong></td>
			   <td>(#getCIData.BlitzEventID#) #getCIData.BlitzProject#</td>
            </tr>
          </table>
		</td>
	  </tr>
	  <tr>
	    <td>&nbsp;</td>
	  </tr>
	  <tr>
	    <td bgcolor="##999999"><strong>USER-DEFINED FIELD INFO</strong></td>
	  </tr>
	  <tr>
	    <td>
		  <table border="0" cellpadding="3" cellspacing="0">
            <cfloop index="x" from="1" to="6">
			  <tr>
                 <td><strong>User #x#:</strong></td>
			     <td>#Evaluate("getCIData.User#x#")#</td>
              </tr>
			</cfloop>
          </table>
		</td>
	  </tr>
	  <tr>
	    <td>&nbsp;</td>
	  </tr>
	  <!--- <tr>
	    <td bgcolor="##999999"><strong>TERRITORY INFO</strong></td>
	  </tr>
	  <tr>
	    <td>
		  <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
               <td></td>
			   <td></td>
            </tr>
          </table>
		</td>
	  </tr>
	  <tr>
	    <td>&nbsp;</td>
	  </tr> --->
	</table>           
</cfoutput>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
