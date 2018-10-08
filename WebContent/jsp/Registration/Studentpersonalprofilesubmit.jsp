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
<%@ page import="com.iGrandee.Registration.StudentRegistrationUpload" %>
<%@ page import="com.iGrandee.Registration.StudentRegistrationBean" %>
<%@ page import="com.iGrandee.Registration.StudentRegistrationQuery" %>

<%@ page import="com.iGrandee.Common.DateTime,java.util.ResourceBundle,java.io.File" %>

<% 

String instituid=(String)session.getValue("instituteid");
String sessionuserid = "";
sessionuserid=(String)session.getValue("userid");

DateTime dateobj=new DateTime();
StudentRegistrationBean gen_qu=new StudentRegistrationBean();

StudentRegistrationQuery gen_query=new StudentRegistrationQuery();
StudentRegistrationUpload upload=new StudentRegistrationUpload(request);
String photo=upload.startProcess()+"";
int result=0;
String return_file=null;
return_file = "./Registration/Studentpersonalprofileupdate.jsp";
String studentapprovalid="-";
if(!photo.equals("storage not connected"))
		{
		  String userid = null;
	      String username = null;
		  String applicantname = null;
	      String fathername = null;
	      String mothername = null;
	      String dob = null;
	    
	      String nationality = null;
	      String community = null;
	      String religion = null;
	      String language = null;
	      String bloodgroup = null;
	      String lastname = null;
	      String middlename = null;
	      String sex = null;
	      String age = null;
	      
	      userid = upload.getParameter("personid");
	      username = upload.getParameter("studusernamehidden");
	       applicantname = upload.getParameter("studentname");
	       fathername = upload.getParameter("fathername");
	       mothername = upload.getParameter("mothername");
	       dob = upload.getParameter("dateofbirth");
	       String prefix = upload.getParameter("slt_prefix");
	       studentapprovalid= upload.getParameter("stundentapproveid");
	       String txtdob=dateobj.getMySQLFormat(dob)+"";
	       //System.out.println("txtdob"+txtdob);
	   	   String   hiddenphoto = upload.getParameter("studuserphoto");

	       nationality = upload.getParameter("nationality");
	       community = upload.getParameter("community");
	       religion = upload.getParameter("religion");
	       language = upload.getParameter("mothertonque");
	       bloodgroup = upload.getParameter("bloodgroup");
	       
	        lastname  = upload.getParameter("lastname");
		       middlename  = upload.getParameter("middlername");
		       sex  = upload.getParameter("studsex");
		       age = upload.getParameter("age");
		       gen_qu.setStudprefix(prefix);

		       gen_qu.setStudlastname(lastname);
		      	gen_qu.setStudmiddlename(middlename);
		        gen_qu.setStudsex(sex);
		        gen_qu.setStudage(age);
	       gen_qu.setUserid(userid);
	      	gen_qu.setApplicantname(applicantname);
	        gen_qu.setFathername(fathername);
	        gen_qu.setMothername(mothername);
	        gen_qu.setDob(txtdob);
	       
	        if(photo!=null && !photo.equals("null"))
	        {
	        	gen_qu.setPhoto(photo);
	        }
	        else
	        {
		        gen_qu.setPhoto(hiddenphoto);
	        }
	        String  phototype = upload.getParameter("phototype");   

		    if(phototype.equalsIgnoreCase("snapshot"))
		    {
		    	ResourceBundle  rbundle = ResourceBundle.getBundle("resources.serversetup");
		    	String shapshotpath=rbundle.getString("shapshot");
		    	String imagePath=rbundle.getString("storagepath")+"/imagestorage/";
		    	String imageName="studentimage_"+studentapprovalid+".jpg"; 
		    	File src=new File(imagePath+imageName);
		    	String newphotopath=photo.substring(0, photo.lastIndexOf("/"));
		    	File dst=new File(rbundle.getString("storagepath")+newphotopath);
		    	if(!dst.exists())
		    		dst.mkdirs();
		    	File dst2=new File(rbundle.getString("storagepath")+photo);
		    	dst2.createNewFile();
		    	java.io.InputStream in1 = new java.io.FileInputStream(src);
		    	java.io.OutputStream out1 = new java.io.FileOutputStream(dst2);
		    	
		         // Transfer bytes from in to out
		         byte[] buf = new byte[1024];
		         int len;
		         while ((len = in1.read(buf)) > 0) {
		             out1.write(buf, 0, len);
		         }  
		         in1.close();
		         out1.close();	
		         //src.delete();
		     }
	        gen_qu.setNationality(nationality);
	        gen_qu.setCommunity(community);
	      	gen_qu.setReligion(religion);
	        gen_qu.setLanguage(language);
		    //System.out.println("bloodgroup"+bloodgroup);
	        gen_qu.setBloodgroup(bloodgroup);
		      %>
		    <input type="hidden" name="personid" value="<%=userid%>" />
		    <input type="hidden" name="usernameforcheck" value="<%=username%>" />
		    <input type="hidden" name="studentprofileedit" value="<%=upload.getParameter("studentprofileedit")%>">
			<input type=hidden   name=session value="<%=upload.getParameter("session")%>">
			<input type=hidden   name=board value="<%=upload.getParameter("board")%>">
			<input type=hidden   name=standardscheduleid value="<%=upload.getParameter("standardscheduleid")%>">
			<input type=hidden   name=sectionscheduleid value="<%=upload.getParameter("sectionscheduleid")%>">
			<input type="hidden" name="req_sessionname" value="<%=upload.getParameter("req_sessionname")%>">
			<input type="hidden" name="req_sessionstatus" value="<%=upload.getParameter("req_sessionstatus")%>">
			<input type="hidden" name="req_boardname" value="<%=upload.getParameter("req_boardname")%>">
			<input type="hidden" name="req_standardnamegp" value="<%=upload.getParameter("req_standardnamegp")%>">
			<input type="hidden" name="req_sectionname" value="<%=upload.getParameter("req_sectionname")%>">
			<input type="hidden" name="req_studentname" value="<%=upload.getParameter("req_studentname")%>">
		      <%
	
		result=gen_query.Studentpersonalprofileupdate(gen_qu);
		}
		else
		{
			result=-1;
			return_file = "./Registration/RegisteredStudentList.jsp";

		}
		String resultword="";
		if(result>0)
		{
			resultword="Student Personal Profile Successfully Updated";
		}
		else
		{
			if(result==-1)
				resultword="Updation  Failed Due to Storage Device not connected ";
				else
					resultword="Operation Failed";		}

		%>
<input type="hidden" name="stundentapproveid" value="<%=studentapprovalid%>"> 
<input type="hidden" name="result" value="<%=result %>">
<input type="hidden" name="returnurl" value="<%=return_file%>">
<input type="hidden" name="message" value="<%=resultword%>">

</form>
</body>
</html>

