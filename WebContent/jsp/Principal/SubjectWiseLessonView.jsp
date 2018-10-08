<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>
<script type="text/javascript">
function backfun()
{
document.Student_Form.action="./StandardWiseSubjectView.jsp";
document.Student_Form.submit();
}
function loadlesson(obj)
{
document.Student_Form.StudentPersonid.value=obj.getAttribute("personid");
document.Student_Form.action="./SubjectWiseLessonView.jsp";
document.Student_Form.submit();
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

<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Prinicipal.PrinicipalQuery,com.iGrandee.Common.DateTime"%>

<%

		PrinicipalQuery prinicipal			= new PrinicipalQuery();
		HashMap	hashmap				= null;
		ArrayList LessonList		= null;
		String standardname=request.getParameter("standardname")+"";
		String standardscheduleid=request.getParameter("standardscheduleid")+"";
		String subjectname=request.getParameter("subjectname")+"";
		String subjectscheduleid=request.getParameter("subjectscheduleid")+"";
		String boardid=request.getParameter("board")+"";
		String sessionid=request.getParameter("session")+"";
		String boardname=request.getParameter("boardname")+"";
		if(!subjectscheduleid.equals("null"))
		{
			LessonList=prinicipal.loadLesson(subjectscheduleid); 
		}
		String today				= DateTime.showTime("calendar");

%>
    <h2><%=bundle.getString("hmlabel.subjectwise.rootpath")%> <%=standardname %> / <%=subjectname %> </h2>

<form name="Student_Form" action="" method="post">
						<input type="hidden" name="standardscheduleid" value="<%=standardscheduleid %>">
						<input type="hidden" name="session" value="<%=sessionid%>">
						<input type="hidden" name="board" value="<%=boardid%>">
						<input type="hidden" name="standardname" value="<%=standardname%>">
		<table id="rounded-corner" border=0 width="100%">
							<thead>
								<tr>
									<th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.schedule.selectedinfo")%></th>
									<th scope="col" class="rounded-q4" width="1%"></th>
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
	    			<td colspan=2><table width="100%">
			    			<td class=tablebold >
			    			<%=bundle.getString("label.schedule.academicyear")%>
			    			</td>
			    			<td class='tablebold'>:</td>
			    			<td><%=session.getValue("sessionname") %>
			    			</td>
			    			<td  class=tablebold >
			    			<%=bundle.getString("label.schedule.board")%>
			    			</td>
			    			<td class='tablebold'>:</td>
			    			<td><%=boardname %>
			    			</td>
	    			</tr>
	    			<tr>
	    			
		    			<td  class=tablebold width=20%>
		    			<%=bundle.getString("label.schedule.standardname")%>
		    			</td>
		    			<td class='tablebold'>:</td>
		    			<td ><%=standardname %></td>
		    			<td  class=tablebold width=20%>
		    			<%=bundle.getString("label.schedule.subjectname")%>
		    			</td>
		    			<td class='tablebold'>:</td>
		    			<td><%=subjectname %></td>
	    			</tr>
	    			</table></td></tr>
    			</tbody>
    			</table>		
						
						
			<br></br>
		<table   align='center' border='0' id=rounded-corner bordercolor=white width="100%" cellpadding=3 cellspacing=0>
			<thead>
			<tr>
				<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("hmlabel.subjectwise.slno")%></th>
				<th scope="col" class="rounded" width="30%"><%=bundle.getString("hmlabel.subjectwise.lessonname")%></th>
				<th scope="col" class="rounded-q4" width="20%"><%=bundle.getString("hmlabel.subjectwise.lessondesc")%></th>
			</tr>
			</thead>
		
		<tbody>
		<%
		int Totalstudent=0;
							if(LessonList != null && LessonList.size()>0)
								{
								for(int y=0,i=1;y<LessonList.size();y++,i++){
									hashmap		= (HashMap)LessonList.get(y);
									String lessonname=hashmap.get("lessonname")+"";
									String lessonscheduleid=hashmap.get("lessonscheduleid")+"";
									String lessonid=hashmap.get("lessonid")+"";
									String lessondescription=hashmap.get("lessondescription")+"";
									if(lessondescription.equals(""))
										lessondescription="-";
									out.print("<tr align=left  ><td>"+i+"</td>");
									out.println("<td align=left>"+lessonname+"</td>");
									out.println("<td>"+lessondescription+"</td>");
									out.println("</tr>");
								}
								}
							else
							{
								out.print("<tr><td colspan='3' class=tablebold align=center><font color=red>Data Not Found</font></td></tr>");

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

		 <a href="#" class="bt_blue" onclick='backfun()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("hmbutton.subjectwise.back")%></strong><span class="bt_blue_r"></span></a>
		 <input type=hidden name="boardname" value="<%=boardname %>">
		</form>		

    </div><!-- end of right content--> 


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>