<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Know Your Child</title>
<SCRIPT language="JavaScript" src="../../js/ServerPath.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../js/MenuRoller.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../js/Validation.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../js/Elements.js"></SCRIPT>
<script language="JavaScript" src="../../js/Calendar/Calendar.js"></script>

<script language="javascript">
function loadYearOfSession() {
	yearof_sess = document.main_Form.yearofsession.value;
	yearof_sess_split = yearof_sess.split("ô");
	//alert (yearof_sess);
	//alert (yearof_sess_split);
	if(yearof_sess != "")
	{

		if(yearof_sess != "null")
		{
			var optidx=1;
			for(mn=0;mn<yearof_sess_split.length;mn++) {
				sess_split = yearof_sess_split[mn].split("õ");
				sessionid = sess_split[0];
				session_str = sess_split[1];
				document.main_Form.course_session.options[optidx] = new Option(session_str,sessionid);
				optidx++;
			}
		}
	}
}

function openwin(req_courseid) {
	window.open("course_details.jsp?req_courseid="+req_courseid,"","top=0,left=0,tollbars=0.statusbar=0,menubar=0,locationbar=0,scrollbars=1,resizable=0,width=550,height=480");
}

function selectCourseSesssion(sessidx)
{
	if(check_ForParticularElements(document.main_Form.course_session,"select"))
	{
		document.main_Form.published.disabled = false;
		document.main_Form.course_session_id.value = sessidx.value;
		document.main_Form.course_session_name.value = sessidx.text;
	}
	else
		document.main_Form.published.disabled = true;
}

function deleteSession(){
	if(document.main_Form.course_session != null && document.main_Form.course_session.selectedIndex == 0){
		alert("Invalid year of session.");
		return false;
	}
	else if(document.main_Form.course_session == null){
		alert("Invalid year of session.");
		return false;
	}
	else{
		if(confirm("This will remove all the published courses [if found] under this session, Do you wish to delete ?")){
			document.main_Form.sessionid.value=document.main_Form.course_session.options[document.main_Form.course_session.selectedIndex].value;
			document.main_Form.action = "./DeleteYearofSession.jsp";
			document.main_Form.submit();
		}
		else{
			return false;
		}
	}
}

function addNewSession(seltype)
{
	document.main_Form.sessiontype.value = seltype;
	if(seltype == "AddNew")
	{
		//document.main_Form.course_session_id.value = null;


		session_getter_span.innerHTML = "<input type=text name='new_course_session' validate='Course Session' class=tablelight maxlength=50 size=29>&nbsp;[eg. <font color='red'>2006-2007</font>]<input type=button value='Exist Session' class=tablelight onclick=addNewSession('ExistSession');>";
		if(document.main_Form.check)
		{
			if(document.main_Form.check.length > 1)
			{
				for(km=0;km<document.main_Form.check.length;km++)
				{
					document.main_Form.check[km].checked = false;
					//date_span[km].innerText = "";
				}
			}
			else
			{
				document.main_Form.check.checked = false;
				//date_span.innerText = "";
			}
		}
	}
	else if(seltype == "ExistSession")
	{
		//document.main_Form.course_session_id.value = null;
		session_getter_span.innerHTML = "<select name='course_session' class='tablelight' validate='Course Session' onchange='selectCourseSesssion(document.main_Form.course_session.options[this.selectedIndex]);'><option>&nbsp;&nbsp; -- Select Year-- &nbsp;&nbsp;</option></select>&nbsp;<input type=button name='new_session' class=tableth value='New Session' onclick=addNewSession('AddNew');>&nbsp;<input type=button name='delete_session' class=tableth value='Delete Session' onclick=deleteSession('Delete');>&nbsp;<input type=button name='published' disabled class=tableth value='Published Course' onclick=addNewSession('PublishedCourse');>";
		loadYearOfSession();
	}
	else if(seltype == "PublishedCourse")
	{
		document.main_Form.sessionid.value=document.main_Form.course_session.options[document.main_Form.course_session.selectedIndex].value;
		document.main_Form.action = "./Coursepublished.jsp";
		document.main_Form.submit();
	}
}


