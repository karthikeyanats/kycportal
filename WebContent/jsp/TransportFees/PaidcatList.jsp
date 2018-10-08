<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.iGrandee.TransportFees.FeesSettingsAction"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.examnamelist.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript" src="../highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/highslide/highslide.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/highslide/highslide-with-html.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript">
hs.graphicsDir = "<%=request.getContextPath()%>/js/highslide/graphics/"; 
hs.outlineType = 'rounded-white'; 
hs.wrapperClassName = 'draggable-header';  
function studentview(obj){
	document.feestypeform.transportcategoryname.value=obj.getAttribute("transportcategoryname");
	document.feestypeform.transportcategoryid.value=obj.getAttribute("transportcategoryid");
	document.feestypeform.action = "studentview.jsp"
	document.feestypeform.submit(); 
} 

function gonotpaid(obj){
	document.feestypeform.transportcategoryname.value=obj.getAttribute("transportcategoryname");
	document.feestypeform.transportcategoryid.value=obj.getAttribute("transportcategoryid");
	document.feestypeform.action = "notpaidstudentview.jsp"
	document.feestypeform.submit(); 
} 

function paydetail(obj)
{
	var transportcategoryid = obj.getAttribute("transportcategoryid");
	document.feestypeform.transportcategoryid.value=obj.getAttribute("transportcategoryid");
	document.feestypeform.transportcategoryname.value=obj.getAttribute("transportcategoryname");
	document.feestypeform.action = "Paidresult.jsp";
	document.feestypeform.submit(); 
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

    <h2>Transport Fees  / Paid Report / Session List / Category List</h2>
    
    <h2>Session Name: <%=request.getParameter("sessionname") %></h2>
    
<form name="feestypeform"  method="post">


<% 
String transportfeestypeid = null;
String sessionid    = null;String institutetransporttypeid=null;
sessionid= request.getParameter("sessionid");
institutetransporttypeid= request.getParameter("institutetransporttypeid");
%>
 <input type="hidden" name="sessionid" value="<%=sessionid%>"/>
		
<table id="rounded-corner" border=0 summary="Examname List" width="100%" align="center">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.examnamelist.SL.No")%></th>
        	<th scope="col" class="rounded" width="30%">Category</th>
            <th scope="col" class="rounded" width="30%">No.of.Paid</th>
        	<th scope="col" class="rounded-q4" width="30%">No.of.Not Paid</th>
        </tr>
    </thead>
    
   <!--  <tfoot>
    	<tr>
        	<td colspan="6" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot> -->
     
     <tbody> 	
     <jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.TransportFees.FeesSettingsAction" />
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.TransportFees.FeesSettingsAction"%>
     		 <%
			     FeesSettingsAction  transportmonth = new FeesSettingsAction();			     
			     ArrayList Loadtransportmonth = null;String transportcategoryname =null;
			     String transportcategoryid=null; ArrayList paycountlist=null;
					int payno=0;int notpayno=0;

			     HashMap innermap=null; 
				     try
				     {
				    	 Loadtransportmonth = transportmonth.getcatname(institutetransporttypeid,sessionid);
					    	 ArrayList archivalDetails = new ArrayList();
					    	 if(Loadtransportmonth!=null && Loadtransportmonth.size()>0)
								{
					    		 
					    		 for (int i = 0, j = 1; i < Loadtransportmonth.size(); i++) {
								
									HashMap feestypeListMap=(HashMap)Loadtransportmonth.get(i);
									 transportcategoryname   = (String)feestypeListMap.get("transportcategoryname");
									 transportcategoryid   	= (String)feestypeListMap.get("transportcategoryid");
									 
									%> 
								<%
									out.println("<tr>");
									out.println("<td>"+j+++"</td>"); 
									out.println("<td>"+transportcategoryname+"</td>");								
									
									
									notpayno=transportmonth.getnotpaidcount(transportcategoryid);
									payno=transportmonth.getpaidcount(transportcategoryid);
									if(payno==0)
										out.println("<td>"+payno+"</td>");
									else
										out.println("<td><a href='#' transportcategoryid='"+transportcategoryid+"'  transportcategoryname='"+transportcategoryname+"' onclick='studentview(this)'>"+payno+"</a></td>");
									if(notpayno==0)
										out.println("<td>"+notpayno+"</td>");							
									else
										out.println("<td><a href='#'  transportcategoryid='"+transportcategoryid+"' transportcategoryname='"+transportcategoryname+"' onclick='gonotpaid(this)'>"+notpayno+"</a></td>");
										
									out.println("</tr>");
					    		 }
							}
					    	 
					    	 else{
								out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");
					    	 }
				     }	 
					catch(Exception e){
						
						e.printStackTrace();
						
					}
			     %>
    </tbody>
 </table>
 <input type="hidden" name="transportcategoryid" value=""/>
 <input type="hidden" name="transportcategoryname">
 <input type="hidden" name="institutetransporttypeid" value="<%=institutetransporttypeid%>"/>
 	<input type="hidden" name="sessionname" value="<%=request.getParameter("sessionname")%>"/>
 
 
</form>  
		<a href="./Paidreport.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
		
     </div><!-- end of right content-->

  </div>   <!--end of center content -->
    <div class="clear"></div> 
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>