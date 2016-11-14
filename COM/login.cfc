<!---@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	Name         : Login
	Author       : Rich Sloan
	Created      : March 7, 2005
	Version		 : 1.0
	Last Updated : 
	History      : Created Component (rws 3/8/05)
	Purpose		 : Log users in and out of system
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--->
<cfcomponent displayname="login" hint="Must pass username and password">
  <!--------------------------- 
     Initialize the component 
	 --------------------------->
  <cffunction name="init" access="remote" returnType="boolean" output="false"
		hint="Initialize the Login">
		<cfset instance.construct = true>	
		<cfreturn true />	
  </cffunction>
  
  <!--------------------------- 
     Login in the user 
	 --------------------------->
  <cffunction access="remote" name="authenticate" output="false" returntype="query" 
        hint="Login user">
	    <cfset var username = arguments.username>
		<cfset var password = arguments.password>
		
		<cfquery name="getlogin" datasource="#Application.HourDayDSN#">
		  SELECT rowid, user_login, first_name, last_name, position, ulevel1, ulevel2, ulevel3, user_dept, email 
		  FROM user_id
		  WHERE user_login= <cfqueryparam value="#username#" cfsqltype="CF_SQL_VARCHAR"> 
		  AND password= <cfqueryparam value="#password#" cfsqltype="CF_SQL_VARCHAR">
	    </cfquery>
		<cfif GetLogin.recordcount GT 0>
			<cflock scope="session" timeout="5" type="EXCLUSIVE">
			  <cfset Session.UserInfo = GetLogin>
			  <cfset Session.IsLoggedIN = true>
			</cflock>
		</cfif>
		<cfreturn GetLogin />
  </cffunction>  
  <!--------------------------- 
     Logout the user 
	 --------------------------->
    <cffunction name="logout" access="remote" returntype="boolean" hint="Logout user">
	   <CFSET StructClear(#session#)>
		<cfreturn true />
  </cffunction>
</cfcomponent>