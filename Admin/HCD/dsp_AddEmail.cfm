<!---
    $Id: ,v 1.0 2005/12/21 rsloan Exp $
    Copyright (c) 2005 Pharmakon, LLC.

    Description: This is the Create a Email Page. It serves 2 functions, Create From Scratch the main information or Copy from an Existing.
        
--->

<!--- Initialize the object --->
  <cfobject name="CreativeInfo" component="pms.com.CreativeInfo">
  <cfobject name="ConfirmEmails" component="pms.com.ConfirmEmails">
				
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Create a New Confirmation Emails" showCalendar="1">
  <table border="0" cellpadding="4" cellspacing="0" width="100%">
    <tr>
       <td>The form below will allow you to create a new confirmation letter form scratch or copy an existing confirmation to work on.</td>
    </tr>
	<tr>
	  <td align="center">
	    <cfif NOT IsDefined("form.LetterMethod")>
	     <form name="thisform" value="dsp_CreateNew.cfm" Method="POST">
		     <table border="0" cellpadding="4" cellspacing="0">
	            <tr>
	               <td><strong>Choose a Method:</strong></td>
				   <td><select name="LetterMethod" onchange="this.form.submit();">
				         <option value="">-- Select One --</option>
						 <option value="0" <cfif isDefined("form.LetterMethod")><cfif form.LetterMethod EQ "0">Selected</cfif></cfif>>Create a New Confirmation Letter</option>
						 <option value="1" <cfif isDefined("form.LetterMethod")><cfif form.LetterMethod EQ "1">Selected</cfif></cfif>>Copy an Existing Confirmation Letter</option>
					   </select>
				   </td>
	            </tr>
	         </table> 
		 </form> 
		 </cfif>  
		 <cfif IsDefined("form.LetterMethod")>
            <table border="0" cellpadding="0" cellspacing="0" width="100%">
              <cfif form.LetterMethod EQ "0">
					
			     <!--- Get the Active and Accepted programs for the pulldown--->
				   <cfset getActivePrograms = CreativeInfo.GetActivePrograms()>
				  <tr>
	                <td>
					  <cfform name="addnew" action="act_createNew.cfm" method="POST">
					   <table border="0" cellpadding="4" cellspacing="0">
                          <tr>  
						     <td><strong>Select a Program:</strong></td>
                             <td align="left"><select name="PID" onchange="this.form.submit();">
							        <option value="">-- Select One --</option>
							       <cfoutput query="getActivePrograms"> 
								     <option value="#Trim(getActivePrograms.client_proj)#" <!--- <cfif Trim(getActivePrograms.client_proj) EQ Trim(ProgramID)>Selected</cfif> --->>#Trim(getActivePrograms.client_proj)#</option>
								   </cfoutput>
								 </select>
						     </td>
                          </tr>
						  
						  <tr>
						     <td><strong>Confirmation Email Title:</strong></td> 
                             <td align="left"><input type="text" name="EmailTitle" value="" size="40" maxlength="65"> <strong style="color:#777777; font-size:10px; font-family:arial; font-weight:normal;">(Internal Use)</strong></td>
                          </tr>
						  <tr>
						     <TD><strong>Begin Date:</strong></td>
							 <td align="left"><cfmodule template="#Application.tagpath#/ctags/calInput.cfm"
									  inputname="begin_date"
									  htmlID="begindate"
									  FormValue="#DateFormat(now(), 'mm/dd/yyyy')#"
									  imgid="begindatebtn">
							</tr>
							<tr>
							   <td><strong>End Date:</strong></td>
							   <td align="left"><cfmodule template="#Application.tagpath#/ctags/calInput.cfm"
										inputname="end_date"
										htmlID="enddate"
										FormValue="#DateFormat(dateadd('d',90 ,now()) , 'mm/dd/yyyy')#"
										imgid="enddatebtn">
							   </td>
						  </tr>
						  <tr>
                             <td colspan="2"><input type="submit" name="submit" value="Create Confirmation Letter"></td>
                          </tr>
						  
                       </table>  
					  </cfform>          
					</td>
	              </tr>
			  <cfelseif form.letterMethod EQ "1">
			     <cfset getAllProg = ConfirmEmails.getAllConfirmations()>
				 <!--- Get the Active and Accepted programs for the pulldown--->
				   <cfset getActivePrograms = CreativeInfo.GetActivePrograms()>
			      <tr>
	                <td>
					  <cfform name="dupconfirm" action="act_CreateDup.cfm" Method="POST">
						  <table border="1" cellpadding="4" cellspacing="0">
	                         <tr>
	                            <td><strong>Select a Program to Copy From:</strong></td>
								<td align="left"><select name="CopyID">
								      <cfoutput query="getAllProg">
								         <option value="#getAllProg.ConfirmID#">#getAllProg.ProjectCode#- #getAllProg.ConfirmTitle#</option>
									  </cfoutput>
									</select>
								</td>
	                         </tr>
							 
							 <tr>  
							     <td><strong>Select the Program Code:</strong></td>
	                             <td align="left"><select name="PID">
								        <option value="">-- Select One --</option>
								       <cfoutput query="getActivePrograms"> 
									     <option value="#Trim(getActivePrograms.client_proj)#">#Trim(getActivePrograms.client_proj)#</option>
									   </cfoutput>
									 </select>
							     </td>
	                          </tr>
							 <tr>
							     <td><strong>Confirmation Email Title:</strong></td> 
	                             <td align="left"><input type="text" name="EmailTitle" value="" size="40" maxlength="65"> <strong style="color:#777777; font-size:10px; font-family:arial; font-weight:normal;">(Internal Use)</strong></td>
	                          </tr> 
							 <tr>
						     <TD><strong>Begin Date:</strong></td>
							 <td align="left"><cfmodule template="#Application.tagpath#/ctags/calInput.cfm"
									  inputname="begin_date"
									  htmlID="begindate"
									  FormValue="#DateFormat(now(), 'mm/dd/yyyy')#"
									  imgid="begindatebtn">
							</tr>
							<tr>
							   <td><strong>End Date:</strong></td>
							   <td align="left"><cfmodule template="#Application.tagpath#/ctags/calInput.cfm"
										inputname="end_date"
										htmlID="enddate"
										FormValue="#DateFormat(dateadd('d',90 ,now()) , 'mm/dd/yyyy')#"
										imgid="enddatebtn">
							   </td>
						  </tr> 
							 <tr>
							   <td colspan="2"><input type="submit" name="submit" value="Copy & Create"></td>
							 </tr>
	                      </table>   
					  </cfform>        
					</td>
	              </tr>	  
			  <cfelse>
			      <tr>
	                <td></td>
	              </tr>		  
			  </cfif>
           </table>           
		 </cfif>       
	  </td>
	</tr>
  </table>                     
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
