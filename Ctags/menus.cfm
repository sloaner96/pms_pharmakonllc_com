<script language="JavaScript">
<!--
function mmLoadMenus() {
  if (window.mm_menu_0309135207_0) return;
  
  
  window.mm_menu_0309135207_0 = new Menu("root",140,16,"Verdana, Arial, Helvetica, sans-serif",10,"#000000","#ffffff","#8ba3a9","#cecfa9","left","middle",3,0,1000,-5,7,true,false,true,0,true,true);
  mm_menu_0309135207_0.addMenuItem("Inbox","window.open('/Index.cfm', '_self');");  
  mm_menu_0309135207_0.addMenuItem("Add&nbsp;New&nbsp;Client&nbsp;Code","window.open('/Projects/dsp_AddClientCode.cfm', '_self');");
  mm_menu_0309135207_0.addMenuItem("Add&nbsp;New&nbsp;Project","window.open('/Projects/dsp_addProject.cfm', '_self');");
  mm_menu_0309135207_0.addMenuItem("Work&nbsp;on&nbsp;a&nbsp;Project","window.open('/Projects/dsp_WorkOnProject.cfm', '_self');");
  mm_menu_0309135207_0.addMenuItem("Add&nbsp;Project&nbsp;Notes","window.open('/Projects/NotesSelect.cfm', '_self');");  
  mm_menu_0309135207_0.addMenuItem("View&nbsp;Client&nbsp;Information","window.open('/Projects/dsp_ClientView.cfm', '_self');");
   mm_menu_0309135207_0.hideOnMouseOut=true;
   mm_menu_0309135207_0.menuBorder=0;
   mm_menu_0309135207_0.menuLiteBgColor='#ffffff';
   mm_menu_0309135207_0.menuBorderBgColor='#555555';
   mm_menu_0309135207_0.bgColor='#555555';
   
   
  window.mm_menu_0309140501_1 = new Menu("root",107,16,"Verdana, Arial, Helvetica, sans-serif",10,"#000000","#ffffff","#8ba3a9","#cecfa9","left","middle",3,0,1000,-5,7,true,false,true,0,true,true);
  mm_menu_0309140501_1.addMenuItem("Speaker&nbsp;Search","window.open('/search/dsp_searchSpeaker.cfm', '_self');");
  mm_menu_0309140501_1.addMenuItem("Moderator&nbsp;Search","window.open('/search/dsp_searchMod.cfm', '_self');");
   mm_menu_0309140501_1.hideOnMouseOut=true;
   mm_menu_0309140501_1.menuBorder=0;
   mm_menu_0309140501_1.menuLiteBgColor='#ffffff';
   mm_menu_0309140501_1.menuBorderBgColor='#555555';
   mm_menu_0309140501_1.bgColor='#555555';
  window.mm_menu_0309140733_2 = new Menu("root",170,16,"Verdana, Arial, Helvetica, sans-serif",10,"#000000","#ffffff","#8ba3a9","#cecfa9","left","middle",3,0,1000,-5,7,true,false,true,0,true,true);


mm_menu_0309140733_2.addMenuItem("Scheduling&nbsp;Main&nbsp;Page","location='/Schedule/main.cfm'");  
   mm_menu_0309140733_2.hideOnMouseOut=true;
   mm_menu_0309140733_2.menuBorder=0;
   mm_menu_0309140733_2.menuLiteBgColor='#ffffff';
   mm_menu_0309140733_2.menuBorderBgColor='#555555';
   mm_menu_0309140733_2.bgColor='#555555';
   
  window.mm_menu_0309141142_3 = new Menu("root",116,16,"Verdana, Arial, Helvetica, sans-serif",10,"#000000","#ffffff","#8ba3a9","#cecfa9","left","middle",3,0,1000,-5,7,true,false,true,0,true,true);
  mm_menu_0309141142_3.addMenuItem("Speaker&nbsp;Search","location='/search/dsp_searchSpeaker.cfm'");
  mm_menu_0309141142_3.addMenuItem("Speaker&nbsp;Schedules","location='/reports/report_modspkr_calendar.cfm'");
  mm_menu_0309141142_3.addMenuItem("Add&nbsp;New&nbsp;Speaker","location='/speakers/dsp_AddSpeaker.cfm'");
  //mm_menu_0309141142_3.addMenuItem("Remove&nbsp;Speaker","location='/speakers/dsp_RemoveSpeaker.cfm'");
   mm_menu_0309141142_3.hideOnMouseOut=true;
   mm_menu_0309141142_3.menuBorder=0;
   mm_menu_0309141142_3.menuLiteBgColor='#ffffff';
   mm_menu_0309141142_3.menuBorderBgColor='#555555';
   mm_menu_0309141142_3.bgColor='#555555';
   
  window.mm_menu_0309141305_4 = new Menu("root",126,16,"Verdana, Arial, Helvetica, sans-serif",10,"#000000","#ffffff","#8ba3a9","#cecfa9","left","middle",3,0,1000,-5,7,true,false,true,0,true,true);
  mm_menu_0309141305_4.addMenuItem("Moderator&nbsp;Search","location='/search/dsp_searchMod.cfm'");
  mm_menu_0309141305_4.addMenuItem("Moderator&nbsp;Schedules","location='/reports/report_modspkr_calendar.cfm'");
   mm_menu_0309141305_4.hideOnMouseOut=true;
   mm_menu_0309141305_4.menuBorder=0;
   mm_menu_0309141305_4.menuLiteBgColor='#ffffff';
   mm_menu_0309141305_4.menuBorderBgColor='#555555';
   mm_menu_0309141305_4.bgColor='#555555';
   
  window.mm_menu_0309141953_5 = new Menu("root",86,16,"Verdana, Arial, Helvetica, sans-serif",10,"#000000","#ffffff","#8ba3a9","#cecfa9","left","middle",3,0,1000,-5,7,true,false,true,0,true,true);
  mm_menu_0309141953_5.addMenuItem("Venue&nbsp;Search","location='/search/dsp_SearchVenue.cfm'");
   mm_menu_0309141953_5.hideOnMouseOut=true;
   mm_menu_0309141953_5.menuBorder=0;
   mm_menu_0309141953_5.menuLiteBgColor='#ffffff';
   mm_menu_0309141953_5.menuBorderBgColor='#555555';
   mm_menu_0309141953_5.bgColor='#555555';
   
    window.mm_menu_0309142106_6_1 = new Menu("Project&nbsp;Reports",89,16,"Verdana, Arial, Helvetica, sans-serif",10,"#000000","#ffffff","#8ba3a9","#cecfa9","left","middle",3,0,1000,-5,7,true,false,true,0,true,true);
    mm_menu_0309142106_6_1.addMenuItem("PIW&nbsp;Reports");
    mm_menu_0309142106_6_1.addMenuItem("PIL&nbsp;Reports");
    mm_menu_0309142106_6_1.addMenuItem("Product&nbsp;List");
     mm_menu_0309142106_6_1.hideOnMouseOut=true;
     mm_menu_0309142106_6_1.menuBorder=0;
     mm_menu_0309142106_6_1.menuLiteBgColor='#ffffff';
     mm_menu_0309142106_6_1.menuBorderBgColor='#555555';
     mm_menu_0309142106_6_1.bgColor='#555555';
	 
    window.mm_menu_0309142106_6_2 = new Menu("Financial&nbsp;Reports",165,16,"Verdana, Arial, Helvetica, sans-serif",10,"#000000","#ffffff","#8ba3a9","#cecfa9","left","middle",3,0,1000,-5,7,true,false,true,0,true,true);
    mm_menu_0309142106_6_2.addMenuItem("Check&nbsp;Requests");
    mm_menu_0309142106_6_2.addMenuItem("Paid&nbsp;Check&nbsp;Requests");
    mm_menu_0309142106_6_2.addMenuItem("Unpaid&nbsp;Check&nbsp;Requests");
    mm_menu_0309142106_6_2.addMenuItem("Honoraria&nbsp;Tracking");
    mm_menu_0309142106_6_2.addMenuItem("Honoraria&nbsp;Aging&nbsp;Report");
    mm_menu_0309142106_6_2.addMenuItem("Speaker&nbsp;Payments");
    mm_menu_0309142106_6_2.addMenuItem("Speaker&nbsp;Payment&nbsp;Aging");
    mm_menu_0309142106_6_2.addMenuItem("Moderator&nbsp;Financial&nbsp;Reports");
    mm_menu_0309142106_6_2.addMenuItem("P.O.&nbsp;Summary");
    mm_menu_0309142106_6_2.addMenuItem("Billing&nbsp;vs.&nbsp;Budget");
     mm_menu_0309142106_6_2.hideOnMouseOut=true;
     mm_menu_0309142106_6_2.menuBorder=0;
     mm_menu_0309142106_6_2.menuLiteBgColor='#ffffff';
     mm_menu_0309142106_6_2.menuBorderBgColor='#555555';
     mm_menu_0309142106_6_2.bgColor='#555555';
	 
    window.mm_menu_0309142106_6_3 = new Menu("Scheduling&nbsp;Reports",165,16,"Verdana, Arial, Helvetica, sans-serif",10,"#000000","#ffffff","#8ba3a9","#cecfa9","left","middle",3,0,1000,-5,7,true,false,true,0,true,true);
    mm_menu_0309142106_6_3.addMenuItem("Meeting&nbsp;Counts&nbsp;Report","location='/reports/report_mcounts.cfm'");
    mm_menu_0309142106_6_3.addMenuItem("Weekly&nbsp;Report","location='/reports/report_weekly.cfm'");
    mm_menu_0309142106_6_3.addMenuItem("Listen-Ins&nbsp;Report","location='/reports/report_listen_ins.cfm'");
    mm_menu_0309142106_6_3.addMenuItem("Trainee&nbsp;Report","location='/reports/report_trainees.cfm'");
    mm_menu_0309142106_6_3.addMenuItem("Unavailable&nbsp;Report","location='/reports/report_unavailable.cfm'");
    mm_menu_0309142106_6_3.addMenuItem("TBDs&nbsp;Report","location='/reports/report_TBD.cfm'");
    mm_menu_0309142106_6_3.addMenuItem("Cancelled&nbsp;Meetings","location='/reports/report_cancelled.cfm'");
    mm_menu_0309142106_6_3.addMenuItem("Meetings&nbsp;per&nbsp;Moderator","location='/reports/report_mod_mtgs.cfm'");    mm_menu_0309142106_6_3.addMenuItem("Moderator&nbsp;Master&nbsp;Schedule","location='/reports/report_master_schedule.cfm'");
    mm_menu_0309142106_6_3.addMenuItem("Program&nbsp;Staff&nbsp;Report","location='/reports/report_meeting_staff.cfm'");
    mm_menu_0309142106_6_3.addMenuItem("Speaker&nbsp;Invoice","location='/reports/report_spkr_invoice.cfm'");    mm_menu_0309142106_6_3.addMenuItem("Moderator&nbsp;Fee&nbsp;Statement","location='/reports/report_moderator_fee.cfm'");
    mm_menu_0309142106_6_3.addMenuItem("Project&nbsp;Report","location='/reports/rpt_project.cfm'");
     mm_menu_0309142106_6_3.hideOnMouseOut=true;
     mm_menu_0309142106_6_3.menuBorder=0;
     mm_menu_0309142106_6_3.menuLiteBgColor='#ffffff';
     mm_menu_0309142106_6_3.menuBorderBgColor='#555555';
     mm_menu_0309142106_6_3.bgColor='#555555';
	 
    window.mm_menu_0309142106_6_4 = new Menu("Attendance&nbsp;Reports",153,16,"Verdana, Arial, Helvetica, sans-serif",10,"#000000","#ffffff","#8ba3a9","#cecfa9","left","middle",3,0,1000,-5,7,true,false,true,0,true,true);
    mm_menu_0309142106_6_4.addMenuItem("Attendance&nbsp;By&nbsp;Date");
    mm_menu_0309142106_6_4.addMenuItem("Client&nbsp;Attendance&nbsp;Reports");
    mm_menu_0309142106_6_4.addMenuItem("Attendance&nbsp;vs.&nbsp;Goals");
     mm_menu_0309142106_6_4.hideOnMouseOut=true;
     mm_menu_0309142106_6_4.menuBorder=0;
     mm_menu_0309142106_6_4.menuLiteBgColor='#ffffff';
     mm_menu_0309142106_6_4.menuBorderBgColor='#555555';
     mm_menu_0309142106_6_4.bgColor='#555555';
	 
  window.mm_menu_0309142106_6 = new Menu("root",125,16,"Verdana, Arial, Helvetica, sans-serif",10,"#000000","#ffffff","#8ba3a9","#cecfa9","left","middle",3,0,1000,-5,7,true,false,true,0,true,true);
  mm_menu_0309142106_6.addMenuItem(mm_menu_0309142106_6_3);  
   mm_menu_0309142106_6.hideOnMouseOut=true;
   mm_menu_0309142106_6.childMenuIcon="/images/arrows.gif";
   mm_menu_0309142106_6.menuBorder=0;
   mm_menu_0309142106_6.menuLiteBgColor='#ffffff';
   mm_menu_0309142106_6.menuBorderBgColor='#555555';
   mm_menu_0309142106_6.bgColor='#555555';
  window.mm_menu_0309143331_7 = new Menu("root",134,16,"Verdana, Arial, Helvetica, sans-serif",10,"#000000","#ffffff","#8ba3a9","#cecfa9","left","middle",3,0,1000,-5,7,true,false,true,0,true,true);

mm_menu_0309143331_7.addMenuItem("Availabilty Admin","location='/admin/unavailable.cfm'");
   mm_menu_0309143331_7.hideOnMouseOut=true;
   mm_menu_0309143331_7.menuBorder=0;
   mm_menu_0309143331_7.menuLiteBgColor='#ffffff';
   mm_menu_0309143331_7.menuBorderBgColor='#555555';
   mm_menu_0309143331_7.bgColor='#555555';

  mm_menu_0309143331_7.writeMenus();
} // mmLoadMenus()

//-->
</script>
<script language="JavaScript1.2" src="/mm_menu.js"></script>

