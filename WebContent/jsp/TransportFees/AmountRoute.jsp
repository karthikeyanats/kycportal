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

function LoadingStage(obj)
{
	document.feestypeform.transportrouteid.value = obj.getAttribute("transportrouteid");
	document.feestypeform.req_transportroutename.value = obj.getAttribute("routename");
	document.feestypeform.action = "stagecatamountallot.jsp";
	document.feestypeform.submit();
}
 
function back()
{
	document.feestypeform.action="AmountCategorytype.jsp";	
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

    <h2>Transport Fees / Stage Amount Allocation / List Session / List Category / Route List </h2>
    
<form name="feestypeform" action="" method="post">
<input type=hidden name=examnameid_hidden>
<input type=hidden name=examname_hidden>
<input type=hidden name=examnameremarks_hidden>
<input type=hidden name=createdby_hidden>

<%
String transportfeestypeid = null;

String sessionid    = request.getParameter("sessionid");

transportfeestypeid = request.getParameter("transportfeestypeid");
//out.println("transportfeestypeid===>>"+transportfeestypeid);
String transportfeestypename = request.getParameter("tn");
String transportcategoryname = request.getParameter("transportcategoryname");
String req_transportcategoryname = request.getParameter("req_transportcategoryname");

String transportcategoryid = request.getParameter("transportcategoryid");
String institutetransporttypeid = request.getParameter("institutetransporttypeid");
String transportrouteid = null;
String routename = null; 
//out.println("transportcategoryid===>>>"+transportcategoryid); 

String equalsmonth = null;

%>
	<input type="hidden" name="sessionid" value=<%=sessionid %> />
	<input type="hidden" name="transportfeestypeid" value=<%=transportfeestypeid %> /> 
	<input type="hidden" name="ittid" value=<%=institutetransporttypeid %> />
		<input type="hidden" name="institutetransporttypeid" value=<%=institutetransporttypeid %> />
	
	<input type="hidden" name="tn" value=<%=transportfeestypename %> />
	<input type="hidden" name="transportrouteid" value="" />
	<input type="hidden" name="transportroutename" value="<%=routename %>" />
	<input type="hidden" name="transportcategoryid" value=<%=transportcategoryid %> /> 
	<input type="hidden" name="transportcategoryname" value="<%=transportcategoryname%>" />
	<input type="hidden" name="req_transportcategoryname" value="<%=req_transportcategoryname%>" />
	<input type="hidden" name="req_transportroutename"/>
	
 <%
			     FeesSettingsAction  YearofSession = new FeesSettingsAction();
			     String instituteid = null;
			     ArrayList LoadyearofsessionList = null;
				     try
				     {
				    	  instituteid = (String)session.getValue("instituteid"); 
				    	  //out.println("instituteid===>>"+instituteid);
				    	  LoadyearofsessionList = YearofSession.getsessionnamedetails(sessionid); 
				    	 
					    	  ArrayList archivalDetails = new ArrayList();
					    	  if(LoadyearofsessionList!=null && LoadyearofsessionList.size()>0)
								{
					    		 for (int i = 0, j = 1; i < LoadyearofsessionList.size(); i++) {
								
									HashMap SessionListMap=(HashMap)LoadyearofsessionList.get(i);
									
									sessionid        = (String)SessionListMap.get("sessionid");
									String sessionname   	= (String)SessionListMap.get("sessionname");
									String startmonth = (String)SessionListMap.get("startmonth");
									String endmonth = (String)SessionListMap.get("endmonth");
									String startyear = (String)SessionListMap.get("startyear");
									String endyear    = (String)SessionListMap.get("endyear");
		
				%>  
				
				<table width="100%" id="rounded-corner" >
				<thead>
				<tr>
        	<th scope="col" class="rounded-company" width="15%">Selected Info</th>
        	<th scope="col" class="rounded" width="15%"></th>
        	<th scope="col" class="rounded"  width="15%"></th>
        	<th scope="col" class="rounded-q4" width="80%"></th>
        </tr>
        </thead>
				<tr>
			    		<td width="15%" class=tablebold> 
			    			Academic Year:
			    		</td>
			    		<td class=tablelight  width="30%"> 
			    			<%=sessionname %>
			    		</td>
			    		<td width="15%" class=tablebold> 
			    			Fees Type:
			    		</td>
			    		<td class=tablelight >
			    			<%=transportfeestypename %> 
			    		</td>
			    	</tr>
			    	
			    	<tr>
			    		
			    		<td width="15%"  class=tablebold> 
			    			Start - End:
			    		</td>
			    		<td class=tablelight>
			    			<%=startmonth %>&nbsp;<%=startyear %> - <%=endmonth %>&nbsp;<%=endyear %>
			    		</td>
			    		<td width="15%"  class=tablebold> 
			    			Category Type:
			    		</td>
			    		<td class=tablelight>
			    			 <%
			    			if(transportcategoryid.equals("Term 1") || transportcategoryid.equals("Term 2") || transportcategoryid.equals("Term 3"))
			    			{	
			    				transportcategoryname = 	YearofSession.gettermname(transportcategoryid);
			    				//out.println("transportcategoryname==>>"+transportcategoryname);
			    			%>
			    				<%=transportcategoryid%>
			    				
			    				
							<%
			    			}else
			    			{	
							transportcategoryname = 	YearofSession.getmonthname(transportcategoryid);
							out.print(transportcategoryname);
			    			}
							%>
							
			    		</td>
			    	</tr>
			    	
			    	
			    	
			</table>
				
				<%	
				  
		    		 }					    		 
	    		 		
					}
			     }catch(Exception e){}
			          
			     %>
<br></br>
<table id="rounded-corner" border=0 summary="Examname List" width="100%" align="center">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.examnamelist.SL.No")%></th>
        	<th scope="col" class="rounded" width="20%">Route Name</th>
        	<th scope="col" class="rounded-q4" width="20%">Set Amount</th>
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
			     instituteid = null;
			     ArrayList LoadamountsettinList = null;
				     try
				     {
				    	  instituteid = (String)session.getValue("instituteid"); 
				    	  //out.println("instituteid===>>"+instituteid);
				    	  LoadamountsettinList = amountsettin.getroutenameamt(instituteid);
				    	//out.println("LoadamountsettinList===>>"+LoadamountsettinList);
					    	  ArrayList archival = new ArrayList();
					    	  if(LoadamountsettinList!=null && LoadamountsettinList.size()>0)
								{
					    		 for (int k = 0, m = 1; k < LoadamountsettinList.size(); k++) {
								
									HashMap AmountListMap=(HashMap)LoadamountsettinList.get(k);
									
									transportrouteid        = (String)AmountListMap.get("transportrouteid");
									routename   	= (String)AmountListMap.get("routename");
									//out.println("transportcategoryid===>>"+transportcategoryname);
		
				%>  
				
									<tr>
							    		<td>
							    			<%=m++ %>.
							    		</td>
							    		
							    		<td>
							    			<%=routename %> 
							    		</td>	
							    		
							    		<td>
							    			<a href='#' transportrouteid="<%=transportrouteid %>" routename="<%=routename %>" onClick='LoadingStage(this)' style='text-decoration:none;'>Set Amount</a>
							    		</td>		    		
							    		
							    	</tr>
			    	
			    	
			
				
				<%	
				  
		    		 }					    		 
	    		 		
					}
			     }catch(Exception e){}
			          
			     %>
     		</table>
    	
    </tbody>
      
</table>

	
	
		 
		<a href="#" onclick="back()" class="bt_blue"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
		 
		

	<%--	<a href="#" feestypename=<%=transportfeestypeid %> sessionid=<%=sessionid %> onClick="SaveFesstype(this)" class="bt_green"><span class="bt_green_lft"></span><strong>Save</strong><span class="bt_green_r"></span></a>
		
      <a href="./ExamnameDeactivatedViewList.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.examnamelist.deactivatelist")%></strong><span class="bt_blue_r"></span></a>
     <a href="./ExamnameTrashedView.jsp" class="bt_red"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.examnamelist.trashitems")%></strong><span class="bt_red_r"></span></a> --%>

     </div><!-- end of right content-->


  </div>   <!--end of center content -->

 
</form>


    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>