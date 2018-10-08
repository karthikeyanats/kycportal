<html>
<head>
<script language="javascript">
function loadResult()
{
	document.submitlessonform.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
	document.submitlessonform.submit();
}
</script>
</head>
<body onload=loadResult()>
<form name="submitlessonform" action="" method="post">
<%@page import="com.iGrandee.Common.DateTime"%>
<%@page import="com.iGrandee.Content.ContentQurey"%>
<%@page import="com.iGrandee.Content.ContentBean"%>
<%@ page import="com.iGrandee.Content.ContentUpload,java.util.HashMap" %>
<%

String returnurl="";
try{
ContentBean beanobj = new ContentBean();
ContentQurey insertion =new ContentQurey();
DateTime dateobj=new DateTime();
String req_standardname    				= request.getParameter("req_standardname");
String standardscheduleid    			= request.getParameter("standardscheduleid");
String req_sessionname    				= request.getParameter("req_sessionname");
String req_boardname    				= request.getParameter("req_boardname");
String req_lessonname    				= request.getParameter("req_lessonname");
String req_subjectname    				= request.getParameter("req_subjectname");
String boardid    				        = request.getParameter("board");
String subjectid    				    = request.getParameter("req_subjectid");
String lessonscheduleid    				= request.getParameter("lessonscheduleid");
String sessionid    				    = request.getParameter("sessionid");
String lessonid      				    = request.getParameter("req_lessonid");
String cmscontentid      			    = request.getParameter("cmscontentid");
String editstatus      			        = request.getParameter("editstatus");
String cmscontentscheduleid      		= request.getParameter("cmscontentscheduleid");

beanobj.setLessonscheduleid(lessonscheduleid);
beanobj.setCmscontentid(cmscontentid);
beanobj.setEditstatus(editstatus);
beanobj.setCmscontentscheduleid(cmscontentscheduleid); 
/*
System.out.print("lessonscheduleid"+lessonscheduleid);
System.out.print("cmscontentid"+cmscontentid);
System.out.print("editstatus"+editstatus);
System.out.print("cmscontentscheduleid"+cmscontentscheduleid);*/
if(editstatus.equals("A"))
	returnurl=request.getContextPath()+"/jsp/ContentManagement/DeployedContentTrashList.jsp";
else
	returnurl=request.getContextPath()+"/jsp/ContentManagement/DeployedContentViewLesson.jsp";
int result=insertion.DeployedContentDataStatusupdation(beanobj);
String resultword="";
if(result >0)
{
	if(editstatus.equals("T"))
		resultword="Deployed Content Successfully Trashed";
	else if(editstatus.equals("A"))
		resultword="Content Successfully Redeployed";
	else
		resultword="Deployed Content Successfully Deleted";
}
else
{
	resultword="Operation Failed";
}
%>
<input type='hidden' name='req_subjectid' 		value='<%=subjectid %>'>
<input type='hidden' name='req_lessonid' 			value='<%=lessonid %>'>
<input type='hidden' name='standardscheduleid' 	value='<%=standardscheduleid %>'>
<input type='hidden' name='sessionid' 			value='<%=sessionid %>'>
<input type='hidden' name=cmscontentid 			value='<%=cmscontentid%>'>				    	
<input type='hidden' name='standard' 	value='<%=standardscheduleid %>'>
<input type='hidden' name='sessionname' 			value='<%=sessionid %>'>
<input type='hidden' name=board 			        value='<%=boardid%>'>
<input type='hidden' name='req_sessionname' 		value='<%=req_sessionname %>'>
<input type='hidden' name=req_boardname 			value='<%=req_boardname %>'>				    	
<input type='hidden' name='req_standardname' 		value='<%=req_standardname %>'>
<input type='hidden' name='req_subjectname' 		value='<%=req_subjectname %>'>
<input type='hidden' name=req_lessonname 			value='<%=req_lessonname%>'>
<input type='hidden' name=lessonscheduleid 			value='<%=lessonscheduleid%>'>
<input type="hidden" name="result" value="<%=result %>">
<input type="hidden" name="returnurl" value="<%=returnurl%>">
<input type="hidden" name="message" value="<%=resultword%>">
<%
}
catch(Exception e)
{
	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message=Opertion Failed&result=0&returnurl="+returnurl);
}
%>

			</form>
	</body>
</html>