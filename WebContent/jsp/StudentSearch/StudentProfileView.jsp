<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
ResourceBundle bundle1  =ResourceBundle.getBundle("resources.ApplicationResources");
java.util.ResourceBundle rb=java.util.ResourceBundle.getBundle("resources.serversetup");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle1.getString("label.studentsearch.profiletitle") %> | Powered by i-Grandee</title>
<LINK rel=stylesheet href="<%=request.getContextPath()%>/css/kyccss.css">

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script language='javascript'>

function backfun()
{

document.f1.action= "HomePage.jsp";
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

<h2><%=bundle1.getString("label.studentsearch.profilerootpath") %></h2>
<form name="f1" method="post" action=""><%@ page
	import="java.util.*"%> <%
 %> <%@ page import="com.iGrandee.StudentSearch.StudentSearchEntry,com.iGrandee.Registration.StudentRegistrationQuery"%>

<%
	String date_str = "";
	ArrayList deptList = null;
	StudentSearchEntry studentquery = new StudentSearchEntry(); 
	String personid = null;
	String rollnumber = "";
	 rollnumber=request.getParameter("rollnumber");
		StudentRegistrationQuery studentquery1 = new StudentRegistrationQuery();
		try {
													  
			String approvalid = session.getValue("studentid")+"";
			//out.print("session.getValue(instituteid)-->"+session.getValue("instituteid"));
			personid=studentquery.getpersonidvisepersonid(rollnumber,(String)session.getValue("instituteid")+"");
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
 		String mobilenumber = "-";

 		



 		ArrayList person_list = studentquery.Studentpersondetails(personid);
 		ArrayList contact_list = studentquery.Studentcontactdetails(personid);
 		ArrayList guardian_list = studentquery.Studentguardiandetails(personid);
 		ArrayList register_list = studentquery.Studentregisterdetails(personid);
 		ArrayList qualification_list = studentquery.Studentqualificationdetails(personid);
 		ArrayList account_list = studentquery.Studentaccountdetails(personid);
 		HashMap map = null;
 		String sectionname1 = "-";
 		String standardname1 = "-";
 		String sessionname1 = "-";
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
 	 		landline = (String) map.get("landlinenumber")+"";
 	 		mobilenumber =(String) map.get("mobilenumber");

 			if (landline == null || landline.equals("null")  || landline.equals("") )
 				landline = "-";
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
 			if (account_list != null && account_list.size() > 0) {
 			map = (HashMap) account_list.get(0);
 			username = (String) map	.get("username");
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
 			
 			HashMap stdmap = null;
 			HashMap secmap = null;

 			ArrayList Studentpersonminidetails=new ArrayList();
 			ArrayList sectionarry=new ArrayList();
 			ArrayList standardarray=new ArrayList();
 			
 			String sectionid="";
 			String standardid="";
 			String sectionname="";
 			String standardname="";
 			String standardscheduleid="";
 			String sessionname="";
 			String groupname = null;
 			 Studentpersonminidetails = studentquery.Studentpersonminidetails(rollnumber,(String)session.getValue("sessionid"));
 			 if (Studentpersonminidetails != null && Studentpersonminidetails.size() > 0) {
 					
 				map = (HashMap) Studentpersonminidetails.get(0);
 				name = (String) map.get("uname");
 				standardid = (String) map.get("standardid");
 				sectionid = (String) map.get("sectionid");
 				
 				standardname = (String) map.get("standardname");
 				sectionname = (String) map.get("sectionname");
 				standardscheduleid = (String) map.get("standardscheduleid");
 				sessionname = (String) map.get("sessionname");
 				groupname = (String) map.get("groupname");
 				if(groupname==null)
 					groupname = "";
 				else
 					groupname = " - "+groupname;
 			 } 
 			

 		
 %>
<form name="f1" method="post" action="">
<input type="hidden" name="rollnumber" value="<%=rollnumber %>">

<TABLE border=0 class="tablecolor" cellspacing=0 width=100% align=center
	height="100%" cellpadding=0>
	<tr><td>
<TABLE border=0 class="tablecolor" cellspacing=0 width=100% align=center
	height="100%" cellpadding=0>
	
	
	
	<br>
	<tr>
	  
		<td valign='top'>
				<table border=0 id="rounded-corner" width="80%">

			<thead>
				<tr>
					<th scope="col" class="rounded-company" colspan=2 width="25%"><%=bundle1.getString("label.studentsearch.hometableheading") %></th>
					<th scope="col" class="rounded" width="1%"></th>
					<th scope="col" class="rounded" width="23%"></th>
					<th scope="col" class="rounded" width="25%"></th>
					<th scope="col" class="rounded" width="1%"></th>
					<th scope="col" class="rounded-q4" width="25%"></th>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan=6 class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
				</tfoot>
				<tr>
					<td></td><td class="tablebold" width="20%"><%=bundle1.getString("label.studentsearch.rollno") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"><%=rollnumber%></td>
					<td class="tablebold" width="20%"><%=bundle1.getString("label.studentsearch.studentname") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"><%=name%></td>
				</tr>
				<tr>
					<td></td><td class="tablebold" width="20%"><%=bundle1.getString("label.studentsearch.academicyear") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"><%=sessionname%></td>
					<td class="tablebold" width="20%"><%=bundle1.getString("label.studentsearch.standard") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"><%=standardname%><%=groupname %></td>
				</tr>
				<tr>
					
					<td></td><td class="tablebold" width="20%"><%=bundle1.getString("label.studentsearch.section") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" colspan=4 width="20%"><%=sectionname%></td>
				</tr>
				
			</thead>
		</table>
		</td>
	</tr>
	</table>
	
<br>
	<TR >
		<td  valign="top">
		<table  id="rounded-corner" border=0 cellspacing=0 cellpadding=0 width="100%">
<thead>
			<tr>
							<th scope="col" class="rounded-company" width="90%">
							<%=bundle1.getString("label.studentprofile.PersonalDetails")%>
							</th>
							<th scope="col" class="rounded-q4" width="10%" ></th>
				</tr>
				</thead>

		<tr>
		<td colspan=2>
			<table border=0 cellspacing=0 cellpadding=0 width="100%">
			<tr>
				<td class=tablebold><%=bundle1.getString("label.studentprofile.Name")%></td><td><%=name%></td><td rowspan=5><img
						src="<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2=<%=photo%>"
						name='stphoto_img1' id=stphoto_img width=120 height=130></td>
			</tr>
			<tr>
							<td class=tablebold><%=bundle1.getString("label.studentprofile.dateofbirth")%></td><td><%=dob%></td>
			</tr>
			<tr>
							<td class=tablebold><%=bundle1.getString("label.studentprofile.Age")%></td><td><%=age%>&nbsp;<%=bundle1.getString("label.studentprofile.Years")%></td>
			</tr>
			<tr>
										<td class=tablebold><%=bundle1.getString("label.studentprofile.Sex")%></td><td><%=sex%></td>
			</tr>
			<tr>
										<td class=tablebold><%=bundle1.getString("label.studentprofile.FatherName")%></td><td><%=fname%></td>
			</tr>


		<tr>
			<td class=tablebold>
				<%=bundle1.getString("label.studentprofile.MotherName")%>
			</td>
			<td colspan=2><%=mname%></td>
		</tr>


		<tr>
			<td class=tablebold>
				<%=bundle1.getString("label.studentprofile.Nationality")%>
			</td>
			<td colspan=2>
				<%=nationality%>
			</td>
		</tr>

<% if(rb.getString("communityflag").equals("yes")){ %>
		<tr>
			<td class=tablebold>
				<%=bundle1.getString("label.studentprofile.Community")%>
			</td>
			<td colspan=2>
				<%=community%>
			</td>
		</tr>

<%} %>
<% if(rb.getString("religionflag").equals("yes")){ %>
		<tr>
			<td class=tablebold>
				<%=bundle1.getString("label.studentprofile.Religion")%>
			</td>
			<td colspan=2>
				<%=religion%>
			</td>
		</tr>
<%} %>
		<tr>
			<td class=tablebold>
				<%=bundle1.getString("label.studentprofile.Language")%>
			</td>
			<td colspan=2>
				<%=language%>
			</td>
		</tr>


		<tr>
			<td class=tablebold>
				<%=bundle1.getString("label.studentprofile.Bloodgroup")%>
			</td>
			<td colspan=2>
				<%=bloodgroup%>
			</td>
</tr>


			</table>
		</td></tr>
	</table>

			<br>
			</td>
	</tr>
	<tr>
	<td  valign="top">
		<table border=0 id="rounded-corner" width="80%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company"   width="100%" colspan=5><%=bundle1.getString("label.studentsearch.ContactDetails") %></th>
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
					
					<tr height=25>
					<td></td>
						<td align=left colspan=4 class="tablebold"><%=bundle1.getString("label.studentsearch.CommunicationAddress") %></td>
					<td></td></tr>
					<tr height=25><td></td>
						<td align=left class="tablebold" width="22%"><%=bundle1.getString("label.studentsearch.Street") %></td>
						<td align=left colspan=3  width="78%"><%=communicationstreet1%></td>
					<td></td></tr>

					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%"><%=bundle1.getString("label.studentsearch.City") %>
						</td>
						<td class="tablelight" style="width: 35%"><%=communicationcity%>
						</td>
						<td class="tablebold" style="width: 15%"><%=bundle1.getString("label.studentsearch.State") %>
						</td>
						<td class="tablelight" style="width: 35%"><%=communicationstate%>
						</td><td></td>
					</tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%"><%=bundle1.getString("label.studentsearch.Country") %>
						</td>
						<td class="tablelight" style="width: 35%"><%=communicationcountry%>
						</td>
						<td class="tablebold" style="width: 15%"><%=bundle1.getString("label.studentsearch.Pin") %>
						</td>
						<td class="tablelight" style="width: 35%"><%=communicationpin%>
						</td><td></td>
					</tr>
					<tr height=25><td></td>
						<td align=left colspan=4 class="tablebold"><%=bundle1.getString("label.studentsearch.PermanentAddress") %></td>
					<td></td></tr>

					<tr height=25><td></td>
						<td align=left class="tablebold"><%=bundle1.getString("label.studentsearch.Street") %></td>
						<td align=left colspan=3><%=permanentstreet1%></td><td></td>
					</tr>

					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%"><%=bundle1.getString("label.studentsearch.City") %>
						</td>
						<td class="tablelight" style="width: 35%"><%=permanentcity%>
						</td>
						<td class="tablebold" style="width: 15%"><%=bundle1.getString("label.studentsearch.State") %>
						</td>
						<td class="tablelight" style="width: 35%"><%=permanentstate%>
						</td><td></td>
					</tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%"><%=bundle1.getString("label.studentsearch.Country") %>
						</td>
						<td class="tablelight" style="width: 35%"><%=permanentcountry%>
						</td>
						<td class="tablebold" style="width: 15%"><%=bundle1.getString("label.studentsearch.Pin") %>
						</td>
						<td class="tablelight" style="width: 35%"><%=permanentpin%> 
						</td><td></td>
					</tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%"><%=bundle1.getString("label.studentsearch.LandLineNo") %>
						</td>
						<td class="tablelight" style="width: 35%" colspan=3><%=landline%></td>
					<td></td></tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%"><%=bundle1.getString("label.studentsearch.smscontactno") %>
						</td>
						<td class="tablelight" style="width: 35%" colspan=3><%=smscontact%></td>
					<td></td></tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%" ><%=bundle1.getString("label.studentprofile.MobileNo.")%>
						</td>
						<td class="tablelight" style="width: 35%" colspan=4><%=mobilenumber%></td>
					</tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%" ><%=bundle1.getString("label.studentsearch.MailId") %>
						</td>
						<td class="tablelight" style="width: 35%" colspan=3><a href="mailto:<%=email%>"><%=email%></a></td>
							<td></td></tr>
				</tbody>
			</table>
			<br>
		</td>
	</tr>
	<tr>
	<td  valign="top">
		<table border=0 id="rounded-corner" width="80%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="100%" colspan=3><%=bundle1.getString("label.studentsearch.Parent/GuardianDetails") %></th>
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
						<td align=left class="tablebold"><%=bundle1.getString("label.studentsearch.Parent/GuardianName") %></td>
						<td align=left ><%=guardianname%></td>
					<td></td></tr>
					<tr height=25>
						<td></td>
						<td align=left class="tablebold"><%=bundle1.getString("label.studentsearch.Parent/GuardianMail") %></td>
						<td align=left ><a href="mailto:<%=guardianmailid%>"><%=guardianmailid%></a></td>
					<td></td></tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 25%"><%=bundle1.getString("label.studentsearch.Parent/GuardianRelation") %>
						</td>
						<td class="tablelight" style="width: 75%"><%=relation%>
						</td>
						<td></td>
					</tr>
					<tr height=25><td></td>
						<td align=left class="tablebold"><%=bundle1.getString("label.studentsearch.Parent/GuardianSelfEmployed") %></td>
						<td align=left ><%=self%></td>
						<td></td>
					</tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%"><%=bundle1.getString("label.studentsearch.NameOforgnization") %>
						</td>
						<td class="tablelight" style="width: 35%"><%=nameoforganization%>
						</td><td></td>
					</tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%"><%=bundle1.getString("label.studentsearch.AnnualincomeRs") %>
						</td>
						<td class="tablelight" style="width: 35%"><%=annualincome%>
						</td><td></td>
					</tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%"><%=bundle1.getString("label.studentsearch.Position") %>
						</td>
						<td class="tablelight" style="width: 35%" ><%=position%></td>
						<td></td>
					</tr>
				</tbody>
			</table>
			<br>
		</td>
	</tr>
	<tr>
	<td  valign="top">
	
		<table border=0 id="rounded-corner" width="80%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company"  width="100%" colspan=3>Additional Information</th>
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
					<tr height=25><td></td>
						<td align=left class="tablebold"><%=bundle1.getString("label.studentsearch.PhysicallyChallenged") %></td>
						<td align=left ><%=physicallyfit%></td><td></td>
					</tr>
				<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 25%"><%=bundle1.getString("label.studentsearch.ChildofEx-Serviceman") %> 
						</td>
						<td class="tablelight" style="width: 75%"><%=exserviceman%>
						</td><td></td>
						
					</tr>
										<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%"><%=bundle1.getString("label.studentsearch.Personalphysicalmarks") %>
						</td>
						<td class="tablelight" style="width: 35%"><%=physicalmark%>
						</td><td></td>
					</tr>
					
				</tbody>
			</table>
			<br>
		</td>
	</tr>
	<tr>
	<td>
	<br>  
		<table border=0 id="rounded-corner" width="100%" align=left>
			<thead>
				<tr>
					<th scope="col" class="rounded-company">Scholarship Details</th>
					<th scope="col" class="rounded"  width="100%" ></th>
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
				<td width="100%" colspan=3 align=left>
				
					<table width="100%" border="0">
							<tr class=tableheading><td>SL. No.</td><td>Term Name</td><td>Scholarship Name</td><td>Amount</td></tr>
					
					<%
					ArrayList scholarshipList 	= studentquery1.loadScholarshipDetails(personid, standardscheduleid);
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
		<table border=0 id="rounded-corner" width="100%" align=left>
			<thead>
				<tr>
					<th scope="col" class="rounded-company"   width="100%" colspan=2><%=bundle1.getString("label.studentprofile.ExtraCurricularactivities")%></th>
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
	</tr>
		<tr>
	<td  >
	<br>  
		<table border=0 id="rounded-corner" width="80%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company"   width="100%"  colspan=3><%=bundle1.getString("label.studentsearch.PreviousSchoolDetails") %></th>
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
						<td align=left class="tablebold"><%=bundle1.getString("label.studentsearch.NameoftheSchool") %></td>
						<td align=left><%=previousschoolname%></td>
					<td></td></tr>

					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 25%"><%=bundle1.getString("label.studentsearch.AddressoftheSchool") %>
						</td>
						<td class="tablelight" style="width: 75%"><%=previousschooladdress%>
						</td><td></td>
					</tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%"><%=bundle1.getString("label.studentsearch.MediumofInstruction") %>
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
	<td  valign="top">
		<table border=0 id="rounded-corner" width="80%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company"  width="100%" colspan=6><%=bundle1.getString("label.studentsearch.ExaminationDetails") %></th>
					<th scope="col" class="rounded-q4" width="10"></th>

				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan=6 class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody>
					<tr bgcolor="#EEEEEE">
						<td></td>
						<td class="headerfont" width="20%" align="left" class="tablebold"><%=bundle1.getString("label.studentsearch.Subjects") %></td>
						<td class="headerfont" width="20%" class="tablebold"><%=bundle1.getString("label.studentsearch.Month-Year") %> </td>
						<td class="headerfont" width="20%" class="tablebold"><%=bundle1.getString("label.studentsearch.RegistrationNo") %></td>
						<td class="headerfont" width="20%" class="tablebold"><%=bundle1.getString("label.studentsearch.MarksScored") %></td>
						<td class="headerfont" width="20%" class="tablebold"><%=bundle1.getString("label.studentsearch.MaxMarks") %></td>
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
					 			out.println("<tr>");
					 			out.println("<td></td><td>"+subject+"</td>");
					 			out.println("<td>"+monthandyear+"</td>");
					 			out.println("<td>"+registrationno+"</td>");
					 			out.println("<td>"+marksscored+"</td>");
					 			out.println("<td>"+maxmarks+"</td><td></td>");

					 			out.println("</tr>");							}
			 			}
					%>
				</tbody>
			</table>
			<br>
		</td>
	</tr>
	<tr>
	<td  valign="top">
		<table border=0 id="rounded-corner" width="80%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company"   width="100%" colspan=3><%=bundle1.getString("label.studentsearch.VerificationofCertificates") %></th>
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
					<tr height=25><td></td>
						<td align=left class="tablebold"><%=bundle1.getString("label.studentsearch.T.C") %></td>
						<td align=left ><%=tc%></td><td></td>
					</tr>

					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 25%"><%=bundle1.getString("label.studentsearch.C.C") %>
						</td>
						<td class="tablelight" style="width: 75%"><%=cc%>
						</td><td></td>
					</tr>
					<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%"><%=bundle1.getString("label.studentsearch.Spl.Category") %>
						</td>
						<td class="tablelight" style="width: 35%"><%=splcategory%>
						</td><td></td>
						</tr>
						<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%"><%=bundle1.getString("label.studentsearch.MedicalCertificate") %>
						</td>
						<td class="tablelight" style="width: 35%"><%=medicalcertificate%>
						</td><td></td>
						</tr>
						<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%"><%=bundle1.getString("label.studentsearch.MarkSheet") %>
						</td>
						<td class="tablelight" style="width: 35%"><%=marksheet%>
						</td><td></td>
						</tr>
						<tr style="height: 20"><td></td>
						<td class="tablebold" style="width: 15%"><%=bundle1.getString("label.studentsearch.SportsCertificate") %>
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
				<td width="100%" colspan=4 align=center><%=bundle1.getString("label.studentsearch.PreviousSchoolDetailsNotYetEntered") %></td>
			</tr>
			</tbody>
			</table>
			<%} %>
		</td>
	</tr>
	
	</table>
		  <a href="#" onclick="backfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle1.getString("button.studentsearch.back") %></strong><span class="bt_blue_r"></span></a>

	
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