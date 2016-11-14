
<cfset loggedout = createobject("component", "pms.com.login").logout()>
<cflocation url="/login.cfm" addtoken="NO">
