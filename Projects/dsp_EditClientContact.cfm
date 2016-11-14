<cfset GetStates = request.util.getStates()>
<cfset getContact = request.Project.getContactInfo(URL.ContactID)>
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Add New Secondary Client Contact">
<br>
<cfoutput>
	<table bgcolor="##000000" align="center" border="0" cellpadding="0" cellspacing="1" width="600">
	  <tr>
		<td bgcolor="##ffffff">
		    <table border="0" cellpadding="4" cellspacing="0" width="100%">
              <tr bgcolor="##666666">
			     <td colspan="2"><strong style="color:##ffffff;">Adding Secondary Contact for #Session.ClientCode#</strong></td>
			   </tr>
            </table>  
			<br>    
			<strong style="font-size:10px; color:##cc0000;">* Required Fields</strong>
			<cfform name="addcontact" action="act_MaintainContact.cfm?Action=Edit" method="POST">
			  <input type="hidden" name="ClientCode" value="#getContact.ClientCode#">
			  <input type="hidden" name="ContactID" value="#getContact.ContactID#">
			  
				<table border="0" cellpadding="4" cellspacing="2" bgcolor="##ffffff">
				   <tr>
				       <td><strong>Firstname:</strong> <strong style="font-size:10px; color:##cc0000;">*</strong></td>
					   <td><input type="text" name="firstname" value="#getContact.Firstname#" size="20" maxlength="50"></td>
				   </tr>
				   <tr>
				       <td><strong>Lastname:</strong> <strong style="font-size:10px; color:##cc0000;">*</strong></td>
					   <td><input type="text" name="lastname" value="#getContact.lastname#"size="20" maxlength="50"></td>
				   </tr>
				   <tr>
				       <td><strong>Title:</strong></td>
					   <td><input type="text" name="Title" size="25" value="#getContact.Title#" maxlength="75"></td>
				   </tr>
				   <tr>
				       <td><strong>Address:</strong></td>
					   <td><input type="text" name="addr1" size="25" value="#getContact.Addr1#" maxlength="50"></td>
				   </tr>
				   <tr>
				       <td><strong>Mailstop/Suite:</strong></td>
					   <td><input type="text" name="addr2" size="25" value="#getContact.Addr2#" maxlength="50"></td>
				   </tr>
				   <tr>
				       <td><strong>City:</strong></td>
					   <td><input type="text" name="City" size="20" value="#getContact.City#" maxlength="50"></td>
				   </tr>
				   <tr>
				       <td><strong>State:</strong></td>
					   <td><select name="State">
					         <option value="">-- Select One --</option>
							 <cfloop query="getStates">
							   <option value="#getStates.StateAbbr#" <cfif getContact.State EQ getStates.StateAbbr>Selected</cfif>>#getStates.StateAbbr#</option>
							 </cfloop>
						   </select>
					   </td>
				   </tr>
				   <tr>
				       <td><strong>ZipCode:</strong></td>
					   <td><input type="text" name="Zipcode" value="#getContact.ZipCode#" size="10" maxlength="10"></td>
				   </tr>
				   <tr>
				       <td><strong>Phone:</strong> <strong style="font-size:10px; color:##cc0000;">*</strong></td>
					   <td><input type="text" name="Phone" value="#getContact.Phone#" size="12" maxlength="14"> <font size="-2" color="##b9b9b9">(Format: 847-555-1212)</font></td>
				   </tr>
				   <tr>
				       <td><strong>Fax:</strong></td>
					   <td><input type="text" name="Fax" value="#getContact.Fax#"size="12" maxlength="14"></td>
				   </tr>
				   
				   <tr>
				       <td><strong>Mobile Phone:</strong></td>
					   <td><input type="text" name="Mobile" value="#getContact.Mobile#" size="12" maxlength="14"></td>
				   </tr>
				   <tr>
				       <td><strong>Email:</strong> <strong style="font-size:10px; color:##cc0000;">*</strong></td>
					   <td><input type="text" name="Email" value="#getContact.Email#" size="25" maxlength="75"> <font size="-2" color="##b9b9b9">(Format: jsmith@pharmakonllc.com)</font></td>
				   </tr>
				   <tr>
				     <td colspan="2">&nbsp;</td>
				   </tr>
				   <tr>
				     <td colspan="2" align="center"><input type="submit" name="submit" value="Update >>"></td>
				   </tr>
				</table>
			</cfform>
			<br>   
	    </td>
	  </tr>
	</table>   
</cfoutput>     
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">	