<cfsilent>
<cfparam name="url.e" default="0">
</cfsilent>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Pharmakon, LLC. Project Management System</title>
<link rel="stylesheet" href="/includes/styles/main.css" type="text/css" />
</head>

<body>
<br><br>
<table border="0" cellpadding="3" cellspacing="0" width="100%">
   <tr>
       <td align="center">
	      <table border="0" cellpadding="0" cellspacing="0" width="368">
   			<tr>
       			<td><img src="/Images/Login_head.jpg" alt="Welcome to Pharmakon, LLC Project Management System" width="369" height="78" border="0"></td>
            </tr>
			<tr>
			   <td>
			       <table cellpadding="0" cellspacing="0" width="368" style="border: 1px solid #6D8C94;">
                     <tr>
                       <td><img src="/images/blank.gif" height="1" width="5" border="0"></td>
						<td align="center"><br><br>
						  <cfform name="login" action="/authenticate.cfm" method="POST">
							  <table border="0" cellpadding="3" cellspacing="0" width="100%" align="center">
								 <cfif url.e EQ 1>
								   <tr>
								      <td colspan=2 class="errorText">You must enter your username.</td>
								   </tr>
								 <cfelseif url.e EQ 2>
								   <tr>
								      <td colspan=2 class="errorText">You must enter your password.</td>
								   </tr>
								 <cfelseif url.e EQ 3>
								   <tr>
								      <td colspan=2 class="errorText">We were not able to log you into the PMS system using the credentials you provided.</td>
								   </tr>
								 </cfif>
								 <tr>
								   <td align="center">
								      <table border="0" cellpaddding="4" cellspacing="0">
                                         <tr>
											<td><img src="/Images/Login_userid.gif"></td>
											<td><cfinput type="text" name="username" value="" size="24" required="Yes" Message="You must include your userid to login" passthrough="style='font-size:11px; font-face:verdana; width: 150px;'"></td>
										 </tr>
										  <tr>
											<td><img src="/Images/Login_password.gif"></td>
											<td><cfinput type="password" name="password" value="" size="24" required="Yes" Message="You must include your userid to login" passthrough="style='font-size:11px; font-face:verdana; width: 150px;'"></td>
										 </tr>
										 <tr>
										   <td colspan="2"><input name="submit" type="image" onMouseOver="this.src='/images/btn_login_on.jpg'" onMouseOut="this.src='/images/btn_login_off.jpg'" value="submit" src="/Images/btn_login_off.jpg" alt="Login" align="right" ></td>
										 </tr>
										 <tr>
										   <td>&nbsp;</td>
										 </tr>
										 <tr>
										   <td colspan=2><a href="mailto:Support@pharmakonllc.com?subject=PMS Login" style="font-family:Verdana, Arial, Helvetica, sans-serif;font-size:10px; color:#000099;">Did You Forget Your Password?</a></td>
										 </tr>
                                      </table>
								   </td>
								 </tr>
							  </table>
						  </cfform>
						</td>
						<td><img src="/images/blank.gif" height="1" width="5" border="0"></td>
                     </tr>
					 <!--- <tr>
					   <td valign="top" background="/Images/Login_Bottom.gif" colspan="3"></td>
					 </tr> --->
                   </table>
			   </td>
			</tr>
          </table>
		  <table border="0" cellpadding="0" cellspacing="0" width="368" align="center">
            <tr>
              <td class="footer" align="left">Pharmakon, a PDI Company &copy; 2006</td>
            </tr>
          </table>
	   </td>
   </tr>

</table>
<br><br>
</body>
</html>
