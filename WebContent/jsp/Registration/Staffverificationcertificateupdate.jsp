<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Verification Certificate  Update | Powered by i-Grandee</title>
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
function chkfun(obj,elementno)
{
 if(obj.checked)
{
	if(!check_ForParticularElements(document.applicationform.certificatename[elementno],"text"))
	{
	    obj.checked=false;
	    return false;
	}
	if(document.applicationform.certificatefile[elementno].value=="")
	{
		if(document.applicationform.certificatepath[elementno].value=="")
		{
		   alert("Empty File is Not Allowed");
		   obj.checked=false;
		   return false;
		}
	}
	if(document.applicationform.status[elementno].value=="X")
		document.applicationform.status[elementno].value="U";
   document.applicationform.certificatename[elementno].disabled=true;
   document.applicationform.certificatepath[elementno].disabled=true;
   document.applicationform.certificatefile[elementno].disabled=true;
   document.applicationform.documentid[elementno].disabled=true;
   document.applicationform.status[elementno].disabled=true;
}
else
{
   if(document.applicationform.status[elementno].value=="U")
		document.applicationform.status[elementno].value="X";
   document.applicationform.certificatename[elementno].disabled=false;
   document.applicationform.certificatepath[elementno].disabled=false;
   document.applicationform.certificatefile[elementno].disabled=false;
   document.applicationform.documentid[elementno].disabled=false;
   document.applicationform.status[elementno].disabled=false;

 }
}
function submitfun()
{
	for(var i=0;i<document.applicationform.filepath.length;i++)
	{
		if(document.applicationform.filepath[i].checked)  
		{
		   document.applicationform.certificatename[i].disabled=false;
		   document.applicationform.certificatepath[i].disabled=false;
		   document.applicationform.certificatefile[i].disabled=false;
		   document.applicationform.documentid[i].disabled=false;
		   document.applicationform.status[i].disabled=false;  
		}
		else
		{
		   document.applicationform.certificatename[i].disabled=true;
		   document.applicationform.certificatepath[i].disabled=true;
		   document.applicationform.certificatefile[i].disabled=true;
		  if(document.applicationform.status[i].value!="X")
		   {
			   document.applicationform.documentid[i].disabled=true;
			   document.applicationform.status[i].disabled=true;
		   }
		 }
	}
	document.applicationform.action= "./Staffcertificateupdatesubmit.jsp";
	document.applicationform.submit();
}
function win(obj)
{
var attachment=obj.getAttribute("atta");
window.open("<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2="+attachment+"","Msg","top=250,left=350,help:no,center:no,status:no,width=500,height=300,scrollbars=1;")
}
function backfun()
{
	document.mainform.action="./StaffProviewView.jsp";
	document.mainform.submit();
}
function deletefun()
{
	var sta=false;
	if(document.applicationform.filechk.length!=undefined)
	{
	for(var i=0;i<document.applicationform.filechk.length;i++)
				{
					if(document.applicationform.filechk[i].checked)  
					{
							sta=true;				
					}
				}
	}
	else
	{
			if(document.applicationform.filechk.checked)  
					{
							sta=true;				
					}
	}
	if(sta==true)
	{		
			if(confirm("You Want to Delete the Selected Document"))
			{
				if(document.applicationform.filechk.length!=undefined)
					{
					for(var i=0;i<document.applicationform.filechk.length;i++)
						{
						
							if(document.applicationform.filechk[i].checked)  
							{
							   document.applicationform.documentid[i].disabled=false;
							}
							else
							{
								document.applicationform.documentid[i].disabled=true;
							}
				 
			           }
			         }
			         else
			         {
			         if(document.applicationform.filechk.checked)  
							{
							   document.applicationform.documentid.disabled=false;
							}
							else
							{
								document.applicationform.documentid.disabled=true;
							}
			         }
			    document.applicationform.action="./Staffcertificatedeletesubmit.jsp";
				document.applicationform.submit();
					 
		   }
	 }
	 else
	 {
	 alert("Select Any One Document to Delete");
	 }
}

