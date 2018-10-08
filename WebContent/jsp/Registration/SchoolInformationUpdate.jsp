<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>	
	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.profileinfo.infoupdatetitle") %> | Powered by i-Grandee</title>
<LINK rel=stylesheet href="<%=request.getContextPath()%>/css/kyccss.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
	<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script language='javascript'>

function goback()
{

document.University.action= "ProfileInfo.jsp";
			document.University.submit();

}
				 
function submission()
	{
	if(confirm("Do you want to update the School Information...?"))
{
if(document.University.photo.value!="")
{
document.University.studuserphoto.value=document.University.photo.value;
}
		 
		 if(check_ForParticularElements(document.University.txt_school_name,"text",document.University.txt_street1,"text",document.University.slt_country,"select",document.University.slt_state,"text",document.University.txt_city,"text",document.University.txt_zip,"text",document.University.txt_contact,"text",document.University.txt_mail,"text",document.University.txt_mobile,"text",document.University.txt_fax,"text"))
 		{
			if(!email_Validation(document.University.txt_mail,"Mail Id",true))
			 {
 				return false;
			 }
		/*	 if(!email_Validation(document.University.txt_mail_admin,"Mail Id",true))
			 {
				return false;
			 }
			 if(!numeric_Validation(document.University.txt_zip,"Zip Code",true))
			 {

				return false;
			 }
			 if(!numeric_Validation(document.University.txt_zip_admin,"Zip Code",true))
			 {
				
				return false;
			 }
			 
 			 if(!stringValidate(document.University.txt_fname,"First Name"))
			 {
				
				document.University.txt_fname.focus();
				return false;
			 }
			 if(!stringValidate(document.University.txt_mname,"Middle Name"))
			 {
				
				document.University.txt_mname.focus();
				return false;
			 }
			 if(!stringValidate(document.University.txt_lname,"Last Name"))
			 {
				
				document.University.txt_lname.focus();
				return false;
			 }
			 if(document.University.txt_username.value.length<3)
			 {
				 
				 alert("Username must be grater than 3 charectors");
				 return false;
			 }
			 if(document.University.txt_passward.value.length<3)
			 {
				 
				 alert("Password must be grater than 3 charectors");
				 return false;
			 }

			 if(!checkUserAndPassword(document.University.txt_username)){
				 
				 return false;
			 };
			 if(!checkUserAndPassword(document.University.txt_passward)){
				 
				 return false;
			 };
			 if(pasword!=paswordconfirm){
			 alert("Password and Confirm password Should Be Same")
				 return false;
			 };*/
			 
			  //doCompletion(document.University.txt_school_name.value,"schoolname");
			  
		var pho_val=getExtension(document.University.photo.value);
		if(pho_val!="0")
		{ 
			if((pho_val != "jpg") & (pho_val != "gif") & (pho_val != "jpeg") & (pho_val != "png"))
			{
				//alert("Please give photo file(ex:gif,jpg.....");
				alert("*.jpeg,*.jpg,*.gif,*.png Image type only allowed")
				document.University.photo.select();
				return false;
			} 
		}
		if(document.University.photo.value !="")
		{
			var pho_val=getExtension(document.University.photo.value);
			pho_val = pho_val.toLowerCase();
			//if((pho_val != "jpg") & (pho_val != "gif") & (pho_val != "jpeg"))
			if((pho_val != "jpeg") & (pho_val != "png") & (pho_val != "jpg") & (pho_val != "gif") & (pho_val != "jpeg"))
			{
			alert("*.jpeg,*.jpg,*.gif,*.png Image type only allowed")
			document.University.photo.select();
			return false;
			}
		}
			 document.University.action= "SchoolInformationSubmit.jsp";
			document.University.submit();
			
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
	function loadFirst()
	{
		if (window.XMLHttpRequest)
		xhttp=new XMLHttpRequest();
	  	else
	   		xhttp=new ActiveXObject("Microsoft.XMLHTTP");
		xhttp.open("GET","../../xml/Region.xml",false);
		xhttp.send(null);
		xmlDoc=xhttp.responseXML;
		country_fun_1();
		//country_fun_2();
	}
	
	
	
	function country_fun_1()
	{
		var obj=document.University.slt_country;
   		var country_xml = xmlDoc.getElementsByTagName("location");
 		if(country_xml[0] != null)
		{
			var states = country_xml[0].getElementsByTagName("country");
 			for(var i=0,j=1;i<states.length;i++)
			{
				var val=states[i].attributes.getNamedItem("name").nodeValue;
				
					obj.options[obj.options.length] = new Option(val,val);
					if(val==document.University.cubtry_temp.value)
					{
					obj.options[j].selected=true;
					}
				j++;
			}
		}
		state_fun('slt_state',document.getElementById('univ_state_tab'),obj)
	}
	
	
	
	var aa="";     
	function state_fun(name,dest,source)
	{
		var tmp_text=source.value;
		var country_xml = xmlDoc.getElementsByTagName("location");
		if(country_xml[0] != null)
		{
			var country = country_xml[0].getElementsByTagName("country");

			for(var i=0;i<country.length;i++)
			{

				
 				if(country[i].attributes.getNamedItem("name").nodeValue==tmp_text)
				{
					var states = country[i].getElementsByTagName("state");

					for(var i=dest.rows.length-1;i>-1;i--)
					{
					
					
				
				
						dest.deleteRow(i);
					}


					if(states.length>0)
					{
					
						var code="<select name='"+name+"'>\n";
					 
					

						for(var i=0;i<states.length;i++)
						{
							if(states[i].attributes.getNamedItem("name").nodeValue==document.University.state_temp.value)
							{
								code+="<option value='"+states[i].attributes.getNamedItem("name").nodeValue+"' selected>"+states[i].attributes.getNamedItem("name").nodeValue+"</option>\n";
							}
							else
							{
							code+="<option value='"+states[i].attributes.getNamedItem("name").nodeValue+"'>"+states[i].attributes.getNamedItem("name").nodeValue+"</option>\n";
							
							}
							
							
						}   
						code+="</select>\n";

						tBody = document.createElement("tbody");
  
							tr=document.createElement("tr");
							tr.height=30;

							tBody.appendChild(tr);

							td=document.createElement("td");
							td.className='tablelight';
							td.width=20;
							td.align='center';
							td.innerHTML=code;
							tr.appendChild(td);

							dest.appendChild(tBody);
							
					}
					else
					{
						var aa = document.University.state_temp.value
						tBody = document.createElement("tbody");

							tr=document.createElement("tr");
							tr.height=30;

							tBody.appendChild(tr);

							td=document.createElement("td");
							td.className='tablelight';
							td.width=20;  
							td.align='center';  
							td.innerHTML="<input type='text' name="+name+" value="+aa+">";
							
							tr.appendChild(td);
    
							dest.appendChild(tBody);
							   
					}   
					break;
				}
			}
		}
	}
function checkNnmerickey(e) {
var code;
if (!e) var e = window.event;
if (e.keyCode) code = e.keyCode;
else if (e.which) code = e.which;
var character = String.fromCharCode(code);
if(code!=9 && code!=46 && code!=8 && code!=43 && code!=45 && code!=118 && code!=99 && code!=44)   
{
	if(code!=44)
	{
		if (code==47||code<46||code>57)
		{
			code=0;
			alert("Enter  Number only")
		
			if(window.event != null)
			{
				window.event.keyCode 	= 505;
				event.cancelBubble		= true;
				event.returnValue		= false;
			}
			else
			{
				e.preventDefault();
			}
			 return false;
		}
	}
}
}
</script>
</head>
<BODY  link="#0000FF" vlink="#800080" text="#000000" TOPMARGIN=0 LEFTMARGIN=0 MARGINwidth=0 MARGINheight=0 onload="loadFirst()">
<div id="main_container">

<div class="header"><%@ include file="../include/userheader.jsp"%>

</div>

<div class="main_content"><%@ include file="../include/header.jsp"%>


<div class="center_content">



<div class="left_content"></div>

<div class="right_content">

<h2><%=bundle.getString("label.profileinfo.infoupdaterootpath") %></h2>
<form name="University" method="post" enctype="multipart/form-data">
<%@ page
	import="java.util.*"%> <%
 	

 %>
 
  <jsp:useBean id="relationcheck" scope="page"
	class="com.iGrandee.Registration.InstitutionQurey" />
	 <%
	 ArrayList instituteArray = null;
	 	HashMap instituteMap = null;
	 	String instituteid = (String) session.getValue("instituteid");
	 	instituteArray = relationcheck.getInstituteDetails(instituteid);

	 	String institutenames = "";
	 	String contactaddress = "";
	 	String country = "";
	 	String state = "";
	 	String landlinenumber = "";
	 	String mobilenumber = "";
	 	String emailid = "";
	 	String fax = "";
	 	String photo = "";
	 	String url = "";
	 	String city = "";
	 	String zip = "";
	 	

	 	if (instituteArray != null && instituteArray.size() > 0) {
	 		for (int k = 0; k < instituteArray.size(); k++) {
	 			instituteMap = (HashMap) instituteArray.get(k);
	 			institutenames = (String) instituteMap.get("institutename");
	 			contactaddress = (String) instituteMap
	 					.get("contactaddress");
	 			country = (String) instituteMap.get("country");
	 			state = (String) instituteMap.get("state");
	 			landlinenumber = (String) instituteMap
	 					.get("landlinenumber");
	 			mobilenumber = (String) instituteMap.get("mobilenumber");
	 			emailid = (String) instituteMap.get("emailid");
	 			fax = (String) instituteMap.get("fax");
	 			emailid = (String) instituteMap.get("emailid");
	 			photo = (String) instituteMap.get("institutelogo");
	 			url = (String) instituteMap.get("url");
	 			city = (String) instituteMap.get("city");
	 			zip = (String) instituteMap.get("zip");
	 			

	 		}
	 	}
 %>







<input type="hidden" name="cubtry_temp" value="<%=country %>">
<input type="hidden" name="state_temp" value="<%=state %>">
	<input type=hidden name="instituteid" value="<%=instituteid %>">


<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="1%"></th>
        	<th scope="col" class="rounded" width="80%"><%=bundle.getString("label.profileinfo.infoupdatetableheading") %></th>
        	<th scope="col" class="rounded-q4" width="20%" ><a  style=float:right;><font color=red> *</font><%=bundle.getString("label.profileinfo.mandatoryfields") %></a></th>
            
        </tr>
    </thead>
    <tfoot>            
    	<tr>
        	<td colspan=2  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
 <tr><td></td><td colspan=2>
<table border=0 id="rounded-corner" align="center" width="100%" >
	 <thead>      	
		
			
								<tr style="height:25">
									<td class="tablebold" width="25%"><%=bundle.getString("label.profileinfo.nameofschool") %> <font color=red>&nbsp;*</font>
									</td>  
									<td class="tablelight" width="82%" colspan="3">
										&nbsp;&nbsp;<input type"text" size="50" name="txt_school_name" maxlength="58" validate=ShoolName value="<%=institutenames %>" >
									</td>
								</tr> 
 								
								<tr style="height:25">
									<td class="tablebold" width="25%" > <%=bundle.getString("label.profileinfo.street") %> <font color=red>&nbsp;&nbsp;*</font>
									</td>
									<td class="tablelight" width="82%" colspan="3">
										&nbsp;&nbsp;<input type="text" name="txt_street1" maxlength="130"  size=50 validate="street"  value="<%=contactaddress %>">
									</td>
									
		
								</tr>
								<tr style="height:25">
									<td class="tablebold" width="10%">
										 <%=bundle.getString("label.profileinfo.country") %><font color=red>&nbsp;&nbsp;*</font>
									</td>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<td class="tablelight" width="10%" colspan="4">
										&nbsp;&nbsp;<select name="slt_country" style="width:250px" onchange="state_fun('slt_state',document.getElementById('univ_state_tab'),this)"  validate="country">
											<option>Select</option>
										</select>
 									</td>
 									</tr>
 									<tr>
									<td class="tablebold" width="10%">
										State<font color=red>&nbsp;&nbsp;*</font>
									</td>
									
									<td class="tablebold" width="10%" align="left"  >
										<table id="univ_state_tab" align="left" border=0 cellspacing=0 cellpadding=0>
											<tr>
												<td align="left">
													<select name="slt_state" style="width:150"  validate="state">
														<option>Select</option>
													</select>

												</td> 
											</tr>
										</table> 
									</td>
									<td></td><td></td>
								</tr>
								<tr style="height:25">
									
									<td class="tablebold" width="25%">
										<%=bundle.getString("label.profileinfo.contactno") %><font color=red>&nbsp;&nbsp;*</font>
									</td>
									<td class="tablebold" width="82%" colspan="3">
									&nbsp;	<input type="text" name="txt_contact" maxlength="50" value="<%=landlinenumber %>" validate="Contact No" onkeypress="return checkNnmerickey(event)">
									</td>


								</tr>
								<tr style="height:25">
									<td class="tablebold" width="10%">
										 <%=bundle.getString("label.profileinfo.city") %><font color=red>&nbsp;&nbsp;*</font>
									</td>
									<td class="tablelight" width="10%">
									&nbsp;	<input type="text" name="txt_city" maxlength="50" value="<%=city %>" validate="City">
									</td>
									<td class="tablebold"width="18%">
										<%=bundle.getString("label.profileinfo.zip") %>
									</td>
									<td class="tablebold" width="70%">
										<input type="text" name="txt_zip" maxlength="30" value="<%=zip %>" validate="Zip">
									</td>
								</tr>
								
								<tr style="height:25">
									<td class="tablebold" width="10%">
										 <%=bundle.getString("label.profileinfo.email") %><font color=red>&nbsp;&nbsp;*</font>
									</td>
									<td class="tablelight" width="10%">
									&nbsp;	<input type="text" name="txt_mail" maxlength="50" value="<%=emailid %>" validate="email">
									</td>
									<td class="tablebold"width="18%">
										<%=bundle.getString("label.profileinfo.web") %>
									</td>
									<td class="tablebold" width="70%">
										<input type="text" name="txt_web" maxlength="250" value="<%=url %>" validate="web">
									</td>
								</tr>
								<tr style="height:25">
									<td class="tablebold" width="10%">
										 <%=bundle.getString("label.profileinfo.mobile") %><font color=red>&nbsp;&nbsp;*</font>
									</td>
									<td class="tablelight" width="10%">
									&nbsp;&nbsp;<input type="text" name="txt_mobile" maxlength="50" value="<%=mobilenumber %>" validate="Mobile" onkeypress="return checkNnmerickey(event)">
									</td>
									<td class="tablebold"width="10%">
										<%=bundle.getString("label.profileinfo.fax") %><font color=red>&nbsp;&nbsp;*</font>
									</td>
									<td class="tablebold" width="70%">
										<input type="text" name="txt_fax" maxlength="30" value="<%=fax %>" validate="Fax" onkeypress="return checkNnmerickey(event)">
									</td>


								</tr>
								
									<tr style="height:25">
									<td class="tablebold" style="width:20%">
									 <%=bundle.getString("label.profileinfo.photo") %>
									</td>
									<td class="tablelight" style="width:15%" colspan="3" > 
											&nbsp;&nbsp;<input type="file" name="photo" validate="photo"  maxlength=500  style="width:220" class=tablelight>
											
									</td>
									
									

								</tr>
								<tr>
								<td colspan=2>
								<font color=red>	
												<%=bundle.getString("label.profileinfo.notemessage") %>
								</font>
								</td>
								</tr>
								</thead>
								
							</table>
							</td>
							</tr>
							

</table>

</td>
</tr>
</table>


</td>
</tr>

</table>
				  <a href="#" onclick="goback()" class="bt_blue"><span class="bt_blue_lft"></span><strong>Back </strong><span class="bt_blue_r"></span></a>

     <a href="#" class="bt_green" onclick="submission()"><span class="bt_green_lft"></span><strong>Update </strong><span class="bt_green_r"></span></a>

	<input type=hidden name=server_date value="">
	<input type=hidden name="hid_photo" value="hid_photo">
<input type="hidden" name="studuserphoto" value="<%=photo%>">

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