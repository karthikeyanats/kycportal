<html>
<head>
<script language="javascript">
function loadResult()
{
	document.applicationForm.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
	document.applicationForm.submit();
}
</script>
</head>
<body onload=loadResult()>
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.GradeSetting.ScaleBean,com.iGrandee.GradeSetting.GradeScaleQuery"%>
<%
com.iGrandee.GradeSetting.GradeScaleQuery  gradescaleQuery = new com.iGrandee.GradeSetting.GradeScaleQuery();
com.iGrandee.GradeSetting.ScaleBean scaleBean = new com.iGrandee.GradeSetting.ScaleBean();
String scalename = "";
String boardid = "";
String instituteid = null;
String userid = null;
int no_of_rows= 0 ;
String message = "";
String return_file = null;
String reqscaleid = null;
String updateoperation = null;
String requeststatus = null;
try
{
	instituteid = (String)session.getValue("instituteid");
	userid = (String)session.getValue("userid");
	boardid = request.getParameter("reqboardid");
	
	updateoperation = request.getParameter("scaleoperation");
	if(updateoperation.equals("UpdateScale"))
	{
		scalename = request.getParameter("scalename");
		reqscaleid = request.getParameter("reqscaleid");
	
	//out.println(reqstandardid+"<br>");
	//out.println(boardid+"<br>");
	//out.println(reqstandardid+"<br>");
	
	
	scaleBean.setScaleid(reqscaleid);
	scaleBean.setScalename(scalename);
	scaleBean.setBoardid(boardid);
	scaleBean.setInstituteid(instituteid);

	no_of_rows = gradescaleQuery.updateScale(scaleBean);
	if(no_of_rows ==1000)
	{
		message = "The Following Scale Name Already Exists :"+scalename;
		no_of_rows=0;
	}
	else if(no_of_rows >0)
		message = "Scale Successfully Updated";
	else
		message = "Scale Updation Failed";
	
	return_file =request.getContextPath()+"/jsp/GradeSetting/Scale/ScaleList.jsp";
	}
	else if(updateoperation.equals("UpdateScaleStatus"))
	{
		reqscaleid = request.getParameter("reqscaleid");
		requeststatus = request.getParameter("requeststatus");
		
		scaleBean.setScaleid(reqscaleid);
		scaleBean.setScalestatus(requeststatus);
		no_of_rows = gradescaleQuery.updateScaleStatus(scaleBean); 
		if(requeststatus.equals("T"))
		{
			return_file =request.getContextPath()+"/jsp/GradeSetting/Scale/ScaleStatusList.jsp";
			if(no_of_rows >0)
				message = "Scale Successfully Trashed";
			else
				message = "Scale Trash Failed";
		}
		if(requeststatus.equals("X"))
		{
			return_file =request.getContextPath()+"/jsp/GradeSetting/Scale/ScaleList.jsp";
			if(no_of_rows >0)
				message = "Scale Successfully Deleted";
			else
				message = "Scale Deletion Failed";
		}
		
		if(requeststatus.equals("A"))
		{
			return_file =request.getContextPath()+"/jsp/GradeSetting/Scale/ScaleList.jsp";
			if(no_of_rows >0)
			message = "Scale Successfully Restored";
			else
			message = "Scale Restore Failed";
			
		}
		if(requeststatus.equals("D"))
		{
			return_file =request.getContextPath()+"/jsp/GradeSetting/Scale/ScaleList.jsp";
			if(no_of_rows >0)
			message = "Scale Successfully Deleted";
			else
			message = "Scale Deletion Failed";
			
		}
	}
		
	//response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+no_of_rows+"&returnurl="+return_file+"&reqboardid="+boardid);

		
}catch(Exception e){}	
	
	
%>
<form name="applicationForm" action="" method="post">
<input type="hidden" name="result" value="<%=no_of_rows %>">
<input type="hidden" name="returnurl" value="<%=return_file%>">
<input type="hidden" name="message" value="<%=message%>">
<input type="hidden" name="reqboardid" value="<%=boardid%>">

</form>
</body>
</html>