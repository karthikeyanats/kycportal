<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.topperweaker.header")%>  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript">

	function backfun()
	{
		document.ExammarkEntryForm.action="GradeWiseStudentSearch.jsp";
		document.ExammarkEntryForm.submit();
	}
</script>
</head>
 <tbody>
 </tbody>
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Prinicipal.PrinicipalQuery,com.iGrandee.GradeSetting.GradeScaleQuery"%>
<body bgcolor="#2B303E" topmargin="0" bottommargin="0">
<form name="ExammarkEntryForm" action="" method="post">
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
      PrinicipalQuery  examAllotmentQuery = new PrinicipalQuery();
	  GradeScaleQuery  gradescaleQuery  = new GradeScaleQuery();

		String sessionid=session.getValue("sessionid")+"";
		String courseid=request.getParameter("course");
		String secSchedId=request.getParameter("reg_sectionpubid");
		String reg_examid=request.getParameter("reg_examid");
		ArrayList registeredList= null;
		String examName=request.getParameter("reg_examname");
		String courseName=request.getParameter("reg_coursename");
		String secName=request.getParameter("reg_sectionname");
		String yearofsession=request.getParameter("reg_sessiontext");
		String boardName=request.getParameter("reg_boardname");
		String gradevalue []=request.getParameterValues("grade");
		String gradename=request.getParameter("gradename");
		gradename=gradename.substring(0,gradename.lastIndexOf(",")); 
		
		String Grade="";
		if(gradevalue!=null && gradevalue.length>0)
		{
			for(int i=0;i<gradevalue.length;i++)
				{
					Grade +=gradevalue[i];
					if(i!=gradevalue.length-1)
					{
						Grade +="','";
					}
				}
		}
  
		//ArrayList StudentList	=	(ArrayList)examAllotmentQuery.LoadStudentgradeWise(reg_examid,courseid,secSchedId,Grade,sessionid);
		ArrayList failedList	=	(ArrayList)gradescaleQuery.LoadFailedID(courseid,reg_examid);
		
		String failedAllocationId="";
   		if(failedList!=null && failedList.size()>0)
		{
   			for(int i=0;i<failedList.size();i++)
				{
					HashMap failedMap=(HashMap)failedList.get(i);
					String studentallocationid=failedMap.get("studentallocationid")+"";
					failedAllocationId +=studentallocationid;
					if(i!=failedList.size()-1)
					{
						failedAllocationId +=",";
					}					
				}
   				failedAllocationId = " and sa.studentallocationid not in ("+failedAllocationId+") ";
   				//System.out.print(failedAllocationId);
		}
		
		ArrayList StudentList	=	(ArrayList)gradescaleQuery.LoadStudentGradeScaleWise(reg_examid,courseid,secSchedId,Grade,sessionid,failedAllocationId);
		 
		%>
	
		<%

