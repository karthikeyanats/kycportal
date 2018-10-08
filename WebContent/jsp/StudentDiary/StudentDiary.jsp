<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<jsp:useBean id="query_object" scope="page"	class="com.iGrandee.StudentDiary.StudentDiaryQuery" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.StudentDiary.StudentDiaryBean" />
	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Community | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="ddaccordion.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>

<script type="text/javascript">
function addcommunity()
{
	if(document.communityform.communityname.value == "")
	{
	alert("Community Name should not be empty");
	document.communityform.communityname.focus();
	return false;
	}
	else
	{
		document.communityform.action="CommunitySubmit.jsp";
		document.communityform.submit();
	}
	
	
	
	
}
function openCalander(idx)
{
	if(document.f1.user_finishing_date.length >= 1)
		Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','0',event,'Not_Greater_Than_CurrentDate',document.communityform.server_date.value);
	else
		Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','0',event,'Not_Greater_Than_CurrentDate',document.communityform.server_date.value);
}
function savedetails()
{
document.communityform.action="StudentList.jsp";
document.communityform.submit();
}
function newDiary()
{
document.communityform.action="StudentnewDiary.jsp";
document.communityform.submit();
}
function standardcombo(obj)
{
var standardname=obj.value;

document.communityform.standardname.value=standardname;

}
function sectioncombo(obj)
{
var sectionname=obj.value;

document.communityform.sectionname.value=sectionname;

}
function subjectcombo(obj)
{
var subject=obj.value;

document.communityform.subject.value=subject;

}
function yearcombo(obj)
{
var sessionid=obj.value;
alert(sessionid);
//alert(document.communityform.yearofsession.options[document.communityform.yearofsession.selectedIndex].innerText);
var yearofsession=document.communityform.yearofsession.options[document.communityform.yearofsession.options.selectedIndex].text;
document.communityform.subject.value=yearofsession;

}

function LoadDiary()
{
document.communityform.action="StudentExistingDiary.jsp";
document.communityform.submit();
}
</script>
</head>
<body>
<jsp:useBean id="datebeans" scope="page" class="com.iGrandee.Common.DateTime"/>
<%@ page import="java.io.*,java.util.*"%>

<%


String date_str="";
String studentdiaryid="";
String subject="";
String sectionid="";
String sectionname="";
String standardid="";
String standardname="";
String sessionname="";
String sessionid="";
date_str = datebeans.showTime("");
ArrayList standards=new ArrayList();

ArrayList subjects=new ArrayList();
ArrayList sections=new ArrayList();
ArrayList yearofsession=new ArrayList();


HashMap newsubjects=new HashMap();
HashMap newsections=new HashMap();
HashMap newstandards=new HashMap();
HashMap newyearofsession=new HashMap();



yearofsession=query_object.getAllYears();
subjects=query_object.getAllSubjects();
sections=query_object.getAllSections();
standards=query_object.getAllStandards();

out.println(yearofsession);
%>
<div id="main_container">
	<div class="header">
<%@ include file="../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<%@ include file="../include/header.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2>Master Entries / Student Diary</h2>
<form name="communityform" action="" method="post">
    
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
	<tr><td align="right" class="tablelight"><a href="<%=request.getContextPath()%>/jsp/StudentDiary/StudentDiary.jsp">Student Diary</a>&nbsp;&nbsp;<a href="DepartmentList.jsp">Department List</a></td></tr>
	<tr>
		<td>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10"></th>
        	<th scope="col" class="rounded" width="100%">Student Diary</th>
        	<th scope="col" class="rounded-q4" width="10" ></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=2  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
</tbody>
</table>
  <table id="rounded-corner" border=0 summary="Department List" width="100%">


    <thead>   
    <tr>
    <td>Year Of Session </td><td><select name="yearofsession" onchange="yearcombo(this)">
    <option value="0">--Select Year Of Session--</option>
     <%
    
    for(int i=0;i<yearofsession.size();i++)
    {//sessionid, sessionname
    	newyearofsession=(HashMap)yearofsession.get(i);
    	sessionid=(String)newyearofsession.get("sessionid");
    	sessionname=(String)newyearofsession.get("sessionname");
    	    out.println("<option  value='"+sessionid+"'>"+sessionname+"</option>");

    }
    %>
    </select>
    </td>
    <td>Standard </td><td><select name="standars" onchange="standardcombo(this)">
    <option value="0">--Select Standard--</option>
     <%
    
    for(int i=0;i<standards.size();i++)
    {
    	newstandards=(HashMap)standards.get(i);
    	standardid=(String)newstandards.get("standardid");
    	standardname=(String)newstandards.get("standardname");
    	    out.println("<option  value='"+standardname+"'>"+standardname+"</option>");

    }
    %>
    </select>
    </td>
    <tr>
     <td>Section </td><td><select name="sections" onchange="sectioncombo(this)">
    <option value="0">--Select Section--</option>
     <%
    
    for(int i=0;i<sections.size();i++)
    {
    	newsections=(HashMap)sections.get(i);
    	sectionid=(String)newsections.get("sectionid");
    	 sectionname=(String)newsections.get("sectionname");
    	    out.println("<option value='"+sectionname+"'>"+sectionname+"</option>");

    }
    %>
    </select>
    </td>
    
    <td>Subject </td><td colspan="3"><select name="subjects" onchange="subjectcombo(this)">
    <option value="0">--Select Subject--</option>
    <%
    
    for(int i=0;i<subjects.size();i++)
    {
    	newsubjects=(HashMap)subjects.get(i);
    	 studentdiaryid=(String)newsubjects.get("subjectid");
    	 subject=(String)newsubjects.get("subjectname");
    	    out.println("<option value='"+subject+"'>"+subject+"</option>");

    }
    %>
    </select>
    </td>
    </tr>
    
    <tr>
    <td colspan="4" align="center"><input type="button" class="tablehead" name="existing" value="Load Existing Diary" onclick="LoadDiary()" >&nbsp;&nbsp;
    <input type="button" class="tablehead" value="Create New Diary" onclick="newDiary()">
    </td>
    </tr>
    </thead>
</table>


     <a href="./CommunityView.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong>View all Communities </strong><span class="bt_blue_r"></span></a>
     <a href="#" class="bt_green" onclick="addcommunity()"><span class="bt_green_lft"></span><strong>Submit</strong><span class="bt_green_r"></span></a>
    <input type=hidden name=server_date value="<%= date_str %>">
        <input type=hidden name=standardname value="">
        <input type=hidden name=sectionname value="">
        <input type=hidden name=subject value="">
                <input type=text name=yearofsession value="">
        
    
     </td>
     </tr>
     </TABLE>
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>