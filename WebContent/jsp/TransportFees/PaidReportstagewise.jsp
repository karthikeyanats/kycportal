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

<script type="text/javascript" src="../highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/highslide/highslide.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/highslide/highslide-with-html.js"></script>
<script type="text/javascript">
hs.graphicsDir = "<%=request.getContextPath()%>/js/highslide/graphics/";  
hs.outlineType = 'rounded-white'; 
hs.wrapperClassName = 'draggable-header';  

function goList(obj)
{	
	document.yearviewform.sessionid.value=obj.getAttribute("sessionid");
	document.yearviewform.sessionname.value=obj.getAttribute("sessionname");
	document.yearviewform.institutetransporttypeid.value=obj.getAttribute("institutetransporttypeid");
	document.yearviewform.action = "PaidcatListstagewise.jsp";
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

    <h2>Transport Fees / Paid Report Stage wise / Session List  </h2>
    
    
<form name="yearviewform"  method="post">

<table id="rounded-corner" border=0 summary="Examname List" width="100%" align="center">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.examnamelist.SL.No")%></th>
            <th scope="col" class="rounded-q4" width="95%">Year of Session</th>
        </tr>
    </thead>
    
   <!--  <tfoot>
    	<tr>  
        	<td colspan="6" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td> 
       </tr>
    </tfoot> --> 
    <%
    String sessionid  = null;
	String sessionname  =null ;
	String sessionstatus=null;
    
    %>
     <tbody>
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.TransportFees.FeesSettingsAction"%>


     		
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
									
									 sessionid        = (String)SessionListMap.get("sessionid");
									 sessionname   	= (String)SessionListMap.get("sessionname");
									 sessionstatus    = (String)SessionListMap.get("sessionstatus");
									 
									institutetransporttypeid = (String)SessionListMap.get("institutetransporttypeid");
									
									
									 %>  
					<tr>
						<td><%=j++ %>.</td>
							<%
							if(sessionstatus.equalsIgnoreCase("R"))
							{
							%>	
							<td><%=sessionname %>(Archived Session) </td>
						<%
							}else{
								%>
								<td>
								
									<a href="#" style="text-decoration:none;cursor:pointer;" sessionname="<%=sessionname %>" institutetransporttypeid="<%=institutetransporttypeid%>" sessionid="<%=sessionid%>" onclick="goList(this)"><%=sessionname %></a>
								</td>
							<%	
							}
							%>								
					</tr>				 
						<%	
						    		 }					    		 
					    			}
			     }catch(Exception e)
			     {
			    	e.printStackTrace(); 
			     }
			     %>
    </tbody>
</table>

<input type='hidden' name='institutetransporttypeid' value="" />
<input type='hidden' name='sessionid' value="" />
<input type='hidden' name='sessionname' value="" />

</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>