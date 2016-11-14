<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<!----------------------------------------------------------------------------
	venu_Summary.cfm
	Displays search results of venue_Select.cfm 
	
	11/15/02 - Matt Eaves -  Initial code.
------------------------------------------------------------------------------
--->
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Venue Summary" showCalendar="0">


<!--- Pulls venue info based on info selected from previous form --->
<cfquery name="GetVenue" DATASOURCE="#application.speakerDSN#">
	SELECT venue_name, venue_type, venue_address1, venue_address2, venue_city, venue_state, venue_zip, venue_phone, venue_contact
	FROM venues
	WHERE 
	<cfif #form.radiobutton# EQ "both">
		venue_name LIKE '%#form.v_name#%' AND venue_city LIKE '%#form.v_city#%'
	<cfelseif #form.radiobutton# EQ "vname">
		venue_name LIKE '%#form.v_name#%'
	<cfelseif #form.radiobutton# EQ "city">
		venue_city LIKE '%#form.v_city#%'
	</cfif>
</cfquery>
<br>
<div>
<strong style="font-family:tahoma, verdana, arial; font-size:12px; color:#CC0011;">Venue's with
<cfoutput>
	<cfif #form.radiobutton# EQ "both">
		names containing "#form.v_name#" and cities containing "#form.v_city#"
	<cfelseif #form.radiobutton# EQ "vname">
		names containing "#form.v_name#"
	<cfelseif #form.radiobutton# EQ "city">
		cities containing "#form.v_city#"
	</cfif>
</cfoutput></strong>
<div align="right">
<strong><a href="/search/dsp_searchvenue.cfm"> << Search again.</a></strong>
</div>
</div>
<br><br><br>
<table border="0" cellpadding="5" cellspacing="1" width="99%" bgcolor="#666666">
	<tr bgcolor="#444444">
		<td><strong style="color:#ffffff;">Name</strong></td>
		<td><strong style="color:#ffffff;">Address</strong></td>
		<td><strong style="color:#ffffff;">City</strong></td>
		<td><strong style="color:#ffffff;">State</strong></td>
		<td><strong style="color:#ffffff;">Zip</strong></td>
		<td><strong style="color:#ffffff;">Phone</strong></td>
		<td><strong style="color:#ffffff;">Contact</strong></td>
	</tr>
	<cfif GetVenue.recordcount>
		<cfoutput query="GetVenue">
			<tr <cfif getvenue.currentrow MOD(2) EQ 1>bgcolor="##eeeeee"<cfelse>bgcolor="##ffffff"</cfif>>
				<td>#GetVenue.venue_name#&nbsp;</td>
				<td>#GetVenue.venue_address1# #GetVenue.venue_address2#&nbsp;</td>
				<td>#GetVenue.venue_city#&nbsp;</td>
				<td>#GetVenue.venue_state#&nbsp;</td>
				<td>#GetVenue.venue_zip#&nbsp;</td>
				<td>#GetVenue.venue_phone#&nbsp;</td>
				<td>#GetVenue.venue_contact#&nbsp;</td>
			</tr>
		</cfoutput>
	<cfelse>
		<tr>
			<td><strong>No matches.  <a href="" onclick="javascript:history.back(-1);"></a>Please search again.</strong></td>
		</tr>
	</cfif>
	<tr bgcolor="#ffffff">
	   <td colspan="7"><strong><a href="/search/dsp_searchvenue.cfm"> << Search again.</a></strong></td>
	</tr>
</table>

<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

 