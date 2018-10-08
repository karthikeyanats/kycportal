<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child | Powered by i-Grandee</title>
<LINK rel=stylesheet href="<%=request.getContextPath()%>/css/kyccss.css">
<link rel="stylesheet" type="text/css" 	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script>
function backfun()
{
if(document.f1.condition.value=="standardview")
{
document.f1.action="./StandardWiseStudentView.jsp";
}
else if(document.f1.condition.value=="studentlist")
{
document.f1.action="./StudentListView.jsp";
}
else if(document.f1.condition.value=="communityview")
{
document.f1.action="../Reports/Community/CommunityStdWiseStudentView.jsp";
}
else if(document.f1.condition.value=="communitysecview")
{
document.f1.action="../Reports/Community/CommunitySecWiseStudentView.jsp";
}
else if(document.f1.condition.value=="combcommunitysecview")
{
document.f1.action="../Reports/Community/CombCommunitySecWiseStudentView.jsp";
}
else if(document.f1.condition.value=="combcommunityview")
{
document.f1.action="../Reports/Community/CombCommunityStdWiseStudentView.jsp";
}
else if(document.f1.condition.value=="religionview")
{
document.f1.action="../Reports/Religion/ReligionStdWiseStudentView.jsp";
}
else if(document.f1.condition.value=="religionsecview")
{
document.f1.action="../Reports/Religion/ReligionSecWiseStudentView.jsp";
}
else if(document.f1.condition.value=="superadminview")
{
document.f1.action="../SuperAdmin/StandardWiseStudentView.jsp";
}
else if(document.f1.condition.value=="superadminsecview")
{
document.f1.action="../SuperAdmin/SectionWiseStudentView.jsp";
}
else
{
document.f1.action="./SectionWiseStudentView.jsp";
}
document.f1.submit();
}
</script>

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
 %> <%@ page import="com.iGrandee.Registration.StaffRegistrationQuery,com.iGrandee.Registration.StudentRegistrationQuery"%>

<%
	String date_str = "";
	ArrayList deptList = null;
	StudentRegistrationQuery studentquery = new StudentRegistrationQuery();
	String personid = null;
	ArrayList person_list =null;
	ArrayList contact_list =null;
	ArrayList guardian_list =null;
	ArrayList register_list =null;
	ArrayList qualification_list =null;
	String standardname=request.getParameter("standardname")+"";
	String standardscheduleid=request.getParameter("standardscheduleid")+"";
	String sectionname=request.getParameter("sectionname")+"";
	String sectionscheduleid=request.getParameter("sectionscheduleid")+"";
	String sexq=request.getParameter("sex")+"";
	String boardid=request.getParameter("hiddenboard")+"";
	String sessionid=request.getParameter("hiddensession")+"";
	String condition=request.getParameter("condition")+"";
	String sessionname			= request.getParameter("sessionname");
	String rootlabel="";
	String sessionstatus			="";
	if(((session.getValue("userrolename")+"").toLowerCase()).startsWith("admin"))
	{
		   sessionid=request.getParameter("req_sessionid")+"";
		   sessionname=request.getParameter("req_sessionname")+"";
		   sessionstatus=request.getParameter("req_sessionstatus")+"";
		   rootlabel="Reports /Session wise Report / Consolidated Student List ";
	}
	else
	{
		sessionid=session.getValue("sessionid")+"";
		sessionname=session.getValue("sessionname")+"";
		sessionstatus=request.getParameter("req_sessionstatus")+"";
		if(sessionstatus.equalsIgnoreCase("null") || sessionstatus.equalsIgnoreCase(""))
			sessionstatus="A";
		rootlabel="Standard / Standard List ";

	}

	String boardname			= request.getParameter("boardname");
