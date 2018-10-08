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

	<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
	<SCRIPT language="JavaScript" src='<%=request.getContextPath()%>/js/Calendar/Calendar.js'></SCRIPT>
	
<script type="text/javascript">
function backfun()
{
document.applicationform.action="./Studentprofileview.jsp";
document.applicationform.submit();
}
	
function updatefun()
{
	if(check_ForParticularElements(document.applicationform.guardianname,"text",document.applicationform.guardianmailid,"text",document.applicationform.relation,"text",document.applicationform.organization,"text",document.applicationform.annualincome,"text",document.applicationform.position,"text",document.applicationform.physicalmarks,"text"))
	{

		if(!email_Validation(document.applicationform.guardianmailid,"Guardian E-Mail",true))
		{
			return false;
		}
				
		if(confirm("Do You Want to Update the Parent Guardian Profile ...?"))
				{
			
				document.applicationform.action="./parentguardianprofileupdatesubmit.jsp";
				document.applicationform.submit();
				}
	}
}
function address_Validation(fields,fieldName)
{
   flag=true;
   field=fields.value;
     var num=parseInt(field.length);
     if(num==0)
     {

       flag=false;

     }
     //to check the starting char is not a special character
     else
     {           startVal=field.charAt(0);
		  }//end of else
     return flag;
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

<%-- <h2><%=bundle.getString("label.studentparentprofileupdate.rootpath") %></h2> --%>

<table width=100%><tr><td width=80% align=left><h2><%=bundle.getString("label.studentparentprofileupdate.rootpath") %></h2></td><td align=right><a class=tablebold><font color=red>*</font>&nbsp;<font color=#000000><%=bundle.getString("label.studentprofileentry.Mandatory")%></font> </a></td></tr></table>

<%@ page
	import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Registration.StudentRegistrationQuery"%>

<%
	String date_str = "";
	StudentRegistrationQuery studentquery = new StudentRegistrationQuery(); 
	StudentRegistrationQuery Staffquery = new StudentRegistrationQuery();
	String studentguardianid = null;
	String guardianname = null;
	String guardianmailid = null;
	String relation = null;
	String self = null;
	String nameoforganization = null;
	String annualincome = null;
	String position = null;
	String createdby = null;

	String dateofcreation = null;
	String ipaddress = null;
	String studentguardianstatus = null;

	String physicallyfit =  null;
	String exserviceman =  null;
	String physicalmark =  null;
	String candidateregisterid = null;
		
	String userid = request.getParameter("personid");
	
	String instituteid = null;
	ArrayList extracurricular = null;
	String personid= "";
	try {
		instituteid = (String) session.getValue("instituteid");
 		ArrayList contact_list = studentquery.parentguardianprofileupdate(userid);
 		
 		System.out.println(contact_list);
 		
		HashMap map = null;
 		
		if (contact_list != null && contact_list.size() > 0) {
 			map = (HashMap) contact_list.get(0);
 			studentguardianid = (String) map.get("studentguardianid");
 			candidateregisterid = (String) map.get("candidateregisterid");
 			guardianname = (String) map	.get("guardianname");
 			if(map.get("guardianmailid")== null)
 				guardianmailid = "-";
 			else
 				guardianmailid = (String)map.get("guardianmailid");
 			
 			personid= (String) map	.get("personid");
 			
 			relation = (String) map.get("relation");
 			self = (String) map.get("self");
 			nameoforganization = (String) map	.get("nameoforganization");
 			annualincome = (String) map.get("annualincome");
 			position = (String) map.get("position");
 			createdby = (String) map.get("createdby");

 			dateofcreation = (String) map.get("dateofcreation");
 			ipaddress = (String) map.get("ipaddress");
 			studentguardianstatus = (String) map.get("studentguardianstatus");
 			physicallyfit = (String) map.get("physicallyfit");
 			exserviceman = (String) map.get("exserviceman");
 			physicalmark = (String) map.get("physicalmark");
 			
 			
 		}
		extracurricular 		= Staffquery.loadExtrcurricular(userid);
		guardianname = guardianname.replaceAll("\"","&#39");
		guardianname = guardianname.replaceAll("\'","&#34");
		
		nameoforganization = nameoforganization.replaceAll("\"","&#39");
		nameoforganization = nameoforganization.replaceAll("\'","&#34");
		
		relation = relation.replaceAll("\"","&#39");
		relation= relation.replaceAll("\'","&#34");
		
		position = position.replaceAll("\"","&#39");
		position= position.replaceAll("\'","&#34");
		

	} catch (Exception e) {
	}
%>

	<form name="applicationform" method="post" action=""><%@ page
		import="java.util.*"%> 

	
<input type="hidden" name="personid" value="<%=userid%>"/>

<input type="hidden" name="studentguardianid" value="<%=studentguardianid%>"/>
<input type="hidden" name="candidateregisterid" value="<%=candidateregisterid%>"/>

<input type="hidden" name="personid" value="<%=personid%>"/>

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
 	<table id="rounded-corner" border=0 
		width="100%">
		<thead>
			<tr>
				<th scope="col" class="rounded-company" width="100%" colspan=2><%=bundle.getString("label.studentparentprofileupdate.StudentParent/GuardianDetailsUpdate")%></th>
				<th scope="col" class="rounded-q4" width="5"></th>
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
						<td align=center colspan=3 >
						<table border="0" width="100%" bordercolor="#EEEEEE"	cellpadding="10" cellspacing="0" align=left rules=groups>
						<tr>
							<td class=tablebold colspan=3 align=left ><%=bundle.getString("label.studentparentprofileupdate.Parent/GuardiansupportingyourEducation(ifguardian,staterelationship)")%></td>
						</tr>
						<tr>
							<td class=tablebold  align=left ><%=bundle.getString("label.studentparentprofileupdate.Parent/GuardianName")%>&nbsp;<font
							color=red>*</font></td>
							<td  align=left ><input type="text"
							class="labeltextbox" class="labelfont" maxlength="40" validate="Guardian Name"
							name="guardianname" size="50%" value="<%=guardianname %>"
							onblur="address_Validation(this,this.name)"></td>
						</tr>
							<tr>
							<td class=tablebold  align=left ><%=bundle.getString("label.studentparentprofileupdate.Parent/GuardianMail")%>&nbsp;<font
							color=red>*</font></td>
							<td  align=left ><input type="text"
							class="labeltextbox" class="labelfont" maxlength="40" validate="Guardian E-Mail"
							name="guardianmailid" size="30%" value="<%=guardianmailid %>"></td>
						</tr>
						<tr>
							<td class=tablebold align=left ><%=bundle.getString("label.studentparentprofileupdate.Relation")%>  &nbsp;<font
							color=red>*</font></td>
							<td align=left >
							<input type="text" class="labeltextbox"  validate="Relation"
							class="labelfont" maxlength="40" name="relation" value="<%=relation %>"
							onblur="address_Validation(this,this.name)">
							</td>
						</tr>
						<tr>
							<td class=tablebold align=left ><%=bundle.getString("label.studentparentprofileupdate.WhetherSelfEmployed")%>  </td><td align=left >
						
							<%
							
							if(self.equals("No"))
							{%>
								Yes <input type="radio" name="selfemployed"  validate="Self Employed" value="Yes" />
								No <input type="radio"  name="selfemployed"   validate="Self Employed" checked value="No" />
							<% }else if(self.equals("Yes"))
							{%>
							Yes<input type="radio" name="selfemployed"  validate="Self Employed" checked value="Yes"/>
								No<input type="radio"  name="selfemployed"  validate="Self Employed" value="No" />
							<% }%>
							</td>
						</tr>
						<tr>
							<td class=tablebold align=left ><%=bundle.getString("label.studentparentprofileupdate.NameOforganization")%>  &nbsp;<font
							color=red>*</font></td>
							<td align=left >
							<input type="text"
							class="labeltextbox" maxlength="50" class="labelfont"   validate="Organization"
							id="organization" name="organization" 
							size="50%"
							onblur="address_Validation(this,this.name)" value="<%=nameoforganization %>"/>
							</td>
						</tr>
						<tr>
							<td class=tablebold align=left ><%=bundle.getString("label.studentparentprofileupdate.AnnualIncomeRs")%>  &nbsp;<font
							color=red>*</font></td>
							
							<td align=left >
							<input type="text" class="labeltextbox"
							class="labelfont" name="annualincome" validate="Annual Income" value="<%=annualincome %>" maxlength="20" size="30%"
							onkeypress="numcheck()">
							</td>
						</tr>
						<tr>
							<td class=tablebold align=left ><%=bundle.getString("label.studentparentprofileupdate.Position")%>   &nbsp;<font
							color=red>*</font></td>
							<td align=left >
							<input type="text" class="labeltextbox"
							class="labelfont" name="position" maxlength="30" size="30%" validate="Position"
							onblur="address_Validation(this,this.name)" value="<%=position %>">
							
							
							</td>
						</tr>
						</table>
						
						
				</td>
			</tr>
		</tbody>
	</table>
	<br>
						<table id="rounded-corner" border=0 
		width="100%">
		<thead>
			<tr>
				<th scope="col" class="rounded-company" colspan=2 width="100%">Additional Information</th>
				<th scope="col" class="rounded-q4" width="5"></th>
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
							<td class=tablebold align=left ><%=bundle.getString("label.studentparentprofileupdate.AreYouPhysicallyChallenged")%>   </td>
							<td align=left >
							<% if(physicallyfit.equals("No"))
							{%>
								Yes<input type="radio" name="physicallyfit" value="Yes"/>
								No<input type="radio"  name="physicallyfit" checked value="No"/>
							<% }else if(physicallyfit.equals("Yes"))
							{%>
						Yes	<input type="radio"  name="physicallyfit" checked value="Yes"/>
								No<input type="radio"  name="physicallyfit" value="No"/>
							<% }%>
							</td>
						</tr>
						<tr><td></td>
							<td class=tablebold align=left ><%=bundle.getString("label.studentparentprofileupdate.Son/DaughterofEx-Serviceman")%>    </td>
							<td align=left >
							
							<% if(exserviceman.equals("No"))
							{%>
								Yes<input type="radio" name="exserviceman" value="Yes"/>
								No<input type="radio" checked name="exserviceman" value="No"/>
							<% }else if(exserviceman.equals("Yes"))
							{%>
							Yes<input type="radio" checked name="exserviceman" value="Yes"/>
								No<input type="radio"  name="exserviceman" value="No"/>
							<% }%>
							
							</td>
						</tr>
						<tr><td></td>
							<td class=tablebold valign=top align=left ><%=bundle.getString("label.studentparentprofileupdate.Personalphysicalmarksofidentificationasperyourschoolrecords")%>    &nbsp;<font
							color=red>*</font></td>
							
							<td align=left >
							<textarea class="labelfont"  validate="Physical Marks"
							name="physicalmarks" onblur="address_Validation1(this,this.name)"
							rows=3 cols=50 class=tablelight
							onkeydown="textCounter(document.applicationform.physicalmarks,document.applicationform.reminLen2,100)"
							onkeypress="textCounter(document.applicationform.physicalmarks,document.applicationform.reminLen2,100)"><%=physicalmark %></textarea>
							<br><input readonly type="text" name="reminLen2" size="3" maxlength="3" value="100"/><font color="red">characters left</font>
							</td>
						</tr>
												
						
					</table>
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
	<a href="#"  onclick="backfun()" class="bt_blue"><span
		class="bt_blue_lft"></span><strong><%=bundle.getString("button.studentparentprofileupdate.Back")%></strong><span
		class="bt_blue_r"></span></a>
	 <a href="#" class="bt_green"
		onclick="updatefun()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.studentparentprofileupdate.Update")%></strong><span
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