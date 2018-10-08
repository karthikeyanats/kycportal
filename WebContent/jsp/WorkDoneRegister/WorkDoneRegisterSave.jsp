
<jsp:useBean id="query_object" scope="page"	class="com.iGrandee.WorkDoneRegister.WorkDoneRegisterEntry" />
<jsp:useBean id="instituteBean" scope="page" class="com.iGrandee.WorkDoneRegister.WorkDoneRegisterBean" />

 <%@ page language="java" import="java.util.ArrayList,java.util.HashMap" %>
 <%
 int count=0;
 
 String sessionid = request.getParameter("session");
	String standardid = request.getParameter("standard");
	String sectionid = request.getParameter("section");
	String subjectid = request.getParameter("subject");
	String lessonid = request.getParameter("lesson");
	String sectionname = request.getParameter("sectionname");
	String subjectname = request.getParameter("subjectname");
	String lessonname = request.getParameter("lessonname");
	String standardname = request.getParameter("standardname");
	String sessionname = request.getParameter("sessionname");
	String subjectcode = request.getParameter("subjectcode");
	String lessonscheduleid = request.getParameter("lessonscheduleid");
	
 	String workdonedetail = request.getParameter("workdonedetail");
 	String userid=(String)session.getValue("userid");
 	instituteBean.setLessonscheduleid(lessonscheduleid);
 	instituteBean.setCreatedby(userid);
 	instituteBean.setWorkdonedetails(workdonedetail);
 	instituteBean.setWorkdonestatus("A");
 	count=query_object.insertwrokdonedetails(instituteBean);
 	String message="";
 	if(count >0)
		message = "Successfully Work Done Inserted";
	else
		message = "Work Done insertion failed";	

		String return_file =request.getContextPath()+"/jsp/WorkDoneRegister/WorkDoneReply.jsp?sessionname="+sessionname+"&subjectname="+subjectname+"&lessonname="+lessonname+"&'lessonname="+lessonname+"&standardname="+standardname+"&subjectcode="+subjectcode+"&lessonscheduleid="+lessonscheduleid;
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+count+"&returnurl="+return_file);
	 	


 %>

