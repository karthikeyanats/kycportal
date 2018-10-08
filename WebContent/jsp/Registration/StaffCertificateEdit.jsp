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
	if(!check_ForParticularElements(document.applicationform.certificatename,"text"))
	{
	    obj.checked=false;
	    return false;
	}
	if(document.applicationform.certificatefile.value=="")
	{
		if(document.applicationform.certificatepath.value=="")
		{
		   alert("Empty File is Not Allowed");
		   obj.checked=false;
		   return false;
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
	document.mainform.action="./Staffverificationcertificateupdate.jsp";
	document.mainform.submit();
}
function updatefun(obj)
{
	document.applicationform.documentid.value=obj.getAttribute("documentid");
	document.applicationform.action="./StaffcertificateEdit.jsp";
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
	String documentid = request.getParameter("hiddendocumentid");

	
	String departmentid = "";
	departmentid =  request.getParameter("departmentid");
	String username = "";
	username =  request.getParameter("hiddenuser_id");
	String userid = "";
	userid =  request.getParameter("personid");
	ArrayList certificate_list=null;
	try {
 			 certificate_list = staffquery.StaffCertificate(documentid);
		}
	catch (Exception e) 
	{
		e.printStackTrace();
	}
%>
<form name="applicationform" method="post" action="" enctype="multipart/form-data"><%@ page
import="java.io.*,java.util.*"%>
<input type="hidden" name="Staffid" value="<%=staffid%>"/>
<input type="hidden" name="departmentid" value="<%=departmentid%>"/>
<input type=hidden name='hiddenuser_id' value="<%=username %>" />
<input type="hidden" name="documentcreation" value="update"> 
<input type="hidden" name=personid value="<%=userid %>"> 
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
					<td>File</td>
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
												out.println("<input type=text name='certificatename' value='"+(innermap.get("documentname")+"").replaceAll("'","&#39;")+"' size=35/>");
												out.println("[<a href='#' atta='"+innermap.get("documentpath")+"' onclick=win(this)>View</a> ]");
												out.println("</td><td><input type='file' name='certificatefile' />");
												out.println("<input type=hidden name='documentid' value='"+innermap.get("documentid")+"' /><input type=hidden name='certificatepath' value='"+innermap.get("documentpath")+"' >");
												out.println("</td>");
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
		onclick="submitfun()"><span class="bt_green_lft"></span><strong>Submit</strong><span
		class="bt_green_r"></span></a></form>
</div>
<form name=mainform method="post" action="">
<input type="hidden" name="Staffid" value="<%=staffid%>"/>
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