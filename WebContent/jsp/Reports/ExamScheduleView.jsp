<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Exam Schedule List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>
<script type="text/javascript">
	function backfun()
	{
	document.Schedule_Form.action="./ExamView.jsp";
		document.Schedule_Form.submit();
	}

	function printfun()
	{
	//window.print();
	//window.open("examsheduleprint.jsp?&req_sessionname=2013-2014&req_sessionid=2&req_examname=may-june(2013-2014)&req_examnameid=2");
	window.open("examsheduleprint.jsp?&req_sessionname="+document.Schedule_Form.req_sessionname.value+"&req_sessionid="+document.Schedule_Form.req_sessionid.value+"&req_examname="+document.Schedule_Form.req_examname.value+"&req_examnameid="+document.Schedule_Form.req_examnameid.value+"&req_sessionstatus="+document.Schedule_Form.req_sessionstatus.value,"Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=650,scrollbars=1;")
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


	<%
		ResourceBundle bundle1  =ResourceBundle.getBundle("resources.ApplicationResources");
	%>
    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle1.getString("label.reports.reportsexamscheduleview")%></h2>
    
<%
	PrinicipalQuery  examQuery = new PrinicipalQuery();
	ExamAllotmentQuery  examAllotmentQuery = new ExamAllotmentQuery();
	//String sessionid = session.getValue("sessionid")+"";
	String sessionid = request.getParameter("req_sessionid");
	String	examId = request.getParameter("examId");
	String	examname = request.getParameter("examname");
	String	yearofssession = request.getParameter("academicname");

		ArrayList subjectList=null;
		try{
		 //if(session.getValue("sessionid")!= null)
		if(request.getParameter("req_sessionid")!= null)
		{
			//String reg_coursepubid = request.getParameter("reg_coursepubid_hidden"); 	
			subjectList=examQuery.LoadExamSubjectListforboard(examId,sessionid);
			//out.println(subjectList); 
		}
	}catch(Exception e){}
%>
<form name="Schedule_Form" action="" method="post">
    <table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    		<tr>
        		
            	<th scope="col" class="rounded-company" width="90%" ><%=bundle1.getString("label.schedule.selectedinfo")%></th>
            	<th scope="col" class="rounded-q4" width="10%"></th>        
        	</tr>
    </thead>
   <tfoot>
    	<tr>
        	<td  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       	</tr>
    	</tfoot>
    <tbody>
    <tr>
    <td colspan=2>
    <table width=100%><tr>
    <td class=tablebold ><%=bundle1.getString("label.schedule.academicyear")%></td>
    <td width=1% class=tablebold>:</td>
    <td><%=request.getParameter("req_sessionname")%></td>
    
    <td class=tablebold > <%=bundle1.getString("label.schedule.examname")%></td>
    <td width=1% class=tablebold>:</td>
    <td><%=examname %></td>
       </tr>
	<%
	if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R"))
	{
	out.print("<tr><td  valign=top class='tablebold' >"+bundle1.getString("label.schedule.archivaldetails")+"</td><td width=1% class=tablebold>:</td><td colspan=3 valign=top class='tablelight' align=left><h2>"+bundle1.getString("label.schedule.archivalmessage1")+"</h2></td><td></td></tr>");	
	}
	%>    
    </table></td></tr>
    </tbody>
    </table>
    <br>
<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Prinicipal.PrinicipalQuery,com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery,com.iGrandee.Common.DateTime"%>

	<input type=hidden name=sessionname value='<%=sessionid%>' />
	<input type=hidden name=req_examId value='<%=examId%>' />
	
	<input type=hidden name=req_sessionid value=<%=request.getParameter("req_sessionid") %>>
	<input type=hidden name=req_sessionname value='<%=request.getParameter("req_sessionname") %>'>
	<input type=hidden name=req_sessionstatus value=<%=request.getParameter("req_sessionstatus") %>>

	<input type=hidden name=req_examnameid value='<%=request.getParameter("examId") %>'>
	<input type=hidden name=req_examname value='<%=request.getParameter("examname") %>'>


		<table width='90%' align='center' border='0' >
			<tr>
				<td width='20%' class='tablebold'>
				
					<table id="rounded-corner" border=0 summary="Subject List" width="80%">
					    <thead>
					    	<tr>
					        	<th scope="col" class="rounded-company" width="5%"><%=bundle1.getString("label.schedule.slno")%></th>
					            <th scope="col" class="rounded" 		width="35%"><%=bundle1.getString("label.schedule.subjectname")%></th>
					            <th scope="col" class="rounded" 		width="17%"><%=bundle1.getString("label.schedule.examdate")%></th>
					            <th scope="col" class="rounded" 		width="10%"><%=bundle1.getString("label.schedule.starttime")%></th>
					            <th scope="col" class="rounded" 		width="10%"><%=bundle1.getString("label.schedule.endtime")%></th>
					            <th scope="col" class="rounded" 		width="10%"><%=bundle1.getString("label.schedule.duration")%></th>
					            <th scope="col" class="rounded-q4" 		width="10%"><%=bundle1.getString("label.examdetails.examtype")%></th>
					        </tr>
					    </thead>
					    <tfoot>
    			<tr>
        			<td colspan="6" class="rounded-foot-left"><em></em></td>
        			<td class="rounded-foot-right">&nbsp;</td>
       			</tr>
    	</tfoot>
		<%
			//int duration=0;
			String duration = null;
			String examtype = null;
			  if(subjectList!=null && subjectList.size()>0)
				{ 
				  int inc = 1;
				String standardscheduleid="";
				String boardmediumid="";
				
			 	for (int i1 = 0; i1 < subjectList.size(); i1++)
			 	{
			 		//examdate=2011-06-21 10:12:20.0, subjectname=Subject Name, groupname=null, examtimein=1000, standardname=1st Standard, examtimeout=1200
				HashMap subjectListMap=(HashMap)subjectList.get(i1);
				String groupname      = (String)subjectListMap.get("groupname")+"";
				String standardname      = (String)subjectListMap.get("standardname");
				if(!groupname.equals("null"))
				{
				standardname=standardname+"  -"+groupname;
				}
				String subjectname      = (String)subjectListMap.get("subjectname");
				String standardid      = (String)subjectListMap.get("standardscheduleid");
				String boardid      = (String)subjectListMap.get("boardid");
				String examdate      = (String)subjectListMap.get("examdate");
				String examtimein      = (String)subjectListMap.get("examtimein");
				//char timein[] =examtimein.toCharArray();
				//examtimein=timein[0]+""+timein[1]+":"+timein[2]+""+timein[3];
				String examtimeout      = (String)subjectListMap.get("examtimeout");
				String examtimeinampm      = (String)subjectListMap.get("examtimeinampm");
				String examtimeoutampm      = (String)subjectListMap.get("examtimeoutampm");
				duration      = (String)subjectListMap.get("duration");
				examtype      = (String)subjectListMap.get("examtype");
				//char timeout[] =examtimeout.toCharArray();
				//examtimeout=timeout[0]+""+timeout[1]+":"+timeout[2]+""+timeout[3];

				if(examdate == null){
					examdate= " ";}
				if(examtimein == null){
					examtimein= " ";}
				if(examtimeout == null){
					examtimeout= " ";}
				//if(subjectListMap.get("examtimein") != null && subjectListMap.get("examtimeout")!=null)
					//duration = examAllotmentQuery.getHourMin(examtimein,examtimeout);
					
				//duration = Integer.parseInt((String)subjectListMap.get("examtimeout"))-Integer.parseInt((String)subjectListMap.get("examtimein"));
		 		//out.println("duration>>>"+duration);
		 		if(!boardmediumid.equals(boardid))
				{
		 			out.println("<tr>");
			 		out.println("<td colspan=7>"+(String)subjectListMap.get("boardmedium")+"</td>");
			 		out.println("</tr>");
			 		boardmediumid=boardid;
				}
		 		
		 		if(!standardscheduleid.equals(standardid))
				{
		 			out.println("<tr>");
			 		out.println("<td colspan=7>"+standardname+"</td>");
			 		out.println("</tr>");
			 		standardscheduleid=standardid;
				}
		 		out.println("<tr>");
		 		out.println("<td >"+inc+"</td>");
		 		out.println("<td>"+subjectname+"</td>");
		 		out.println("<td>"+examdate+"</td>");
		 		out.println("<td>"+examtimeinampm+"</td>");
		 		out.println("<td>"+examtimeoutampm+"</td>");
		 		out.println("<td>"+duration+"</td>");
		 		out.println("<td>"+examtype+"</td>");
		 		out.println("</tr>");
		 		inc++;

		}
		
		}
		  else
			  {
			  out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>"+bundle1.getString("label.schedule.datanotfound")+"</font></td></tr>");
		   		//out.println("<tr><td colspan=6 align=center>"+bundle1.getString("label.schedule.datanotfound")+"</td></tr>");    	 
		   	  }
		%>
		</table>

			
		<a href="#" class="bt_blue" onclick='backfun()'><span class="bt_blue_lft"></span><strong><%=bundle1.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a>
		<%if(subjectList.size()>0){%> 
				<a href="#" class="bt_green" onclick='printfun()'><span class="bt_green_lft"></span><strong><%=bundle1.getString("label.schedule.print")%></strong><span class="bt_green_r"></span></a>
		<%} %>		
		</td>
		</tr>
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