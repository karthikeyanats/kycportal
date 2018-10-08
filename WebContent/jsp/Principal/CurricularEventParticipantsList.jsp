<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Extra Curricular Event Entry | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>

<script type="text/javascript">
function backfun()
{
		document.curriculareventparticipantsform.action="CurricularEventList.jsp";
		document.curriculareventparticipantsform.submit();
}
</script>
</head>
<body>
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

    <h2>Activities / Extra Curricular Event List /  Extra Curricular Participants List </h2>
<form name="curriculareventparticipantsform" action="" method="post">
<%@ page language="java" import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Common.DateTime,com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery"%>
<%
String instituteid= null;
String today				= DateTime.showTime("calendar");
ArrayList AllocatedstudentList = null;
com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery extraCurricularQuery = new com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery();
ArrayList sessionList=null;
String eventid="";
String eventname="";
String eventdate="";
String venue="";
String sessionid="";
eventid		=request.getParameter("eventidhidden")+"";
eventname	=request.getParameter("eventhidden")+"";
venue		=request.getParameter("venuehidden")+"";
eventdate	=request.getParameter("eventdatehidden")+"";
sessionid	=request.getParameter("session")+"";
try
{
	AllocatedstudentList = extraCurricularQuery.loadEventAllocatedstudent(eventid);
//out.println("===========>>>>>"+AllocatedstudentList);
}catch(Exception e){}
%>
<input type="hidden" name="session" value="<%=sessionid%>">
<table id="rounded-corner" border=0 summary="selectd Information" align=center>
    <thead>
    	<tr>
     
        	<th scope="col" class="rounded-company" width=90%>Event Details</th>
          	<th scope="col" class="rounded-q4" WIDTH=10%></th>
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
    <td colspan=2>
    <table width="100%">
    <tr>   
		<td width='20%' class='tablebold'>Academic Year</td>
		<td width='1%' class='tablebold'>:</td>
		<td width='40%' class='tablelight'><%=session.getValue("sessionname") %></td>
		
	</tr>
     <tr>
	
		<td width='20%' class='tablebold'>Event Name</td>
		<td width='1%' class='tablebold'>:</td>
		<td class='tablelight' width='40%'>
		<%=eventname %></td>
		
		
	</tr>
	<tr>
	
		<td width='10%' class='tablebold'>Event Date</td>
		<td width='1%' class='tablebold'>:</td>
		<td class='tablelight' width='30%'>
		<%=eventdate %></td>
		

	</tr>
		<tr>
		<td width='20%' class='tablebold'>Venue</td>
		<td width='1%' class='tablebold'>:</td>
		<td class='tablelight' width='40%' colspan=4>
		<%=venue %></td>
		
	</tr>
	</table>
	</td>
	</tr>
	
	
     </tbody>
     </table>
          <br>
     
<table id="rounded-corner" border=0 summary="selectd Information" align=center>
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="1%"></th>
        	<th scope="col" class="rounded" >Sl. No</th>
        	<th scope="col" class="rounded" >Student Name</th>
        	<th scope="col" class="rounded" >Roll No</th>
        	<th scope="col" class="rounded" >Award Details</th>
        	<th scope="col" class="rounded-q4" width="1%"></th>
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=5 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
 <%
//out.println("eventCategoryList.size()"+eventCategoryList.size()+"request.getParameter(session)"+request.getParameter("session"));
 if(AllocatedstudentList.size()>0 )
 {
 String category="";
 for(int i=0,x=1;i<AllocatedstudentList.size();i++,x++)
	{
	 HashMap innermap=(HashMap)AllocatedstudentList.get(i);
	// rollno=12A1001, uname=Mr. Barani dharan, studentallocationid=3
	 out.println("<tr>");
	 out.println("<td></td>");
	 out.println("<td>"+x+"</td>");
	 out.println("<td>"+innermap.get("uname")+"</td>");
	 String rollno=innermap.get("rollno")+"";
	 if(rollno.equals("null"))
			rollno="-";
	 out.println("<td>"+rollno+"</td>");
	  out.println("<td>"+innermap.get("awarddetails")+"</td>");
	 
	 out.println("<td></td>");
	 out.println("</tr>");
	 //extracurricularcategoryid, a.curriculareventid,,, 
	 }
 
 }
 else
 {
	 out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>Data Not Found</font></td></tr>");
	 //out.println("<tr>");
	 //out.println("<td align=center colspan=6><font color=red>Data Not Found</font></td>");
	 //out.println("</tr>");

 }%>
	 </tbody>
	 </table>
	 <a href="#bbb" name="bbb" id="bbb" onclick='backfun()' class="bt_blue" align=center><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
	</td><td width="30%">&nbsp;</td></tr></table>	 
	<input type='hidden' name='todaydate' 	value='<%=today %>'/>
</form>
     </div><!-- end of right content-->
  </div>   <!--end of center content -->
    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>