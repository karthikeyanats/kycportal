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
 

var validflag  =false;
function checkfun(obj)
{
	
	var chkid = obj.getAttribute("chkid");
	var transportfeesheadid = obj.getAttribute("transportfeesheadid");
	var transportstageid = obj.getAttribute("transportstageid");
	if(obj.checked)
	{		
		
		
	if(document.stageamountform.checkamount[chkid].value == "")
	{
		alert("Amount should not be empty");
		document.stageamountform.checkamount[chkid].focus();
		document.stageamountform.checkallotamount[chkid].checked=false;
		return false;
	} 
	else
	{
		var amountvalue=document.stageamountform.checkamount[chkid].value;
		
		
		document.stageamountform.checkallotamount[chkid].value=amountvalue+";"+transportfeesheadid+";"+transportstageid;
		
		//alert(document.stageamountform.checkallotamount[chkid].value);
	}
		
	
} 
}


function addFeesAmount(obj)
{	
	var amount= [];
	
	document.stageamountform.transportfeesheadid.value = obj.getAttribute("transportfeesheadid");
	document.stageamountform.transportstageid.value = obj.getAttribute("transportstageid");
	
	if(check_ForParticularElements(document.stageamountform.checkallotamount,"checkbox"))
	{
	
	if(document.stageamountform.checkamount.length !="undefined")
	{ 
	for(var k=0;k<document.stageamountform.checkamount.length;k++)
		{
			if(document.stageamountform.checkallotamount[k].checked)
			{
				var amountvalue = document.stageamountform.checkamount[k].value;
				var transportstageid=document.stageamountform.transportstageid[k].value;
				var transportfeesheadid=document.stageamountform.transportfeesheadid[k].value;
				
				
				document.stageamountform.checkallotamount[k].value=amountvalue+";"+transportfeesheadid+";"+transportstageid;
				
				//alert(document.stageamountform.checkallotamount[k].value);				
				
			}					
		} 
		
	} 	
	else
	{     
	amount = document.stageamountform.amountallot.value;
	}  
	
	document.stageamountform.action="stageamountsubmit.jsp";
	document.stageamountform.submit();
	}
	
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

    
        <h2>Transport Fees / Stage Amount Allocation / List Session / List Category / Route List / Fees Head</h2>
    
<form name="stageamountform" action="" method="post">


<%

String transportstageid = null;
String transportcategoryid = null;
transportcategoryid = request.getParameter("t");
String transportfeestypename = request.getParameter("transportfeestypename");
String sessionid = (String)session.getValue("sessionid");
String transportcategoryname = null;
String stageid = request.getParameter("transportstageid");
String transportstagename = request.getParameter("transportstagename");
String transportroutename = request.getParameter("transportroutename");
String transportrouteid = request.getParameter("transportrouteid");
transportcategoryname = request.getParameter("transportcategoryname"); 
String transportfeesheadid = null;
String transportfeessettingsid = null;
//out.println("transportrouteid===>>>"+transportrouteid);


%>

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
				
				<table width="100%" >
				<tr>
			    		<td width="15%"> 
			    			<h4></>Year of Session: </h4>
			    		</td>
			    		<td>
			    			<%=sessionname %>
			    		</td>
			    		<td width="15%"> 
			    			<h4></>Fees Type: </h4>
			    		</td>
			    		<td>
			    			<%=transportfeestypename %> 
			    		</td>
			    	</tr>
			    	
			    	<tr>
			    		
			    		<td width="15%"> 
			    			<h4></>Start - End:   </h4>
			    		</td>
			    		<td>
			    			<%=startmonth %> - <%=endmonth %>
			    		</td>
			    		<td width="15%"> 
			    			<h4></>Category Type: </h4>
			    		</td>
			    		<td>
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
			    		
			    		<td width="15%"> 
			    			<h4></>Route Name: </h4>
			    		</td>
			    		<td>
			    			<%			    			
			    			out.println(transportroutename);
			    			%>
			    		</td>
			    	</tr>
			    	
			</table>
				
				<%	
				  
		    		 }					    		 
	    		 		
					}
			     }catch(Exception e){}
			          
			     %>	
	
	<table id="rounded-corner" border=0 summary="Examname List" width="100%" align="center">
	
	
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.examnamelist.SL.No")%></th>
            <th scope="col" class="rounded" width="25%">Stages Name</th>
            <th scope="col" class="rounded" width="25%">Fees Head Name</th>
            <th scope="col" class="rounded" width="20%">Amount</th>
            <th scope="col" class="rounded-q4" width="10%">Select</th>
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
				    	  Loadstageamount = stagefeesamount.getstageforamounallotment(transportrouteid);
				    	  //out.println("Loadstageamount===>>"+Loadstageamount);

					    	  ArrayList archivalDetails = new ArrayList();
					    	  if(Loadstageamount!=null && Loadstageamount.size()>0)
								{
								  int commoninc=0;

					    		 for (int i = 0, j = 1; i < Loadstageamount.size(); i++) {
								
									HashMap SessionListMap=(HashMap)Loadstageamount.get(i);
									
									transportstageid   	= (String)SessionListMap.get("transportstageid");
									transportstagename   	= (String)SessionListMap.get("transportstagename");  
						
				%>  
				
					<tr>
					
						
								<td valign="top"><%=j++ %>.</td>
						<td valign="top">
							<%=transportstagename %> <%=transportstageid %>
						</td>
						<td valign="top">
						 
						  <%
				    	  int incvalue=0;
						  

			     			TrasportFeesHeadAction  stagefeeshead = new TrasportFeesHeadAction();
						    instituteid = null;
						     ArrayList Loadstagefeeshead = null;
						     try
						     {
						    	  instituteid = (String)session.getValue("instituteid"); 
						    	  //out.println("instituteid===>>"+instituteid);
						    	  Loadstagefeeshead = stagefeeshead.getstagefeeshead(instituteid);
		
							    	  ArrayList archivalDetails1 = new ArrayList();
							    	  if(Loadstagefeeshead!=null && Loadstagefeeshead.size()>0)
										{
							    		 
							    		  ArrayList containList= new ArrayList();
							    		 for (int i1 = 0, j1 = 1; i1 < Loadstagefeeshead.size(); i1++) 
							    		 {
										
											HashMap SessionListMap1=(HashMap)Loadstagefeeshead.get(i1);
											
											transportfeesheadid        = (String)SessionListMap1.get("transportfeesheadid");
									
											String transportfeesheadname   	= (String)SessionListMap1.get("transportfeesheadname");  
		 
										
											
											if(!containList.contains(transportfeesheadname))
											{
												incvalue++;
												%> 
												
												<%=transportfeesheadname %>
												<br>
												<br>
												<br>
												
													
												<%
												containList.add(transportfeesheadname);
											}
											else
											{
												
											}
										    		 
							    		 }				    		 
									    		 		
													}else
													{
													%>
													-
													<%	
													}
							     }catch(Exception e){}
							          
							     %>
						 
						
						
						</td>
						<td valign="top">
					 <%--  <%
										for(int k=0;k<incvalue;k++)
													{	
													%>
													
													<input type="text" name="checkamount" value='' />
													<br>
													<br>
													          	 
													<%	
													}
													%>     --%>     
						
					  <%
						
							
								FeesSettingsAction  amountlist = new FeesSettingsAction();
							    instituteid = null;
							    
							     ArrayList Loadamount = null;
								     try
								     {
								    	  instituteid = (String)session.getValue("instituteid"); 
								    	  //out.println("instituteid===>>"+instituteid); getstageforamounallotment  Loadstageamount = stagefeesamount.getstageamountcollection(transportcategoryid);
								    	  Loadamount = amountlist.getstageamount(transportstageid,transportcategoryid);
								    	  //out.println("Loadamount===>>"+Loadamount);

									    	  ArrayList archival = new ArrayList();
									    	  if(Loadamount!=null && Loadamount.size()>0)
												{
									    		  out.println("sssss"+Loadamount.size());
									    		 for (int a = 0, b = 1; a < Loadamount.size(); a++) {
												
													HashMap AmountMap=(HashMap)Loadamount.get(a);
													
													String transportstageamountallocationid   	= (String)AmountMap.get("transportstageamountallocationid");
													String allocatedamount 	= (String)AmountMap.get("allocatedamount"); 
 													if(allocatedamount == null ||  allocatedamount.equals("") || allocatedamount.toString().equals("") || allocatedamount=="" )
													{ 
														%>
														
														<input type="text" name="checkamount" value='' />
														<br>
														<br>
														
														<%
														  
						
													}else
													{
													out.println(""+allocatedamount);
																} 
													
													}
							}
							
												
								     }
													
								     catch(Exception e){}		
					    		
									    		 
						%>	 
					</td>
					
						<td valign="top">
						
						<%
				    	  int incvalue1=0;

			     			TrasportFeesHeadAction  stagefeeshead1 = new TrasportFeesHeadAction();
						    instituteid = null;
						     ArrayList Loadstagefeeshead1 = null;
						     try
						     {
						    	  instituteid = (String)session.getValue("instituteid"); 
						    	  //out.println("instituteid===>>"+instituteid);
						    	  Loadstagefeeshead1 = stagefeeshead1.getstagefeeshead(instituteid);
		
							    	  ArrayList archivalDetails2 = new ArrayList();
							    	  if(Loadstagefeeshead1!=null && Loadstagefeeshead.size()>0)
										{
							    		 
							    		  ArrayList containList= new ArrayList();
							    		 for (int i2 = 0, j2 = 1; i2 < Loadstagefeeshead1.size(); i2++) 
							    		 {
										
											HashMap SessionListMap2=(HashMap)Loadstagefeeshead1.get(i2);
											
											transportfeesheadid        = (String)SessionListMap2.get("transportfeesheadid");
									
											String transportfeesheadname   	= (String)SessionListMap2.get("transportfeesheadname");  
											
											if(!containList.contains(transportfeesheadname))
											{
											
												%> 
											
												<input type="hidden" name="transportfeesheadid" value="<%=transportfeesheadid%>" />
												<input type="hidden" name="transportstageid" value="<%=transportstageid%>" />
												<input type="checkbox" name="checkallotamount" validate="Check Amount" chkid="<%=commoninc%>" transportfeesheadid=<%=transportfeesheadid %> transportstageid=<%=transportstageid %> size="5" class="tablelight" onclick="checkfun(this)"/>
												<input type="hidden" name="amountvalset" value="" />
												<br>
												<br>
						
							<%
													incvalue1++;
													commoninc++;
												containList.add(transportfeesheadname);
											}
											else
											{
											
											}
												
							    		 }					    		 
													}else
													{
													%>
													-
													<%	
													}
							     }catch(Exception e){
							    	 
							     }
							          
							     %>
								
								<input type="hidden" name="transportfeessettingsid" value="<%=transportfeessettingsid%>" />		
								<input type="hidden" name="transportcategoryid" value="<%=transportcategoryid%>" />	
					
						<%
							}
						%>	
					</td>					
						
						
						
					</tr>				 
				
				<%					  
								
						    		 }else{
						    			 out.print("<td colspan='5' align=center><font color='red'>Stage not Found</font></td>");
						    		 }
					    		 		
									
			     }catch(Exception e){}
			          
			     %>
     		
    	
    </tbody>
</table>


	

	<a href="<%=request.getContextPath() %>/jsp/TransportFees/Transportyearview.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
	
	<a href="#" transportfeessettingsid=<%=transportfeessettingsid %> transportfeesheadid=<%=transportfeesheadid %> onClick="addFeesAmount(this)" class="bt_green"><span class="bt_green_lft"></span><strong>Update</strong><span class="bt_green_r"></span></a>

	<%-- <a href="./ExamnameEntry.jsp" class="bt_green"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.examnamelist.addnew")%></strong><span class="bt_green_r"></span></a>
     <a href="./ExamnameDeactivatedViewList.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.examnamelist.deactivatelist")%></strong><span class="bt_blue_r"></span></a>
     <a href="./ExamnameTrashedView.jsp" class="bt_red"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.examnamelist.trashitems")%></strong><span class="bt_red_r"></span></a> --%>

<input type='hidden' name="transportstageid" value="" /> 
<input type='hidden' name="transportcategoryname" value="<%=transportcategoryname %>" />
    
    </form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>