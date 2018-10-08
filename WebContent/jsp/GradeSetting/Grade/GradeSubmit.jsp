<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.GradeSetting.GradeBean,com.iGrandee.GradeSetting.GradeScaleQuery"%>

<%
	String instituteid 		= null;
	String userid 			= null;
	String reqscaleid 	= null;
	String[] gradeid		= null; 
	String[] gradename	= null;
	int rows 				= 0;
	String return_file 		= "";
	String op				= "";
	String reqboardid 		= null;
	String reqboardname 	= null;
	String reqscalename 	= null;
	String resultword		= "";
	//com.iGrandee.MasterEntries.Subject.SubjectQuery  subjectQuery 	= new com.iGrandee.MasterEntries.Subject.SubjectQuery();
	//com.iGrandee.MasterEntries.Subject.SubjectBean subjectBean 		= new com.iGrandee.MasterEntries.Subject.SubjectBean();
	com.iGrandee.GradeSetting.GradeScaleQuery  gradescaleQuery = new com.iGrandee.GradeSetting.GradeScaleQuery();
	com.iGrandee.GradeSetting.GradeBean gradeBean = new com.iGrandee.GradeSetting.GradeBean();
	int insert					= 0;
	String gradeduplicate		= "";
	
	try
	{
		instituteid 		= (String)session.getValue("instituteid");
		userid 				= (String)session.getValue("userid");
		reqscaleid 		= request.getParameter("reqscaleid");
		reqscalename 	= request.getParameter("reqscalename");
		gradeid 			= request.getParameterValues("gradeid");
		gradename 		= request.getParameterValues("gradename");
		reqboardid 			= request.getParameter("reqboardid");
		reqboardname 		= request.getParameter("reqboardname");
		 
		
		for(int x=0;x<gradename.length;x++)
		{
			if(!gradename[x].equals(""))
			{
				gradeBean.setGradename(gradename[x]);
				gradeBean.setCreatedby(userid);
				gradeBean.setInstituteid(instituteid);
				gradeBean.setScaleid(reqscaleid); 
				insert	= gradescaleQuery.insertGradeFromScale(gradeBean);
				
				if(insert == 1000 || insert == 2000){
					if(insert == 1000)
						gradeduplicate	+= gradename[x]+",";
				}
				else{
					rows				+= insert;
				}
			}
		}
		
		return_file = "./GradeSetting/Grade/GradeCreation.jsp";
		if(rows>0)
			resultword	= "Grade(s) Successfully Inserted";
		else
			resultword	="Grade(s) Insertion Failed.";
		
		if(gradeduplicate != null && gradeduplicate.length()>2){
			resultword	+= " The Following Grade Name already exists. "+gradeduplicate.substring(0,gradeduplicate.length()-1);
		}

		
		
	}catch(Exception e){e.printStackTrace();}

%>
<html>
<head>
<script language="javascript">
function loadResult()
{
	document.gradeform.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
	document.gradeform.submit();
}
</script>
</head>
<body onload=loadResult()>
<form name="gradeform" action="" method="post">
<input type="hidden" name="result" value="<%=rows %>">
     	  <input type="hidden" name="reqscaleid" value="<%=reqscaleid%>">
    	  <input type="hidden" name="reqscalename" value="<%=reqscalename%>">
    	  <input type="hidden" name="reqboardid" value="<%=reqboardid%>">
    	  <input type="hidden" name="reqboardname" value="<%=reqboardname%>">
    	      	  <input type="hidden" name="returnurl" value="<%=return_file%>">
    	  <input type="hidden" name="message" value="<%=resultword%>">

    	  
    	  
    	  
</form>
</body>
</html>
