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

<script type="text/javascript">

	function backfun()
	{
		document.applicationform.action="./Studentprofileview.jsp";
		document.applicationform.submit();
	}
	
	function Submitfun()
	{
		if(a_chkflg){
		if(confirm("Do you want to Update the Student Scholarship Update...?"))
		{
			document.applicationform.actionstate.value= "allocate";
			document.applicationform.action		= "StudentScholarshipProfilesubmit.jsp";
			document.applicationform.submit();
		}
		}
		else
			{
			alert("Select any options for Allocation")
			}
	}
	
	function deallocatfun()
	{
		
		if(de_chkflg){
		
		if(confirm("Do you want to Update the Student Scholarship Update...?"))
		{
			document.applicationform.actionstate.value= "deallocate";
			document.applicationform.action		= "StudentScholarshipProfilesubmit.jsp";
			document.applicationform.submit();
		}
		}
		else
			{
			alert("Select any options for deallocation")
			
			}

	}
	var a_chkflg= false;
	var de_chkflg= false;
	function chksel(obj)
	{
		var position	= obj.getAttribute("position");

		if(obj.getAttribute("chkstate")=="allocate")
		{
			if(obj.checked)
			{
				a_chkflg= true;	
				document.applicationform.amount[position].value=obj.getAttribute("amount");
				document.applicationform.termfeesid[position].value=obj.getAttribute("termfeesid"); 
				document.applicationform.scholarshipamountallocationid[position].value=obj.value;
			}
			else
			{
				a_chkflg= false;
			document.applicationform.amount[position].value="";
			document.applicationform.termfeesid[position].value=""; 
			document.applicationform.scholarshipamountallocationid[position].value="";

			}
		}
		else if(obj.getAttribute("chkstate")=="deallocate")
		{
			if(obj.checked)
			{
				de_chkflg= true;
				document.applicationform.deamount[position].value=obj.getAttribute("deamount");
				document.applicationform.determfeesid[position].value=obj.getAttribute("determfeesid"); 
				document.applicationform.feescollectionid[position].value=obj.getAttribute("feescollectionid");
				document.applicationform.schemeforstudentid[position].value=obj.getAttribute("schemeforstudentid");
				document.applicationform.descholarshipamountallocationid[position].value=obj.value;

			}
			else
				{
				de_chkflg= false;
				document.applicationform.deamount[position].value="";
				document.applicationform.determfeesid[position].value="";
				document.applicationform.feescollectionid[position].value="";
				document.applicationform.schemeforstudentid[position].value="";
				document.applicationform.descholarshipamountallocationid[position].value="";
				}
		}
	}
	
	
	
	
	function cancelSelection(){
		
		for(var i=0;i<document.applicationform.scholarshipallocation.options.length;i++){
			
			document.applicationform.scholarshipallocation.options[i].selected	= false;
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

<h2><%=bundle.getString("label.studentscholarshipprofileupdate.rootpath") %></h2>
<%@ page
	import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Registration.StudentRegistrationQuery"%>

<%
		String date_str = "";
		StudentRegistrationQuery studentquery = new StudentRegistrationQuery(); 	
		
		//ArrayList scholarshipList	= studentquery.loadScholarshipDetails(personid, standardscheduleid);
		
		String personid = request.getParameter("personid");
		String instituteid = null;
		String studextracurricular="";
		ArrayList scholarshipList= null;
		String stundentapproveid =  null;
		
		 stundentapproveid = request.getParameter("stundentapproveid");
	 	
	 	scholarshipList			= studentquery.loadScholarshipDetails(personid, request.getParameter("standardscheduleid"));
	 //	out.println(scholarshipList);
//	 	out.println("Stdscheduleid===>>>"+request.getParameter("standardscheduleid"));
		
		
%>

	<form name="applicationform" method="post" action=""><%@ page
		import="java.io.*,java.util.*"%> <%
 	StringBuffer currentDate = new StringBuffer();
 	Date dateObj = new Date();
 	currentDate.append((dateObj.getMonth() + 1) + "/"	+ dateObj.getDate() + "/" + (dateObj.getYear() + 1900));

 %> <input type="hidden" name="currentDate" value="<%=currentDate%>">
<input type="hidden" name="personid" value="<%=personid%>">
<input type="hidden" name="studentprofileedit" value="<%=request.getParameter("studentprofileedit")%>">
<input type=hidden   name=session value="<%=request.getParameter("session")%>">
<input type=hidden   name=board value="<%=request.getParameter("board")%>">
<input type=hidden   name=standardscheduleid value="<%=request.getParameter("standardscheduleid")%>">
<%-- <input type=hidden   name=standard value="<%=request.getParameter("standardscheduleid")%>">
 --%><input type=hidden   name=sectionscheduleid value="<%=request.getParameter("sectionscheduleid")%>">
<input type="hidden" name="req_sessionname" value="<%=request.getParameter("req_sessionname")%>">
<input type="hidden" name="req_sessionstatus" value="<%=request.getParameter("req_sessionstatus")%>">
<input type="hidden" name="hiddensession" value="<%=request.getParameter("session")%>">

<input type="hidden" name="req_boardname" value="<%=request.getParameter("req_boardname")%>">
<input type="hidden" name="req_standardnamegp" value="<%=request.getParameter("req_standardnamegp")%>">
<input type="hidden" name="req_sectionname" value="<%=request.getParameter("req_sectionname")%>">
<input type="hidden" name="req_studentname" value="<%=request.getParameter("req_studentname")%>">
<input type="hidden" name="actionstate">
<input type="hidden" name="amount">
<input type="hidden" name="termfeesid">
<input type="hidden" name="deamount">
<input type="hidden" name="determfeesid">
<input type="hidden" name="feescollectionid">
<input type="hidden" name="schemeforstudentid">
<input type="hidden" name="scholarshipamountallocationid">
<input type="hidden" name="descholarshipamountallocationid">


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
				
				<th scope="col" class="rounded-company" width="100%">Scholarship Allocation </th>
				<th scope="col" class="rounded-q4" width="5"></th>
			</tr>
		</thead>
		<tfoot>
			<tr>
				<td colspan=1 class="rounded-foot-left"><em></em></td>
				<td class="rounded-foot-right">&nbsp;</td>
			</tr>
		</tfoot>
		<tbody>
					
			<tr>
				<td align=center colspan=3>
					
					<table width="100%" border="0">
							<tr class=tableheading><td>SL. No.</td><td>Term Name</td><td>Scholarship Name</td><td>Amount</td><td>Select</td></tr>
					
					<%
							HashMap hashmap	= null;
						int inc=0; int serialcount =0;
							if(scholarshipList != null && scholarshipList.size()>0)
							for(int y=0;y<scholarshipList.size();y++){
								hashmap			= (HashMap)scholarshipList.get(y);
								if(hashmap.get("schemeforstudentid")==null)
								{
									inc++;
								out.print("<tr><td>"+(inc)+"</td><td>"+hashmap.get("termname")+"</td><td>"+hashmap.get("scholarshipname")+"</td><td>"+hashmap.get("amount")+"</td>");
									out.print("<td><input type=checkbox name='scholarshipallocation' value='"+hashmap.get("scholarshipamountallocationid")+"' position='"+serialcount+"' termfeesid='"+hashmap.get("termfeesid")+"'  amount='"+hashmap.get("amount")+"'  chkstate='allocate' onclick='chksel(this)'><input type=hidden id='termfeesid' name='termfeesid'><input type=hidden id='amount' name='amount'><input type=hidden id='scholarshipamountallocationid' name='scholarshipamountallocationid'>");
									serialcount++;	
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
					
					
										
				</td>
			</tr>
			<!-- <tr>
				<td valign="top" colspan="3">
					<a href="#" class="bt_green" onclick="cancelSelection()"><span class="bt_green_lft"></span><strong>Cancel Selection</strong><span class="bt_green_r"></span></a>
				</td>
			</tr> -->
		</tbody>
	</table>
	
	<a href="#"  onclick="backfun()" class="bt_blue"><span
		class="bt_blue_lft"></span><strong><%=bundle.getString("button.studentextracurricularprofileupdate.Back")%></strong><span
		class="bt_blue_r"></span></a>
	<%if(inc > 0){ %> <a href="#" class="bt_green"
		onclick="Submitfun()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.studentextracurricularprofileupdate.Submit")%></strong><span
		class="bt_green_r"></span></a>
		<%}%>
		<br></br><br></br>
		
		
		
		
		<table id="rounded-corner" border=0 width="100%">
		<thead>
			<tr>
				
				<th scope="col" class="rounded-company" width="100%">Allocated Scholarships </th>
				<th scope="col" class="rounded-q4" width="5"></th>
			</tr>
		</thead>
		<tfoot>
			<tr>
				<td colspan=1 class="rounded-foot-left"><em></em></td>
				<td class="rounded-foot-right">&nbsp;</td>
			</tr>
		</tfoot>
		<tbody>
					
			<tr>
				<td align=center colspan=3>
				
					<table width="100%" border="0">
							<tr class=tableheading><td>SL. No.</td><td>Term Name</td><td>Scholarship Name</td><td>Amount</td><td>Select</td></tr>
					
					<%
							HashMap hashmap1	= null;
							int inc1=0;int serialcnt=0;
							if(scholarshipList != null && scholarshipList.size()>0)
							for(int y=0;y<scholarshipList.size();y++){
								hashmap1			= (HashMap)scholarshipList.get(y);
								if(hashmap1.get("schemeforstudentid")!=null){
									inc1++;
								out.print("<tr><td>"+(inc1)+"</td><td>"+hashmap1.get("termname")+"</td><td>"+hashmap1.get("scholarshipname")+"</td><td>"+hashmap1.get("amount")+"</td>");
								/* if(hashmap.get("schemeforstudentid")==null)
								out.print("<td><input type=checkbox name=scholarshipallocation value='"+hashmap1.get("scholarshipamountallocationid")+"'><input type=hidden name='termfeesid' value='"+hashmap1.get("termfeesid")+"'><input type=hidden name='amount' value='"+hashmap1.get("amount")+"'>");
								else */
								
									out.print("<td><input type=checkbox  name='descholarshipallocation' value='"+hashmap1.get("scholarshipamountallocationid")+"' position='"+serialcnt+"' determfeesid='"+hashmap1.get("termfeesid")+"' deamount='"+hashmap1.get("amount")+"'  feescollectionid='"+hashmap1.get("feescollectionid")+"'  schemeforstudentid='"+hashmap1.get("schemeforstudentid")+"' chkstate='deallocate' onclick='chksel(this)'><input type=hidden id='schemeforstudentid' name='schemeforstudentid'><input type=hidden id='feescollectionid' name='feescollectionid'><input type=hidden id='determfeesid' name='determfeesid'><input type=hidden id='deamount' name='deamount'><input type=hidden id='descholarshipamountallocationid' name='descholarshipamountallocationid'></tr>");
								serialcnt++;
								}
									
							}
							
							if(inc1 ==0)
							{
								out.print("<tr><td>Data Not Found</td></tr>");
							}
							%>
					</table>
					
					
										
				</td>
			</tr>
			<!-- <tr>
				<td valign="top" colspan="3">
					<a href="#" class="bt_green" onclick="cancelSelection()"><span class="bt_green_lft"></span><strong>Cancel Selection</strong><span class="bt_green_r"></span></a>
				</td>
			</tr> -->
		</tbody>
	</table>
	<%
	if(inc1 >0){%>
	<a href="#"  onclick="backfun()" class="bt_blue"><span
		class="bt_blue_lft"></span><strong><%=bundle.getString("button.studentextracurricularprofileupdate.Back")%></strong><span
		class="bt_blue_r"></span></a>
	 <a href="#" class="bt_green"
		onclick="deallocatfun()"><span class="bt_green_lft"></span><strong>De Allocate</strong><span
		class="bt_green_r"></span></a>
		<%}%>
		
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