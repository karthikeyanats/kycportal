<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Exam Schedule List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>
<script type="text/javascript">
	function backfun()
	{
	document.Schedule_Form.action="./ExamView.jsp";
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

    <h2><%=bundle.getString("hmlabel.examscheduleview.rootpath")%> </h2>
    
<%
	PrinicipalQuery  examQuery = new PrinicipalQuery();
	ExamAllotmentQuery examAllotQuery = new ExamAllotmentQuery();
	String sessionid = session.getValue("sessionid")+"";
	String	examId = request.getParameter("examId");
	String	examname = request.getParameter("examname");
	String	yearofssession = request.getParameter("academicname");
		ArrayList subjectList=null;
		try{
		 if(session.getValue("sessionid")!= null)
		{
			String reg_coursepubid = request.getParameter("reg_coursepubid_hidden"); 
		
			subjectList=examQuery.LoadExamSubjectListforboard(examId,session.getValue("sessionid")+"");    
		}
	}catch(Exception e){}
%>
<form name="Schedule_Form" action="" method="post">
    <table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    		<tr>
        		<th scope="col" class="rounded-company" width="90%" ><%=bundle.getString("hmlabel.examscheduleview.selecteddetails")%></th>
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
    <table width=100%>
    <tr>
	    <td class=tablebold ><%=bundle.getString("hmlabel.examscheduleview.academicyear")%></td>
	    <td width='1%' class='tablebold'>:</td>
	    <td><%=session.getValue("sessionname")%></td>
	    <td class=tablebold > <%=bundle.getString("hmlabel.examscheduleview.examname")%></td>
	    <td width='1%' class='tablebold'>:</td>
	    <td><%=examname %></td>
    </tr>
    </table></td></tr>
    </tbody>
    </table>
    <br>
<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Prinicipal.PrinicipalQuery,com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery,com.iGrandee.Common.DateTime"%>

	<input type=hidden name=sessionname value='<%=sessionid%>' />

		<table width='90%' align='center' border='0' >
			<tr>
				<td width='20%' class='tablebold'>
				
					<table id="rounded-corner" border=0 summary="Subject List" width="80%">
					    <thead>
					    	<tr>
					        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("hmlabel.examscheduleview.slno")%> </th>
					            <th scope="col" class="rounded" 		width="40%"><%=bundle.getString("hmlabel.examscheduleview.subjectname")%> </th>
					            <th scope="col" class="rounded" 		width="17%"><%=bundle.getString("hmlabel.examscheduleview.examdate")%> </th>
					            <th scope="col" class="rounded" 		width="10%"><%=bundle.getString("hmlabel.examscheduleview.starttime")%></th>
					            <th scope="col" class="rounded" 		width="10%"><%=bundle.getString("hmlabel.examscheduleview.endtime")%> </th>
					            <th scope="col" class="rounded-q4" 		width="10%"><%=bundle.getString("hmlabel.examscheduleview.duration")%></th>
					        </tr>
					    </thead>
					    <tfoot>
    			<tr>
        			<td colspan="5" class="rounded-foot-left"><em></em></td>
        			<td class="rounded-foot-right">&nbsp;</td>
       			</tr>
    	</tfoot>
		<%
			//int duration=0;
			String duration = null;
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
				//char timeout[] =examtimeout.toCharArray();
				//examtimeout=timeout[0]+""+timeout[1]+":"+timeout[2]+""+timeout[3];
				if(examdate == null){
					examdate= " ";}
				if(examtimein == null){
					examtimein= " ";}
				if(examtimeout == null){
					examtimeout= " ";}
				//if(subjectListMap.get("examtimein") != null && subjectListMap.get("examtimeout")!=null)
					//duration = examAllotQuery.getHourMin(examtimein,examtimeout);
					
					//duration = Integer.parseInt((String)subjectListMap.get("examtimeout"))-Integer.parseInt((String)subjectListMap.get("examtimein"));
				String duration_temp=duration+"";
				char duratiochar[] =duration_temp.toCharArray();
				
				if(!boardmediumid.equals(boardid))
				{
		 			out.println("<tr>");
			 		out.println("<td colspan=6>"+(String)subjectListMap.get("boardmedium")+"</td>");
			 		out.println("</tr>");
			 		boardmediumid=boardid;
				}
				
		 		if(!standardscheduleid.equals(standardid))
				{
		 			out.println("<tr>");
			 		out.println("<td colspan=6>"+standardname+"</td>");
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
		 		///*if((duration_temp.length())>3)
		 		//{
			 		//out.println("<td>"+duratiochar[0]+duratiochar[1]+":"+duratiochar[2]+duratiochar[3]+"</td>");
		 		//}
		 		//else
		 		//{
		 		//out.println("<td>"+duratiochar[0]+":"+duratiochar[1]+duratiochar[2]+"</td>");
		 		//}*/
		 		out.println("</tr>");
		 		inc++;

		}
		
		}
		  else
			  {
		   		out.println("<tr><td colspan=6 class=tablebold align=center><font color=red>Data not found</font></td></tr>");    	 
		   	  }
		%>
		</table>

			
		<a href="#" class="bt_blue" onclick='backfun()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("hmbutton.examscheduleview.back")%></strong><span class="bt_blue_r"></span></a>
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