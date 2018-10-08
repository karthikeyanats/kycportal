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
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
	<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
	<SCRIPT language="JavaScript" src='<%=request.getContextPath()%>/js/Calendar/Calendar.js'></SCRIPT>
	
<script type="text/javascript">
function backfun()
{
document.applicationform.action="./Studentprofileview.jsp";
document.applicationform.submit();
}
function Submitfun()
{
var flag=false;
	if(check_ForParticularElements(document.applicationform.schoolname,'text',document.applicationform.schooladdress,'textarea'))
	{	var len=document.applicationform.chk.length;
		for(var i=0;i<len;i++)
		{
			if(document.applicationform.chk[i].checked==true)
			{
			 	flag=true;
			}
		}
		if(flag==true)
		{
			if(confirm("Do you want to update the Previous School Profile...?"))
			{
			for(var i=0;i<len;i++)
				{
					if(document.applicationform.chk[i].checked==true)
					{
					   document.applicationform.subject[i].disabled=false;
					   document.applicationform.month[i].disabled=false;
					   document.applicationform.registrationno[i].disabled=false;
					   document.applicationform.mark[i].disabled=false;
					   document.applicationform.max[i].disabled=false;
					}
					else
					{
						if(document.applicationform.examinfoedit[i].value!="X")
						{
						   document.applicationform.subject[i].disabled=true;
						   document.applicationform.month[i].disabled=true;
						   document.applicationform.registrationno[i].disabled=true;
						   document.applicationform.mark[i].disabled=true;
						   document.applicationform.max[i].disabled=true;
						}
					   if(document.applicationform.examinfoedit[i].value=="A")
					   document.applicationform.examinfoedit[i].disabled=true; 
					}
				}
				document.applicationform.action="StudentPreviousSchoolProfilesubmit.jsp";
				document.applicationform.submit();
			}
		}
		else
		{
			alert("Select Any One Exam Details ");
		}
	}
}

function markvalidation(obj,count)
{
if(obj.checked)
{
	if(check_ForParticularElements(document.applicationform.subject[count],"text",document.applicationform.month[count],"text",document.applicationform.registrationno[count],"text",document.applicationform.mark[count],"text",document.applicationform.max[count],"text"))
	{
	   document.applicationform.subject[count].disabled=true;
	   document.applicationform.month[count].disabled=true;
	   document.applicationform.registrationno[count].disabled=true;
	   document.applicationform.mark[count].disabled=true;
	   document.applicationform.max[count].disabled=true;
	   if(document.applicationform.examinfoedit[count].value!="A")
	   {
	   	  document.applicationform.examinfoedit[count].value="U";
	   	  }
	}
	else
	{
	obj.checked=false;
	}
}
else
{
   document.applicationform.subject[count].disabled=false;
   document.applicationform.month[count].disabled=false;
   document.applicationform.registrationno[count].disabled=false;
   document.applicationform.mark[count].disabled=false;
   document.applicationform.max[count].disabled=false;
   if(document.applicationform.examinfoedit[count].value!="A")
	   {
	   	  document.applicationform.examinfoedit[count].value="X";
	   	  }
}
}
var filednumber="0";
function createexamdetails()
{
	rowlen = document.getElementById("previousStudentexam").rows.length;
	table=document.getElementById("previousStudentexam").getElementsByTagName("tbody")[0];
	row = document.createElement("tr");
	row.align="Left";

	cell = document.createElement("td");
	cell.innerHTML = "<input type='text' class='labeltextbox' maxlength='30' size=15 name='subject'>";
	row.appendChild(cell);

	cell = document.createElement("td");
	cell.align = "left";
	cell.innerHTML = "<input type='text'	class='labeltextbox' maxlength='20' size=15 name='month'>";
	row.appendChild(cell);

	cell = document.createElement("td");
	cell.align = "left";
	cell.innerHTML = "<input type='text' class='labeltextbox' maxlength='30' size=15 name='registrationno'>";
	row.appendChild(cell);

	cell = document.createElement("td");
	cell.align = "left";
	cell.innerHTML = "<input type='text' name='mark' maxlength='3' size=10 onkeypress='checkNumber(event)' >";
	row.appendChild(cell);

	cell = document.createElement("td");
	cell.align = "left";
	cell.innerHTML = "<input type='text' class='labeltextbox' name='max' maxlength='3' size=10 value='' onkeypress='checkNumber(event)'>";
	row.appendChild(cell);
	
	cell = document.createElement("td");
	cell.align = "left";
	cell.innerHTML = "<input type=checkbox class=tablelight name=chk onclick=markvalidation(this,'"+filednumber+"')><input type='hidden' name='examinfoedit' value='A'>";
	row.appendChild(cell);
	table.appendChild(row);

	filednumber++;
}