var module_array = new Array();
function submitPublishCourse(entrytype)
{


	incval = 0;
	course_schedule = "";
	check_len = 0;
	checkflag = false;

	if(document.main_Form.check)
	{
		if(document.main_Form.check.length > 1)
		{
			for(m=0;m<document.main_Form.check.length;m++)
			{
				if(document.main_Form.check[parseInt(m)].checked)
				{
					check_len++;
				}
			}

			appissue_stdate = document.main_Form.serverdate_cal.value;
			lastdate = document.main_Form.lastdate.value;
			for(k=0;k<document.main_Form.check.length;k++)
			{
				if(document.main_Form.check[k].checked)
				{

					courseid = document.main_Form.check[k].value;
					//alert("courseid           "+courseid);
					sessionid = document.main_Form.course_session_id.value;
					stdate_chk = eval("document.main_Form.startdate"+parseInt(k+1));
					edate_chk = eval("document.main_Form.enddate"+parseInt(k+1));
					stdate = eval("document.main_Form.startdate"+parseInt(k+1)+".value");
					edate = eval("document.main_Form.enddate"+parseInt(k+1)+".value");
					noofseat = document.main_Form.check[parseInt(k)].getAttribute("noofseat");
					eligible = document.main_Form.check[parseInt(k)].getAttribute("eligible");

					if(check_ForParticularElements(stdate_chk,"text",edate_chk,"text"))
					{
					}
					else
					{

						return false;
					}

					if(incval == parseInt(check_len-1))
					{
                        if(document.main_Form.sessiontype.value == "AddNew")
                        	course_schedule += courseid+"õ"+stdate+"õ"+edate+"õ"+appissue_stdate+"õ"+lastdate+"õ"+noofseat+"õ"+eligible;
                        else if(document.main_Form.sessiontype.value == "ExistSession")
                        	course_schedule += sessionid+"õ"+courseid+"õ"+stdate+"õ"+edate+"õ"+appissue_stdate+"õ"+lastdate+"õ"+noofseat+"õ"+eligible;
					}
					else
					{
						if(document.main_Form.sessiontype.value == "AddNew")
							course_schedule += courseid+"õ"+stdate+"õ"+edate+"õ"+appissue_stdate+"õ"+lastdate+"õ"+noofseat+"õ"+eligible+"ô";
						else if(document.main_Form.sessiontype.value == "ExistSession")
							course_schedule += sessionid+"õ"+courseid+"õ"+stdate+"õ"+edate+"õ"+appissue_stdate+"õ"+lastdate+"õ"+noofseat+"õ"+eligible+"ô";
					}

					incval++;
					checkflag = true;
				}
			}
		}
		else
		{


			appissue_stdate = document.main_Form.serverdate_cal.value;
			lastdate = document.main_Form.lastdate.value;
			if(document.main_Form.check.checked)
			{
				courseid = document.main_Form.check.value;
				sessionid = document.main_Form.course_session_id.value;
				stdate = document.main_Form.startdate1.value;
				edate = document.main_Form.enddate1.value;
				noofseat = document.main_Form.check.getAttribute("noofseat");
				eligible = document.main_Form.check.getAttribute("eligible");
				if(check_ForParticularElements(document.main_Form.startdate1,"text",document.main_Form.enddate1,"text"))
				{}
				else
				{

					return false;
				}


				if(document.main_Form.sessiontype.value == "AddNew")
					course_schedule += courseid+"õ"+stdate+"õ"+edate+"õ"+appissue_stdate+"õ"+lastdate+"õ"+noofseat+"õ"+eligible;
				else if(document.main_Form.sessiontype.value == "ExistSession")
					course_schedule += sessionid+"õ"+courseid+"õ"+stdate+"õ"+edate+"õ"+appissue_stdate+"õ"+lastdate+"õ"+noofseat+"õ"+eligible;

				checkflag = true;
			}
		}
		if(document.main_Form.sessiontype.value == "AddNew")
		{
			if(check_ForParticularElements(document.main_Form.new_course_session,"text",document.main_Form.lastdate,"text"))
			{
				var split_new_course_session = document.main_Form.new_course_session.value.split("-");
				if(split_new_course_session.length == 2){
					if(isNaN(split_new_course_session[0])){
						alert("Invalid session");
						document.main_Form.new_course_session.focus();
						return false;
					}
					if(isNaN(split_new_course_session[1])){
						alert("Invalid session");
						document.main_Form.new_course_session.focus();
						return false;
					}

					if(parseInt(split_new_course_session[0]) < 1900){
						alert("Invalid session");
						document.main_Form.new_course_session.focus();
						return false;
					}

					if(parseInt(split_new_course_session[0]) > 9999){
						alert("Invalid session");
						document.main_Form.new_course_session.focus();
						return false;
					}

					if(parseInt(split_new_course_session[1]) > 9999){
						alert("Invalid session");
						document.main_Form.new_course_session.focus();
						return false;
					}

					if(parseInt(split_new_course_session[0]) > parseInt(split_new_course_session[1])){
						alert("Invalid session");
						document.main_Form.new_course_session.focus();
						return false;
					}
				}
				else{
					alert("Invalid session format.");
					document.main_Form.new_course_session.focus();
					return false;
				}
			}
			else
				return false;
		}
		else if(document.main_Form.sessiontype.value == "ExistSession")
		{
			if(check_ForParticularElements(document.main_Form.course_session,"text",document.main_Form.lastdate,"text"))
			{}
			else
			{

				return false;
			}
		}

		if(checkflag)
		{
 			document.main_Form.courseids.value = course_schedule;
			//alert("=========     "+document.main_Form.courseids.value);


			document.main_Form.action = "./course_session_schedule_submit.jsp";
			document.main_Form.submit();
		}
		else
			alert("Select the course.");
	}
	else
	{
		alert("Course not found.");
	}
}



