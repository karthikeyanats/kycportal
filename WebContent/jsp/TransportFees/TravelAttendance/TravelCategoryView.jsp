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

function Openstage(obj)
{
	var equalsmonth = obj.getAttribute("equalsmonth");
	document.feestypeform.action = "stagecatamountallot.jsp?equalsmonth="+equalsmonth;
	document.feestypeform.submit();
}

function LoadingRoute(obj)
{
	var transportcategoryid = obj.getAttribute("transportcategoryid");
	document.feestypeform.transportcategoryid.value = obj.getAttribute("transportcategoryid");	
	document.feestypeform.action = "TravelRoute.jsp";
	document.feestypeform.submit();
}


</script>

</head>
<body>
<div id="main_container">
	<div class="header">
<%@ include file="../../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">


<%@ include file="../../include/header.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2>Transport Fees / Travel Attendance / Category View </h2>
    
    
    
<form name="feestypeform" action="" method="post">
<input type=hidden name=examnameid_hidden>
<input type=hidden name=examname_hidden>
<input type=hidden name=examnameremarks_hidden>
<input type=hidden name=createdby_hidden>

<%
String transportfeestypeid = null;

String sessionid    = (String)session.getValue("sessionid");
String sessionname    = (String)session.getValue("sessionname");
//out.println("sessionid===>>"+sessionid);
String reqsessionid = request.getParameter("sessionid");
transportfeestypeid = request.getParameter("transportfeestypeid"); 
String transportfeestypename = request.getParameter("tn");
String institutetransporttypeid = request.getParameter("ittid");

String transportcategoryname = null;
String transportcategoryid = null;
String equalsmonth = null;

%>


				
		<table width="100%" >
				<tr>
			    		<td width="15%"> 
			    			<h4></>Year of Session: </h4>
			    		</td>
			    		<td>
			    			<%=sessionname %>
			    		</td>
			    		
			    	</tr>
			    
			</table>
				
			

<table id="rounded-corner" border=0 summary="Examname List" width="100%" align="center">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.examnamelist.SL.No")%></th>
        	<th scope="col" class="rounded" width="20%">Category Name</th>
        	<th scope="col" class="rounded" width="20%">Route</th>
        	<th scope="col" class="rounded-q4" width="20%">Attendance</th>
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
	class="com.iGrandee.TransportFees.TransportRouteAction" />
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.TransportFees.FeesSettingsAction"%>

     		<!-- Sindhu -->
     		
     		 <%
			     FeesSettingsAction  amountsettin = new FeesSettingsAction();
			     String instituteid = null;
			     ArrayList LoadamountsettinList = null;
				     try
				     {
				    	  instituteid = (String)session.getValue("instituteid"); 
				    	 	//out.println("instituteid===>>>"+instituteid);
				    	  LoadamountsettinList = amountsettin.Travelcategoryname(sessionid);
				    	
					    	  ArrayList archival = new ArrayList();
					    	  if(LoadamountsettinList!=null && LoadamountsettinList.size()>0)
								{
					    		 for (int k = 0, m = 1; k < LoadamountsettinList.size(); k++) {
								
									HashMap AmountListMap=(HashMap)LoadamountsettinList.get(k);
									
									transportcategoryid        = (String)AmountListMap.get("transportcategoryid");
									transportcategoryname   	= (String)AmountListMap.get("transportcategoryname");
		
				%>  
				
								 <tr>
							    		<td>
							    			<%=m++ %>.
							    		</td>
							    		
							    		<td>
							    			<%=transportcategoryname %> 
							    		</td>	
							    		
							    		<td>
							    			<a href='#' transportcategoryid=<%=transportcategoryid %> onClick='LoadingRoute(this)' style='text-decoration:none;'>Show Route</a>
							    		</td>
							    		
							    		<td>
							    			0 
							    		</td>		    		
							    		
							    	</tr>
			    	
				<%	
				  
		    		 }					    		 
	    		 		
					}
					  else{
					    		  
						 out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");
					   }
					    	  
			     }catch(Exception e){}
			          
			     %>
     		</table>
    	
    </tbody>
      
</table>

	
	<input type="hidden" name="sessionid" value=<%=reqsessionid %> />
	<input type="hidden" name="transportfeestypeid" value=<%=transportfeestypeid %> /> 
	<input type="hidden" name="institutetransporttypeid" value=<%=institutetransporttypeid %> />
	<input type="hidden" name="tn" value=<%=transportfeestypename %> /> 
	<input type="hidden" name="transportcategoryname" value=<%=transportcategoryname %> />
	<input type="hidden" name="transportcategoryid" value=<%=transportcategoryid %> />	
	
	

</form>

	<%--	<a href="#" feestypename=<%=transportfeestypeid %> sessionid=<%=sessionid %> onClick="SaveFesstype(this)" class="bt_green"><span class="bt_green_lft"></span><strong>Save</strong><span class="bt_green_r"></span></a>
		
      <a href="./ExamnameDeactivatedViewList.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.examnamelist.deactivatelist")%></strong><span class="bt_blue_r"></span></a>
     <a href="./ExamnameTrashedView.jsp" class="bt_red"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.examnamelist.trashitems")%></strong><span class="bt_red_r"></span></a> --%>

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>