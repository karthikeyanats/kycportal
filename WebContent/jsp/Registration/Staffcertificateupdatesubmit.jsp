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
<%@ page language="java" %>
<%@ page import="com.iGrandee.Registration.StaffRegistrationUpload" %>
<%@ page import="com.iGrandee.Registration.StaffRegistrationBean" %>
<%@ page import="com.iGrandee.Registration.StaffRegistrationQuery" %>
<%@ page import="com.iGrandee.Common.DateTime,java.util.HashMap" %>
<% 

String instituid=(String)session.getValue("instituteid");
String sessionuserid = "";
sessionuserid=(String)session.getValue("userid");
DateTime dateobj=new DateTime();
StaffRegistrationBean gen_qu=new StaffRegistrationBean();

StaffRegistrationQuery gen_query=new StaffRegistrationQuery();
StaffRegistrationUpload upload=new StaffRegistrationUpload(request);
HashMap photomap=upload.startProcessnew();

String photo ="";
String name ="";

if(photomap.size()>0)
{
	HashMap innermap=(HashMap)photomap.get("certificatemap0");
	photo = innermap.get("certificatepath")+"";
	name  = innermap.get("certificatename")+"";
}
int result=0;
String return_file=null;
String documentcreation=upload.getParameter("documentcreation")+"";
return_file = "./Registration/Staffverificationcertificateupdate.jsp";

if(!photo.equals("storage not connected"))
		{
	     	   String documentid []= {upload.getParameter("documentid"),""};
	   	   		String userid = upload.getParameter("personid");

	   	       gen_qu.setDocumentid(documentid);  
	   	       gen_qu.setDocumentName(upload.getParameter("certificatename"));  
	   	   	   if(!photo.equals("No photo Uploaded") )
		     	   {
		   	       		gen_qu.setDocumentpath(photo);  
		     	   }
		   	   else
			   	   {
				   		gen_qu.setDocumentpath(upload.getParameter("certificatepath"));  
			   	   }
	   	   	   if(documentcreation.equals("update"))
	   	   	   {
			       result=gen_query.Staffverificationcertificateupdate(gen_qu); 

	   	   	   }
	   	   	   else if(documentcreation.equals("creation"))
	   	   	   {
	   	   			gen_qu.setUserId(sessionuserid);
	   	   			gen_qu.setPersonId(userid);
			       result=gen_query.Staffverificationcertificateinsert(gen_qu);   
	   	   	   }
		   String     Staffid = upload.getParameter("Staffid");
		   String     departmentid = upload.getParameter("departmentid");
		   String     username = upload.getParameter("hiddenuser_id");


		      %>
		      <input type="hidden" name="personid" value="<%=userid %>" />
		      <input type="hidden" name="Staffid" value="<%=Staffid%>"/>
			  <input type="hidden" name="departmentid" value="<%=departmentid%>"/>
			  <input type="hidden" name="hiddenuser_id" value="<%=username%>"/>
			  <input type="hidden" name="deptname" value="<%=upload.getParameter("deptname")%>"/>
			  
		      <%
		
		}
		else
		{
			result=-1;
			return_file = "./Registration/Staff_List.jsp";
		}
		String resultword="";
		if(result>0)
		{
			if(documentcreation.equals("update"))
	   	   	   {
					resultword="Document Successfully Update";
	   	   	   }
	   	   	   else if(documentcreation.equals("creation"))
	   	   	   {
					resultword="Document Successfully Added";
	   	   	   }
		}
		else
		{
			if(result==-1)
				resultword="Updation  Failed Due to Storage Device not connected ";
			else
				resultword="Operation Failed";
		}		
		%>
	
<input type="hidden" name="result" value="<%=result %>">
<input type="hidden" name="returnurl" value="<%=return_file%>">
<input type="hidden" name="message" value="<%=resultword%>">

</form>
</body>
</html>

