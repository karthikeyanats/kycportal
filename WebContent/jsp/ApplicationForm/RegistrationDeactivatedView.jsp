<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<% 	
	java.util.ResourceBundle bundle 	= 	java.util.ResourceBundle.getBundle("resources.ApplicationResources");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.admisiondeactivatelist.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript">

function addnew_fun()
{
	document.applicationForm.req_sessionstatus.value = null;
	document.applicationForm.action= "RegistrationProcessList_Pre.jsp";
	document.applicationForm.submit();
}

function viewActive()
{
	document.applicationForm.action= "RegistrationView.jsp";
	document.applicationForm.submit();
}

function viewTrash()
{
	document.applicationForm.action= "RegistrationTrashView.jsp";
	document.applicationForm.submit();
}

function statusChangeFun(obj)
{
		if(confirm("Do you want to "+obj.getAttribute("statusval")+" the Applicant ...?"))
		{
			document.applicationForm.registrationid_hidden.value = obj.getAttribute("registrationid");
			document.applicationForm.statuschange.value = obj.getAttribute("status");
			document.applicationForm.statuschangeval.value = obj.getAttribute("statusval");			
			//alert(document.applicationForm.statuschange.value)
			document.applicationForm.action= "registrationStatusSubmit.jsp";
			document.applicationForm.submit();
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

    <h2><%=bundle.getString("label.admisiondeactivatelist.rootpath")%></h2>

<form name="applicationForm" action="" method="post">

<input type=hidden name=registrationid_hidden>

<input type=hidden name=standardpubid_hidden>

<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
   
            <th scope="col" class="rounded-company" width="90%">Selected Information </th>
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
		<td class=tablebold width="25%">&nbsp;&nbsp;&nbsp;&nbsp; <%=bundle.getString("label.admisiondeactivatelist.AcademicYear")%></td><td class=tablebold width='2%' valign=top>:</td><td class=tablelight ><%=request.getParameter("req_sessionname") %></td>
		<td class=tablebold width="25%"><%=bundle.getString("label.admisiondeactivatelist.Standard")%></td><td class=tablebold width='2%' valign=top>:</td><td class=tablelight><%=request.getParameter("standardnamegp") %></td>
	</tr>
	<tr><td class=tablebold>&nbsp;&nbsp;&nbsp;&nbsp; <%=bundle.getString("label.admisiondeactivatelist.Board")%> </td><td class=tablebold width='2%' valign=top>:</td><td  colspan=2  class=tablelight><%=request.getParameter("req_boardname") %></td>

</tr>
</table>
</td></tr>
</table>
<br>
<table id="rounded-corner" border=0 summary="Department List" width="100%" align="center">
   <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.admisiondeactivatelist.SL.No")%></th>
            <th scope="col" class="rounded" width="35%"><%=bundle.getString("label.admisiondeactivatelist.ApplicantName")%></th>
            <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.admisiondeactivatelist.ApplicationNo")%></th>
            <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.admisiondeactivatelist.DateofDeActivation")%></th>
            <th scope="col" class="rounded-q4" width="10%"><%=bundle.getString("label.admisiondeactivatelist.Action")%></th>
                   
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="4" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess"%>

     <%
     com.iGrandee.Application.RegistrationProcess  applicationQuery = new com.iGrandee.Application.RegistrationProcess();
     String instituteid = null;
     ArrayList applicantList = null;
     try
     {
    	  instituteid = (String)session.getValue("instituteid");
    	  //applicantList = applicationQuery.loadApplicantList(sessionid,boardid,standardpublishid);
    	   
    	  //applicantList = applicationQuery.loadApplicantList(request.getParameter("req_sessionid"),request.getParameter("req_boardid"),request.getParameter("standardpublishid"),"D");
    	  applicantList = applicationQuery.loadAdmittedList(request.getParameter("standardpublishid"),instituteid,"D");
    	
    	//scholarshipcategoryid,categoryname
    	 if(applicantList!=null && applicantList.size()>0)
			{
    		 for (int i = 0, j = 1; i < applicantList.size(); i++) {
			
				HashMap applicantListMap=(HashMap)applicantList.get(i);
				String registrationId      = (String)applicantListMap.get("registrationid");
				String regAmount		  = (String)applicantListMap.get("registrationamount");
				String applicantName      = (String)applicantListMap.get("applicantname");
				String applicationNo      = (String)applicantListMap.get("applicationno");
				String receiptNo	      = (String)applicantListMap.get("receiptno");
				String dateofadmission     = (String)applicantListMap.get("dateofadmission");
				
				%>
				
				<tr>
        	 <td><%=j++ %></td>
            <td><%=applicantName %></td>
            <td><%=applicationNo %></td>
            <td><%=dateofadmission%> </td>
            <% 
            if(request.getParameter("req_sessionstatus")=="A" || request.getParameter("req_sessionstatus").equals("A"))
            {
            %>   
            <td><a href="#"  registrationid="<%=registrationId%>" applicantname="<%=applicantName %>" applicationno="<%=applicationNo %>" statusval="Activate" status="A" onclick="statusChangeFun(this)" class="ask"><%=bundle.getString("hlink.admisiondeactivatelist.Action")%></a></td>
            <%
            }
            else
            {
            %>
            <td>-</td>
            <%} %>        
        </tr>
				<%
    		 }
			}
    	 	else{
    	 		out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");
     			//out.println("<tr><td colspan=7>Data not found</td></tr>");    	 
    	 	}
     }catch(Exception e){}
          
     %>
    	
    </tbody>
</table>



	<a href="#" class="bt_green" onclick="addnew_fun()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.admisiondeactivatelist.Addnewitem")%></strong><span class="bt_green_r"></span></a>
    <a href="#" class="bt_red" onclick="viewTrash()"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.admisiondeactivatelist.TrashedApplicants")%></strong><span class="bt_red_r"></span></a>
    <a href="#" class="bt_blue" onclick="viewActive()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.admisiondeactivatelist.ViewActiveApplicants")%> </strong><span class="bt_blue_r"></span></a>
    
	<input type=hidden name="req_sessionname" value = "<%=request.getParameter("req_sessionname")%>">
	<input type=hidden name="req_sessionid" value = "<%=request.getParameter("req_sessionid")%>">
	<input type=hidden name="req_boardname" value = "<%=request.getParameter("req_boardname")%>">
	<input type=hidden name="req_boardid" value = "<%=request.getParameter("req_boardid")%>">
	<input type=hidden name="standardnamegp" value = "<%=request.getParameter("standardnamegp")%>">
	<input type=hidden name="standardpublishid" value = "<%=request.getParameter("standardpublishid")%>">
	<input type=hidden name="req_sessionstatus" value = "<%=request.getParameter("req_sessionstatus")%>">
	
	
	<input type=hidden name="statuschange">
	<input type=hidden name="statuschangeval">
	
	
	
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>