<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.staffcontactprofileupdate.staffExperienceprofileupdatetitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/niceforms-default.css" />

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<SCRIPT language="JavaScript"
	src="<%=request.getContextPath()%>/js/Validation.js"></script>
<SCRIPT language="JavaScript"
	src='<%=request.getContextPath()%>/js/Calendar/Calendar.js'></SCRIPT>

<script type="text/javascript">
var experiencecheckcount=0;
function experiencevalidation(obj,elementno)
{
if(obj.checked)
{
	if(!check_ForParticularElements(document.applicationform.instituteRole[elementno],"text",document.applicationform.institutePeriod[elementno],"text"))
	{
	   obj.checked=false;
	   return false;
	}
	else
	{
		document.applicationform.instituteRole[elementno].disabled=true;
		document.applicationform.institutePeriod[elementno].disabled=true;
	}
	experiencecheckcount++;
	if(document.applicationform.hiddenexperience[elementno].value!="A")
	document.applicationform.hiddenexperience[elementno].value="U";
}
else
{
   document.applicationform.instituteRole[elementno].disabled=false;
   document.applicationform.institutePeriod[elementno].disabled=false;
   experiencecheckcount--;
   	document.applicationform.hiddenexperience[elementno].value="X";
   
}
}
var qualificationcheckcount=0;
function qualificationvalidation(obj,elementno)
{
  if(obj.checked)
{
	if(!check_ForParticularElements(document.applicationform.major[elementno],"text",document.applicationform.user_qualification[elementno],"text",document.applicationform.Yearofgrad[elementno],"text",document.applicationform.marks[elementno],"text",document.applicationform.institutename[elementno],"text"))
	{
	   obj.checked=false;
	   return false;
	}
	else
	{
				var year_of_graduration=document.applicationform.Yearofgrad[elementno].value;
				var split_year_of_graduration	= year_of_graduration.split(" ");
					if(split_year_of_graduration.length > 2){
						alert("Invalid year of graduation.");
				  		obj.checked=false;
						document.applicationform.Yearofgrad[elementno].focus();
						return false;
					}
					else{
						var month_array = new Array("jan","feb","mar","apr","may","jun","jul","aug","sep","oct","nov","dec");
						var valid_month	= false;
						for(var a=0;a<month_array.length;a++){
							if(split_year_of_graduration[0].toLowerCase() == month_array[a].toLowerCase()){
								valid_month	= true;
							}
						}
						if(!valid_month){
							alert("Invalid year of graduation.");
							obj.checked=false;
							document.applicationform.Yearofgrad[elementno].focus();
							return false;
						}
						if(isNaN(split_year_of_graduration[1])){
							alert("Invalid year of graduation.");
							obj.checked=false;
							document.applicationform.Yearofgrad[elementno].focus();
							return false;
						}
					}
				if(isNaN(document.applicationform.marks[elementno].value))
				{
						alert("Invalid GPA.");
						obj.checked=false;
						document.applicationform.marks[elementno].value="";
						document.applicationform.marks[elementno].focus();
						return false;
		}
		
   document.applicationform.major[elementno].disabled=true;
   document.applicationform.user_qualification[elementno].disabled=true;
   document.applicationform.Yearofgrad[elementno].disabled=true;
   document.applicationform.marks[elementno].disabled=true;
   document.applicationform.institutename[elementno].disabled=true;
	}
	qualificationcheckcount++;
	if(document.applicationform.hiddenqualification[elementno].value!="A")
	document.applicationform.hiddenqualification[elementno].value="U";
}
else
{
   document.applicationform.major[elementno].disabled=false;
   document.applicationform.user_qualification[elementno].disabled=false;
   document.applicationform.Yearofgrad[elementno].disabled=false;
   document.applicationform.marks[elementno].disabled=false;
   document.applicationform.institutename[elementno].disabled=false;
   document.applicationform.hiddenqualification[elementno].value="X";
 }
}
function checkNumber(e) {
var code;
if (!e) var e = window.event;
if (e.keyCode) code = e.keyCode;
else if (e.which) code = e.which;
var character = String.fromCharCode(code);
if(code!=9 && code!=46 && code!=8)
{
if (code==47||code<46||code>57)
{
	code=0;
	alert("Enter  Number only")

if(window.event != null)
{
	window.event.keyCode 	= 505;
	event.cancelBubble		= true;
	event.returnValue		= false;
}
else
{
	e.preventDefault();
}
	 return false;
}
}
}
function backfun()
{
document.applicationform.action="./StaffProviewView.jsp";
document.applicationform.submit();
}
function Submitfun()
{
var checkqualification="false";
var checkexperience="false";


	if(check_ForParticularElements(document.applicationform.user_department,"select",document.applicationform.user_role,"select",document.applicationform.user_joining_date,"text"))
	{
	for(var i=0;i<document.applicationform.chk.length;i++)
		{
		   if(document.applicationform.chk[i].checked)
		   {
		   		   	   checkqualification="true";
		   }
		}
		if(checkqualification=="false")
		{
			alert("select Any One Qualification");
			return false;
		}
		/*for(var i=0;i<document.applicationform.experiencecheck.length;i++)
		{
		   if(document.applicationform.experiencecheck[i].checked)
		   {
		   		   	   checkexperience="true";
		   }
		}
		if(checkexperience=="false")
		{
			alert("select Any One Experience");
			return false;
		}*/
		for(var i=0;i<document.applicationform.chk.length;i++)
		{
		   if(!document.applicationform.chk[i].checked)
		   {
			   if(document.applicationform.hiddenqualification[i].value=="A")
			     	 {
						   document.applicationform.major[i].disabled=true;
						   document.applicationform.user_qualification[i].disabled=true;
						   document.applicationform.Yearofgrad[i].disabled=true;
						   document.applicationform.marks[i].disabled=true;
						   document.applicationform.institutename[i].disabled=true;
			   		 }
		   }
		   else
		   {
			   document.applicationform.major[i].disabled=false;
			   document.applicationform.user_qualification[i].disabled=false;
			   document.applicationform.Yearofgrad[i].disabled=false;
			   document.applicationform.marks[i].disabled=false;
			   document.applicationform.institutename[i].disabled=false;
		   }
		}
		
		for(var i=0;i<document.applicationform.experiencecheck.length;i++)
		{
		   if(!document.applicationform.experiencecheck[i].checked)
			   {
			      if(document.applicationform.hiddenexperience[i].value=="A")
			       {
					   document.applicationform.instituteRole[i].disabled=true;
					   document.applicationform.institutePeriod[i].disabled=true;
				   }
			   }
		   else
			   {
				   document.applicationform.instituteRole[i].disabled=false;
				   document.applicationform.institutePeriod[i].disabled=false;
			    }
		  }
		    document.applicationform.user_post[0].disabled=false;
			document.applicationform.user_post[1].disabled=false;
			document.applicationform.user_post[2].disabled=false;
			document.applicationform.user_department.disabled=false;
			document.applicationform.user_role.disabled=false;
			document.applicationform.user_joining_date.disabled=false;
			if(confirm("Do you want to update the staff profile...?"))
			{
			document.applicationform.action="./StaffExperienceprofilesubmit.jsp";
			document.applicationform.submit();
			}

	}

}

