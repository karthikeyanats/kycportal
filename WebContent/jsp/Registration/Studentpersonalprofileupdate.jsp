<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Profile Update | Powered by i-Grandee</title>


<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/Validation.js"></script>

	<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
	<SCRIPT language="JavaScript" src='<%=request.getContextPath()%>/js/Calendar/Calendar.js'></SCRIPT>
	
<script type="text/javascript">
function backfun()
{
document.mainform.action="./Studentprofileview.jsp";
document.mainform.submit();
}
function getExtension(file_value)
{
	if(file_value.lastIndexOf(".") != -1)
	{
		var ext_of_file = file_value.substring(file_value.lastIndexOf(".")+1);
		return ext_of_file.toLowerCase();
	}
	else
	{
		return 0;
	}
}
function Submitfun()
{
//if(check_ForParticularElements(document.applicationform.studentname,"text",document.applicationform.lastname,"text",document.applicationform.dateofbirth,"text",document.applicationform.age,"text",document.applicationform.fathername,"text",document.applicationform.mothername,"text",document.applicationform.nationality,"text"))
//if(check_ForParticularElements(document.applicationform.studentname,"text",document.applicationform.lastname,"text",document.applicationform.dateofbirth,"text",document.applicationform.age,"text",document.applicationform.fathername,"text",document.applicationform.nationality,"radio",document.applicationform.community,"radio",document.applicationform.religion,"radio",document.applicationform.mothertonque,"radio"))	
	if(check_ForParticularElements(document.applicationform.studentname,"text",document.applicationform.lastname,"text",document.applicationform.dateofbirth,"text",document.applicationform.age,"text",document.applicationform.fathername,"text",document.applicationform.community,"radio",document.applicationform.religion,"radio"))
{
	if( document.applicationform.fathername.value.charAt(0)==" ")
				 {
				 	alert("Father Name should not start with Empty Character");
				    document.applicationform.fathername.focus();
					return false;
				 }
				 if(!stringValidateincludesigquots(document.applicationform.fathername,"Father Name"))
				 {
					
					document.applicationform.fathername.focus();
					return false;
				 }
				 
				 if(!stringValidateincludesigquots(document.applicationform.mothername,"Mother Name"))
				 {
					  
					document.applicationform.mothername.focus();
					return false;
				 }
				 if(document.applicationform.photo.value!="")
					{
					
							var pho_val=getExtension(document.applicationform.photo.value);
							pho_val = pho_val.toLowerCase();
							if((pho_val != "jpg") & (pho_val != "gif") & (pho_val != "jpeg") & (pho_val != "png"))
							{
							alert("*.jpeg,*.jpg,*.gif,*.png,*.bmp Image type only allowed")
							document.applicationform.user_photo.select();
							return false;
							}
					}
if(confirm("Do You Want to Update the Student Personal Profile...?"))
{

if(document.applicationform.photo.value!="")
{
	document.applicationform.studuserphoto.value=document.applicationform.photo.value;
}

document.applicationform.action="./Studentpersonalprofilesubmit.jsp";
document.applicationform.submit();
}
}
}
var is_ie 		= (/msie/i.test(navigator.userAgent));
function calcAge(args)
{
	var ages = 0;
		var birthDate = new Date(args);
		var currentDate = new Date();
		var birthYear = "0";
		if(2000<=birthDate.getYear())
		{
		   birthYear = birthDate.getYear();
		}
		else
		if(is_ie)
		{
		   birthYear = birthDate.getYear()+1900;
	   }
	   else
	   {
		   birthYear = birthDate.getYear();
	   }

		var currentYear = currentDate.getYear();
		ages = currentYear -  birthYear;
		var birthMonth = birthDate.getMonth()+1;
		var currentMonth = currentDate.getMonth()+1;
		if(currentMonth<birthMonth)
			ages = ages - 1;

	return ages;
}
function calcagefunstudent()
{
var dob=document.applicationform.dateofbirth.value.split("-");
mon="Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec";
mon=mon.split(",");
for(var i=0;i<mon.length;i++)
{
if(dob[1]==mon[i])
{
var age=calcAge(i+1+"/"+dob[0]+"/"+dob[2]);
document.applicationform.age.value=age;
document.getElementById("displayage").innerHTML=age;
}
}
}
function loadphototype(type)
{
	if(type=="local")
	{
		document.getElementById('webcamspan').style.display='none';
		document.getElementById('localphoto').style.display='';
		document.applicationform.photo.disabled=false;

	}
	else
	{
		document.getElementById('webcamspan').style.display='';
		document.getElementById('localphoto').style.display='none';
		document.applicationform.photo.disabled=true;

	}
}
</script>
</head>
<body >
<div id="main_container">
<div class="header"><%@ include file="../include/userheader.jsp"%>

