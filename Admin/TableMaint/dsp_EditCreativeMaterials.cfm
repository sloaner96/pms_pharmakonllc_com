
<cfparam name="url.MaterialID" default="0" type="numeric">
<cfobject name="CreativeInfo" component="pms.com.CreativeInfo">
<cfset MaterialInfo = CreativeInfo.getMaterialFiles(URL.MaterialID)>

<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Update Program Materials" showCalendar="0">
 

	 <cfoutput>
	   <cfform name="Updmat" action="act_AdminCreative.cfm?Action=Update" Method="POST" enctype="multipart/form-data"> 
		 <input type="hidden" name="MaterialID" value="#URL.MaterialID#">
		 <input type="hidden" name="ProjectCode" value="#URL.PID#">
		 <table border="0" cellpadding="4" cellspacing="0" align="center" style="font-family:arial; font-size:11px;">
		     <tr>
			   <td colspan="2">Use the form below to update program material on the healthcare discussions website.</td>
			 </tr>
			 <tr>
			   <td colspan="2" style="font-family:verdana; font-size:10px; color:##CC0000;">* Required Fields</td>
			 </tr>
			 <tr>
		        <td><sup style="font-family:verdana; font-size:10px; color:##CC0000;">*</sup> <strong>Document Title:</strong></td>
				<td><input type="text" name="MatTitle" value="#MaterialInfo.MaterialTitle#" size="35" maxlength="175"></td>
		     </tr>
			 <tr>
		        <td><sup style="font-family:verdana; font-size:10px; color:##CC0000;">*</sup> <strong>Material Type:</strong></td>
				<td><select name="MatType">
				      <option value="A" <cfif MaterialInfo.MaterialType EQ "A">Selected</cfif>>Admin</option>
					  <option value="M" <cfif MaterialInfo.MaterialType EQ "M">Selected</cfif>>Moderator</option>
					  <option value="G" <cfif MaterialInfo.MaterialType EQ "G">Selected</cfif>>GuideBook</option>
					</select>
				</td>
		     </tr>
			 <cfif MaterialInfo.FileName NEQ "">
			   <tr>
			     <td><strong>Current File:</strong></td>
			     <td><a href="act_getFile.cfm?doc=#MaterialInfo.MaterialID#" target="_blank">View Current Document</a></td>
			   </tr>
			 </cfif>
			 <tr>
		        <td><strong>NEW File to Upload:</strong></td>
				<td><input type="file" name="FileToLoad" size="15"> <strong style="color:##CC0000;">(*PDF ONLY)</strong></td>
		     </tr>
			 <tr>
		        <td colspan="2"><strong>Material Description:</strong><br>
				  <textarea name="MaterialDesc" rows="10" cols="55">#MaterialInfo.MaterialDesc#</textarea>
				</td>
		     </tr>
			 <tr>
			   <td colspan="2" align="center"><input type="submit" name="submit" value="Update Material >>"></td>
			 </tr>
		  </table> 
		 </cfform> 
		</cfoutput> 
                 

<cfmodule template="#Application.tagpath#/ctags/footer.cfm">