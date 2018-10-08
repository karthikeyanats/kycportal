<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<% 	
	java.util.ResourceBundle bundle 	= 	java.util.ResourceBundle.getBundle("resources.ApplicationResources");
%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.admisionview.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript">

function editApplicant(obj)
{
if(confirm("Do you want to Update the Applicant ...?"))
	{
		document.applicationForm.approvestatus.value = obj.getAttribute("approvestatus");
		document.applicationForm.registrationid_hidden.value=obj.getAttribute("registrationid");
		document.applicationForm.applicantname_hidden.value=obj.getAttribute("applicantname");
		document.applicationForm.applicationno_hidden.value=obj.getAttribute("applicationno");
		document.applicationForm.regamount_hidden.value=obj.getAttribute("regamount");
		//document.applicationForm.contactno_hidden.value=obj.getAttribute("contactno");
		document.applicationForm.receiptno_hidden.value=obj.getAttribute("receiptno");
		document.applicationForm.standardpubid_hidden.value=obj.getAttribute("standardpubid");
		document.applicationForm.action="RegistrationUpdate.jsp";
		document.applicationForm.submit();
	}
}


function statusChangeFun(obj)
{
		if(confirm("Do you want to "+obj.getAttribute("statusval")+" the Applicant Details..?"))
		{
			document.applicationForm.regamount_hidden.value=obj.getAttribute("regamount");
			document.applicationForm.applno.value = obj.getAttribute("applicationno");
			document.applicationForm.statusval.value = obj.getAttribute("statusval");
			document.applicationForm.approvestatus.value = obj.getAttribute("approvestatus");			
			document.applicationForm.registrationid_hidden.value = obj.getAttribute("registrationid");
			document.applicationForm.statuschange.value = obj.getAttribute("status");
			//alert(document.applicationForm.statuschange.value)
			document.applicationForm.action= "RegistrationStatusPreview.jsp";
			document.applicationForm.submit();
		}
}


function statusChangeFun1(obj)
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

function addnew_fun()
{
	document.applicationForm.req_sessionstatus.value = null;
	document.applicationForm.action= "RegistrationProcessList_Pre.jsp";
	document.applicationForm.submit();
}

function viewDeactive()
{
	document.applicationForm.action= "RegistrationDeactivatedView.jsp";
	document.applicationForm.submit();
}

function viewTrash()
{
	document.applicationForm.action= "RegistrationTrashView.jsp";
	document.applicationForm.submit();
}

