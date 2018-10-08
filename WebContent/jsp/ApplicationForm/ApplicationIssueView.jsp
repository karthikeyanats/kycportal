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

function editApplicant(obj)
{
if(confirm("Do you want to Update the Applicant...?"))
	{
		document.applicationForm.applicationid_hidden.value=obj.getAttribute("applicationid");
		document.applicationForm.applicantname_hidden.value=obj.getAttribute("applicantname");
		document.applicationForm.applicationno_hidden.value=obj.getAttribute("applicationno");
		document.applicationForm.cost_hidden.value=obj.getAttribute("cost");
		document.applicationForm.contactno_hidden.value=obj.getAttribute("contactno");
		document.applicationForm.emailid_hidden.value=obj.getAttribute("emailid");
		document.applicationForm.receiptno_hidden.value=obj.getAttribute("receiptno");
		document.applicationForm.standardpubid_hidden.value=obj.getAttribute("standardpubid");
		document.applicationForm.action="ApplicationIssueUpdate.jsp";
		document.applicationForm.submit();
	}
}

function statusChangeFun(obj)
{
		if(confirm("Do you want to "+obj.getAttribute("statusval")+" the Applicant ...?"))
		{
			document.applicationForm.applicationid_hidden.value = obj.getAttribute("applicationid");
			document.applicationForm.applno.value = obj.getAttribute("applicationno");
			document.applicationForm.statuschange.value = obj.getAttribute("status");
			/*if(obj.getAttribute("status")=="T")
			{
				
				document.applicationForm.action= "ApplicantDetails.jsp";
			}
			else
			{
				document.applicationForm.action= "applicationStatusSubmit.jsp";
			}*/
			document.applicationForm.action= "ApplicantDetails.jsp";
			document.applicationForm.submit();
		}
}

function printApplicationReceipt(obj)
{
if(confirm("Do you want to Print the Applicant...?"))
	{
	window.open("./ApplicationReceiptPrint.jsp?applno="+obj.getAttribute("applicationno")+"&standardnamegp="+obj.getAttribute("standardnamegp")+"&req_sessionname="+obj.getAttribute("req_sessionname")+"&req_boardname="+obj.getAttribute("req_boardname")+"","Msg","top=250,left=350,help:no,center:no,status:no,width=500,height=400;")
	}
}


function addnew_fun()
{
	document.applicationForm.action= "ApplicationIssue.jsp";
	document.applicationForm.submit();
}

function viewDeactive()
{
	document.applicationForm.action= "ApplicationDeactivatedView.jsp";
	document.applicationForm.submit();
}

