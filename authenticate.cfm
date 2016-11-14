
<!--- Error Check the Form Variables --->
  <cfif Len(trim(form.username)) EQ 0>
    <cflocation url="login.cfm?e=1" addtoken="NO">
  </cfif>
  <cfif Len(trim(form.password)) EQ 0>
    <cflocation url="login.cfm?e=2" addtoken="NO">
  </cfif>

<!--- Initiate the Login CFC --->
<cfset thislogin = createobject("component", "pms.com.login").init()>
 
<!--- Call Login.cfc to authenticate the user --->
<cfinvoke 
   component="pms.com.login" 
   method="authenticate" 
   returnvariable="IsLoggedIN"> 

   <cfinvokeargument name="username" value="#form.username#">
   <cfinvokeargument name="password" value="#form.password#">
 </cfinvoke> 
 
 
<!---   <cfif form.username NEQ "rsloan">
    <cflocation url="tempPage.cfm" addtoken="NO">
	
  </cfif> --->
 <!--- Check Return Variable and either send to index.cfm or go back to  --->
 <cfif IsLoggedIN.recordcount GT 0>
  <cfset session.user = '#form.username#'>
    <cflocation url="index.cfm" addtoken="NO">
 <cfelse>
    <cflocation url="login.cfm?e=3" addtoken="NO">
 </cfif> 