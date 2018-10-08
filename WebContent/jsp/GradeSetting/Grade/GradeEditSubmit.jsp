<html>
<head>
<script language="javascript">
function loadResult()
{
	document.gradeForm.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
	document.gradeForm.submit();
}
</script>
</head>
<body onload=loadResult()>
<form name="gradeForm" action="" method="post">
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.GradeSetting.GradeBean,com.iGrandee.GradeSetting.GradeScaleQuery"%>
<%
String instituteid = null;
String userid = null;
String reqscaleid = null;
String gradeid; 
String gradename;
int result=0;
String return_file = "";
com.iGrandee.GradeSetting.GradeScaleQuery  gradescaleQuery = new com.iGrandee.GradeSetting.GradeScaleQuery();
com.iGrandee.GradeSetting.GradeBean gradeBean = new com.iGrandee.GradeSetting.GradeBean();
String reqboardid = null;
String editstatus = null;
String boardname = null;
String scalename = null;
String scaleid = null;String reqscalename = null;

int insert					= 0;
String gradeduplicate		= "";
String gradecodeduplicate	= "";

try
{
	 reqboardid = request.getParameter("reqboardid");
	 boardname = request.getParameter("reqboardname");
	 scalename = request.getParameter("reqscalename");
	 scaleid = request.getParameter("reqscaleid");
		instituteid = (String)session.getValue("instituteid");
		userid = (String)session.getValue("userid");
		
		gradeid = request.getParameter("gradeid");
		
		gradename = request.getParameter("gradename");
	 	editstatus = request.getParameter("EditStatus");
	 	scaleid = request.getParameter("reqscaleid");
	 	gradeBean.setScaleid(scaleid);
	 	gradeBean.setGradeid(gradeid);
	 	gradeBean.setGradename(gradename);
		gradeBean.setCreatedby(userid);
		gradeBean.setInstituteid(instituteid);
		return_file = request.getContextPath()+"/jsp/GradeSetting/Grade/GradeCreation.jsp";
		insert=gradescaleQuery.updateGradeDetail(gradeBean,editstatus);
		
		if(insert == 1000 || insert == 2000){
			if(insert == 1000)
				gradeduplicate	+= gradename;

		}
		else{
			result				+= insert;
		}
		

		
	String resultword = "";
	if(result >0){
		if(editstatus.equals("T"))
		{
			resultword="Grade Successfully Trashed";
		}
		else if(editstatus.equals("E"))
		{
			resultword="Grade Successfully Updated";
		}	
		else if(editstatus.equals("A"))
		{
			resultword="Grade Successfully Restored";
		}
		else if(editstatus.equals("X"))
		{
			resultword="Grade Successfully Deleted";
		}	
	}
	else
	{
		if(editstatus.equals("T"))
		{
			resultword="Grade Trash Failed";
		}
		else if(editstatus.equals("E"))
		{
			resultword="Grade Updation Failed";
		}	
		else if(editstatus.equals("A"))
		{
			resultword="Grade Restore Failed";
		}
		else if(editstatus.equals("X"))
		{
			resultword="Grade Deletion Failed";
		}	
	}
	
	if(gradeduplicate != null && gradeduplicate.length()>2){
		resultword	+= " The Grade Name already exists. "+gradeduplicate;
	}
	
	%>
	  <input type="hidden" name="reqboardid" value="<%=reqboardid%>">
      <input type="hidden" name="reqboardname" value="<%=boardname%>">
      <input type="hidden" name="reqscalename" value="<%=scalename%>">
      <input type="hidden" name="reqscaleid" value="<%=scaleid%>">
<input type="hidden" name="message" value="<%=resultword%>">
<input type="hidden" name="result" value="<%=result%>">
<input type="hidden" name="returnurl" value="<%=return_file%>">			
<%}
catch(Exception e){e.printStackTrace();}
%>
</form>
</body>
</html>
