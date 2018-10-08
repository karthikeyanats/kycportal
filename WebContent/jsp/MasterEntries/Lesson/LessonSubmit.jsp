
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Standard.StandardBean,com.iGrandee.MasterEntries.Standard.StandardQuery"%>

<%

	String instituteid = null;
	String userid = null;
	String reqstandardid = null;
	String[] lessonname;
	String[] lessondescription; 
	int rows = 0;
	String return_file = "";
	String message="";
	com.iGrandee.MasterEntries.Lesson.LessonQuery  lessonQuery = new com.iGrandee.MasterEntries.Lesson.LessonQuery();
	com.iGrandee.MasterEntries.Lesson.LessonBean lessonBean = new com.iGrandee.MasterEntries.Lesson.LessonBean();
	String reqboardname			= null;
	String reqboardid			= null;
	String reqstandardname		= null;
	String reqsubjectname		= null;
	String reqsubjectid			= null;
	String reqgroupstatus 		= null;
	String resultword			= "";
	int insert					= 0;
	String subjectduplicate		= "";

	try
	{
		reqboardid 			= request.getParameter("reqboardid");
		reqboardname 		= request.getParameter("reqboardname");
		reqstandardname 	= request.getParameter("reqstandardname");
		reqstandardid 		= request.getParameter("reqstandardid");
		reqsubjectid 		= request.getParameter("reqsubjectid");
		reqsubjectname 		= request.getParameter("reqsubjectname");
	 	reqgroupstatus 		= request.getParameter("reqgroupstatus");
		instituteid 		= (String)session.getValue("instituteid");
		userid 				= (String)session.getValue("userid");
		lessonname 			= request.getParameterValues("lessonname");
		lessondescription 	= request.getParameterValues("lessondescription");
		 
		 
		
		for(int x=0;x<lessonname.length;x++)
		{
			if(!lessonname[x].equals(""))
			{
				lessonBean.setLessonname(lessonname[x]);
				lessonBean.setDescription(lessondescription[x]);
				lessonBean.setCreatedby(userid);
				lessonBean.setSubjectid(reqsubjectid);
				lessonBean.setLessonstatus("A");
				insert= lessonQuery.insertLesson(lessonBean);
				
				if(insert == 1000){
					subjectduplicate	+= lessonname[x]+",";
				}
				else{
					rows				+= insert;
				}
				
				
			}
		}
	
		if(rows>0)
			resultword="Lesson(s) Successfully Inserted ";
		else
			resultword="Lesson(s) Insertion Failed";
		
		if(subjectduplicate != null && subjectduplicate.length()>2){
			resultword	+= " The Following Lesson Name already exists. "+subjectduplicate.substring(0,subjectduplicate.length()-1);
		}

		//return_file = request.getContextPath()+"/jsp/MasterEntries/Lesson/LessonCreation.jsp?reqsubjectid="+reqsubjectid+"&reqboardname="+reqboardname+"&reqsubjectname="+reqsubjectname+"&reqstandardname="+reqstandardname;
			return_file = request.getContextPath()+"/jsp/MasterEntries/Lesson/LessonCreation.jsp";
		
			//response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+resultword+"&result="+rows+"&returnurl="+return_file);

		//response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+resultword+"&result="+rows+"&returnurl="+return_file);
	
	}catch(Exception e){e.printStackTrace();}

%>
<html>
<head>
<script language="javascript">
//function loadResult()
//{
	//document.submitlessonform.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
	//document.submitlessonform.submit();
//}
function loadResult()
{
	document.submitlessonform.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
	document.submitlessonform.submit();
}
</script>
</head>
<body onload=loadResult()>
<form name="submitlessonform" method="post">
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
