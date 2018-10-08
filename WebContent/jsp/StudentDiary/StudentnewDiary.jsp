<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
function submitFun()
{
document.communityform.action="StudentDiarySubmit.jsp";
document.communityform.submit();
}
</script>
</head>
<body>

<%


String standardname="";
String sectionname="";
String subjectname="";
String subjectscheduleid="";


 standardname=request.getParameter("standardname");
 sectionname=request.getParameter("sectionname");
 subjectname=request.getParameter("subjectname");

 subjectscheduleid=request.getParameter("subjectscheduleid");


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
    <td>Standard</td> <td><%=standardname %></td>
     <td>Section </td> <td><%=sectionname %></td>
    </tr>
    <tr >
    <td>Subject </td><td colspan="3"><%=subjectname %></td>
    </tr>
    
    <tr>
    <td>Diary Subject</td><td colspan="3"><input type="text" name="diarysubjectname" value="" size="66"></td>
    </tr>
    <tr>
    <td>Details</td>
    <td colspan="3"><textarea validate="Description" class=tablelight cols=50
	rows=2 name="descryption" maxlength=1000></textarea>
	</td>
    </tr>
    
    </thead>
</table>


     <a href="./CommunityView.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong>View all Communities </strong><span class="bt_blue_r"></span></a>
     <a href="#" class="bt_green" onclick="submitFun()"><span class="bt_green_lft"></span><strong>Submit</strong><span class="bt_green_r"></span></a>
    
   <input type=hidden name=standardname value="<%= standardname %>">
        <input type=hidden name=sectionname value="<%= sectionname %>">
        <input type=hidden name=subject value="<%= subjectname %>">
                <input type=hidden name=subjectscheduleid value="<%= subjectscheduleid %>">
        
    
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