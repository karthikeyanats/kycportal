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
function showstudents(obj)
{
//	var transportcategoryid = obj.getAttribute("transportcategoryid");
//	var paidstatus = obj.getAttribute("paidstatus");
	document.feestypeform.transportcategoryid.value=obj.getAttribute("transportcategoryid");
	document.feestypeform.req_paidstatus.value=obj.getAttribute("paidstatus");
	document.feestypeform.transportcategoryname.value=obj.getAttribute("transportcategoryname");
	
	document.feestypeform.action = "categorystudentlist.jsp";
	document.feestypeform.submit(); 
	
	}
	function printfun()
	{
		window.open("./newtransportprint.jsp?institutetransporttypeid="+document.feestypeform.institutetransporttypeid.value+"&sessionid="+document.feestypeform.reqsessionid.value+"&sessionname="+document.feestypeform.sessionname.value,"Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=800,scrollbars=1;")
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

    <h2>Transport Fees  / Paid Report / Category List</h2>
    
    
<form name="feestypeform"  method="post">


<% 
String transportfeestypeid = null;
String sessionid    = null;String institutetransporttypeid=null;
sessionid= request.getParameter("sessionid");
String paidstatus = null;
institutetransporttypeid= request.getParameter("institutetransporttypeid");
%>
 <input type="hidden" name="sessionid" value="<%=sessionid%>"/>
 
 <table id="rounded-corner" border=0 summary="Examname List" width="100%" align="center">
     <thead>
    	<tr>
        	<th scope="col" class="rounded-company" colspan=2>Selected Info</th>
        	<th scope="col" class="rounded-q4" width="30%"></th>
        	</tr></thead>
 
 <tr>
 <td class=tablebold width="15%"> Academic Year</td><td class=tablelight colspan=3 width="10%" align=left><%=request.getParameter("sessionname") %></td>
 
 </tr>
 </table>
		<br></br>
<table id="rounded-corner" border=0 summary="Examname List" width="100%" align="center">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.examnamelist.SL.No")%></th>
        	<th scope="col" class="rounded" width="30%">Category</th>
            <th scope="col" class="rounded" width="30%">No.of Paid Students</th>
        	<th scope="col" class="rounded-q4" width="30%">No.of Pending Students</th>
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
					    	 String paid=null; String notpaid= null;
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
									
									
									/* notpayno=transportmonth.getnotpaidcount(transportcategoryid);
									payno=transportmonth.getpaidcount(transportcategoryid); */
									ArrayList paidstate = transportmonth.listpaymentdetails(transportcategoryid,sessionid);
									//out.println("paidstate===>>>"+paidstate);
									
									  if(paidstate!=null && paidstate.size()>0)
										{
										 HashMap paidstateMap=(HashMap)paidstate.get(0);
										 paidstatus = (String)paidstateMap.get("paidstatus");
										 //out.println("paidstatus===>>>"+paidstatus);
										 if(paidstateMap.get("paid") ==null)
											 	paid = "0";
										 else
											 paid   = (String)paidstateMap.get("paid");
										
										 if(paidstateMap.get("notpaid") ==null)
											 notpaid = "0";
										 else
											 notpaid   = (String)paidstateMap.get("notpaid");
										 
										 if(paid.equals("0"))
										 {
											 out.println("<td>"+paid+"</td>");
										 }
										 else
										 {
											 out.println("<td><a href='#' transportcategoryid='"+transportcategoryid+"' transportcategoryname='"+transportcategoryname+"' paidstatus='paid' onclick='showstudents(this)'>"+paid+"</a></td>");
										 }
											//out.println("<td><a href='#' transportcategoryid='"+transportcategoryid+"' transportcategoryname='"+transportcategoryname+"' paidstatus='paid' onclick='showstudents(this)'>"+paid+"</a></td>");
											if(notpaid.equals("0"))
										 {
											 out.println("<td>"+notpaid+"</td>");
										 }
										 else
										 {
											 out.println("<td><a href='#' transportcategoryid='"+transportcategoryid+"' paidstatus='pending' transportcategoryname='"+transportcategoryname+"' onclick='showstudents(this)'>"+notpaid+"</a></td>");
										 }
											
										}
									 else
									 {
										 out.println("<td>0</td><td>0</td>");
									 }
										
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
 <input type="hidden" name="transportcategoryname" /> 
 <input type="hidden" name="institutetransporttypeid" value="<%=institutetransporttypeid%>"/>
 	<input type="hidden" name="sessionname" value="<%=request.getParameter("sessionname")%>"/>
 	<input type="hidden" name="sessionid" value="<%=sessionid%>"/>
 	<input type="hidden" name="reqsessionid" value="<%=sessionid%>"/>
 	
 	<input type="hidden" name="req_paidstatus"/>
 	
 
 
</form>  
		<a href="./Paidreport.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
		<a href="#" class="bt_green" onclick="printfun()"><span class="bt_green_lft"></span><strong>Print</strong><span class="bt_green_r"></span></a>
		
     </div><!-- end of right content-->

  </div>   <!--end of center content -->
    <div class="clear"></div> 
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>