function printApplicationReceipt(obj)
{
if(confirm("Do you want to Print the Applicant...?"))
	{
	window.open("./RegPrintFinal.jsp?applicationid="+obj.getAttribute("applicationid")+"&standardnamegp="+obj.getAttribute("standardnamegp")+"&req_sessionname="+obj.getAttribute("req_sessionname")+"&req_boardname="+obj.getAttribute("req_boardname")+"","Msg","top=250,left=350,help:no,center:no,status:no,width=500,height=300;")
	}
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

    <h2><%=bundle.getString("label.admisionview.rootpath")%></h2>

<form name="applicationForm" action="" method="post">

<input type=hidden name=registrationid_hidden>
<input type=hidden name=applno>
<input type=hidden name=approvestatus>


<input type=hidden name=applicantname_hidden>
<input type=hidden name=applicationno_hidden>
<input type=hidden name=regamount_hidden>
<input type=hidden name=receiptno_hidden>
<input type=hidden name=standardpubid_hidden>

<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
            <th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.admisionview.SelectedInformation")%></th>
            <th scope="col" class="rounded-q4" width="10"></th>        
        </tr>
    </thead>
    
        <tfoot>
    	<tr>
        	<td  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
    
    <tr><td colspan=2 ><table border=0 align=center id="rounded-corner1" width="100%">
	<tr>
		<td class=tablebold width="25%">&nbsp;&nbsp;&nbsp;&nbsp; <%=bundle.getString("label.admisionview.AcademicYear")%></td><td class=tablebold width='2%'>:</td><td class=tablelight ><%=request.getParameter("req_sessionname") %></td>
		<td class=tablebold width="25%"><%=bundle.getString("label.admisionview.Standard")%></td><td class=tablebold width='2%'>:</td><td class=tablelight><%=request.getParameter("standardnamegp") %></td>
	</tr>
	<tr><td class=tablebold>&nbsp;&nbsp;&nbsp;&nbsp; <%=bundle.getString("label.admisionview.Board")%> </td><td class=tablebold width='2%'>:</td><td  colspan=2  class=tablelight><%=request.getParameter("req_boardname") %></td>

</tr>
</table>
</td></tr>
</table>
<br>
<table id="rounded-corner" border=0 summary="Department List" width="100%" align="center">
   <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.admisionview.SL.No")%></th>
            <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.admisionview.ApplicantName")%></th>
            <th scope="col" class="rounded" width="15%">Appln No</th>
            <!--  <th scope="col" class="rounded" width="13%">bundle.getString("label.admisionview.AdmissionFee")</th>-->
            <th scope="col" class="rounded" width="15%">Contact Info</th>
            <th scope="col" class="rounded" width="15%"><%=bundle.getString("label.admisionview.AdmissionDate")%></th>
            <th scope="col" class="rounded" width="7%"><%=bundle.getString("label.admisionview.Edit")%></th>
            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.admisionview.Action")%></th>            
            <th scope="col" class="rounded" width="5%"><%=bundle.getString("label.admisionview.Trash")%></th>
            <th scope="col" class="rounded-q4" width="5%"><%=bundle.getString("label.admisionview.Print")%></th>  
                      
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="8" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess,java.text.NumberFormat,java.util.Locale"%>

     <%
     com.iGrandee.Application.RegistrationProcess  applicationQuery = new com.iGrandee.Application.RegistrationProcess();
     String instituteid = null;
     ArrayList applicantList = null;
     try
     {
    	   instituteid = (String)session.getValue("instituteid");
    	  //applicantList = applicationQuery.loadApplicantList(sessionid,boardid,standardpublishid);
    	    
    	  applicantList = applicationQuery.loadAdmittedList(request.getParameter("standardpublishid"),instituteid,"A");
   	
    	 if(applicantList!=null && applicantList.size()>0)
			{
    	     String formattedRegFeeCurrency = null;
    	     //Locale localcurrency = new Locale("en", "IN");
    	     java.util.ResourceBundle serBundle 	= 	java.util.ResourceBundle.getBundle("resources.serversetup");
    	     Locale localcurrency = new Locale(serBundle.getString("language"), serBundle.getString("code"));
    	     
    		 for (int i = 0, j = 1; i < applicantList.size(); i++) {
			
				HashMap applicantListMap=(HashMap)applicantList.get(i);
				String applicationId	 = (String)applicantListMap.get("applicationid");	
				String registrationId      = (String)applicantListMap.get("registrationid");
				String regAmount		  = (String)applicantListMap.get("registrationamount");
				String applicantName      = (String)applicantListMap.get("applicantname");
				String applicationNo      = (String)applicantListMap.get("applicationno");
				String receiptNo	      = (String)applicantListMap.get("receiptno");
				String dateofadmission     = (String)applicantListMap.get("dateofadmission");
				String approvestatus     = (String)applicantListMap.get("approvestatus");
				
				
				
	    	    Long regFeeObj = Long.valueOf(regAmount);
	    	    NumberFormat format = NumberFormat.getCurrencyInstance(localcurrency);
	    	    formattedRegFeeCurrency = format.format(regFeeObj);
				%>
				
				<tr>
        	 <td valign=top><%=j++%></td>
            <td valign=top><%=applicantName%></td>
            <td valign=top><%=applicationNo%></td>
            <!--  <td align=right><%=formattedRegFeeCurrency%></td>-->
            <td valign=top><%=applicantListMap.get("contactno")%><br><a href="mailto:<%=applicantListMap.get("emailid")%>"><%=applicantListMap.get("emailid")%></a></td>
            
            <td align=center valign=top><%=dateofadmission%> </td>
            <% 
            if(request.getParameter("req_sessionstatus")=="A" || request.getParameter("req_sessionstatus").equals("A"))
            {
            %>
            <td><a href="#"  approvestatus="<%=approvestatus%>" registrationid="<%=registrationId%>" applicantname="<%=applicantName %>" applicationno="<%=applicationNo %>" receiptno="<%=receiptNo%>" regamount="<%=regAmount%>" standardpubid="<%=request.getParameter("standardpublishid")%>" onclick="editApplicant(this)"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/user_edit.png" alt="" title="Edit" border="0" /></a></td>
            <td><a href="#"  approvestatus="<%=approvestatus%>" registrationid="<%=registrationId%>" applicantname="<%=applicantName %>" applicationno="<%=applicationNo %>" regamount="<%=regAmount%>" statusval="DeActivate" status="D" onclick="statusChangeFun(this)" class="ask" title="Deactivate"><%=bundle.getString("hlink.admissionapproval.Deactivate")%></a></td>
            <td><a href="#"  approvestatus="<%=approvestatus%>" registrationid="<%=registrationId%>" applicantname="<%=applicantName %>" applicationno="<%=applicationNo %>" regamount="<%=regAmount%>" statusval="Trash" status="T" onclick="statusChangeFun(this)" class="ask"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/trash.png" alt="" title="Trash" border="0" /></a></td>
            <td><a href="#"  applicationid="<%=applicationId %>" req_sessionname="<%=request.getParameter("req_sessionname")%>" req_boardname="<%=request.getParameter("req_boardname")%>" standardnamegp="<%=request.getParameter("standardnamegp")%>"  onclick="printApplicationReceipt(this)" class="ask"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/printer.png" alt="" title="Print" border="0" /></a></td>
            <%
            } 
            else
            {
            %>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td><a href="#"  applicationid="<%=applicationId %>" req_sessionname="<%=request.getParameter("req_sessionname")%>" req_boardname="<%=request.getParameter("req_boardname")%>" standardnamegp="<%=request.getParameter("standardnamegp")%>"  onclick="printApplicationReceipt(this)" class="ask"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/printer.png" alt="" title="Print" border="0" /></a></td>
			<% 
            }
			%>        
        </tr>
				<%
    		 }
			}
    	 	else{
    	 		out.println("<tr align='center' class='tablebold'><td colspan='9'><font color='red'>Data Not Found</font></td></tr>");
     			//out.println("<tr><td colspan=7>Data not found</td></tr>");    	 
    	 	}
     }catch(Exception e){}
          
     %>
    	
    </tbody>
</table>



	<a href="#" class="bt_green" onclick="addnew_fun()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.admisionview.Addnewitem")%></strong><span class="bt_green_r"></span></a>
    <a href="#" class="bt_red" onclick="viewDeactive()"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.admisionview.ViewDeactiveApplicants")%> </strong><span class="bt_red_r"></span></a>
    <a href="#" class="bt_blue" onclick="viewTrash()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.admisionview.TrashedApplicants")%></strong><span class="bt_blue_r"></span></a>

	<input type=hidden name="req_sessionname" value = "<%=request.getParameter("req_sessionname")%>">
	<input type=hidden name="req_sessionid" value = "<%=request.getParameter("req_sessionid")%>">
	<input type=hidden name="req_boardname" value = "<%=request.getParameter("req_boardname")%>">
	<input type=hidden name="req_boardid" value = "<%=request.getParameter("req_boardid")%>">
	<input type=hidden name="standardnamegp" value = "<%=request.getParameter("standardnamegp")%>">
	<input type=hidden name="standardpublishid" value = "<%=request.getParameter("standardpublishid")%>">
	<input type=hidden name="req_sessionstatus" value = "<%=request.getParameter("req_sessionstatus")%>">
	
	<input type=hidden name="statuschange">
	<input type=hidden name="statusval">
	
	
	
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>