<%
com.iGrandee.MasterEntries.Subject.SubjectQuery  subjectQuery = new com.iGrandee.MasterEntries.Subject.SubjectQuery();
com.iGrandee.MasterEntries.Subject.SubjectBean subjectBean = new com.iGrandee.MasterEntries.Subject.SubjectBean();
String[] theoryinternalmin;
String[] theoryinternalmax;
String[] theoryexternalmin;
String[] theoryexternalmax;
String[] projectinternalmin;
String[] projectinternalmax;
String[] projectexternalmin;
String[] projectexternalmax;

String[] practicalinternalmin;
String[] practicalinternalmax;
String[] practicalexternalmin;
String[] practicalexternalmax;
String[] subjectids;
String[] chk;
String return_file = "";
String reqgroupstatus = "";
String op="";
String reqboardid = null;
String reqboardname = null;
String reqstandardname = null;
int rows = 0;
String reqstandardid = null;
String message = null;
try
{		
reqstandardid = request.getParameter("reqstandardid");
reqstandardname = request.getParameter("reqstandardname");
reqgroupstatus = request.getParameter("reqgroupstatus");
reqboardid = request.getParameter("reqboardid");
reqboardname = request.getParameter("reqboardname");
	
theoryinternalmin = request.getParameterValues("theoryinternalmin");
theoryinternalmax = request.getParameterValues("theoryinternalmax");
theoryexternalmin = request.getParameterValues("theoryexternalmin");
theoryexternalmax = request.getParameterValues("theoryexternalmax");


practicalinternalmin = request.getParameterValues("practicalinternalmin");
practicalinternalmax = request.getParameterValues("practicalinternalmax");
practicalexternalmin = request.getParameterValues("practicalexternalmin");
practicalexternalmax = request.getParameterValues("practicalexternalmax");


projectinternalmin = request.getParameterValues("projectinternalmin");
projectinternalmax = request.getParameterValues("projectinternalmax");
projectexternalmin = request.getParameterValues("projectexternalmin");
projectexternalmax = request.getParameterValues("projectexternalmax");

subjectids = request.getParameterValues("subjectids");
chk = request.getParameterValues("chk");


for(int x=0;x<subjectids.length;x++)
{
		subjectBean.setTheoryinternalmin(theoryinternalmin[x]);
		subjectBean.setTheoryinternalmax(theoryinternalmax[x]);	
		subjectBean.setTheoryexternalmin(theoryexternalmin[x]);
		subjectBean.setTheoryexternalmax(theoryexternalmax[x]);
		subjectBean.setProjectinternalmin(practicalinternalmin[x]);
		subjectBean.setProjectinternalmax(practicalinternalmax[x]);
		subjectBean.setProjectexternalmin(practicalexternalmin[x]);
		subjectBean.setProjectexternalmax(practicalexternalmax[x]);
		subjectBean.setPracticalinternalmin(projectinternalmin[x]);
		subjectBean.setPracticalinternalmax(projectinternalmax[x]);
		subjectBean.setPracticalexternalmin(projectexternalmin[x]);
		subjectBean.setPracticalexternalmax(projectexternalmax[x]);
		subjectBean.setSubjectid(subjectids[x]);
		rows +=subjectQuery.updateSubjectMark(subjectBean);
}
if(rows > 0)
	message = "Mark Successfully Inserted";
else
	message = "Mark Insertion Failed";	


return_file =request.getContextPath()+"/jsp/MasterEntries/Subject/Marksettings.jsp";

}catch(Exception e){e.printStackTrace();}


%><html>
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
     	      <input type="hidden" name="reqstandardid" value="<%=reqstandardid %>">
     <input type="hidden" name="reqstandardname" value="<%=reqstandardname %>">
     <input type="hidden" name="reqboardid" value="<%=reqboardid %>">
     <input type="hidden" name="reqboardname" value="<%=reqboardname %>">
     <input type="hidden" name="reqgroupstatus" value="<%=reqgroupstatus %>">
     
    	      	  <input type="hidden" name="returnurl" value="<%=return_file%>">
    	      	  <input type=hidden name="reqgroupstatus" value="<%=reqgroupstatus %>">
    	      	  <input type="hidden" name="result" value="<%=rows %>">
    	      	  <input type="hidden" name="message" value="<%=message%>">
    	      	  

    	  
    	  
    	  
</form>
</body>
</html>
