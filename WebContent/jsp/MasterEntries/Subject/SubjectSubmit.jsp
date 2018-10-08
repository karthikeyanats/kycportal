<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Standard.StandardBean,com.iGrandee.MasterEntries.Standard.StandardQuery"%>

<%
	String instituteid 		= null;
	String userid 			= null;
	String reqstandardid 	= null;
	String[] subjectid		= null; 
	String[] subjectname	= null;
	String[] credithours	= null; 
	String[] subjecttypeid	= null;
	String[] subjectcode	= null;
	int rows 				= 0;
	String return_file 		= "";
	String reqgroupstatus 	= "";
	String op				= "";
	String reqboardid 		= null;
	String reqboardname 	= null;
	String reqstandardname 	= null;
	String resultword		= "";
	com.iGrandee.MasterEntries.Subject.SubjectQuery  subjectQuery 	= new com.iGrandee.MasterEntries.Subject.SubjectQuery();
	com.iGrandee.MasterEntries.Subject.SubjectBean subjectBean 		= new com.iGrandee.MasterEntries.Subject.SubjectBean();
	int insert					= 0;
	String subjectduplicate		= "";
	String subjectcodeduplicate	= "";
	
	try
	{
		instituteid 		= (String)session.getValue("instituteid");
		userid 				= (String)session.getValue("userid");
		reqstandardid 		= request.getParameter("reqstandardid");
		reqstandardname 	= request.getParameter("reqstandardname");
		subjectid 			= request.getParameterValues("subjectid");
		subjectname 		= request.getParameterValues("subjectname");
		credithours 		= request.getParameterValues("credithours");
		subjecttypeid 		= request.getParameterValues("subjecttype");
		subjectcode 		= request.getParameterValues("subjectcode");
		reqgroupstatus 		= request.getParameter("reqgroupstatus");
		reqboardid 			= request.getParameter("reqboardid");
		reqboardname 		= request.getParameter("reqboardname");
		 
		
		for(int x=0;x<subjectname.length;x++)
		{
			if(!subjectname[x].equals(""))
			{
				subjectBean.setSubjectname(subjectname[x]);
				//subjectBean.setCredithours(credithours[x]);
				subjectBean.setCredithours("0");
				subjectBean.setSubjectcode(subjectcode[x]);
				subjectBean.setCreatedby(userid);
				subjectBean.setInstituteid(instituteid);
				subjectBean.setStandardid(reqstandardid);
				subjectBean.setSubjecttypeid(subjecttypeid[x]);
				insert	= subjectQuery.insertSubject(subjectBean);
				
				if(insert == 1000 || insert == 2000){
					if(insert == 1000)
						subjectduplicate	+= subjectname[x]+",";
					else
						subjectcodeduplicate+= subjectcode[x]+",";
				}
				else{
					rows				+= insert;
				}
			}
		}
		
		return_file = "./MasterEntries/Subject/SubjectCreation.jsp";
		if(rows>0)
			resultword	= "Subject(s) Successfully Inserted";
		else
			resultword	="Subject(s) Insertion Failed.";
		
		if(subjectduplicate != null && subjectduplicate.length()>2){
			resultword	+= " The Following Subject Name already exists. "+subjectduplicate.substring(0,subjectduplicate.length()-1);
		}
		if(subjectcodeduplicate != null && subjectcodeduplicate.length()>2){
			resultword	+= " The Following Subject Code already exists. "+subjectcodeduplicate.substring(0,subjectcodeduplicate.length()-1);
		}
		
		
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
    	      	  <input type="hidden" name="returnurl" value="<%=return_file%>">
    	      	  <input type=hidden name="reqgroupstatus" value="<%=reqgroupstatus %>">
    	  <input type="hidden" name="message" value="<%=resultword%>">

    	  
    	  
    	  
</form>
</body>
</html>
