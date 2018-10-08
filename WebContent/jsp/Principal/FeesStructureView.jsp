<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle1  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle1.getString("label.feesstructureview.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="ddaccordion.js"></script>
<script type="text/javascript">

function goBack()
{
	document.applicationForm.action= "FeesStructureSelect.jsp";
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

    <h2><%=bundle1.getString("label.feesstructureview.rootpath")%></h2>

<form name="applicationForm" action="" method="post">

<input type=hidden name=standardpubid_hidden>

<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
            <th scope="col" class="rounded-company" width="90%"><%=bundle1.getString("label.feesstructureview.SelectedInformation")%> </th>
            <th scope="col" class="rounded-q4" width="10%"></th>        
        </tr>
    </thead>
    
        <tfoot>
    	<tr>
        	<td  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
    
    <tr><td colspan=2>
    <table border=0 align=center id="rounded-corner" width="100%">
	<tr>
		<td class=tablebold width="25%"> <%=bundle1.getString("label.feesstructureview.AcademicYear")%></td>
		<td width='1%' class='tablebold'>:</td>
		<td class=tablelight ><%=request.getParameter("req_sessionname") %></td>
		<td class=tablebold><%=bundle1.getString("label.feesstructureview.Board")%></td>
		<td width='1%' class='tablebold'>:</td>
		<td  colspan=2  class=tablelight><%=request.getParameter("req_boardname") %></td>
	</tr>
	<tr><td class=tablebold width="25%"><%=bundle1.getString("label.feesstructureview.Standard")%> </td>
	<td width='1%' class='tablebold'>:</td>
	<td class=tablelight colspan=3><%=request.getParameter("standardnamegp") %></td>

</tr>
</table>
</td></tr>
</table>

<br>
     <%@ page import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess,com.iGrandee.Fees.FeesSchedule,java.text.NumberFormat,java.util.Locale"%>

<%
	com.iGrandee.Fees.FeesSchedule  feesscheduleQuery = new com.iGrandee.Fees.FeesSchedule();
      ArrayList termfeesscheduleList = null;
     ArrayList feesheadscheduleList = null;
	//String sectionid				= (String)session.getValue("sectionscheduleid");
	//String studentid				= (String)session.getValue("studentid");
	HashMap	hashmap					= null;
	  int termtotalamount =0;
	  int headtotalamount =0;
	     String formattedCurrency = null;
	     //Locale localcurrency = new Locale("en", "IN");
	     ResourceBundle bundle 	= 	ResourceBundle.getBundle("resources.serversetup");
Locale localcurrency = new Locale(bundle.getString("language"), bundle.getString("code"));
	     
    	//String standardscheduleid = (String)session.getValue("standardscheduleid");
    	String standardscheduleid = request.getParameter("standardpublishid");
    	  
     try
     { 
    	 termfeesscheduleList = feesscheduleQuery.loadTermFeesDetails(standardscheduleid);
    	 feesheadscheduleList = feesscheduleQuery.loadFeesHeadDetails(standardscheduleid);
    }catch(Exception e){}	
%>  
					<table border=0 cellpadding=5 cellspacing=0 width="100%">
			<tr valign=top><td width="50%">
			
		     <table border=1 cellpadding=5 cellspacing=0 width="100%">
		        <tr><td colspan=2 class=tablebold align=center> <%=bundle1.getString("label.feesstructureview.TermwiseAmount")%> </td></tr>
		     
		    <tr class=tableheading><td> <%=bundle1.getString("label.feesstructureview.TermName")%></td><td align=right><%=bundle1.getString("label.feesstructureview.Amount")%></td></tr>
		   	    	<%
			
					if(termfeesscheduleList!=null && termfeesscheduleList.size()>0)
			    	{ int inc = 1;
			    	for(int y=0;y<termfeesscheduleList.size();y++){
						
			    		HashMap termfeesscheduleListMap		= (HashMap)termfeesscheduleList.get(y);
						
			    		String termname     = (String)termfeesscheduleListMap.get("termname");
			    		String termid      = (String)termfeesscheduleListMap.get("termid");
			    		String termfeesid      = (String)termfeesscheduleListMap.get("termfeesid");
			    		String termfeesamount      = (String)termfeesscheduleListMap.get("termfeesamount");
			    	%>
				<tr>
					<td class=tablebold><%= termname%></td>
					<td class=tablelight><%= termfeesamount%></td>
				</tr>
				<%
				headtotalamount +=Integer.parseInt(termfeesamount);
				
			    	}
			    	Long lObj2 = Long.valueOf(headtotalamount);
				    NumberFormat format = NumberFormat.getCurrencyInstance(localcurrency);
				    formattedCurrency = format.format(lObj2);
			    	out.println("<tr><Td>Total</td><td>"+formattedCurrency+"</td></tr>");
			    }else{
			    	out.println("<tr class='tablebold'><td align='center' colspan=2><font color='red'>Data Not Found</font></td></tr>");
				}%>
				</table>
		</td>
		<td width="50%">
		  <table border=1 cellpadding=5 cellspacing=0 width="100%">
   <tr><td colspan=2 class=tablebold align=center> <%=bundle1.getString("label.feesstructureview.FeesHeadwiseAmountDetails")%></td></tr>
    <tr  class=tableheading><td> <%=bundle1.getString("label.feesstructureview.HeadName")%></td><td><%=bundle1.getString("label.feesstructureview.Amount")%></td></tr><%
	
			if(feesheadscheduleList!=null && feesheadscheduleList.size()>0)
	    	{ int inc = 1;
	    	for(int y=0;y<feesheadscheduleList.size();y++){
				
	    		HashMap feesheadscheduleListtMap		= (HashMap)feesheadscheduleList.get(y);
				
	    		String feesheadid     = (String)feesheadscheduleListtMap.get("feesheadid");
	    		String feesheadname      = (String)feesheadscheduleListtMap.get("feesheadname");
	    		String feesscheduleamount      = (String)feesheadscheduleListtMap.get("feesscheduleamount");
	    	%>
		<tr>
			<td  class=tablebold><%= feesheadname%></td>
			<td class=tablelight><%= feesscheduleamount%></td>
		</tr>
		<%
		termtotalamount +=Integer.parseInt(feesscheduleamount);
		
	    	}
	    	Long lObj2 = Long.valueOf(termtotalamount);
		    NumberFormat format = NumberFormat.getCurrencyInstance(localcurrency);
		    formattedCurrency = format.format(lObj2);
	    	out.println("<tr><Td>Total</td><td>"+formattedCurrency+"</td></tr>");
	    }else{
	    	out.println("<tr  class='tablebold'><td align='center' colspan=2><font color='red'>Data Not Found</font></td></tr>");
		}%>
		
	</table>
	</td></tr></table>
		
		</td></tr></table>
		
		<br>

    <a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong><%=bundle1.getString("button.feesstructureview.Back")%></strong><span class="bt_blue_r"></span></a>

	<input type=hidden name="req_sessionname" value = "<%=request.getParameter("req_sessionname")%>">
	<input type=hidden name="req_sessionid" value = "<%=request.getParameter("req_sessionid")%>">
	<input type=hidden name="req_boardname" value = "<%=request.getParameter("req_boardname")%>">
	<input type=hidden name="req_boardid" value = "<%=request.getParameter("req_boardid")%>">
	<input type=hidden name="standardnamegp" value = "<%=request.getParameter("standardnamegp")%>">
	<input type=hidden name="standardpublishid" value = "<%=request.getParameter("standardpublishid")%>">
	<input type=hidden name="req_sessionstatus" value = "<%=request.getParameter("req_sessionstatus")%>">
		
	<input type=hidden name="statuschange">
	
	
	
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>