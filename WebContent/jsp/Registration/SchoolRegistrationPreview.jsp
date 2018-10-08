<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>	
<HTML>
<LINK rel=stylesheet href="../css/vlearn_sty.css">
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META NAME="Generator" CONTENT="NetObjects Fusion 4.0 Trial for Windows">
<LINK rel=stylesheet href="<%=request.getContextPath() %>/css/kyccss.css">
<link rel="stylesheet" type="text/css" href="../kycpanel/style.css" />

<script language="JavaScript">
function editfun()
	{
				window.history.go(-1);
		
	}
function submission()
	{
		if(confirm("Are you Sure want to Register the School...?"))
				{
					document.getElementById("subbut").style.visibility="hidden";
					document.University.action="./SchoolRegistrationSubmit.jsp";
					document.University.submit();
				}
	}
	function backfun()
	{
				window.history.go(-1);
	}
</script>
</HEAD>
<BODY  LINK="#0000FF" VLINK="#800080" TEXT="#000000" TOPMARGIN=0 LEFTMARGIN=0 MARGINwidth=0 MARGINheight=0 >
<div id="main_container">

	<div class="header">
   
    </div>

    <div class="main_content">



    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content"><%@ page import="com.iGrandee.Registration.InstitutionUpload,java.util.HashMap" %>

<%
String photo1="";
String photo2="";
InstitutionUpload institutedetails = new InstitutionUpload(request);
HashMap photopath=institutedetails.startProcess();
if(photopath.size()>0)
{
 photo1=photopath.get("institution")+"";
 photo2=photopath.get("user")+"";
}
String txt_school_name 				= institutedetails.getParameter("txt_school_name");
String txt_street1    				= institutedetails.getParameter("txt_street1");
String txt_street2  				= institutedetails.getParameter("txt_street2");
String txt_city 					= institutedetails.getParameter("txt_city");
String slt_country   				= institutedetails.getParameter("slt_country");
String slt_state     				= institutedetails.getParameter("slt_state");
String txt_zip       				= institutedetails.getParameter("txt_zip");
String txt_contact   				= institutedetails.getParameter("txt_contact");
String txt_mail     				= institutedetails.getParameter("txt_mail");
String txt_web       				= institutedetails.getParameter("txt_web")+"";
if(txt_web.equals("") ||txt_web.equals("null"))
	txt_web="-";
