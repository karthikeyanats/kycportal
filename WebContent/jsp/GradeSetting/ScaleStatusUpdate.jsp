<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.GradeSetting.GradeScaleQuery" />
<jsp:useBean id="scaleBean" scope="page"
	class="com.iGrandee.GradeSetting.ScaleBean" />

<%@ page language="java" import="java.util.*"%>
<%
	String message="";
	String msgtemp="";
	String return_file="";
	int courseList=0;
	String temp_url="";
	String scalename=request.getParameter("scalename");
	String userid=session.getValue("userid")+"";
	String scaleid=request.getParameter("scaleid");
	String flage=request.getParameter("flage");
	String[] http=request.getParameterValues("http");
	
	
	scaleBean.setCreatedby(userid);
	scaleBean.setScalename(scalename);
	scaleBean.setScaleid(scaleid);
	if(flage.equals("Update"))
	{
		
		scaleBean.setScalestatus("A");
		 courseList = query_object.UpdateScale(scaleBean); 
		 if(courseList>0)
		 msgtemp="Updated";
	     else
		 msgtemp="Updation";
		 
		 return_file =request.getContextPath()+"/jsp/GradeSetting/ScaleView.jsp";

	 
	}
	else if(flage.equals("Trash"))
	{
		scaleBean.setScalestatus("T");
		courseList = query_object.UpdateScaleStatus(scaleBean);  
		if(courseList>0)
		msgtemp="Trashed";
	    else
		msgtemp="Trash";
		
		 return_file =request.getContextPath()+"/jsp/GradeSetting/ScaleView.jsp";

	}
	else if(flage.equals("Delete"))
	{
		scaleBean.setScalestatus("X");
		courseList = query_object.UpdateScaleStatus(scaleBean); 
		if(courseList>0)
		msgtemp="Deleted";
		else
		msgtemp="Deletion";
		
		return_file =request.getContextPath()+"/jsp/GradeSetting/ScaleTrashView.jsp";

	}
	else if(flage.equals("Restore"))
	{
		scaleBean.setScalestatus("A");
		courseList = query_object.UpdateScaleStatus(scaleBean); 
		if(courseList>0)
		msgtemp="Restored";
		else
		msgtemp="Restore";
		
		return_file =request.getContextPath()+"/jsp/GradeSetting/ScaleTrashView.jsp";

	}
	
	

	if(courseList == 1000)
	{
		message = "Scale Name Updation Failed, Scale Name is Already Exists";	
		courseList=0;
	}
	else if(courseList >0)
	{
		message = "Successfully Scale Name "+msgtemp;
	}
	else
	{
		message = "Scale Name "+msgtemp+" Failed";	
	}

	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	 	
 	%>
