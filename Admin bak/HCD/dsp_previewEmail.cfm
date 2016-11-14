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
   <cfparam name="URL.S" default="0" type="numeric">
   <cfparam name="URL.E" default="0" type="numeric">
   
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

   
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="HealthCare Discussions Admin" showCalendar="0">

  <cfoutput>	
   <div align="right"><a href="##" onclick="javascript:history.back(-1);"><< Back</a></div>
	<table border="0" cellpadding="4" cellspacing="0" width="100%">
      <tr>
	    <td>
		  <table border="0" cellpadding="3" cellspacing="0">
			  <tr style="highlight">
	             <td colspan="2"><h4>#GetConfirm.ConfirmTitle#</h4></td>
	          </tr>
	          <tr>
                <td><strong>Program:</strong></td>
		        <td>#GetConfirm.ProjectCode#</td>
              </tr>
		  </table>           
		</td>
	  </tr>
	  <tr>
	    <td align="center"><cfif url.s EQ 1><strong style="color:##009900;">You have Successfully sent a test email to yourself. Please check you email inbox.</strong><br><cfelseif URL.S EQ 2><strong style="color:##CC0000;">There was no FROM Address to send the test email from</strong></cfif><form name="testemail" action="act_SendTestEmail.cfm?CID=#getConfirm.confirmID#" method="POST"><input type="submit" name="submit" value="Send Test Email"></form></td>
	  </tr>
	  <tr bgcolor="##c9c9c9">
	    <td><strong style="font-size:12px;">Email Content</strong></td>
	  </tr>
	  <tr>
	    <td>
		    <table border="0" cellpadding="0" cellspacing="0" width="100%">
               <tr>
                   <td><strong>TO:</strong> #ToAddress#</td>
               </tr>
			   <tr>
                   <td><strong>FROM:</strong> #GetConfirm.FromAddress#</td>
               </tr>
			   <tr>
                   <td><strong>SUBJECT:</strong> #GetConfirm.ConfirmSubject#</td>
               </tr>
			   <tr>
                   <td><hr noshade="1"></td>
               </tr>
			   <tr>
			     <td>#trim(Newtext)#</td>
			   </tr>
            </table>           
		</td>
	  </tr>
	  
    </table>   
  </cfoutput>       
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
