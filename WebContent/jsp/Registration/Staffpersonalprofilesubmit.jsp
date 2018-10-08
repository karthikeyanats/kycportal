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
<%@ page import="com.iGrandee.Common.DateTime,java.util.HashMap,java.io.File,java.util.ResourceBundle" %>
<% 
  
String instituid=(String)session.getValue("instituteid");
String sessionuserid = "";
sessionuserid=(String)session.getValue("userid");
DateTime dateobj=new DateTime();
StaffRegistrationBean gen_qu=new StaffRegistrationBean();

StaffRegistrationQuery gen_query=new StaffRegistrationQuery();
StaffRegistrationUpload upload=new StaffRegistrationUpload(request);
HashMap photomap=upload.startProcess();
String photo = photomap.get("personphoto")+"";
String  phototype = upload.getParameter("phototype");   

if(phototype.equalsIgnoreCase("snapshot"))
{
	ResourceBundle  rbundle = ResourceBundle.getBundle("resources.serversetup");
	String shapshotpath=rbundle.getString("shapshot");
	String imagePath=rbundle.getString("storagepath")+"/imagestorage/";
	String imageName="StaffPersonalImage.jpg"; 
	File src=new File(imagePath+imageName);
	if(src.exists() && src.isFile())
	{
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
	     src.delete();
	}
 }

int result=0;
String return_file=null;

return_file = "./Registration/Staffpersonalprofileupdate.jsp";

if(!photo.equals("storage not connected"))
		{
		  String staffpersonid = null;
	      String username = null;
	      String prefix = null;
		  String fname = null;
		  String mname = null;
		  String lname = null;

	      String fathername = null;
	      String mothername = null;
	      
	      String dob = null;
	      
	        
	      String sex = null;
	      String age = null;
	      String qualification = null;
	      String staffmarital = null;
	      
	     String Staffid = upload.getParameter("Staffid");

	      staffpersonid = upload.getParameter("staffpersonid");
	       username = upload.getParameter("studusernamehidden");
	       
	       fname = upload.getParameter("studentname");
	       lname  = upload.getParameter("lastname");
	       mname  = upload.getParameter("middlername");
	       String departmentid  = upload.getParameter("departmentid");

	       
	       fathername = upload.getParameter("fathername");
	       mothername = upload.getParameter("mothername");
	       qualification= upload.getParameter("qualification");
	       dob = upload.getParameter("dateofbirth");
	       sex  = upload.getParameter("studsex");
	       age = upload.getParameter("age");
	       prefix = upload.getParameter("slt_prefix");
	       staffmarital= upload.getParameter("staffmarital");
	       String txtdob=dateobj.getMySQLFormat(dob)+"";


	       //System.out.println("txtdob"+txtdob);
	       
	   	   String   hiddenphoto = upload.getParameter("studuserphoto");

		       gen_qu.setprefix(prefix);
			   gen_qu.setFirstName(fname);
			   gen_qu.setMidName(mname);
			   gen_qu.setLastName(lname);
			   
			   gen_qu.setDOB(txtdob);
			   gen_qu.setAge(age);
			   gen_qu.setGender(sex);

			   gen_qu.setFatherName(fathername);
			   gen_qu.setMotherName(mothername);
			   gen_qu.setQualification(qualification);
			   gen_qu.setMStatus(staffmarital);
			   gen_qu.setPersonId(staffpersonid);

		        if(photo!=null && !photo.equals("null"))
		        {
		        gen_qu.setPhoto(photo);
		        }
		        else
		        {
			        gen_qu.setPhoto(hiddenphoto);
		        }
			 
		      %>
		      <input type="hidden" name="personid" value="" />
		      <input type="hidden" name="usernameforcheck" value="<%=username%>" />
		      <input type="hidden" name="Staffid" value="<%=Staffid%>" />
		      <input type="hidden" name="departmentid" value="<%=departmentid%>"/>
		      <input type="hidden" name="deptname" value="<%=upload.getParameter("deptname")%>"/>
		      
		      <%
				String ipaddress  = request.getRemoteHost();
				gen_qu.setipaddress(ipaddress);
				 result=gen_query.Staffpersonalprofileupdate(gen_qu);
				}
				else
				{
					result=-1;
					return_file = "./Registration/Staff_List.jsp";
				}
				String resultword="";
				if(result>0)
				{
					resultword="Personal Details Successfully Updated";
		
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

