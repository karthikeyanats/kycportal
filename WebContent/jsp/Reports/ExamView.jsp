<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Exam Schedule List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>
<script type="text/javascript">
	var count	= 0; 
	function loadExam()
	{
		document.Schedule_Form.submit();
	}
	function loadexamdetails(obj)
	{
		document.Schedule_Form.examId.value = obj.getAttribute("examId");
		document.Schedule_Form.examname.value = obj.getAttribute("examname");
		document.Schedule_Form.action="./ExamScheduleView.jsp";
		document.Schedule_Form.submit();
	}
	
	function goBack(){
		document.Schedule_Form.action="./ReportIndexView.jsp";
		document.Schedule_Form.submit();
	}

	function printfun()
	{
	window.open("PrintPreviewExamScheduleView.jsp?&req_sessionname="+document.Schedule_Form.req_sessionname.value+"&req_sessionid="+document.Schedule_Form.req_sessionid.value+"&req_sessionstatus="+document.Schedule_Form.req_sessionstatus.value,"Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=800,scrollbars=1;")
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
<%
ResourceBundle bundle1  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
    <h2><%=bundle1.getString("label.reports.reportsexamschedule")%></h2>
	<form name="Schedule_Form" action="" method="post">
    <input type=hidden name=examId />
    <input type=hidden name=examname />
    <input type=hidden name=academicname />
<input type=hidden name=req_sessionid value=<%=request.getParameter("req_sessionid") %>>
<input type=hidden name=req_sessionname value='<%=request.getParameter("req_sessionname") %>'>
<input type=hidden name=req_sessionstatus value=<%=request.getParameter("req_sessionstatus") %>>
    
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="90%"><%=bundle1.getString("label.schedule.selectedinfo")%></th>
            <th scope="col" class="rounded-q4" width="10%"></th>
            
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
     <table width=100% border=0>
	<tr>
	<td class=tablebold  width=40%>
		<%=bundle1.getString("label.schedule.academicyear")%></td>
		<td class=tablebold >:</td>
		<td  align=left width=60%>
		<%=request.getParameter("req_sessionname") %>
		</td>	
	</tr>
	<%
	if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R"))
	{
	out.print("<tr><td  width=40% valign=top class='tablebold'>"+bundle1.getString("label.schedule.archivaldetails")+"</td><td class=tablebold >:</td><td valign=top class='tablelight' align=left><h2>"+bundle1.getString("label.schedule.archivalmessage1")+"</h2></td><td></td></tr>");	
	}
	%>
	</table></td></tr>
    </tbody>
</table>
<br>    

<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery,com.iGrandee.Common.DateTime"%>

<%
		com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery  examQuery = new com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery();
		String instituteid = null;
		ArrayList BoardList=null;
		instituteid			= (String)session.getValue("instituteid");
		//ArrayList academicList 		= examQuery.loadAcademicYear(instituteid);
		HashMap	hashmap				= null;
		String req_subjectscheduleid="";
		ArrayList ExamList=null;
		String req_sessionid 	= null;
		//out.println("==============>>>>>>>>>"+request.getParameter("sessionname"));
try{
	
		 //if(session.getValue("sessionid") != null )		{
			// req_sessionid=session.getValue("sessionid")+"";
			//ExamList=examQuery.LoadExamnameList(req_sessionid);
		//}
	req_sessionid = request.getParameter("req_sessionid");
	if(req_sessionid != null )
		ExamList=examQuery.LoadExamnameList(req_sessionid);
		
		
}catch(Exception e){}
			
%>
			

  <br>
		<table width='90%' align='center' border='0' >
			<tr>
				<td width='20%' class='tablebold'>
				
					<table id="rounded-corner" border=0 summary="Subject List" width="80%">
					    <thead>
					    	<tr>
					        	<th scope="col" class="rounded-company" width="10%"><%=bundle1.getString("label.schedule.slno")%></th>
					            <th scope="col" class="rounded-q4" 		width="90%"><%=bundle1.getString("label.schedule.examname")%></th>
					        </tr>
					    </thead>
					    <tfoot>
    			<tr>
        			<td colspan="1" class="rounded-foot-left"><em></em></td>
        			<td class="rounded-foot-right">&nbsp;</td>
       			</tr>
    	</tfoot>
					   	<%
					      	if(ExamList!=null && ExamList.size()>0)
							{
			  		 			for (int i = 0, j = 1; i < ExamList.size(); i++) 
			  		 			{
									HashMap ExamListMap=(HashMap)ExamList.get(i);
									String examId     = (String)ExamListMap.get("examnameid");
									String examName      = (String)ExamListMap.get("examname");
									out.println("<tr>");
									out.println("<td>"+j+"</td><td class=tablelight ><a href='#exam' name='exam' examId='"+examId+"' examname='"+examName+"' onclick='loadexamdetails(this)'>"+examName+"</a>");
									out.println("</tr>");
									j++;
									}
						  	 }
					      	else
					      	{
					      		out.println("<tr align='center' class='tablebold'><td colspan='2'><font color='red'>"+bundle1.getString("label.schedule.datanotfound")+"</font></td></tr>");
					      		//out.println("<tr>");
								//out.println("<td align='center' colspan='2'>"+bundle1.getString("label.schedule.datanotfound")+"</td>");
								//out.println("</tr>");
					      	}
						%>
		</table>
		</td>
		</tr>
		</table>
			
		<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong><%=bundle1.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a> 
		<%if(ExamList.size()>0){%> 
				<!-- <a href="#" class="bt_green" onclick='printfun()'><span class="bt_green_lft"></span><strong><%=bundle1.getString("label.schedule.print")%></strong><span class="bt_green_r"></span></a> -->
		<%} %>	
	</table>
</form>	
    </div><!-- end of right content-->
	</div>   <!--end of center content -->

   <div class="clear"></div>
   </div> <!--end of main content-->
<%@ include file="../include/footer.jsp" %>
</div>
</body>
</html>