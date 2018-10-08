<html>
<head>
<script>
function sub(status)
{
/*if(status==1)
{
alert("Successfully Inserted");
}
else if(status==0)
{
alert("Insertion Failed");
}
document.University.action="./SchoolRegistration.jsp";
document.University.submit();*/
}
</script>
</head>
<body>
<form name="University" method="post" action="">
<%@page import="com.iGrandee.Common.DateTime"%>
<%@page import="com.iGrandee.Content.ContentQurey"%>
<%@page import="com.iGrandee.Content.ContentBean"%>
<%@ page import="com.iGrandee.Content.ContentUpload,java.util.HashMap" %>
<%
ContentUpload cupload = new ContentUpload(request);
HashMap mainmap=cupload.startProcess();
HashMap pathmap=new HashMap();
HashMap namemap=new HashMap();
String name[]=null;
String path[]=null;

if(mainmap.size()>0)
{
	pathmap=(HashMap)mainmap.get("path");
	namemap=(HashMap)mainmap.get("name");
	name =new String[namemap.size()];
	path =new String[pathmap.size()];
}
if(pathmap.size()>0 && namemap.size()>0)
{
	for(int i=0;i<pathmap.size();i++)
	{
		path[i] =pathmap.get("path_"+(i+1))+"";
		name[i] =namemap.get("name_"+(i+1))+"";
	}
}

String returnurl="";
returnurl=request.getContextPath()+"/jsp/ContentManagement/contenthome.jsp";
try{
ContentBean beanobj = new ContentBean();
ContentQurey insertion =new ContentQurey();
DateTime dateobj=new DateTime();
String notes []       	 			= cupload.getParameterValues("notes");
String slidename []       	 		= cupload.getParameterValues("slidename");
String title []       	 			= cupload.getParameterValues("title");
String source []       	 			= cupload.getParameterValues("source");
String presentername []       	 	= cupload.getParameterValues("presentername");
String institutename []       	 	= cupload.getParameterValues("institutename");
String referenceurl []       	 	= cupload.getParameterValues("referenceurl");
String licensedby []       	 		= cupload.getParameterValues("licensedby");
String description []       	 	= cupload.getParameterValues("description");
String sessionid    				= cupload.getParameter("sessionid");
String subjectid        			= cupload.getParameter("req_subjectid");
String lessonid      				= cupload.getParameter("req_lessonid");
String sessionuserid=(String)session.getValue("userid");
beanobj.setCreatedby(sessionuserid);
if(!path[0].equals("storage not connected"))
{
beanobj.setFilepath(path);
beanobj.setFilename(name);
}
beanobj.setNotes(notes);
beanobj.setSlidename(slidename);

beanobj.setLessonid(lessonid);
beanobj.setSessionid(sessionid);
beanobj.setSubjectid(subjectid);
beanobj.setTitle(title);
beanobj.setSource(source);
beanobj.setPresentername(presentername);
beanobj.setInstitutename(institutename);
beanobj.setReferenceurl(referenceurl);
beanobj.setLicensedby(licensedby);
beanobj.setDescription(description); 
int result=0;
if(!path[0].equals("storage not connected"))
{
 result=insertion.ContenDataInsertion(beanobj);
}
else
{
	result=-1;
}
String resultword="";
if(result >0)
{
		resultword="Content Successfully Uploaded";
}
else
{
	if(result==-1)
	resultword="Insertion Failed Due to Storage Device not connected ";
	else
		resultword="Operation Failed";
	

		
}

	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+resultword+"&result="+result+"&returnurl="+returnurl);
}
catch(Exception e)
{
	e.printStackTrace();
	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message=Opertion Failed&result=0&returnurl="+returnurl);
}
%>
</form>
</body>
</html>