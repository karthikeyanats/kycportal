<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%= bundle.getString("label.staffpromotionpreview.title")%>| Powered by i-Grandee</title>
<script language="javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript">
function backfun()
{
document.f1.action= "./Staff_Promotion_View.jsp";
document.f1.submit();
}
function promotionsubmit()
{
var Status="";
var Stafftype="";

for(var i=0;i<document.f1.Promotion.length;i++)
{
if(document.f1.Promotion[i].checked)
Status=document.f1.Promotion[i].value;
}
for(var i=0;i<document.f1.user_post.length;i++)
{
if(document.f1.user_post[i].checked)
Stafftype=document.f1.user_post[i].getAttribute("categoryname");
}
if(Stafftype.toLowerCase()=="headmaster")
{
	if(parseInt(document.f1.staffcheck.value)>0)
	{
		alert("HeadMaster Already Assigned For this School, so you can not promote.");
		return false;
	}
}
if(check_ForParticularElements(document.f1.user_department,"select",document.f1.user_role,"select"))
{
var fieldname="";
if(Status=="DP")
{
fieldname="DePromote"
}
else if(Status=="P")
{
fieldname="Promote"
}
if(confirm("Are You Sure You Want to "+fieldname+" the Staff...? "))
{
document.f1.action= "./Staffpromotionsubmit.jsp";
document.f1.submit();
}
}
}
function win(obj)
{
var attachment=obj.getAttribute("atta");
window.open("<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2="+attachment+"","Msg","top=250,left=350,help:no,center:no,status:no,width=500,height=300,scrollbars=1;")
}
</script>

<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/niceforms.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="<%=request.getContextPath()%>/jsp/kycpanel/niceforms-default.css" />

</head>
<body>
<div id="main_container">

	<div class="header">
<%@ include file="../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<%@ include file="../include/header.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%= bundle.getString("label.staffpromotionpreview.rootpath")%></h2>
  <form name="f1" method="post" action="" >
 <%@ page import="java.util.*"%>

<%@ page import="com.iGrandee.Registration.StaffRegistrationQuery"%>