String rootpath="";
		try {

			personid = request.getParameter("StudentPersonid");
			 person_list = studentquery.Studentpersondetails(personid);
	 		 contact_list = studentquery.Studentcontactdetails(personid);
	 		 guardian_list = studentquery.Studentguardiandetails(personid);
	 		 register_list = studentquery.Studentdetails(personid,sessionid,sessionstatus);
	 		qualification_list = studentquery.Studentqualificationdetails(personid);
	 		if(condition.equals("standardview"))
	 		{
	 			rootpath="/ "+standardname+" /";
	 		}
	 		else if(condition.equals("studentlist"))
	 		{
	 			rootpath="/ Student List View";	 		
	 			
	 		}
	 		else if(condition.equals("communityview"))
	 		{
	 			rootlabel=bundle.getString("label.reports.reportscommunitystudentlist")+" "+request.getParameter("operationlabel")+" / ";	
	 		}
	 		else if(condition.equals("communitysecview"))
	 		{
	 			rootlabel=bundle.getString("label.reports.reportscommunitystudentlist")+" / Section Wise "+request.getParameter("operationlabel")+" / ";	
	 		}	 		
	 		else if(condition.equals("combcommunitysecview"))
	 		{
	 			rootlabel=bundle.getString("label.reports.reportscommunitystudentlist")+" / Combined View / Section Wise "+request.getParameter("operationlabel")+" / ";	
	 		}
	 		else if(condition.equals("combcommunityview"))
	 		{
	 			rootlabel=bundle.getString("label.reports.reportscommunitystudentlist")+" / Combined View "+request.getParameter("operationlabel")+" / ";	
	 		}
	 		else if(condition.equals("religionview"))
	 		{
	 			rootlabel=bundle.getString("label.reports.reportsreligionstudentlist")+" "+request.getParameter("operationlabel")+" / ";	
	 		}
	 		else if(condition.equals("religionsecview"))
	 		{
	 			rootlabel=bundle.getString("label.reports.reportsreligionstudentlist")+" / Section Wise "+request.getParameter("operationlabel")+" / ";	
	 		}
	 		else if(condition.equals("superadminview"))
	 		{
	 			out.print("<br>");
	 			StaffRegistrationQuery staffquery=new StaffRegistrationQuery();
	 			rootlabel=staffquery.fieldValue("institutename","institution","instituteid",request.getParameter("req_instituteid"),"status",request.getParameter("req_instituteid"))+" / "+bundle.getString("label.superadmin.studentlistrootpath")+" / ";	
	 		}	 		
	 		else if(condition.equals("superadminsecview"))
	 		{
	 			out.print("<br>");
	 			StaffRegistrationQuery staffquery=new StaffRegistrationQuery();
	 			rootlabel=staffquery.fieldValue("institutename","institution","instituteid",request.getParameter("req_instituteid"),"status",request.getParameter("req_instituteid"))+" / "+bundle.getString("label.superadmin.studentlistrootpath")+" / Section Wise / ";	
	 		}	 		
	 		else
	 		{
	 			rootpath="/ "+standardname+" / "+sectionname+" /";
	 		}
	 	}
		catch (Exception e) {e.printStackTrace();
		}
