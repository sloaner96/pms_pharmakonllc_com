<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Healthcare Discussions Document Admin: Add Document" showCalendar="0">
 
	   <cfform name="Addmat" action="act_AdminCreative.cfm?Action=ADD" Method="POST" enctype="multipart/form-data"> 
	     <cfoutput><input type="hidden" name="ProjectID" value="#URL.PID#"></cfoutput>
		 <table border="0" cellpadding="4" cellspacing="0" align="center" style="font-family:arial; font-size:11px;">
		     <tr>
			   <td colspan="2">Use the form below to add a new document to the healthcare discussions website.</td>
			 </tr>
			 <tr>
			   <td colspan="2" style="font-family:verdana; font-size:10px; color:#CC0000;">* Required Fields</td>
			 </tr>
			 <tr>
		        <td><sup style="font-family:verdana; font-size:10px; color:#CC0000;">*</sup> <strong>Document Title:</strong></td>
				<td><input type="text" name="MatTitle" value="" size="35" maxlength="175"></td>
		     </tr>
			 <tr>
		        <td><sup style="font-family:verdana; font-size:10px; color:#CC0000;">*</sup> <strong>Material Type:</strong></td>
				<td><select name="MatType">
				      <option value="A">Admin</option>
					  <option value="M">Moderator</option>
					  <option value="G">GuideBook</option>
					</select>
				</td>
		     </tr>
			 <tr>
		        <td><sup style="font-family:verdana; font-size:10px; color:#CC0000;">*</sup> <strong>File to Upload:</strong></td>
				<td><input type="file" name="FileToLoad" size="15"> <strong style="color:#CC0000;">(*PDF ONLY)</strong></td>
		     </tr>
			 <tr>
		        <td colspan="2"><strong>Material Description:</strong><br>
				  <textarea name="MaterialDesc" rows="10" cols="55"></textarea>
				</td>
		     </tr>
			 <tr>
			   <td colspan="2" align="center"><input type="submit" name="submit" value="Add Material >>"></td>
			 </tr>
		  </table> 
		 </cfform> 
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
