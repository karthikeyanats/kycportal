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
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript"> 

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
function back(){
	 
	document.stageamountform.action="<%=request.getContextPath() %>/jsp/TransportFees/AmountRoute.jsp";
	document.stageamountform.submit();
}

function UpdateAmount()
{
	document.stageamountform.action="<%=request.getContextPath() %>/jsp/TransportFees/AmountUpdate.jsp";
	document.stageamountform.submit();
}


var amountpatteren=/^\d{1,10}(\.\d{1,2})?$/;
var validflagcount=0;
var validflag  =false;
function checkfun(obj)
{ 
		
	var chkid = obj.getAttribute("chkid");
	var transportfeesheadid = obj.getAttribute("transportfeesheadid");
	var transportstageid = obj.getAttribute("transportstageid");
	if(obj.checked)
	{		
		
		if(document.stageamountform.checkamount.length == undefined)
		{	
			 if(document.stageamountform.checkamount.value == "")
				{
				alert("Amount should not be emptysss");
				document.stageamountform.checkamount.focus();
				document.stageamountform.checkallotamount.checked=false;
				return false;
				}
			 
/* 			 matchArray=document.stageamountform.checkamount.value.match(amountpatteren);
 */			/*  if (matchArray == null) { 
				 alert("Amount should be numeric value");
					document.stageamountform.checkamount.focus();
					document.stageamountform.checkallotamount.checked=false;  
				 return false;
			 }  */
			 
			/*  if(document.stageamountform.checkamount.value.indexOf(".") != -1)
			 {
				 alert("Amount should be numeric value ")
			 	document.stageamountform.checkallotamount.checked=false;
			 	document.stageamountform.checkamount.disabled=false;
			 	return false;
			 } */
						 
			 var amountvalue=document.stageamountform.checkamount.value;
			// console.log("1");
			document.stageamountform.checkallotamount.value=amountvalue+";"+transportfeesheadid+";"+transportstageid;
		//	console.log("2");
			 validflag=true;
			// console.log("3");
				document.stageamountform.checkamount.disabled=true;
				//console.log("4");
				validflagcount++;
				//console.log("validflagcount"+validflagcount);
			
		}
		else if(document.stageamountform.checkamount.length != undefined)			
		{
			if(document.stageamountform.checkamount[chkid].value=="")
			{
				alert("Amount should not be empty");
				document.stageamountform.checkamount[chkid].focus();
				document.stageamountform.checkallotamount[chkid].checked=false;
				return false;
			}
			
			
			if(isNaN(document.stageamountform.checkamount[chkid].value))
			{
				alert("Amount should be Integer Value");
				document.stageamountform.checkamount[chkid].focus();
				document.stageamountform.checkallotamount[chkid].checked=false;
				return false;
			}
			// matchArray1=document.stageamountform.checkamount[chkid].value.match(amountpatteren);
			 
			 
			 if(document.stageamountform.checkamount[chkid].value.indexOf(".") != -1)
				 {
				 alert("Amount should be numeric value ")
				 
				document.stageamountform.checkamount[chkid].focus();
				document.stageamountform.checkallotamount[chkid].checked=false;
				 //document.stageamountform.checkamount[chkid].disabled=false;
				 //alert(document.stageamountform.checkamount[chkid].disabled);
				 return false;
				 }
			 
		/* 	 if (matchArray1 == null) {
				 alert("Amount should be numeric value");
					document.stageamountform.checkamount[chkid].focus();
					document.stageamountform.checkallotamount[chkid].checked=fastagecatamountallotlse;
					
				 return false;
			 } */
			
				document.stageamountform.checkamount[chkid].disabled=false; 

				var amountvalue=document.stageamountform.checkamount[chkid].value;
				
				
				document.stageamountform.checkallotamount[chkid].value=amountvalue+";"+transportfeesheadid+";"+transportstageid;
				
				 validflag=true;
				//alert(document.stageamountform.checkallotamount[chkid].value);
		
	 
		}
		
		//document.stageamountform.checkamount[chkid].disabled=true; 
		validflagcount++;
} 
	else{
		validflag=false;
		document.stageamountform.checkamount[chkid].disabled=false; 
		validflagcount--;
	}
}


