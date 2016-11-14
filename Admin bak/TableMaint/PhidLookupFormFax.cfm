<cfform name="Phidlookup" action="dsp_FaxLookup.cfm?##Edit" method="POST">
	    <input type="hidden" name="Lookup" value="1">
		  <table border="0" cellpadding="4" cellspacing="0" width="100%" align="center">
			<tr>
			   <td align="center" class="PhidLookupTable">Use the form below to lookup a physician by PHID number. Once we have found the physician, you can change or mark their fax number as authorized</td>
			</tr>
			<tr>
		       <td align="center">    
			      <table border="0" cellpadding="0" cellspacing="1" bgcolor="#000000" width="400">
					 <tr>
					    <td bgcolor="#ffffff">
						   <table border="0" cellpadding="4" cellspacing="0" width="100%">
						     <tr>
			                   <td align="center" colspan="2"><strong style="color:#003366;font-family:arial;font-size:14px;">Lookup Physician Fax</strong></td>
			                 </tr>
							 <tr>
							   <td colspan="2"><hr noshade size="1"></td>
							 </tr>
							 <tr>
				                <td valign="middle" width="15%"><strong>Enter Phid Number:</strong></td>
								<td valign="middle"><input type="text" name="Phid" value=""></td>
				             </tr>
							 <tr>
							   <td><strong style="color:#ff0000;">OR</strong></td>
							 </tr>
							 <tr>
							   <td colspan="2">
							      <table border="0" cellpadding="4" cellspacing="0">
                                      <tr>
                                        <td><strong>FirstName:</strong></td>
										<td><input type="text" name="LkupFname" value="" size="20" maxlength="100"></td>
                                      </tr>
									  <tr>
                                        <td><strong>LastName:</strong></td>
										<td><input type="text" name="LkupLname" value="" size="20" maxlength="100"></td>
                                      </tr>
									  <tr>
			                             <td><strong>ZipCode:</strong></td>
										 <td><input type="text" name="LkUpZip" value="" size="10" maxlength="10"></td>
			                          </tr>
									  <!--- <tr>
									     <td><strong>Fax Number:</strong></td>
										 <td><input type="text" name="LkUpFax" value="" size="20" maxlength="20"></td>
									  </tr> --->
                                  </table>           
							   </td>
							 </tr>
							 <tr>
							   <td>&nbsp;</td>
							 </tr>
							 <tr>
							    <td colspan="2" align="center"><input type="submit" name="submit" value="Lookup >>"></td>
							 </tr>
						   </table>           
						</td>
					 </tr>  
		          </table>           
			   </td>
		    </tr>
		  </table>  
	  </cfform>