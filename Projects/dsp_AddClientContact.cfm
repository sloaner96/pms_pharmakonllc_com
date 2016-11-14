<cfset GetStates = request.util.getStates()>

<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Adding Secondary Contact for #Session.ClientCode#">
<br>
<cfoutput>

			    
			
			<br>    
			
			<cfform name="addcontact" action="act_MaintainContact.cfm?Action=Add" method="POST">
			  <input type="hidden" name="ClientCode" value="#URL.CC#">
				<table border="0" cellpadding="4" cellspacing="2" bgcolor="##ffffff" align="center">
				   <tr>
				     <td colspan="2"><strong style="font-size:10px; color:##cc0000;">* Required Fields</strong></td>
				   </tr>
				   <tr>
				       <td><strong>Firstname:</strong> <strong style="font-size:10px; color:##cc0000;">*</strong></td>
					   <td><cfinput type="text" name="firstname" size="20" maxlength="50" required="yes" message="You must include a firstname"></td>
				   </tr>
				   <tr>
				       <td><strong>Lastname:</strong> <strong style="font-size:10px; color:##cc0000;">*</strong></td>
					   <td><cfinput type="text" name="lastname" size="20" maxlength="50" required="yes" message="You must include a lastname"></td>
				   </tr>
				   <tr>
				       <td><strong>Title:</strong></td>
					   <td><input type="text" name="Title" size="25" maxlength="75"></td>
				   </tr>
				   <tr>
				       <td><strong>Address:</strong></td>
					   <td><input type="text" name="addr1" size="25" maxlength="50"></td>
				   </tr>
				   <tr>
				       <td><strong>Mailstop/Suite:</strong></td>
					   <td><input type="text" name="addr2" size="25" maxlength="50"></td>
				   </tr>
				   <tr>
				       <td><strong>City:</strong></td>
					   <td><input type="text" name="City" size="20" maxlength="50"></td>
				   </tr>
				   <tr>
				       <td><strong>State:</strong></td>
					   <td><select name="State">
					         <option value="">-- Select One --</option>
							 <cfloop query="getStates">
							   <option value="#StateAbbr#">#StateAbbr#</option>
							 </cfloop>
						   </select>
					   </td>
				   </tr>
				   <tr>
				       <td><strong>ZipCode:</strong></td>
					   <td><input type="text" name="Zipcode" size="10" maxlength="10"></td>
				   </tr>
				   <tr>
				       <td><strong>Phone:</strong> <strong style="font-size:10px; color:##cc0000;">*</strong></td>
					   <td><cfinput type="text" name="Phone" size="12" maxlength="14" required="yes" message="You must include a Phone Number"> <font size="-2" color="##b9b9b9">(Format: 847-555-1212)</font></td>
				   </tr>
				   <tr>
				       <td><strong>Fax:</strong></td>
					   <td><input type="text" name="Fax" size="12" maxlength="14"></td>
				   </tr>
				   
				   <tr>
				       <td><strong>Mobile Phone:</strong></td>
					   <td><input type="text" name="Mobile" size="12" maxlength="14"></td>
				   </tr>
				   <tr>
				       <td><strong>Email:</strong> <strong style="font-size:10px; color:##cc0000;">*</strong></td>
					   <td><cfinput type="text" name="Email" size="25" maxlength="75" required="yes" message="You must include an email address"> <font size="-2" color="##b9b9b9">(Format: jsmith@pharmakonllc.com)</font></td>
				   </tr>
				   <tr>
				     <td colspan="2">&nbsp;</td>
				   </tr>
				   <tr>
				     <td colspan="2" align="center"><input type="submit" name="submit" value="Save >>"></td>
				   </tr>
				</table>
			</cfform>
			<br>     
</cfoutput>     
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">					 