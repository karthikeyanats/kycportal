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
ContentUpload cupload = new ContentUpload(request);
HashMap mainmap=cupload.startProcessForSingle();
HashMap pathmap=new HashMap();
HashMap namemap=new HashMap();
String name="null";
String path="null";

if(mainmap.size()>0)
{
	path=mainmap.get("path")+"";
	name=mainmap.get("name")+"";
}
/*System.out.println(path);
System.out.println(name);
*/
String returnurl="";
returnurl=request.getContextPath()+"/jsp/ContentManagement/EditContentForLesson.jsp";
try{
ContentBean beanobj = new ContentBean();
ContentQurey insertion =new ContentQurey();
DateTime dateobj=new DateTime();
String req_standardname    				= cupload.getParameter("req_standardname");
String standardscheduleid    			= cupload.getParameter("standardscheduleid");
String req_sessionname    				= cupload.getParameter("req_sessionname");
String req_boardname    				= cupload.getParameter("req_boardname");
String req_lessonname    				= cupload.getParameter("req_lessonname");
String req_subjectname    				= cupload.getParameter("req_subjectname");
String boardid    				= cupload.getParameter("board");

String notes        	 			= cupload.getParameter("notes");
String sessionid    				= cupload.getParameter("sessionid");
String subjectid        			= cupload.getParameter("req_subjectid");
String lessonid      				= cupload.getParameter("req_lessonid");
String lessonscheduleid      		= cupload.getParameter("lessonscheduleid");

String cmscontentid      			= cupload.getParameter("cmscontentid");
String filepath      			    = cupload.getParameter("filepath")+"";
String filename      			    = cupload.getParameter("filename")+"";
String cmsmetainfoid      			= cupload.getParameter("cmsmetainfoid")+"";

String title []       	 			= cupload.getParameterValues("title");
String source []       	 			= cupload.getParameterValues("source");
String presentername []       	 	= cupload.getParameterValues("presentername");
String institutename []       	 	= cupload.getParameterValues("institutename");
String referenceurl []       	 	= cupload.getParameterValues("referenceurl");
String licensedby []       	 		= cupload.getParameterValues("licensedby");
String description []       	 	= cupload.getParameterValues("description");
String sessionuserid=(String)session.getValue("userid");
beanobj.setCreatedby(sessionuserid);
if(!path.equals("storage not connected"))
{
	if(path.equals("null") && name.equals("null") && !filepath.equals("null") && !filename.equals("null"))
	{
	beanobj.setSfilepath(filepath);
	beanobj.setSfilename(filename);
	}
	else
	{
		beanobj.setSfilepath(path);
		beanobj.setSfilename(name);
	}
}
beanobj.setCmsmetainfoid(cmsmetainfoid);
beanobj.setSnotes(notes);
beanobj.setLessonid(lessonid);
beanobj.setSessionid(sessionid);
beanobj.setSubjectid(subjectid);
beanobj.setCmscontentid(cmscontentid);
beanobj.setTitle(title);
beanobj.setSource(source);
beanobj.setPresentername(presentername);
beanobj.setInstitutename(institutename);
beanobj.setReferenceurl(referenceurl);
beanobj.setLicensedby(licensedby);
beanobj.setDescription(description);
returnurl=request.getContextPath()+"/jsp/ContentManagement/ContentViewLesson.jsp";
int result=0;
if(!path.equals("storage not connected"))
{
	 result=insertion.ContenDataupdation(beanobj);
}
else
{
	result=-1;
	returnurl=request.getContextPath()+"/jsp/ContentManagement/contenthome.jsp";

}
String resultword="";
if(result >0)
{
		resultword="Content Successfully Updated";
}
else
{
	if(result==-1)
		resultword="Updation Failed Due to Storage Drive not connected ";
		else
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