if(loginusercategory.equals("SA"))
{
%>
    <h2><%=bundle.getString("label.topperweaker.rootpathview")%></h2>
<%
}else
{ %>
<h2><%=bundle.getString("label.topperweaker.princirootpathview")%></h2>
<%} %>
	   <table id="" border=0 summary="Department List" width="100%">
		<tbody>
		<tr>
			<td>
				<table border=0 align=center id="rounded-corner" width="100%">
				<thead>
    		<tr>
            	<th scope="col" class="rounded-company" width="100%" colspan=6><%=bundle.getString("label.topperweaker.selectinfo")%></th>
            	<th scope="col" class="rounded-q4" width="10"></th>        
        	</tr>
    	</thead>
    
        <tfoot>
    	<tr>
        	<td colspan="6" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       	</tr>
       		</tfoot>
       		<tbody>
				<tr>
					<td class=tablebold width="20%"><%=bundle.getString("label.topperweaker.AcademicYear")%></td><td class=tablebold width="2%">:</td><td class=tablelight  width="35%"><%=session.getValue("sessionname") %></td>
					<td class=tablebold  width="20%"><%=bundle.getString("label.topperweaker.Board")%> </td><td class=tablebold width="2%">:</td><td class=tablelight  width="60%"><%=boardName %></td><td></td>
				</tr>
				<tr>
					<td class=tablebold><%=bundle.getString("label.topperweaker.ExamName")%></td><td class=tablebold width="2%">:</td><td class=tablelight><%=examName %></td>
					<td class=tablebold ><%=bundle.getString("label.topperweaker.Standard")%></td><td class=tablebold width="2%">:</td><td class=tablelight><%=courseName %></td><td></td>
				</tr>
				<tr>
					<td class=tablebold><%=bundle.getString("label.topperweaker.section")%></td><td class=tablebold width="2%">:</td><td class=tablelight><%=secName %></td>
					<td class=tablebold ><%=bundle.getString("label.topperweaker.selectgrade")%></td><td class=tablebold width="2%">:</td><td class=tablelight><%=gradename %></td><td></td>
				</tr>				
			</tbody>		
				</table>
			</td>
		</tr>
		</table>
		<br>
		<table border=0 align=center id="rounded-corner" width="100%">
				<thead>
		    		<tr>
		        		<th scope="col" class="rounded-company" width="10%" ><%=bundle.getString("label.topperweaker.slno")%></th>
		            	<th scope="col" class="rounded" width="40%" ><%=bundle.getString("label.topperweaker.StudentName")%> </th>
		            	<th scope="col" class="rounded" width="25%" ><%=bundle.getString("label.topperweaker.rollno")%> </th>
		            	<th scope="col" class="rounded" width="25%" ><%=bundle.getString("label.topperweaker.TotalMarksTaken")%> </th>
		            	<th scope="col" class="rounded-q4" width="10"></th>        
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
		       		if(StudentList!=null && StudentList.size()>0)
					{
		       			String temp="";
						for(int i=0;i<StudentList.size();i++)
							{
								HashMap innermap=(HashMap)StudentList.get(i);
								//String gradeid=innermap.get("gradesystemid")+"";
								String gradeid=innermap.get("gradeid")+"";
								String innergradename=innermap.get("gradename")+"";
								String rangefrom=innermap.get("rangefrom")+"";
								String rangeto=innermap.get("rangeto")+"";
								if(!gradeid.equals(temp))
								{
									out.println("<tr>");
									//out.println("<td>");
									//out.println("</td>");
									out.println("<td colspan=4 align=left class=tablebold style='color:red'>");
									out.println(innergradename +"  ( "+rangefrom+" to "+rangeto+" )");
									out.println("</td>");
									out.println("<td>");
									out.println("</td>");
									out.println("</tr>");
									temp=gradeid;
								}
								out.println("<tr>");
								//out.println("<td>");
								//out.println("</td>");
								out.println("<td>");
								out.println((i+1));
								out.println("</td>");
								out.println("<td>");
								out.println(innermap.get("uname"));
								out.println("</td>");
								out.println("<td>");
								out.println(innermap.get("rollno"));
								out.println("</td>");
								out.println("<td>");
								out.println(innermap.get("total"));
								out.println("</td>");
								out.println("<td>");
								out.println("</td>");
								out.println("</tr>");
							}
					}
		       		else
		       		{
		       			out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
		       			//out.println("<tr>");
						//out.println("<td align=center colspan=6>");
						//out.println("Data Not Found");
						//out.println("</td>");
						//out.println("</tr>");
		       		}
	       		 %>
				</tbody>
			</table>
		
			
			<a href="#" class="bt_blue" onclick="backfun()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.topperweaker.back")%></strong><span class="bt_blue_r"></span></a>

		</div><!-- end of right content-->


	</div>   <!--end of center content -->

    <div class="clear"></div>
    </div> <!--end of main content-->

	<%@ include file="../include/footer.jsp" %>

	</div>
</form>
</body>
</html>