<%
	String date_str="";
	ArrayList deptList = null;
	ArrayList roleList = null;

	StaffRegistrationQuery staffquery=new StaffRegistrationQuery();
	String userid=null;
	String instituid=null;
	String Staffid=null;
	String departid=null;
	String roleid=null;
	String Status=null;
	String Staffname=null;

	userid=(String)session.getValue("userid");
	instituid=(String)session.getValue("instituteid");

	if(userid!=null)
	{
	try
	{

			//schedule_query_bean.getInstituteInfo();

		deptList =staffquery.departmentload(instituid);
		//out.println("SSSSS deptList"+deptList);
		roleList = staffquery.roleload(instituid);
		
		departid=request.getParameter("departmentid")+"";
		Staffid=request.getParameter("Staffid")+"";
		roleid=request.getParameter("roleid")+"";
		Status=request.getParameter("status")+"";
		Staffname=request.getParameter("Staffname")+"";

			//out.println("Staffid===>>>"+Staffid);
			
	}//SELECT * FROM subjectallotment a,subjectschedule b,subject c,standard d,sectionschedule e,section f where a.subjectscheduleid =b.subjectscheduleid and b.subjectid =c.subjectid and c.standardid =d.standardid  and a.sectionpublishid=e.sectionscheduleid and  e.sectionid=f.sectionid and a.staffid='1';
	
	
	catch(NullPointerException e){}
%>
<%
	//personal
	String name="-";
	String fname="-";
	String mname="-";
	String lname="-";
	String age="-";
	String dob="-";
	String gender="-";
	String m_status="-";
	String photo="-";

	//contact
	String communicationstreet1 ="";
	String communicationstreet2 ="";

	String communicationstate="-";
	String communicationcountry="-";
	String communicationcity="-";
	String communicationpin="-";
	String permanentstreet1="-";
	String permanentstreet2="-";
	String permanentstate="-";
	String permanentcountry="-";
	String permanentcity="-";
	String permanentpin="-";

	String mail_id="-";
	
	//job
	String department="-";
	String occupation="-";
	String landline="-";
	String mobile="-";
	String email="-";

	ArrayList p_list=staffquery.staffprofiledetail(Staffid);
	ArrayList c_list=staffquery.staffaddressprofiledetail(Staffid);

	
	ArrayList q_list=staffquery.staffqualificationdetail(Staffid);
	

  	ArrayList d_list=staffquery.staffjobdetails(Staffid);

  	ArrayList extra_list=staffquery.staffExtradetails(Staffid);
  	
  	ArrayList experi_list=staffquery.staffexperiencedetails(Staffid);
  	ArrayList stafflog_list=staffquery.stafflogviewload(Staffid);
  	ArrayList jobList = staffquery.jobcategoryload(instituid);
  	ArrayList certificate_list=staffquery.StaffVerificationCertificate(Staffid);
  	ArrayList CheckStaffList=staffquery.checkstaffusercategory(userid);

  	
  	
  	

	//experiance
	String join_date="-";
	HashMap map=null;
	String area="-";
	String publication="-";
	String qualification="-";
	String staffcategoryid="-";
	String staffuserid="-";

	
	if(extra_list!=null && extra_list.size()>0)
	{
		map=(HashMap)extra_list.get(0);
		area=(String)map.get("areaofinterest");
	 	publication=(String)map.get("publications");
	}
	if(p_list!=null && p_list.size()>0)
	{
		map=(HashMap)p_list.get(0);
		name=(String)map.get("uname");
		fname=(String)map.get("fathername");
		if(fname==null)
			fname="-";
		mname=(String)map.get("mothername");
		if(mname==null)
			mname="-";
 		age=(String)map.get("age");
 		if(age==null)
 			age="-";
		dob=(String)map.get("dob");
		/*if(dob!=null)
		{
			String[] str_dob=dob.split("-");
			dob=str_dob[1]+"-"+str_dob[0]+"-"+str_dob[2];
		}*/

		gender=(String)map.get("sex");
			//out.println(gender);
		m_status=(String)map.get("maritalstatus");
		if(m_status==null)
			m_status="-";
		 landline=(String)map.get("landlinenumber");
			if(landline==null)
				landline="-";
		 mobile=(String)map.get("mobilenumber");
		 photo=(String)map.get("imagepath");
			//System.out.println("================photo====>"+photo);
		 email=(String)map.get("emailid");
		 qualification=(String)map.get("qualification");
		}
	if(c_list!=null && c_list.size()>0)
	{
		map=(HashMap)c_list.get(0);
		communicationstreet1=(String)map.get("communicationstreet1");
		communicationstreet2=(String)map.get("communicationstreet2");
		communicationcity=(String)map.get("communicationcity");
		communicationstate=(String)map.get("communicationstate");
		communicationcountry=(String)map.get("communicationcountry");
		communicationpin=(String)map.get("communicationpin");
		permanentstreet1=(String)map.get("permanentstreet1");
		permanentstreet2=(String)map.get("permanentstreet2");
		permanentcity=(String)map.get("permanentcity");
		permanentstate=(String)map.get("permanentstate");
		permanentcountry=(String)map.get("permanentcountry");
		permanentcountry=(String)map.get("permanentpin");
	}

	if( d_list.size()>0)
	{
		map=(HashMap)d_list.get(0);
		staffuserid=(String)map.get("userid");
		occupation=(String)map.get("rolename");
	    join_date=(String)map.get("dateofjoin");
	    department=(String)map.get("departmentname");
	    staffcategoryid=(String)map.get("staffcategoryid");

	    
	}
		
%>
	
<form name="f1" method="post" action="" >
<input type="hidden" name="Staffid" value="<%=Staffid%>"/>
<input type="hidden" name="Staffuserid" value="<%=staffuserid%>"/>

<input type="hidden" name="roleid" value="<%=roleid%>"/>
<input type="hidden" name="status" value="<%=Status%>"/>
<input type="hidden" name="departmentid" value="<%=departid%>"/>
<input type="hidden" name="staffcheck" value="<%=CheckStaffList.size()%>"/>


 <TABLE border=0 class="tablecolor" cellspacing=0 width=100% align=center height=485 cellpadding=0>
  <TR valign="top" style="height:190">
      <TD>
      <table id="rounded-corner" border=0 summary="Department List" width="100%">
    	<thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="100%"><%= bundle.getString("label.staffpromotionpreview.StaffPromotion")%></th>
            <th scope="col" class="rounded-q4" width="1%"></th>
            
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
					<td width="100%" colspan=2>
							<table width="100%" border=0 bgcolor="#ffffff"   cellspacing=0 cellpadding=0>
								<tr style="height:25">
									<td class="tablebold" style="width:15%">
										<%= bundle.getString("label.staffpromotionpreview.Department")%> 
									</td>
									<td valign="middle" height="40" style="width:25%"><select name="user_department" class=tablelight validate="Department" style="width:200px">
	  <option value="" selected>&nbsp;&nbsp;-- Select Department --&nbsp;&nbsp;</option>
	  <%
		try
		{
	 		HashMap deptMap = null;
	 		for(int i=0;i<deptList.size();i++) {
	 			deptMap = (HashMap)deptList.get(i);
	 			String deptid = (String)deptMap.get("departmentid");
	    		String deptname = (String)deptMap.get("departmentname");
	    		if(deptid.equals(departid))
	 		   		out.println("<option value='"+deptid+"' selected=true>"+deptname+"</option>");
	    		else
		 		   	out.println("<option value='"+deptid+"'>"+deptname+"</option>");

	 		}
		}
		catch(NullPointerException npe)
		{
			System.out.println("IGST-ERROR : in Staff_Registration.jsp in deptMap"+npe);
			npe.printStackTrace();
			}
	%>
	</select>
	</td>
									<td class="tablebold" style="width:10%">
										<%= bundle.getString("label.staffpromotionpreview.Role")%>  
									</td>
									<td valign="middle" height="40" colspan=3><select name="user_role"  style="width:200px" class=tablelight validate="Role">
	  <option value="" selected>&nbsp;&nbsp;-- Select Position --&nbsp;&nbsp;</option>
	  <%
	  try
		{
			
			HashMap roleMap = null;
			for(int i=0;i<roleList.size();i++) {
				roleMap = (HashMap)roleList.get(i);
				String roleid1 = (String)roleMap.get("roleid");
				String rolename = (String)roleMap.get("rolename");
	    		//System.out.println("======>>>>>>>>>"+roleid+"======"+roleid1+"("+roleid.equals(roleid1)+")<<<<<<========");

				if(roleid1.equals(roleid))
					out.println("<option value='"+roleid1+"' selected=true>"+rolename+"</option>");
				else
					out.println("<option value='"+roleid1+"'>"+rolename+"</option>");

	 		}
		}
		catch(NullPointerException npe)
		{
			//System.out.println("IGST-ERROR : in Staff_Registration.jsp in roleMap"+npe);
			npe.printStackTrace();
		}
	%>
	</select>
	</td>
								</tr>
								<tr>
							<td class=tablebold><%= bundle.getString("label.staffpromotionpreview.JobCategory")%> </td>
							<td colspan=5>
							<%
								try {
									HashMap deptMap = null;
									for (int i = 0; i < jobList.size()-1; i++) {
										deptMap = (HashMap) jobList.get(i);
										String categoryid = (String) deptMap.get("staffcategoryid");
										String categoryname = (String) deptMap.get("categoryname");
										if (staffcategoryid.equals(categoryid)) {
											out
													.println("<input type = radio name='user_post' value='"
															+ categoryid
															+ "' checked categoryname='"+categoryname+"'>"
															+ categoryname + "&nbsp;&nbsp;");
										} else {
											out
													.println("<input type = radio name='user_post' value='"
															+ categoryid
															+ "' categoryname='"+categoryname+"'>"
															+ categoryname
															+ "&nbsp;&nbsp;");

										}
									}
								} catch (NullPointerException npe) {
									System.out
											.println("IGST-ERROR : in Staff_Registration.jsp in deptMap"
													+ npe);
									npe.printStackTrace();
								}
							%>
							</td>
							</tr>
								<tr style="height:30">
								
								
							<td class=tablebold><%= bundle.getString("label.staffpromotionpreview.Action")%>
								</td>
								<td class="tablebold"  colspan=6 >
									 <input type='radio' name="Promotion" value="P" checked><%= bundle.getString("label.staffpromotionpreview.Promote")%>&nbsp;&nbsp;&nbsp;<input type='radio' name="Promotion" value="DP"><%= bundle.getString("label.staffpromotionpreview.Depromote")%>
								</td>
								</tr>
								
							</table>
					
</tbody>
</table>
		</td>
	</tr>
	<TR height=30>
      <TD class=tablebold>
      <%=name%>'s Promotion Logs
      </td>
      </tr>
      <tr  valign="top" >
      <td>
 				<table width="100%" align="center" border=0 id=rounded-corner1 bgcolor="#ffffff"  cellspacing=0 cellpadding=0>
							<tr class=tableheading height=30><td>Sl.No</td><td>RoleName</td><td>StaffDetail</td><td>DateOfModification</td></tr>
								<%
								try
								{
							 		HashMap deptMap = null;
							 		for(int i=0;i<stafflog_list.size();i++) {
							 			deptMap = (HashMap)stafflog_list.get(i);
							 			String dateofcreation = (String)deptMap.get("dateofcreation");
							    		String stafflogdetail = (String)deptMap.get("stafflogdetail");
							    		String rolename = (String)deptMap.get("rolename");
							 		   	out.println("<tr  height=30>");
								 		   out.println("<td>"+(i+1)+"</td>");

							 		   out.println("<td>"+rolename+"</td>");
							 		   out.println("<td>"+stafflogdetail+"</td>");
							 		   out.println("<td>"+dateofcreation+"</td>");

   							 		   out.println("</tr>");
							 		}
								}
								catch(NullPointerException npe)
								{
									System.out.println("IGST-ERROR : in Staff_Registration.jsp in deptMap"+npe);
									npe.printStackTrace();
								
									}
	%>
							</table>
							<br>
					</TD>
					</TR>
					
  <TR valign="top" style="height:190">
      <TD>
 		<table id="rounded-corner" border=0 summary="Department List" width="100%">
    	<thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="100%"><%= bundle.getString("label.staffpromotionpreview.subcontent")%></th>
            <th scope="col" class="rounded-q4" width="1%"></th>
            
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
					<td width="100%" colspan=2>
							<table width="100%" border=0 bgcolor="#ffffff" cellspacing=0 cellpadding=0>
								<tr style="height:25">
									<td class="tablebold" style="width:15%">
										 <%= bundle.getString("label.staffpromotionpreview.Name")%>
									</td>
									<td class="tablelight" style="width:65%" colspan="3">
										<%=name%>&nbsp;,<%=qualification %>
									</td>

									<td rowspan="6">
											<img src="<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2=<%=photo%>" name='stphoto_img1' id=stphoto_img width=120 height=130>
									
									</td>
								</tr>
								
								<tr style="height:25">
									<td class="tablebold" style="width:15%">
										<%= bundle.getString("label.staffpromotionpreview.dateofbirth")%>
									</td>
									<td class="tablelight" style="width:35%">
										<%=dob%>
									</td>

								</tr>

								<tr style="height:25">
									<td class="tablebold" style="width:15%">
										<%= bundle.getString("label.staffpromotionpreview.Age")%>
									</td>
									<td class="tablelight" style="width:35%">
										<%=age%><%= bundle.getString("label.staffpromotionpreview.Years")%> 
									</td>

								</tr>
								<tr style="height:25">
									<td class="tablebold" style="width:15%">
										<%= bundle.getString("label.staffpromotionpreview.gender")%>
									</td>
									<td class="tablelight" style="width:35%">
										<%
										if(gender.equals("M"))
											{
											out.println("Male");
											}
										else if(gender.equals("F"))
										{
											out.println("Female");
										}
										else
										{
											out.println(gender);
										}
										%>
									</td>
								</tr>
								<tr style="height:25">
									<td class="tablebold" style="width:15%">
									<%= bundle.getString("label.staffpromotionpreview.martialstatus")%>
									</td>
									<td class="tablelight" style="width:35%" colspan=5>
										<%=m_status%>
									</td>
								</tr>
								<tr style="height:25">
								<td class="tablebold" style="width:15%">
									 <%= bundle.getString("label.staffpromotionpreview.FatherName")%> 
								</td>
								<td class="tablelight" style="width:65%">
										<%=fname%>
								</td>
								</tr>
								<tr style="height:25">
									<td class="tablebold" style="width:15%">
										<%= bundle.getString("label.staffpromotionpreview.MotherName")%>
									</td>
									<td class="tablelight" colspan=4 style="width:65%">
											<%=mname%>
									</td>
								</tr>
							</table>
					</td>
				</tr>
				</tbody>
				
			</table>
			<br>

		</td>
	</tr>


	<tr valign="top">
			<td>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    	<thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="100%"><%= bundle.getString("label.staffpromotionpreview.continform")%></th>
            <th scope="col" class="rounded-q4" width="1%"></th>
            
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
					<td width="100%" colspan=2>
				<table border=0 bordercolor='#EFEFE7' align=center class=tablehead cellpadding=0 cellspacing=0 width="95%" rules="groups">
					<tr height=25>
						<td  align=left><h3 align=left><%= bundle.getString("label.staffpromotionpreview.CommunicationAddress")%></h3></td>
					</tr>
					<tr>
						<td width="100%">
								<table width="100%" border=0 bgcolor="#ffffff" cellpadding=0 cellspacing=0>

					<tr   height=25>
						<td   align=left class="tablebold"><%= bundle.getString("label.staffpromotionpreview.Street1")%></td>
						<td   align=left colspan=3><%=communicationstreet1 %></td>
					</tr>
					<tr   height=25>
						<td   align=left class="tablebold"><%= bundle.getString("label.staffpromotionpreview.Street2")%>2</td>
						<td   align=left colspan=3><%=communicationstreet2 %></td>
					</tr>

									<tr style="height:25">
										<td class="tablebold" style="width:15%">
												<%= bundle.getString("label.staffpromotionpreview.city")%>
										</td>
										<td class="tablelight" style="width:35%">
												 <%=communicationcity%>
										</td>
										<td class="tablebold" style="width:15%">
												<%= bundle.getString("label.staffpromotionpreview.state")%>
										</td>
										<td class="tablelight" style="width:35%">
												<%=communicationstate%>
										</td>
									</tr>
									<tr style="height:25">
										<td class="tablebold" style="width:15%">
												<%= bundle.getString("label.staffpromotionpreview.country")%>
										</td>
										<td class="tablelight" style="width:35%">
												<%=communicationcountry%>
										</td>
										<td class="tablebold" style="width:15%">
												<%= bundle.getString("label.staffpromotionpreview.Pin")%>
										</td>
										<td class="tablelight" style="width:35%">
												<%=communicationpin%>
										</td>
									</tr>
										<tr   height=25>
						<td   align=left colspan=4><h3><%= bundle.getString("label.staffpromotionpreview.PermanentAddress")%></h3></td>
					</tr>

									<tr   height=25>
						<td   align=left class="tablebold"><%= bundle.getString("label.staffpromotionpreview.Street1")%></td>
						<td   align=left colspan=3><%=permanentstreet1 %></td>
					</tr>
					<tr   height=25>
						<td   align=left class="tablebold"><%= bundle.getString("label.staffpromotionpreview.Street2")%></td>
						<td   align=left colspan=3><%=permanentstreet2 %></td>
					</tr>

									<tr style="height:25">
										<td class="tablebold" style="width:15%">
												<%= bundle.getString("label.staffpromotionpreview.city")%>
										</td>
										<td class="tablelight" style="width:35%">
												 <%=permanentcity%>
										</td>
										<td class="tablebold" style="width:15%">
												<%= bundle.getString("label.staffpromotionpreview.state")%>
										</td>
										<td class="tablelight" style="width:35%">
												<%=permanentstate%>
										</td>
									</tr>
									<tr style="height:25">
										<td class="tablebold" style="width:15%">
												<%= bundle.getString("label.staffpromotionpreview.country")%>
										</td>
										<td class="tablelight" style="width:35%">
												<%=permanentcountry%>
										</td>
										<td class="tablebold" style="width:15%">
												<%= bundle.getString("label.staffpromotionpreview.Pin")%>
										</td>
										<td class="tablelight" style="width:35%">
												<%=permanentpin%>
												<br><br>										</td>
									</tr>
									<tr style="height:25">
										<td class="tablebold" style="width:15%">
Mobile No										</td>
										<td class="tablelight" style="width:35%" colspan=3>
											<%=mobile%>
										</td>
										
									</tr>

									<tr style="height:25">
										<td class="tablebold" style="width:15%">
											<%= bundle.getString("label.staffpromotionpreview.landlineno")%>
										</td>
										<td class="tablelight" style="width:35%" colspan=3>
										<%=landline%>
										</td>
									
									</tr>

									<tr style="height:25">
										<td class="tablebold" style="width:15%">
											<%= bundle.getString("label.staffpromotionpreview.mailId")%>
										</td>
										<td class="tablelight" style="width:35%" colspan=3>
											<%=email%>
										</td>

									</tr>

								</table>
						</td>
					</tr>
				</table>
				</tbody>
				</table>
				<br>
			</td>
	</tr>
	<tr valign="top">
			<td>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    	<thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="100%"><%= bundle.getString("label.staffpromotionpreview.qualification")%></th>
            <th scope="col" class="rounded-q4" width="1%"></th>
            
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
					<td width="100%" colspan=2>
				<table border=0 bordercolor='#EFEFE7' align=center class=tablehead cellpadding=0 cellspacing=0 width="95%" rules="groups">
						<td width="100%">
								<table width="100%" border=0 bgcolor="#ffffff" cellpadding=0 cellspacing=0>
									<tr style="height:25">
									<td class="tablebold" style="width:5%">
											 <%= bundle.getString("label.staffpromotionpreview.SL.No")%>
										</td>
									<td class="tablebold" style="width:15%">
											<%= bundle.getString("label.staffpromotionpreview.Major")%> 
										</td>
										<td class="tablebold" style="width:15%">
											 <%= bundle.getString("label.staffpromotionpreview.University")%>
										</td>
										<td class="tablebold" style="width:35%">
											<%= bundle.getString("label.staffpromotionpreview.Program")%>
										</td>
										<td class="tablebold" style="width:15%">
											 <%= bundle.getString("label.staffpromotionpreview.Year")%>
										</td>
										<td class="tablebold" style="width:35%">
											<%= bundle.getString("label.staffpromotionpreview.%OfMarks")%> 
										</td>
									</tr>

									<%
									//out.println("q_list.size()"+q_list.size());

										if(q_list.size()>0 )
											{
												for(int i=0;i<q_list.size();i++)
												{
													map=(HashMap)q_list.get(i);
													out.println("<tr>");
													out.println("<td class='tablelight'>");
													out.println((i+1));
													out.println("</td>");
														out.println("<td class='tablelight'>");
														out.println((String)map.get("major"));
														out.println("</td>");
															out.println("<td class='tablelight'>");
																out.println((String)map.get("college"));
															out.println("</td>");
															out.println("<td class='tablelight'>");
															out.println((String)map.get("areaofqualification"));

															out.println("</td>");
															out.println("<td class='tablelight'>");
															out.println((String)map.get("yearofgraduation"));

															out.println("</td>");
															out.println("<td class='tablelight'>");
															out.println((String)map.get("precentage"));

															out.println("</td>");
														out.println("</tr>");
												}
											}
										else
										{
											out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>Data Not Found</font></td></tr>");
											//out.println("<tr><td colspan=6  align=center>Data Not Found</td></tr>");

										}
									%>
								</table>
						</td>
					</tr>
				</table>
				</tbody>
				</table>
								<br>
				
			</td>
	</tr>
	<%
if (certificate_list != null && certificate_list.size() > 0) {
%>
		<tr valign="top">
		<td>
		<table id="rounded-corner" border=0 summary="Department List"
			width="100%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="100%"><%=bundle.getString("label.staffregisteration.Certificate")%></th>
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
					<td width="100%" colspan=2>
					<table border=0 bordercolor='#EFEFE7' align=center class=tablehead
						cellpadding=0 cellspacing=0 width="95%" rules="groups">
						<tr><td width="100%">
						<table width="100%" border=0 bgcolor="#ffffff" cellpadding=0
							cellspacing=0>
							<%
										for (int i = 0; i<certificate_list.size(); i++) {
											HashMap innermap=(HashMap)certificate_list.get(i);
											out.println("<tr>");
											out.println("<td class='tablelight' width='10%' >");
											out.println((i + 1));
											out.println("</td  width='10%' >");
											out.println("<td class='tablelight'>");
											out.println(innermap.get("documentname"));
											out.println("[ <a href='#' atta='"+innermap.get("documentpath")+"' onclick=win(this)>View</a> ]");
											out.println("</td>");
											out.println("</tr>");

										}
							%>
						</table>
						</td>
						</tr>
					</table>
			</tbody>
		</table>
		<br>
		</td>
	</tr>
	<%} %>
	<tr valign="top">
			<td>
			<table id="rounded-corner" border=0 summary="Department List" width="100%">
    	<thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="100%"><%= bundle.getString("label.staffpromotionpreview.jobinform")%></th>
            <th scope="col" class="rounded-q4" width="1%"></th>
            
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
					<td width="100%" colspan=2>
				<table border=0 bordercolor='#EFEFE7' align=center class=tablehead cellpadding=0 cellspacing=0 width="95%" rules="groups">
					<tr>
						<td width="100%">
								<table width="100%" border=0 bgcolor="#ffffff" cellpadding=0 cellspacing=0>
									<tr style="height:25">
										<td class="tablebold" style="width:15%">
											<%= bundle.getString("label.staffpromotionpreview.Department")%>
										</td>
										<td class="tablelight" style="width:35%">
											 <%=department%>
										</td>
										<td class="tablebold" style="width:15%">
											 <%= bundle.getString("label.staffpromotionpreview.joiningdate")%>
										</td>
										<td class="tablelight" style="width:35%">
											 <%=join_date%>
										</td>
									</tr>
									<tr style="height:25">
											<td class="tablebold" style="width:15%">
											<%= bundle.getString("label.staffpromotionpreview.role")%>
										</td>
										<td class="tablelight" style="width:35%" colspan='3'>
											<%=occupation%>
										</td>
									</tr>
								</table>
						</td>
					</tr>
				</table>
				</tbody>
				</table>
								<br>
				
			</td>
	</tr>
	<tr valign="top">
			<td>
			<table id="rounded-corner" border=0 summary="Department List" width="100%">
    	<thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="100%">	<%= bundle.getString("label.staffpromotionpreview.ExperienceDetails")%> </th>
            <th scope="col" class="rounded-q4" width="1%"></th>
            
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
					<td width="100%" colspan=2>
				<table border=0 bordercolor='#EFEFE7' align=center class=tablehead cellpadding=0 cellspacing=0 width="95%" rules="groups">
						<tr>
						<td width="100%">
								<table width="100%" border=0 bgcolor="#ffffff" cellpadding=0 cellspacing=0 >
									<tr style="height:25">
									<td class="tablebold" style="width:15%">
											<%= bundle.getString("label.staffpromotionpreview.SL.No")%> 
										</td>
										<td class="tablebold" style="width:40%">
											<%= bundle.getString("label.staffpromotionpreview.Position")%> 
										</td>
										<td class="tablebold" style="width:45%">
											<%= bundle.getString("label.staffpromotionpreview.Period")%> 
										</td>
									</tr>
									<%
									//out.println("q_list.size()"+q_list.size());

										if(experi_list.size()>0 )
											{
												for(int i=0;i<experi_list.size();i++)
												{
												map=(HashMap)experi_list.get(i);
														out.println("<tr>");
														out.println("<td class='tablelight'>");
														out.println((i+1));
														out.println("</td>");
														out.println("<td class='tablelight'>");
														out.println((String)map.get("role"));
														out.println("</td>");
														out.println("<td class='tablelight'>");
														out.println((String)map.get("period"));
														out.println("</td>");
														out.println("</tr>");
												}
											}
										else
										{
											out.println("<tr align='center' class='tablebold'><td colspan='3'><font color='red'>Data Not Found</font></td></tr>");
											//out.println("<tr><td colspan=3 align=center>Data Not Found</td></tr>");

										}
									%>
								</table>
						</td>
					</tr>
				</table>
				</tbody>
				</table>
				<br>
			</td>
	</tr>
			<tr valign="top">
			<td>
				

						</td>
					</tr>
				</table>
				<br>
			
	<tr valign="top">
			<td>
				<table id="rounded-corner" border=0 summary="Department List" width="100%">
    	<thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="100%"><%= bundle.getString("label.staffpromotionpreview.subAreainterestAndPublication")%></th>
            <th scope="col" class="rounded-q4" width="1%"></th>
            
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
					<td width="100%" colspan=2>
				<table border=0 bordercolor='#EFEFE7' align=center class=tablehead cellpadding=0 cellspacing=0 width="95%" rules="groups">
					<tr>
						<td width="100%">
								<table width="100%" border=0 bgcolor="#ffffff"  cellpadding=0 cellspacing=0 >
									<tr style="height:30%" align="left" valign=top width="70%">
										<td class="tablebold" width='25%'>
											 <%= bundle.getString("label.staffpromotionpreview.Areaofinterest")%>
										</td>

										<td class="tablelight" style="width:35%" colspan=4>
													<%=area%>
										</td>
										</tr>
										<tr  valign=top >
										<td class="tablebold"  width='15%'>
										<%= bundle.getString("label.staffpromotionpreview.Publication")%> 
										</td>

										<td class="tablelight" style="width:35%"  colspan=4>
											 <%=publication%>
										</td>
									</tr>

									<tr style="height:25" align="left" width="70%">
										<td class="tablebold" width='15%'>
										</td>

										<td class="tablelight" style="width:35%">
									
										</td>

										<td class="tablebold" colspan="2" width='15%'>

										</td>

										<td class="tablelight" style="width:35%">
										</td>
									</tr>

								</table>
								</tbody>
								</table>
								
						</td>
					</tr>
				</table>
				 		<table border=0 bordercolor='#EFEFE7' align=center class=tablehead cellpadding=0 cellspacing=0 width="95%" rules="groups">
				
				<tr style="height:25">
									<td class="tablebold" style="width:15%" colspan=4 align="center">
									<br>
									<a href="#"  onclick="backfun()" class="bt_blue"><span
		class="bt_blue_lft"></span><strong><%= bundle.getString("button.staffpromotionpreview.Back")%></strong><span
		class="bt_blue_r"></span></a>
									<a href="#bbsb" name="Register" onclick=promotionsubmit() class="bt_green" align=center><span class="bt_green_lft"></span><strong><%= bundle.getString("button.staffpromotionpreview.Promote")%></strong><span class="bt_green_r"></span></a>
									</td>
								</tr>
								</table>
<%} %>
</form>

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>