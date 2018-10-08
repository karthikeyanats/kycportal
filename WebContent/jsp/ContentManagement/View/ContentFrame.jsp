<html>
<%
   String subjectId=request.getParameter("SubjectList");
   String sessionname=request.getParameter("req_sessionname");
   String semesterId=request.getParameter("SemesterList");
   String courseId=request.getParameter("courseid");
   String boardname=request.getParameter("req_boardname");
   String sessionId=request.getParameter("sessionid");
   String standardname=request.getParameter("req_standardname");
   String subjectname=request.getParameter("req_subjectname");
   String frameSize=request.getParameter("framesize");
   String coursename=request.getParameter("coursename");
   String semestername=request.getParameter("semestername");
  
   	   session.putValue("SubjectList", subjectId);
       session.putValue("subjectname", subjectname);
       if(boardname!=null && standardname!=null )
       {
       session.putValue("boardname", boardname);
	   session.putValue("standardname", standardname); 
       }
	 /*  session.putValue("semestername", semestername);
	   session.putValue("sessionname", sessionname);
	 */ 
 
%>

<head>
<link rel="StyleSheet" href="<%= request.getContextPath() %>/css/kyccss.css" type="text/css" />
<title>Off Line Content View</title>
</head>

<input type=hidden name="SubjectList" value="<%=subjectId%>">
<input type=hidden name="SemesterList" value="<%=semesterId%>">
<input type=hidden name="CourseList" value="<%=courseId%>">
<input type=hidden name="yearOfSession" value="<%=sessionId%>">

<frameset frameborder="11" framespacing="0"  cols="*" rows="75,*">
    <frame marginwidth="5" marginheight="5" src="../View/TreeReport/menu_empty.jsp" name="heading" noresize scrolling="no">
    <%
        if(frameSize != null)
        {
			frameSize=frameSize;
		}
		else
		{
			frameSize="220";
		}
     %>

		<frameset frameborder="11" framespacing="0" border="0" cols="<%=frameSize%>,*" rows="*">
			<frameset frameborder="0" framespacing="0" border="0" cols="*" rows="0,*">
				<frame frameborder="0" marginwidth="0" marginheight="0" name="code" noresize scrolling="no" frameborder="0" marginwidth=50 >
				<frame frameborder="0" marginwidth="5" marginheight="5" src="LessonTree.jsp?req_subjectscheduleid=<%=request.getParameter("req_subjectscheduleid")%>&req_subjectname=<%=request.getParameter("req_subjectname")%>" name="menu" noresize scrolling="auto">
			</frameset>
			
		<frame marginwidth="5" marginheight="5" src="ViewContent.jsp?SubjectList=<%=request.getParameter("req_subjectscheduleid")%>&subjectname1=<%=request.getParameter("req_subjectname")%>" name="clientpanel" noresize>
		</frameset>

	<noframes>
		<p>The <code>NOFRAMES</code> element is to be used to give useful content to people with browsers that cannot display frames.  One example is Lynx, a text-based browser.</p>
	</noframes>
</frameset>

</html>