function callCalendar(datefield,idval,validatable_date)
{
	calflag = false;
	validate_date = "";
	datefld = "main_Form."+datefield+idval;
	valid_fld = eval("document.main_Form."+validatable_date+idval);
	if(idval >= 2)
	{
		ididx = parseInt(idval - 1);
		if(datefield == "startdate")
		{
			status = "Not_Less_Than_CurrentDate";
			//validate_date = eval("document.main_Form.enddate"+ididx);
			validate_date = document.main_Form.serverdate_cal;
			calflag = true;
		}
		if(datefield == "enddate")
		{
			if(check_ForParticularElements(valid_fld,"text"))
			{
				status = "Not_Less_Than_StartDate";
				validate_date = eval("document.main_Form.startdate"+idval);
				calflag = true;
			}
		}
	}
	else
	{
		if(datefield == "enddate")
		{
			if(check_ForParticularElements(document.main_Form.startdate1,"text"))
			{
				status = "Not_Less_Than_StartDate";
				validate_date = eval("document.main_Form."+validatable_date+idval);
				calflag = true;
			}
		}
		else
		{
			status = "Not_Less_Than_CurrentDate";
			validate_date = document.main_Form.serverdate_cal;
			calflag = true;
		}
	}

	if(calflag)
		Calendar_Fun('../../js/Calendar/CalendarWindow.html',datefld,'0',event,status,validate_date)
}


function loadCourses(type_value)
{
	if(type_value != "both")
	{
		document.main_Form.category.value = type_value;
		document.main_Form.action = "./Coursepublish.jsp";
		document.main_Form.submit();
	}
}
function cListFun()
{
	document.main_Form.action = "FullCourseList.jsp";
	document.main_Form.submit();
}
function aListFun()
{
	document.main_Form.action = "Alloted_course_list.jsp";
	document.main_Form.submit();
}

