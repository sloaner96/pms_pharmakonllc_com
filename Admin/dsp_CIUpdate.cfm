<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Rep Update Program" showCalendar="0">
  <cfform name="upload" action="act_CIUpdate.cfm" method="POST" enctype="multipart/form-data">
	  <table border="0" cellpaddding="5" cellspacing="0" width="100%">
		    <tr>
		       <td>Use the form below to upload the Confirmed Invitee (CI) list.</td>
		    </tr>
			<tr>
			  <td>&nbsp;</td>
			</tr>
			<tr>
			  <td align="center">
			     <table border="0" cellpadding="6" cellspacing="0">
                   <tr>
                      <td><strong>Choose Application:</strong></td>
					  <td><strong>Choose Product Code:</strong></td>
                   </tr>
				   <tr> 
				      <td><select name="AppName">
					        <!--- <option value="">-- Select One --</option> --->
					        <option value="CI">CI Processing</option>
							<!--- <option value="REG">Registration</option>
							<option value="TI">Time</option>
							<option value="PO">Polling</option>
							<option value="QU">Questions</option>
							<option value="SU">Survey</option> --->
						  </select>
					  </td>
					  <td><select name="ProductCode">
					        <option value="">-- Select One --</option>
							<option value="GLEZX">GLEZX</option>
                            <option value="GLISC">GLISC</option>
                            <option value="GLESR">GLESR</option>
                            <option value="GLEGM">GLEGM</option>
                            <option value="GLIEF">GLIEF</option>
                            <option value="GLICY">GLICY</option>
                            <option value="GLIST">GLIST</option>
						  </select>
					  </td>
				   </tr>
                 </table>           
			  </td>
			</tr>
			<tr>
			  <td align="center">
			    <table border="0" cellpadding="3" cellspacing="0">
                  <tr >
			        <td><strong>Upload File:</strong><br><font size="-2">(.xls or .csv)</font></td>
			        <td valign="top"><input type="file" name="repfile" size="30"></td>
			      </tr>
               </table>           
			  </td>
			</tr>
			<tr>
			  <td align="center"><input type="submit" name="submit" value="Upload File >>"></td>
			</tr>
	   </table>
   </cfform>            
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">