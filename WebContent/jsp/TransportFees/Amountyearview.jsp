<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.iGrandee.TransportFees.FeesSettingsAction"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.examnamelist.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript">

function FeestypeView(obj)
{	
	var sessionid=obj.getAttribute("sessionid");
	document.yearviewform.action = "Transporttypeview.jsp?sessionid="+sessionid;
	document.yearviewform.submit();
}

function Monthview(obj)
{	
	
	document.yearviewform.transportfeestypeid.value=obj.getAttribute("transportfeestypeid");
	document.yearviewform.sessionid.value = obj.getAttribute("sessionid");
	document.yearviewform.ittid.value = obj.getAttribute("ittid");
	//alert("ittid===>>>"+ittid);
	document.yearviewform.tn.value=obj.getAttribute("tn");
	document.yearviewform.action = "AmountCategorytype.jsp";
	document.yearviewform.submit();
}


function Termview(obj)
{	
	document.yearviewform.transportfeestypeid.value=obj.getAttribute("transportfeestypeid");
	document.yearviewform.ittid.value = obj.getAttribute("ittid");
	document.yearviewform.sessionid.value = obj.getAttribute("sessionid");
	//alert("ittid===>>>"+ittid);
	document.yearviewform.tn.value=obj.getAttribute("tn");
	document.yearviewform.action = "AmountCategorytype.jsp";
	document.yearviewform.submit();	
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

    <h2>Transport Fees / Stage Amount Allocation / List Session </h2>
    
<form name="yearviewform"  method="post">
<%

String sessionids = (String)session.getAttribute("sessionid");

%>
<table id="rounded-corner" border=0 summary="Examname List" width="100%" align="center">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.examnamelist.SL.No")%></th>
            <th scope="col" class="rounded" width="35%">Academic Year</th>
            <th scope="col" class="rounded" width="25%">Fees Type</th>
              <th scope="col" class="rounded-q4" width="30%">Set Amount</th>
          
        </tr>
    </thead>
    
   <!--  <tfoot>
    	<tr>  
        	<td colspan="6" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td> 
       </tr>
    </tfoot> -->
    
     <tbody>
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.TransportFees.FeesSettingsAction"%>

     		<!-- Sindhu -->
     		
     		 <%
			     FeesSettingsAction  YearofSession = new FeesSettingsAction();
			     String instituteid = null;String institutetransporttypeid=null;
			     ArrayList LoadyearofsessionList = null;
				     try
				     {
				    	  instituteid = (String)session.getValue("instituteid"); 
				    	  //out.println("instituteid===>>"+instituteid);
				    	  LoadyearofsessionList = YearofSession.getyearofsession(instituteid);     	 

					    	  ArrayList archivalDetails = new ArrayList();
					    	  if(LoadyearofsessionList!=null && LoadyearofsessionList.size()>0)
								{
					    		 for (int i = 0, j = 1; i < LoadyearofsessionList.size(); i++) {
								
									HashMap SessionListMap=(HashMap)LoadyearofsessionList.get(i);
									
									String sessionid        = (String)SessionListMap.get("sessionid");
									String sessionname   	= (String)SessionListMap.get("sessionname");
									String transportfeestypeid = (String)SessionListMap.get("transportfeestypeid");
									String transportfeestypename = (String)SessionListMap.get("transportfeestypename");
									String sessionstatus    = (String)SessionListMap.get("sessionstatus");
									institutetransporttypeid = (String)SessionListMap.get("institutetransporttypeid");
									 %>  
					<tr>
						<td><%=j++ %>.</td>
							<%
							if(sessionstatus.equalsIgnoreCase("R"))
							{
							%>	
							<td><%=sessionname %>(Archived Session) </td>
							<td> 
							<%
							if(transportfeestypename !=null) 
							{	
							%>
							<%=transportfeestypename %>
							<%
							}else
							{	
							%>
							-
							<%
							}
							%>
							</td>
							<td>-</td>
							<%
							}else{
								%>
								<td>
								<%
								if(transportfeestypeid != null)
								{	
								%>
								<%=sessionname %>
								<%
								}else
								{	
								%>
								<%=sessionname %>
								<%
								}
								%>
								</td>
								<td>
								
									<%
									if(transportfeestypename !=null)
									{	
									%>
									<%
									if(transportfeestypename.equalsIgnoreCase("Year"))
									{	
									%>	
									<%=transportfeestypename %>
									<%
									}else if(transportfeestypename.equalsIgnoreCase("Month Wise"))
									{	
									%>
										<%=transportfeestypename %>
									<%
									}else
									{	
									%>
									<%=transportfeestypename %>
									<%
									}
									%>
									<%
									}else
									{	
									%>
									-
									<%
									}
									%>
								</td>
								
								<td>
								
									<%
									if(transportfeestypename !=null)
									{	
									%>
									<%
									if(transportfeestypename.equalsIgnoreCase("Year"))
									{	
									%>	
									<a href="#" sessionid=<%=sessionid %> transportfeestypeid=<%=transportfeestypeid %> tn=<%=transportfeestypename %> ittid="<%=institutetransporttypeid %>" onClick="Monthview(this)" style="text-decoration:cursor;">Set Amount</a>
									<%
									}else if(transportfeestypename.equalsIgnoreCase("Month Wise"))
									{	
									%>
										<a href="#" sessionid=<%=sessionid %> transportfeestypeid=<%=transportfeestypeid %> tn=<%=transportfeestypename %> ittid="<%=institutetransporttypeid %>" onClick="Monthview(this)" style="text-decoration:cursor;">Set Amount</a>
									<%
									}
									else if(transportfeestypename.equalsIgnoreCase("Term Wise"))
									{	 
									%>
										<a href="#" sessionid=<%=sessionid %> transportfeestypeid=<%=transportfeestypeid %> tn=<%=transportfeestypename %> ittid="<%=institutetransporttypeid %>" onClick="Termview(this)" style="text-decoration:cursor;">Set Amount</a>
									<%
									} 
									
									else
									{	
									%>
										Set Amount
									<%
									}
									%>
									<%
									}else
									{	
									%>
									-
									<%
									}
									%>
								</td>
								
								
							<%	
							}
							%>								
								
					</tr>				 
				
				<%	
								
						    		 }					    		 
					    		 		
									}
			     }catch(Exception e){}
			          
			     %>
     		
     		
    	
    </tbody>
</table>

<input type='hidden' name='ittid' value="" />
<input type='hidden' name='sessionid' value="" />
<input type='hidden' name='tn' value="" />
<input type='hidden' name='transportfeestypeid' value="" />
<input type='hidden' name='reqsessionid' value="" />

<input type='hidden' name='feestypeid' value="" />
<input type='hidden' name='f' value="" /> 
<input type='hidden' name='transportfeestypename' value="" />
<input type='hidden' name='institutetransporttypeid' value="" />


</form>


	<%-- <a href="./ExamnameEntry.jsp" class="bt_green"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.examnamelist.addnew")%></strong><span class="bt_green_r"></span></a>
     <a href="./ExamnameDeactivatedViewList.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.examnamelist.deactivatelist")%></strong><span class="bt_blue_r"></span></a>
     <a href="./ExamnameTrashedView.jsp" class="bt_red"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.examnamelist.trashitems")%></strong><span class="bt_red_r"></span></a> --%>

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>