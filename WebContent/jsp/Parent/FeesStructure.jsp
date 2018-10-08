<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.feesstructureparent.entrytitle")%>  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>

<script language='javascript'>

	function callDairyView(obj){
	
		document.workallotment.dairyid.value 	= obj.getAttribute("dairyid");
		document.workallotment.action			= "DairyProcess.jsp";
		document.workallotment.submit();
	
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

    <h2><%=bundle.getString("label.feesstructureparent.entryheading")%></h2>
    
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java" import="java.util.ResourceBundle,java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,java.util.HashMap,java.text.NumberFormat,java.util.Locale"%>
<%
 com.iGrandee.Fees.FeesSchedule  feesscheduleQuery = new com.iGrandee.Fees.FeesSchedule();      String instituteid = null;
     ArrayList termfeesscheduleList = null;
     ArrayList feesheadscheduleList = null;
	String sectionid				= (String)session.getValue("sectionscheduleid");
	String studentid				= (String)session.getValue("studentid");
	HashMap	hashmap					= null;
	  int termtotalamount =0;
	  int headtotalamount =0;
	     String formattedCurrency = null;
	     //Locale localcurrency = new Locale("en", "IN");
	     ResourceBundle bundle1 	= 	ResourceBundle.getBundle("resources.serversetup");
Locale localcurrency = new Locale(bundle1.getString("language"), bundle1.getString("code"));
    	String standardscheduleid = (String)session.getValue("standardscheduleid");
    	  
     try
     { 
    	 termfeesscheduleList = feesscheduleQuery.loadTermFeesDetails(standardscheduleid);
    	 feesheadscheduleList = feesscheduleQuery.loadFeesHeadDetails(standardscheduleid);
    }catch(Exception e){}	
%>    
    
    
	<form name='workallotment' method='post'>
		<table class="bodyinnercolor" border=0 bordercolor='red' align="center" width="100%" height='100%' cellspacing=0 cellpadding=0>
			<tr>
				<td width='100%' align='center'>
				
					<table id="rounded-corner" border=0 summary="Department List" width="100%">
					    <thead>
					    	<tr>
					        	
					            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.feesstructureparent.StudentDetails")%></th>
					            <th scope="col" class="rounded-q4" width="2%"></th>
					        </tr>
					    </thead>
					    <tr>		
					    	<td colspan='2'>					
				
								<%
									out.print("<table  border='0' bordercolor='blue' align='center' width='100%' cellspacing='0' cellpadding='5'>");
									out.print("<tr><td width='17%' class=tablebold>"+bundle.getString("label.feesstructureparent.StudentName")+"</td><td width='1%'>:</td><td>"+session.getValue("studentname")+"</td></tr>");
									out.print("<tr><td class=tablebold>"+bundle.getString("label.feesstructureparent.AcademicYear")+"</td><td>:</td><td>"+session.getValue("sessionname")+"</td></tr>");
									if(session.getValue("groupname") == null)
										out.print("<tr><td class=tablebold>"+bundle.getString("label.feesstructureparent.StandardName")+"</td><td>:</td><td>"+session.getValue("standardname")+"</td></tr>");
									else
										out.print("<tr><td class=tablebold>"+bundle.getString("label.feesstructureparent.StandardName")+"</td><td>:</td><td>"+session.getValue("standardname")+"&nbsp;&nbsp;[&nbsp;"+session.getValue("groupname")+"&nbsp;]</td></tr>");
									out.print("<tr><td class=tablebold>"+bundle.getString("label.feesstructureparent.SectionName")+"</td><td>:</td><td>"+session.getValue("sectionname")+"</td></tr>");
									out.print("<tr><td class=tablebold>"+bundle.getString("label.feesstructureparent.BoardName")+"</td><td>:</td><td>"+session.getValue("boardname")+"</td></tr>");
									out.print("<tr><td class=tablebold>"+bundle.getString("label.feesstructureparent.MediumName")+"</td><td>:</td><td>"+session.getValue("mediumname")+"</td></tr>");
									out.print("</table>");
								%>	
							</td>
						</tr>
					</table>	
					<br><br>	
					<table border=0 cellpadding=5 cellspacing=0 width="100%">
			<tr valign=top><td width="50%">
			
		     <table border=1 cellpadding=5 cellspacing=0 width="100%">
		        <tr><td colspan=2 class=tablebold align=center> <%=bundle.getString("label.feesstructureparent.TermwiseAmount") %> </td></tr>
		     
		    <tr class=tableheading><td><%= bundle.getString("label.feesstructureparent.TermName")%> </td><td align=right><%= bundle.getString("label.feesstructureparent.Amount")%></td></tr>
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
			    	out.println("<tr><td class=tablebold>"+bundle.getString("label.feesstructureparent.Total")+"</td><td>"+formattedCurrency+"</td></tr>");
			    }else{
			    	out.println("<tr align='center' class='tablebold'><td colspan='2'><font color='red'>Data Not Found</font></td></tr>");
					//out.println("<tr><td colspan=2>Data not found</td></tr>");
				}%>
				</table>
		</td>
		<td width="50%">
		  <table border=1 cellpadding=5 cellspacing=0 width="100%">
   <tr><td colspan=2 class=tablebold align=center><%= bundle.getString("label.feesstructureparent.FeesHeadwiseAmountDetails")%></td></tr>
    <tr  class=tableheading><td><%= bundle.getString("label.feesstructureparent.HeadName")%></td><td><%= bundle.getString("label.feesstructureparent.Amount")%></td></tr><%
	
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
	    	out.println("<tr><td class=tablebold>"+bundle.getString("label.feesstructureparent.Total")+"</td><td>"+formattedCurrency+"</td></tr>");
	    }else{
	    	out.println("<tr align='center' class='tablebold'><td colspan='2'><font color='red'>Data Not Found</font></td></tr>");
	    	//out.println("<tr><td colspan=2>Data not found</td></tr>");
		}%>
		
	</table>
	</td></tr></table>
		
		</td></tr></table>
	</form>    
    

    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>