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
	 
	document.stageamountform.action="<%=request.getContextPath() %>/jsp/TransportFees/stagecatamountallot.jsp";
	document.stageamountform.submit();
}

function ViewAmount()
{
	document.stageamountform.action="<%=request.getContextPath() %>/jsp/TransportFees/ViewAmountAllocation.jsp";
	document.stageamountform.submit();
}

function checkNumber(e) {
	var code;
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;
	else if (e.which) code = e.which;  
	if(code!=9 && code!=46 && code!=8 && code!=43&& code!=45 && code!=118 && code!=99 && code!=37 && code!=38 && code!=39 && code!=40)
	{
	var character = String.fromCharCode(code);
	if (code==47||code<46||code>57)
	{
		code=0;
		alert("Enter  Number only")

	if(window.event != null)
	{
		window.event.keyCode 	= 505;
		event.cancelBubble		= true;
		event.returnValue		= false;

	}
	else
	{
		e.preventDefault();
	 }
		 return false;
	}
	}
	}
var amountpatteren=/^\d{1,10}(\.\d{1,2})?$/;

var validflag  =false;
function checkfuqn(obj)
{
	var chkid = obj.getAttribute("chkid");
	var transportfeesheadid = obj.getAttribute("transportfeesheadid");
	var transportstageid = obj.getAttribute("transportstageid");
	var transportstageamountallocationid = obj.getAttribute("transportstageamountallocationid");
	
	if(obj.checked)
	{		
		console.log(document.stageamountform.checkamount.length);
		if(document.stageamountform.checkamount.length == undefined)
		{	
			 if(document.stageamountform.checkamount.value == "")
				{
				alert("Amount should not be empty");
				document.stageamountform.checkamount.focus();
				document.stageamountform.checkallotamount.checked=false;
				 document.stageamountform.checkamount.disabled=false;

				return false;
				}
			
			/*  matchArray=document.stageamountform.checkamount.value.match(amountpatteren);
			 if (matchArray == null) {
				 alert("Invalid Pattern");
					document.stageamountform.checkamount.focus();
					document.stageamountform.checkallotamount.checked=false;  
					 document.stageamountform.checkamount.disabled=false;
				 return false;
			 } */
			 
			 if(document.stageamountform.checkamount.value.indexOf(".") != -1)
			 {
				 alert("Amount should be numeric value ")
				 document.stageamountform.checkamount.focus();
			 	document.stageamountform.checkallotamount.checked=false;
			 	document.stageamountform.checkamount.disabled=false;
			 	return false;
			 }
			 
			 
			 var amountvalue=document.stageamountform.checkamount.value;
			 
			 document.stageamountform.checkallotamount.value=amountvalue+";"+transportfeesheadid+";"+transportstageid+";"+transportstageamountallocationid;
			 console.log(document.stageamountform.checkallotamount.value);
			 validflag=true;
			
			 document.stageamountform.checkamount.disabled=true;
			 
		}
		else if(document.stageamountform.checkamount.length != undefined)			
		{
			if(document.stageamountform.checkamount[chkid].value == "")
			{
				alert("Amount should not be empty");
				document.stageamountform.checkamount[chkid].focus();
				document.stageamountform.checkallotamount[chkid].checked=false;
				return false;
			} 
			
			 
			 if(document.stageamountform.checkamount[chkid].value.indexOf(".") != -1)
			 {
				 alert("Amount should be numeric value ")
				 document.stageamountform.checkamount[chkid].focus();
			 	document.stageamountform.checkallotamount[chkid].checked=false;
			 	document.stageamountform.checkamount[chkid].disabled=false;
			 	return false;
			 }
		/* 	 matchArray1=document.stageamountform.checkamount[chkid].value.match(amountpatteren);
			 if (matchArray1 == null) {
				 alert("Invalid Pattern");
					document.stageamountform.checkamount[chkid].focus();
					document.stageamountform.checkallotamount[chkid].checked=false;
					
				 return false;
			 }
			else
			{ */
				document.stageamountform.checkamount.disabled=false;
				
				var amountvalue=document.stageamountform.checkamount[chkid].value;
				
				
				document.stageamountform.checkallotamount[chkid].value=amountvalue+";"+transportfeesheadid+";"+transportstageid+";"+transportstageamountallocationid;
				
				 validflag=true;
				//alert(document.stageamountform.checkallotamount[chkid].value);
			//}
	 
		}
		
		document.stageamountform.checkamount[chkid].disabled=true;
	
} 
	else{
		validflag=false;
		document.stageamountform.checkamount[chkid].disabled=false;
	}
}

