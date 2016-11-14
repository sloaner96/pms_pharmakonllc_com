<!---
    $Id: ,v 1.0 2000/00/00 rsloan Exp $
    Copyright (c) 2005 Pharmakon, LLC.

    Description:
        
    Parameters:
        
    Usage:
        
    Documentation:
        
    Based on:
        
--->
<!--- Set Defaults  --->
   <cfparam name="URL.CID" default="0" type="numeric">
<!--- include libraries --->   
<cfinclude template="/PMS/Includes/libraries/FormatPhone.cfm">
   
<!--- Initialize Component --->
   <cfobject name="ConfirmEmails" component="pms.com.ConfirmEmails">
   <cfobject name="Projects" component="pms.com.Projects">
<!--- Pull Record --->
   <cfset getConfirm = ConfirmEmails.getConfirmations(URL.CID)>
   
   <cfset getProjects = Projects.getProject(getConfirm.ProjectCode)>
<!--- Set Test Variables --->
   
   <cfset ToAddress = "#Session.userinfo.email#">

   <cfset PHID = "000000">
   <cfset FULLNAME = "John H. Smith, MD">
   <cfset ADDRESSBLOCK = "475 N. Martingale Rd.<br>Suite 200<br>Schaumburg, IL 60173">
   <cfset FIRSTNAME = "John">
   <cfset LASTNAME = "Smith">
   <cfset PROGRAMTITLE = "#trim(getProjects.guide_topic)#">
   <cfset MEETINGDATE = "1/1/2006">
   <cfset MEETINGTIME = "3:00PM">
   <cfset SELLINGCOMPANY = "#Trim(getProjects.corp_value)#">
   
   <cfset CETPHONE = "#FormatPhone(replacelist(trim("8885551212"), '(,),-,.,#chr(32)#', ''))#">
   <cfset RECRUITERNUMBER = "#FormatPhone(replacelist(trim(getProjects.recruiting_company_phone), '(,),-,.,#chr(32)#', ''))#">
   <cfset DISCONNECTNUMBER = "#FormatPhone(replacelist(trim(getProjects.helpline), '(,),-,.,#chr(32)#', ''))#">
   <cfset PROGRAMCODE = "#trim(getProjects.Project_Code)#">
   <cfset SIGNATUREIMAGE = "<img src='http://www.healthcareDiscussions.com/images/kevin_Signature.gif' hspace='5' vspace='5' border='0' alt='Kevin Christopherson Signature'>">
		   
   
  
<!--- Do Replacements --->
   <cfset Newtext = ReplacenoCase(getConfirm.ConfirmText, "[FULLNAME]", FULLNAME, "ALL")>
   <cfset Newtext = ReplacenoCase(NewText, "[ADDRESSBLOCK]", ADDRESSBLOCK, "ALL")>
   <cfset Newtext = ReplacenoCase(NewText, "[FIRSTNAME]", FIRSTNAME, "ALL")>
   <cfset Newtext = ReplacenoCase(NewText, "[LASTNAME]", LASTNAME, "ALL")>
   <cfset Newtext = ReplacenoCase(NewText, "[PHID]", PHID, "ALL")>
   <cfset Newtext = ReplacenoCase(NewText, "[PROGRAMTITLE]", PROGRAMTITLE, "ALL")>
   <cfset Newtext = ReplacenoCase(NewText, "[MEETINGDATE]", MEETINGDATE, "ALL")>
   <cfset Newtext = ReplacenoCase(NewText, "[MEETINGTIME]", MEETINGTIME, "ALL")>
   <cfset Newtext = ReplacenoCase(NewText, "[SELLINGCOMPANY]", SELLINGCOMPANY, "ALL")>
   <cfset Newtext = ReplacenoCase(NewText, "[CETPHONE]", CETPHONE, "ALL")>
   <cfset Newtext = ReplacenoCase(NewText, "[RECRUITERNUMBER]", RECRUITERNUMBER, "ALL")>
   <cfset Newtext = ReplacenoCase(NewText, "[DISCONNECTNUMBER]", DISCONNECTNUMBER, "ALL")>
   <cfset Newtext = ReplacenoCase(NewText, "[PROGRAMCODE]", PROGRAMCODE, "ALL")>
   <cfset Newtext = ReplacenoCase(NewText, "[SIGNATUREIMAGE]", SIGNATUREIMAGE, "ALL")>
   
   <cfset setTestEmailSent = ConfirmEmails.UpdtestEmailSent(URL.CID)>
   
   <cfif GetConfirm.FromAddress NEQ "">
	   <cfmail from="#GetConfirm.FromAddress#" to="#ToAddress#" subject="#GetConfirm.ConfirmSubject#" server="mail.pharmakonllc.com" username="pharmakon\zyprexa.marketing" password="mob4merits" type="HTML">
	     #trim(Newtext)#
	   </cfmail>
	   
	   <cflocation URL="dsp_PreviewEmail.cfm?CID=#URL.CID#&s=1" addtoken="NO">
   <cfelse>
      <cflocation URL="dsp_PreviewEmail.cfm?CID=#URL.CID#&s=2" addtoken="NO">	    
   </cfif>
   