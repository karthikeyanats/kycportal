<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.applicationissueinsert.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">

function printPrev()
{
	//var rece=document.ApplicantSearch.receipt.value
	var applno			=	document.ApplicantSearch.Applicationno.value;
	var standardnamegp	=	document.ApplicantSearch.standardnamegp.value;
	var req_sessionname	=	document.ApplicantSearch.req_sessionname.value
	var req_boardname	=	document.ApplicantSearch.req_boardname.value
	
	//alert("standardnamegp-->"+standardnamegp)
	window.open("./ApplicationReceiptPrint.jsp?applno="+applno+"&standardnamegp="+standardnamegp+"&req_sessionname="+req_sessionname+"&req_boardname="+req_boardname+"","Msg","top=250,left=350,help:no,center:no,status:no,width=500,height=400;")
}

function goBack()
{
   document.ApplicantSearch.action="ApplicationIssue.jsp";
	document.ApplicantSearch.submit();
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

    <h2><%=bundle.getString("label.applicationissueentry.rootpath")%></h2>
<form name="ApplicantSearch" action="" method="post">

<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        
        	<th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.applicationissueentry.ApplicationIssue")%></th>
        	<th scope="col" class="rounded-q4" width="10%" ></th>            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     </tbody>
	<%@ page import="java.util.Date,java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.ApplicationQuery"%>    
	<%
		com.iGrandee.Application.ApplicationQuery  applicationQuery = new com.iGrandee.Application.ApplicationQuery();	
		com.iGrandee.Application.ApplicationBean applicationBean = new com.iGrandee.Application.ApplicationBean();
		String req_sessionid = "";
		String req_sessionname  = "";
		String req_boardid = "";
		String req_boardname  = "";

		String applicantName=request.getParameter("applicantName");
		String standardpublishid=request.getParameter("standardpublish");
		String standardnamegp	=	request.getParameter("standardnamegp");
		//String applicationNo=request.getParameter("applicationNo");
		String applicationNo=applicationBean.getApplicationno();
		String applicationCost=request.getParameter("applicationCost");
		String receiptNo=request.getParameter("receiptno");
		String receipt=request.getParameter("receipt");
		String collegeType=request.getParameter("collegeType");
		String contactno=request.getParameter("contactno");
		String emailid=request.getParameter("emailid");
		req_sessionid  	= request.getParameter("req_sessionid");
		req_sessionname = request.getParameter("req_sessionname");
		req_boardid  	= request.getParameter("req_boardid");
		req_boardname  	= request.getParameter("req_boardname"); 
		
		
		//out.println("applicantName-->"+applicantName+"receiptno-->"+receiptNo+"applicationNo-->"+applicationNo+"applicationCost-->"+applicationCost+"contactno-->"+contactno+"standardpublishid-->"+standardpublishid);
		String colFormat=null;
		int number=0;
		
		
		
		if(request.getParameter("colFormat")!=null)
		{
		
		
		 colFormat=request.getParameter("colFormat");
		//  number=Integer.parseInt(colFormat);
		}
		
		String appId=null;
		String applicantname=null;
		String Applicationno=null;
		String appCost=null;
		Date d=new Date();
	    
		String formattedappCostCurrency = null;
		// Locale localcurrency = new Locale("en", "IN");
		java.util.ResourceBundle bundle1 	= 	java.util.ResourceBundle.getBundle("resources.serversetup");
		java.util.Locale localcurrency = new java.util.Locale(bundle1.getString("language"), bundle1.getString("code"));		
		//String corseType;
		//int month=1+d.getMonth();
		//int year= 1900+d.getYear();
		//String date=d.getDate()+" - "+month+" - "+year;
		//int rep=Integer.parseInt(receipt);
		float cost=0;
		if(applicationCost!=null)
		{
		 cost=Float.parseFloat(applicationCost);
		}
		int code=0;
		ArrayList valueList=null;
		valueList=applicationQuery.getApplicantDetails(applicationNo);
		//out.println(applicationNo);
		//out.println(valueList.size());
		if(valueList.size()==0)
		{
			int standardSchedId = Integer.parseInt(standardpublishid);
			int yearofsessionId = Integer.parseInt(req_sessionid);
			int boardId 		= Integer.parseInt(req_boardid);
			
			String createdby = (String)session.getValue("userid");
			String ipaddress = request.getRemoteAddr();
			String instituteid = (String)session.getValue("instituteid");

			applicationBean.setApplicantname(applicantName);
			//applicationBean.setApplicationno(applicationNo);
			applicationBean.setApplicationcost(applicationCost);
			applicationBean.setContactno(contactno);
			applicationBean.setEmailid(emailid);		
			applicationBean.setStandardscheduleid(standardSchedId); 
			applicationBean.setCreatedby(createdby);
			applicationBean.setIpaddress(ipaddress);
			applicationBean.setInstituteid(instituteid);
			applicationBean.setSessionid(yearofsessionId);
			applicationBean.setBoardid(boardId);
			
			
			
			//rows += applicationQuery.updateApplication(applicationBean);
			
			code = applicationQuery.applicationInsert(applicationBean);
			//code=applicationQuery.applicationInsert(applicantName,applicationNo,cost,contactno,emailid,standardpublishid,req_sessionid,req_boardid,createdby,ipaddress,instituteid);
		} 
		//out.println(rep);
		//valueList=applicationQuery.getApplicantDetails(applicationNo);
		valueList=applicationQuery.getApplicantDetails(code+"");
	%>
		<input type=hidden name="req_sessionname" value = "<%=req_sessionname %>">
		<input type=hidden name="req_sessionid" value = "<%=req_sessionid %>">
		<input type=hidden name="req_boardname" value = "<%=req_boardname %>">
		<input type=hidden name="req_boardid" value = "<%=req_boardid %>">


    							<tr><td colspan=2><table border=0 align=center id="rounded-corner1" width="100%">
								<%
								//String temp=applicationQuery.receiptNo();

								%>
								<%String check = "";
								for(int i=0;i<valueList.size();i++)
								{
									HashMap map=(HashMap)valueList.get(i);


									 appId=(String)map.get("applicationid");
									 applicantname=(String)map.get("applicantname");
									 Applicationno=(String)map.get("applicationno");
									 appCost=(String)map.get("cost");
									 String receiptno=(String)map.get("receiptno");
									 //corseType=(String)map.get("type");
									 contactno=(String)map.get("contactno");
									 emailid = (String)map.get("emailid");
									 if(emailid.equals(""))
										 emailid = "-";
									 standardpublishid=(String)map.get("standardpublishid");
									 String standardname=(String)map.get("standardname");
									// String check=corseType.substring(0,1);

									Long appFeeObj = Long.valueOf(appCost);
									java.text.NumberFormat format = java.text.NumberFormat.getCurrencyInstance(localcurrency);
    	    						formattedappCostCurrency = format.format(appFeeObj);	

									out.println("<tr class='tablehead'><td class='tablebold'>"+bundle.getString("label.applicationissueentry.ReceiptNo")+"&nbsp;</td><td class=tablebold width='2%'>:</td><td>"+receiptno+"</td></tr><tr><td class='tablebold'>"+bundle.getString("label.applicationissueentry.AcademicYear")+" </td><td class=tablebold width='2%'>:</td><td>"+req_sessionname +"</td></tr><tr><td class='tablebold'>"+bundle.getString("label.applicationissueentry.BoardName")+" </td><td class=tablebold width='2%'>:</td><td>"+req_boardname +"</td></tr>");

									out.println("<tr class='tablelight'><td class='tablebold'>"+bundle.getString("label.applicationissueentry.StandardName")+"</td><td class=tablebold width='2%'>:</td><td>"+standardnamegp+"</td></tr>");
									out.println("<tr class='tablelight'><td class='tablebold' width='50%'>"+bundle.getString("label.applicationissueentry.ApplicantName")+"</td><td class=tablebold width='2%'>:</td><td>"+applicantname+"</td></tr>");
									out.println("<tr class='tablelight'><td class='tablebold'>"+bundle.getString("label.applicationissueentry.ApplicationNo")+".</td><td class=tablebold width='2%'>:</td><td>"+Applicationno+"</td></tr>");
									out.println("<tr class='tablelight'><td class='tablebold'>"+bundle.getString("label.applicationissueentry.ApplicationFee")+"</td><td class=tablebold width='2%'>:</td><td>"+formattedappCostCurrency+"</td></tr>");
									out.println("<tr class='tablelight'><td class='tablebold'>"+bundle.getString("label.applicationissueentry.PhoneNo")+".</td><td class=tablebold width='2%'>:</td><td>"+contactno+"</td></tr>");
									out.println("<tr class='tablelight'><td class='tablebold'>"+bundle.getString("label.applicationissueentry.E-mail")+"</td><td class=tablebold width='2%'>:</td><td>"+emailid+"</td></tr>");
									


									}
								%>


								</table><br></td></tr>

							</table>
							<input type="hidden" name="receipt" value="<%=appId%>">
							<input type="hidden" name="applicantname" value="<%=applicantname%>">
							<input type="hidden" name="Applicationno" value="<%=Applicationno%>">
							<input type="hidden" name="applicationCost" value="<%=appCost%>">
							<input type="hidden" name="standardnamegp" value="<%=standardnamegp%>">
							<input type=hidden name="req_sessionstatus" value = "<%=request.getParameter("req_sessionstatus") %>">

</form>

     <a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.applicationissueentry.Back")%></strong><span class="bt_blue_r"></span></a>
	<a href="#" class="bt_green" onclick="printPrev()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.applicationissueentry.Print")%></strong><span class="bt_green_r"></span></a>

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>
