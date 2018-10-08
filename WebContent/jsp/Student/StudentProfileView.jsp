<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
java.util.ResourceBundle rb=java.util.ResourceBundle.getBundle("resources.serversetup");
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child -<%=bundle.getString("label.studentprofile.title")%>| Powered by i-Grandee</title>
<LINK rel=stylesheet href="<%=request.getContextPath()%>/css/kyccss.css">

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script>
function backfun()
{
if(document.f1.backward.value=="Parent")
{
document.f1.action= "<%=request.getContextPath()%>/jsp/Parent/ParentHome.jsp";
}
else
{
document.f1.action= "./StudentHome.jsp";
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

<h2><%=bundle.getString("label.studentprofile.rootpath")%></h2>
<form name="f1" method="post" action=""><%@ page
	import="java.util.*"%> <%

 %> <%@ page import="com.iGrandee.Registration.StudentRegistrationQuery"%>

<%
	String date_str = "";
	ArrayList deptList = null;
	StudentRegistrationQuery studentquery = new StudentRegistrationQuery();
	String personid = null;
	String backward =request.getParameter("backward")+"";
	String userrole = session.getValue("userrolename")+"";
		try {
			//personid = request.getParameter("Staffid");

			String approvalid = session.getValue("studentid")+"";
			//System.out.println("approvalid"+approvalid);
			personid=studentquery.getpersonidviseallocationid(approvalid)+"";
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
 		String username = "-";
 		String previousschoolhistory = "-";
 		String smscontact = "-";
 		String mobilenumber	= "-";



 		/*ArrayList person_list = (ArrayList)masterperson_list.get(0);
 		ArrayList contact_list = (ArrayList)masterperson_list.get(1);
 		ArrayList guardian_list = (ArrayList)masterperson_list.get(2);
 		ArrayList register_list = (ArrayList)masterperson_list.get(3);
 		ArrayList qualification_list = (ArrayList)masterperson_list.get(4);
 		ArrayList account_list =(ArrayList)masterperson_list.get(5);*/

 		ArrayList person_list = studentquery.Studentpersondetails(personid);
 		ArrayList contact_list = studentquery.Studentcontactdetails(personid);
 		ArrayList guardian_list = studentquery.Studentguardiandetails(personid);
 		ArrayList register_list = studentquery.Studentregisterdetails(personid);
 		ArrayList qualification_list = studentquery.Studentqualificationdetails(personid);



 		//experiance
 		 		String sectionname1 = "-";
 		String standardname1 = "-";
 		String sessionname1 = "-";
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
 			dob = (String) map.get("dob");
 			sex = (String) map.get("sex");

 			/*if(dob!=null)
 			{
 				String[] str_dob=dob.split("-");
 				dob=str_dob[1]+"-"+str_dob[0]+"-"+str_dob[2];
 			}*/

 			//out.println(gender);

 			landline = (String) map.get("landlinenumber");
 			if (landline == null || landline.equals("") )
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
 			smscontact = (String) map.get("smscontactno")+"";
 			if (smscontact == null || smscontact.equals("null")  || smscontact.equals("") )
 				smscontact = "-";
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
			
			if(smscontact == null || smscontact.equals("") || smscontact.equalsIgnoreCase("null"))
				smscontact	= "-";

 %>
<form name="f1" method="post" action="">
<input type ="hidden" name="backward" value="<%=userrole %>">
<TABLE border=0  cellspacing=0 width=100% align=center
	height=485 cellpadding=0>

	<%
	if(session.getValue("usercategory").equals("P")){%>
	<tr>
	<td>
	<table id="rounded-corner" border=0 summary="Department List" width="100%">
					    <thead>
					    	<tr>
					        	
					            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.studentprofile.StudentDetails") %></th>
					            <th scope="col" class="rounded-q4" width="2%"></th>
					        </tr>
					    </thead>
					    <tr>
					    	<td colspan='2'>

								<%
									out.print("<table  border='0' bordercolor='blue' align='center' width='100%' cellspacing='0' cellpadding='5'>");
									out.print("<tr><td width='17%' class='tablebold'>"+bundle.getString("label.studentprofile.StudentName")+"</td><td width='1%' class='tablebold'>:</td><td>"+session.getValue("studentname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.studentprofile.AcademicYear")+"</td><td class='tablebold'>:</td><td>"+session.getValue("sessionname")+"</td></tr>");
									if(session.getValue("groupname") == null)
										out.print("<tr><td class='tablebold'>"+bundle.getString("label.studentprofile.StandardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("standardname")+"</td></tr>");
									else
										out.print("<tr><td class='tablebold'>"+bundle.getString("label.studentprofile.StandardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("standardname")+"&nbsp;&nbsp;[&nbsp;"+session.getValue("groupname")+"&nbsp;]</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.studentprofile.SectionName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("sectionname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.studentprofile.BoardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("boardname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.studentprofile.MediumName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("mediumname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.studentprofile.RollNo.")+"</td><td class='tablebold'>:</td><td>"+session.getValue("rollno") + "</td></tr>");

									out.print("</table>");
								%>
							</td>
						</tr>
					</table>
					<br>



			</td>
	</tr>
	<%} %>

	
	<TR valign="top" >
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
				<td class=tablebold><%=bundle.getString("label.studentprofile.Name")%></td><td><%=name%></td><td rowspan=5 align=right><img
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
	<br>
		<table border=0     id="rounded-corner"  width="80%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="10"></th>
					<th scope="col" class="rounded"  width="100%" align=left colspan=4><%=bundle.getString("label.studentprofile.ContactDetails")%></th>
					<th scope="col" class="rounded-q4" width="10"></th>

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
						<td align=left class="tablebold"><%=bundle.getString("label.studentprofile.Street")%></td>
						<td align=left colspan=4><%=communicationstreet1%></td>
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
						<td align=left colspan=5 class="tablebold"><%=bundle.getString("label.studentprofile.PersonalDetails")%></td>
					</tr>

					<tr height=25><td></td>
						<td align=left class="tablebold"><%=bundle.getString("label.studentprofile.Street")%></td>
						<td align=left colspan=4><%=permanentstreet1%></td>
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
						<td class="tablebold" style="width: 15%"><%=bundle.getString("label.studentsearch.smscontactno") %>
						</td>
						<td class="tablelight" style="width: 35%" colspan=3><%=smscontact%></td>
					<td></td></tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%" ><%=bundle.getString("label.studentprofile.MobileNo.")%>
						</td>
						<td class="tablelight" style="width: 35%" colspan=4><%=mobilenumber%></td>
					</tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%" ><%=bundle.getString("label.studentprofile.Email")%>
						</td>
						<td class="tablelight" style="width: 35%" colspan=4><a href="mailto:<%=email%>"><%=email%></a></td>
							</tr>
				</tbody>
			</table>
			<br>

	<tr>
	<td>
		<table border=0 id="rounded-corner" width="80%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="10"></th>
					<th scope="col" class="rounded"  width="100%" colspan=2><%=bundle.getString("label.studentprofile.Parent/GuardianDetails")%></th>
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
			<tr>
			<td></td>
						<td align=left class="tablebold"><%=bundle.getString("label.studentprofile.Parent/GuardianName")%></td>
						<td align=left ><%=guardianname%></td>
					<td></td></tr>
<tr>
			<td></td>
						<td align=left class="tablebold"><%=bundle.getString("label.studentprofile.Parent/GuardianMail")%></td>
						<td align=left ><a href="mailto:<%=guardianmailid%>"><%=guardianmailid%></a></td>
					<td></td></tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 35%"><%=bundle.getString("label.studentprofile.Parent/GuardianRelation")%>
						</td>
						<td class="tablelight" style="width: 65%"><%=relation%>
						<td></td></td>

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
						<td></td></td>
					</tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 35%"><%=bundle.getString("label.studentprofile.AnnualIncomeRs")%>.
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
		</br>
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
						<td class="tablebold" style="width: 35%"><%=bundle.getString("label.studentprofile.Son/DaughterofEx-Serviceman")%>	</td>
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
	</tr><tr><td>&nbsp;</td></tr>
	<tr>
	<td>
		<table border=0 id="rounded-corner" width="100%" align=left>
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="10"></th>
					<th scope="col" class="rounded"  width="100%" ><%=bundle.getString("label.studentprofile.ExtraCurricularactivities")%></th>
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
	</tr></br>
	<tr height=20><td colspan=2></td></tr>
		<tr>
	<td>
		<table border=0 id="rounded-corner" width="80%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="10"></th>
					<th scope="col" class="rounded"  width="100%" colspan=2><%=bundle.getString("label.studentprofile.PreviousSchoolDetails")%></th>
					<th scope="col" class="rounded-q4" width="10"></th>

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
						<td class="headerfont" width="20%" class="tablebold"><%=bundle.getString("label.studentprofile.RegistrationNo")%>.</td>
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
		</td>
	</tr>
</table>
<a href="#bbsb" name="bbsb" onclick=backfun() class="bt_blue" align=center><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.studentprofile.Back")%></strong><span class="bt_blue_r"></span></a>

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