function checkfun(obj)
{
	
					url = "../StudentPromotion/getAction.jsp?Action=CheckReduceAmount&transportstageamountallocationid="+obj.getAttribute("transportstageamountallocationid");
		
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
													var allocatedamount;
													var chkids;
													var checkamount;
													if(document.stageamountform.checkamount.length){  
														
														 chkids=obj.getAttribute("chkid");
														 allocatedamount=parseFloat((document.stageamountform.allocatedamount[chkids].value));
														 checkamount=parseFloat((document.stageamountform.checkamount[chkids].value));
														
														if((checkamount<allocatedamount))   
														{
															alert("This Stage Amount had been Collected. You can't Reduce the Amount");	
															document.stageamountform.checkallotamount[chkids].checked=false;
															return false;
														}
														else{
														
														}
													
													}
													else{ 
														
														 chkids=obj.getAttribute("chkid"); 
														 allocatedamount=parseFloat((document.stageamountform.allocatedamount.value));
														 checkamount=parseFloat((document.stageamountform.checkamount.value));
														
														
														if((checkamount<allocatedamount))   
														{
															alert("This Stage Amount had been Collected. You can't Reduce the Amount");	
															document.stageamountform.checkallotamount.checked=false;
															return false;
														}
														else{
														
														}
													}
												}
												else
												{
													
												}
				
										  }
									   	 else if (req.status == 204)
									     {
										 }
								   	}
						   };
						req.open("GET",url,true);
						req.send(null);
						
						
						var chkid = obj.getAttribute("chkid");
						var transportfeesheadid = obj.getAttribute("transportfeesheadid");
						var transportstageid = obj.getAttribute("transportstageid");
						var transportstageamountallocationid = obj.getAttribute("transportstageamountallocationid");
						
						if(obj.checked)
						{		
							//alert(document.stageamountform.checkamount.length);
							if(document.stageamountform.checkamount.length == undefined)
							{	
								 if(document.stageamountform.checkamount.value == "")
									{
									alert("Amount should not be empty");
									
									document.stageamountform.checkallotamount.checked=false;
									 document.stageamountform.checkamount.disabled=false;
									 document.stageamountform.checkamount.focus();

									return false;
									}
								
								/*  matchArray=document.stageamountform.checkamount.value.match(amountpatteren);
								 if (matchArray == null) {
									 alert("Invalid Pattern");
										document.stageamountform.checkamount.focus();
										document.stageamountform.checkallotamount.checked=false;  
										document.stageamountform.checkamount.disabled=false;
									 return false;
								 } */
								 if(document.stageamountform.checkamount.value.indexOf(".") != -1)
								 {
									 alert("Amount should be numeric value ")
									
								 	document.stageamountform.checkallotamount.checked=false;
								 	document.stageamountform.checkamount.disabled=false;
								 	 document.stageamountform.checkamount.focus();
								 	return false;
								 }
								 
								 
								 var amountvalue=document.stageamountform.checkamount.value;
								 
								 document.stageamountform.checkallotamount.value=amountvalue+";"+transportfeesheadid+";"+transportstageid+";"+transportstageamountallocationid;
								 console.log(document.stageamountform.checkallotamount.value);
								 validflag++;
								
								 document.stageamountform.checkamount.disabled=true;
								 console.log("validflag>>checked"+validflag);
							}
							else if(document.stageamountform.checkamount.length)			 
							{
								document.stageamountform.checkamount[chkid].disabled=true;

								if(document.stageamountform.checkamount[chkid].value == "")
								{
									alert("Amount should not be empty");
							
									document.stageamountform.checkamount[chkid].disabled=false;
									document.stageamountform.checkallotamount[chkid].checked=false;
									document.stageamountform.checkamount[chkid].focus();
									return false;
								} 
								if(document.stageamountform.checkamount[chkid].value.indexOf(".") != -1)
								 {
									 alert("Amount should be numeric value ")
									 
								 	document.stageamountform.checkallotamount[chkid].checked=false;
								 	document.stageamountform.checkamount[chkid].disabled=false;
								 	document.stageamountform.checkamount[chkid].focus();
								 	return false;
								 }
								// matchArray1=document.stageamountform.checkamount[chkid].value.match(amountpatteren);
								/*  if (matchArray1 == null) {
									 alert("Invalid Pattern");
										document.stageamountform.checkamount[chkid].focus();
										document.stageamountform.checkallotamount[chkid].checked=false;
										
									 return false;
								 }
								else
								{ */
									document.stageamountform.checkamount.disabled=false;
									
									var amountvalue=document.stageamountform.checkamount[chkid].value;
									
									
									document.stageamountform.checkallotamount[chkid].value=amountvalue+";"+transportfeesheadid+";"+transportstageid+";"+transportstageamountallocationid;
									
									
									//alert(document.stageamountform.checkallotamount[chkid].value);
								//}
								 validflag++;
									document.stageamountform.checkamount[chkid].disabled=true;

							}
							
						
					} 
						else{
							
							if(document.stageamountform.checkamount.length){
								
								document.stageamountform.checkamount[chkid].disabled=false;
								validflag--;
							}
							else{
								document.stageamountform.checkamount.disabled=false;
								validflag--;
							}
							
							console.log("validflag>>unchecke"+validflag);
						}
	
}






