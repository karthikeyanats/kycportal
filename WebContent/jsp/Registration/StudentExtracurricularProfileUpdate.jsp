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
if(document.applicationform.extra!=undefined)
{
	var flag=false;
	var len=document.applicationform.extra.length;
	if(len!=undefined)
	{
			for(var i=0;i<len;i++)
			{
				if(document.applicationform.extra[i].checked==true)
				{
				 	flag=true;
				}
			}
	}
	else
	{
	if(document.applicationform.extra.checked==true)
				{
				 	flag=true;
				}
	
	}
			if(flag==true)
			{
				if(confirm("Do you want to Update the Student Extracurricular Profile Update...?"))
				{
					document.applicationform.action="StudentExtraCurricularActivityProfilesubmit.jsp";
					document.applicationform.submit();
				}
			}
			else
			{
				alert("Select Any One Extra Curricular Activity ");
			}
	}
	else
	{
		alert("Extra Curricular Activity Not found");
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

<h2><%=bundle.getString("label.studentextracurricularprofileupdate.rootpath") %></h2>
<%@ page
	import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Registration.StudentRegistrationQuery"%>

<%
		String date_str = "";
		StudentRegistrationQuery studentquery = new StudentRegistrationQuery(); 	
		String userid = request.getParameter("personid");
		String instituteid = null;
		String studextracurricular="";
		ArrayList extracurricular=new ArrayList();
		String sessionuserid	= (String) session.getValue("userid");

		try 
		{
		instituteid = (String) session.getValue("instituteid");
		ArrayList register_list = studentquery.Studentregisterdetails(userid);
	 	extracurricular 		= studentquery.loadExtrcurricular(sessionuserid);
		HashMap map = null;
		if (register_list != null && register_list.size() > 0)
		{
 			map = (HashMap) register_list.get(0);
			studextracurricular = (String) map.get("studextracurricular")+"";
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
<input type="hidden" name="hiddensession" value="<%=request.getParameter("session")%>">

<input type="hidden" name="req_boardname" value="<%=request.getParameter("req_boardname")%>">
<input type="hidden" name="req_standardnamegp" value="<%=request.getParameter("req_standardnamegp")%>">
<input type="hidden" name="req_sectionname" value="<%=request.getParameter("req_sectionname")%>">
<input type="hidden" name="req_studentname" value="<%=request.getParameter("req_studentname")%>">
 
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
				<th scope="col" class="rounded" width="100%"><%=bundle.getString("label.studentextracurricularprofileupdate.StudentExtraCurricularActivityProfileUpdate")%></th>
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
						<table  border=0 width="100%">
								<% 
									HashMap hashmap		= null;
									HashMap hashmap1	= null;
									if(extracurricular != null && extracurricular.size()>0){
										for(int u=0;u<extracurricular.size();u++){
											hashmap		= (HashMap)extracurricular.get(u);
											
											if(u==0)
											out.print("<tr>");
											if(studextracurricular.indexOf(hashmap.get("extracurricularactivityid")+"")!=-1)
											{
												if(extracurricular.size()%2==1 && u==extracurricular.size()-1)
												out.print("<td width='50%' colspan=2 align=left><input type='checkbox' name='extra' value='"+hashmap.get("extracurricularactivityid")+"' checked>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+hashmap.get("extracurricularname")+"</td>");
												else
												out.print("<td width='50%' align=left><input type='checkbox' name='extra' value='"+hashmap.get("extracurricularactivityid")+"' checked>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+hashmap.get("extracurricularname")+"</td>");

											}
											else
											 {
												if(extracurricular.size()%2==1 && u==extracurricular.size()-1)
												out.print("<td colspan=2 align=left><input type='checkbox' name='extra' value='"+hashmap.get("extracurricularactivityid")+"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+hashmap.get("extracurricularname")+"</td>");
												else
												out.print("<td  align=left><input type='checkbox' name='extra' value='"+hashmap.get("extracurricularactivityid")+"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+hashmap.get("extracurricularname")+"</td>");
													
											 }
											if(u%2==1)
												out.print("</tr><tr>");
											if(u==extracurricular.size()-1)
												out.print("</tr>");

										}
									}
									else{
										out.println("<tr align='center' class='tablebold'><td colspan='2'><font color='red'>Data Not Found</font></td></tr>");
										//out.print("<tr><td colspan='2' align='center'>Data Not Found</td></tr>");
									}
										
								%>
							</table>
				</td>
			</tr>
		</tbody>
	</table>
	<a href="#"  onclick="backfun()" class="bt_blue"><span
		class="bt_blue_lft"></span><strong><%=bundle.getString("button.studentextracurricularprofileupdate.Back")%></strong><span
		class="bt_blue_r"></span></a>
	 <a href="#" class="bt_green"
		onclick="Submitfun()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.studentextracurricularprofileupdate.Submit")%></strong><span
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