function viewTrash()
{
	document.applicationForm.action= "ApplicationTrashView.jsp";
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

    <h2><%=bundle.getString("label.applicationissueview.rootpath")%></h2>

<form name="applicationForm" action="" method="post">

<input type=hidden name=applicationid_hidden>
<input type=hidden name=applicantname_hidden>
<input type=hidden name=applicationno_hidden>
<input type=hidden name=cost_hidden>
<input type=hidden name=contactno_hidden>
<input type=hidden name=emailid_hidden>
<input type=hidden name=receiptno_hidden>
<input type=hidden name=standardpubid_hidden>

<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
            <th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.applicationissueview.SelectedInformation")%> </th>
            <th scope="col" class="rounded-q4" width="10%"></th>        
        </tr>
    </thead>
    
        <tfoot>
    	<tr>
        	<td  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
    
    <tr><td colspan=2><table border=0 align=center id="rounded-corner1" width="100%">
	<tr>
		<td class=tablebold width="25%">&nbsp;&nbsp;&nbsp;&nbsp; <%=bundle.getString("label.applicationissueview.AcademicYear")%></td><td class=tablebold width="2%">:</td><td class=tablelight ><%=request.getParameter("req_sessionname") %></td>
		<td class=tablebold width="25%"><%=bundle.getString("label.applicationissueview.Standard")%></td><td class=tablebold width="2%">:</td><td class=tablelight><%=request.getParameter("standardnamegp") %></td>
	</tr>
	<tr><td class=tablebold>&nbsp;&nbsp;&nbsp;&nbsp; <%=bundle.getString("label.applicationissueview.Board")%> </td><td class=tablebold width="2%">:</td><td  colspan=2  class=tablelight><%=request.getParameter("req_boardname") %></td>

</tr>
</table>
</td></tr>
</table>
<br>
<table id="rounded-corner" border=0 summary="Department List" width="100%" align="center">
   <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.applicationissueview.SL.No")%></th>
            <th scope="col" class="rounded" width="30%"><%=bundle.getString("label.applicationissueview.ApplicantName")%></th>
            <th scope="col" class="rounded" width="15%">Appln No</th>
            <!--<th scope="col" class="rounded" width="15%"><%=bundle.getString("label.applicationissueview.ApplicationFee")%></th>-->
            <th scope="col" class="rounded" width="15%">Contact Info</th>
            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.applicationissueview.DateofIssue")%></th>
            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.applicationissueview.Edit")%></th>
            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.applicationissueview.Action")%></th>
            <th scope="col" class="rounded" width="5%"><%=bundle.getString("label.applicationissueview.Trash")%></th>
            <th scope="col" class="rounded-q4" width="5%"><%=bundle.getString("label.applicationissueview.Print")%></th>                      
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="8" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     <%@ page import="java.util.ArrayList,java.util.HashMap,java.text.NumberFormat,java.util.Locale,com.iGrandee.Application.RegistrationProcess"%>

     <%
     com.iGrandee.Application.RegistrationProcess  applicationQuery = new com.iGrandee.Application.RegistrationProcess();
     String instituteid = null;
     String req_sessionstatus = request.getParameter("req_sessionstatus");
     String formattedCurrency 	= null;
     ArrayList applicantList = null;
     try
     {
    	  instituteid = (String)session.getValue("instituteid");
    	  //applicantList = applicationQuery.loadApplicantList(sessionid,boardid,standardpublishid);
    	    
    	  applicantList = applicationQuery.loadApplicantList(request.getParameter("req_sessionid"),request.getParameter("req_boardid"),request.getParameter("standardpublishid"),instituteid,"A");
    	
    	//scholarshipcategoryid,categoryname
    	ArrayList archivalDetails = new ArrayList();
    	 if(applicantList!=null && applicantList.size()>0)
			{
    		 for (int i = 0, j = 1; i < applicantList.size(); i++) {
			
				HashMap applicantListMap=(HashMap)applicantList.get(i);
				String applicationId      = (String)applicantListMap.get("applicationid");
				String applicantName      = (String)applicantListMap.get("applicantname");
				String applicationNo      = (String)applicantListMap.get("applicationno");
				String costofApp		  = (String)applicantListMap.get("cost");
				String contactNo		  = (String)applicantListMap.get("contactno");
				String emailId		  	  = (String)applicantListMap.get("emailid");
				String receiptNo		  = (String)applicantListMap.get("receiptno");
				String dateofcreation     = (String)applicantListMap.get("dateofcreation");
				
				String formattedAppCost = costofApp;
				//java.util.ResourceBundle serBundle 	= 	java.util.ResourceBundle.getBundle("resources.serversetup");
				Locale localcurrency = new Locale(serBundle.getString("language"), serBundle.getString("code"));

				Long lObj2 = Long.valueOf(formattedAppCost);
				NumberFormat format = NumberFormat.getCurrencyInstance(localcurrency);
		    	formattedCurrency = format.format(lObj2);
				
				
				%>
				
				<tr>
        	 <td align=center valign=top><%=j++ %></td>
            <td valign=top><%=applicantName %></td>
            <td valign=top><%=applicationNo %></td>
            <!--  <td><%=formattedCurrency %></td>-->
            <td valign=top><%=contactNo%><br><a href="mailto:<%=emailId%>"><%=emailId%></a></td>
            <td valign=top><%=dateofcreation %> </td>
            <% 
            if(req_sessionstatus=="A" || req_sessionstatus.equals("A"))
            {
            %>
            <td><a href="#"  applicationid="<%=applicationId%>" applicantname="<%=applicantName %>" applicationno="<%=applicationNo %>"  cost="<%=costofApp%>" receiptno="<%=receiptNo%>" contactno="<%=contactNo%>" emailid="<%=emailId%>" standardpubid="<%=request.getParameter("standardpublishid")%>" onclick="editApplicant(this)"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/user_edit.png" alt="" title="Edit" border="0" /></a></td>
            <td><a href="#"  applicationid="<%=applicationId%>" applicantname="<%=applicantName %>" applicationno="<%=applicationNo %>" statusval="Deactivate" status="D" onclick="statusChangeFun(this)" class="ask" title="<%=bundle.getString("hlink.applicationissueview.Deactivate")%>"><%=bundle.getString("hlink.applicationissueview.Deactivate")%></a></td>
            <td><a href="#"  applicationid="<%=applicationId%>" applicantname="<%=applicantName %>" applicationno="<%=applicationNo %>" statusval="Trash" status="T" onclick="statusChangeFun(this)" class="ask"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/trash.png" alt="" title="Trash" border="0" /></a></td>
            <td><a href="#"  applicationno="<%=applicationNo %>" req_sessionname="<%=request.getParameter("req_sessionname")%>" req_boardname="<%=request.getParameter("req_boardname")%>" standardnamegp="<%=request.getParameter("standardnamegp")%>"  onclick="printApplicationReceipt(this)" class="ask"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/printer.png" alt="" title="Print" border="0" /></a></td>  
            <%
            } 
            else
            {
            %>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td><a href="#"  applicationno="<%=applicationNo %>" req_sessionname="<%=request.getParameter("req_sessionname")%>" req_boardname="<%=request.getParameter("req_boardname")%>" standardnamegp="<%=request.getParameter("standardnamegp")%>"  onclick="printApplicationReceipt(this)" class="ask"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/printer.png" alt="" title="Print" border="0" /></a></td>
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



	<a href="#" class="bt_green" onclick="addnew_fun()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.applicationissueview.Addnewitem")%></strong><span class="bt_green_r"></span></a>
    <a href="#" class="bt_red" onclick="viewDeactive()"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.applicationissueview.ViewDeactiveApplicants")%> </strong><span class="bt_red_r"></span></a>
    <a href="#" class="bt_blue" onclick="viewTrash()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.applicationissueview.TrashedApplicants")%></strong><span class="bt_blue_r"></span></a>

	<input type=hidden name="req_sessionname" value = "<%=request.getParameter("req_sessionname")%>">
	<input type=hidden name="req_sessionid" value = "<%=request.getParameter("req_sessionid")%>">
	<input type=hidden name="req_boardname" value = "<%=request.getParameter("req_boardname")%>">
	<input type=hidden name="req_boardid" value = "<%=request.getParameter("req_boardid")%>">
	<input type=hidden name="standardnamegp" value = "<%=request.getParameter("standardnamegp")%>">
	<input type=hidden name="standardpublishid" value = "<%=request.getParameter("standardpublishid")%>">
	<input type=hidden name="req_sessionstatus" value = "<%=request.getParameter("req_sessionstatus")%>">
	<input type=hidden name="applno" value = "">
	
	<input type=hidden name="statuschange">
	
	
	
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>