function addFeesAmount(obj)
{	
	
	if(document.stageamountform.checkamount==undefined)
	{ 
				alert("Select any one option");
				return false;
		
	}
	
	var amount= [];
	
	document.stageamountform.transportfeesheadid.value = obj.getAttribute("transportfeesheadid");
	document.stageamountform.transportstageid.value = obj.getAttribute("transportstageid");
	document.stageamountform.transportstageamountallocationid.value = obj.getAttribute("transportstageamountallocationid");
	console.log("validflag--;"+validflag);
	//if(check_ForParticularElements(document.stageamountform.checkallotamount,"checkbox"))
	if(validflag>0){
	
	if(document.stageamountform.checkamount.length !="undefined")
	{ 
	for(var k=0;k<document.stageamountform.checkamount.length;k++)
		{
			if(document.stageamountform.checkallotamount[k].checked)
			{
				var amountvalue = document.stageamountform.checkamount[k].value;
				var transportstageid=document.stageamountform.transportstageid[k].value;
				var transportfeesheadid=document.stageamountform.transportfeesheadid[k].value;
				var transportstageamountallocationid=document.stageamountform.transportstageamountallocationid[k].value;
				
				document.stageamountform.checkallotamount[k].value=amountvalue+";"+transportfeesheadid+";"+transportstageid+";"+transportstageamountallocationid;
				
			}					
		} 
		
	} 	
	else
	{ 
		var amountvalue = document.stageamountform.checkamount.value;
		var transportstageid=document.stageamountform.transportstageid.value;
		var transportfeesheadid=document.stageamountform.transportfeesheadid.value;
		alert(document.stageamountform.checkallotamount.value);
		document.stageamountform.checkallotamount.value=amountvalue+";"+transportfeesheadid+";"+transportstageid+";"+transportstageamountallocationid;
		
	}  
		if(confirm("Do you want update the amount?"))
		{	
			document.stageamountform.action="Updatestageamountsubmit.jsp";
			document.stageamountform.submit();
		}
	}else
		{
		alert("select any one of the options");
		return false;
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

    
        <h2>Transport Fees / Stage Amount Allocation / List Session / List Category / Route List / Amount Updation</h2>
    
<form name="stageamountform" action="" method="post">


<%
String req_transportroutename= null;
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
String req_transportcategoryname = request.getParameter("req_transportcategoryname");

String transportfeesheadid = null;String transportfeestypeid=null;
String transportfeessettingsid = null;
//out.println("transportcategoryname===>>>"+transportcategoryname);
 transportfeestypeid=request.getParameter("transportfeestypeid");
 req_transportroutename = request.getParameter("req_transportroutename");
%> 

<input type="hidden" name="transportfeestypeid" value="<%=transportfeestypeid%>"/>
<input type="hidden" name="sessionid" value="<%=sessionid%>"/>
<input type="hidden" name="tn" value="<%=transportfeestypename%>"/>
<input type="hidden" name="transportcategoryname" value="<%=transportcategoryname%>"/>
<input type="hidden" name="transportcategoryid" value="<%=transportcategoryid%>"/>
<input type="hidden" name="institutetransporttypeid" value="<%=request.getParameter("ittinstitutetransporttypeid")%>"/>
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
					    	  else
					    	  {
					    		  out.println("<tr><td colspan=5>Data not Found</td></tr>");
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
						<input type="text" name="checkamount" value='<%=allocatedamount %>' maxlength="6"  onkeypress="checkNumber(event);"/>
						<input type="hidden" name="allocatedamount" value='<%=allocatedamount %>' maxlength="6"/>
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
								
								<input type="hidden" name="transportfeesheadid" value="<%=transportfeesheadid%>" />
								<input type="hidden" name="transportstageid" value="<%=transportstageid%>" />
								<input type="hidden" name="transportstageamountallocationid" value="<%=transportstageamountallocationid%>" />
								
								<input type="checkbox" name="checkallotamount" validate="Check Amount" chkid="<%=commoninc%>" transportfeesheadid=<%=transportfeesheadid %> transportstageid=<%=transportstageid %> transportstageamountallocationid=<%=transportstageamountallocationid %> size="5" class="tablelight" onclick="checkfun(this)"/>
								
								<input type="hidden" name="amountvalset" value="" />
								
								<%
								commoninc++;
								}
								else
								{
								%>
								
								Not Allocated								
								
								<%	
								
								}
								%>
								
								
								
								<input type="hidden" name="transportfeessettingsid" value="<%=transportfeessettingsid%>" />		
								<input type="hidden" name="transportcategoryid" value="<%=transportcategoryid%>" />	
					
						
					</td>					
						
					</tr>				 
				
				<%					  
					    		 }
								}

					    	  else
					    	  {
					    		  out.println("<tr><td colspan=5>Data not Found</td></tr>");
					    	  }
					    		 		
				     }catch(Exception e){}
			          
			     %>
     		
    	
    </tbody>
</table>


	
<a href="#" onClick="ViewAmount()" class="bt_green"><span class="bt_green_lft"></span><strong>View Amount</strong><span class="bt_green_r"></span></a>

	<a href="#" onclick="back()" class="bt_blue"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>

		
		<a href="#" transportfeessettingsid=<%=transportfeessettingsid %> transportfeesheadid=<%=transportfeesheadid %> onClick="addFeesAmount(this)" class="bt_green"><span class="bt_green_lft"></span><strong>Update</strong><span class="bt_green_r"></span></a>

	<%-- <a href="./ExamnameEntry.jsp" class="bt_green"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.examnamelist.addnew")%></strong><span class="bt_green_r"></span></a>
     <a href="./ExamnameDeactivatedViewList.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.examnamelist.deactivatelist")%></strong><span class="bt_blue_r"></span></a>
     <a href="./ExamnameTrashedView.jsp" class="bt_red"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.examnamelist.trashitems")%></strong><span class="bt_red_r"></span></a> --%>

<input type='hidden' name="transportstageid" value="" /> 
<input type='hidden' name="transportcategoryname" value="<%=transportcategoryname %>" />
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