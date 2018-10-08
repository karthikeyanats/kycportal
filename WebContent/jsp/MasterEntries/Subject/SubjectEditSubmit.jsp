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
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Standard.StandardBean,com.iGrandee.MasterEntries.Standard.StandardQuery"%>
<%
String instituteid = null;
String userid = null;
String reqstandardid = null;
String subjectid; 
String subjectname;
String credithours; 
String subjecttypeid;
String subjectcode;
int result=0;
String return_file = "";
com.iGrandee.MasterEntries.Subject.SubjectQuery  subjectQuery = new com.iGrandee.MasterEntries.Subject.SubjectQuery();
com.iGrandee.MasterEntries.Subject.SubjectBean subjectBean = new com.iGrandee.MasterEntries.Subject.SubjectBean();
String reqboardid = null;
String editstatus = null;
String boardname = null;
String standardname = null;
String standardid = null;String reqstandardname = null;

int insert					= 0;
String subjectduplicate		= "";
String subjectcodeduplicate	= "";

try
{
	 reqboardid = request.getParameter("reqboardid");
	 boardname = request.getParameter("reqboardname");
	 standardname = request.getParameter("reqstandardname");
	 standardid = request.getParameter("reqstandardid");
		instituteid = (String)session.getValue("instituteid");
		userid = (String)session.getValue("userid");
		
		subjectid = request.getParameter("subjectid");
		
	 	subjectname = request.getParameter("subjectname");
	 	credithours = request.getParameter("credithours");
	 	subjecttypeid = request.getParameter("subjecttype");
	 	editstatus = request.getParameter("EditStatus");
	 	subjectcode = request.getParameter("subjectcode");
	 	standardid = request.getParameter("reqstandardid");
	 	subjectBean.setStandardid(standardid);
		subjectBean.setSubjectid(subjectid);
	 	subjectBean.setSubjectname(subjectname);
		//subjectBean.setCredithours(credithours);
		subjectBean.setCredithours("0");
		subjectBean.setSubjectcode(subjectcode);
		subjectBean.setCreatedby(userid);
		subjectBean.setInstituteid(instituteid);
		subjectBean.setSubjecttypeid(subjecttypeid);
		return_file = request.getContextPath()+"/jsp/MasterEntries/Subject/SubjectCreation.jsp";
		insert=subjectQuery.updateSubjectDetail(subjectBean,editstatus);
		
		if(insert == 1000 || insert == 2000){
			if(insert == 1000)
				subjectduplicate	+= subjectname;
			else
				subjectcodeduplicate+= subjectcode;
		}
		else{
			result				+= insert;
		}
		

		
	String resultword = "";
	if(result >0){
		if(editstatus.equals("T"))
		{
			resultword="Subject Successfully Trashed";
		}
		else if(editstatus.equals("E"))
		{
			resultword="Subject Successfully Updated";
		}	
		else if(editstatus.equals("A"))
		{
			resultword="Subject Successfully Restored";
		}
		else if(editstatus.equals("X"))
		{
			resultword="Subject Successfully Deleted";
		}	
	}
	else
	{
		if(editstatus.equals("T"))
		{
			resultword="Subject Trash Failed";
		}
		else if(editstatus.equals("E"))
		{
			resultword="Subject Updation Failed";
		}	
		else if(editstatus.equals("A"))
		{
			resultword="Subject Restore Failed";
		}
		else if(editstatus.equals("X"))
		{
			resultword="Subject Deletion Failed";
		}	
	}
	
	if(subjectduplicate != null && subjectduplicate.length()>2){
		resultword	+= " The Subject Name already exists. "+subjectduplicate;
	}
	if(subjectcodeduplicate != null && subjectcodeduplicate.length()>2){
		resultword	+= " The Subject Code already exists. "+subjectcodeduplicate;
	}
	
	%>
	  <input type="hidden" name="reqboardid" value="<%=reqboardid%>">
      <input type="hidden" name="reqboardname" value="<%=boardname%>">
      <input type="hidden" name="reqstandardname" value="<%=standardname%>">
      <input type="hidden" name="reqstandardid" value="<%=standardid%>">
<input type="hidden" name="message" value="<%=resultword%>">
<input type="hidden" name="result" value="<%=result%>">
<input type="hidden" name="returnurl" value="<%=return_file%>">			
<%}
catch(Exception e){e.printStackTrace();}
%>
</form>
</body>
</html>
