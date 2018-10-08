
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Standard.StandardBean,com.iGrandee.MasterEntries.Standard.StandardQuery"%>

<%
String instituteid = null;
String userid = null;
String reqstandardid = null;
String lessonname;
String lessondescription; 
int rows = 0;
String return_file = "";
String op="";
com.iGrandee.MasterEntries.Lesson.LessonQuery  lessonQuery = new com.iGrandee.MasterEntries.Lesson.LessonQuery();
com.iGrandee.MasterEntries.Lesson.LessonBean lessonBean = new com.iGrandee.MasterEntries.Lesson.LessonBean();
String reqboardname=null;
String reqboardid=null;
String reqstandardname=null;
String reqsubjectname=null;
String reqsubjectid=null;
String reqgroupstatus = null;
String lessonid = null;
String EditStatus = null;
String resultword = null;
int insert					= 0;
String subjectduplicate		= "";


try
{
	 reqboardid = request.getParameter("reqboardid");
	 reqboardname = request.getParameter("reqboardname");
	 reqstandardname = request.getParameter("reqstandardname");
	 reqstandardid = request.getParameter("reqstandardid");
	 reqsubjectid = request.getParameter("reqsubjectid");
	 reqsubjectname = request.getParameter("reqsubjectname");
	 reqgroupstatus = request.getParameter("reqgroupstatus");
	 instituteid = (String)session.getValue("instituteid");
	 EditStatus = request.getParameter("EditStatus");

		userid = (String)session.getValue("userid");
		lessonid    = request.getParameter("lessonid");
		lessonname  = request.getParameter("lessonname");
	 	lessondescription = request.getParameter("lessondescription");
		lessonBean.setLessonid(lessonid);
		lessonBean.setLessonname(lessonname);
		lessonBean.setDescription(lessondescription);
		lessonBean.setCreatedby(userid);
		lessonBean.setSubjectid(reqsubjectid);
		lessonBean.setLessonstatus(EditStatus);
		if(EditStatus.equals("E"))
		{
			insert = lessonQuery.updateLesson(lessonBean);
			
			if(insert == 1000){
				subjectduplicate	+= lessonname;
			}
			else{
				rows				+= insert;
			}
		
		}
		else if(EditStatus.equals("T") || EditStatus.equals("A") || EditStatus.equals("X"))
		{
			rows = lessonQuery.updateLessonStatus(lessonBean);
		}
		if(rows>0)
		{
		if(EditStatus.equals("T"))
		{
			resultword="Lesson Successfully Trashed";
		}
		else if(EditStatus.equals("E"))
		{
			resultword="Lesson Successfully Updated";
		}	
		else if(EditStatus.equals("A"))
		{
			resultword="Lesson Successfully Restored";
		}
		else if(EditStatus.equals("X"))
		{
			resultword="Lesson Successfully Deleted";
		}	
	}
	else
	{
		if(EditStatus.equals("T"))
		{
			resultword="Lesson Trash Failed";
		}
		else if(EditStatus.equals("E"))
		{
			resultword="Lesson Updation Failed ";
		}	
		else if(EditStatus.equals("A"))
		{
			resultword="Lesson Restore Failed";
		}
		else if(EditStatus.equals("X"))
		{
			resultword="Lesson Deletion Failed";
		}	
		
	}
		
		if(subjectduplicate != null && subjectduplicate.length()>2){
			resultword	+= "  Lesson Name Already Exist. "+subjectduplicate;
		}
		
		return_file = "./MasterEntries/Lesson/LessonCreation.jsp";
	
}catch(Exception e){e.printStackTrace();}

%>
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
<input type="hidden" name="result" value="<%=rows %>">
     	  <input type="hidden" name="reqstandardid" value="<%=reqstandardid%>">
    	  <input type="hidden" name="reqstandardname" value="<%=reqstandardname%>">
    	  <input type="hidden" name="reqboardid" value="<%=reqboardid%>">
    	  <input type="hidden" name="reqboardname" value="<%=reqboardname%>">
    	  <input type="hidden" name="reqsubjectid" value="<%=reqsubjectid%>">
    	  <input type="hidden" name="reqsubjectname" value="<%=reqsubjectname%>">
      	  <input type="hidden" name="returnurl" value="<%=return_file%>">
      	  <input type=hidden name="reqgroupstatus" value="<%=reqgroupstatus %>">
      	  <input type="hidden" name="message" value="<%=resultword%>">
</form>
</body>
</html>
