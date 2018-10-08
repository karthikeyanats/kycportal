<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child | Powered by i-Grandee</title>
<LINK rel=stylesheet href="<%=request.getContextPath()%>/css/kyccss.css">

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>

<script type="text/javascript">
function personalprofileupdate()
{
document.f1.action= "./Studentpersonalprofileupdate.jsp";
document.f1.submit();
}
function contactprofileupdate()
{
document.f1.action= "./Studentcontactprofileupdate.jsp";
document.f1.submit();
}

function parentguardianprofileupdate()
{
document.f1.action= "./parentguardianprofileupdate.jsp";
document.f1.submit();
}
function previousschoolprofileupdate()
{
document.f1.action= "./StudentPreviousSchoolProfileUpdate.jsp";
document.f1.submit();
}

function previousextracurricularprofileupdate()
{
	document.f1.action= "./StudentExtracurricularProfileUpdate.jsp";
	document.f1.submit();
}

function previousscholarshipupdate()
{
	document.f1.action= "./StudentScholarshipProfileUpdate.jsp";
	document.f1.submit();
}



function backfun()
{
if(document.f1.studentprofileedit.value=="studentprofileedit")
document.f1.action= "./StudentReportView.jsp";
else
document.f1.action= "./RegisteredStudentList.jsp";

document.f1.submit();
}
function profileeditpage()
{
alert("Your Profile Not Yet Entered");
document.f1.action= "./StudentApplicationSearch.jsp";
document.f1.submit();
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

<%@ page
	import="java.util.*"%> <%
 	ResourceBundle bundle = null;
 	bundle = ResourceBundle.getBundle("resources.ApplicationResources");
 	ResourceBundle rb=ResourceBundle.getBundle("resources.serversetup");

 %> <%@ page import="com.iGrandee.Registration.StudentRegistrationQuery"%>

<%
	String date_str = "";
	ArrayList deptList = null;
	StudentRegistrationQuery studentquery = new StudentRegistrationQuery(); 
	String userid = null;
	String instituid = null;
	String personid = null;
	String departid = null;
	String roleid = null;
	String Status = null;
	String Staffname = null;
	String studentprofileedit="";
	
	String standardscheduleid="";
	
	userid = (String) session.getValue("userid");
	String approvalid ="";
	if (userid != null) {
		try {
			
			departid 			= request.getParameter("departmentid");
			
			
			if(request.getParameter("standard") == null)
			standardscheduleid	= request.getParameter("standardscheduleid");
			else
				standardscheduleid	= request.getParameter("standard");
				
			//personid = request.getParameter("Staffid");
													  
			approvalid = request.getParameter("stundentapproveid")+"";
			//out.println("approvalid"+approvalid);
			if(!approvalid.equals("null"))
			{
				personid=studentquery.getpersonidviseapprovalid(approvalid)+"";
				if(personid.equals("null"))
				{
					out.println("<script>profileeditpage()</script>");
				}
			}
			else
			{
				personid= request.getParameter("personid")+"";
				studentprofileedit= request.getParameter("studentprofileedit")+"";

			}
			
			roleid = request.getParameter("roleid");
			Status = request.getParameter("status");
			Staffname = request.getParameter("Staffname");

			//deptList = staffquery.staffdetails(Staffid);
			//out.println("=====>>>"+Staffid);
			String instituteid = "";

		}

		catch (Exception e) {e.printStackTrace();
		}
%> <%
 	//personal
 		String name = "-";
 		String fname = "-";
 		String mname = "-";
 		String sex = "-";
 		String age = "-";
 		String dob = "-";
 		String photo = "-";
 		String mail_id = "-";
 		String landline = "-";
 		String email = "-";
 		String nationality = "-";
 		String community = "-";
 		String religion = "-";
 		String language = "-";
 		String bloodgroup = "-";
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
 		String smscontactno	= "-";
 		
 		String guardianname = "-";
 		String guardianemail = "-";
 		String relation = "-";
 		String self = "-";
 		String nameoforganization = "-";
 		String annualincome = "-";
 		String position = "-";
 		String sexvalue=null;
 		
 		String physicallyfit = "-";
 		String exserviceman = "-";
 		String physicalmark = "-";
 		String previousschoolname = "-";
 		String previousschooladdress = "-";
 		String mediumstudied = "-";
 		String tc = "-";
 		String cc = "-";
 		String splcategory = "-";
 		String medicalcertificate = "-";
 		String marksheet = "-";
 		String sportscertificate = "-";
 		String studextracurricular = "-";
 		String username = "-";
 		String previousschoolhistory = "-";
 		String mobilenumber = "-";
 		String boardname = "-";
 		String mediumname = "-";

 		
 		//out.println("personid ==>"+personid);
 		
 		ArrayList person_list = studentquery.Studentpersondetails(personid);
 		ArrayList contact_list = studentquery.Studentcontactdetails(personid);
 		ArrayList guardian_list = studentquery.Studentguardiandetails(personid);
 		ArrayList register_list = new ArrayList();
 		if(studentprofileedit.equals("studentprofileedit"))
 	 		register_list = studentquery.Studentdetails(personid,request.getParameter("hiddensession"),request.getParameter("req_sessionstatus"));
 		else
 		register_list = studentquery.Studentregisterdetails(personid);
 		
 		ArrayList qualification_list = studentquery.Studentqualificationdetails(personid);
 		ArrayList account_list = studentquery.Studentaccountdetails(personid);
 		
 		//ArrayList scholarshipList 	= studentquery.Studentscholarshipdetails(personid, standardscheduleid);
		
//scholarshipList			= studentquery.loadScholarshipDetails(personid, request.getParameter("standardscheduleid"));
 		

 		//experiance
 		String sectionname1 = "-";
 		String standardname1 = "-";
 		String sessionname1 = "-";
 		String firstname=null;
 		String middlename=null;
 		String lastname=null;
 		
 		HashMap map = null;
 		if (person_list != null && person_list.size() > 0) {
 			
 			
 			map = (HashMap) person_list.get(0);
 			name = (String) map.get("uname");
 			firstname		= (String)map.get("firstname");
			 middlename		= (String)map.get("middlename");
			 lastname		= (String)map.get("lastname");
			 
			 if(middlename==null || middlename.equals("") || middlename.equals("-")){
				 middlename="";
			 }
			 else
			 {
				 middlename=" "+middlename;
			 }
			 
			 if(lastname==null || lastname.equals("") || lastname.equals("-")){
				 lastname="";
		}
		 else
		 {
			 lastname=" "+lastname;
		 }
			 name = firstname+middlename+lastname;
			 
 			fname = (String) map.get("fathername");
 			if (fname == null)
 				fname = "-";
 			mname = (String) map.get("mothername");
 			if (mname == null)
 				mname = "-";
 			age = (String) map.get("age");
 			if(age==null)
 	 			age="-";
 			dob = (String) map.get("dob");
 			sex = (String) map.get("sex");
 			if(sex.equals("F"))
 				sexvalue = "Female";
 				else if(sex.equals("M"))
 					sexvalue = "Male";

 			/*if(dob!=null)
 			{
 				String[] str_dob=dob.split("-");
 				dob=str_dob[1]+"-"+str_dob[0]+"-"+str_dob[2];
 			}*/

 			//out.println(gender);

 			landline = (String) map.get("landlinenumber")+"";
 			if (landline == null || landline.equals("null") || landline.equals("") )
 				landline = "-";
 			photo = (String) map.get("imagepath");
 			//System.out.println("================photo====>" + photo);
 			email = (String) map.get("emailid");
 			 nationality =(String) map.get("nationality");
 	 		 community = (String) map.get("community");
 	 		 religion = (String) map.get("religion");
 	 		 language = (String) map.get("language");
 	 		 bloodgroup =(String) map.get("bloodgroup");
 	 		mobilenumber =(String) map.get("mobilenumber");

 	 		
 		}
 		if (contact_list != null && contact_list.size() > 0) {
 			map = (HashMap) contact_list.get(0);
 			communicationstreet1 = (String) map	.get("communicationstreet1");
 			communicationstreet2 = (String) map	.get("communicationstreet2")+"";
 			if (communicationstreet2.equals("null") || communicationstreet2.equals(""))
 				communicationstreet2 = "-";

 			communicationcity = (String) map.get("communicationcity");
 			communicationstate = (String) map.get("communicationstate");
 			communicationcountry = (String) map
 					.get("communicationcountry");
 			communicationpin = (String) map.get("communicationpin");
 			permanentstreet1 = (String) map.get("permanentstreet1");
 			permanentstreet2 = (String) map.get("permanentstreet2")+"";
 			if (permanentstreet2.equals("null") || permanentstreet2.equals("") )
 				permanentstreet2 = "-";
 			permanentcity = (String) map.get("permanentcity");
 			permanentstate = (String) map.get("permanentstate");
 			permanentcountry = (String) map.get("permanentcountry");
 			permanentpin = (String) map.get("permanentpin");
 			smscontactno	= (String) map.get("smscontactno");
 		}
 		if (guardian_list != null && guardian_list.size() > 0) {
 			map = (HashMap) guardian_list.get(0);
 			
 			guardianname = (String) map	.get("guardianname");
 			if(map.get("guardianmailid") == null)
 				guardianemail = "-";
 			else
 			guardianemail = (String) map.get("guardianmailid");
 			
 			relation = (String) map.get("relation");
 			nameoforganization = (String) map.get("nameoforganization");
 			self = (String) map	.get("self");
 			annualincome = (String) map.get("annualincome");
 			position = (String) map.get("position");
 			
 		}
 		if (account_list != null && account_list.size() > 0) {
 			map = (HashMap) account_list.get(0);
 			username = (String) map.get("username");
 			}
 		if (register_list != null && register_list.size() > 0) {
 			map = (HashMap) register_list.get(0);
 			physicallyfit = (String) map.get("physicallyfit");
 			exserviceman = (String) map.get("exserviceman");
 			physicalmark = (String) map.get("physicalmark");
 			previousschoolname = (String) map	.get("previousschoolname");
 			previousschooladdress = (String) map.get("previousschooladdress");
 			mediumstudied = (String) map.get("mediumstudied");
 			tc = (String) map	.get("tc");
 			cc = (String) map.get("cc");
 			splcategory = (String) map.get("splcategory");
 			medicalcertificate = (String) map	.get("medicalcertificate");
 			marksheet = (String) map.get("marksheet");
 			sportscertificate = (String) map.get("sportscertificate");
 			studextracurricular = (String) map.get("studextracurricular")+"";
 			if(studextracurricular.equals("") || studextracurricular.equals("null") )
 				studextracurricular="-"; 
 			
 			previousschoolhistory = (String) map.get("previousschoolhistory")+"";
 			if(previousschoolhistory.equals(""))
 				previousschoolhistory="no";
 			
 			
 			sectionname1 = (String) map.get("sectionname");
 	 		standardname1 = (String) map.get("standardname");
 	 		standardscheduleid = (String) map.get("standardscheduleid");
 	 		
 	 		sessionname1 = (String) map.get("sessionname");
 	 		boardname= (String) map.get("boardname");
 	 		mediumname= (String) map.get("mediumname");
			if(mediumname!=null)
 	 		boardname=boardname+" -"+mediumname;
 			}
 		
 			if(studextracurricular != null && !studextracurricular.equals("-")){
 				ArrayList extralist	= studentquery.loadExtrcurricularProfileView(studextracurricular);
 				
 				if(extralist != null && extralist.size()>0){
 					studextracurricular = "";
 					for(int y=0;y<extralist.size();y++){
						HashMap hashmap	= (HashMap)extralist.get(y); 
						studextracurricular	+=(String)hashmap.get("extracurricularname")+",";
 					}
 				}
 	 			if(studextracurricular.length()>2)  
 	 				studextracurricular	= studextracurricular.substring(0,studextracurricular.length()-1);
 			}
 			
 			if(smscontactno == null || smscontactno.equals("") || smscontactno.equalsIgnoreCase("null"))
 				smscontactno	= "-";
 			
 	 		if(studentprofileedit.equals("studentprofileedit"))
 	 		{		
 %>
   <h2>Enrollment / Student Enrollment / Student Profile View / Student List View / Student Profile  Details</h2>
 <%}else{ %>
  <h2>Enrollment / Student Enrollment / Registered Student List / Student Profile  Details</h2>
 
 <%} %>
<form name="f1" method="post" action=""><input type="hidden"
	name="personid" value="<%=personid%>" /> <input type="hidden"
	name="roleid" value="<%=roleid%>" /> <input type="hidden" name="status"
	value="<%=Status%>" /> <input type="hidden" name="departmentid"
	value="<%=departid%>" />
	<input type="hidden" name="usernameforcheck" value="<%=username%>" />
		<input type="hidden" name="studentprofileedit" value="<%=studentprofileedit%>">
		<input type=hidden   name=session value="<%=request.getParameter("hiddensession")%>">
		<input type=hidden   name=board value="<%=request.getParameter("hiddenboard")%>">
		<input type=hidden   name=standardscheduleid value="<%=standardscheduleid%>">
		<input type=hidden   name=sectionscheduleid value="<%=request.getParameter("sectionscheduleid")%>">
		<input type="hidden" name="req_sessionname" value="<%=request.getParameter("req_sessionname")%>">
		<input type="hidden" name="req_sessionstatus" value="<%=request.getParameter("req_sessionstatus")%>">
		<input type="hidden" name="req_boardname" value="<%=request.getParameter("req_boardname")%>">
		<input type="hidden" name="req_standardnamegp" value="<%=request.getParameter("req_standardnamegp")%>">
		<input type="hidden" name="req_sectionname" value="<%=request.getParameter("req_sectionname")%>"> 
		<input type="hidden" name="req_studentname" value="<%=name%>">
		<input type="hidden" name="stundentapproveid" value="<%=approvalid%>"> 
		
		
	<TABLE border=0 class="tablecolor" cellspacing=0 width=100% align=center
	height=485 cellpadding=0>
		<tr>
	<td>
	
		<table border=0 id="rounded-corner" width="100%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company"  width="90%" ><%=bundle.getString("label.schedule.selectedinfo")%></th>
					<th scope="col" class="rounded-q4" width="10%"></th>

				</tr>
			</thead>
			<tfoot>
				<tr>
					<td  class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody>
						<tr>
						<td colspan=2><table width="100%"><tr>
						<td class="tablebold" ><%=bundle.getString("label.studentprofile.AcademicYear")%>
						<td class="tablebold">:</td>
						<td class="tablelight" ><%=sessionname1%>
						</td>
						<td class="tablebold" ><%=bundle.getString("label.studentprofile.Standard")%>
						</td>
						<td class="tablebold">:</td>
						<td class="tablelight" ><%=standardname1%>
						</td>
						</tr>
						<tr style="height: 20">
						<td class="tablebold" ><%=bundle.getString("label.studentprofile.Board")%>
						</td>
						<td class="tablebold">:</td>
						<td class="tablelight" ><%=boardname%>
						</td>
						<td class="tablebold" ><%=bundle.getString("label.studentprofile.Section")%>
						</td>
						<td class="tablebold">:</td>
						<td class="tablelight" ><%=sectionname1%>
						</td>
						</tr>
						</table></td></tr>
				</tbody>
			</table>
			<br>
			</td>
	</tr>
	<TR valign="top" >
		<td>
		<table border=0 id="rounded-corner" width="80%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="10"></th>
					<th scope="col" class="rounded" width="100%" colspan=3><%=bundle.getString("label.studentprofile.PersonalDetails")%></th>
					<th scope="col" class="rounded-q4" width="10" ><a href="#"  onclick="personalprofileupdate()" id=edit1><img align=right src="<%=request.getContextPath()%>/jsp/kycpanel/images/user_edit.png" alt="" title="Update" border="0" /></a></th>
				</tr>
			</thead>
			<tfoot>
				<tr> 
					<td colspan=4 class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody> 
				<tr style="height: 20">
				<td></td>
					<td class="tablebold" style="width: 15%"><%=bundle.getString("label.studentprofile.Name")%>
					</td>
					<td class="tablelight" style="width: 45%" ><%=name%>
					</td>
					<td rowspan="6" align=right>
					<table border=0 cellpadding=0><tr><td>
					<img
						src="<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2=<%=photo%>"
						name='stphoto_img1' id=stphoto_img width=120 height=130/>
						</td></tr></table>
						</td>
						
					<td></td>
						
				</tr>
				
 				<tr style="height: 20">
 								<td></td>
 				
					<td class="tablebold" style="width: 15%"><%=bundle.getString("label.studentprofile.dateofbirth")%>
					</td>
					<td class="tablelight"  style="width: 35%" ><%=dob%></td>
				<td></td>

				</tr>
				<tr style="height: 20">
								<td></td>
				
					<td class="tablebold" style="width: 15%"><%=bundle.getString("label.studentprofile.Age")%>
					</td>
					<td class="tablelight"  style="width: 35%" ><%=age%>&nbsp;Years</td>
					<td></td>

				</tr>
				<tr style="height: 20"><td></td>
					<td class="tablebold" style="width: 15%"><%=bundle.getString("label.studentprofile.Sex")%>
					</td>
					<td class="tablelight"  style="width: 35%"  ><%=sexvalue%></td>
				<td></td>
				</tr>
				<tr style="height: 20">
								<td></td>
				
					<td class="tablebold" style="width: 15%"><%=bundle.getString("label.studentprofile.FatherName")%></td>
					<td class="tablelight"  style="width: 45%"><%=fname%>
					</td>
					<td></td>
				</tr>
				<tr style="height: 20">
								<td></td>
				
					<td class="tablebold" style="width: 15%"><%=bundle.getString("label.studentprofile.MotherName")%></td>
					<td class="tablelight"  style="width: 45%" colspan=2><%=mname%>
					</td>
									<td></td>
					
				</tr>
				<tr style="height: 20">
				<td></td>
					<td class="tablebold" style="width: 15%"><%=bundle.getString("label.studentprofile.Nationality")%>
					</td>
					<td class="tablelight"  align=left style="width: 35%"><%=nationality%></td>
				<td></td><td></td>
				</tr>
				<% if(rb.getString("communityflag").equals("yes")){ %>
				<tr style="height: 20"><td></td>
					<td class="tablebold" style="width: 15%"><%=bundle.getString("label.studentprofile.Community")%>
					</td>
					<td class="tablelight"  style="width: 35%" align=left><%=community%></td>

				<td></td><td></td></tr>
				<%} %>
									<% if(rb.getString("religionflag").equals("yes")){ %>
				
				<tr style="height: 20"><td></td>
					<td class="tablebold" style="width: 15%" ><%=bundle.getString("label.studentprofile.Religion")%>
					</td>
					<td class="tablelight" style="width: 35%"  align=left><%=religion%></td>
				<td></td><td></td></tr>
				<%} %>
				<tr style="height: 20"><td></td>
					<td class="tablebold" style="width: 15%"><%=bundle.getString("label.studentprofile.Language")%>
					</td>
					<td class="tablelight" style="width: 35%"   align=left><%=language%></td>
				<td></td><td></td></tr>
				<tr style="height: 20"><td></td>
					<td class="tablebold" style="width: 15%" ><%=bundle.getString("label.studentprofile.Bloodgroup")%>
					</td>
					<td class="tablelight" style="width: 35%" align=left ><%=bloodgroup%></td>
				<td></td><td></td></tr>
			</tbody>
			</table>
			<br>
			</td>
	</tr>
	<tr>
	<td>
	
		<table border=0 id="rounded-corner"  width="80%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="10"></th>
					<th scope="col" class="rounded"  width="100%" align=left colspan=4><%=bundle.getString("label.studentprofile.ContactDetails")%></th>
					<th scope="col" class="rounded-q4" width="10"><a href="#" onclick="contactprofileupdate()" id=edit2><img align=right src="<%=request.getContextPath()%>/jsp/kycpanel/images/user_edit.png" alt="" title="Update" border="0" /></a></th>

				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan=5 class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody> 
			<tr height=25><td></td>
				<td align=left colspan=5 class="tablebold"><%=bundle.getString("label.studentprofile.CommunicationAddress")%></td>
			</tr>
					<tr height=25>
					<td></td>
						<td align=left class="tablebold"><%=bundle.getString("label.studentprofile.Street1")%></td>  
						<td align=left colspan=4><%=communicationstreet1%></td>
					</tr>
					<tr height=25>
					<td></td>
						<td align=left class="tablebold"><%=bundle.getString("label.studentprofile.Street2")%></td>
						<td align=left colspan=4><%=communicationstreet2%></td>
					</tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%"><%=bundle.getString("label.studentprofile.city")%>
						</td>
						<td class="tablelight" style="width: 35%"><%=communicationcity%>
						</td>
						<td class="tablebold" style="width: 15%"><%=bundle.getString("label.studentprofile.state")%>
						</td>
						<td class="tablelight" style="width: 35%" colspan=2><%=communicationstate%>
						</td>
					</tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%"><%=bundle
										.getString("label.studentprofile.country")%>
						</td>
						<td class="tablelight" style="width: 35%"><%=communicationcountry%>
						</td>
						<td class="tablebold" style="width: 15%"><%=bundle.getString("label.studentprofile.Pin")%>
						</td>
						<td class="tablelight" style="width: 35%" colspan=2><%=communicationpin%>
						</td>
					</tr>
					<tr height=25><td></td>
						<td align=left colspan=5 class="tablebold"><%=bundle.getString("label.studentprofile.PermanentAddress")%></td>
					</tr>

					<tr height=25><td></td>
						<td align=left class="tablebold"><%=bundle.getString("label.studentprofile.Street1")%></td>
						<td align=left colspan=4><%=permanentstreet1%></td>
					</tr>
					<tr height=25><td></td>
						<td align=left class="tablebold"><%=bundle.getString("label.studentprofile.Street2")%></td>
						<td align=left colspan=4><%=permanentstreet2%></td>
					</tr>

					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%"><%=bundle.getString("label.studentprofile.city")%>
						</td>
						<td class="tablelight" style="width: 35%"><%=permanentcity%>
						</td>
						<td class="tablebold" style="width: 15%"><%=bundle.getString("label.studentprofile.state")%>
						</td>
						<td class="tablelight" style="width: 35%" colspan=2><%=permanentstate%>
						</td>
					</tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%"><%=bundle
										.getString("label.studentprofile.country")%>
						</td>
						<td class="tablelight" style="width: 35%"><%=permanentcountry%>
						</td>
						<td class="tablebold" style="width: 15%"><%=bundle.getString("label.studentprofile.Pin")%>
						</td>
						<td class="tablelight" style="width: 35%" colspan=2><%=permanentpin%> 
						</td>
					</tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%"><%=bundle.getString("label.studentprofile.landlineno")%>
						</td>
						<td class="tablelight" style="width: 35%" colspan=4><%=landline%></td>
					</tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%" ><%=bundle.getString("label.studentprofile.Email")%>
						</td>
						<td class="tablelight" style="width: 35%" colspan=4><a href="mailto:<%=email%>"><%=email%></a></td>
					</tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%" ><%=bundle.getString("label.studentprofile.SMSContactNo.")%>
						</td>
						<td class="tablelight" style="width: 35%" colspan=4><%=smscontactno%></td>
					</tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%" ><%=bundle.getString("label.studentprofile.MobileNo.")%>
						</td>
						<td class="tablelight" style="width: 35%" colspan=4><%=mobilenumber%></td>
					</tr>
				</tbody>
			</table>
			<br>
		</td>
	</tr>
	<tr>
	<td>
		<table border=0 id="rounded-corner" width="80%">
			<thead>
			<tr>
					<th scope="col" class="rounded-company" width="10"></th>
					<th scope="col" class="rounded"  width="100%" align=left colspan=2><%=bundle.getString("label.studentprofile.Parent/GuardianDetails")%></th>
					<th scope="col" class="rounded-q4" width="10"><a href="#" onclick="parentguardianprofileupdate()"  id=edit3><img align=right src="<%=request.getContextPath()%>/jsp/kycpanel/images/user_edit.png" alt="" title="Update" border="0" /></a></th>

				</tr>
				
			</thead>
			<tfoot>
				<tr>
					<td colspan=3 class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody>
					<tr>
						<td></td>
						<td align=left class="tablebold"><%=bundle.getString("label.studentprofile.Parent/GuardianName")%></td>
						<td align=left ><%=guardianname%></td>
					<td></td></tr>
					<tr>
						<td></td>
						<td align=left class="tablebold"><%=bundle.getString("label.studentprofile.Parent/GuardianMail")%></td>
						<td align=left ><a href="mailto:<%=guardianemail%>"><%=guardianemail%></a></td>
					<td></td></tr>
				
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 35%"><%=bundle.getString("label.studentprofile.Parent/GuardianRelation")%>
						</td>
						<td class="tablelight" style="width: 65%"><%=relation%>
						<td></td>
						
					</tr>
					
					<tr height=25><td></td>
						<td align=left class="tablebold"><%=bundle.getString("label.studentprofile.Parent/GuardianSelfEmployed")%></td>
						<td align=left ><%=self%></td>
					<td></td>	
					</tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 35%"><%=bundle.getString("label.studentprofile.NameOforganization")%>
						</td>
						<td class="tablelight" style="width: 65%"><%=nameoforganization%>
						<td></td>
					</tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 35%"><%=bundle.getString("label.studentprofile.AnnualIncomeRs")%>
						</td>
						<td class="tablelight" style="width: 65%"><%=annualincome%>
						</td>
					<td></td></tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 35%"><%=bundle.getString("label.studentprofile.Position")%>
						</td>
						<td class="tablelight" style="width: 65%" ><%=position%></td>
					<td></td></tr>
				</tbody>
			</table>
			<br>
		</td>
	</tr>
	<tr>
	<td>
	
<table border=0 id="rounded-corner" width="80%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="10"></th>
					<th scope="col" class="rounded"  width="100%" colspan=2><%=bundle.getString("label.studentprofile.ScholarshipDetails")%></th>
					<th scope="col" class="rounded-q4" width="10"></th>

				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan=3 class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody>
						<tr height=25>
						<td></td>
						<td align=left class="tablebold"><%=bundle.getString("label.studentprofile.PhysicallyChallenged")%></td>
						<td align=left colspan=2><%=physicallyfit%></td>
					</tr>
				<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 35%"><%=bundle.getString("label.studentprofile.Son/DaughterofEx-Serviceman")%> 						</td>
						<td class="tablelight" style="width: 65%" colspan=2><%=exserviceman%>
						</td>
						
					</tr>
										<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 35%"><%=bundle.getString("label.studentprofile.Personalphysicalmarks")%>
						</td>
						<td class="tablelight" style="width: 65%" colspan=2><%=physicalmark%>
						</td>
					</tr>
					
				</tbody>
			</table>
			<br>
		</td>
	</tr>
	<tr>
	<td>
		<table border=0 id="rounded-corner" width="100%" align=left>
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="10"></th>
					<th scope="col" class="rounded"  width="100%" ><%=bundle.getString("label.studentprofile.ExtraCurricularactivities")%></th>
					<th scope="col" class="rounded-q4" width="10"><a href="#" onclick="previousextracurricularprofileupdate()" id=edit4><img align=right src="<%=request.getContextPath()%>/jsp/kycpanel/images/user_edit.png" alt="" title="Update" border="0" /></a></th>

				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan=2 class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody>
			<tr>
				<td width="100%" colspan=3 align=left>
				<table width="100%" border=0 align=left>
					<tr style="height: 20">
						<td class="tablelight"  align=left>
						<% 
						if(studextracurricular.equals("-")|| studextracurricular.equals("") || studextracurricular.equals("null") ){
						%>	Extra curricular activity not selected<% }else{ %>
							
						<%=studextracurricular%>
						<%} %>
						</td>
					</tr>
					</table>
				</tbody>
			</table>
		</td>
	</tr>
	<tr>
	<td>
	<br>  
		<table border=0 id="rounded-corner" width="100%" align=left>
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="1"> </th>
					<th scope="col" class="rounded"  width="100%" >Scholarship Details</th>
					<th scope="col" class="rounded-q4" width="10"><a href="#" onclick="previousscholarshipupdate()" id=edit4><img align=right src="<%=request.getContextPath()%>/jsp/kycpanel/images/user_edit.png" alt="" title="Update" border="0" /></a></th>

				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan=2 class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody>
			<tr>
				<td width="100%" colspan=3 align=left>
				
					<table width="100%" border="0">
							<tr class=tableheading><td>SL. No.</td><td>Term Name</td><td>Scholarship Name</td><td>Amount</td></tr>
					
					<%
					ArrayList scholarshipList 	= studentquery.loadScholarshipDetails(personid, standardscheduleid);
							HashMap hashmap	= null;
						int inc=0;
							if(scholarshipList != null && scholarshipList.size()>0)
							for(int y=0;y<scholarshipList.size();y++){
								hashmap			= (HashMap)scholarshipList.get(y);
								if(hashmap.get("schemeforstudentid")!=null)
								{
									inc++;
								out.print("<tr><td>"+(inc)+"</td><td>"+hashmap.get("termname")+"</td><td>"+hashmap.get("scholarshipname")+"</td><td>"+hashmap.get("amount")+"</td>");
									//out.print("<td><input type=checkbox name=scholarshipallocation value='"+hashmap.get("scholarshipamountallocationid")+"'><input type=hidden name='termfeesid' value='"+hashmap.get("termfeesid")+"'><input type=hidden name='amount' value='"+hashmap.get("amount")+"'>");
									}
								
/* 								else
									out.print("<td><input type=checkbox checked name=scholarshipallocation value='"+hashmap.get("scholarshipamountallocationid")+"'><input type=hidden name='termfeesid' value='"+hashmap.get("termfeesid")+"'><input type=hidden name='amount' value='"+hashmap.get("amount")+"'></tr>");
 */									
							}
							if(inc ==0)
							{
								out.print("<tr><td>Data Not Found</td></tr>");
							}
					%>
					</table>
				<%-- <table width="100%" border=0 align=left>
					<tr style="height: 20" class="tablebold">
						<td>Sl.No.</td><td>Scholarship Name</td><td>Amount</td>
					</tr>
						<% 
						HashMap hashMap	= null;
							if(scholarshipList != null && scholarshipList.size()>0){
								for(int y=0;y<scholarshipList.size();y++){
									
									hashMap	= (HashMap)scholarshipList.get(y);
									String scholarshipamountallocationid = (String) hashMap.get("scholarshipamountallocationid");
									//hashMap.get("scholarshipamountallocationid");
									
									
									
									out.print("<tr class='tablelight'><td>"+(y+1)+".</td><td>"+hashMap.get("scholarshipname")+"</td><td>"+hashMap.get("amount")+"</td></tr>");
									out.println("<input type='hidden' name='scholarshipamountallocationid' value='"+hashMap.get("scholarshipamountallocationid")+"'>");
								}							
							  
								
							}else{
								out.print("<tr class='nodata'><td colspan='3' align='center'>Data Not Found</td></tr>");
							}
							
						%>
						
					
					</table> --%>
				</tbody>
			</table>
		</td>
	</tr>
<tr>
	<td>
				<br>  
	
		<table border=0 id="rounded-corner" width="80%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="10"></th>
					<th scope="col" class="rounded"  width="100%" colspan=2><%=bundle.getString("label.studentprofile.PreviousSchoolDetails")%></th>
					<th scope="col" class="rounded-q4" width="10"><a href="#" onclick="previousschoolprofileupdate()"  id=edit5><img align=right src="<%=request.getContextPath()%>/jsp/kycpanel/images/user_edit.png" alt="" title="Update" border="0" /></a></th>

				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan=3 class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody>
				<%
			if(previousschoolhistory.equals("yes"))
			{
			%>
				<tbody> 
					<tr height=25>
					<td></td>
						<td align=left class="tablebold"><%=bundle.getString("label.studentprofile.NameoftheSchool")%></td>
						<td align=left colspan=2><%=previousschoolname%></td>
					</tr>

					<tr style="height: 20"><td></td>
						<td class="tablebold"  style="width: 35%"><%=bundle.getString("label.studentprofile.AddressoftheSchool")%>
						</td>
						<td class="tablelight" style="width: 65%" colspan=2><%=previousschooladdress%>
						</td>
					</tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold"  style="width: 35%"><%=bundle.getString("label.studentprofile.MediumofInstruction")%>
						</td>
						<td class="tablelight" style="width: 65%" colspan=2><%=mediumstudied%>
						</td>
						
					</tr>
				</tbody>
			</table>
			<br>
		</td>
	</tr>
	
	<tr>
	<td>
		<table border=0 id="rounded-corner" width="80%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="10"></th>
					<th scope="col" class="rounded"  width="100%" ><%=bundle.getString("label.studentprofile.ExaminationDetails")%></th>
					<th scope="col" class="rounded-q4" width="10"></th>

				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan=2 class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody>
				
			<tr>
			<td></td>
				<td width="100%" colspan=2>  
				<table width="100%" border=0 >
					<tr bgcolor="#EEEEEE">
						<td class="headerfont" width="20%" align="left" class="tablebold"><%=bundle.getString("label.studentprofile.Subjects")%></td>
						<td class="headerfont" width="20%" class="tablebold"><%=bundle.getString("label.studentprofile.Month-Year")%> 
						<td class="headerfont" width="20%" class="tablebold"><%=bundle.getString("label.studentprofile.RegistrationNo")%></td>
						<td class="headerfont" width="20%" class="tablebold"><%=bundle.getString("label.studentprofile.MarksScored")%></td>
						<td class="headerfont" width="20%" class="tablebold"><%=bundle.getString("label.studentprofile.MaxMarks")%></td>

					</tr>
					<%
					if (qualification_list != null && qualification_list.size() > 0) {
						for(int i=0;i<qualification_list.size();i++)
							{
					 			map = (HashMap) qualification_list.get(i);
					 			String subject  = (String) map.get("subject");
					 			String monthandyear = (String) map.get("monthandyear");
					 			String registrationno = (String) map.get("registrationno");
					 			String marksscored = (String) map	.get("marksscored");
					 			String maxmarks = (String) map.get("maxmarks");
					 			out.println("<tr>");
					 			out.println("<td>"+subject+"</td>");
					 			out.println("<td>"+monthandyear+"</td>");
					 			out.println("<td>"+registrationno+"</td>");
					 			out.println("<td>"+marksscored+"</td>");
					 			out.println("<td>"+maxmarks+"</td>");

					 			out.println("</tr>");							}
			 			}
					%>
					</table>
				</tbody>
			</table>
			<br>
		</td>
		<td></td>
	</tr>
	
	<tr>
	<td>
		<table border=0 id="rounded-corner" width="80%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="10"></th>
					<th scope="col" class="rounded"  width="100%" ><%=bundle.getString("label.studentprofile.VerificationofCertificates")%></th>
					<th scope="col" class="rounded-q4" width="10"></th>

				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan=2 class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody>
			<tr>
			<td></td>
				<td width="100%" >
				<table width="100%" border=0 align=left >
					<tr height=25>
						<td align=left class="tablebold"><%=bundle.getString("label.studentprofile.T.C")%></td>
						<td align=left ><%=tc%></td>
					</tr>
					<tr style="height: 20">
						<td class="tablebold" style="width: 35%"><%=bundle.getString("label.studentprofile.C.C")%>
						</td>
						<td class="tablelight" style="width: 65%"><%=cc%>
						</td>
					</tr>
					<tr style="height: 20">
						<td class="tablebold" style="width: 35%"><%=bundle.getString("label.studentprofile.Spl.Category")%>
						</td>
						<td class="tablelight" style="width: 65%"><%=splcategory%>
						</td>
						</tr>
						<tr style="height: 20">
						<td class="tablebold" style="width: 35%"><%=bundle.getString("label.studentprofile.MedicalCertificate")%>
						</td>
						<td class="tablelight" style="width: 65%"><%=medicalcertificate%>
						</td>
						</tr>
						<tr style="height: 20">
						<td class="tablebold" style="width: 35%"><%=bundle.getString("label.studentprofile.MarkSheet")%>
						</td>
						<td class="tablelight" style="width: 65%"><%=marksheet%>
						</td>
						</tr>
						<tr style="height: 20">
						<td class="tablebold" style="width: 35%"><%=bundle.getString("label.studentprofile.SportsCertificate")%>
						</td>
						<td class="tablelight" style="width: 65%"><%=sportscertificate%>
						</td>
						</tr>
					</table>
					</td>
					<td></td>
					</tr>
				</tbody>
				</table>
				<br>
				<%} else
			{%>
			<tbody>
			<tr>
				<td width="100%" colspan=4 align=center><%=bundle.getString("label.studentprofile.message")%></td>
			</tr>
			</tbody>
			</table>
			<%} %>
			<a href="#"  onclick="backfun()" class="bt_blue"><span
		class="bt_blue_lft"></span><strong><%=bundle.getString("button.studentprofile.Back")%></strong><span
		class="bt_blue_r"></span></a> 
		</td>
	</tr>
	</table>
	<%
		}
	%>
	<script> 
	if(document.f1.req_sessionstatus.value=="R")
	{
		document.getElementById("edit1").style.visibility="hidden";
		document.getElementById("edit2").style.visibility="hidden";
		document.getElementById("edit3").style.visibility="hidden";
		document.getElementById("edit4").style.visibility="hidden";
		document.getElementById("edit5").style.visibility="hidden";
	}
	</script>
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