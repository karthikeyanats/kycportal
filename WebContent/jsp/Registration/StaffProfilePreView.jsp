<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.staffdetails.staffregisterationtitle") %>| Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript">
function editfun()
	{
				//window.history.go(-1);    
				document.f1.action="./StaffProfileEdit.jsp";  
				document.f1.submit();
	}
function Submitfun()
{
document.f1.action= "./StaffRegistrationSubmit.jsp";
document.f1.submit();
}
function backfun()
{
document.f1.action= "./Staff_registration.jsp";
document.f1.submit();
}
function contactprofileupdate()
{
document.f1.action= "./Staffcontactprofileupdate.jsp";
document.f1.submit();
}
function updatestaffstatus()
{
var Status=document.f1.status.value;
var fieldname="";
if(Status=="D")
{
fieldname="Deactivate"
}
else if(Status=="A")
{
fieldname="Activate"
}
else if(Status=="T")
{
fieldname="Trash"
}
if(confirm("Are You Sure You Want to "+fieldname+" the Staff...? "))
{
document.f1.action= "./StaffupdateSubmit.jsp";
document.f1.submit();
}
}
function win(obj)
{
var attachment=obj.getAttribute("atta");
window.open("<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2="+attachment+"","Msg","top=250,left=350,help:no,center:no,status:no,width=500,height=300,scrollbars=1;")
}
</script>

<script language="javascript" type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/niceforms.js"></script>
<link rel="stylesheet" type="text/css" media="all"
	href="<%=request.getContextPath()%>/jsp/kycpanel/niceforms-default.css" />

</head>
<body>
<div id="main_container">

<div class="header"><%@ include file="../include/userheader.jsp"%>

</div>

<div class="main_content"><%@ include file="../include/header.jsp"%>


<div class="center_content">



<div class="left_content"></div>

<div class="right_content">

<h2><%=bundle.getString("label.staffdetails.staffregisterationrootpath") %></h2>
<form name="f1" method="post" action="">
<%@ page	import="java.util.*,java.io.File"%>
<%@ page	import="com.iGrandee.Registration.StaffRegistrationQuery,com.iGrandee.Common.DateTime,com.iGrandee.Registration.StaffRegistrationBean,com.iGrandee.Registration.StaffRegistrationUpload"%>