%>
<h2><%=rootlabel %><%=rootpath %> Student Profile  Details</h2>
<form name="f1" method="post" action=""> <%
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

 		String communicationstate = "-";
 		String communicationcountry = "-";
 		String communicationcity = "-";
 		String communicationpin = "-";
 		String permanentstreet1 = "-";
 		String permanentstate = "-";
 		String permanentcountry = "-";
 		String permanentcity = "-";
 		String permanentpin = "-";
 		
 		String guardianname = "-";
 		String guardianmailid = "-";
 		String relation = "-";
 		String self = "-";
 		String nameoforganization = "-";
 		String annualincome = "-";
 		String position = "-";
 		
 		
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
 		String previousschoolhistory = "-";
 		String sectionname1 = "-";
 		String standardname1 = "-";
 		String sessionname1 = "-";
 		String smscontactno	= "-";
 		String mobilenumber	= "-";

 		

 		/*ArrayList person_list = (ArrayList)masterperson_list.get(0);
 		ArrayList contact_list = (ArrayList)masterperson_list.get(1);
 		ArrayList guardian_list = (ArrayList)masterperson_list.get(2);
 		ArrayList register_list = (ArrayList)masterperson_list.get(3);
 		ArrayList qualification_list = (ArrayList)masterperson_list.get(4);
 		ArrayList account_list =(ArrayList)masterperson_list.get(5);*/

 	 	java.util.ResourceBundle rb=java.util.ResourceBundle.getBundle("resources.serversetup");


 		

 		//experiance
 		
 		HashMap map = null;
 		
 		if (person_list != null && person_list.size() > 0) {
 			
 			
 			map = (HashMap) person_list.get(0);
 			name = (String) map.get("uname");
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

 			/*if(dob!=null)
 			{
 				String[] str_dob=dob.split("-");
 				dob=str_dob[1]+"-"+str_dob[0]+"-"+str_dob[2];
 			}*/

 			//out.println(gender);

 			landline = (String) map.get("landlinenumber")+"";
 			if (landline == null || landline.equals("null")  || landline.equals("") )
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
 			communicationcity = (String) map.get("communicationcity");
 			communicationstate = (String) map.get("communicationstate");
 			communicationcountry = (String) map
 					.get("communicationcountry");
 			communicationpin = (String) map.get("communicationpin");
 			permanentstreet1 = (String) map.get("permanentstreet1");
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
 				guardianmailid = "-";
 			else
 				guardianmailid = (String) map.get("guardianmailid");
 			relation = (String) map.get("relation");
 			nameoforganization = (String) map.get("nameoforganization");
 			self = (String) map	.get("self");
 			annualincome = (String) map.get("annualincome");
 			position = (String) map.get("position");
 			
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
 			studextracurricular = (String) map.get("studextracurricular");
 			previousschoolhistory = (String) map.get("previousschoolhistory")+"";
 			if(previousschoolhistory.equals(""))
 				previousschoolhistory="yes";
 			
 			sectionname1 = (String) map.get("sectionname");
 	 		standardname1 = (String) map.get("standardname");
 	 		sessionname1 = (String) map.get("sessionname");
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
 
 		
 			
 %>
<form name="f1" method="post" action="">
<input type="hidden" name="sectionscheduleid" value="<%=sectionscheduleid %>">
<input type="hidden" name="session" value="<%=sessionid%>">
<input type="hidden" name="standardscheduleid" value="<%=standardscheduleid %>">
<input type="hidden" name="board" value="<%=boardid%>">

<input type="hidden" name="standardname" value="<%=standardname%>">
<input type="hidden" name="sectionname" value="<%=sectionname %>">
<input type="hidden" name="sessionname" value="<%=sessionname%>">
<input type="hidden" name="boardname" value="<%=boardname%>">
<input type="hidden" name="sex" value="<%=sexq %>">
<input type="hidden" name="condition" value="<%=condition %>">
<input type="hidden" name="operation" value="<%=request.getParameter("operation")%>">
<input type="hidden" name="communityid" value="<%=request.getParameter("communityid")%>">
<input type="hidden" name="communityname" value="<%=request.getParameter("communityname")%>">
<input type="hidden" name="religionid" value="<%=request.getParameter("religionid")%>">
<input type="hidden" name="religionname" value="<%=request.getParameter("religionname")%>">
<input type="hidden" name="req_sessionid" value="<%=sessionid %>">
<input type="hidden" name="req_sessionname" value="<%=sessionname%>">
<input type=hidden name=req_sessionstatus value="<%=request.getParameter("req_sessionstatus") %>">
<input type="hidden" name="req_boardid" value="<%=request.getParameter("req_boardid") %>">
<input type="hidden" name="req_boardname" value="<%=request.getParameter("req_boardname") %>">
<input type="hidden" name="req_instituteid" value="<%=request.getParameter("req_instituteid") %>">

<TABLE border=0 class="tablecolor" cellspacing=0 width=100% align=center
	height=485 cellpadding=0>
	<tr>
	<td>
	
		<table border=0 id="rounded-corner" width="90%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company"  width="99%"><%=bundle.getString("label.schedule.selectedinfo")%></th>
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
			<td colspan=2>
    			<table border=0 cellpadding=0 width="100%">
    			<tr>
						<td class="tablebold" style="width: 15%"><%=bundle.getString("label.studentprofile.AcademicYear")%>
						</td>
						<td class=tablebold>:</td>
						<td class="tablelight" style="width: 35%"><%=sessionname1%>
						</td>
						<td class="tablebold" style="width: 15%"><%=bundle.getString("label.studentprofile.Standard")%>
						</td>
						<td class=tablebold>:</td>
						<td class="tablelight" style="width: 35%"><%=standardname1%>
						</td>
			
						
						</tr>
						
						<tr>
					
						<td class="tablebold" style="width: 15%"><%=bundle.getString("label.studentprofile.Section")%>
						</td>
						<td class=tablebold>:</td>
						<td class="tablelight" style="width: 35%" colspan='4'><%=sectionname1%>
						</td>
						</tr>
			</table></td></tr>			
				</tbody>
			</table>
			<br>
			</td>
	</tr>
	<tr valign="top" >
		<td>
		<table  id="rounded-corner" border=0 cellspacing=0 cellpadding=0 width="100%">
		<thead>
					<tr>
									<th scope="col" class="rounded-company" width="90%">
									<%=bundle.getString("label.studentprofile.PersonalDetails")%>
									</th>
									<th scope="col" class="rounded-q4" width="10%" ></th>
						</tr>
						</thead>

				<tr>
				<td colspan=2>
					<table border=0 cellspacing=0 cellpadding=0 width="100%">
					<tr>
						<td class=tablebold><%=bundle.getString("label.studentprofile.Name")%></td><td><%=name%></td><td rowspan=5><img
								src="<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2=<%=photo%>"
								name='stphoto_img1' id=stphoto_img width=120 height=130></td>
					</tr>
					<tr>
									<td class=tablebold><%=bundle.getString("label.studentprofile.dateofbirth")%></td><td><%=dob%></td>
					</tr>
					<tr>
									<td class=tablebold><%=bundle.getString("label.studentprofile.Age")%></td><td><%=age%>&nbsp;<%=bundle.getString("label.studentprofile.Years")%></td>
					</tr>
					<tr>
												<td class=tablebold><%=bundle.getString("label.studentprofile.Sex")%></td><td><%=sex%></td>
					</tr>
					<tr>
												<td class=tablebold><%=bundle.getString("label.studentprofile.FatherName")%></td><td><%=fname%></td>
					</tr>


				<tr>
					<td class=tablebold>
						<%=bundle.getString("label.studentprofile.MotherName")%>
					</td>
					<td colspan=2><%=mname%></td>
				</tr>


				<tr>
					<td class=tablebold>
						<%=bundle.getString("label.studentprofile.Nationality")%>
					</td>
					<td colspan=2>
						<%=nationality%>
					</td>
				</tr>

<% if(rb.getString("communityflag").equals("yes")){ %>
				<tr>
					<td class=tablebold>
						<%=bundle.getString("label.studentprofile.Community")%>
					</td>
					<td colspan=2>
						<%=community%>
					</td>
				</tr>

<%} %>
					<% if(rb.getString("religionflag").equals("yes")){ %>
				<tr>
					<td class=tablebold>
						<%=bundle.getString("label.studentprofile.Religion")%>
					</td>
					<td colspan=2>
						<%=religion%>
					</td>
				</tr>
<%} %>
				<tr>
					<td class=tablebold>
						<%=bundle.getString("label.studentprofile.Language")%>
					</td>
					<td colspan=2>
						<%=language%>
					</td>
				</tr>


				<tr>
					<td class=tablebold>
						<%=bundle.getString("label.studentprofile.Bloodgroup")%>
					</td>
					<td colspan=2>
						<%=bloodgroup%>
					</td>
		</tr>


					</table>
				</td></tr>
			</table>
			</td>
	</tr>
	<tr>
	<td>
		<table border=0 id="rounded-corner" width="80%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company"  width="99%" colspan=5><%=bundle.getString("label.studentprofile.ContactDetails")%></th>
					<th scope="col" class="rounded-q4" width="1%"></th>

				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan=5 class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody>
				<tr height=25>
				<td></td>
				<td align=left colspan=4 class="tablebold"><%=bundle.getString("label.studentprofile.CommunicationAddress")%></td>
				<td></td>
				</tr>
					<tr height=25><td></td>
						<td align=left class="tablebold"><%=bundle.getString("label.studentprofile.Street")%></td>
						<td align=left colspan=3><%=communicationstreet1%></td>
					<td></td></tr>

					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%"><%=bundle.getString("label.studentprofile.city")%>
						</td>
						<td class="tablelight" style="width: 35%"><%=communicationcity%>
						</td>
						<td class="tablebold" style="width: 15%"><%=bundle.getString("label.studentprofile.state")%>
						</td>
						<td class="tablelight" style="width: 35%"><%=communicationstate%>
						</td><td></td>
					</tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%"><%=bundle
										.getString("label.studentprofile.country")%>
						</td>
						<td class="tablelight" style="width: 35%"><%=communicationcountry%>
						</td>
						<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffdetails.Pin")%>
						</td>
						<td class="tablelight" style="width: 35%"><%=communicationpin%>
						</td><td></td>
					</tr>
					<tr height=25><td></td>
						<td align=left colspan=5 class="tablebold"><%=bundle.getString("label.studentprofile.PermanentAddress")%></td>
					</tr>

					<tr height=25><td></td>
						<td align=left class="tablebold"><%=bundle.getString("label.studentprofile.Street")%></td>
						<td align=left colspan=3><%=permanentstreet1%></td><td></td>
					</tr>

					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%"><%=bundle.getString("label.studentprofile.city")%>
						</td>
						<td class="tablelight" style="width: 35%"><%=permanentcity%>
						</td>
						<td class="tablebold" style="width: 15%"><%=bundle.getString("label.studentprofile.state")%>
						</td>
						<td class="tablelight" style="width: 35%"><%=permanentstate%>
						</td><td></td>
					</tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%"><%=bundle
										.getString("label.studentprofile.country")%>
						</td>
						<td class="tablelight" style="width: 35%"><%=permanentcountry%>
						</td>
						<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffdetails.Pin")%>
						</td>
						<td class="tablelight" style="width: 35%"><%=permanentpin%> 
						</td><td></td>
					</tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%"><%=bundle.getString("label.studentprofile.landlineno")%>
						</td>
						<td class="tablelight" style="width: 35%" colspan=3><%=landline%></td>
					<td></td></tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 25%" ><%=bundle.getString("label.studentprofile.SMSContactNo.")%>
						</td>
						<td class="tablelight" style="width: 35%" colspan=3><%=smscontactno%></td><td></td>
					</tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%" ><%=bundle.getString("label.studentprofile.MobileNo.")%>
						</td>
						<td class="tablelight" style="width: 35%" colspan=4><%=mobilenumber%></td>
					</tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%" ><%=bundle.getString("label.studentprofile.Email")%>
						</td>
						<td class="tablelight" style="width: 35%" colspan=3><a href="mailto:<%=email%>"><%=email%></a></td>
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
					<th scope="col" class="rounded-company"  width="99%" colspan=3><%=bundle.getString("label.studentprofile.Parent/GuardianDetails")%></th>
					<th scope="col" class="rounded-q4" width="1%"></th>

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
					<tr height=25>
					<td></td>
						<td align=left class="tablebold"><%=bundle.getString("label.studentprofile.Parent/GuardianName")%></td>
						<td align=left ><%=guardianname%></td><td></td>
					</tr>
					
					<tr height=25>
					<td></td>
						<td align=left class="tablebold"><%=bundle.getString("label.studentprofile.Parent/GuardianMail")%></td>
						<td align=left ><a href="mailto:<%=guardianmailid%>"><%=guardianmailid%></a></td><td></td>
					</tr>
					
					
				
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%"><%=bundle.getString("label.studentprofile.Parent/GuardianRelation")%>
						</td>
						<td class="tablelight" style="width: 35%"><%=relation%>
						</td><td></td>
						
					</tr>
					<tr height=25><td></td>
						<td align=left class="tablebold"><%=bundle.getString("label.studentprofile.Parent/GuardianSelfEmployed")%></td>
						<td align=left ><%=self%></td>
						
					<td></td></tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%"><%=bundle.getString("label.studentprofile.NameOforganization")%>
						</td>
						<td class="tablelight" style="width: 35%"><%=nameoforganization%>
						</td>
					<td></td></tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%"><%=bundle.getString("label.studentprofile.AnnualIncomeRs")%>
						</td>
						<td class="tablelight" style="width: 35%"><%=annualincome%>
						</td>
					<td></td></tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 25%"><%=bundle.getString("label.studentprofile.Position")%>
						</td>
						<td class="tablelight" style="width: 75%"><%=position%></td>
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
					<th scope="col" class="rounded-company"  width="99%" colspan=3><%=bundle.getString("label.studentprofile.ScholarshipDetails")%></th>
					<th scope="col" class="rounded-q4" width="1%"></th>

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
						<td align=left ><%=physicallyfit%></td>
					<td></td></tr>
						<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 25%"><%=bundle.getString("label.studentprofile.Son/DaughterofEx-Serviceman")%>
						</td>
						<td class="tablelight" style="width: 75%"><%=exserviceman%>
						</td>
						<td></td>
					</tr>
										<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%"><%=bundle.getString("label.studentprofile.Personalphysicalmarks")%>
						</td>
						<td class="tablelight" style="width: 35%"><%=physicalmark%>
						</td><td></td>
					</tr>
			</table>
			<br>
		</td>
	</tr>
		<tr>
	<td>
		<table border=0 id="rounded-corner" width="100%" align=left>
			<thead>
				<tr>
					<th scope="col" class="rounded-company"  width="99%" colspan=2 ><%=bundle.getString("label.studentprofile.ExtraCurricularactivities")%></th>
					<th scope="col" class="rounded-q4" width="1%"></th>

				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan=2 class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody>
					<tr style="height: 20">
						<%if(studextracurricular!=null && !studextracurricular.equals("") && !studextracurricular.equals("null") && !studextracurricular.equals("-")) {%>
					
						<td></td><td class="tablelight" style="width: 95%" align=left><%=studextracurricular%>
						<%}else
							{%>
							<td></td><td class="tablelight" style="width: 95%" align=center>Extra curricular activity not selected
							
							<%} %>
						
						</td><td></td>
					</tr>
			</tbody>
			</table>
		</td>
	</tr>
	
	
	<tr>
		<td>
			<br></br>
			
			<table border=0 id="rounded-corner" width="100%" align=left>
			<thead>
				<tr>
					<th scope="col" class="rounded-company">Scholarship Details</th>
					<th scope="col" class="rounded"></th>
					<th scope="col" class="rounded-q4"></th>

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
					<th scope="col" class="rounded-company"  width="99%" colspan=3><%=bundle.getString("label.studentprofile.PreviousSchoolDetails")%></th>
					<th scope="col" class="rounded-q4" width="1%"></th>

				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan=3 class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<%
			if(previousschoolhistory.equals("yes"))
			{
			%><tbody>
					<tr height=25>
				<td></td>		<td align=left class="tablebold"><%=bundle.getString("label.studentprofile.NameoftheSchool")%></td>
						<td align=left ><%=previousschoolname%></td><td></td>
					</tr>

					<tr style="height: 20">
						<td></td><td class="tablebold" style="width: 25%"><%=bundle.getString("label.studentprofile.AddressoftheSchool")%>
						</td>
						<td class="tablelight" style="width: 75%"><%=previousschooladdress%>
						</td><td></td>
					</tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%"><%=bundle.getString("label.studentprofile.MediumofInstruction")%>
						</td>
						<td class="tablelight" style="width: 35%"><%=mediumstudied%>
						</td><td></td>
						
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
					<th scope="col" class="rounded-company"  width="99%" colspan=6><%=bundle.getString("label.studentprofile.ExaminationDetails")%></th>
					<th scope="col" class="rounded-q4" width="1%"></th>

				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan=6 class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody>
						<tr bgcolor="#EEEEEE"><td></td>
						<td class="headerfont" width="20%" align="left" class="tablebold"><%=bundle.getString("label.studentprofile.Subjects")%></td>
						<td class="headerfont" width="20%" class="tablebold"><%=bundle.getString("label.studentprofile.Month-Year")%> 
						<td class="headerfont" width="20%" class="tablebold"><%=bundle.getString("label.studentprofile.RegistrationNo")%></td>
						<td class="headerfont" width="20%" class="tablebold"><%=bundle.getString("label.studentprofile.MarksScored")%></td>
						<td class="headerfont" width="20%" class="tablebold"><%=bundle.getString("label.studentprofile.MaxMarks")%></td>
<td></td>
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
					 			out.println("<tr><td></td>");
					 			out.println("<td>"+subject+"</td>");
					 			out.println("<td>"+monthandyear+"</td>");
					 			out.println("<td>"+registrationno+"</td>");
					 			out.println("<td>"+marksscored+"</td>");
					 			out.println("<td>"+maxmarks+"</td>");

					 			out.println("<td></td></tr>");							}
			 			}
					%>
			
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
					<th scope="col" class="rounded-company"  width="99%" colspan=3><%=bundle.getString("label.studentprofile.VerificationofCertificates")%></th>
					<th scope="col" class="rounded-q4" width="1%"></th>

				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan=3 class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody>
					<tr height=25><td></td>
						<td align=left class="tablebold"><%=bundle.getString("label.studentprofile.T.C")%></td>
						<td align=left ><%=tc%></td><td></td>
					</tr>

					<tr style="height: 20">
						<td></td><td class="tablebold" style="width: 15%"><%=bundle.getString("label.studentprofile.C.C")%>
						</td>
						<td class="tablelight" style="width: 35%"><%=cc%>
						</td><td></td>
					</tr>
					<tr style="height: 20">
					<td></td>	<td class="tablebold" style="width: 15%"><%=bundle.getString("label.studentprofile.Spl.Category")%>
						</td>
						<td class="tablelight" style="width: 35%"><%=splcategory%>
						</td><td></td>
						</tr>
						<tr style="height: 20">
						<td></td><td class="tablebold" style="width: 25%"><%=bundle.getString("label.studentprofile.MedicalCertificate")%>
						</td>
						<td class="tablelight" style="width: 75%"><%=medicalcertificate%>
						</td><td></td>
						</tr>
						<tr style="height: 20">
						<td></td><td class="tablebold" style="width: 15%"><%=bundle.getString("label.studentprofile.MarkSheet")%>
						</td>
						<td class="tablelight" style="width: 35%"><%=marksheet%>
						</td><td></td>
						</tr>
						<tr style="height: 20">
						<td></td><td class="tablebold" style="width: 15%"><%=bundle.getString("label.studentprofile.SportsCertificate")%>
						</td>
						<td class="tablelight" style="width: 35%"><%=sportscertificate%>
						</td><td></td>
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
		</td>
	</tr>
	</table>
<a href="#" class="bt_blue" onclick='backfun()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.studentprofile.Back")%></strong><span class="bt_blue_r"></span></a>
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