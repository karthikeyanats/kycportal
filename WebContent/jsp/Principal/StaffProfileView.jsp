<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.staffprofile.title") %>| Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>


<script type="text/javascript">
function backfun()
{
document.f1.action= "<%=request.getContextPath()%>/jsp/Principal/StaffList.jsp";
document.f1.submit();
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

    <h2><%= bundle.getString("label.staffprofile_principal.rootpath")%></h2>  
  <form name="f1" method="post" action="" >
 <%@ page import="java.util.*"%>

<%@ page import="com.iGrandee.Registration.StaffRegistrationQuery"%>

<%
	String date_str="";
	ArrayList deptList = null;
	StaffRegistrationQuery staffquery=new StaffRegistrationQuery();
	String userid=null;
	String instituid=null;
	String Staffid=null;
	String departid=null;
	String roleid=null;
	String Status=null;
	String Staffname=null;

	userid=(String)session.getValue("userid");
	String backward =request.getParameter("backward")+"";
	if(userid!=null)
	{
	try
	{
		departid=request.getParameter("department");
		Staffid=request.getParameter("Staffid");
		deptList =staffquery.staffdetails(Staffid); 
		String instituteid="";
			
	}
	
	
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
	String categoryname="-";

	ArrayList p_list=staffquery.staffprofiledetail(Staffid);
	ArrayList c_list=staffquery.staffaddressprofiledetail(Staffid);
	ArrayList q_list=staffquery.staffqualificationdetail(Staffid);
  	ArrayList d_list=staffquery.staffjobdetails(Staffid);
  	ArrayList extra_list=staffquery.staffExtradetails(Staffid);
  	ArrayList experi_list=staffquery.staffexperiencedetails(Staffid);

  	
	//experiance
	String join_date="-";
	HashMap map=null;
	String area="";
	String publication="";
	String qualification="";
	String smsmobile="";

	
	
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
		qualification=(String)map.get("qualification");

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
		permanentpin=(String)map.get("permanentpin");
		smsmobile=(String)map.get("smscontactno");
		if(smsmobile==null)
			smsmobile="-";

	}
	if( d_list.size()>0)
	{
		map=(HashMap)d_list.get(0);
		occupation=(String)map.get("rolename");
	    join_date=(String)map.get("dateofjoin");
	    department=(String)map.get("departmentname");
	    categoryname=(String)map.get("categoryname");

	}
%>
	
<form name="f1" method="post" action="" >
<input type="hidden" name="backward" value="<%=backward%>"/>
<input type="hidden" name="Staffid" value="<%=Staffid%>"/>
<input type="hidden" name="roleid" value="<%=roleid%>"/>
<input type="hidden" name="status" value="<%=Status%>"/>
<input type="hidden" name="department" value="<%=departid%>"/>

 <TABLE border=0 class="tablecolor" cellspacing=0 width=100% align=center height=485 cellpadding=0>
  <t valign="top" style="height:190">
      <TD>
 		<table id="rounded-corner" border=0 summary="Department List" width="100%">
    	<thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="100%"><%= bundle.getString("label.staffprofile.subcontent")%></th>
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
										 <%= bundle.getString("label.staffprofile.Name")%>
									</td>
									<td class="tablelight" style="width:65%" colspan="3">
										<%=name%>&nbsp;,<%=qualification%>
									</td>

									<td rowspan="6">
											<img src="<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2=<%=photo%>" name='stphoto_img1' id=stphoto_img width=120 height=130>
									
									</td>
								</tr>
								
								<tr style="height:25">
									<td class="tablebold" style="width:15%">
										<%= bundle.getString("label.staffprofile.dateofbirth")%>
									</td>
									<td class="tablelight" style="width:35%">
										<%=dob%>
									</td>

								</tr>

								<tr style="height:25">
									<td class="tablebold" style="width:15%">
										<%= bundle.getString("label.staffdetails.Age")%>
									</td>
									<td class="tablelight" style="width:35%">
										<%=age%><%= bundle.getString("label.staffprofile.Years")%>  
									</td>

								</tr>
								<tr style="height:25">
									<td class="tablebold" style="width:15%">
										<%= bundle.getString("label.staffprofile.gender")%>
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
									<%= bundle.getString("label.staffprofile.martialstatus")%>
									</td>
									<td class="tablelight" style="width:35%" colspan=5>
										<%=m_status%>
									</td>
								</tr>
								<tr style="height:25">
								<td class="tablebold" style="width:15%">
									 <%= bundle.getString("label.staffprofile.FatherName")%> 
								</td>
								<td class="tablelight" style="width:65%">
										<%=fname%>
								</td>
								</tr>
								<tr style="height:25">
									<td class="tablebold" style="width:15%">
										<%= bundle.getString("label.staffprofile.MotherName")%>
									</td>
									<td class="tablelight" style="width:65%" colspan=4>
											<%=mname%>
									</td>
								</tr>
							</table>
					</td>
				</tr>
				</tbody>
				
			</table>
			<br>

	


	<tr valign="top">
			<td>
<table id="rounded-corner" border=0 summary="Department List"
			width="100%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="100%"><%=bundle.getString("label.staffprofile.continform")%></th>
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
				<tr height=25>
					<td align=left colspan=2>
					<h3 align=left><%= bundle.getString("label.staffprofile.CommunicationAddress")%></h3>
					</td>
				</tr>
				<tr>
				<td width="100%" colspan=2>
				<table border=0 bordercolor='#EFEFE7' align=center class=tablehead
					cellpadding=0 cellspacing=0 width="95%" >

					<tr>
						<td width="100%">
						<table width="100%" border=0 bgcolor="#ffffff" cellpadding=0
							cellspacing=0>

							<tr height=25>
								<td align=left class="tablebold"><%= bundle.getString("label.staffprofile.Street1")%></td>
								<td align=left colspan=3><%=communicationstreet1%></td>
							</tr>
							<tr height=25>
								<td align=left class="tablebold">Street 2</td>
								<td align=left colspan=3><%=communicationstreet2%></td>
							</tr>

							<tr style="height: 25">
								<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffprofile.city")%>
								</td>
								<td class="tablelight" style="width: 35%"><%=communicationcity%>
								</td>
								<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffprofile.state")%>
								</td>
								<td class="tablelight" style="width: 35%"><%=communicationstate%>
								</td>
							</tr>
							<tr style="height: 25">
								<td class="tablebold" style="width: 15%"><%=bundle
										.getString("label.staffprofile.country")%></td>
								<td class="tablelight" style="width: 35%"><%=communicationcountry%>
								</td>
								<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffdetails.Pin")%>
								</td>
								<td class="tablelight" style="width: 35%"><%=communicationpin%>
								</td>
							</tr>
							</table>
							</td>
							</tr>
							</table>
							
							<tr height=25>
								<td align=left colspan=2>
								<h3><%= bundle.getString("label.staffprofile.PermanentAddress")%></h3>
								</td>
							</tr>
							<tr>
							<td  colspan=2>
							<table border=0 bordercolor='#EFEFE7' align=center class=tablehead
						cellpadding=0 cellspacing=0 width="95%" >
							<tr height=25>
								<td align=left>
					<table border=0 bordercolor='#EFEFE7' align=center class=tablehead
					cellpadding=0 cellspacing=0 width="100%" rules="groups">							<tr height=25>
								<td align=left class="tablebold"><%= bundle.getString("label.staffprofile.Street1")%></td>
								<td align=left colspan=3><%=permanentstreet1%></td>
							</tr>
							<tr height=25>
								<td align=left class="tablebold"><%= bundle.getString("label.staffprofile.Street2")%></td>
								<td align=left colspan=3><%=permanentstreet2%></td>
							</tr>

							<tr style="height: 25">
								<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffprofile.city")%>
								</td>
								<td class="tablelight" style="width: 35%"><%=permanentcity%>
								</td>
								<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffprofile.state")%>
								</td>
								<td class="tablelight" style="width: 35%"><%=permanentstate%>
								</td>
							</tr>
							<tr style="height: 25">
								<td class="tablebold" style="width: 15%"><%=bundle
										.getString("label.staffprofile.country")%></td>
								<td class="tablelight" style="width: 35%"><%=permanentcountry%>
								</td>
								<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffdetails.Pin")%>
								</td>
								<td class="tablelight" style="width: 35%"><%=permanentpin%>
								<br>
								<br>
								</td>
							</tr>
							<tr style="height: 25">
								<td class="tablebold" style="width: 15%"><%= bundle.getString("label.staffprofile.MobileNo")%></td>
								<td class="tablelight" style="width: 35%" colspan=3><%=mobile%>
								</td>

							</tr>
							<tr style="height: 25">
								<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffprofile.smscontact") %></td>
								<td class="tablelight" style="width: 35%" colspan=3><%=smsmobile%>
								</td>
 							</tr>
							<tr style="height: 25">
								<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffprofile.landlineno")%>
								</td>
								<td class="tablelight" style="width: 35%" colspan=3><%=landline%>
								</td>

							</tr>

							<tr style="height: 25">
								<td class="tablebold" style="width: 15%">asdfdasf<%= bundle.getString("label.staffprofile.Email")%>
								</td>
								<td class="tablelight" style="width: 35%" colspan=3>
								
								<a href="mailto:<%=email%>"><%=email%></a> 
								</td>

							</tr>

						</table>
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
        	<th scope="col" class="rounded-company" width="100%"><%= bundle.getString("label.studentform.qualification")%></th>
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
											 <%= bundle.getString("label.staffprofile.SL.No")%>
										</td>
									<td class="tablebold" style="width:15%">
											 <%= bundle.getString("label.staffprofile.Major")%> 
										</td>
										<td class="tablebold" style="width:15%">
											 <%= bundle.getString("label.staffdetails.University")%>
										</td>
										<td class="tablebold" style="width:35%">
											<%= bundle.getString("label.staffdetails.Program")%>
										</td>
										<td class="tablebold" style="width:15%">
											 <%= bundle.getString("label.staffdetails.Year")%>
										</td>
										<td class="tablebold" style="width:35%">
											<%= bundle.getString("label.staffprofile.%OfMarks")%>
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
	<tr valign="top">
			<td>
			<table id="rounded-corner" border=0 summary="Department List" width="100%">
    	<thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="100%"><%= bundle.getString("label.staffprofile.jobinform")%></th>
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
											<%= bundle.getString("label.staffdetails.Department")%>
										</td>
										<td class="tablelight" style="width:35%">
											 <%=department%>
										</td>
										<td class="tablebold" style="width:15%">
											 <%= bundle.getString("label.staffdetails.joiningdate")%>
										</td>
										<td class="tablelight" style="width:35%">
											 <%=join_date%>
										</td>
									</tr>
									<tr style="height:25">
											<td class="tablebold" style="width:15%">
											<%= bundle.getString("label.staffprofile.role")%>
										</td>
										<td class="tablelight" style="width:35%" >
											<%=occupation%>
										</td>
										<td class="tablebold" style="width:15%">
											 <%= bundle.getString("label.staffdetails.jobcategory")%>
										</td>
										<td class="tablelight" style="width:35%">
											 <%=categoryname%>
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
		<%
	if (experi_list != null && experi_list.size()>0 ) 
	{
		%>
	<tr valign="top">
			<td>
			<table id="rounded-corner" border=0 summary="Department List" width="100%">
    	<thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="100%"><%= bundle.getString("label.staffprofile.ExperienceDetails")%></th>
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
											 <%= bundle.getString("label.staffprofile.SL.No")%>
										</td>
										<td class="tablebold" style="width:40%">
											 <%= bundle.getString("label.staffprofile.Position")%>
										</td>
										<td class="tablebold" style="width:45%">
											<%= bundle.getString("label.staffprofile.Period")%>
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
	<%} 	if((area!=null && !area.equals("")) || (publication!=null && !publication.equals("")) ){%>
	
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
        	<th scope="col" class="rounded-company" width="100%"><%= bundle.getString("label.staffdetails.subAreainterestAndPublication")%></th>
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
									<% if(area!=null && !area.equals("")) 
								{%>
									<tr style="height:30%" align="left" valign=top width="70%">
										<td class="tablebold" width='25%'>
											 <%= bundle.getString("label.staffdetails.Areaofinterest")%>
										</td>

										<td class="tablelight" style="width:35%"  colspan=4>
													<%=area%>
										</td>
										</tr>
										<%} if(publication!=null && !publication.equals("")) 
									{ %>
										<tr  valign=top >
										<td class="tablebold" width='15%'>
										<%= bundle.getString("label.staffprofile.Publication")%>
										</td>

										<td class="tablelight" style="width:35%"  colspan=4>
											 <%=publication%>
										</td>
									</tr>
<%} %>

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
								
								</table>
								
						</td>
					</tr>
					<%} %>
					
				</table>
												 <a href="#bbsb" name="bbsb" onclick=backfun() class="bt_blue" align=center><span class="bt_blue_lft"></span><strong><%= bundle.getString("button.staffprofile.Back")%></strong><span class="bt_blue_r"></span></a>
			
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