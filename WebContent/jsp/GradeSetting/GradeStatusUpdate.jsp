<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.GradeSetting.GradeScaleQuery" />
<jsp:useBean id="gradeBean" scope="page"
	class="com.iGrandee.GradeSetting.GradeBean" />

<%@ page language="java" import="java.util.*"%>
<%
	String message="";
	String msgtemp="";
	String return_file="";
	int courseList=0;
	String temp_url="";
	String gradename=request.getParameter("gradename");
	String userid=session.getValue("userid")+"";
	String gradeid=request.getParameter("gradeid");
	String flage=request.getParameter("flage");
	String[] http=request.getParameterValues("http");
	
	
	gradeBean.setCreatedby(userid);
	gradeBean.setGradename(gradename);
	gradeBean.setGradeid(gradeid);
	if(flage.equals("Update"))
	{
		
		 gradeBean.setGradestatus("A");
		 courseList = query_object.UpdateGrade(gradeBean); 
		 if(courseList>0)
		 msgtemp="Updated";
	     else
		 msgtemp="Updation";
		 
		 return_file =request.getContextPath()+"/jsp/GradeSetting/GradeView.jsp";

	 
	}
	else if(flage.equals("Trash"))
	{
		gradeBean.setGradestatus("T");
		courseList = query_object.UpdateGradeStatus(gradeBean);  
		if(courseList>0)
		msgtemp="Trashed";
	    else
		msgtemp="Trash";
		
		 return_file =request.getContextPath()+"/jsp/GradeSetting/GradeView.jsp";

	}
	else if(flage.equals("Delete"))
	{
		gradeBean.setGradestatus("X");
		courseList = query_object.UpdateGradeStatus(gradeBean); 
		if(courseList>0)
		msgtemp="Deleted";
		else
		msgtemp="Deletion";
		
		return_file =request.getContextPath()+"/jsp/GradeSetting/GradeTrashView.jsp";

	}
	else if(flage.equals("Restore"))
	{
		gradeBean.setGradestatus("A");
		courseList = query_object.UpdateGradeStatus(gradeBean); 
		if(courseList>0)
		msgtemp="Restored";
		else
		msgtemp="Restore";
		
		return_file =request.getContextPath()+"/jsp/GradeSetting/GradeTrashView.jsp";

	}
	
	

	if(courseList == 1000)
	{
		message = "Grade Name Updation Failed, Grade Name is Already Exists";	
		courseList=0;
	}
	else if(courseList >0)
	{
		message = "Successfully Grade Name "+msgtemp;
	}
	else
	{
		message = "Grade Name "+msgtemp+" Failed";	
	}

	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	 	
 	%>