</div>

<div class="main_content"><%@ include file="../include/header.jsp"%>


<div class="center_content">



<div class="left_content"></div>

<div class="right_content">
<%-- 
<h2><%=bundle.getString("label.studentpersonalprofileupdate.rootpath")%></h2> --%>
<table width=100%><tr><td width=80% align=left><h2><%=bundle.getString("label.studentpersonalprofileupdate.rootpath")%></h2></td><td align=right><a class=tablebold><font color=red>*</font>&nbsp;<font color=#000000><%=bundle.getString("label.studentprofileentry.Mandatory")%></font> </a></td></tr></table>
<jsp:useBean id="datebeans" scope="page" class="com.iGrandee.Common.DateTime"/>

<%@ page
	import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Registration.StudentRegistrationQuery"%>

<%
	String date_str = "";
	StudentRegistrationQuery studentquery = new StudentRegistrationQuery(); 	
	String firstname = "-";
	String middlename = "-";
	String lastname = "-";

	String fname = "-";
	String mname = "-";
	String age = "-";
	String sex = "-";

	String dateofbirth = "-";
	String photo = "-";
	String mail_id = "-";
	String landline = "-";
	String email = "-";
	String nationality = "-";
	String community = "-";
	String religion = "-";
	String language = "-";
	String bloodgroup = "-";
	
	String userid = "-";
	String username = "-";
	String studentapprovalid= "-";
	userid = request.getParameter("personid");
	username =  request.getParameter("usernameforcheck");
	String instituteid = null;
	String prefix1 = "-";
	String religion_id = null;
	String community_id = null;
	studentapprovalid =  request.getParameter("stundentapproveid");

	
	try {
		 date_str = datebeans.showTime("calendar");

		instituteid = (String) session.getValue("instituteid");
 		ArrayList person_list = studentquery.Studentpersondetails(userid);
		HashMap map = null;
 		
 		if (person_list != null && person_list.size() > 0) {
 			
 			
 			map = (HashMap) person_list.get(0);
 			firstname = (String) map.get("firstname");
 			
 			middlename = (String) map.get("middlename");
 			if (middlename == null)
 				middlename = "-";
 			lastname = (String) map.get("lastname");

 			fname = (String) map.get("fathername");
 			if (fname == null)
 				fname = "-";
 			mname = (String) map.get("mothername");
 			if (mname == null)
 				mname = "-";
 			age = (String) map.get("age");
 			sex = (String) map.get("sex");
 			dateofbirth = (String) map.get("dob");
 			/*if(dob!=null)
 			{
 				String[] str_dob=dob.split("-");
 				dob=str_dob[1]+"-"+str_dob[0]+"-"+str_dob[2];
 			}*/

 			//out.println(gender);

 			landline = (String) map.get("landlinenumber");
 			if (landline == null)
 				landline = "-";
 			photo = (String) map.get("imagepath");
 			//System.out.println("================photo====>" + photo);
 			email = (String) map.get("emailid");
 			 nationality =(String) map.get("nationality");
 	 		 community = (String) map.get("community");
 	 		 religion = (String) map.get("religion");
 	 		community_id = (String) map.get("communityid");
 	 		religion_id = (String) map.get("religionid");
 	 		 language = (String) map.get("language");
 	 		 bloodgroup =(String) map.get("bloodgroup");
  			prefix1= (String) map.get("prefix");

 		}

	} catch (Exception e) {
	}
	java.util.ResourceBundle rb=java.util.ResourceBundle.getBundle("resources.serversetup");
	String shapshotpath=rb.getString("shapshot");
	
//	out.println("shapshotpath********* "+shapshotpath);
	
	String imagePath=rb.getString("storagepath")+"/imagestorage/";
	

	String imageName="studentimage_"+studentapprovalid+".jpg";
	

%>

	<form name="applicationform" method="post" action=""
		enctype="multipart/form-data"><%@ page
		import="java.io.*,java.util.*"%> <%
 	StringBuffer currentDate = new StringBuffer();
 	Date dateObj = new Date();
 	currentDate.append((dateObj.getMonth() + 1) + "/"	+ dateObj.getDate() + "/" + (dateObj.getYear() + 1900));
 	StudentRegistrationQuery Staffquery = new StudentRegistrationQuery();
 	ArrayList communityList = Staffquery.loadcommunity(instituteid);
 	ArrayList religionList = Staffquery.loadreligion(instituteid);
	
	// out.println("detaillist=========>>>>>"+detaillist);
 %> <input type="hidden" name="currentDate" value="<%=currentDate%>">
