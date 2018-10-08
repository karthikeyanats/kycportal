<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Approval Trash List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript">

function addnew_fun()
{
	document.applicationForm.req_sessionstatus.value = null;
	document.applicationForm.action= "StudentApproval.jsp";
	document.applicationForm.submit();
}

function viewDeactive()
{
	document.applicationForm.action= "ApproveDeactivatedView.jsp";
	document.applicationForm.submit();
}

function viewActive()
{
	document.applicationForm.action= "ApproveView.jsp";
	document.applicationForm.submit();
}

function statusChangeFun(obj)
{
		if(obj.getAttribute("status")=="A")
		{
				url = "../StudentPromotion/getAction.jsp?Action=getApplicationNoinApprv&appNo="+obj.getAttribute("applicationno");
	
				var req=null;
			
				try
				  {
				  // Firefox, Opera 8.0+, Safari
				  req=new XMLHttpRequest();
				  }
				catch (e)
				  {
				  // Internet Explorer
				  try
				    {
				    req=new ActiveXObject("Msxml2.XMLHTTP");
				    }
				  catch (e)
				    {
				    req=new ActiveXObject("Microsoft.XMLHTTP");
				    }
				  }
				  //alert(req)
				
						req.onreadystatechange = function()
						{
						//	alert(req.readyState)
							if (req.readyState == 4)
							   {
								//   alert(req.status)
							  		 if(req.status == 200)
									 {
					              			var parseXML=req.responseXML;
				
											var rootObj=parseXML.getElementsByTagName("checkNumber");
											var cNode_1=rootObj[0].childNodes.length;
											var username=null;
											var finalValue=rootObj[0].childNodes.item(0).childNodes.item(0).firstChild.nodeValue;
											//var finalValue=rootObj[0].childNodes[0].selectSingleNode("finalValue").text;
				
											if(finalValue=="1")
											{
												alert("This Application No. Already Exist in Approved List.You cant Restore")
											}
											else
											{
												if(confirm("Do you want to "+obj.getAttribute("statusval")+" the Applicant ...?"))
												{
													document.applicationForm.studentapprovalid_hidden.value = obj.getAttribute("studentapprovalid");
													document.applicationForm.statuschange.value = obj.getAttribute("status");
													document.applicationForm.statuschangeval.value = obj.getAttribute("statusval");
													//alert(document.applicationForm.statuschange.value)
													document.applicationForm.action= "approvalStatusSubmit.jsp";
													document.applicationForm.submit();
												}
											}
			
									  }
								   	 else if (req.status == 204)
								     {
									 }
							   	}
					   };
					req.open("GET",url,true);
					req.send(null);
		}
		else
		{
			if(confirm("Do you want to "+obj.getAttribute("statusval")+" the Applicant ...?"))
			{
				document.applicationForm.studentapprovalid_hidden.value = obj.getAttribute("studentapprovalid");
				document.applicationForm.statuschange.value = obj.getAttribute("status");
				document.applicationForm.statuschangeval.value = obj.getAttribute("statusval");
				//alert(document.applicationForm.statuschange.value)
				document.applicationForm.action= "approvalStatusSubmit.jsp";
				document.applicationForm.submit();
			}
		}
}

function statusChangeFun1(obj)
{
		if(confirm("Do you want to "+obj.getAttribute("statusval")+" the Applicant...?"))
		{
			document.applicationForm.studentapprovalid_hidden.value = obj.getAttribute("studentapprovalid");
			document.applicationForm.statuschange.value = obj.getAttribute("status");
			document.applicationForm.statuschangeval.value = obj.getAttribute("statusval");
			//alert(document.applicationForm.statuschange.value)
			document.applicationForm.action= "approvalStatusSubmit.jsp";
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

    <h2>Enrollment / Student Enrollment / Approval / Trashed Approval View</h2>

<form name="applicationForm" action="" method="post">

<input type=hidden name=studentapprovalid_hidden>
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
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
    
    <tr><td colspan=2><table border=0 align=center id="rounded-corner1" width="100%">
	<tr>
		<td class=tablebold width="25%">&nbsp;&nbsp;&nbsp;&nbsp; Academic Year</td><td class=tablebold width='2%'>:</td><td class=tablelight ><%=request.getParameter("req_sessionname") %></td>
		<td class=tablebold width="25%">Standard</td><td class=tablebold width='2%'>:</td><td class=tablelight><%=request.getParameter("standardnamegp") %></td>
	</tr>
	<tr><td class=tablebold>&nbsp;&nbsp;&nbsp;&nbsp; Board </td><td class=tablebold width='2%'>:</td><td  colspan=2  class=tablelight><%=request.getParameter("req_boardname") %></td>

</tr>
</table>
</td></tr>
</table>
<br>
<table id="rounded-corner" border=0 summary="Department List" width="100%" align="center">
   <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%">Sl.No</th>
            <th scope="col" class="rounded" width="35%">Applicant Name</th>
            <th scope="col" class="rounded" width="25%">Application No</th>
            <th scope="col" class="rounded" width="25%">Date of Trash</th>
            <th scope="col" class="rounded" width="10%">Delete</th>
            <th scope="col" class="rounded-q4" width="10%">Restore</th>
                      
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="5" class="rounded-foot-left"><em></em></td>
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
    	   
    	  //applicantList = applicationQuery.loadApplicantList(request.getParameter("req_sessionid"),request.getParameter("req_boardid"),request.getParameter("standardpublishid"),"T");
    	  applicantList = applicationQuery.loadApprovedList(request.getParameter("standardpublishid"),"T");
    	    	
    	 if(applicantList!=null && applicantList.size()>0)
			{
    		 for (int i = 0, j = 1; i < applicantList.size(); i++) {
			
				HashMap applicantListMap=(HashMap)applicantList.get(i);
				String studentapprovalId  = (String)applicantListMap.get("studentapprovalid");
				String applicantName      = (String)applicantListMap.get("applicantname");
				String applicationNo      = (String)applicantListMap.get("applicationno");
				String dateofapproval     = (String)applicantListMap.get("dateofapproval");
				
				%>
				
				<tr>
        	 <td><%=j++ %></td>
            <td><%=applicantName %></td>
            <td><%=applicationNo %></td>
            <td><%=dateofapproval %> </td>
            <% 
            if(request.getParameter("req_sessionstatus")=="A" || request.getParameter("req_sessionstatus").equals("A"))
            {
            %>                     
            <td><a href="#"  studentapprovalid="<%=studentapprovalId%>" applicantname="<%=applicantName %>" applicationno="<%=applicationNo %>" statusval="Delete" status="X" onclick="statusChangeFun(this)" class="ask"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/user_logout.png" alt="" title="" border="0" /></a></td>
            <td><a href="#"  studentapprovalid="<%=studentapprovalId%>" applicantname="<%=applicantName %>" applicationno="<%=applicationNo %>" statusval="Restore" status="A" onclick="statusChangeFun(this)" class="ask"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/16-undo1.png" alt="" title="" border="0" /></a></td>
            <%
            }
            else
            {
            %>
            <td>-</td>
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



	<a href="#" class="bt_green" onclick="addnew_fun()"><span class="bt_green_lft"></span><strong>Add new item</strong><span class="bt_green_r"></span></a>
    <a href="#" class="bt_red" onclick="viewDeactive()"><span class="bt_red_lft"></span><strong>View Deactive Applicants </strong><span class="bt_red_r"></span></a>
    <a href="#" class="bt_blue" onclick="viewActive()"><span class="bt_blue_lft"></span><strong>View Active Applicants</strong><span class="bt_blue_r"></span></a>

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