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
returnurl=request.getContextPath()+"/jsp/ContentManagement/EditContentForLesson.jsp";
try{
ContentBean beanobj = new ContentBean();
ContentQurey insertion =new ContentQurey();
String req_sessionname=request.getParameter("req_sessionname")+"";
String req_boardname=request.getParameter("req_boardname")+"";
String req_standardname=request.getParameter("req_standardname")+"";
String req_subjectname=request.getParameter("req_subjectname")+"";
String req_lessonname=request.getParameter("req_lessonname")+"";
String req_subjectid=request.getParameter("req_subjectid")+"";
String contentstaus =request.getParameter("contentstaus")+"";


String sessionid      			    = request.getParameter("sessionname");
String boardid      			    = request.getParameter("board");
String standardscheid      			= request.getParameter("standard");
String subjectscheid      			= request.getParameter("subject");
String lessonid      		        = request.getParameter("req_lessonid");
String lessonscheduleid      		= request.getParameter("lessonscheduleid");
String cmscontentidforallocation [] = request.getParameterValues("dep_cmscontentid");
beanobj.setLessonscheduleid(lessonscheduleid);
beanobj.setCmscontentidforallocation(cmscontentidforallocation);
String sessionuserid=(String)session.getValue("userid");
beanobj.setCreatedby(sessionuserid);
if(contentstaus.equals("current"))
{
returnurl=request.getContextPath()+"/jsp/ContentManagement/ContentViewLesson.jsp";
}
else if(contentstaus.equals("previous"))
{
	returnurl=request.getContextPath()+"/jsp/ContentManagement/ContentViewPrevioussession.jsp";
}
int result=insertion.ContenDataAllocation(beanobj);

String resultword="";
if(result >0)
{
		resultword="Content Successfully Deployed";
}
else
{
	resultword="Operation Failed";
}
%>

<input type='hidden' name='req_subjectid' 		value='<%=req_subjectid %>'>

<input type='hidden' name='req_sessionname' 		value='<%=req_sessionname %>'>
<input type='hidden' name=req_boardname 			value='<%=req_boardname %>'>				    	
<input type='hidden' name='req_standardname' 		value='<%=req_standardname %>'>
<input type='hidden' name='req_subjectname' 		value='<%=req_subjectname %>'>
<input type='hidden' name=req_lessonname 			value='<%=req_lessonname%>'>
<input type='hidden' name='subject' 		        value='<%=subjectscheid %>'>
<input type='hidden' name='req_lessonid' 			value='<%=lessonid%>'>
<input type='hidden' name='lessonscheduleid' 		value='<%=lessonscheduleid %>'>
<input type='hidden' name='standard' 	            value='<%=standardscheid %>'>
<input type='hidden' name='sessionname' 			value='<%=sessionid %>'>
<input type='hidden' name=board 			        value='<%=boardid%>'>
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