<input type="hidden" name="personid" value="<%=userid%>">
<input type="hidden" name="studusernamehidden" value="<%=username%>">
<input type="hidden" name="studuserphoto" value="<%=photo%>">
<input type="hidden" name="studentprofileedit" value="<%=request.getParameter("studentprofileedit")%>">
<input type=hidden   name=session value="<%=request.getParameter("session")%>">
<input type=hidden   name=board value="<%=request.getParameter("board")%>">
<input type=hidden   name=standardscheduleid value="<%=request.getParameter("standardscheduleid")%>">
<input type=hidden   name=sectionscheduleid value="<%=request.getParameter("sectionscheduleid")%>">
<input type="hidden" name="req_sessionname" value="<%=request.getParameter("req_sessionname")%>">
<input type="hidden" name="req_sessionstatus" value="<%=request.getParameter("req_sessionstatus")%>">
<input type="hidden" name="req_boardname" value="<%=request.getParameter("req_boardname")%>">
<input type="hidden" name="req_standardnamegp" value="<%=request.getParameter("req_standardnamegp")%>">
<input type="hidden" name="req_sectionname" value="<%=request.getParameter("req_sectionname")%>">
<input type="hidden" name="req_studentname" value="<%=request.getParameter("req_studentname")%>">
<input type="hidden" name="stundentapproveid" value="<%=studentapprovalid%>"> 
<input type=hidden name=server_date value="<%= date_str %>">

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
						<td class="tablelight" ><%= request.getParameter("req_sessionname")%>
						</td>
						<td class="tablebold" ><%=bundle.getString("label.studentprofile.Standard")%>
						</td>
						<td class="tablebold">:</td>
						<td class="tablelight" ><%=request.getParameter("req_standardnamegp")%>
						</td>
						</tr>
						<tr style="height: 20">
						<td class="tablebold" ><%=bundle.getString("label.studentprofile.Board")%>
						</td>
						<td class="tablebold">:</td>
						<td class="tablelight" ><%=request.getParameter("req_boardname")%>
						</td>
						<td class="tablebold" ><%=bundle.getString("label.studentprofile.Section")%>
						</td>
						<td class="tablebold">:</td>
						<td class="tablelight" ><%=request.getParameter("req_sessionname")%>
						</td>
						</tr>
						<tr>
							<td class="tablebold" ><%=bundle.getString("label.studentprofile.Name")%>
						</td>
						<td class="tablebold">:</td>
						<td class="tablelight" ><%=request.getParameter("req_studentname")%>
						</td>
						
						</tr>
						</table></td></tr>
				</tbody>
			</table><br></br>
 	<table id="rounded-corner" border=0	width="100%">
		<thead>
			<tr>
		
				<th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.studentpersonalprofileupdate.StudentProfileUpdate")%></th>
				<th scope="col" class="rounded-q4" width="10%"></th>
			</tr>
		</thead>
		<tfoot>
			<tr>
				<td class="rounded-foot-left"><em></em></td>
				<td class="rounded-foot-right">&nbsp;</td>
			</tr>
		</tfoot>
		<tbody >
			
			<tr>
				<td colspan=2 align=center><br>
				<table border="0" width="100%" cellpadding="5" cellspacing="0">
					<tr align="left">
						<td class=tablebold width="30%"><%=bundle.getString("label.studentpersonalprofileupdate.Prefix")%></td>
						<td align="left" colspan=2><select name="slt_prefix"  maxlength=6  class=tablelight validate="prefix">
										 <option value="Mr.">Mr.</option>
										 <option value="Mrs.">Mrs.</option>
										 <option value="Ms.">Ms.</option>
										 <option value="Dr.">Dr.</option>
										 <option value="Sir.">Sir.</option>
									 </select><input type=hidden  name="hiddenprefix"	value="<%=prefix1%>">
						<script>
							for(var i=0;i<document.applicationform.slt_prefix.length;i++)
							{
							if(document.applicationform.slt_prefix[i].value==document.applicationform.hiddenprefix.value)
							document.applicationform.slt_prefix[i].selected=true;
							}
							</script> 
									 </td>
									 </tr>
					<tr align="left">
						<td class=tablebold width="30%"><%=bundle.getString("label.studentpersonalprofileupdate.FirstName")%>&nbsp;<font
							color=red>*</font></td>
						<td align="left"><input type=text class=tablelight
							name="studentname" validate="Student First Name" value="<%=firstname %>"></td>
							<td rowspan="3"><img
						src="<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2=<%=photo%>"
						name='stphoto_img1' id=stphoto_img width=120 height=130></td>
					</tr>
					<tr align="left">
						<td width="30%" class=tablebold><%=bundle.getString("label.studentpersonalprofileupdate.MiddleName")%>&nbsp;</td>
						<td align="left" width="55%"><input type="text"
							class="labeltextbox" class="labelfont" name="middlername"
							maxlength="40" size="30"
							value="<%=middlename %>"></td>
						</tr>
					<tr align="left" class=tablebold>
						<td width="30%"><%=bundle.getString("label.studentpersonalprofileupdate.LastName")%>&nbsp;<font
							color=red>*</font></td>
						<td align="left" width="55%"><input type="text"
							class="labeltextbox" class="labelfont" validate="Student Last Name" name="lastname"
							maxlength="40" size="30"
							value="<%=lastname %>"></td>
						
					</tr>
					

					<tr align="left">
					<td colspan=2>
					<input type="radio" name="phototype" value='local' onclick="loadphototype('local')" checked=true /><%=bundle.getString("label.studentprofileentry.UploadImage")%><input type="radio" name="phototype" value='snapshot' onclick="loadphototype('webcam')"/><%=bundle.getString("label.studentprofileentry.CaptureImage")%>
					</td>
					</tr>
					<tr align="left">
					<td colspan=2>
					<table border='0' bordercolor='yellow' id="localphoto" style="display:block;" >  
						<tr>  
						<td width="39%" align="left" class=tablebold><%=bundle.getString("label.studentpersonalprofileupdate.Photo")%>&nbsp;</td>
						<td align="left" valign="bottom" width="61%"><input size='30' type=file class="browses" name="photo"	></td>
					</tr>
					</table>
					</td>
					</tr>
					<tr>
					<td colspan=2>
					
					<table border='0' bordercolor='yellow' id="webcamspan" style="display: none" >  
									<tr>      
										<td>  
										<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
												id="Snapshot"  width="320" height="180"
												codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
												<param name="movie" value="<%=shapshotpath %>/Snapshot.swf" />
												<param name="quality" value="high" />   
												<param name="bgcolor" value="#869ca7" />
												<param name="allowScriptAccess" value="sameDomain" />  
												<param name="FlashVars" value="imagePath=<%=imagePath%>&imageName=<%=imageName%>" />
												<embed src="<%=shapshotpath %>/Snapshot.swf" FlashVars="imagePath=<%=imagePath%>&imageName=<%=imageName%>" quality="high" bgcolor="#869ca7"
													name="Snapshot" align="middle" width="320" height="180"
													play="true"
													loop="false"
													quality="high"
													allowScriptAccess="sameDomain"
													type="application/x-shockwave-flash"
													pluginspage="http://www.adobe.com/go/getflashplayer">
												</embed>
										</object>
										</td>
									</tr>
								</table>		
					</td>
					</tr>
					<tr align="left" class=tablebold>
						<td class=tablebold width="29%">
						<%=bundle.getString("label.studentpersonalprofileupdate.DateofBirth")%>&nbsp;<font
							color=red>*</font>			</td>	<td  align=left>
					<input type=text name="dateofbirth"		class=tablelight value="<%=dateofbirth%>" maxlength=50 size=20	validate="Date of Birth" onkeydown='this.blur()'>
					<input	type="button" class="tablehead" value="^" onclick="Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','applicationform.dateofbirth','1001',event,'Not_Greater_Than_CurrentDate',document.applicationform.server_date);"></td>
					</tr>
					<tr align="left">
						<td class=tablebold width="29%"><%=bundle.getString("label.studentpersonalprofileupdate.Age")%>&nbsp;<font
							color=red>*</font></td>
						<td  width="71%"><input readonly type="text"
							name="age" value="<%=age %>" size=5></td>

					</tr>
					<tr align="left">
						<td class=tablebold width="29%"><%=bundle.getString("label.studentpersonalprofileupdate.Gender")%></td>
						<td  width="71%"><input type="radio"
							name="studsex" value="Male" idx="M" checked>Male<input type="radio"
							name="studsex" value="Female"  idx="F">Female
							<input type=hidden  name="hiddensetextx"	value="<%=sex%>">
						<script>
							for(var i=0;i<document.applicationform.studsex.length;i++)
							{
								//alert(document.applicationform.studsex[i].getAttribute("idx")+"=="+document.applicationform.hiddensex.value)
							//if(document.applicationform.studsex[i].value==document.applicationform.hiddensex.value)
								
							if(document.applicationform.studsex[i].getAttribute("idx")==document.applicationform.hiddensex.value)
							document.applicationform.studsex[i].checked=true;
							}
							</script></td>

					</tr>
					<tr align="left" class=tablebold>
						<td width="29%"><%=bundle.getString("label.studentpersonalprofileupdate.FatherName")%>&nbsp;<font color=red>*</font></td>
						<td align="left" width="55%"><input type="text"
							class="labeltextbox" class="labelfont" name="fathername"
							maxlength="40" size="30"
							value="<%=fname %>"></td>
					</tr>
					<tr align="left" class=tablebold>
						<td width="29%"><%=bundle.getString("label.studentpersonalprofileupdate.MotherName")%>&nbsp;</td>
						<td align="left" width="55%"><input type="text"	class="labeltextbox" class="labelfont" name="mothername" maxlength="40" size="30"		value="<%=mname %>"></td>
					</tr>
					
					<tr align="left">
						<td class=tablebold width="29%"><%=bundle.getString("label.studentpersonalprofileupdate.Nationality")%>&nbsp;<font color=red>*</font></td>
						<td class="headerfont" width="71%"><input type="text"
							name="nationality" value="<%=nationality %>" size=30></td>

					</tr>
					<% if(rb.getString("communityflag").equals("yes")){ %>
					
				
					<tr align=left>
						<td  width="28%" class=tablebold><%=bundle.getString("label.studentpersonalprofileupdate.Community")%>&nbsp;<font color=red>*</font></td><td align='left' width='70%'>
						<%
							System.out.println(communityList);
							for (int i = 0; communityList != null && i < communityList.size(); i++) {
								HashMap communityMap = (HashMap) communityList.get(i);
								String communityName = null;
								String communityid = null;

								
								if (communityMap.get("communityname") != null) {
									communityid = (String) communityMap.get("communityid");
									communityName = (String) communityMap.get("communityname");
									//if (i == 0) {
										//out	.println("<input type='radio' name='community' value="+ communityid+ " checked='true'>"+ communityName +"  ");
										//out.println(communityName+"========="+community);

									//} else
									//{
										out.println(" / <input type='radio' name='community' validate='Community' value="+ communityid+ " >"+ communityName+ "  ");
									//}
								}
								communityMap = null;
								communityName = null;
							}
						%>
						<input type=hidden  name="hiddencommunity"	value="<%=community_id %>">
							<script>
						//	alert(document.applicationform.hiddencommunity.value);
							for(var i=0;i<document.applicationform.community.length;i++)
							{
								//alert(document.applicationform.community[i].value+"=="+document.applicationform.hiddencommunity.value);
							if(document.applicationform.community[i].value==document.applicationform.hiddencommunity.value){
								document.applicationform.community[i].checked=true;}
							}
							</script>
						</td>
					</tr>
				<%} %>