String txt_fname      				= institutedetails.getParameter("txt_fname");
String txt_mname      				= institutedetails.getParameter("txt_mname");
String txt_lname      				= institutedetails.getParameter("txt_lname");
String slt_prefix      				= institutedetails.getParameter("slt_prefix");
String txt_street_admin    			= institutedetails.getParameter("txt_street_admin");
String txt_city_admin      			= institutedetails.getParameter("txt_city_admin");
String slt_country_admin   			= institutedetails.getParameter("slt_country_admin");
String slt_state_admin     			= institutedetails.getParameter("slt_state_admin");
String txt_zip_admin       			= institutedetails.getParameter("txt_zip_admin");
String txt_contact_admin   			= institutedetails.getParameter("txt_contact_admin");
String txt_mail_admin     			= institutedetails.getParameter("txt_mail_admin");
String txt_dob         				= institutedetails.getParameter("txt_dob");
String slt_sex         				= institutedetails.getParameter("slt_sex");
String txt_qualification       	 	= institutedetails.getParameter("txt_qualification");
String txt_username       			= institutedetails.getParameter("txt_username");
String txt_passward    				= institutedetails.getParameter("txt_passward");
String slt_hint        				= institutedetails.getParameter("slt_hint");
String txt_answer      				= institutedetails.getParameter("txt_answer");
String txt_mobile_admin      		= institutedetails.getParameter("txt_mobile_admin");
String txt_mobile      				= institutedetails.getParameter("txt_mobile");
String txt_fax      				= institutedetails.getParameter("txt_fax");
String institutionmode				= institutedetails.getParameter("institutionmode")+"";
String age      				= institutedetails.getParameter("age");
String currencytype				= "-";//institutedetails.getParameter("currencytype");
%>
<div id=loading style="position:absolute"></div>
	<TABLE align=center width=781  height=100%  cellspacing=0 cellpadding=0 >
	<!--  BODY CONTENT TABLE  START  -->
        <TABLE  align=center width=100% height=95%  cellspacing=0 cellpadding=8>
        <TR><TH class=tableBody_BG height=45 align=left valign=bottom>
       <%
       if(!photo1.equals("storage not connected"))
       {
    	   if(institutionmode.equals("MA"))
    	   {%> 
        <font class=tableBody>Master Admin Registration Preview</font>
        <%}
       else
       {%>
               <font class=tableBody>School Registration Preview</font>
       <%} %>
        </TH></TR>
        <TR><TD valign=top><br>
<form name="University" method="post" enctype="multipart/form-data">
<TABLE border=0 cellspacing=0 width=100% align=center height=485 cellpadding=0>
  <TR valign="TOP" style="height:190">
      <TD>
     
 		<table border=0 bordercolor='#EFEFE7' align=center class=tablehead cellpadding=0 cellspacing=0 width="95%" rules="groups">
				<tr>
					<td width="100%" >
					<fieldset >
					<%if(institutionmode.equals("MA"))
			    	   {%> 
			        <legend class="heading1"><%=bundle.getString("label.schoolregistrationpreview.MasterAdminInformation")%></legend>
			        <%}
			       else
			       {%>
					<legend class="heading1"><%=bundle.getString("label.schoolregistrationpreview.SchoolInformation")%></legend>
					<%} %>
					
					<br >
							<table width="100%" border=0 bgcolor="#ffffff"  cellspacing="0" cellpadding=6>
								<tr style="height:25">
									<td class="tablebold" width="20%">
										 <%=bundle.getString("label.schoolregistrationpreview.NameofSchool")%> :
									</td>
									<td class="tablelight" width="60%" colspan="3">
										<%=txt_school_name%><input type="hidden" size="50" name="txt_school_name"  value="<%=txt_school_name.replaceAll("'","&#180;")%>">
									</td>
									<td class="tablebold" width="20%" rowspan=6 align="center">
											<img src="<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2=<%=photo1%>" width='120' height='130' border='0'/>
									</td>
								</tr>
								<tr style="height:25">
									<td class="tablebold">
										 <%=bundle.getString("label.schoolregistrationpreview.Street")%> :
									</td>
									<td class="tablelight" >
										<%=txt_street1%><input type="hidden" size="50" name="txt_street1"  value="<%=txt_street2%>">
									</td>
									<td class="tablebold">
										<%=bundle.getString("label.schoolregistrationpreview.City")%> :
									</td>
									<td class="tablelight" >
										<%=txt_city%><input type="hidden" size="50" name="txt_city"  value="<%=txt_city%>">
									</td>
								</tr>
								<tr style="height:25">
									<td class="tablebold">
										 <%=bundle.getString("label.schoolregistrationpreview.Country")%> :
									</td>
									<td class="tablelight">
										<%=slt_country%><input type="hidden" size="50" name="slt_country"  value="<%=slt_country%>">
 									</td>
									<td class="tablebold">
										<%=bundle.getString("label.schoolregistrationpreview.State")%> :
									</td>
									<td class="tablelight">
										<table id="univ_state_tab">
											<tr>
												<td>
													<%=slt_state%><input type="hidden" size="50" maxlength=40 name="slt_state"  value="<%=slt_state%>">
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr style="height:25">
									<td class="tablebold" >
										 <%=bundle.getString("label.schoolregistrationpreview.Zipcode")%> :
									</td>
									<td class="tablelight">
									<%= txt_zip%><input type="hidden" size="50" name="txt_zip"  value="<%=txt_zip%>">
									</td>
									<td class="tablebold" >
										<%=bundle.getString("label.schoolregistrationpreview.ContactNo")%> :
									</td>
									<td class="tablelight">
									<%=txt_contact%><input type="hidden" size="50" name="txt_contact"  value="<%=txt_contact%>">
									</td>


								</tr>
								<tr style="height:25">
									<td class="tablebold" >
										 <%=bundle.getString("label.schoolregistrationpreview.Email")%> :
									</td>
									<td class="tablelight" >
										<a href="mailto:<%=txt_mail%>" ><%=txt_mail%></a><input type="hidden" size="50" name="txt_mail"  value="<%=txt_mail%>">
									</td>
									<td class="tablebold">
										<%=bundle.getString("label.schoolregistrationpreview.Web")%> :
									</td>
									<td class="tablelight" >
										<%=txt_web%><input type="hidden" size="50" name="txt_web"  value="<%=txt_web%>">
									</td>


								</tr>
								<tr style="height:25">
									<td class="tablebold" >
										 <%=bundle.getString("label.schoolregistrationpreview.Mobile")%> :
									</td>
									<td class="tablelight" >
										<%=txt_mobile%><input type="hidden" size="50" name="txt_mobile"  value="<%=txt_mobile%>">
									</td>
									<td class="tablebold">
										<%=bundle.getString("label.schoolregistrationpreview.Fax")%> :
									</td>
									<td class="tablelight" >
										<%=txt_fax%><input type="hidden" size="50" name="txt_fax"  value="<%=txt_fax%>">
									</td>


								</tr>
								<!-- <tr style="height:25">
									<td class="tablebold" >
										 Currency Type:
									</td>
									<td class="tablelight" >
										<%=currencytype%><input type="hidden" size="50" name="currencytype"  value="<%=currencytype%>">
									</td>
									<td class="tablebold">
										
									</td>
									<td class="tablelight" >
									</td>
								</tr> -->
							</table>
												</fieldset>
							

					</td>
				</tr>
				<tr   height=10 bgcolor="#ffffff">
									<td><br></td>
				</tr>
				<tr   height=10 bgcolor="#ffffff">
					<td><br></td>
				</tr>
				<tr >
					<td width="100%">
					<fieldset >
					<legend class="heading1"><%=bundle.getString("label.schoolregistrationpreview.AdminInformation")%></legend>
					<br >
						<table width="100%" border=0 bgcolor="#ffffff"  cellspacing="0" cellpadding=6>
							<tr   height=10 bgcolor="#ffffff">
								<td class="tablebold">
									<font color="red"><%=bundle.getString("label.schoolregistrationpreview.Personal")%></font>
								</td>
							</tr>

 							<tr style="height:25">
								<td class="tablebold" style="width:20%">
								<%=bundle.getString("label.schoolregistrationpreview.Prefix")%> :
								</td>
								<td class="tablelight" style="width:10%" colspan="4">
									<%=slt_prefix%><input type="hidden" size="50" name="slt_prefix"  value="<%=slt_prefix%>">
								</td>
							</tr>
 							<tr style="height:25"  >
								<td class="tablebold"  width="20%">
									 <%=bundle.getString("label.schoolregistrationpreview.Firstname")%> :
									</td><td class="tablelight" width="5%">
									<%=txt_fname%><input type="hidden" size="50" name="txt_fname"  value="<%=txt_fname%>">
								   								     </td><td class="tablebold" width="5%">
									<%=bundle.getString("label.schoolregistrationpreview.Middle")%> :
							 				 </td><td class="tablelight" width="15%">
									<%=txt_mname%><input type="hidden" size="50" name="txt_mname"  value="<%=txt_mname%>">
								 	</td><td  class="tablelight">
									<font class="tablebold"><%=bundle.getString("label.schoolregistrationpreview.Last")%> :</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								 	 	<%=txt_lname%><input  type="hidden" size="50" name="txt_lname"  value="<%=txt_lname%>">
								</td>
								
							</tr>
							<tr style="height:25">
									<td class="tablebold" >
										 <%=bundle.getString("label.schoolregistrationpreview.DateOfBirth")%> :  
									</td>
									<td class="tablelight" width="15%">
										<%=txt_dob%><input type="hidden" size="50" name="txt_dob"  value="<%=txt_dob%>">
									</td>
									<td class="tablebold" >
										<%=bundle.getString("label.schoolregistrationpreview.Sex")%> :
									</td>
									<td class="tablelight" >
 										 <%=slt_sex%><input type="hidden" size="50" name="slt_sex"  value="<%=slt_sex%>">

									</td>
									<td class="tablebold" style="width:34%" rowspan=4 align="center">
												<img id="img_photo" src="<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2=<%=photo2%>" width=120 height=130></img>
									</td>
								</tr>
								<tr style="height:25">
									<td class="tablebold" style="width:20%">
										 <%=bundle.getString("label.schoolregistrationpreview.Age")%> :
									</td>
									<td colspan="4">
									<%=age%><input type="hidden" size="50" name="age"  value="<%=age%>">
									</td>
										</tr>
								<tr style="height:25">
									<td class="tablebold" style="width:20%">
										 <%=bundle.getString("label.schoolregistrationpreview.Qualification")%> :
									</td>
									<td colspan="4">
									<%=txt_qualification%><input type="hidden" size="50" name="txt_qualification"  value="<%=txt_qualification%>">
									</td>
									
									
											
								</tr>
								<tr   height=10 bgcolor="#ffffff">
									<td class="tablebold">
										<font color="red"><%=bundle.getString("label.schoolregistrationpreview.Contact")%></font>
									</td>
								</tr>
								<tr style="height:25">
									<td class="tablebold" width="15%" >
									<%=bundle.getString("label.schoolregistrationpreview.Street1")%> :
									</td>
									<td class="tablelight"  colspan="4">
										<%=txt_street2%><input type="hidden" size="50" name="txt_street2"  value="<%=txt_street2%>">
									</td>
								</tr>
								<tr style="height:25">
									<td class="tablebold" width="20%">
										 <%=bundle.getString("label.schoolregistrationpreview.Street2")%> :
									</td>
									<td class="tablelight" >
										<%=txt_street_admin%><input type="hidden" size="50" name="txt_street_admin"  value="<%=txt_street_admin%>">
									</td>
									<td class="tablebold" >
										<%=bundle.getString("label.schoolregistrationpreview.City")%> :
									</td>
									<td class="tablelight" >
										<%=txt_city_admin%><input type="hidden" size="50" name="txt_city_admin"  value="<%=txt_city_admin%>">
									</td>
								</tr>
								<tr style="height:25">
									<td class="tablebold" width="25%">
										 <%=bundle.getString("label.schoolregistrationpreview.Country")%> :
									</td>
									<td class="tablelight" width="30%">
													<%=slt_country_admin%><input type="hidden" size="50" name="slt_country_admin"  value="<%=slt_country_admin%>">
 									</td>
									<td class="tablebold" width="20%">
										<%=bundle.getString("label.schoolregistrationpreview.State")%> :
									</td>
									<td class="tablelight" width="30%" colspan=2>
											<%=slt_state_admin%><input type="hidden" size="50" name="slt_state_admin"  value="<%=slt_state_admin%>">
									</td>
								</tr>
								<tr style="height:25">
									<td class="tablebold" width="20%">
										 <%=bundle.getString("label.schoolregistrationpreview.Zipcode")%> :
									</td>
									<td class="tablelight" >
										<%=txt_zip_admin%><input type="hidden" size="50" name="txt_zip_admin"  value="<%=txt_zip_admin%>">
									</td>
									<td class="tablebold" >
										<%=bundle.getString("label.schoolregistrationpreview.ContactNo")%> :
									</td>
									<td class="tablelight" >
										<%=txt_contact_admin%><input type="hidden" size="50" name="txt_contact_admin"  value="<%=txt_contact_admin%>">
									</td>
								</tr>
								<tr style="height:25">
									<td class="tablebold" width="20%">
										 <%=bundle.getString("label.schoolregistrationpreview.Email")%> :
									</td>
									<td class="tablelight" >
										<%=txt_mail_admin%><input type="hidden" size="50" name="txt_mail_admin"  value="<%=txt_mail_admin%>">
									</td>
									<td class="tablebold" width="15%">
										 <%=bundle.getString("label.schoolregistrationpreview.MobileNo")%> :
									</td>
									<td class="tablelight" >
										<%=txt_mobile_admin %><input type="hidden" name="txt_mobile_admin" value="<%=txt_mobile_admin %>">
									</td>
									
								</tr>


						</table>
		</fieldset>
					</td>
				</tr>
				<tr   height=10 bgcolor="#ffffff">
					<td><br></td>
				</tr>
				<tr   height=25>
				</tr>
				<tr>
					<td width="100%">
					<fieldset >
					<legend class="heading1"><%=bundle.getString("label.schoolregistrationpreview.AccountInformation")%> </legend>
					<br>
					<table width="100%" border=0 bgcolor="#ffffff"  cellspacing="0" cellpadding=6>
							<tr style="height:25">
								<td class="tablebold"   width="23%">
								<%=bundle.getString("label.schoolregistrationpreview.Username")%> :
								</td>
								<td class="tablelight"    width="77%">
									<%=txt_username%><input type="hidden" size="50" name="txt_username"  value="<%=txt_username%>">
								</td>
								
							</tr>
							<tr style="height:25">
								<td class="tablebold"    width="23%">
									 <%=bundle.getString("label.schoolregistrationpreview.Password")%> :
								</td>
								<td class="tablelight"    width="77%">
									*****************<input type="hidden" size="50" name="txt_passward"  value="<%=txt_passward%>">
								</td>
								
							</tr>
							<tr style="height:25">
								<td class="tablebold"    width="23%">
									 <%=bundle.getString("label.schoolregistrationpreview.Hint")%> :
								</td>
								<td class="tablelight"    width="77%">
									  <%=slt_hint%><input type="hidden" size="50" name="slt_hint"  value="<%=slt_hint%>">
								</td>
								
							</tr>
							<tr style="height:25">
								<td class="tablebold"   width="23%">
									 <%=bundle.getString("label.schoolregistrationpreview.Answer")%> :
								</td>
								<td class="tablelight"   width="77%">
									  <%=txt_answer%><input type="hidden" size="50" name="txt_answer"  value="<%=txt_answer%>">
								</td>
							
							</tr>
						</table>
						</fieldset >
					</td>
				</tr>

			</table>
	

		</td>
	</tr>

			<tr valign="TOP">
					<td align="center">
					<br>
						<input type=button name="editbut" id="editbut" value="E D I T" class=buttontab onclick='editfun()' style="width:80;visibility:hidden"><input type=button name="subbut" id="subbut" value="<%=bundle.getString("button.schoolregistrationpreview.submit")%>" class=buttontab onclick='submission()' style=width:80>
					</td>
		</tr>
	<%
	}
      else
     {
    	  out.print("<h2>Registration Preview</h2><br>");
    	  out.print("<div class='error_box'><center>Registration Failed Due to Storage Device not connected</center></div><input type=button name='editbut'  value='Back' class=buttontab onclick='backfun()'>");
     }
      %>

</table>
	<input type=hidden name="hid_photo1" value="<%=photo1%>">
	<input type=hidden name="hid_photo2" value="<%=photo2%>">
	<input type=hidden name="institutionmode" value="<%=institutionmode%>">
	
	
</form>
</td>
</tr>
</table>

</div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
</div>