function sListFun()
{
	document.main_Form.action = "SemesterFullCourseList.jsp";
	document.main_Form.submit();
}
</script>
</head>

<body onLoad="loadYearOfSession()" bgcolor="#2B303E" topmargin="0" bottommargin="0">

  <table align="center" border="0" width="710" height="100%" bgcolor="#FFFFFF" cellspacing="0" cellpadding="0">
<!--         ******************************        Header         ******************************           -->
<tr valign="top">
<td vAlign="top">
<table align="center" border="0" width="710" height="495" bgcolor="#FFFFFF" cellspacing="0" cellpadding="0">

    <!--  
    <tr valign="top">
      <td valign="top">Banner.jsp</td>
    </tr>
    -->
	<tr vAlign="top">
		<td vAlign="top">
		<table border="0" width="100%" cellspacing="0" cellpadding="0">
		<!-- <tr>
			<td>Menu.jsp</td>
		</tr> -->
		<tr>
			<td vAlign="top">
      <!-- Start -->


<BODY leftmargin=0 topmargin=0>
<!--  BODY CONTENT TABLE  START  -->
        <TABLE class=tableBody_border align=center width=100% height=95%  cellspacing=0 cellpadding=8>
        <TR><TH class=tableBody_BG height=45 align=left valign=bottom>
        <img src="../../images/template_ball.gif">&nbsp;
        <font class=tableBody>Standard Publish</font>
        </TH></TR>
        <TR><TD valign=top><br>

<table border="0" cellpadding="0" cellspacing="0" height="100%" width="100%" class="OTbl"> <tr> <td height="100%" valign="top" width="100%">
   <form name=main_Form method="post" action="">

<%@ page language="java"%>
<%@ page import="java.lang.*,java.sql.*,java.util.*"%>
<jsp:useBean id="query_object" scope="page" class="com.iGrandee.Publishing.StandardPublish"/>
<jsp:useBean id="date_object" scope="page" class="com.iGrandee.Common.DateTime"/>

<%


	String fail=request.getParameter("failop");

	if(fail!=null)
	{
		out.println("<script>");
			out.println("alert('This Standard already Published')");
		out.println("</script>");
	}




	ArrayList degreeList = null;
	ArrayList categoryList = null;
	ArrayList courseList = null;
	String course_string=null;String yearofsession 	= null;
	String coursecat = "all";

%>

<%

	if(request.getParameter("category") != null)
	{
		coursecat = request.getParameter("category");
	}

		String instituteid	= (String)session.getValue("userinstituteid");
		//out.println("<script>alert('coursecat   ::"+coursecat+"')</script>");
		//course_string		= query_object.getUniversityDetails(coursecat,"0",instituteid);

		yearofsession = query_object.getYearOfSession();
		out.println("yearofsession-->"+yearofsession);
		String date_str = date_object.showTime("WithTime");
		String date_str_cal = date_object.showTime("");
		out.println("date_str-->"+date_str+"--date_str_cal-->"+date_str_cal);

		out.println("<input type=hidden name='server_date' value='"+date_str+"'>");
		out.println("<input type=hidden name='serverdate_cal' value='"+date_str_cal+"'>");

%>
   <input type='hidden' name='yearofsession' value="<%= yearofsession%>">
<input type='hidden' name='course_session_id' value="">

