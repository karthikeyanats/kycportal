<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.staffprofileupdate.title") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/niceforms-default.css" />

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>

	<script language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
	<script language="JavaScript" src='<%=request.getContextPath()%>/js/Calendar/Calendar.js'></SCRIPT>
	
<script type="text/javascript">
function backfun()
{
	document.mainform.action="./StaffProviewView.jsp";
	document.mainform.submit();
}
var is_ie 		= (/msie/i.test(navigator.userAgent));
function calcAge(args)
{
	//alert(args);
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
function calcagefun()
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
	
		if(document.applicationform.photo.value!="")
					{
					
							var pho_val=getExtension(document.applicationform.photo.value);
							pho_val = pho_val.toLowerCase();
							if((pho_val != "jpg") & (pho_val != "gif") & (pho_val != "jpeg") & (pho_val != "png"))
							{
							alert("*.jpeg,*.jpg,*.gif,*.png Image type only allowed")
							document.applicationform.user_photo.select();
							return false;
							}
					}
			if(check_ForParticularElements(document.applicationform.studentname,"text",document.applicationform.lastname,"text",document.applicationform.qualification,"text",document.applicationform.dateofbirth,"text",document.applicationform.age,"text",document.applicationform.fathername,"text",document.applicationform.mothername,"text"))
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
				 if( document.applicationform.mothername.value.charAt(0)==" ")
				 {
				 	alert("Mother Name should not start with Empty Character");
				    document.applicationform.mothername.focus();
					return false;
				 }
				 if(!stringValidateincludesigquots(document.applicationform.mothername,"Mother Name"))
				 {
					  
					document.applicationform.mothername.focus();
					return false;
				 }
				if(confirm("Do you want to Update the Staff Personal Profile...?"))
					{
					document.applicationform.studuserphoto.value=document.applicationform.photo.value;
					document.applicationform.action="./Staffpersonalprofilesubmit.jsp";
					document.applicationform.submit();
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

<div class="main_content">
<%@ include file="../include/header.jsp"%>


<div class="center_content">
<div class="left_content"></div>

<div class="right_content">

<%-- <h2><%=bundle.getString("label.staffprofileupdate.rootpath") %></h2> --%>

<table width=100%><tr><td width=80% align=left><h2><%=bundle.getString("label.staffprofileupdate.rootpath") %></h2></td><td align=right><a class=tablebold><font color=red>*</font>&nbsp;<font color=#000000><%=bundle.getString("label.studentprofileentry.Mandatory")%></font> </a></td></tr></table>

<%@ page
	import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Registration.StaffRegistrationQuery"%>

<%
	String date_str = "";
	StaffRegistrationQuery staffquery=new StaffRegistrationQuery();
	String prefix1 = "-";

	String firstname = "-";
	String middlename = "-";
	String lastname = "-";

	String fname = "-";
	String mname = "-";
	String age = "-";
	String sex = "-";

	String dateofbirth = "-";
	String photo = "-";
	
	String userid = "-";
	
	String personid = "-";

	String username = "-";
	String qualification = "-";
	String maritalstatus = "-";
	String departmentid = "-";

	
	
	
	String Staffid = request.getParameter("Staffid");
		departmentid =  request.getParameter("departmentid");

	String instituteid = null;
	try {
		instituteid = (String) session.getValue("instituteid");
 		ArrayList person_list = staffquery.staffprofiledetail(Staffid);
		HashMap map = null;
 		
 		if (person_list != null && person_list.size() > 0) {
 			map = (HashMap) person_list.get(0);
 			prefix1= (String) map.get("prefix");
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
 			age = (String) map.get("age")+"";
 			if(age.equals("null"))
 				age="";
 			sex = (String) map.get("sex");
 			dateofbirth = (String) map.get("dob");
 			photo= (String) map.get("imagepath");
 			userid = (String) map.get("userid");
 			personid = (String) map.get("personid");

 			username =  (String) map.get("username");
 			qualification =  (String) map.get("qualification");
 			maritalstatus =  (String) map.get("maritalstatus");
 		}

	} catch (Exception e) {
	}
	java.util.ResourceBundle rb=java.util.ResourceBundle.getBundle("resources.serversetup");
	String shapshotpath=rb.getString("shapshot");
	//out.println("shapshotpath********* "+shapshotpath);
	String imagePath=rb.getString("storagepath")+"/imagestorage/";
	String imageName="StaffPersonalImage.jpg";  
%>

	<form name="applicationform" method="post" 	enctype="multipart/form-data"><%@ page
		import="java.io.*,java.util.*"%> <%
 	StringBuffer currentDate = new StringBuffer();
 	Date dateObj = new Date();
 	currentDate.append((dateObj.getMonth() + 1) + "/"	+ dateObj.getDate() + "/" + (dateObj.getYear() + 1900));

	// out.println("detaillist=========>>>>>"+detaillist);
 %> <input type="hidden" name="currentDate" value="<%=currentDate%>">
<input type="hidden" name="personid" value="<%=userid%>">
<input type="hidden" name="staffpersonid" value="<%=personid%>">
<input type="hidden" name="Staffid" value="<%=Staffid%>"/>
<input type="hidden" name="departmentid" value="<%=departmentid%>"/>
<input type="hidden" name="hiddenuser_id" value="<%=username%>">
<input type="hidden" name="studuserphoto" value="<%=photo%>">
<input type="hidden" name="deptname" value="<%=request.getParameter("deptname")%>"/>

 	<table id="rounded-corner" border=0	width="100%">
		<thead>
			<tr>
				<th scope="col" class="rounded-company" width="5"></th>
				<th scope="col" class="rounded" width="100%"><%=bundle.getString("label.staffprofileupdate.StaffProfileUpdate") %></th>
				<th scope="col" class="rounded-q4" width="5"></th>
			</tr>
		</thead>
		<tfoot>
			<tr>
				<td colspan=2 class="rounded-foot-left"><em></em></td>
				<td class="rounded-foot-right">&nbsp;</td>
			</tr>
		</tfoot>
		<tbody >
			
			<tr>
			<td></td>
				<td  align=center colspan=2>
				<table border="0" width="83%" cellpadding="5" cellspacing="0" >
				<tr align="left">
						<td class=tablebold width="32%"><%=bundle.getString("label.staffprofileupdate.Prefix") %></td>
						<td align="left"><select name="slt_prefix"  maxlength=6  class=tablelight validate="prefix">
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
						<td class=tablebold width="32%"><%=bundle.getString("label.staffprofileupdate.FirstName") %>&nbsp;<font color=red>*</font></td>
						<td align="left"><input type=text class=tablelight
							name="studentname" validate="First Name" value="<%=firstname %>"  size="30"></td>
							<td rowspan="3" align=right><img
						src="<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2=<%=photo%>"
						name='stphoto_img1' id=stphoto_img width=120 height=130></td>
					</tr>
					<tr align="left">
						<td width="32%" class=tablebold><%=bundle.getString("label.staffprofileupdate.MiddleName") %></td>
						<td align="left" width="30%"><input type="text"
							 class="tablelight" name="middlername"
							maxlength="40" size="30"
							value="<%=middlename %>"></td>
						</tr>
					<tr align="left" class=tablebold>
						<td width="32%"><%=bundle.getString("label.staffprofileupdate.LastName") %>&nbsp;<font color=red>*</font></td>
						<td align="left" width="30%"><input type="text"
							 class="tablelight" name="lastname" validate="Last Name"
							maxlength="40" size="30"
							value="<%=lastname %>"></td>
						
					</tr>
				</table>
				</td>
			</tr>
			<tr>
			<td colspan=3 align =center >
			<table border="0" width="80%" bordercolor="#EEEEEE"  cellpadding="5"		cellspacing="0">
					<tr align="left" class=tablebold>
						<td width="33%"><%=bundle.getString("label.staffprofileupdate.Qualification") %>&nbsp;<font color=red>*</font></td>
						<td align="left" width="55%"><input type="text"	class="labeltextbox" class="labelfont" name="qualification" maxlength="40" size="30" validate="Qualification" value="<%=qualification %>" /></td>
					</tr>
					<tr align="left" class=tablebold>
						<td class=tablebold width="29%">
			<%=bundle.getString("label.staffprofileupdate.DateofBirth") %>&nbsp;<font color=red>*</font>
						</td>	<td  align=left>
					<input type=text name="dateofbirth"		class=tablelight value="<%=dateofbirth%>" maxlength=50 size=20	validate="Date of Birth" onkeydown='this.blur()' />
					<input	type="button" class="tablehead" value="^" onclick="Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','applicationform.dateofbirth','0',event,'Not_Greater_Than_CurrentDate',document.applicationform.server_date);" ></td>
					</tr>
					<tr align="left">
						<td class=tablebold width="29%"><%=bundle.getString("label.staffprofileupdate.Age") %>&nbsp;<font color=red>*</font></td>
						<td  width="71%"><input readonly type="text" validate="Age"
							name="age" value="<%=age %>" size=5 onblur='calcagefun()' onclick='calcagefun()' /></td>

					</tr>
					<tr align="left">
						<td class=tablebold width="29%"><%=bundle.getString("label.staffprofileupdate.Gender") %></td>
						<td  width="71%"><input type="radio"
							name="studsex" value="M" checked /><%=bundle.getString("label.staffprofileupdate.Male") %><input type="radio"
							name="studsex" value="F" /><%=bundle.getString("label.staffprofileupdate.Female") %>
							<input type=hidden  name="hiddensex"	value="<%=sex%>" />
						<script>
							for(var i=0;i<document.applicationform.studsex.length;i++)
							{
							if(document.applicationform.studsex[i].value==document.applicationform.hiddensex.value)
							document.applicationform.studsex[i].checked=true;
							}
							</script></td>

					</tr>
					<tr align="left">
						<td class=tablebold width="29%"><%=bundle.getString("label.staffprofileupdate.MaritalStatus") %></td>
						<td  width="71%"><input type="radio"
							name="staffmarital" value="Single" checked />Single<input type="radio"
							name="staffmarital" value="Married" /><%=bundle.getString("label.staffprofileupdate.Married") %>
							<input type=hidden  name="hiddenmarital"	value="<%=maritalstatus%>" />
						<script>
							for(var i=0;i<document.applicationform.staffmarital.length;i++)
							{
							if(document.applicationform.staffmarital[i].value==document.applicationform.hiddenmarital.value)
							document.applicationform.staffmarital[i].checked=true;
							}
							</script></td>

					</tr>
<tr align="left">
					<td colspan=2>
					<input type="radio" name="phototype" value='local' onclick="loadphototype('local')" checked/><%=bundle.getString("label.studentprofileentry.UploadImage")%><input type="radio" name="phototype" value='snapshot' onclick="loadphototype('webcam')"/><%=bundle.getString("label.studentprofileentry.CaptureImage")%>
					</td>
					</tr>
					<tr align="left">
					<td colspan=2>
					<table border='0' bordercolor='yellow' id="localphoto" style="display:block;" >  
						<tr>  
						<td width="33%" align="left" class=tablebold><%=bundle.getString("label.studentprofileentry.Photo")%>&nbsp;&nbsp;<font color=red class=tablebold>*</font></td>
						<td align="left" valign="bottom" width="55%"><input size='30' type=file class="browses" name="photo" validate="Photo"	/></td>
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
						<td width="33%"><%=bundle.getString("label.staffprofileupdate.Father'sName") %>&nbsp;<font color=red>*</font></td>
						<td align="left" width="55%"><input type="text"
							class="labeltextbox" class="labelfont" name="fathername" validate="Father's Name"
							maxlength="40" size="30"
							value="<%=fname %>" /></td>
					</tr>
					<tr align="left" class=tablebold>
						<td width="33%"><%=bundle.getString("label.staffprofileupdate.Mother'sName") %>&nbsp;<font color=red>*</font></td>
						<td align="left" width="55%"><input type="text"	class="labeltextbox" class="labelfont" name="mothername" maxlength="40" size="30" validate="Mother's Name" value="<%=mname %>" /></td>
					</tr>
					
					</table>
					</td>
					</tr>
					</tbody>
	</table>
	
	<a href="#"  onclick="backfun()" class="bt_blue"><span
		class="bt_blue_lft"></span><strong><%=bundle.getString("button.staffprofileupdate.Back") %></strong><span
		class="bt_blue_r"></span></a>
	 <a href="#" class="bt_green"
		onclick="Submitfun()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.staffprofileupdate.Submit") %></strong><span
		class="bt_green_r"></span></a></form>
</div>

</form>
<form name=mainform method="post" action="">
	<input type="hidden" name="personid" value="<%=userid%>"/>
		<input type="hidden" name="Staffid" value="<%=Staffid%>"/>
	<input type="hidden" name="departmentid" value="<%=departmentid%>"/>
	<input type="hidden" name="deptname" value="<%=request.getParameter("deptname")%>"/>
	
	
	</form>
<!-- end of right content--></div>
<!--end of center content -->




<div class="clear"></div>
</div>
<!--end of main content--> <%@ include file="../include/footer.jsp"%>


</div>
</body>
</html>