function updatefun(obj)
{
	document.applicationform.hiddendocumentid.value=obj.getAttribute("documentid");
	document.applicationform.action="./StaffCertificateEdit.jsp";   
	document.applicationform.submit();
}
function addfun()
{
	document.applicationform.action="./StaffCertificateAdd.jsp";   
	document.applicationform.submit();
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

<h2>Enrollment / Staff Enrollment / Staff List / Staff List View / Staff Profile Details / Verification Certificate Update</h2>
<%@ page
	import="java.util.ArrayList,java.util.HashMap"%>
	<%@ page import="com.iGrandee.Registration.StaffRegistrationQuery"%>
	<%
	String date_str = "";
	StaffRegistrationQuery staffquery = new StaffRegistrationQuery(); 	
	String staffid = request.getParameter("Staffid");
	String departmentid = "";
	departmentid =  request.getParameter("departmentid");
	String userid =  request.getParameter("personid"); 
	ArrayList certificate_list=null;
	try {
 			 certificate_list = staffquery.StaffVerificationCertificate(staffid);
		}
	catch (Exception e) 
	{
		
	}
%>
<form name="applicationform" method="post" action="" ><%@ page
import="java.io.*,java.util.*"%>
<input type="hidden" name="hiddendocumentid" value="">
<input type="hidden" name="Staffid" value="<%=staffid%>"/>
<input type="hidden" name="departmentid" value="<%=departmentid%>"/>
<input type="hidden" name="deptname" value="<%=request.getParameter("deptname")%>"/>

<%
if (certificate_list != null && certificate_list.size() > 0) {
%>
		
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
						<tr class=tablebold><td width="100%">
						<table width="100%" border=0 bgcolor="#ffffff" cellpadding=0
							cellspacing=0>
							<tr height=30>
					<td width="5%">Sl.No</td><td class=tablelight  width="80%">Document Name 
					</td>
					<td>Edit</td>
					<td>Check</td>
			        </tr>
							<%
										for (int i = 0; i<certificate_list.size(); i++) 
										{
												HashMap innermap=(HashMap)certificate_list.get(i);
												out.println("<tr>");
												out.println("<td class='tablelight' width='10%' >");
												out.println((i + 1));
												out.println("</td  width='10%' >");
												out.println("<td class='tablelight' width='45%' >");
												out.println(innermap.get("documentname"));
												out.println("[ <a href='#' atta='"+innermap.get("documentpath")+"' onclick=win(this)>View</a> ]");
												out.println("<input type=hidden name='documentid' value='"+innermap.get("documentid")+"' />");
												if(i==0)
												{
													out.println("<input type=hidden name='personid' value='"+innermap.get("userid")+"' />");
													out.println("<input type=hidden name='hiddenuser_id' value='"+innermap.get("username")+"' />");
												}
												out.println("</td>");
												out.println("<td><a href='#' documentid='"+innermap.get("documentid")+"' onclick='updatefun(this)' >Edit</a></td>");
												out.println("<td><input type='checkbox' name='filechk' value='"+i+"'></td>");
												out.println("</tr>");
										}
							
							%>
			       <!-- <tr height=30>
					<td width="5%"></td><td class=tablelight  width="30%"><input type=text name='status' value='N' /><input type=text name="certificatename" value="" size="30"  validate='Document Name' /> 
					</td>
					<td class=tablelight  ><input type="file" name="certificatefile" /><input type=text name='certificatepath' value='' size=30 />   
					</td>
					<td><input type='checkbox' name='filepath' value=''   onclick='chkfun(this)'><input type=text name='documentid' value=''></td>
			        </tr> --> 
						</table>
						</td>
						</tr>
					</table>
					</td>
					</tr>
			</tbody>
		</table>
		
	<%} %>
		
	<a href="#"  onclick="backfun()" class="bt_blue"><span
		class="bt_blue_lft"></span><strong>Back</strong><span
		class="bt_blue_r"></span></a>
	   <a href="#" class="bt_green"
		onclick="addfun()"><span class="bt_green_lft"></span><strong>Add New Document</strong><span
		class="bt_green_r"></span></a></form>
		<a href="#" class="bt_green"
		onclick="deletefun()"><span class="bt_green_lft"></span><strong>Delete Document</strong><span
		class="bt_green_r"></span></a></form>
</div>
<form name=mainform method="post" action="">
<input type="hidden" name="Staffid" value="<%=staffid%>"/>
<input type="hidden" name="departmentid" value="<%=departmentid%>"/>
<input type="hidden" name="deptname" value="<%=request.getParameter("deptname")%>"/>

</form>

<% try{if(certificate_list.size()==0)  
 {
	 out.println("<script>backfun();</script>");
  } }
  catch(Exception e)
  {}%>
<!-- end of right content--></div>
<!--end of center content -->




<div class="clear"></div>
</div>
<!--end of main content--> <%@ include file="../include/footer.jsp"%>


</div>
</body>
</html>