function addFeesAmount(obj)
{	
	
	if(document.stageamountform.checkamount==undefined)
	{ 
				alert("Select any one options");
				return false;
		
	}

	var amount= [];
	
	document.stageamountform.transportfeesheadid.value = obj.getAttribute("transportfeesheadid");
	document.stageamountform.transportstageid.value = obj.getAttribute("transportstageid");
	
	//if(check_ForParticularElements(document.stageamountform.checkallotamount,"checkbox"))
	//
	//if(validflag){
		if(validflagcount>0)
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
		//amount = document.stageamountform.amountallot.value;
		
		
		var amountvalue = document.stageamountform.checkamount.value;
		var transportstageid=document.stageamountform.transportstageid.value;
		var transportfeesheadid=document.stageamountform.transportfeesheadid.value;
		alert(document.stageamountform.checkallotamount.value);
		document.stageamountform.checkallotamount.value=amountvalue+";"+transportfeesheadid+";"+transportstageid;
	}  
	
	if(confirm("Do you want allocate the amount?")){

	document.stageamountform.action="stageamountsubmit.jsp";
	document.stageamountform.submit();
	}
	}
	else
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

    
        <h2>Transport Fees / Stage Amount Allocation / List Session / List Category / Route List / Amount Allocation </h2>
    
<form name="stageamountform" action="" method="post">


<%
String req_transportroutename = null;
String sessionid = (String)session.getAttribute("sessionid");

String transportstageid = null;
String transportcategoryid = null;
String req_transportcategoryname =null;
transportcategoryid = request.getParameter("transportcategoryid");
String transportfeestypename = request.getParameter("tn");
String transportcategoryname = null;
String stageid = request.getParameter("transportstageid");
String transportstagename = request.getParameter("transportstagename");
String transportrouteid = request.getParameter("transportrouteid");
transportcategoryname = request.getParameter("transportcategoryname"); 
req_transportcategoryname = request.getParameter("req_transportcategoryname");

req_transportroutename = request.getParameter("req_transportroutename");
String transportfeesheadid = null;String transportfeestypeid=null;
String transportfeessettingsid = null;
transportfeestypeid=request.getParameter("transportfeestypeid");
//out.println("transportfeestypeid===>>>"+transportstagename);
 

%> 
<input type="hidden" name="req_transportcategoryname" value="<%=req_transportcategoryname%>" />
<input type="hidden" name="req_transportroutename" value="<%=req_transportroutename%>" />

