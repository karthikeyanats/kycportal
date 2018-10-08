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
	
	
</script>
</head>
<body>
<div id="main_container">
	<div class="header">
<%@ include file="../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<%@ include file="../include/header.jsp" %>
	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>

    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("hmlabel.examschedule.rootpath")%>   </h2>
	<form name="Schedule_Form" action="" method="post">
    <input type=hidden name=examId />
    <input type=hidden name=examname />
    <input type=hidden name=academicname />
        <input type=hidden name=examallotmentid />
   
    	<table id="rounded-corner" border=0 summary="Department List" width="100%">
    	<thead>
    		<tr>
        		
            	<th scope="col" class="rounded-company" width="90%"><%=bundle.getString("hmlabel.examschedule.examschedulehead")%> </th>
            	<th scope="col" class="rounded-q4" width="10%"></th>        
        	</tr>
    	</thead>
        <tfoot>
    			<tr>
        			<td class="rounded-foot-left"><em></em></td>
        			<td class="rounded-foot-right">&nbsp;</td>
       			</tr>
    	</tfoot>
<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery,com.iGrandee.Common.DateTime"%>

<%
		com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery  examQuery = new com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery();
		String instituteid = null;
		ArrayList BoardList=null;
		instituteid			= (String)session.getValue("instituteid");
		ArrayList academicList 		= examQuery.loadAcademicYear(instituteid);
		HashMap	hashmap				= null;
		String req_subjectscheduleid="";
		ArrayList ExamList=null;
		String reg_sessionid 	= null;
		//out.println("==============>>>>>>>>>"+request.getParameter("sessionname"));
try{
	
		 if(session.getValue("sessionid") != null )		{
			 reg_sessionid=session.getValue("sessionid")+"";
			ExamList=examQuery.LoadExamnameList(reg_sessionid);

		}
		
		
}catch(Exception e){}
			
%>
			
<tbody>	
<tr>
<td colspan=2>
<table width=100%>
<tr>
		<td class=tablebold width='15%'><%=bundle.getString("hmlabel.examschedule.academicyear")%> </td>
		<td width='1%' class='tablebold'>:</td>
		<td width='60%'><%=session.getValue("sessionname") %></td>
				
</tr>
</table></td></tr>
	</tbody>
</table>
  <br>
		<table width='90%' align='center' border='0' >
			<tr>
				<td width='20%' class='tablebold'>
				
					<table id="rounded-corner" border=0 summary="Subject List" width="80%">
					    <thead>
					    	<tr>
					        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("hmlabel.examschedule.slno")%></th>
					            <th scope="col" class="rounded-q4" 		width="90%"><%=bundle.getString("hmlabel.examschedule.examname")%> </th>
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
					      		ArrayList templist=new ArrayList();
			  		 			for (int i = 0, j = 1; i < ExamList.size(); i++) 
			  		 			{
									HashMap ExamListMap=(HashMap)ExamList.get(i);
									String examId     = (String)ExamListMap.get("examnameid");
									String examName      = (String)ExamListMap.get("examname");
									String examallotmentid      = (String)ExamListMap.get("examallotmentid");
									if(!templist.contains(examId))
									{
									out.println("<tr>");
									out.println("<td>"+j+"</td><td class=tablelight ><a href='#exam' name='exam' examId='"+examId+"' examname='"+examName+"'  onclick='loadexamdetails(this)'>"+examName+"</a>");
									out.println("</tr>");
									templist.add(examId);
									j++;
									}
			  		 					
									}
							}
					      	else
					      	{
					      		out.println("<tr>");
								out.println("<td align='center' colspan='2' class=tablebold><font color=red>Data Not Found</font> </td>");
								out.println("</tr>");
					      	}
						%>
		</table>
		</td>
		</tr>
		</table>
			
		<!-- <a href="#" class="bt_blue" onclick='publishStandard()'><span class="bt_blue_lft"></span><strong>Submit</strong><span class="bt_blue_r"></span></a> -->
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