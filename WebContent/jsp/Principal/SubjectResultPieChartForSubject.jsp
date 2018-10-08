<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>

<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.exampass.chartheader")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript">

	function backfun()
	{
		document.ExammarkEntryForm.action="ExamChartView.jsp";
		document.ExammarkEntryForm.submit();
	}
</script>
</head>
 <tbody>
 </tbody>
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess"%>
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

    <h2><%=bundle.getString("label.exampass.subpierootpath")%></h2>
	<table id="" border=0 summary="Department List" width="100%">
    	<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Prinicipal.PrinicipalQuery"%>
	<%
        PrinicipalQuery  examAllotmentQuery = new PrinicipalQuery();
		StringBuffer head=new StringBuffer();
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
		
		String subjectname="";
		registeredList	=	(ArrayList)examAllotmentQuery.LoadexammarkforStudentList(reg_examid,courseid,secSchedId);
		ArrayList temp=new ArrayList();
		HashMap contmap=new HashMap();

	   	if(registeredList.size()!=0)
		{
			for(int i=0;i<registeredList.size();i++)
				{			
					HashMap map=(HashMap)registeredList.get(i);
					if(!temp.contains(map.get("subjectscheduleid")+""))
					{
						subjectname =map.get("subjectname")+"";
						temp.add(map.get("subjectscheduleid")+""); 
						contmap.put(map.get("subjectscheduleid")+"",subjectname);
					}
				}
	    }

	  /*out.println("temp"+temp);
	   	out.println("contmap"+contmap);*/
			//ArrayList yearList = registrationQuery.listYearofSession();
		%>
		
		<tbody>
		<tr>
			<td>
				<table border=0 align=center id="rounded-corner" width="100%">
				<thead>
    		<tr>
            	<th scope="col" class="rounded-company" width="100%" colspan=6><%=bundle.getString("label.exampass.selectinfo")%></th>
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
					<td class=tablebold width="20%"><%=bundle.getString("label.exampass.academic")%></td><td width=1px class=tablebold>:</td><td class=tablelight  width="35%"><%=session.getValue("sessionname") %></td>
					<td class=tablebold  width="10%"><%=bundle.getString("label.exampass.board")%> </td><td width=1px class=tablebold>:</td><td class=tablelight  width="60%"><%=boardName %></td><td></td>
				</tr>
				<tr>
					<td class=tablebold><%=bundle.getString("label.exampass.examname")%></td><td width=1px class=tablebold>:</td><td class=tablelight><%=examName %></td>
					<td class=tablebold ><%=bundle.getString("label.exampass.standard")%></td><td width=1px class=tablebold>:</td><td class=tablelight><%=courseName %></td><td></td>
				</tr>
				<tr>
					<td class=tablebold><%=bundle.getString("label.exampass.section")%></td><td width=1px class=tablebold>:</td><td class=tablelight colspan=4><%=secName %></td><td width=10%></td>  
				</tr>
			</tbody>		
				</table>
			</td>
		</tr>
		</table>
		<br>
			<table id="rounded-corner" border=0 width="100%">
		
		<tr><td><table border=0 align=center id="rounded-corner1" width="100%">
			<%
			if(temp.size()>0 && contmap.size()>0)
			{
				for(int i=0;i<temp.size();i++)
				{
					out.println("<tr height=10px><td align=center class=tablebold>&nbsp;</td></tr>");  
					out.println("<tr><td align=center><iframe id='iframeid"+i+"' src='./SubjectResultPieChartView.jsp?course="+courseid+"&sectionpubid="+secSchedId+"&examid="+reg_examid+"&subjectid="+temp.get(i)+"&subjectname="+contmap.get(temp.get(i))+"' width=650px height=320px frameborder=0></iframe></td></tr>");
				}
			}
			else
			{
				out.println("<center  class=tablebold><font color=red>Data Not Found</font></center>");
			}
			%>
			</table></td>
			</tr>
			</tbody>
			</table>
			<a href="#" class="bt_blue" onclick="backfun()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.exampass.back")%></strong><span class="bt_blue_r"></span></a>

		</div><!-- end of right content-->


	</div>   <!--end of center content -->

    <div class="clear"></div>
    </div> <!--end of main content-->

	<%@ include file="../include/footer.jsp" %>

	</div>
</form>
</body>
</html>