function removeexamdetails(tabname)
{

	if(document.getElementById(tabname).rows.length==4)
	{
	alert("Cant delete further rows");
	}
	else
	{
       if(document.getElementById(tabname).rows.length > 1)
       	{
            document.getElementById(tabname).deleteRow(document.getElementById(tabname).rows.length-1);
            filednumber--;
        }
  	}
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

<%-- <h2><%=bundle.getString("label.studentpreviousschoolprofileupdate.rootpath") %></h2> --%>

<table width=100%><tr><td width=80% align=left><h2><%=bundle.getString("label.studentpreviousschoolprofileupdate.rootpath") %></h2></td><td align=right><a class=tablebold><font color=red>*</font>&nbsp;<font color=#000000><%=bundle.getString("label.studentprofileentry.Mandatory")%></font> </a></td></tr></table>


<%@ page
	import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Registration.StudentRegistrationQuery"%>

<%
		String date_str = "";
		StudentRegistrationQuery studentquery = new StudentRegistrationQuery(); 	

		String previousschoolname = "-";
		String previousschooladdress = "-";
		String mediumstudied = "-";
		String tc = "-";
		String cc = "-";
		String splcategory = "-";
		String marksheet = "-";
		String medicalcertificate = "-";
		String sportscertificate = "-";

		
	String userid = request.getParameter("personid");
	String instituteid = null;
	ArrayList qualification_list=new ArrayList();
	try {
		instituteid = (String) session.getValue("instituteid");
		ArrayList register_list = studentquery.Studentregisterdetails(userid);
 		qualification_list = studentquery.Studentqualificationdetails(userid);
		HashMap map = null;
		if (register_list != null && register_list.size() > 0)
		{
 			map = (HashMap) register_list.get(0);
 			previousschoolname = (String) map	.get("previousschoolname");
 			previousschooladdress = (String) map.get("previousschooladdress");
 			if(previousschoolname==null)
 				previousschoolname="-";
 			if(previousschooladdress==null)
 				previousschooladdress="-";
 			mediumstudied = (String) map.get("mediumstudied")+"";
 			tc = (String) map	.get("tc")+"";
 			cc = (String) map.get("cc")+"";
 			splcategory = (String) map.get("splcategory")+"";
 			medicalcertificate = (String) map	.get("medicalcertificate")+"";
 			marksheet = (String) map.get("marksheet")+"";
 			sportscertificate = (String) map.get("sportscertificate")+"";
 		}
		

	} catch (Exception e) {
	}
%>

	<form name="applicationform" method="post" action=""><%@ page
		import="java.io.*,java.util.*"%> <%
 	StringBuffer currentDate = new StringBuffer();
 	Date dateObj = new Date();
 	currentDate.append((dateObj.getMonth() + 1) + "/"	+ dateObj.getDate() + "/" + (dateObj.getYear() + 1900));

 %> <input type="hidden" name="currentDate" value="<%=currentDate%>">
<input type="hidden" name="personid" value="<%=userid%>">
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
 <input type="hidden" name="hiddensession" value="<%=request.getParameter("session")%>">
 
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
 	<table id="rounded-corner" border=0 width="100%">
		<thead>
			<tr>
				<th scope="col" class="rounded-company" width="5"></th>
				<th scope="col" class="rounded" width="100%"><%=bundle.getString("label.studentpreviousschoolprofileupdate.StudentPreviousSchoolDetailsUpdate")%></th>
				<th scope="col" class="rounded-q4" width="5"></th>
			</tr>
		</thead>
		<tfoot>
			<tr>
				<td   colspan=2 class="rounded-foot-left"><em></em></td>
				<td class="rounded-foot-right">&nbsp;</td>
			</tr>
		</tfoot>
		<tbody>
					
					<tr>
						<td align=center colspan=3>
							<table border="0" width="80%" bordercolor="#EEEEEE" cellpadding="5" align=center cellspacing="0" rules="groups" id="previousSchooldetails">
									<tr>
										<td  align="left" class='tablebold' width='30%'><%=bundle.getString("label.studentpreviousschoolprofileupdate.NameoftheSchool")%><font color=red class=tablebold>*</font></td>
										<td  align="left" class='tablebold' width='1%'>:</td>
										<td  align="left" class='tablelight' align='left'><input type='text'  maxlength='50' validate="School Name" name='schoolname' size='40' value="<%=previousschoolname %>" ></td>
									</tr>
									<tr>
										<td  align="left" class='tablebold' width='30%' valign='top'><%=bundle.getString("label.studentpreviousschoolprofileupdate.AddressoftheSchool")%><font color=red class=tablebold>*</font></td>
										<td  align="left" class='tablebold' width='1%'  valign='top'>:</td>
										<td  align="left" class='tablelight'><textarea  name='schooladdress' validate="School Address" rows='5' cols='50' onkeydown=textCounter_label(this,document.getElementById('remschoolLen2'),100) onkeypress=textCounter_label(this,document.getElementById('remschoolLen2'),100)><%=previousschooladdress %></textarea><br><font color=red><label id='remschoolLen2' >100</label>&nbsp;characters Remaining</font></td>
									</tr>
									<tr>
										<td  align="left" class='tablebold' width='30%' valign='top'><%=bundle.getString("label.studentpreviousschoolprofileupdate.MediumofInstruction")%><font color=red class=tablebold>*</font></td>
										<td  align="left" class='tablebold' width='1%'  valign='top'>:</td>
										<% if(mediumstudied.equalsIgnoreCase("Tamil")){%>  
											<td  align="left" class='tablelight' align='left'><input type='radio' name='medium' value='Tamil' checked> Tamil &nbsp; <input type='radio' name='medium' value='English'>English</td>
										<%} else{%>
											<td  align="left" class='tablelight' align='left'><input type='radio' name='medium' value='Tamil'> Tamil &nbsp; <input type='radio' name='medium' value='English' checked>English</td>
										<%} %>
										
									</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td  align="center" colspan=3>
								<table border="1" width="80%"  bordercolor="#EEEEEE" cellpadding="3" id="previousStudentexam" align=center cellspacing="0" rules="groups">
								<tr>
									<td  align="left" class='tablebold' colspan='6'><%=bundle.getString("label.studentpreviousschoolprofileupdate.EXAMINATIONDETAILS")%></td>
								</tr>
								<tr>
									<td  align="left" class='tablebold'><%=bundle.getString("label.studentpreviousschoolprofileupdate.Subjects")%></td>
									<td  align="left" class='tablebold' ><%=bundle.getString("label.studentpreviousschoolprofileupdate.Month-Year")%> <br> Ex:<font color=red size=1><%=bundle.getString("label.studentpreviousschoolprofileupdate.May2007")%></font></td>
									<td  align="left" class='tablebold' ><%=bundle.getString("label.studentpreviousschoolprofileupdate.RegistrationNo")%></td>
									<td  align="left" class='tablebold' ><%=bundle.getString("label.studentpreviousschoolprofileupdate.MarksScored")%></td>
									<td  align="left" class='tablebold' ><%=bundle.getString("label.studentpreviousschoolprofileupdate.MaxMarks")%></td>
									<td  align="left" class='tablebold' ><%=bundle.getString("label.studentpreviousschoolprofileupdate.Check")%></td>
								</tr>
							<%	
							int j=0;
							if (qualification_list != null && qualification_list.size() > 0) {
							for(int i=0;i<qualification_list.size();i++,j++)
							{
					 			HashMap map = (HashMap) qualification_list.get(i);
					 			String subject  = (String) map.get("subject");
					 			String monthandyear = (String) map.get("monthandyear");
					 			String registrationno = (String) map.get("registrationno");
					 			String marksscored = (String) map	.get("marksscored");
					 			String maxmarks = (String) map.get("maxmarks");
					 			String studentqualificationid = (String) map.get("studentqualificationid");

					 			
					 			%>
								<tr>
								<%if(subject.equalsIgnoreCase("Language") || subject.equalsIgnoreCase("English")){ %>
									<td  align="left" class="tablebold"><input type="hidden" name="subject" value="<%=subject%>"  disabled><%=subject%></td>
									<%}else{ %>
									<td  align="left" class="tablebold"><input type="text" name="subject" value="<%=subject%>"  disabled></td>
									<%} %>
									<td  align="left" class="tablebold" ><input type="text"	class="labeltextbox" maxlength="20"  value="<%=monthandyear%>" size=15 name="month"	 disabled></td>
									<td  align="left" class="tablebold" ><input type="text" class="labeltextbox" maxlength="30" size=15 name="registrationno"  value="<%=registrationno%>" disabled></td>
									<td  align="left" class="tablebold" ><input type="text" name="mark" maxlength="3" size=10 onkeypress="checkNumber(event)"  value="<%=marksscored%>" disabled></td>
									<td  align="left" class="tablebold" ><input type="text" class="labeltextbox" name="max" maxlength="3" size=10  value="<%=maxmarks%>" onkeypress="checkNumber(event)" disabled></td>
									<td  align="left" class="tablebold" ><input type=checkbox class=tablelight name=chk onclick=markvalidation(this,<%=j %>) checked><input type="hidden" name="examinfoid" value="<%=studentqualificationid %>"><input type="hidden" name="examinfoedit" value="U"></td>
								</tr>
								<%} 
								}
							
					 			 out.println("<script>filednumber='"+qualification_list.size()+"';</script>");
					 			if(qualification_list.size()==0)
								{
								%>
									<tr>
									<td  align="left" class="tablebold"><input type="text" name="subject" value=""  ></td>
									<td  align="left" class="tablebold" ><input type="text"	class="labeltextbox" maxlength="20"  value="" size=15 name="month"	 ></td>
									<td  align="left" class="tablebold" ><input type="text" class="labeltextbox" maxlength="30" size=15 name="registrationno"  value="" ></td>
									<td  align="left" class="tablebold" ><input type="text" name="mark" maxlength="3" size=10 onkeypress="checkNumber(event)"  value="" ></td>
									<td  align="left" class="tablebold" ><input type="text" class="labeltextbox" name="max" maxlength="3" size=10  value="" onkeypress="checkNumber(event)" ></td>
									<td  align="left" class="tablebold" ><input type=checkbox class=tablelight name=chk onclick=markvalidation(this,0) ><input type="hidden" name="examinfoedit" value="A"></td>
									</tr>
									<tr>
									<td  align="left" class="tablebold"><input type="text" name="subject" value=""  ></td>
									<td  align="left" class="tablebold" ><input type="text"	class="labeltextbox" maxlength="20"  value="" size=15 name="month"	 ></td>
									<td  align="left" class="tablebold" ><input type="text" class="labeltextbox" maxlength="30" size=15 name="registrationno"  value="" ></td>
									<td  align="left" class="tablebold" ><input type="text" name="mark" maxlength="3" size=10 onkeypress="checkNumber(event)"  value="" ></td>
									<td  align="left" class="tablebold" ><input type="text" class="labeltextbox" name="max" maxlength="3" size=10  value="" onkeypress="checkNumber(event)" ></td>
									<td  align="left" class="tablebold" ><input type=checkbox class=tablelight name=chk onclick=markvalidation(this,1) ><input type="hidden" name="examinfoedit" value="A"></td>
									</tr>
									
								<%
					 			 out.println("<script>filednumber='2';</script>");
								} 
								
								if(qualification_list.size()==1)
								{
								%>
									<tr>
									<td  align="left" class="tablebold"><input type="text" name="subject" value=""  ></td>
									<td  align="left" class="tablebold" ><input type="text"	class="labeltextbox" maxlength="20"  value="" size=15 name="month"	 ></td>
									<td  align="left" class="tablebold" ><input type="text" class="labeltextbox" maxlength="30" size=15 name="registrationno"  value="" ></td>
									<td  align="left" class="tablebold" ><input type="text" name="mark" maxlength="3" size=10 onkeypress="checkNumber(event)"  value="" ></td>
									<td  align="left" class="tablebold" ><input type="text" class="labeltextbox" name="max" maxlength="3" size=10  value="" onkeypress="checkNumber(event)" ></td>
									<td  align="left" class="tablebold" ><input type=checkbox class=tablelight name=chk onclick=markvalidation(this,1) ><input type="hidden" name="examinfoedit" value="A"></td>
									</tr>
									
								<%
					 			 out.println("<script>filednumber='2';</script>");
								}
								%>
							</table>	
				</td>
			</tr>
			<tr>
				<td  valign=bottom align="right" colspan=3>
		     	<a href="#ck" name='ck' onclick="removeexamdetails('previousStudentexam')" class="bt_red"><span class="bt_red_lft"></span><strong><%=bundle.getString("label.studentpreviousschoolprofileupdate.Remove")%></strong><span class="bt_red_r"></span></a>
				 <a href='#bb' name="bb" onclick="createexamdetails()" class="bt_green"><span class="bt_green_lft"></span><strong><%=bundle.getString("label.studentpreviousschoolprofileupdate.AddNewRow")%></strong><span class="bt_green_r"></span></a>
		
				</td>
   			</tr>
			<tr>
				<td  align=center colspan=3>
					<table border="0" bordercolor="#EEEEEE"  cellpadding="5" id="Certificateverification" cellspacing="0" width="80%">
								<tr>
									<td  align="left" class="tablebold" colspan="3"><%=bundle.getString("label.studentpreviousschoolprofileupdate.VerificationofCertificates")%></td>
								</tr>
								<tr>
									<td  align="left" class="tablebold" width="25%"><%=bundle.getString("label.studentpreviousschoolprofileupdate.T.C")%></td>
									<td  align="left" class="tablebold" width="1%">:</td>
									<% if(tc.equalsIgnoreCase("Yes")){%>
									<td  align="left" class="tablebold" ><input type="radio" name="tc" value="Yes" checked>Yes	/<input type="radio" name="tc"  value="No">No</td>
									<%}else{ %>
									<td  align="left" class="tablebold" ><input type="radio" name="tc" value="Yes">Yes	/<input type="radio" name="tc" checked value="No">No</td>
									<%} %>
								</tr>
								<tr>
									<td  align="left" class="tablebold"><%=bundle.getString("label.studentpreviousschoolprofileupdate.C.C")%></td>
									<td  align="left" class="tablebold" width="1%">:</td>
									<% if(cc.equalsIgnoreCase("Yes")){%>
									<td  align="left" class="tablebold" ><input type="radio" name="cc" value="Yes" checked>Yes	/<input type="radio" name="cc"  value="No">No</td>
									<%}else{ %>
									<td  align="left" class="tablebold" ><input type="radio" name="cc" value="Yes">Yes	/<input type="radio" name="cc" checked value="No">No</td>
									<%} %>

								</tr>
								<tr>
									<td  align="left" class="tablebold"><%=bundle.getString("label.studentpreviousschoolprofileupdate.Spl.Category")%></td>
									<td  align="left" class="tablebold" width="1%">:</td>
									<% if(splcategory.equalsIgnoreCase("Yes")){%>
									<td  align="left" class="tablebold" ><input type="radio" name="splCategory" value="Yes" checked>Yes/<input type="radio" name="splCategory"  value="No">No</td>
									<%}else{ %>
									<td  align="left" class="tablebold" ><input type="radio" name="splCategory" value="Yes">Yes/<input type="radio" name="splCategory" checked value="No">No</td>
									<%} %>
								</tr>
								<tr>
									<td  align="left" class="tablebold"><%=bundle.getString("label.studentpreviousschoolprofileupdate.MedicalCertificate")%></td>
									<td  align="left" class="tablebold" width="1%">:</td>
									<% if(medicalcertificate.equalsIgnoreCase("Yes")){%>
									<td  align="left" class="tablebold" ><input type="radio" name="mc" value="Yes" checked>Yes	/<input type="radio" name="mc"  value="No">No</td>
									<%}else{ %>
									<td  align="left" class="tablebold" ><input type="radio" name="mc" value="Yes">Yes	/<input type="radio" name="mc" checked value="No">No</td>
									<%} %>
								</tr>
								<tr>
									<td  align="left" class="tablebold"><%=bundle.getString("label.studentpreviousschoolprofileupdate.MarkSheet")%></td>
									<td  align="left" class="tablebold" width="1%">:</td>
									<% if(marksheet.equalsIgnoreCase("Yes")){%>
									<td  align="left" class="tablebold" ><input type="radio" name="ms" value="Yes" checked>Yes	/<input type="radio" name="ms"  value="No">No</td>
									<%}else{ %>
									<td  align="left" class="tablebold" ><input type="radio" name="ms" value="Yes">Yes	/<input type="radio" name="ms" checked value="No">No</td>
									<%} %>

								</tr>
								<tr>
									<td  align="left" class="tablebold"><%=bundle.getString("label.studentpreviousschoolprofileupdate.SportsCertificate")%></td>
									<td  align="left" class="tablebold" width="1%">:</td>
									<% if(sportscertificate.equalsIgnoreCase("Yes")){%>
									<td  align="left" class="tablebold" ><input type="radio" name="sc" value="Yes" checked>Yes	/<input type="radio" name="sc"  value="No">No</td>
									<%}else{ %>
									<td  align="left" class="tablebold" ><input type="radio" name="sc" value="Yes">Yes	/<input type="radio" name="sc" checked value="No">No</td>
									<%} %>
								</tr>
							</table>
				</td>
			</tr>
		</tbody>
	</table>
	<a href="#"  onclick="backfun()" class="bt_blue"><span
		class="bt_blue_lft"></span><strong><%=bundle.getString("button.studentpreviousschoolprofileupdate.Back")%></strong><span
		class="bt_blue_r"></span></a>
	 <a href="#" class="bt_green"
		onclick="Submitfun()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.studentpreviousschoolprofileupdate.Submit")%></strong><span
		class="bt_green_r"></span></a></form>
</div>
<!-- end of right content--></div>
<!--end of center content -->




<div class="clear"></div>
</div>
<!--end of main content--> <%@ include file="../include/footer.jsp"%>


</div>
</body>
</html>