<input type="hidden" name="transportfeestypeid" value="<%=transportfeestypeid%>"/>
<input type="hidden" name="sessionid" value="<%=sessionid%>"/>
<input type="hidden" name="transportcategoryname" value="<%=transportcategoryname%>"/>
<input type="hidden" name="transportcategoryid" value="<%=transportcategoryid%>"/>
<input type="hidden" name="ittinstitutetransporttypeid" value="<%=request.getParameter("institutetransporttypeid")%>"/>

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
								/* 	if(endmonth != null)
									{
										out.print(endmonth);
									}else
									{
										out.print("-");
									}
									
									if(startmonth != null)
									{
										out.print(startmonth);
									}else
									{
										out.print("-");
									}
									
									if(startyear != null)
									{
										out.print(startyear);
									}else
									{
										out.print("-");
									}
									
									if(endyear != null)
									{
										out.print(endyear);
									}else
									{
										out.print("-");
									} */
		
				%>  
				
				<table width="100%" id="rounded-corner" >	<thead>
				<tr>
        	<th scope="col" class="rounded-company" width="15%">Selected Info</th>
        	<th scope="col" class="rounded" width="15%"></th>
        	<th scope="col" class="rounded"  width="15%"></th>
        	<th scope="col" class="rounded-q4" width="80%"></th>
        </tr>
        </thead>
				<tr>
			    		<td width="15%"  class=tablebold> 
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
			    			<%-- <%=startmonth %> - <%=endmonth %> --%>
			    			<%=startmonth %>&nbsp;<%=startyear %> - <%=endmonth %>&nbsp;<%=endyear %>
			    		</td>
			    		
			    		<td width="15%" class=tablebold> 
			    			Category Type:
			    		</td>
			    		<td class=tablelight>
			    		<%=req_transportcategoryname %>
			    			<%--  <%
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
							//out.print(transportcategoryname);
			    			}
							%> --%>
							
			    		</td>
			    		
			    	</tr>
			    	
			    	<tr>
			    		
			    		<td width="15%" class=tablebold> 
			    			Route Name:
			    		</td>
			    		<td class=tablelight colspan=3>
			    			<%
			    			/* FeesSettingsAction  routenameset = new FeesSettingsAction();
			    			String routename = routenameset.getRoute(transportrouteid); */
			    			out.println(req_transportroutename);
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
			    
			    ArrayList stageList=new ArrayList();
			     ArrayList Loadstageamount = null;
				     try
				     {
				    	  instituteid = (String)session.getValue("instituteid"); 
				    	  //out.println("instituteid===>>"+instituteid); getstageforamounallotment  Loadstageamount = stagefeesamount.getstageamountcollection(transportcategoryid);
				    	  Loadstageamount =stagefeesamount.getstageforamounallotment(transportrouteid,transportcategoryid,instituteid);
				    	 // out.println("Loadstageamount===>>"+Loadstageamount);

					    	  ArrayList archivalDetails = new ArrayList(); 
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
									//out.println("allocatedamount===>>"+allocatedamount);
				%>  
				
					<tr>
					
						

						<%-- <%
						
						String temp_stageid = "";
						 if(transportstageid.equals(temp_stageid))
						 {
							 temp_stageid = transportstageid; 
							 out.println("<tr><td>"+transportstagename+"</td></tr>");
						 }
						%> --%>
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
						<input type="text" name="checkamount" value='' maxlength="6" onkeypress="checkNumber(event);"/>
						<%
						}
						%> 		
						
						</td>
					
						<td valign="top">
								<%
								if(allocatedamount != null)
								{
									out.print("Allocated");
								}else
								{	
								%>
								
								<input type="hidden" name="transportfeesheadid" value="<%=transportfeesheadid%>" />
								<input type="hidden" name="transportstageid" value="<%=transportstageid%>" />
								
								<input type="checkbox" name="checkallotamount" validate="Check Amount" chkid="<%=commoninc%>" transportfeesheadid=<%=transportfeesheadid %> transportstageid=<%=transportstageid %> size="5" class="tablelight" onclick="checkfun(this)"/>
								
								<input type="hidden" name="amountvalset" value="" />
								
								<%
								commoninc++;
								}
								%>
						
								
								<input type="hidden" name="transportfeessettingsid" value="<%=transportfeessettingsid%>" />		
								<input type="hidden" name="transportcategoryid" value="<%=transportcategoryid%>" />	
					
						
					</td>					
						
					</tr>				 
				
				<%					  
					    		 }
								}
					    	  else{
					    		  
					    		  out.println("<tr><td colspan=5>Stage Not allocated for this route</td></tr>");
					    	  }
					    		 		
				     }catch(Exception e){e.printStackTrace();
				    	 
				     }
			          
			     %>
     		
    	
    </tbody>
</table>


	<a href="#" onClick="UpdateAmount()" class="bt_green"><span class="bt_green_lft"></span><strong>Edit Amount</strong><span class="bt_green_r"></span></a>

	<a href="#" onclick="back()" class="bt_blue"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>

		
		<a href="#" transportfeessettingsid=<%=transportfeessettingsid %> transportfeesheadid=<%=transportfeesheadid %> onClick="addFeesAmount(this)" class="bt_green"><span class="bt_green_lft"></span><strong>Save</strong><span class="bt_green_r"></span></a>

	<%-- <a href="./ExamnameEntry.jsp" class="bt_green"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.examnamelist.addnew")%></strong><span class="bt_green_r"></span></a>
     <a href="./ExamnameDeactivatedViewList.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.examnamelist.deactivatelist")%></strong><span class="bt_blue_r"></span></a>
     <a href="./ExamnameTrashedView.jsp" class="bt_red"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.examnamelist.trashitems")%></strong><span class="bt_red_r"></span></a> --%>

<input type='hidden' name="transportstageid" value="" /> 
<input type='hidden' name="tn" value="<%=transportfeestypename %>" />
<input type="hidden" name="transportrouteid" value="<%=transportrouteid %>" />    
    </form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>