</script>
</head>
<body>
<div id="main_container">
<div class="header"><%@ include file="../include/userheader.jsp"%>

</div>

<div class="main_content"><%@ include file="../include/header.jsp"%>


<div class="center_content">



<div class="left_content"></div>

<div class="right_content">

<%-- <h2><%=bundle.getString("label.staffcontactprofileupdate.staffExperienceprofileupdaterootpath") %></h2> --%>

<table width=100%><tr><td width=80% align=left><h2><%=bundle.getString("label.staffcontactprofileupdate.staffExperienceprofileupdaterootpath") %></h2></td><td align=right><a class=tablebold><font color=red>*</font>&nbsp;<font color=#000000><%=bundle.getString("label.studentprofileentry.Mandatory")%></font> </a></td></tr></table>
<%@ page
	import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Registration.StaffRegistrationQuery"%>

<%
	String date_str = "";
	String join_date = "-";
	String area = "-";
	String publication = "-";
	String departmentid = "-";
	String roleid = "-";
	String staffcategoryid = "-";
	HashMap map = null;
	StaffRegistrationQuery staffquery = new StaffRegistrationQuery();
	String sessionuserid = "0";
	String Staffid = request.getParameter("Staffid");
	ArrayList q_list = new ArrayList();
	ArrayList d_list = new ArrayList();
	ArrayList extra_list = new ArrayList();
	ArrayList experi_list = new ArrayList();
	ArrayList roleList = new ArrayList();
	ArrayList deptList = new ArrayList();
	ArrayList jobList = null;

	String Staffuserid = "0";
	String departid = "";

	
	String instituteid = null;
	String userlogintype="";

	try {
		sessionuserid = (String) session.getValue("userid");
		//out.println("sessionuserid====>>>>"+sessionuserid);
		departid=request.getParameter("departmentid");
		instituteid = (String) session.getValue("instituteid");
		q_list = staffquery.staffqualificationdetail(Staffid);
		d_list = staffquery.staffjobdetails(Staffid);
		extra_list = staffquery.staffExtradetails(Staffid);
		experi_list = staffquery.staffexperiencedetails(Staffid);
		roleList = staffquery.roleload(instituteid);
		deptList = staffquery.departmentload(instituteid);
		jobList = staffquery.jobcategoryload(instituteid);
		if (extra_list != null && extra_list.size() > 0) {
			map = (HashMap) extra_list.get(0);
			area = (String) map.get("areaofinterest");
			publication = (String) map.get("publications");


		}
		if (d_list.size() > 0) {
			map = (HashMap) d_list.get(0);
			roleid = (String) map.get("roleid");
			join_date = (String) map.get("dateofjoin");
			departmentid = (String) map.get("departmentid");
			staffcategoryid = (String) map.get("staffcategoryid");
			Staffuserid = (String) map.get("userid");
			
			userlogintype = (String) map.get("usercategory");   


		}
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
<jsp:useBean id="datebeans" scope="page" class="com.iGrandee.Common.DateTime"/>

<form name="applicationform" method="post" action=""><%@ page
	import="java.io.*,java.util.*"%> <%
 	StringBuffer currentDate = new StringBuffer();
 	Date dateObj = new Date();
 	currentDate.append((dateObj.getMonth() + 1) + "/"
 			+ dateObj.getDate() + "/" + (dateObj.getYear() + 1900));
	 date_str = datebeans.showTime("calendar");

 	// out.println("detaillist=========>>>>>"+detaillist);
 %> <input type="hidden" name="currentDate" value="<%=currentDate%>"><input
	type="hidden" name="Staffid" value="<%=Staffid %>"><input
	type="hidden" name="personid" value="<%=Staffuserid %>">
	<input type="hidden" name="departmentid" value="<%=departid%>"/>
	<input type=hidden name=server_date value="<%= date_str %>">
	<input type="hidden" name="deptname" value="<%=request.getParameter("deptname")%>"/>
	
<table id="rounded-corner" border=0 summary="Department List" width="100%">
	<thead>
		<tr>
			<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.staffexperienceprofileupdate.QualificationDetails")%></th>
			<th scope="col" class="rounded-q4" width="20%"><a class=tablebold><font color=red>*</font>&nbsp;<font color=#000000><%=bundle.getString("label.studentprofileentry.Mandatory")%></font> </a></th>

		</tr>
	</thead>
	<tfoot>
		<tr>
			<td class="rounded-foot-left"><em></em></td>
			<td class="rounded-foot-right">&nbsp;</td>
		</tr>
	</tfoot>
	<tbody>
		<tr>
			<td width="100%" colspan=2>
			<table border=0 bordercolor='#EFEFE7' align=center class=tablehead
				cellpadding=0 cellspacing=0 width="100%" rules="groups">
				<td width="100%">
				<table width="100%" border=0 bgcolor="#ffffff" cellpadding=0
					cellspacing=0>
					<tr style="height: 25">
						<td class="tablebold" style="width: 5%"><%=bundle.getString("label.staffexperienceprofileupdate.SL.No")%></td>
						<td class="tablebold" style="width: 10%"><%=bundle.getString("label.staffexperienceprofileupdate.Major")%></td>
						<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffexperienceprofileupdate.AreaofSpecialization")%></td>
						<td class="tablebold" style="width: 35%"><%=bundle.getString("label.staffexperienceprofileupdate.YearofGraduation")%></td>
						<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffexperienceprofileupdate.%OfMarks")%></td>
						<td class="tablebold" style="width: 35%"><%=bundle.getString("label.staffexperienceprofileupdate.College/University")%></td>
						<td class="tablebold" style="width: 5%"><%=bundle.getString("label.staffexperienceprofileupdate.Check")%></td>

					</tr>

					<%
						//out.println("q_list.size()"+q_list.size());

						if (q_list.size() > 0) {
							int i = 0;
							for (i = 0; i < q_list.size(); i++) {
								map = (HashMap) q_list.get(i);
								out.println("<tr>");
								out.println("<td class='tablelight'>");
								out.println((i + 1));
								out.println("</td>");
								out.println("<td class='tablelight'>");
								String major = (String) map.get("major") + "";
								String staffqualificationid = (String) map
										.get("staffqualificationid")
										+ "";

								out
										.println("<input type=text name=major disabled size=16 class=tablelight validate='Major' value='"
												+ major + "' maxlength=40>");
								out.println("</td>");

								out.println("<td class='tablelight'>");
								String areaofqualification = (String) map
										.get("areaofqualification")
										+ "";
								out
										.println("<input type=text disabled  name=user_qualification size=16 class=tablelight validate='Qualification'  value='"
												+ areaofqualification + "' maxlength=40>");

								out.println("</td>");
								out.println("<td class='tablelight'>");
								String yearofgraduation = (String) map
										.get("yearofgraduation")
										+ "";
								out
										.println("<input type=text  disabled name=Yearofgrad size=10 class=tablelight validate='Year of Graduation' value='"
												+ yearofgraduation + "' maxlength=40>");
								out.println("</td>");
								out.println("<td class='tablelight'>");
								String precentage = (String) map.get("precentage") + "";
								out
										.println("<input type=text  disabled name=marks size=10 class=tablelight validate='Percentage' value='"
												+ precentage + "'>");

								out.println("</td>");
								out.println("<td class='tablelight'>");
								String college = (String) map.get("college") + "";
								out
										.println("<input type=text  disabled name=institutename size=16 class=tablelight validate='Institute Name' value='"
												+ college + "'>");
								out.println("</td>");
								out.println("<td class='tablelight'>");
								out
										.println("<input type=checkbox class=tablelight name=chk onclick=qualificationvalidation(this,'"
												+ i + "')   checked=true)>");
								out
										.println("<input type=hidden class=tablelight name=hiddenqualification value='U' size=5>");
								out
										.println("<input type=hidden class=tablelight name=staffqualificationid value='"
												+ staffqualificationid + "' size=5>");

								out.println("</td>");

								out.println("</tr>");
							}
							for (int j = 0; j < 2; j++, i++) {
								out.println("<tr>");
								out.println("<td class='tablelight'>");
								out.println((i + 1));
								out.println("</td>");
								out.println("<td class='tablelight'>");
								out
										.println("<input type=text name=major size=16 class=tablelight validate='Major' value=''>");
								out.println("</td>");

								out.println("<td class='tablelight'>");
								out
										.println("<input type=text name=user_qualification size=16 class=tablelight validate='Qualification'  value=''>");

								out.println("</td>");
								out.println("<td class='tablelight'>");
								out
										.println("<input type=text name=Yearofgrad size=10 class=tablelight validate='Year of Graduation' value=''>");
								out.println("</td>");
								out.println("<td class='tablelight'>");
								out
										.println("<input type=text name=marks size=10 class=tablelight validate='Percentage' value=''>");

								out.println("</td>");
								out.println("<td class='tablelight'>");
								out
										.println("<input type=text name=institutename size=16 class=tablelight validate='Institute Name' value=''>");
								out.println("</td>");
								out.println("<td class='tablelight'>");
								out
										.println("<input type=checkbox class=tablelight name=chk onclick=qualificationvalidation(this,'"
												+ i + "') >");
								out
										.println("<input type=hidden class=tablelight name=hiddenqualification value='A' size=5>");

								out.println("</td>");

								out.println("</tr>");
							}
						} else {
							for (int j = 0; j < 2; j++) {
								out.println("<tr>");
								out.println("<td class='tablelight'>");
								out.println((j + 1));
								out.println("</td>");
								out.println("<td class='tablelight'>");
								out
										.println("<input type=text name=major size=16 class=tablelight validate='Major' value=''>");
								out.println("</td>");

								out.println("<td class='tablelight'>");
								out
										.println("<input type=text name=user_qualification size=16 class=tablelight validate='Qualification'  value=''>");

								out.println("</td>");
								out.println("<td class='tablelight'>");
								out
										.println("<input type=text name=Yearofgrad size=10 class=tablelight validate='Year of Graduation' value=''>");
								out.println("</td>");
								out.println("<td class='tablelight'>");
								out
										.println("<input type=text name=marks size=10 class=tablelight validate='Percentage' value=''>");

								out.println("</td>");
								out.println("<td class='tablelight'>");
								out
										.println("<input type=text name=institutename size=16 class=tablelight validate='Institute Name' value=''>");
								out.println("</td>");
								out.println("<td class='tablelight'>");
								out
										.println("<input type=checkbox class=tablelight name=chk onclick=qualificationvalidation(this,'"
												+ j + "')   )>");
								out
										.println("<input type=hidden class=tablelight name=hiddenqualification value='A' size=5>");

								out.println("</td>");

								out.println("</tr>");
							}
						}
					%>

				</table>
				</td>
				</tr>
				<tr>
			</table>
	</tbody>
</table>
<br>
<table id="rounded-corner" border=0 summary="Department List"
	width="100%">
	<thead>
		<tr>
			<th scope="col" class="rounded-company" width="100%"><%=bundle.getString("label.staffexperienceprofileupdate.JobInformation")%></th>
			<th scope="col" class="rounded-q4" width="1%"></th>

		</tr>
	</thead>
	<tfoot>
		<tr>
			<td class="rounded-foot-left"><em></em></td>
			<td class="rounded-foot-right">&nbsp;</td>
		</tr>
	</tfoot>
	<tbody>
		<tr>
			<td width="100%" colspan=2>
			<table border=0  cellpadding=0 cellspacing=0 width="95%">
				<tr>
					<td width="100%">
					<table width="100%" border=0  cellpadding=0	cellspacing=0>
						<tr>
							<td class=tablebold><%=bundle.getString("label.staffexperienceprofileupdate.JobCategory")%>&nbsp;<font color=red>*</font></td>
							<td>
							<%
								try {
									HashMap deptMap = null;
									for (int i = 0; i < jobList.size()-1; i++) {
										deptMap = (HashMap) jobList.get(i);
										String categoryid = (String) deptMap.get("staffcategoryid");
										String categoryname = (String) deptMap.get("categoryname");
										if (staffcategoryid.equals(categoryid)) {
											out
													.println("<input type = radio name='user_post' value='"
															+ categoryid
															+ "' checked >"
															+ categoryname + "&nbsp;&nbsp;");
										} else {
											out
													.println("<input type = radio name='user_post' value='"
															+ categoryid
															+ "' >"
															+ categoryname
															+ "&nbsp;&nbsp;");

										}
									}
								} catch (NullPointerException npe) {
									System.out
											.println("IGST-ERROR : in Staff_Registration.jsp in deptMap"
													+ npe);
									npe.printStackTrace();
								}
							%>
							</td>
							</tr>
						<tr style="height: 25">
							<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffexperienceprofileupdate.Department")%>&nbsp;<font color=red>*</font></td>
							<td class="tablelight" style="width: 35%"><select
								name="user_department" class=tablelight validate="Department"
								style="width: 250px">
								<option selected>&nbsp;&nbsp;-- Select Department
								--&nbsp;&nbsp;</option>
								<%
									try {
										HashMap deptMap = null;
										for (int i = 0; i < deptList.size(); i++) {
											deptMap = (HashMap) deptList.get(i);
											String deptid = (String) deptMap.get("departmentid");
											String deptname = (String) deptMap.get("departmentname");
											if (departmentid.equals(deptid))
												out.println("<option value='" + deptid
														+ "' selected=true>" + deptname + "</option>");
											else
												out.println("<option value='" + deptid + "' >"
														+ deptname + "</option>");
										}
									} catch (NullPointerException npe) {
										npe.printStackTrace();
									}
								%>
							</select></td>
						<tr style="height: 25">
							<td class="tablebold" style="width: 15%">Position&nbsp;<font color=red>*</font></td>
							<td class="tablelight" style="width: 35%" ><select
								name="user_role" class=tablelight validate="Position"
								style="width: 250px">
								<option selected>&nbsp;&nbsp;-- Select Position
								--&nbsp;&nbsp;</option>
								<%
									try {

										HashMap roleMap = null;
										for (int i = 0; i < roleList.size(); i++) {
											roleMap = (HashMap) roleList.get(i);
											String roleid1 = (String) roleMap.get("roleid") + "";
											String rolename = (String) roleMap.get("rolename");
											if (roleid1.equals(roleid))
												out.println("<option value='" + roleid1
														+ "' selected=true>" + rolename + "</option>");
											else
												out.println("<option value='" + roleid1 + "' >"
														+ rolename + "</option>");

										}
									} catch (NullPointerException npe) {
										System.out
												.println("IGST-ERROR : in Staff_Registration.jsp in roleMap"
														+ npe);
										npe.printStackTrace();
									}
								%>
							</select></td>
						</tr>
						</tr>
						<tr>
							<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffexperienceprofileupdate.JoinDate")%>&nbsp;<font color=red>*</font></td>
							<td class="tablelight" style="width: 35%"><input type=text
								name="user_joining_date" maxlength=50 size=20
								validate="Joining Date" value="<%=join_date%>" class=tablelight
								onkeydown='this.blur();' /><input type="button" value="^"
								onclick="Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','applicationform.user_joining_date','0',event,'Not_Greater_Than_CurrentDate',document.applicationform.server_date);" name="calbutton" ></td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
	</tbody>
</table>
<br>
<%if(userlogintype.equals("SA")){%>
<script>
document.applicationform.user_post[0].disabled=true;
document.applicationform.user_post[1].disabled=true;
document.applicationform.user_post[2].disabled=true;
document.applicationform.user_post[3].disabled=true;
document.applicationform.user_department.disabled=true;
document.applicationform.user_role.disabled=true;
document.applicationform.user_joining_date.disabled=true;
document.applicationform.calbutton.disabled=true;  
</script>
<%} %>
<table id="rounded-corner" border=0 summary="Department List"
	width="100%">
	<thead>
		<tr>
			<th scope="col" class="rounded-company" width="100%"><%=bundle.getString("label.staffexperienceprofileupdate.ExperienceDetails")%></th>
			<th scope="col" class="rounded-q4" width="1%"></th>

		</tr>
	</thead>
	<tfoot>
		<tr>
			<td class="rounded-foot-left"><em></em></td>
			<td class="rounded-foot-right">&nbsp;</td>
		</tr>
	</tfoot>
	<tbody>
		<tr>
			<td width="100%" colspan=2>
			<table border=0 bordercolor='#EFEFE7' align=center class=tablehead
				cellpadding=0 cellspacing=0 width="95%" rules="groups">
				<tr>
					<td width="100%">
					<table width="100%" border=0 bgcolor="#ffffff" cellpadding=0
						cellspacing=0>
						<tr height=25 class=tablebold bgcolor='#AED7FF'>
							<td class=tablehead align=center width='5%'><%=bundle.getString("label.staffexperienceprofileupdate.SL.No")%></td>
							<td class=tablehead align=center width='30%'><%=bundle.getString("label.staffexperienceprofileupdate.Position")%></td>
							<td class=tablehead align=center width='30%'><%=bundle.getString("label.staffexperienceprofileupdate.Period")%> &nbsp;<font
								color='red'><%=bundle.getString("label.staffexperienceprofileupdate.[InYear(s)orMonth(s)]")%> </font></td>
							<td class=tablehead align=center width='5%'><%=bundle.getString("label.staffexperienceprofileupdate.Check")%></td>
						</tr>
						<%
							if (experi_list.size() > 0) {
								int i = 0;
								for (i = 0; i < experi_list.size(); i++) {
									map = (HashMap) experi_list.get(i);
									out.println("<tr align=center>");
									out.println("<td class='tablelight'>");
									out.println((i + 1));
									out.println("</td>");
									out.println("<td class='tablelight'>");
									String role = (String) map.get("role") + "";
									String experienceid = (String) map.get("experienceid") + "";
									if (role.equals("null"))
										role = "-";
									out
											.println("<input type=text name='instituteRole' disabled maxlength=100 size=25 class=tablelight value='"
													+ role + "'>");
									out.println("</td>");
									out.println("<td class='tablelight'>");
									String period = (String) map.get("period") + "";
									if (period.equals("null"))
										period = "-";
									out
											.println("<input type=text name='institutePeriod'  disabled maxlength=100 size=25 class=tablelight value='"
													+ period + "'>");
									out.println("</td>");
									out.println("<td class='tablelight'>");
									out
											.println("<input type=checkbox name='experiencecheck'   onclick=experiencevalidation(this,'"
													+ (i) + "') checked=true>");
									out
											.println("<input type=hidden class=tablelight name=hiddenexperience value='U' size=5>");
									out
											.println("<input type=hidden class=tablelight name=staffexperienceid value='"
													+ experienceid + "' size=5>");
									out.println("</td>");
									out.println("</tr>");
								}
								for (int j = 0; j < 2; j++, i++) {
									out.println("<tr align=center>");
									out.println("<td class='tablelight'>");
									out.println((i + 1));
									out.println("</td>");
									out.println("<td class='tablelight'>");
									out
											.println("<input type=text name='instituteRole' maxlength=100 size=25 class=tablelight value=''>");
									out.println("</td>");
									out.println("<td class='tablelight'>");
									out
											.println("<input type=text name='institutePeriod' maxlength=100 size=25 class=tablelight value=''>");
									out.println("</td>");
									out.println("<td class='tablelight'>");
									out
											.println("<input type=checkbox name='experiencecheck' onclick=experiencevalidation(this,'"
													+ i + "') >");
									out
											.println("<input type=hidden class=tablelight name=hiddenexperience value='A' size=5>");

									out.println("</td>");
									out.println("</tr>");
								}
							} else {
								for (int j = 0; j < 2; j++) {
									out.println("<tr align=center>");
									out.println("<td class='tablelight'>");
									out.println((j + 1));
									out.println("</td>");
									out.println("<td class='tablelight'>");
									out
											.println("<input type=text name='instituteRole' maxlength=100 size=25 class=tablelight value=''>");
									out.println("</td>");
									out.println("<td class='tablelight'>");
									out
											.println("<input type=text name='institutePeriod' maxlength=100 size=25 class=tablelight value=''>");
									out.println("</td>");
									out.println("<td class='tablelight'>");
									out
											.println("<input type=checkbox name='experiencecheck' onclick=experiencevalidation(this,'"
													+ j + "') >");
									out
											.println("<input type=hidden class=tablelight name=hiddenexperience value='A' size=5>");

									out.println("</td>");
									out.println("</tr>");
								}
							}
						%>
					</table>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</tbody>
</table>
<br>
<table id="rounded-corner" border=0 summary="Department List"
	width="100%">
	<thead>
		<tr>
			<th scope="col" class="rounded-company" width="100%"><%=bundle.getString("label.staffexperienceprofileupdate.AreaOfInterestAndPublicationInformation")%></th>
			<th scope="col" class="rounded-q4" width="1%"></th>
		</tr>
	</thead>
	<tfoot>
		<tr>
			<td class="rounded-foot-left"><em></em></td>
			<td class="rounded-foot-right">&nbsp;</td>
		</tr>
	</tfoot>
	<tbody>
		<tr>
			<td width="100%" colspan=2>
			<table border=0 bordercolor='#EFEFE7' align=center class=tablehead
				cellpadding=0 cellspacing=0 width="95%" rules="groups">
				<tr>
					<td width="100%">
					<table width="100%" border=0 bgcolor="#ffffff" cellpadding=0
						cellspacing=0>
						<tr style="height: 30%" align="left" width="70%">
							<td class="tablebold" width='25%' valign=top><%=bundle.getString("label.staffexperienceprofileupdate.AreaOfInterest")%></td>
							<td class="tablelight" style="width: 35%" colspan="4"><textarea
								name="areaOfInterest" rows=5 cols=40 validate="Area of Interest"
								onkeydown="textCounter_label(document.applicationform.areaOfInterest,document.getElementById('remLen32'),2000)"
								onkeypress="textCounter_label(document.applicationform.areaOfInterest,document.getElementById('remLen32'),2000)"><%=area%></textarea>
							<br>
							<i><font color="red"><label name="remLen32"
								style='color: red' id="remLen32"><%=bundle.getString("label.staffexperienceprofileupdate.2000")%></label><%=bundle.getString("label.staffexperienceprofileupdate.charactersRemaining")%></font></i></td>
						</tr>
						<tr>
							<td class="tablebold" width='15%' valign=top><%=bundle.getString("label.staffexperienceprofileupdate.Publication")%></td>

							<td class="tablelight" colspan="4" style="width: 35%"><textarea
								name="publiCations" rows=5 cols=40 validate="Publications"
								onkeydown="textCounter_label(document.applicationform.publiCations,document.getElementById('remLen2'),2000)"
								onkeypress="textCounter_label(document.applicationform.publiCations,document.getElementById('remLen2'),2000)"><%=publication%></textarea>
							<br>
							<i><font color="red"><label name="remLen2"
								style='color: red' id="remLen2"><%=bundle.getString("label.staffexperienceprofileupdate.2000")%></label><%=bundle.getString("label.staffexperienceprofileupdate.charactersRemaining")%> </font></i></td>
						</tr>

						<tr style="height: 25" align="left" width="70%">
							<td class="tablebold" width='15%'></td>

							<td class="tablelight" style="width: 35%"></td>

							<td class="tablebold" colspan="2" width='15%'></td>

							<td class="tablelight" style="width: 35%"></td>
						</tr>

					</table>
				</tbody>
			</table>
			</td>
		</tr>
	</tbody>
</table>

<a href="#" onclick="backfun()" class="bt_blue"><span
	class="bt_blue_lft"></span><strong><%=bundle.getString("button.staffexperienceprofileupdate.Back")%></strong><span class="bt_blue_r"></span></a>
<a href="#" class="bt_green" onclick="Submitfun()"><span
	class="bt_green_lft"></span><strong><%=bundle.getString("button.staffexperienceprofileupdate.Submit")%></strong><span
	class="bt_green_r"></span></a></form>
</div>
<!-- end of right content--></div>
<!--end of center content -->




<div class="clear"></div>
</div>
<!--end of main content--> <%@ include file="../include/footer.jsp"%>


</div>
</body>
</html>