<%
	StaffRegistrationUpload upload = new StaffRegistrationUpload(request);
	HashMap photomap= upload.startProcess();
	String certificatename[] =null;
	String certificatepath[] =null;
	String photo = photomap.get("personphoto")+"";
	String  phototype = upload.getParameter("phototype");   

    if(phototype != null && phototype.equalsIgnoreCase("snapshot"))
    {
    	ResourceBundle  rbundle = ResourceBundle.getBundle("resources.serversetup");
    	String shapshotpath=rbundle.getString("shapshot");
    	String imagePath=rbundle.getString("storagepath")+"/imagestorage/";
    	String imageName="StaffPersonalImage.jpg"; 
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
         src.delete();
     }
	
	if(phototype == null || phototype.equals("") || phototype.equalsIgnoreCase("null"))
		photo=upload.getParameter("hiddenphoto");
	StaffRegistrationBean gen_qu=new StaffRegistrationBean();
	if((upload.getParameter("editstatus")+"").equals("Edit"))
	{
		StaffRegistrationBean gen_qunew=new StaffRegistrationBean();
 		gen_qunew=(StaffRegistrationBean)session.getAttribute("detailobj");
		certificatename=gen_qunew.getVerficertificatename();
		certificatepath=gen_qunew.getVerficertificatepath(); 
	}
	else if(photomap.size()>1)
	{
		certificatename=new String [photomap.size()-1];
		certificatepath=new String [photomap.size()-1];
		for(int i=0;i<photomap.size()-1;i++)
		{
			HashMap innermap=(HashMap)photomap.get("certificatemap"+i);
			certificatename[i]=innermap.get("certificatename")+"";
			certificatepath[i]=innermap.get("certificatepath")+"";
		}
	}
	 
	DateTime dateobj=new DateTime();
	String date_str = "";
	ArrayList deptList = null;
	StaffRegistrationQuery staffquery = new StaffRegistrationQuery();
	String userid = null;
	String instituid = null;
	String Staffid = null;
	String departid = null;
	String roleid = null;
	String Status = null;
	String Staffname = null;

	instituid=(String)session.getValue("instituteid");

	String sessionInstituteName = "";
	sessionInstituteName=(String)session.getValue("institutename");
	
		userid=(String)session.getValue("userid");

	if (userid != null) {
		try {
			departid = request.getParameter("departmentid");
			Staffid = request.getParameter("Staffid");
			roleid = request.getParameter("roleid");
			Status = request.getParameter("status");
			Staffname = request.getParameter("Staffname");
			deptList = staffquery.staffdetails(Staffid);
			String instituteid = "";
		}

		catch (NullPointerException e) {
		}
%> <%
 	//personal
 if(photo != null && !photo.equals("storage not connected"))
 {
 		String name = "-";
 		String fname = "-";
 		String mname = "-";
 		String lname = "-";
 		String age = "-";
 		String dob = "-";
 		String gender = "-";
 		String m_status = "-";

 		//contact
 		String communicationstreet1 = "";
 		String communicationstreet2 = "";

 		String communicationstate = "-";
 		String communicationcountry = "-";
 		String communicationcity = "-";
 		String communicationpin = "-";
 		String permanentstreet1 = "-";
 		String permanentstreet2 = "-";
 		String permanentstate = "-";
 		String permanentcountry = "-";
 		String permanentcity = "-";
 		String permanentpin = "-";

 		String mail_id = "-";

 		//job
 		String department = "-";
 		String occupation = "-";
 		String landline = "-";
 		String mobile = "-";
 		String email = "-";

 		String join_date = "-";
 		HashMap map = null;
 		String area = "-";
 		String publication = "-";
 		String sessionuserid = "";
 		String[] major =null;
 		String[] user_qualification =null;
 		String[] Yearofgrad =null;
 		String[] marks =null;
 		String[] institute_name =null;
 		String[] instName =null;
 		String[] instRole =null;
 		String[] instPeriod =null;
 		String fathername = null;
 		String mothername = null;
 		String username = null;
 		String rolenname =null;
 		String smsmobile =null;

 		String departmentname =null;
 		
 		try{
 			age = upload.getParameter("user_age");
 		String prefixname = upload.getParameter("slt_prefix");
 		fname = upload.getParameter("user_first_name");
 		mname = upload.getParameter("user_middle_name");
 		lname = upload.getParameter("user_last_name");
 		if(mname.equals(""))
 			name=prefixname+fname+" "+lname;
 		else
 			name=prefixname+fname+" "+mname+" "+lname;

 		String qualification = upload
 				.getParameter("user_final_qualification");
 		 fathername = upload.getParameter("user_fathername");
 		 mothername = upload.getParameter("user_mothername");
 		gender = upload.getParameter("user_gender");
 		m_status = upload.getParameter("user_mar_status");
 		 username = upload.getParameter("user_id");
 		smsmobile = upload.getParameter("smscontactno");

 		String password = upload.getParameter("user_passwd1");

 		if (m_status == null)
 			m_status = "-";
 		dob = upload.getParameter("user_bday");
 		
		String dob1=dateobj.getMySQLFormat(dob)+"";

 		communicationstreet1 = upload.getParameter("user_street1");
 		communicationstreet2 = upload.getParameter("user_street2");
 		communicationstate = upload.getParameter("user_state");
 		communicationcity = upload.getParameter("user_city");
 		communicationcountry = upload.getParameter("country");
 		communicationpin = upload.getParameter("user_zipcode");
 		if (communicationpin.equals(""))
 			communicationpin = "-";
 		permanentstreet1 = upload.getParameter("permanentuser_street1");
 		permanentstreet2 = upload.getParameter("permanentuser_street2");
 		permanentstate = upload.getParameter("permanentuser_state");
 		permanentcity = upload.getParameter("permanentuser_city");
 		permanentcountry = upload.getParameter("permanentcountry");
 		permanentpin = upload.getParameter("permanentuser_zipcode");
 		if (permanentpin.equals(""))
 			permanentpin = "-";
 		mobile = upload.getParameter("user_phone");
 		if (mobile == null || mobile.equals("")
 				|| mobile.equals("null"))
 			mobile = "-";

 		landline = upload.getParameter("user_phone_ll");
 		if (landline == null || landline.equals("")
 				|| landline.equals("null"))
 			landline = "-";
 		email = upload.getParameter("user_private_mail_id");
 		if (email.equals(""))
 			email = "-";

 		 major = upload.getParameterValues("major");
 		 user_qualification = upload
 				.getParameterValues("user_qualification");
 		 Yearofgrad = upload.getParameterValues("Yearofgrad");
 		 marks = upload.getParameterValues("marks");
 		 institute_name = upload
 				.getParameterValues("institutename");
 		 instName = upload.getParameterValues("instituteName");
 		 instRole = upload.getParameterValues("instituteRole");
 		 instPeriod = upload	.getParameterValues("institutePeriod");
 		occupation = upload.getParameter("user_post");
 		department = upload.getParameter("user_department");
 		roleid = upload.getParameter("user_role");

 		 rolenname 	  = upload.getParameter("rolename");
 		 departmentname = upload.getParameter("departname");

 		join_date = upload.getParameter("user_joining_date");

 		area = upload.getParameter("areaOfInterest");
 		publication = upload.getParameter("publiCations");
 		
 		gen_qu.setOperation("Insert");
		gen_qu.setprefix(prefix);
		gen_qu.setAge(age);

		gen_qu.setFirstName(fname);
		gen_qu.setMidName(mname);
		gen_qu.setLastName(lname);
		gen_qu.setQualification(qualification);

		gen_qu.setUserName(username);
		gen_qu.setPassWd(password);
		
		gen_qu.setInstituteId(instituid);
		
		gen_qu.setSessionInstituteName(sessionInstituteName);
		
		gen_qu.setFatherName(fathername);
		gen_qu.setMotherName(mothername);
		
		gen_qu.setPhoto(photo);
		gen_qu.setGender(gender);

		gen_qu.setDOB(dob1);
		gen_qu.setEditdob(dob);

		gen_qu.setUserId(userid);
		
		gen_qu.setMStatus(m_status);
		
		gen_qu.setStreet1(communicationstreet1);
		gen_qu.setStreet2(communicationstreet2);
		gen_qu.setCity(communicationcity);
		gen_qu.setState(communicationstate); 
		gen_qu.setCountry(communicationcountry);
		gen_qu.setZipCode(communicationpin);
		
		gen_qu.setpermanentStreet1(permanentstreet1);
		gen_qu.setpermanentStreet2(permanentstreet2);
		gen_qu.setpermanentCity(permanentcity);
		gen_qu.setpermanentState(permanentstate);
		gen_qu.setpermanentCountry(permanentcountry);
		gen_qu.setpermanentZipCode(permanentpin);
		
		gen_qu.setMobile(mobile);	//mobile2
		gen_qu.setLandLine(landline);
		gen_qu.setEMail(email);

		gen_qu.setmajor(major);
		gen_qu.setuser_qualification(user_qualification);
		gen_qu.setYearofgrad(Yearofgrad);
		gen_qu.setmarks(marks);
		gen_qu.setinstitutename(institute_name);

		gen_qu.setPost(occupation);
		gen_qu.setDepartment(department);
		gen_qu.setRole(roleid);
		String join_date1=dateobj.getMySQLFormat(join_date)+"";
		gen_qu.setEditjoindate(join_date);
		gen_qu.setJoiningDate(join_date1);
		gen_qu.setSmsmobile(smsmobile);
		gen_qu.setinstName(instName);
		gen_qu.setinstRole(instRole);
		gen_qu.setinstPeriod(instPeriod);
		gen_qu.setVerficertificatename(certificatename);
		gen_qu.setVerficertificatepath(certificatepath);  
		gen_qu.setAreaOfInterest(area);
		gen_qu.setPubliCations(publication);
		String ipaddress  = request.getRemoteHost();
		gen_qu.setipaddress(ipaddress);
		session.setAttribute("detailobj",gen_qu);
		/*StaffRegistrationBean	gen_qun=new StaffRegistrationBean();
		gen_qun=(StaffRegistrationBean)session.getAttribute("detailobj");*/
		//out.println("===="+gen_qun.getDOB());  
 		}
 		catch(Exception e)
 		{
 			e.printStackTrace();
 		}
 %>
<form name="f1" method="post" action=""><input type="hidden"
	name="Staffid" value="<%=Staffid%>" /> <input type="hidden"
	name="roleid" value="<%=roleid%>" /> <input type="hidden"
	name="status" value="<%=Status%>" /> <input type="hidden"
	name="departmentid" value="<%=departid%>" />

<TABLE border=0 class="tablecolor" cellspacing=0 width=100% align=center
	height=485 cellpadding=0>
	<tr valign="top" style="height: 190">
		<td>
		<table id="rounded-corner" border=0 summary="Department List"
			width="100%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="100%"><%=bundle.getString("label.staffprofile.subcontent")%></th>
					<th scope="col" class="rounded-q4" width="1%"></th>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<td class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody>
				<tr>
					<td width="100%" colspan=2>
					<table width="100%" border=0 bgcolor="#ffffff" cellspacing=0 cellpadding=0 >
						<tr style="height: 25">
							<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffprofile.Name")%>
							</td>
							<td class="tablelight" style="width: 65%" colspan="3"><%=name%>
							</td>

							<td rowspan="6"><img
								src="<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2=<%=photo%>"
								name='stphoto_img1' id=stphoto_img width=120 height=130></td>
						</tr>
						<tr style="height: 25">
							<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffprofile.FatherName")%></td>
							<td class="tablelight" style="width: 65%"><%=fathername%></td>
						</tr>
						<tr style="height: 25">
							<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffprofile.MotherName")%></td>
							<td class="tablelight" style="width: 65%"><%=mothername%></td>
						</tr>
						<tr style="height: 25">
							<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffprofile.dateofbirth")%>
							</td>
							<td class="tablelight" style="width: 35%"><%=dob%></td>

						</tr>

						<tr style="height: 25">
							<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffdetails.Age")%>
							</td>
							<td class="tablelight" style="width: 35%"><%=age%><%=bundle.getString("label.staffprofile.Year's")%> </td>

						</tr>
						<tr style="height: 25">
							<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffprofile.gender")%>
							</td>
							<td class="tablelight" style="width: 35%">
							<%
								if (gender.equals("M")) {
										out.println("Male");
									} else if (gender.equals("F")) {
										out.println("Female");
									} else {
										out.println(gender);
									}
							%>
							</td>
						</tr>
						<tr style="height: 25">
							<td class="tablebold" style="width: 15%"><%=bundle
										.getString("label.staffprofile.martialstatus")%></td>
							<td class="tablelight" style="width: 35%" colspan=5><%=m_status%>
							</td>
						</tr>
					</table>
					</td>
				</tr>
			</tbody>

		</table>
		<br>
		</td>
	</tr>


	<tr valign="top">
		<td>
		<table id="rounded-corner" border=0 summary="Department List"
			width="100%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="100%"><%=bundle.getString("label.staffprofile.continform")%></th>
					<th scope="col" class="rounded-q4" width="1%"></th>

				</tr>
			</thead>
			<tfoot>
				<tr>
					<td class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody>
				<tr height=25>
					<td align=left colspan=2>
					<h3 align=left><%=bundle.getString("label.staffprofile.CommunicationAddress")%></h3>
					</td>
				</tr>
				<tr>
				<td width="100%" colspan=2>
				<table border=0 bordercolor='#EFEFE7' align=center class=tablehead
					cellpadding=0 cellspacing=0 width="95%" >

					<tr>
						<td width="100%">
						<table width="100%" border=0 bgcolor="#ffffff" cellpadding=0
							cellspacing=0>

							<tr height=25>
								<td align=left class="tablebold"><%=bundle.getString("label.staffprofile.Street1")%></td>
								<td align=left colspan=3><%=communicationstreet1%></td>
							</tr>
							<tr height=25>
								<td align=left class="tablebold"><%=bundle.getString("label.staffprofile.Street2")%></td>
								<td align=left colspan=3><%=communicationstreet2%></td>
							</tr>

							<tr style="height: 25">
								<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffprofile.city")%>
								</td>
								<td class="tablelight" style="width: 35%"><%=communicationcity%>
								</td>
								<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffprofile.state")%>
								</td>
								<td class="tablelight" style="width: 35%"><%=communicationstate%>
								</td>
							</tr>
							<tr style="height: 25">
								<td class="tablebold" style="width: 15%"><%=bundle
										.getString("label.staffprofile.country")%></td>
								<td class="tablelight" style="width: 35%"><%=communicationcountry%>
								</td>
								<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffdetails.Pin")%>
								</td>
								<td class="tablelight" style="width: 35%"><%=communicationpin%>
								</td>
							</tr>
							</table>
							</td>
							</tr>
							</table>
							
							<tr height=25>
								<td align=left colspan=2>
								<h3><%=bundle.getString("label.staffprofile.PermanentAddress")%></h3>
								</td>
							</tr>
							<tr>
							<td  colspan=2>
							<table border=0 bordercolor='#EFEFE7' align=center class=tablehead
						cellpadding=0 cellspacing=0 width="100%" >
							<tr height=25>
								<td align=left>
	<table border=0 bordercolor='#EFEFE7' align=center class=tablehead
					cellpadding=0 cellspacing=0 width="95%" rules="groups">							<tr height=25>
								<td align=left class="tablebold"><%=bundle.getString("label.staffprofile.Street1")%></td>
								<td align=left colspan=3><%=permanentstreet1%></td>
							</tr>
							<tr height=25>
								<td align=left class="tablebold"><%=bundle.getString("label.staffprofile.Street2")%></td>
								<td align=left colspan=3><%=permanentstreet2%></td>
							</tr>

							<tr style="height: 25">
								<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffprofile.city")%>
								</td>
								<td class="tablelight" style="width: 35%"><%=permanentcity%>
								</td>
								<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffprofile.state")%>
								</td>
								<td class="tablelight" style="width: 35%"><%=permanentstate%>
								</td>
							</tr>
							<tr style="height: 25">
								<td class="tablebold" style="width: 15%"><%=bundle
										.getString("label.staffprofile.country")%></td>
								<td class="tablelight" style="width: 35%"><%=permanentcountry%>
								</td>
								<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffdetails.Pin")%>
								</td>
								<td class="tablelight" style="width: 35%"><%=permanentpin%>
								<br>
								<br>
								</td>
							</tr>
							<tr style="height: 25">
								<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffprofile.MobileNo")%></td>
								<td class="tablelight" style="width: 35%" colspan=3><%=mobile%>
								</td>

							</tr>
							<tr style="height: 25">
								<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffprofile.smscontact")%></td>
								<td class="tablelight" style="width: 35%" colspan=3><%=smsmobile%>
								</td>

							</tr>
							<tr style="height: 25">
								<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffprofile.landlineno")%>
								</td>
								<td class="tablelight" style="width: 35%" colspan=3><%=landline%>
								</td>

							</tr>

							<tr style="height: 25">
								<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffdetails.mailId")%>
								</td>
								<td class="tablelight" style="width: 35%" colspan=3><%=email%>
								</td>

							</tr>

						</table>
						</td>
					</tr>
				</table>
				</td>
				</tr>
				
			</tbody>
		</table>
		<br>
		</td>
	</tr>
	<tr valign="top">
		<td>
		<table id="rounded-corner" border=0 summary="Department List"
			width="100%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="100%"><%=bundle.getString("label.staffprofile.qualification")%></th>
					<th scope="col" class="rounded-q4" width="1%"></th>

				</tr>
			</thead>
			<tfoot>
				<tr>
					<td class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody>
				<tr>
					<td width="100%" colspan=2>
					<table border=0 bordercolor='#EFEFE7' align=center class=tablehead
						cellpadding=0 cellspacing=0 width="95%" rules="groups">
						<tr><td width="100%">
						<table width="100%" border=0 bgcolor="#ffffff" cellpadding=0
							cellspacing=0>
							<tr style="height: 25">
								<td class="tablebold" style="width: 5%"><%=bundle.getString("label.staffdetails.SL.No")%></td>
								<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffdetails.Major")%></td>
								<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffdetails.University")%>
								</td>
								<td class="tablebold" style="width: 35%"><%=bundle.getString("label.staffdetails.Program")%>
								</td>
								<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffdetails.Year")%>
								</td>
								<td class="tablebold" style="width: 35%"><%=bundle.getString("label.staffdetails.%OfMarks")%></td>
							</tr>
							<%
								if (major != null && major.length > 0) {
										for (int i = 0; i < major.length; i++) {
											out.println("<tr>");
											out.println("<td class='tablelight'>");
											out.println((i + 1));
											out.println("</td>");
											out.println("<td class='tablelight'>");
											out.println(major[i]);
											out.println("</td>");
											out.println("<td class='tablelight'>");
											out.println(institute_name[i]);
											out.println("</td>");
											out.println("<td class='tablelight'>");
											out.println(user_qualification[i]);

											out.println("</td>");
											out.println("<td class='tablelight'>");
											out.println(Yearofgrad[i]);

											out.println("</td>");
											out.println("<td class='tablelight'>");
											out.println(marks[i]);

											out.println("</td>");
											out.println("</tr>");

										}
									}
							%>
						</table>
						</td>
						</tr>
					</table>
			</tbody>
		</table>
		<br>
		</td>
	</tr>
<%
if (certificatepath != null && certificatepath.length > 0 && certificatename != null && certificatename.length > 0) {
%>
		<tr valign="top">
		<td>
		<table id="rounded-corner" border=0 summary="Department List"
			width="100%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="100%"><%=bundle.getString("label.staffregisteration.Certificate")%></th>
					<th scope="col" class="rounded-q4" width="1%"></th>

				</tr>
			</thead>
			<tfoot>
				<tr>
					<td class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody>
				<tr>
					<td width="100%" colspan=2>
					<table border=0 bordercolor='#EFEFE7' align=center class=tablehead
						cellpadding=0 cellspacing=0 width="95%" rules="groups">
						<tr><td width="100%">
						<table width="100%" border=0 bgcolor="#ffffff" cellpadding=0
							cellspacing=0>
							<%
										for (int i = 0; i<certificatepath.length; i++) {
											out.println("<tr>");
											out.println("<td class='tablelight' width='10%' >");
											out.println((i + 1));
											out.println("</td  width='10%' >");
											out.println("<td class='tablelight'>");
											out.println(certificatename[i]);
											out.println("[ <a href='#' atta='"+certificatepath[i]+"' onclick=win(this)>View</a> ]");
											out.println("</td>");
											out.println("</tr>");

										}
							%>
						</table>
						</td>
						</tr>
					</table>
			</tbody>
		</table>
		<br>
		</td>
	</tr>
	<%} %>
	<tr valign="top">
		<td>
		<table id="rounded-corner" border=0 summary="Department List"
			width="100%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="100%"><%=bundle
										.getString("label.staffprofile.jobinform")%></th>
					<th scope="col" class="rounded-q4" width="1%"></th>

				</tr>
			</thead>
			<tfoot>
				<tr>
					<td class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody>
				<tr>
					<td width="100%" colspan=2>
					<table border=0 bordercolor='#EFEFE7' align=center class=tablehead
						cellpadding=0 cellspacing=0 width="95%" rules="groups">
						<tr>
							<td width="100%">
							<table width="100%" border=0 bgcolor="#ffffff" cellpadding=0
								cellspacing=0>
								<tr style="height: 25">
									<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffdetails.Department")%>
									</td>
									<td class="tablelight" style="width: 35%"><%=departmentname%>
									</td>
									<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffdetails.joiningdate")%>
									</td>
									<td class="tablelight" style="width: 35%"><%=join_date%></td>
								</tr>
								<tr style="height: 25">
									<td class="tablebold" style="width: 15%"><%=bundle
										.getString("label.staffprofile.role")%></td>
									<td class="tablelight" style="width: 35%" colspan='3'><%=rolenname%>
									</td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
			</tbody>
		</table>
		<br>
		</td>
	</tr>
	<%
	if (instRole != null && instRole.length > 0) 
	{
		%>
	<tr valign="top">
		<td>
		<table id="rounded-corner" border=0 summary="Department List"
			width="100%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="100%"><%=bundle.getString("label.staffdetails.ExperienceDetails")%></th>
					<th scope="col" class="rounded-q4" width="1%"></th>

				</tr>
			</thead>
			<tfoot>
				<tr>
					<td class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody>
				<tr>
					<td width="100%" colspan=2>
					<table border=0 bordercolor='#EFEFE7' align=center class=tablehead
						cellpadding=0 cellspacing=0 width="95%" rules="groups">
						<tr>
							<td width="100%">
							<table width="100%" border=0 bgcolor="#ffffff" cellpadding=0
								cellspacing=0>
								<tr style="height: 25">
									<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffdetails.SL.No")%></td>
									<td class="tablebold" style="width: 40%"><%=bundle.getString("label.staffdetails.Position")%></td>
									<td class="tablebold" style="width: 45%"><%=bundle.getString("label.staffdetails.Period")%></td>
								</tr>
								<%
											for (int i = 0; i < instRole.length; i++) {
												out.println("<tr>");
												out.println("<td class='tablelight'>");
												out.println((i + 1));
												out.println("</td>");
												out.println("<td class='tablelight'>");
												out.println(instRole[i]);
												out.println("</td>");
												out.println("<td class='tablelight'>");
												out.println(instPeriod[i]);
												out.println("</td>");
												out.println("</tr>");
											}
								%>
							</table>
							</td>
						</tr>
					</table>
			</tbody>
		</table>
		<br>
		</td>
	</tr>
        <%    }
	if((area!=null && !area.equals("")) || (publication!=null && !publication.equals("")) ){%>
	<tr valign="top">
		<td>
		<table id="rounded-corner" border=0 summary="Department List"
			width="100%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="100%"><%=bundle
										.getString("label.staffdetails.subAreainterestAndPublication")%></th>
					<th scope="col" class="rounded-q4" width="1%"></th>

				</tr>
			</thead>
			<tfoot>
				<tr>
					<td class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody>
				<tr>
					<td width="100%" colspan=2>
					<table border=0 bordercolor='#EFEFE7' align=center class=tablehead
						cellpadding=0 cellspacing=0 width="95%" rules="groups">
						<tr>
							<td width="100%">
							<table width="100%" border=0 bgcolor="#ffffff" cellpadding=0
								cellspacing=0>
								<% if(area!=null && !area.equals("")) 
								{%>
								
								<tr style="height: 30%" align="left" width="70%" valign=top>
									<td class="tablebold" width='25%'><%=bundle
										.getString("label.staffdetails.Areaofinterest")%></td>
									<td class="tablelight" style="width: 35%" colspan=5><%=area%></td>
							</tr>
									<%} if(publication!=null && !publication.equals("")) 
									{ %>
								<tr style="height: 30%" align="left" width="70%" valign=top>

									<td class="tablebold" width='15%'><%=bundle.getString("label.staffdetails.Publication")%></td>
									<td class="tablelight" style="width: 35%"  colspan=5><%=publication%>
									</td>
								</tr>
								<%} %>
								<tr style="height: 25" align="left" width="70%">
									<td class="tablebold" width='15%'></td>

									<td class="tablelight" style="width: 35%"></td>

									<td class="tablebold" colspan="2" width='15%'></td>

									<td class="tablelight" style="width: 35%"></td>
								</tr>

							</table>
							</td>
						</tr>
					</table>


					</td>
				</tr>
		</table>
		<br>
		</td>
	</tr>
	<%} %>
	<tr valign="top">
		<td>
		<table id="rounded-corner" border=0 summary="Department List"
			width="100%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="100%"><%=bundle.getString("label.staffdetails.AccountInformation")%></th>
					<th scope="col" class="rounded-q4" width="1%"></th>

				</tr>
			</thead>
			<tfoot>
				<tr>
					<td class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody>
				<tr>
					<td width="100%" colspan=2>
					<table border=0 bordercolor='#EFEFE7' align=center class=tablehead
						cellpadding=0 cellspacing=0 width="95%" rules="groups">
						<tr>
							<td width="25%" class=tablebold><%=bundle.getString("label.staffdetails.UserName")%></td>
							<td width="75%"><%=username%></td>
						</tr>
						<tr>
							<td width="25%" class=tablebold><%=bundle.getString("label.staffdetails.Password")%></td>
							<td width="75%">*****************</td>
						</tr>
					</table>
			</tbody>
		</table>
		</td>
	</tr>
</table>

<a href="#bbsb" name="bbsb" onclick=backfun() class="bt_blue"
	align=center><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.staffdetails.Back")%></strong><span
	class="bt_blue_r"></span></a><a href="#bbb" name="bbb" onclick='editfun()' class="bt_green" align=center><span class="bt_green_lft"></span><strong><%=bundle.getString("button.staffdetails.Edit")%></strong><span class="bt_green_r"></span></a> 
	<a href="#bbb" name="bbb" onclick='Submitfun()' class="bt_green" align=center><span class="bt_green_lft"></span><strong><%=bundle.getString("button.staffdetails.Register")%></strong><span class="bt_green_r"></span></a><%
	}
	else
	{
  	  out.print("<div class='error_box'><center>Insertion Failed Due to Storage Device not connected</center></div><a href='#bbsb' name='bbsb' onclick=backfun() class='bt_blue' align=center><span class='bt_blue_lft'></span><strong>Back</strong><span	class='bt_blue_r'></span></a>");
	}
	}
}
catch(Exception e){
	e.printStackTrace();
}
 %>
</form>
</div>
<!-- end of right content--></div>
<!--end of center content -->




<div class="clear"></div>
</div>
<!--end of main content--> <%@ include file="../include/footer.jsp"%>


</div>
</body>
</html>