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

function openCalander(idx)
{
	if(document.f1.user_finishing_date.length >= 1)
		Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','0',event,'Not_Greater_Than_CurrentDate',document.communityform.server_date.value);
	else
		Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','0',event,'Not_Greater_Than_CurrentDate',document.communityform.server_date.value);
}


function submitFun()
{
document.communityform.action="StudentDiaryUpdate.jsp";
document.communityform.submit();
}
function viewDiary()
{
document.communityform.action="StudentDiaryView.jsp";
document.communityform.submit();
}

</script>
</head>
<body>
<jsp:useBean id="datebeans" scope="page" class="com.iGrandee.Common.DateTime"/>
<%@ page import="java.io.*,java.util.*"%>

<%
ArrayList StudntDiarySubjects=new ArrayList();
HashMap newStudntDiarySubjects=new HashMap();

String newdates="";
StudntDiarySubjects=query_object.StudntDiarySubjects();



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

    <h2>Master Entries / Student Diary Update</h2>
<form name="communityform" action="" method="post">
    
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
	<tr><td align="right" class="tablelight"><a href="<%=request.getContextPath()%>/jsp/StudentDiary/StudentDiaryStaff.jsp">Back</a></td></tr>
	<tr>
		<td>
<table id="rounded-corner" border=0 summary="Student Diary Creation" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10"></th>
        	<th scope="col" class="rounded" width="100%">Student Diary Info</th>
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
    <% 
    for(int i=0,j=1;i<StudntDiarySubjects.size();i++,j++)
	{
	newStudntDiarySubjects=(HashMap)StudntDiarySubjects.get(i);
	 newdates=(String)newStudntDiarySubjects.get("newdates");
	}
	 %>
    <td class="tablebold">Diary List for Today :</td> <td colspan="2"><%=newdates %></td>
    </tr>
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10">Sl.No</th>
        	<th scope="col" class="rounded" width="20%">Subject Name</th>
        	<th scope="col" class="rounded-q4" width="10" ></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=2  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    
    </tfoot>
    <%
	for(int i=0,j=1;i<StudntDiarySubjects.size();i++,j++)
	{
	newStudntDiarySubjects=(HashMap)StudntDiarySubjects.get(i);
	// newdates=(String)newStudntDiarySubjects.get("newdates");
	out.println("<tr>");
	out.println("<td>"+j+"</td>");
	out.println("<td>"+newStudntDiarySubjects.get("subject")+"</td>");
	out.println("<td><a href='#' onclick='viewDiary(this)'>View Diary</a></td>");
	out.println("</tr>");
}
%>
    </thead>
</table>



     <a href="./CommunityView.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong>View all Communities </strong><span class="bt_blue_r"></span></a>
     <a href="#" class="bt_green" onclick="submitFun()"><span class="bt_green_lft"></span><strong>Submit</strong><span class="bt_green_r"></span></a>
    
  
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