<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.iGrandee.TransportFees.TrasportFeesHeadAction"%>
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
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript"> 
hs.graphicsDir = "<%=request.getContextPath()%>/js/highslide/graphics/"; 
hs.outlineType = 'rounded-white'; 
hs.wrapperClassName = 'draggable-header';  
 
function back(){
	 
	document.stageamountform.action="<%=request.getContextPath() %>/jsp/TransportFees/AmountUpdate.jsp";
	document.stageamountform.submit();
}

function TrashListview()
{
	document.stageamountform.action="<%=request.getContextPath() %>/jsp/TransportFees/AmountTrahList.jsp";
	document.stageamountform.submit();
}

function trashFun(obj)
{
	
	
					url = "../StudentPromotion/getAction.jsp?Action=CheckAmountID&transportstageamountallocationid="+obj.getAttribute("transportstageamountallocationid");
		
					var req=null;
				
					try
					  {
					  // Firefox, Opera 8.0+, Safari
					  req=new XMLHttpRequest();
					  }
					catch (e)
					  {
					  // Internet Explorer
					  try
					    {
					    req=new ActiveXObject("Msxml2.XMLHTTP");
					    }
					  catch (e)
					    {
					    req=new ActiveXObject("Microsoft.XMLHTTP");
					    }
					  }
					  //alert(req)
					
							req.onreadystatechange = function()
							{
							//	alert(req.readyState)
								if (req.readyState == 4)
								   {
									//   alert(req.status)
								  		 if(req.status == 200)
										 {
						              			var parseXML=req.responseXML;
					
												var rootObj=parseXML.getElementsByTagName("checkNumber");
												var cNode_1=rootObj[0].childNodes.length;
												var username=null;
												var finalValue=rootObj[0].childNodes.item(0).childNodes.item(0).firstChild.nodeValue;
												//var finalValue=rootObj[0].childNodes[0].selectSingleNode("finalValue").text;

												if(finalValue=="1")
												{
													alert("This Stage Amount had been Collected. You cant Trash")
												}
												else
												{
													if(confirm("Do you want To Trash the Stage Amount...?"))
													{
													
													document.stageamountform.transportstageamountallocationid.value=obj.getAttribute("transportstageamountallocationid");
													document.stageamountform.action= "TransportAmountTrash.jsp";
													document.stageamountform.submit();
													}
												}
				
										  }
									   	 else if (req.status == 204)
									     {
										 }
								   	}
						   };
						req.open("GET",url,true);
						req.send(null);
	
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

    
        <h2>Transport Fees / Stage Amount Allocation / List Session / List Category / Route List / View Amount</h2>
    
<form name="stageamountform" action="" method="post">


<%

String transportstageid = null;
String transportcategoryid = null;
transportcategoryid = request.getParameter("transportcategoryid");
String transportfeestypename = request.getParameter("tn");
String sessionid = (String)session.getValue("sessionid");
String transportcategoryname = null;
String stageid = request.getParameter("transportstageid");
String transportstagename = request.getParameter("transportstagename");
String transportrouteid = request.getParameter("transportrouteid");
transportcategoryname = request.getParameter("transportcategoryname"); 
String transportfeesheadid = null;String transportfeestypeid=null;
String transportfeessettingsid = null;
//out.println("transportcategoryname===>>>"+transportcategoryname);
 transportfeestypeid=request.getParameter("transportfeestypeid");
 String req_transportcategoryname = request.getParameter("req_transportcategoryname");
 String req_transportroutename = request.getParameter("req_transportroutename");
%> 

<input type="hidden" name="transportfeestypeid" value="<%=transportfeestypeid%>"/>
<input type="hidden" name="sessionid" value="<%=sessionid%>"/>
<input type="hidden" name="tn" value="<%=transportfeestypename%>"/>
<input type="hidden" name="transportcategoryname" value="<%=transportcategoryname%>"/>
<input type="hidden" name="transportcategoryid" value="<%=transportcategoryid%>"/>
<input type="hidden" name="institutetransporttypeid" value="<%=request.getParameter("institutetransporttypeid")%>"/>
<input type="hidden" name="transportstageamountallocationid" value="" />
<input type="hidden" name="transportcategoryid" value="<%=transportcategoryid%>"/>
<input type="hidden" name="req_transportroutename" value="<%=req_transportroutename%>"/>
<input type="hidden" name="req_transportcategoryname" value="<%=req_transportcategoryname%>"/>



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
			    		<td class=tablelight width="35%">
			    			<%=sessionname %>
			    		</td>
			    		<td width="15%" class=tablebold> 
			    			Fees Type: 
			    		</td>
			    		<td class=tablelight>
			    			<%=transportfeestypename %> 
			    		</td>
			    	</tr>
			    	
			    	<tr>
			    		
			    		<td width="15%" class=tablebold> 
			    			Start - End:  
			    		</td>
			    		<td class=tablelight>
			    			<%=startmonth %>&nbsp;<%=startyear %> - <%=endmonth %>&nbsp;<%=endyear %>
			    		</td>
			    		
			    		<td width="15%" class=tablebold> 
			    			Category Type:
			    		</td>
			    		<td class=tablelight>
			    			 <%
			    			if(transportcategoryid.equals("Term 1") || transportcategoryid.equals("Term 2") || transportcategoryid.equals("Term 3") || transportcategoryid.equals("Term 4"))
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
			    	
			    	<tr>
			    		
			    		<td width="15%" class=tablebold> 
			    			Route Name: 
			    		</td>
			    		<td class=tablelight colspan=3>
			    			<%
			    			FeesSettingsAction  routenameset = new FeesSettingsAction();
			    			String routename = routenameset.getRoute(transportrouteid);
			    			out.println(routename);
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
        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.examnamelist.SL.No")%></th>
            <th scope="col" class="rounded" width="25%">Stage Name</th>
            <th scope="col" class="rounded" width="25%">Fees Head Name</th>
            <th scope="col" class="rounded" width="20%">Amount</th>
            <th scope="col" class="rounded-q4" width="10%">Trash</th>
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
     		
     		<%-- <tr>
     			<td>
     				1.
     			</td>
     			<td>
     				<%=transportstagename %>
     			</td>
     		</tr> --%>
     		
     		 <%
     			FeesSettingsAction  stagefeesamount = new FeesSettingsAction();
			    instituteid = null;
			     ArrayList Loadstageamount = null;
				     try
				     {
				    	  instituteid = (String)session.getValue("instituteid"); 
				    	  //out.println("instituteid===>>"+instituteid); getstageforamounallotment  Loadstageamount = stagefeesamount.getstageamountcollection(transportcategoryid);
				    	  Loadstageamount = stagefeesamount.getstageforamounallotment(transportrouteid,transportcategoryid,instituteid);
				    	 // out.println("Loadstageamount===>>"+Loadstageamount);

					    	  ArrayList archivalDetails = new ArrayList();
					    	  ArrayList stageList = new ArrayList();
					    	  if(Loadstageamount!=null && Loadstageamount.size()>0)
								{
								  int commoninc=0;

					    		 for (int i = 0, j = 1; i < Loadstageamount.size(); i++) {
								
									HashMap SessionListMap=(HashMap)Loadstageamount.get(i);
									
									transportstageid   	= (String)SessionListMap.get("transportstageid");
									transportstagename   	= (String)SessionListMap.get("transportstagename");
									transportfeesheadid = (String)SessionListMap.get("transportfeesheadid");
									String transportfeesheadname = (String)SessionListMap.get("transportfeesheadname");
									String allocatedamount = (String)SessionListMap.get("allocatedamount");
									String transportstageamountallocationid = (String)SessionListMap.get("transportstageamountallocationid");
									//out.println("transportstageamountallocationid===>>"+transportstageamountallocationid);
				%>  
				
					<tr>
						
						<%
						if(!stageList.contains(transportstagename))
						{
							
							%>
							
						<td valign="top"><%=j%>.</td>
						<td valign="top">							
								<%=transportstagename %>
								<% 
							stageList.add(transportstagename);
								j++;
						}
						else
						{
							%>
							<td valign="top"> &nbsp;</td>
								<td valign="top">								
							<%
						}
						
						 %>
							
						</td>
						<td valign="top">
						 
						  <%=transportfeesheadname %>						 
						
						</td>
						<td valign="top">
						
						<%
						if(allocatedamount != null)
						{	
						%>
						<%=allocatedamount %>
						<%
						}else
						{	
						%>							
						-
						<%
						}
						%> 		
						
						</td>
					
						<td valign="top">
						<%
						if(allocatedamount != null)
						{	
						%>
							
							<a href='#' class='tablelight' onclick='trashFun(this)' transportstageamountallocationid='<%=transportstageamountallocationid %>' ><img src='<%=request.getContextPath() %>/jsp/kycpanel/images/trash.png' alt='' title='"+bundle.getString("label.role.trash")+"' border=0 /></a>
						<%
						}else
						{
							out.print("-");
						}
						
						%>		
						
					</td>					
						
					</tr>				 
				
				<%					  
					    		 }
								}else
								{
									 out.println("<tr><td colspan=5>Stage Not allocated for this route</td></tr>");

								}
					    		 		
				     }catch(Exception e){}
			          
			     %>
    	
    </tbody>
</table>

	<a href="#" onclick="back()" class="bt_blue"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>

		<a href="#" onclick="TrashListview()" class="bt_red"><span class="bt_red_lft"></span><strong>Trash List</strong><span class="bt_red_r"></span></a>

<input type='hidden' name="transportstageid" value="" /> 
<input type="hidden" name="transportrouteid" value="<%=transportrouteid%>" />
    
    </form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->


    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>

</div>
</body>
</html>