<% if(rb.getString("religionflag").equals("yes")){ %>
					<tr align='left'>
						<td width="28%" class=tablebold><%=bundle.getString("label.studentpersonalprofileupdate.Religion")%>&nbsp;<font color=red>*</font></td>
						<td align='left' width='70%'>
								
							<%
							//out.println(communityList);
							for (int i = 0; religionList != null && i < religionList.size(); i++) {
								HashMap religionMap = (HashMap) religionList.get(i);
								String religionName = null;
								String religionid = null;
						
								if (religionMap.get("religionname") != null) {
									religionName = (String) religionMap.get("religionname");
									religionid = (String) religionMap.get("religionid");

								/*	if (i == 0) {
										out
												.println("<input type='radio' name='religion' value="
														+ religionid
														+ " checked>"
														+ religionName +"  ");
									} else*/
										out.println(" / <input type='radio' name='religion' validate='Religion' value="+ religionid+ " >"+ religionName + "  ");
								}
								religionMap = null;
								religionName = null;
							}
						%>
						<input type=hidden  name="hiddenreligion"		value="<%=religion_id %>">
						<script>
						if(document.applicationform.religion.length == undefined)
							{
								if(document.applicationform.religion.value==document.applicationform.hiddenreligion.value)
								document.applicationform.religion.checked=true;
							}
						else
							{
								for(var i=0;i<document.applicationform.religion.length;i++)
								{
								//alert(document.applicationform.hiddenreligion.value);
								if(document.applicationform.religion[i].value==document.applicationform.hiddenreligion.value)
								document.applicationform.religion[i].checked=true;
								}
							}
							</script>
						</td>
					</tr>
				<%} %>
					<tr align="left">
						<td align="left" width="29%" class=tablebold><%=bundle.getString("label.studentpersonalprofileupdate.Language")%>&nbsp;<font color=red>*</font></td>
						<td class="labelfont" width="80%"><input type="radio"
							name="mothertonque" value="Tamil" checked> Tamil
						&nbsp;&nbsp;&nbsp; <input type="radio" name="mothertonque" validate="Language"
							value="Hindi" > Hindi &nbsp;&nbsp;&nbsp; <input
							type="radio" name="mothertonque" validate="Language" value="Other"> Other
						<input type=hidden class="labeltextbox" class="labelfont"
							maxlength="30" validate="Language" name="othersmothertonque"
							onblur="address_Validation(this,this.name)">
							<input type=hidden  name="hiddenmothertonque"	value="<%=language %>">
							<script>
							for(var i=0;i<document.applicationform.mothertonque.length;i++)
							{
							if(document.applicationform.mothertonque[i].value==document.applicationform.hiddenmothertonque.value)
							document.applicationform.mothertonque[i].checked=true;
							}
							</script>
							</td>
					</tr>
				
					<tr>
						<td align="left" class=tablebold width="30%"><%=bundle.getString("label.studentpersonalprofileupdate.BloodGroup")%></td>
						<td align="left" width="70%">
							<select name="bloodgroup">
							<option value="O+">O+</option>
							<option value="A+">A+</option>
							<option value="B+">B+</option>
							<option value="AB+">AB+</option>
							<option value="AB-">AB-</option>
							<option value="A-">A-</option>
							<option value="B-">B-</option>
							<option value="O-">O-</option>
							<option value="A1B">A1B</option>
							</select>
							<input type=hidden  name="hiddenbloodgroup"	value="<%=bloodgroup %>">
							<script>
							for(var i=0;i<document.applicationform.bloodgroup.length;i++)
							{
							if(document.applicationform.bloodgroup[i].value==document.applicationform.hiddenbloodgroup.value)
							document.applicationform.bloodgroup[i].selected=true;
							}
							</script>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</tbody>
	</table>
	
	<a href="#"  onclick="backfun()" class="bt_blue"><span
		class="bt_blue_lft"></span><strong><%=bundle.getString("button.studentpersonalprofileupdate.Back")%></strong><span
		class="bt_blue_r"></span></a>
	 <a href="#" class="bt_green"
		onclick="Submitfun()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.studentpersonalprofileupdate.Submit")%></strong><span
		class="bt_green_r"></span></a></form>
