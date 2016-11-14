<!---
    $Id: ,v 1.0 2005/12/01 rsloan Exp $
    Copyright (c) 2005 Pharmakon, LLC.

    Description:This is the Edit Module, from here 
	            users can edit created (non-Approved) 
				Confirmation Letters.
        
    Parameters: Requires URL.CID which is the confirmation ID Passed along the url line.

        
--->
<cfparam name="URL.CID" default="0" type="numeric">

<!--- Initialize Components --->   
   <cfobject name="ConfirmEmails" component="pms.com.ConfirmEmails">
   <cfobject name="CreativeInfo" component="pms.com.CreativeInfo">
   
<!--- Get the Confirmation Email to work on. --->
    <cfset EmailRec = ConfirmEmails.getConfirmations(url.CID)> 
	
<!--- Get the Active and Accepted programs for the pulldown--->
	<cfset getActivePrograms = CreativeInfo.GetActivePrograms()>     
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Edit Confirmation Email" showCalendar="0">
  <div align="right"><a href="index.cfm"><< Back to Confirmation Home</a></div>
  <table border="0" cellpadding="4" cellspacing="0">
	 <tr>
	     <td>You can edit the confirmation email below. Use the legend to insert placeholder text that will be specific to each email sent out. Use only placeholders that are listed to the right. If you need additional placeholders please contact IT.</td>
	 </tr>
  </table>
  <cfform name="addnew" action="act_UpdateContent.cfm" method="POST">
     <cfoutput>
	    <input type="hidden" name="ConfirmID" value="#EmailRec.ConfirmID#">
		 <table border="0" cellpadding="4" cellspacing="0" width="100%">
	          <tr>  
			     <td><strong>Program:</strong></td>
	             <td align="left">#EmailRec.ProjectCode#</td>
	          </tr>
			  <tr>
			     <td width="18%"><strong>Confirmation Email Title:</strong></td> 
	             <td align="left"><input type="text" name="EmailTitle" value="#Trim(EmailRec.ConfirmTitle)#" size="40" maxlength="65"> <strong style="color:##777777; font-size:10px; font-family:arial; font-weight:normal;">(Internal Use)</strong></td>
	          </tr>
			  <tr>
			     <TD><strong>Begin Date:</strong></td>
				 <td align="left"><cfmodule template="#Application.tagpath#/ctags/calInput.cfm"
						  inputname="begin_date"
						  htmlID="begindate"
						  FormValue="#dateformat(EmailRec.StartDate, 'mm/dd/yyyy')#"
						  imgid="begindatebtn">
				</tr>
				<tr>
				   <td><strong>End Date:</strong></td>
				   <td align="left"><cfmodule template="#Application.tagpath#/ctags/calInput.cfm"
							inputname="end_date"
							htmlID="enddate"
							FormValue="#DateFormat(EmailRec.endDate , 'mm/dd/yyyy')#"
							imgid="enddatebtn">
				   </td>
			  </tr>
			  <tr>
			    <td><strong>Date Added:</strong></td>
				<td>#DateFormat(EmailRec.DateAdded, 'MM/DD/YYYY')#</td>
			  </tr>
			  <tr>
			    <td><strong>Last Updated:</strong></td>
				<td><cfif EmailRec.LastUpdated NEQ "">#DateFormat(EmailRec.LastUpdated, 'MM/DD/YYYY')#<cfelse>NEVER</cfif></td>
			  </tr>
			  <tr>
			     <td>&nbsp;</td>
			  </tr>
			  <tr class="highlight">
			     <td colspan="2"><strong>Email Content</strong></td>
			  </tr>
			  <tr>
			     <td><strong>From Address:</strong></td>
				 <td align="left"><input type="text" name="EmailFrom" value="#Trim(EmailRec.FromAddress)#" size="50" maxlength="90"></td>
			  </tr>
			  <tr>
			     <td><strong>Email Subject:</strong></td>
				 <td align="left"><input type="text" name="EmailSubject" value="#Trim(EmailRec.ConfirmSubject)#" size="50" maxlength="65"></td>
			  </tr>
			  <tr>
			     <td colspan="2"><strong>Email Content:</strong></td>
			  </tr>
			  <tr>
			     <td colspan="2">
				   <table border="0" cellpadding="0" cellspacing="0" width="100%">
				     <tr>
				        <td><textarea cols="60" rows="30" name="EmailText">#trim(EmailRec.ConfirmText)#</textarea></td>
						   <td valign="top" align="center">
							   <table border="0" cellpadding="3" cellspacing="1" width="150" bgcolor="##000000">
						           <tr bgcolor="##eeeeee">
						               <td align="center"><strong>LEGEND:</strong></td>
						           </tr>
								   <tr>
						             <td bgcolor="##ffffff" align="left">
										 <table border="0" cellpadding="3" cellspacing="0" width="100%">
											 <tr>
											   <td width="12"><img src="/Images/btn_help_gray.gif" width="12" height="12" alt="This is the PHID of the participant such as 00000" border="0"></td>
											   <td width="140">[PHID]</td>
											 </tr>
											 <tr>
											   <td width="12"><img src="/Images/btn_help_gray.gif" width="12" height="12" alt="This is the full name of the participant such as Dr. John Smith" border="0"></td>
											   <td width="140">[FULLNAME]</td>
											 </tr>
											 <tr>
											   <td width="12"><img src="/Images/btn_help_gray.gif" width="12" height="12" alt="This is the full address" border="0"></td>
											   <td>[ADDRESSBLOCK]</td>
											 </tr>
											 <tr>
											   <td width="12"><img src="/Images/btn_help_gray.gif" width="12" height="12" alt="The Firstname of the participant" border="0"></td>
											   <td>[FIRSTNAME]</td>
											 </tr>
											 <tr>
											   <td width="12"><img src="/Images/btn_help_gray.gif" width="12" height="12" alt="The Lastname of the participant" border="0"></td>
											   <td>[LASTNAME]</td>
											 </tr>
											 <tr>
											   <td width="12"><img src="/Images/btn_help_gray.gif" width="12" height="12" alt="The Title of the Program out of the PIW" border="0"></td>
											   <td>[PROGRAMTITLE]</td>
											 </tr>
											 <tr>
											   <td width="12"><img src="/Images/btn_help_gray.gif" width="12" height="12" alt="The date that the particpant is signed up for formatted MM/DD/YYYY" border="0"></td>
											   <td>[MEETINGDATE]</td>
											 </tr>
											 <tr>
											   <td width="12"><img src="/Images/btn_help_gray.gif" width="12" height="12" alt="The time that the particpant is signed up for formatted HH:MM TT" border="0"></td>
											   <td>[MEETINGTIME]</td>
											 </tr>
											 <tr>
											   <td width="12"><img src="/Images/btn_help_gray.gif" width="12" height="12" alt="The name of the company that sold the program." border="0"></td>
											   <td>[SELLINGCOMPANY]</td>
											 </tr>
											 <tr>
											   <td width="12"><img src="/Images/btn_help_gray.gif" width="12" height="12" alt="" border="0"></td>
											   <td>[CETPHONE]</td>
											 </tr>
											 <tr>
											   <td width="12"><img src="/Images/btn_help_gray.gif" width="12" height="12" alt="" border="0"></td>
											   <td>[RECRUITERNUMBER]</td>
											 </tr>
											 <tr>
											   <td width="12"><img src="/Images/btn_help_gray.gif" width="12" height="12" alt="" border="0"></td>
											   <td>[DISCONNECTNUMBER]</td>
											 </tr> 
											 <tr>
											   <td width="12"><img src="/Images/btn_help_gray.gif" width="12" height="12" alt="" border="0"></td>
											   <td>[PROGRAMCODE]</td>
											 </tr> 
											 <tr>
											   <td width="12"><img src="/Images/btn_help_gray.gif" width="12" height="12" alt="This will pull the graphic for Kevin's signature and insert it where placed." border="0"></td>
											   <td>[SIGNATUREIMAGE]</td>
											 </tr> 
											 
						                    </table>
											<hr noshade size="1">
											<table border="0" cellpadding="2" cellspacing="0" width="100%">
											  <tr>
											      <td valign="top"><strong>NOTE:</strong></td>
											      <td>You must type placeholders exactly as they appear above.</td>
											  </tr>
											</table>           
										 </td>
						              </tr>
						         </table>
							</td>	   
				        </tr>
                    </table>           
				</td>
			  </tr>
			  <tr>
	             <td colspan="2"><input type="submit" name="submit" value="Update Confirmation Letter >>"></td>
	          </tr>
	       </table>  
	   </cfoutput>
	</cfform>         
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
