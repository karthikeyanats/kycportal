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
		
function categoryupdation(obj)
{ 
	if(obj.getAttribute("result")!='null'){
		
		alert("Amount Allocated for this Category");
		
	}
	else
	{
		if(confirm("Are you sure want to DeAllocate this Category?")){
			document.feestypeform.equalsmonth.value=obj.getAttribute("equalsmonth");
			
		//	document.feestypeform.institutetransporttypeid.value=obj.getAttribute("institutetransporttypeid");
			document.feestypeform.action="./Categoryunselect.jsp";
			document.feestypeform.submit();
		}
	}
}		 

function submitFun(){
	
	if(validflag>0)
		{
			if(confirm("Do you want to Allocate this Category?"))
			{	
				document.feestypeform.action="./CategorySubmit.jsp";
				document.feestypeform.submit();
			}
		}
	else{
		alert("Select any one option");
	}
}


function CheckFun(obj)
{
	var chkid = obj.getAttribute("value");
	//alert("chkid===>>"+chkid);		
		
	
}		


var validflag  =0;
function CheckFun(obj)
{
	chkid = obj.getAttribute("chkid");
	if(obj.checked)
	{
			validflag++;
	}
	else
	{
		validflag--;
	}
	
}


function Openstage(obj)
{
	var equalsmonth = obj.getAttribute("equalsmonth");
	document.feestypeform.action = "stagecatamountallot.jsp?equalsmonth="+equalsmonth;
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

    <h2>Discount / Paid Report / Session List / Category List / Paid Result</h2>
    
 
    <h2>Category Name:&nbsp;<%=request.getParameter("transportcategoryname") %></h2>
<form name="feestypeform" action="" method="post">


<% 
String transportfeestypeid = null;
String sessionid    = null;String institutetransporttypeid=null;
sessionid= request.getParameter("sessionid");
institutetransporttypeid= request.getParameter("institutetransporttypeid");
%>
 
		
<table id="rounded-corner" border=0 summary="Examname List" width="100%" align="center">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.examnamelist.SL.No")%></th>
        	<th scope="col" class="rounded" width="45%">No.of.Payed</th>
        	<th scope="col" class="rounded-q4" width="45%">No.of.Not Payed</th>
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
			     ArrayList Loadtransportmonth = null;String count =null;
			     String transportcategoryid=null;int paidcount=0;int notpaidcount=0;
			     transportcategoryid=request.getParameter("transportcategoryid");
				     try
				     {
				    	 Loadtransportmonth = transportmonth.getpayecount(transportcategoryid);
					    	 ArrayList archivalDetails = new ArrayList();
					    	 if(Loadtransportmonth!=null && Loadtransportmonth.size()>0)
								{
					    		 for (int i = 0, j = 1; i < Loadtransportmonth.size(); i++) {
								
									HashMap feestypeListMap=(HashMap)Loadtransportmonth.get(i);
									count   = (String)feestypeListMap.get("count");
									
									 
									%> 
								<%
								if(count.equals("paid")){
									paidcount++;
								}
								else{
									notpaidcount++;
								}
								
					    		 }
					    			out.println("<tr>");
									out.println("<td>1.</td>");
									out.println("<td><a href=''>"+paidcount+"</a></td>");								
									out.println("<td>"+notpaidcount+"</td>");								
								out.println("</tr>");
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