</div>

</form>

<form name=mainform method="post" action="">
<input type="hidden" name="personid" value="<%=userid%>"/>
<input type="hidden" name="studentprofileedit" value="<%=request.getParameter("studentprofileedit")%>">
<input type=hidden   name=session value="<%=request.getParameter("session")%>">
<input type=hidden   name=board value="<%=request.getParameter("board")%>">
<input type=hidden   name=standardscheduleid value="<%=request.getParameter("standardscheduleid")%>">
<input type=hidden   name=sectionscheduleid value="<%=request.getParameter("sectionscheduleid")%>">
<input type="hidden" name="req_sessionname" value="<%=request.getParameter("req_sessionname")%>">
<input type="hidden" name="req_sessionstatus" value="<%=request.getParameter("req_sessionstatus")%>">
<input type="hidden" name="req_boardname" value="<%=request.getParameter("req_boardname")%>">
<input type="hidden" name="req_standardnamegp" value="<%=request.getParameter("req_standardnamegp")%>">
<input type="hidden" name="req_sectionname" value="<%=request.getParameter("req_sectionname")%>">
<input type="hidden" name="hiddensession" value="<%=request.getParameter("session")%>">
<input type="hidden" name="stundentapproveid" value="<%=studentapprovalid%>"> 
<input type="hidden" name="req_studentname" value="<%=request.getParameter("req_studentname")%>">
	</form>
<!-- end of right content--></div>
<!--end of center content -->




<div class="clear"></div>
</div>
<!--end of main content--> <%@ include file="../include/footer.jsp"%>


</div>
</body>
</html>