<input type='hidden' name='course_session_name' value="">
<input type='hidden' name='sessiontype' value="ExistSession">
<input type='hidden' name='courseids' value="">
<%

  try
	{
		out.println("<table width='100%' border=0 align='center'>");
		//out.println("<tr><td colspan=7 align=right class=tablebold><font color=blue><a href=# style='cursor:hand;color:blue' title='Click here Course List' class=tablelights onclick='cListFun()' class='nvlink'>Course List</a> &nbsp;<a href=# style='cursor:hand;color:blue' title='Click here for Alloted Course List' class=tablelights onclick='aListFun()' class='nvlink'>Alloted Course List</a></font></td></tr></table>");

		out.print("<table border=0 class=table3 width='100%' height=200>");

		out.println("<td class='tablebold' colspan='2'><font color=black><span id='univ_span'></font></span> &nbsp;SETTINGS /&nbsp;<font color=red>STANDARD&nbsp;PUBLISHING</font> &nbsp;</td>");
		/*out.println("<tr height='24'>");
		if(coursecat.equals("IT"))
			out.println("<td class='tablebold' colspan='2'><font color=black><span id='univ_span'></font></span> &nbsp;SETTINGS /&nbsp;<font color=red>STANDARD&nbsp;PUBLISHING</font> &nbsp;</td><td colspan='3' align='right' class='tablebold'><input type='radio' checked name='course_category' onclick='loadCourses(\"IT\")'><font color=brown>IT</font> Courses&nbsp;<input type='radio' name='course_category' onclick='loadCourses(\"NON IT\")'><font color=green>NON IT</font> Courses&nbsp;<input type='radio' name='course_category' onclick='loadCourses(\"all\")'><font color=black>All</font></td>");
		else if(coursecat.equals("NON IT"))
			out.println("<td class='tablebold' colspan='2'><font color=black><span id='univ_span'></font></span> &nbsp;SETTINGS /&nbsp;<font color=red>STANDARD&nbsp;PUBLISHING</font> &nbsp;</td><td colspan='3' align='right' class='tablebold'><input type='radio' name='course_category' onclick='loadCourses(\"IT\")'><font color=green>IT</font> Courses&nbsp;<input type='radio' name='course_category' checked onclick='loadCourses(\"NON IT\")'><font color=brown>NON IT</font> Courses&nbsp;<input type='radio' name='course_category' onclick='loadCourses(\"all\")'><font color=black>All</font></td>");
		else
			out.println("<td class='tablebold' colspan='2'><font color=black><span id='univ_span'></font></span> &nbsp;SETTINGS /&nbsp;<font color=red>STANDARD&nbsp;PUBLISHING</font> &nbsp;</td><td colspan='3' align='right' class='tablebold'><input type='radio' name='course_category' onclick='loadCourses(\"IT\")'><font color=green>IT</font> Courses&nbsp;<input type='radio' name='course_category' onclick='loadCourses(\"NON IT\")'><font color=green>NON IT</font> Courses&nbsp;<input type='radio' name='course_category' checked onclick='loadCourses(\"all\")'><font color=brown>All</font></td>");
		out.println("</tr>");*/

		int pg_inc1 = 1;
		int textincval = 1;
		String startfld = "";
		String endfld = "";

		out.print("<tr height='24'>");
			out.print("<td colspan='7' align='right' class='tablebold'><span id='status_span' class=tablebold>&nbsp;</span>Academic Year: &nbsp;<span id='session_getter_span'><select name='course_session' class='tablelight' validate='Course Session' onchange='selectCourseSesssion(document.main_Form.course_session.options[this.selectedIndex]);'><option>&nbsp;&nbsp; -- Select Academic Year -- &nbsp;&nbsp;</option></select>&nbsp;<input type=button name='new_session' class=tableth value='New Session' onclick=addNewSession('AddNew');>&nbsp;<input type=button name='delete_session' class=tableth value='Delete Session' onclick=deleteSession('Delete');>&nbsp;<input type=button name='published' disabled class=tableth value='Published Standard' onclick=addNewSession('PublishedCourse');></span></td>");
		out.print("</tr>");
		degreeList = query_object.getDegree();
		if(degreeList != null) {
			HashMap degreeMap = null;
			for(int dginc=0;dginc<degreeList.size();dginc++) {
				degreeMap = (HashMap)degreeList.get(dginc);
				String degreeid = (String)degreeMap.get("degreeid");
				String degreename = (String)degreeMap.get("degreename");
				out.print("<tr height='24'>");
					out.print("<td class=tableheaddark colspan='5' valign='top'><table cellpadding=0 width='100%' cellspacing=0><tr class=tabledarkth height=25><td>&nbsp; "+degreename+" COURSES </td><td align=right><font color=yellow><span id='application_span' class=tablebold></span></font></td></tr></table></td>");
				out.print("</tr>");
				out.print("<tr>");
					out.print("<td colspan='7' valign='top'>");
					out.print("<table id='it_course_table' valign=top width='100%'>");
					out.print("<tr height='35' align='center' class='tableth'>");
						out.print("<td width='3%'>S No.</td><td width='6%'>Type</td><td width='6%'>Course Code</td><td width='20%' align=left>Name of the Course</td><td width='9%'>Start Date</td><td width='9%'>End Date</td><td width='9%'>Duration</td><td width='9%'>Select</td>");
					out.print("</tr>");
				categoryList = query_object.getCourseCategory();
				if(categoryList != null) {
					if(categoryList.size() >= 1) {
						HashMap categoryMap = null;
						for(int catinc=0;catinc<categoryList.size();catinc++) {
							categoryMap = (HashMap)categoryList.get(catinc);
							String iInstituteid = "1";
							String courseCategoryName = (String)categoryMap.get("categoryname");
							String courseCategory = (String)categoryMap.get("coursecategoryid");
							courseList = query_object.getUniversityDetails(degreeid,iInstituteid,courseCategory);
							if (courseList.size()>0) {
								out.println("<tr><td class='tablehead' colspan='7'><font color='white'>"+courseCategoryName+" COURSES</font></td></tr>");
							}

							if(courseList != null) {
								HashMap courseMap = null;
								for(int cinc=0;cinc<courseList.size();cinc++) {
									startfld = "startdate"+textincval;
									endfld = "enddate"+textincval;

									courseMap = (HashMap)courseList.get(cinc);
									//String coursecategory = (String) row_token.nextToken();
									String courseid = (String)courseMap.get("courseid");
									String courseFees = query_object.getCourseFeess(courseid);
									String coursedegree = (String)courseMap.get("coursedegree");
									String coursedescription = (String)courseMap.get("coursedescription");
									String coursename = (String)courseMap.get("coursename");
									String eligibility = (String)courseMap.get("eligibility");
									String agelimit = (String)courseMap.get("agelimit");
									String duration = (String)courseMap.get("duration");
									String noofseats = (String)courseMap.get("noofseats");
									String type = (String)courseMap.get("branchtype");



									out.println("<tr height='24' class=tablebold bgcolor='#EEEEEE'>");
									out.println("<td align=center><font color=black>"+pg_inc1+"</font></td>");
									out.println("<td align=center><font color=black>"+type+"</font></td>");

									out.println("<td align=center><font color=black>"+coursedegree+"</font></td>");
									out.println("<td align=center><font color=blue title='Click here to get details'><span id='q' style='cursor:hand'  re_courseid='"+courseid+"' onclick=openwin(this.re_courseid)><u>"+coursename+"<u></span></font></td>");
									out.println("<td class=tablelight><input type='hidden' name='cFees' value="+courseFees+"><input class=tablelight type=text name='"+startfld+"' validate='Start date' maxlength=12 size=12 onkeypress='this.blur();'>&nbsp;<input type=button name='startdate_but' class=buttons value='^' id='"+textincval+"' onclick=callCalendar('startdate',this.id,'serverdate_cal');></td>");
									//out.println("<input type='hidden' name='cFees' value="+courseFees+"");



										out.println("<td class=tablelight><input class=tablelight type=text name='"+endfld+"' validate='End date' maxlength=12 size=12 onkeypress='this.blur();'>&nbsp;<input type=button name='enddate_but' class=buttons value='^' id='"+textincval+"' onclick=callCalendar('enddate',this.id,'startdate');></td>");


										out.println("<td align=center><font color=black>"+duration+"</font></td>");
										out.println("<td align=center><input type=checkbox name=check noofseat='"+noofseats+"' eligible='"+eligibility+"' value="+courseid+"></font></td>");
									out.println("<tr>");

									pg_inc1++;
									textincval++;
								}
							}
						}
					}
					else {
						out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");
						//out.println("<tr><td colspan='7' class='tablebold' align='center'>DATA NOT FOUND</td></tr>");
					}
				}
				else {
					out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");
					//out.println("<tr><td colspan='7' class='tablebold' align='center'>DATA NOT FOUND</td></tr>");
				}
				out.print("</table><br><br>");
			}
		}
		/*out.print("<tr height='24'>");
		out.print("<td class=tableheaddark colspan='5' valign='top'><table cellpadding=0 width='100%' cellspacing=0><tr class=tabledarkth height=25><td>&nbsp; IT COURSES </td><td align=right><font color=yellow><span id='application_span' class=tablebold></span></font></td></tr></table></td>");
		out.print("</tr>");
		out.print("<tr>");
		out.print("<td colspan='6' valign='top'>");

		out.print("<table id='it_course_table' valign=top width='100%'>");
		out.print("<tr height='35' align='center' class='tableth'>");
		out.print("<td width='3%'>S No.</td><td width='6%'>Course Code</td><td width='20%'>Name of the Course</td><td width='9%'>Start Date</td><td width='9%'>End Date</td><td width='9%'>Duration</td><td width='9%'>Select</td>");
		out.print("</tr>");
		out.print("</table><br><br>");


		out.print("<table  width='100%'>");
		out.print("<tr height='24'>");
		out.print("<td class=tableheaddark colspan='5'><table cellpadding=0 width='100%' cellspacing=0><tr height=25 class=tabledarkth><td>&nbsp; NON IT COURSES </td><td align=right><font color=yellow><span id='application_span' class=tablebold></span></font></td></tr></table></td>");
		out.print("</tr>");
		out.print("<tr>");
		out.print("<td colspan='5' valign='top'>");

		out.print("<table id='non_course_table' width='100%'>");
		out.print("<tr height='35' align='center' class='tableth'>");
		out.print("<td width='3%'>S No.</td><td width='6%'>Course Code</td><td width='20%'>Name of the Course</td><!--<td width='12%'>Eligibility</td><td width='5%'>No of Seats</td>--><td width='9%'>Start Date</td><td width='9%'>End Date</td><td width='9%'>Duration</td><td width='9%'>Select</td>");
		out.print("</tr>");*/


		out.println("<tr title=''><td height=20 colspan=5 class=tablebold align=left>&nbsp;</td></tr>");
		out.println("<tr title=''><td colspan=5 class=tablebold align=right>Last Date for Course Registration : <input type=text class='tablelight' name='lastdate' validate='Last Date' onkeypress='this.blur();'><input type=button class=buttons value='^' onclick=Calendar_Fun('../../js/Calendar/CalendarWindow.html','main_Form.lastdate','0',event,'Not_Less_Than_Todaydate',document.main_Form.serverdate_cal);>");

		out.println("<input type=button class=buttons value=' Publish ' onclick=submitPublishCourse('Publish');><!--&nbsp;<input type=button class=tablebold value=' Module Schedule ' onclick=publishCourses('ModuleSchedule');>--></td></tr>");
		out.println("<tr title=''><td height=20 colspan=5 class=tablebold align=left>&nbsp;</td></tr>");
		out.println("</table>");
		out.print("<table>");

	}
	catch(Exception e){}


%>


				</TD>
				</TR>
				</TABLE>
		</TD>
		</TR>
		</TABLE>

</TD>
</TR>
</TABLE>

<input type=hidden name=sessionid>
<input type='hidden' name='category' value="all">




      <!-- End  -->
    	  </td>
    	</tr>



<!--         ******************************        Body         ******************************           -->

  	</table>
  	</td>
  </tr>
  </table>
 	</td>
  </tr>
  </table>
</form>

</body>
</html>