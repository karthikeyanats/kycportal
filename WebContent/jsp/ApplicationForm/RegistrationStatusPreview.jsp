<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<% 	
	java.util.ResourceBundle serBundle 	= 	java.util.ResourceBundle.getBundle("resources.serversetup");
	java.util.ResourceBundle bundle 	= 	java.util.ResourceBundle.getBundle("resources.ApplicationResources");
%>

<title>Know Your Child - <%=bundle.getString("label.applicationissueview.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript">
function statusChangeFun(obj)
{
		if(confirm("Do you want to "+obj.getAttribute("statusval")+" the Applicant Details..?"))
		{
		
			document.applicationForm.registrationid_hidden.value = obj.getAttribute("registrationid");
			document.applicationForm.statuschange.value = obj.getAttribute("status");
			//alert(document.applicationForm.statuschange.value)
			document.applicationForm.action= "registrationStatusSubmit.jsp";
			document.applicationForm.submit();
		}
}

function backfun()
{
	document.applicationForm.action= "RegistrationView.jsp";
	document.applicationForm.submit();
}
</script>
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

    <h2>Enrollment / Student Enrollment / Admission / Admission <%=request.getParameter("statusval")%> Preview</h2>

<form name="applicationForm" action="" method="post">

<input type=hidden name=applicationid_hidden>
<input type=hidden name=applicantname_hidden>
<input type=hidden name=applicationno_hidden>
<input type=hidden name=cost_hidden>
<input type=hidden name=contactno_hidden>
<input type=hidden name=emailid_hidden>
<input type=hidden name=receiptno_hidden>
<input type=hidden name=standardpubid_hidden>
<jsp:useBean id="applicationQuery" scope="page" class="com.iGrandee.Application.ApplicationQuery"/>

<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
            <th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.applicationissueview.StudentInformation")%> </th>
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
    <tr><td colspan=2>
    <table border=0  width="100%">
	<%
	//String temp=applicationQuery.receiptNo();
	java.util.ArrayList valueList= null;
	String receipt= "";
	String applno = "";
	String standardnamegp = "";

	//receipt=request.getParameter("receipt");
	applno=request.getParameter("applno");
	standardnamegp=request.getParameter("standardnamegp");

	valueList=applicationQuery.getApplicantDetails(applno);

	%>
	<%

	String appId				= 	"";
	String applicantname		= 	"";
	String Applicationno		= 	"";
	String appCost				= 	"";
	String regCost				= 	"";
	String contactno			=	"";
	String standardpublishid	=	"";
	String standardname			=	"";
	String currentdate			=	"";
	String formattedCurrency 	= null;

	java.util.Locale localcurrency = new java.util.Locale(serBundle.getString("language"), serBundle.getString("code"));

	if(valueList.size() > 0 )
	{
	for(int i=0;i<valueList.size();i++)
	{
		java.util.HashMap map=(java.util.HashMap)valueList.get(i);
		 appId=(String)map.get("applicationid");
		 applicantname=(String)map.get("applicantname");
		 Applicationno=(String)map.get("applicationno");
		 appCost=(String)map.get("cost");
		 String receiptno=(String)map.get("receiptno");
		 //corseType=(String)map.get("type");
		 contactno=(String)map.get("contactno");
		 standardpublishid=(String)map.get("standardpublishid");
		 standardname=(String)map.get("standardname");
		 currentdate = (String)map.get("currentdate");
		 regCost=request.getParameter("regamount_hidden");
		 
		// String check=corseType.substring(0,1);

		String formattedAppCost = regCost+"";
		Long lObj2 = Long.valueOf(formattedAppCost);
		java.text.NumberFormat format = java.text.NumberFormat.getCurrencyInstance(localcurrency);
    	formattedCurrency = format.format(lObj2);
		out.println("<tr class=tablelight><td class=tablelight><b>"+bundle.getString("label.applicationissueprint.ReceiptNo")+"</b></td><td>"+receiptno+"</td></tr>");
		out.println("<tr class=tablelight><td class=tablelight><b>"+bundle.getString("label.applicationissueprint.AcademicYear")+"</b></td><td class=tablelight>"+request.getParameter("req_sessionname")+"</td></tr>");
		out.println("<tr class=tablelight><td class=tablelight><b>"+bundle.getString("label.applicationissueprint.BoardName")+"</b></td><td class=tablelight>"+request.getParameter("req_boardname")+"</td></tr>");
		out.println("<tr class=tablelight><td class=tablelight><b>"+bundle.getString("label.applicationissueprint.Standard")+"</b></td><td class=tablelight>"+standardnamegp+"</td></tr>");
		out.println("<tr class=tablelight ><td width='45%' class=tablelight><b>"+bundle.getString("label.applicationissueprint.ApplicantName")+"</b></td><td class=tablelight>"+applicantname+"</td></tr>");
		out.println("<tr class=tablelight><td class=tablelight><b>"+bundle.getString("label.applicationissueprint.ApplicationNo")+".</b></td><td class=tablelight>"+Applicationno+"</td></tr>");
		out.println("<tr class=tablelight><td class=tablelight><b>"+bundle.getString("label.admisionprocess.AdmissionFee")+"</b></td><td class=tablelight>"+formattedCurrency+"</td></tr>");

		//out.println("<tr><td colspan='3' align='center'><input type='button' value='Print' class='buttons'></td></tr>");

	}
}
else
{
	out.println("<tr align='center' class='tablebold'><td><font color='red'>Data Not Found</font></td></tr>");
	//out.println("<tr><td><font color='#000000'>Data not found</td></tr>");
}
	
	%>
</table>
</td></tr>
	</tbody>

</table>

<%
if(!request.getParameter("approvestatus").equals("InActive"))
{
%>
<br>
<div class=warning_box>Student Already Approved. so you can't <%=request.getParameter("statusval")%>.
</div>
<br><%
}
%>


<a href="#" class="bt_blue" onclick="backfun()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.applicationissueview.Back")%></strong><span class="bt_blue_r"></span></a>

	<%
	if(request.getParameter("approvestatus").equals("InActive"))
	{
	%>
	
	<a href="#" class="bt_red" registrationid="<%=request.getParameter("registrationid_hidden")%>"  statusval="<%=request.getParameter("statusval")%>" status="<%=request.getParameter("statuschange")%>" onclick="statusChangeFun(this)"><span class="bt_red_lft"></span><strong><%=request.getParameter("statusval")%></strong><span class="bt_red_r"></span></a>
	<br><%
	}
	%>
	
	<input type=hidden name="req_sessionname" value = "<%=request.getParameter("req_sessionname")%>">
	<input type=hidden name="req_sessionid" value = "<%=request.getParameter("req_sessionid")%>">
	<input type=hidden name="req_boardname" value = "<%=request.getParameter("req_boardname")%>">
	<input type=hidden name="req_boardid" value = "<%=request.getParameter("req_boardid")%>">
	<input type=hidden name="standardnamegp" value = "<%=request.getParameter("standardnamegp")%>">
	<input type=hidden name="standardpublishid" value = "<%=request.getParameter("standardpublishid")%>">
	<input type=hidden name="req_sessionstatus" value = "<%=request.getParameter("req_sessionstatus")%>">
	<input type=hidden name="statuschange" value = "<%=request.getParameter("statuschange")%>">
	<input type=hidden name="appId" value="<%=appId %>">
	<input type=hidden name="registrationid_hidden">
	
	
	
	
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>