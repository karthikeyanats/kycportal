
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.GradeSetting.ScaleBean,com.iGrandee.GradeSetting.GradeScaleQuery"%>

<%
//com.iGrandee.MasterEntries.Standard.StandardQuery  standardQuery = new com.iGrandee.MasterEntries.Standard.StandardQuery();
//com.iGrandee.MasterEntries.Standard.StandardBean standardBean = new com.iGrandee.MasterEntries.Standard.StandardBean();
com.iGrandee.GradeSetting.GradeScaleQuery  gradescaleQuery = new com.iGrandee.GradeSetting.GradeScaleQuery();
com.iGrandee.GradeSetting.ScaleBean scaleBean = new com.iGrandee.GradeSetting.ScaleBean();

String scalename = "";
//String standarddescription = "";
String boardid = "";
String instituteid = null;
String userid = null;
//String groupstatus = null;
int no_of_rows= 0 ;
String return_file = null;
String message = "";
try
{
	instituteid = (String)session.getValue("instituteid");
	userid = (String)session.getValue("userid");
	scalename = request.getParameter("scalename");
	boardid = request.getParameter("standardboard");
	
	scaleBean.setScalename(scalename);
	scaleBean.setBoardid(boardid);
	scaleBean.setInstituteid(instituteid);
	scaleBean.setCreatedby(userid);
	no_of_rows = gradescaleQuery.insertScaleBoard(scaleBean); 
	if(no_of_rows ==1000)
	{
		message = "The Follwoing Scale Name Already Exists :"+scalename;
		no_of_rows=0;
	}
	else if(no_of_rows >0)
		message = "Scale Successfully Inserted";
	else
		message = "Scale Insertion Failed";
	
	
	return_file = request.getContextPath()+"/jsp/GradeSetting/Scale/ScaleCreation.jsp";
	
	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+no_of_rows+"&returnurl="+return_file);

		
}catch(Exception e){}	
	
	
%>