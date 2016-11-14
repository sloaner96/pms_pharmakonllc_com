<cfsilent>
<cfparam name="Attributes.inputname" default="button1">
<cfparam name="Attributes.htmlid" default="button1">
<cfparam name="Attributes.formvalue" default="">
<cfparam name="Attributes.imgid" default="button1">
</cfsilent>
<cfoutput>
<input type="text" 
	   name="#Attributes.inputname#" 
	   id="#Attributes.htmlid#" 
	   style="font-size:11px;" 
	   value="#Attributes.formvalue#" 
	   size="10" 
	   maxlength="10">&nbsp;
<img src="/images/btn_formcalendar.gif" 
	 id="#Attributes.imgid#" 
	 border="0" 
	 alt="Click to view calendar" 
	 onclick="Calendar.setup({inputField:'#Attributes.htmlid#' ,ifFormat:'%m/%d/%Y',showsTime:false,button:'#Attributes.imgid#',singleClick:true,step:1})">
</cfoutput>