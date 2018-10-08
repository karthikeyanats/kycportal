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

function LoadDiary()
{
document.communityform.action="StudentExistingDiary.jsp";
document.communityform.submit();
}
function DairyDetailEdit(obj)
{
var details=obj.getAttribute("details");
var creation=obj.getAttribute("creation");
var subjectname=obj.getAttribute("subjectname");

var studentdiaryid=obj.getAttribute("studentdiaryid");

document.communityform.details.value=details;
document.communityform.creation.value=creation;
document.communityform.subjectname.value=subjectname;

document.communityform.studentdiaryid.value=studentdiaryid;


document.communityform.action="DairyDetailEdit.jsp";
document.communityform.submit();
}
function DairyDetailAssign(obj)
{
var details=obj.getAttribute("details");
var creation=obj.getAttribute("creation");
var subjectname=obj.getAttribute("subjectname");

var k=obj.getAttribute("k");
var sectionscheduleid=obj.getAttribute("sectionscheduleid");
var studentdiaryid=obj.getAttribute("studentdiaryid");
document.communityform.details.value=details;
document.communityform.creation.value=creation;
document.communityform.subjectname.value=subjectname;

document.communityform.studentdiaryid.value=studentdiaryid;
document.communityform.sectionscheduleid.value=sectionscheduleid;




document.communityform.action="DairyDetailAssign.jsp?k="+k;
document.communityform.submit();
}
</script>
</head>
<body>
<jsp:useBean id="datebeans" scope="page" class="com.iGrandee.Common.DateTime"/>
<%@ page import="java.io.*,java.util.*"%>

<%

String studentdiaryid="";
String date_str="";
String subjectname1="";
String sectionid="";
String sectionname="";
String standardid="";
String standardname="";
String sectionscheduleid="";
String subjectscheduleid="";
String subjectscheduleids="";
date_str = datebeans.showTime("");

ArrayList allexisting=new ArrayList();





HashMap newallexisting=new HashMap();






String userid=(String)session.getValue("userid");


//out.println(standards);

 standardname=request.getParameter("standardname");
 sectionname=request.getParameter("sectionname");
 subjectname1=request.getParameter("subjectname");
 subjectscheduleid=request.getParameter("subjectscheduleid");
 
 allexisting=query_object.getAllExistingStudent(userid,subjectscheduleid);

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

    <h2>Master Entries / Student Existing Diary</h2>
<form name="communityform" action="" method="post">
    
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
	<tr><td align="right" class="tablelight"><a href="<%=request.getContextPath()%>/jsp/StudentDiary/StudentDiaryStaff.jsp">Back</a></td></tr>
	<tr>
		<td>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10"></th>
        	<th scope="col" class="rounded" width="100%">Student Existing Diary</th>
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
    <td><a class=tablebold>Standard </a></td><td class="tablelight"><%=standardname %> </td>
     <td  class=tablebold>Section </td><td  class=tabllight><%=sectionname %>  </td>
    </tr>
    <tr >
    <td  class=tablebold>Subject </td><td colspan="3"  class=tablelight><%=subjectname1 %> </td>
    </tr>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>    	<tr>
        	<th scope="col" class="rounded-company" width="10%">Sl.No</th>
            <th scope="col" class="rounded" width="30%">Diary Details</th>
            <th scope="col" class="rounded" width="40%">Date of Creation</th>
             <th scope="col" class="rounded" width="40%" colspan="2">Submission Date</th>
            
            <th scope="col" class="rounded-q4" width="25%"  colspan="3" align="center">Action</th>
            
        </tr>
    </thead>
   <tfoot>
    	<tr>
        	<td colspan="4" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
    
     <tbody>
     <% 
     for(int j=0,k=1;j<allexisting.size();j++,k++)
     {//studentdiaryid, subject, workdetails, subjectscheduleid, ipaddress, studentdiarycreateiondate, credatedby, studentdiarystatus
    	 newallexisting =(HashMap)allexisting.get(j);
    	 String details=(String)newallexisting.get("workdetails");
    	 String creation=(String)newallexisting.get("newdates");
    	 String subjectname=(String)newallexisting.get("subject");
    	  studentdiaryid=(String)newallexisting.get("studentdiaryid");
    	  subjectscheduleid=(String)newallexisting.get("subjectscheduleid");
    	  sectionscheduleid=(String)newallexisting.get("sectionscheduleid");
    	 out.println("<tr>");
    	 out.println("<td>"+k+"</td>");
    	 out.println("<td>"+details+"</td>");
    	 out.println("<td>"+creation+"</td>");
    	 out.println("<td><input type='text' class='tablelight' name='startdate"+k+"'>&nbsp;");
    	 out.println("<input type='button' class='tablehead' value='^' onclick=Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','communityform.startdate"+k+"','0',event,'Not_Greater_Than_CurrentDate',document.communityform.server_date);forhiddendate()></td>");
    	 out.println("<td><a href='#' onclick='DairyDetailEdit(this)' sectionscheduleid='"+sectionscheduleid+"' studentdiaryid='"+studentdiaryid+"'  details='"+details+"' creation='"+creation+"' subjectname='"+subjectname+"'>Edit</a></td>");
    	 out.println("<td><a href='#' onclick='DairyDetailTrash(this)' studentdiaryid='"+studentdiaryid+"' details='"+details+"' creation='"+creation+"' subjectname='"+subjectname+"'>Trash</a></td>");
    	 out.println("<td><a href='#' onclick='DairyDetailAssign(this)' sectionscheduleid='"+sectionscheduleid+"' k='"+k+"' studentdiaryid='"+studentdiaryid+"' details='"+details+"' creation='"+creation+"' subjectname='"+subjectname+"'>Assign</a></td>");



    	 out.println("</tr>");


     }
     %>
     </tbody>
     
</table>


     <a href="./CommunityView.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong>View all Communities </strong><span class="bt_blue_r"></span></a>
     <a href="#" class="bt_green" onclick="addcommunity()"><span class="bt_green_lft"></span><strong>Submit</strong><span class="bt_green_r"></span></a>
    
        <input type=hidden name=details value="">
        <input type=hidden name=creation value="">
        <input type=hidden name=subjectname value="">
        
        <input type=hidden name=standardname value="<%=standardname%>">
        <input type=hidden name=sectionname value="<%=sectionname%>">
        <input type=hidden name=subject value="<%=subjectname1%>">
                <input type=hidden name=studentdiaryid value="">
                <input type=hidden name=sectionscheduleid value="">
                        <input type=hidden name=subjectscheduleid value="">
            <input type=hidden name=server_date value="<%= date_str %>">
        
    
      
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