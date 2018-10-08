<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Subject | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript">
function backfun()
{
document.Lesson_Form.action="./YearWiseStaffList.jsp";
document.Lesson_Form.submit();
}
function loadlesson(obj)
{
document.Lesson_Form.subjectscheduleid.value=obj.getAttribute("subjectscheduleid");
document.Lesson_Form.subjectname.value=obj.getAttribute("subjectname");
document.Lesson_Form.action="./SubjectWiseLessonView.jsp";
document.Lesson_Form.submit();
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

<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>
	
<%@ page language="java" import="com.iGrandee.Prinicipal.PrinicipalQuery,com.iGrandee.Common.DateTime"%>
	<%
		String sessionname=request.getParameter("sessionname_hidden");
	%>
<%

		PrinicipalQuery prinicipal			= new PrinicipalQuery();
		HashMap	hashmap				= null;
		ArrayList SubjectList		= null;
		String standardname=request.getParameter("standardname")+"";
		String staffid=request.getParameter("staffid")+"";
		String sessionid=request.getParameter("hiddenyear")+"";
		String standardid=request.getParameter("hiddenstandardid")+"";
		String sectionscheduleid=request.getParameter("sectionscheduleid")+"";
		String boardname=request.getParameter("boardname")+"";
		if(!staffid.equals("null") )
		{
			SubjectList=prinicipal.loadsubjectusingstaffid(staffid,standardid,sectionscheduleid); 
		}
		String today				= DateTime.showTime("calendar");
%>
    <h2>Staff / Subject Allotment List / Staff List / Subject</h2>

				<form name="Lesson_Form" action="" method="post">
						<input type="hidden" name="subjectscheduleid" value="">
						<input type="hidden" name="subjectname" value="">
						<input type="hidden" name="session" value="<%=sessionid %>">
						<input type="hidden" name="standard" value="<%=standardid %>">
						<input type="hidden" name="req_sessionid" value="<%=sessionid %>">
						
				<table id="rounded-corner" border=0 width="100%">
						<thead>
							<tr>
								<th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.schedule.selectedinfo")%></th>
								<th scope="col" class="rounded-q4" width="2%"></th>
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
    				<td class=tablebold ><%=bundle.getString("label.schedule.academicyear")%></td>
	    			<td width='1%' class='tablebold'>:</td>
	    			<td><%=sessionname %></td>
	    			<td  class=tablebold align=right><%=bundle.getString("label.schedule.board")%></td>
	    			<td width='1%' class='tablebold'>:</td>
	    			<td><%=boardname %></td>
    			</tr>
    			<tr>
    				<td  class=tablebold ><%=bundle.getString("label.schedule.standardname")%></td>
    				<td width='1%' class='tablebold'>:</td>
    				<td colspan=4><%=standardname %></td>
    			</tr>
    		</table></td></tr>	
    			</tbody>
    			</table>
						
			<br></br>
		<table align='center' border='0' id=rounded-corner width="100%" >
			<thead>
			<tr>
				<th scope="col" class="rounded-company" width="10%">Sl.No</th>
				<th scope="col" class="rounded" width="30%">Subject Name</th>
				<th scope="col" class="rounded-q4" width="20%">Subject Code</th>
			</tr>
			</thead>
			<tfoot>
			<tr>
				<td colspan=2 class="rounded-foot-left"><em></em></td>
				<td class="rounded-foot-right">&nbsp;</td>
			</tr>
		</tfoot>
		
		<tbody>
			<%
		int Totalstudent=0;
							if(SubjectList != null && SubjectList.size()>0)
								{
								String tempsectionid="";
								for(int y=0,i=1;y<SubjectList.size();y++,i++){
									hashmap		= (HashMap)SubjectList.get(y);
									String subjectname=hashmap.get("subjectname")+"";
									String subjectscheduleid=hashmap.get("subjectscheduleid")+"";
									 standardid=hashmap.get("standardid")+"";
									String subjectid=hashmap.get("subjectid")+"";
									String subjectcode=hashmap.get("subjectcode")+"";
									if(subjectcode.equals(""))
									subjectcode="-";
									 
									String sectionid=hashmap.get("sectionid")+"";
									out.print("<tr ><td>"+i+"</td>");
									out.println("<td>"+subjectname+"</td>");
									out.println("<td>"+subjectcode+"</td>");
									out.println("</tr>");
								}
								}
							else
							{
								out.print("<tr><td colspan='3' align=center><font color=red>Data Not Found</font></td></tr>");

							}
						%>
		</tbody>
		<tfoot>
			<tr>
				<td colspan=2 class="rounded-foot-left"><em></em></td>
				<td class="rounded-foot-right">&nbsp;</td>
			</tr>
		</tfoot>
		</table>

		 <a href="#" class="bt_blue" onclick='backfun()'><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
		</form>		

    </div><!-- end of right content--> 


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>