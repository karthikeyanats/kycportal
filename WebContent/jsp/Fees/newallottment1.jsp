<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.iGrandee.Fees.FeesSchedule"%>
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.feesstructureloadstandard.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.9.1.min.js"></script> 


<script type="text/javascript">

	function loadStandard()   
	{ 
		if(check_ForParticularElements(document.scholarsip_form.academicyear,"select",document.scholarsip_form.standard_board,"select")){
			
			document.scholarsip_form.action		= "./newallottment1.jsp";
			document.scholarsip_form.submit();
		}
	} 
	
	function loadTerm()   
	{ 
		if(check_ForParticularElements(document.scholarsip_form.academicyear,"select",document.scholarsip_form.standard_board,"select",document.scholarsip_form.scholarship,"select",document.scholarsip_form.standard,"select")){
			
			document.scholarsip_form.action		= "./newallottment1.jsp";
			document.scholarsip_form.submit();
		}
	}
	var chekflag =false;
	function insertAmount(obj){
		
		var position	= obj.getAttribute("position");
		
		if(obj.checked){
			chekflag =true;
			document.getElementById("amount"+position).disabled		= false;
			document.getElementById("termfees"+position).disabled	= false;
		}	
		else{
			chekflag =false;

			document.getElementById("amount"+position).disabled		= true;
			document.getElementById("termfees"+position).disabled	= true;
		}
	}
	 
function insertAmountkeypress(obj){
		console.log("calllaas");
		var position	= obj.getAttribute("position");
	    var pattern	= /^\d{10}$/;
			if(!pattern.test(document.scholarsip_form.amount[position].value)){
				
				alert("Please enter a valid Amount.(Numeric characters only)");
			
			}
			
		
	}
	

function valid(o,w){
	 o.value = o.value.replace(valid.r[w],'');
	 }
	 valid.r={
	 'special':/[\W]/g,
	 'quotes':/['\''&'\"']/g,
	 'numbers':/[^\d]/g
	 }

	
	function submitAllot(){
		
		if(chekflag){
		if(check_ForParticularElements(document.scholarsip_form.standardscheduleid,"checkbox")){
			
			for(var i=0;i<document.scholarsip_form.standardscheduleid.length-1;i++){

				if(document.scholarsip_form.standardscheduleid[i].checked){
					if(!check_ForParticularElements(document.scholarsip_form.amount[i],"text",document.scholarsip_form.termfees[i],"select")){
						return false;
					}
					else{
						
						if(isNaN(document.scholarsip_form.amount[i].value)){
							alert("Please enter a valid amount");
							document.scholarsip_form.amount[i].value	= "";
							return false;
							
						}else{

							document.scholarsip_form.amount[i].value	= parseFloat(document.scholarsip_form.amount[i].value).toFixed(2);
							
						}
					}
				}
			}
			
			if(confirm("Are you sure want to allot?")){
				
				//document.scholarsip_form.action		= "scholarshipallotmentinsert.jsp"; 
				document.scholarsip_form.action		= "scholarshipallotmentinsert1.jsp";
				document.scholarsip_form.submit();
			}
		}else
			{
			alert("select any one");
			document.scholarsip_form.amount.focus(); 
			return false;}
		}
	}
	 
	
	 
	 var amountpatteren=/^\d{1,10}(\.\d{1,2})?$/;
	 var a_chkflg= false;
		var de_chkflg= false;
		var a_chkflginc =0;
		var de_chkflginc =0;
		
		function chksel(obj)
		{
			var position	= obj.getAttribute("position");
			if(obj.getAttribute("chkstate")=="allocate")
			{
				if(obj.checked)
				{

					if(document.scholarsip_form.allocatechk.length==undefined){
						document.scholarsip_form.amount.disabled=false;
						document.scholarsip_form.allocatechk.disabled=false;
						a_chkflginc++;

						
						}
				 	else{
						document.scholarsip_form.amount[position].disabled=false;
						document.scholarsip_form.allocatechk[position].disabled=false;	
						a_chkflginc++;
				 	}	
					

					if(document.scholarsip_form.allocatechk.length==undefined){
						 matchArray=document.scholarsip_form.amount.value.match(amountpatteren);
				 			if (matchArray == null) {
				 	   				alert("Empty scholarship amount is not allowed");		 	   				
								 	document.scholarsip_form.allocatechk.checked=false;
										 
				 	   		return false;
				 			}
						
						
						if(parseFloat(document.scholarsip_form.amount.value) > parseFloat(obj.getAttribute("termamountval")))
			 			{
							alert("Scholarship amount should not exceed the term amount");
								document.scholarsip_form.allocatechk.checked=false; 
								document.scholarsip_form.amount.disabled=false;
							
						return false;	
			 			}
						document.scholarsip_form.amount.disabled=true;
						
					}
					else
						{
							 matchArray=document.scholarsip_form.amount[position].value.match(amountpatteren);
				 			if (matchArray == null) {
				 	   		alert("Empty scholarship amount is not allowed");		 	   				
								 	   	if(document.scholarsip_form.allocatechk.length==undefined){
											document.scholarsip_form.allocatechk.checked=false;
											}
									 	else{
											document.scholarsip_form.allocatechk[position].checked=false;} 
				 	   		return false;
				 			}
				 			if(parseFloat(document.scholarsip_form.amount[position].value) > parseFloat(obj.getAttribute("termamountval")))
				 			{
								alert("Scholarship amount should not exceed the term amount");
								if(document.scholarsip_form.allocatechk.length ==undefined)
									document.scholarsip_form.allocatechk.checked=false; 
								else
									document.scholarsip_form.allocatechk[position].checked=false;
								
							return false;	
				 			}else
				 			{	 
					 			if(document.scholarsip_form.allocatechk.length ==undefined)
					 			{
				 					document.scholarsip_form.amount.disabled=true;
									document.scholarsip_form.allocatechk.disabled=false;
				 				}
								else{
				 				document.scholarsip_form.amount[position].disabled=true;
								document.scholarsip_form.allocatechk[position].disabled=false;
				 			
		
								}
					 			
				 				
				 			}	
						}
		 				a_chkflg= true;
					
				}
				else 
				{
					
					if(document.scholarsip_form.allocatechk.length ==undefined)
						{
							document.scholarsip_form.allocatechk.checked=false;
							document.scholarsip_form.amount.disabled=false;						
						}

					else
						{
							document.scholarsip_form.allocatechk[position].checked=false;
							document.scholarsip_form.amount[position].disabled=false;						
						}

					
					a_chkflg= false;
					a_chkflginc--;
				document.scholarsip_form.amount[position].value="";
				document.scholarsip_form.scholarshipamountallocationid[position].value="";

				}
			}
			else if(obj.getAttribute("chkstate")=="deallocate")
			{
				if(obj.checked)
				{
					//alert(document.scholarsip_form.deallocatechk.length);
					if(document.scholarsip_form.deallocatechk.length==undefined)
					{
						 if(document.scholarsip_form.deamount.value=="")
						{
							alert("The amount should not be empty");
							document.scholarsip_form.deallocatechk.checked=false;
							document.scholarsip_form.deamount.focus();
							return false;
						} 
						
						if(parseFloat(document.scholarsip_form.deamount.value) > parseFloat(obj.getAttribute("termamountval")))
			 			{
							alert("Scholarship amount should not exceed the term amount");
								document.scholarsip_form.deallocatechk.checked=false;
								document.scholarsip_form.deamount.disabled=false;
								document.scholarsip_form.deamount.focus();
						return false;	
			 			}
						//document.scholarsip_form.deallocatechk.checked=false;
						document.scholarsip_form.deamount.disabled=true;
					}
					else
					{
						if(document.scholarsip_form.deamount[position].value=="")
						{
							alert("The amount should not be empty");
							document.scholarsip_form.deallocatechk[position].checked=false;
							document.scholarsip_form.deamount[position].focus();
							return false;
						}
						if(parseFloat(document.scholarsip_form.deamount[position].value) > parseFloat(obj.getAttribute("termamountval")))
			 			{
							alert("Scholarship amount should not exceed the term amount");
								document.scholarsip_form.deallocatechk[position].checked=false;
								document.scholarsip_form.deamount[position].disabled=false;
								document.scholarsip_form.deamount[position].focus();
						return false;	
			 			}
						document.scholarsip_form.deamount[position].disabled=true;
					}
					de_chkflginc++;
				}
				else
				{
					if(document.scholarsip_form.deallocatechk.length==undefined)
					{
						document.scholarsip_form.deamount.disabled=false;
					}
					else
					{
						document.scholarsip_form.deamount[position].disabled=false;
					}
					de_chkflginc--;
				}
				
				
			
			}
		
		}
		
		
		function submitfun()
		{
			if(a_chkflginc>0)
			{
				
				if(document.scholarsip_form.allocatechk.length ==undefined)
				{
					if(!document.scholarsip_form.allocatechk.checked){
					document.scholarsip_form.amount.disabled=true;
					document.scholarsip_form.allocatechk.disabled=true;
					}
					else if(document.scholarsip_form.allocatechk.checked){
						document.scholarsip_form.amount.disabled=false;
						document.scholarsip_form.allocatechk.disabled=false;
						}
				}
				else
					{
						for(var x=0;x<document.scholarsip_form.allocatechk.length;x++)
						{
							if(!document.scholarsip_form.allocatechk[x].checked){
							document.scholarsip_form.amount[x].disabled=true;
							document.scholarsip_form.allocatechk[x].disabled=true;
							}
							else if(document.scholarsip_form.allocatechk[x].checked){
								document.scholarsip_form.amount[x].disabled=false;
								document.scholarsip_form.allocatechk[x].disabled=false;
								}
						}
					}
			
				if(confirm("Are you sure want to allot the amount?"))
				{
					document.scholarsip_form.actionstate.value= "allocate";
					document.scholarsip_form.action="submitnewallotment.jsp";
					document.scholarsip_form.submit();
				}	
			}
			else
				{
				alert("select any one");
				}
			
		} 
		
		
		
		function updateallotment()
		{
			if(de_chkflginc>0)
			{
				if(document.scholarsip_form.deallocatechk.length ==undefined)
				{
					if(!document.scholarsip_form.deallocatechk.checked){
					document.scholarsip_form.deamount.disabled=true;
					document.scholarsip_form.deallocatechk.disabled=true;
					}
					else if(document.scholarsip_form.deallocatechk.checked)
					{
					document.scholarsip_form.deamount.disabled=false;
					document.scholarsip_form.deallocatechk.disabled=false;
					}
				}
				else
					{
						for(var x=0;x<document.scholarsip_form.deallocatechk.length;x++)
						{
							if(!document.scholarsip_form.deallocatechk[x].checked)
							{
							document.scholarsip_form.deamount[x].disabled=true;
							document.scholarsip_form.deallocatechk[x].disabled=true;
							}
							else if(document.scholarsip_form.deallocatechk[x].checked)
							{
							document.scholarsip_form.deamount[x].disabled=false;
							document.scholarsip_form.deallocatechk[x].disabled=false;
							}
						}
					}
				
				if(confirm("Are you sure want to update the amount?"))
				{
					document.scholarsip_form.actionstate.value= "deallocate";
					document.scholarsip_form.action="submitnewallotment.jsp";
					document.scholarsip_form.submit();
				}
			}
			else
				{
				alert("select any one");
				}
			
		}
		
		
		function trashFun(obj)
		{
			
							//alert("feestermid1===>>"+obj.getAttribute("feestermid1"));
							var feestermid1 = obj.getAttribute("feestermid1");
							//alert("feestermid1===>>"+obj.getAttribute("feestermid1"));
							var scholarshipamountallocationid = obj.getAttribute("scholarshipamountallocationid");
							var schemeforstudentid = obj.getAttribute("schemeforstudentid");
							
							//alert("scholarshipamountallocationid===>>"+obj.getAttribute("scholarshipamountallocationid"));
							//url = "../StudentPromotion/getAction.jsp?Action=feescollectioncheckid&feestermid1="+obj.getAttribute("feestermid1");
							url = "../StudentPromotion/getAction.jsp?Action=feescollectioncheckid&schemeforstudentid="+obj.getAttribute("schemeforstudentid");
							
				
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
															alert("This Scholarship Amount had been allocated. You cant Delete")
														}
														else
														{
															if(confirm("Do you want To Delete the Scholarship Amount...?"))
															{	
																//alert("Calling Function");																
																document.scholarsip_form.action= "ScholarshipAmountTrash.jsp?scholarshipamountallocationid="+scholarshipamountallocationid;
																document.scholarsip_form.submit(); 
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

    <h2>Scholarship Allotment</h2>

<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.AcademicSession.AcademicSessionEntry" />
<% 	

	ResourceBundle bundle1 			= ResourceBundle.getBundle("resources.serversetup");
	StandardQuery  standardQuery 	= new StandardQuery();
	FeesSchedule  feesscheduleQuery = new FeesSchedule();
	
	String 	instituteid 			= (String)session.getAttribute("instituteid");
	String sessionid				=  null;
	String boardid				=  null;
	String scholarshipid				=  null;
	String standardscheduleid				=  null;
	ArrayList academicList			= null;
	ArrayList standardList			= null;
	ArrayList scholarshipList			= null;
	ArrayList boardList				= null;
	HashMap	hashMap					= null;
	HashMap hashMap1				= null;
	//session.setMaxInactiveInterval(10);
	try
	{
	
	 academicList			= query_object.get_All_AcademicSessions(instituteid);
	 standardList			= null;
	
	scholarshipList		= feesscheduleQuery.loadscholarship(instituteid);
	
	if(request.getParameter("academicyear") !=null)
	 sessionid				= request.getParameter("academicyear");
	
	if(request.getParameter("standard_board") !=null)
	 boardid					= request.getParameter("standard_board");
	
	if(request.getParameter("scholarship") !=null)
	 scholarshipid			= request.getParameter("scholarship");
	
	if(request.getParameter("standard") !=null)
	 standardscheduleid			= request.getParameter("standard");
	
	
	if(sessionid != null && !sessionid.equals("") && !sessionid.equalsIgnoreCase("null") && !sessionid.equals("0"))
		standardList				= standardQuery.getScheduledStandards(sessionid, boardid);
	
	boardList 						= standardQuery.listBoard(instituteid);
	}catch(Exception e){e.printStackTrace();}
	
%>
<form name="scholarsip_form" method="post">

<table id="rounded-corner" border=0   width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="90%" colspan=5>Allotment</th>
        	<th scope="col" class="rounded-q4" width="10%" ></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
				<td colspan=5 class="rounded-foot-left"><em></em></td>
				<td class="rounded-foot-right">&nbsp;</td>
			</tr>
    </tfoot>
    
     <tbody>
     <%@ page import="java.util.ArrayList,java.util.HashMap,java.text.NumberFormat,java.util.Locale,com.iGrandee.MasterEntries.Standard.StandardQuery"%>

    	<tr>
    	<td class=tablebold width="15%">Academic Year
    	
    	</td><td class=tablelight class='tablelight' width='34%'> 
    	
    	<select name="academicyear" validate="Academic Year">
    		<option value="0">---Select Academic Year</option>
    		<%
	    	  	if(academicList!=null && academicList.size()>0)
	   			for(int i=0;i<academicList.size();i++)
	   			{
					hashMap		= (HashMap)academicList.get(i);
					
					if(sessionid != null && sessionid.equals((String)hashMap.get("sessionid")))
						out.print("<option value='"+hashMap.get("sessionid")+"' selected>"+hashMap.get("sessionname")+"</option>");
					else
						out.print("<option value='"+hashMap.get("sessionid")+"'>"+hashMap.get("sessionname")+"</option>");
	    		}
    		%>  
    	</select>
    	</td>
    	<td class=tablebold width="15%"> <%=bundle.getString("label.standard.Board") %> </td><td class='tablelight' colspan="6">
			<select name="standard_board" class=tablelight validate="Board Name" onchange=loadStandard()> 
				<option value="0">-Select Board-Medium- </option>
	    		<%
		    	  	if(boardList!=null && boardList.size()>0)
		   			for(int i=0;i<boardList.size();i++)
		   			{
						hashMap		= (HashMap)boardList.get(i);
						 
						if(boardid != null && boardid.equals((String)hashMap.get("boardid")))
							out.print("<option value='"+hashMap.get("boardid")+"' selected>"+hashMap.get("boardname")+"-"+hashMap.get("mediumname")+"</option>");
						else
							out.print("<option value='"+hashMap.get("boardid")+"'>"+hashMap.get("boardname")+"-"+hashMap.get("mediumname")+"</option>");
		    		}
	    		%>  
   		 	</select>
		</td>
    	</tr>
    	<tr>
        	<td class=tablebold>Scholarship</td><td class=tablelight>
        
		        <select name="scholarship" class=tablelight   validate="Scholarship">
					<option value="0">-Select Scholarship Type-</option>
					<%

						if(scholarshipList!=null && scholarshipList.size()>0)
			   			for(int i=0;i<scholarshipList.size();i++)
			   			{
							hashMap		= (HashMap)scholarshipList.get(i);
							
							if(scholarshipid != null && scholarshipid.equals((String)hashMap.get("scholarshipid")))
								out.print("<option value='"+hashMap.get("scholarshipid")+"' selected>"+hashMap.get("scholarshipname")+"</option>");
							else
								out.print("<option value='"+hashMap.get("scholarshipid")+"'>"+hashMap.get("scholarshipname")+"</option>");
			    		}
					%>
				</select>
        </td>
        <td class=tablebold>Standard</td><td class=tablelight  colspan="6">
        
		        <select name="standard" class=tablelight   validate="Standard">
					<option value="0">-Select Standard-</option>
					<%

						if(standardList!=null && standardList.size()>0)
			   			for(int i=0;i<standardList.size();i++)
			   			{
							hashMap		= (HashMap)standardList.get(i);
							
							if(standardscheduleid != null && standardscheduleid.equals((String)hashMap.get("standardscheduleid")))
								out.print("<option value='"+hashMap.get("standardscheduleid")+"' selected>"+hashMap.get("standardname")+"</option>");
							else
								out.print("<option value='"+hashMap.get("standardscheduleid")+"'>"+hashMap.get("standardname")+"</option>");
			    		}
					%>
				</select>
        </td>
    </tr>	 
     <tr> 
			<td colspan="3" align="center"> <a href="#" class="bt_green" onclick="loadTerm()"><span class="bt_green_lft"></span><strong>Submit</strong><span class="bt_green_r"></span></a><!-- <a href="./newallotment.jsp">New allotment</a> --></td>
			<td colspan="3"></td>
		</tr>
	
    </tbody>
</table>
<br/><br/>
	
	<table id="rounded-corner" border=0 summary="selectd Information" width="100%">
    	<thead>
        	<th scope="col" class="rounded-company">SL.No</th>
        	<th scope="col" class="rounded">Term Name</th>
        	<th scope="col" class="rounded">Term Amount</th>
        	<th scope="col" class="rounded">Scholarship Amount</th> 
        	<th scope="col" class="rounded-q4">Check</th>
    	</thead>
    	<tfoot>
        	<td colspan=4 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
    	</tfoot>
     	
     	<tbody>
 		<%
			

 			ArrayList termsList			= null;
 			int serialcount				= 0;
 			
 			String feestermid			= "";
 			String feestermid_t			= "";
 			int inc =1;
 			if(standardscheduleid != null)
 			{
 			termsList	= standardQuery.getStandardwiseTerms(standardscheduleid,"allocate",scholarshipid);
 			}
 			//d.termname, c.termfeesamount,c.termfeesid from termfees c, feestermname
 			
 	//System.out.println("ASDFADSFDASF"+termsList);
 			if(termsList!=null && termsList.size()>0)
			{
			 	for (int i = 0; i < termsList.size(); i++) {
			 		
			 		hashMap		= (HashMap)termsList.get(i);
			 		
			 		feestermid	= (String)hashMap.get("termfeesid");
			 		
			 		
			 		%>
				<%if(hashMap.get("scholarshipamountallocationid") == null){ %>
					<tr valign=top class="amtclassrow">
					<td><%=inc++ %>.</td> 
					<td><%=hashMap.get("termname") %></td>
					<td><%=hashMap.get("termfeesamount") %></td>
	    	 		<td class="amtclasscol1">
	    	 					<input type="text" 	name="amount" id="amount<%=serialcount%>" value="" onkeyup="valid(this,'numbers')" maxlength="8"  validate="Amount"/>
	    	 			</td>
	    	 		<%-- <td><input type=checkbox name=termfeesid value="<%=hashMap.get("termfeesid") %>" chkstate='allocate' onclick=chksel(this)></input></td> --%>
	    	 		<td><input type=hidden name="allocatestate"></input><input type=hidden name="termfeesid" value="<%=hashMap.get("termfeesid") %>"></input><input type=checkbox name="allocatechk" value="<%=hashMap.get("termfeesid") %>" chkstate='allocate' position="<%=serialcount %>" termamountval="<%=hashMap.get("termfeesamount") %>" onclick="chksel(this)"></input></td>
					</tr>
			 		<%
			 		serialcount++;
				}
			 	}
			}
		 	else
				out.print("<tr><td colspan='5' align='center'>Data Not Found</td></tr>");
 
	 	%>
	   </tbody>
   </table>
   
   <a href="#" class="bt_green" onclick="submitfun()"><span class="bt_green_lft"></span><strong>Allot</strong><span class="bt_green_r"></span></a>
   
 	<h2>Scholarship Amount Allotted Term List</h2>
   
   	<table id="rounded-corner" border=0 summary="selectd Information" width="100%">
    	<thead>
        	<th scope="col" class="rounded-company">SL.No</th>
        	<th scope="col" class="rounded">Term Name</th>
        	<th scope="col" class="rounded">Term Amount</th>
        	<th scope="col" class="rounded">Allocated Amount</th>
        	<th scope="col" class="rounded">Check</th>  
        	<th scope="col" class="rounded-q4">DeAllocate</th>
    	</thead>
    	<tfoot>
        	<td colspan=5 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
    	</tfoot>
     	
     	<tbody>
 		<%
			

 			ArrayList termsList1			= null;
 			int serialcount1				= 0;
 			
 			int inc1 =1;
 			
 			//d.termname, c.termfeesamount,c.termfeesid from termfees c, feestermname
 			
 	
 			if(termsList!=null && termsList.size()>0)
			{
			 	for (int i = 0; i < termsList.size(); i++) {
			 		
			 		hashMap		= (HashMap)termsList.get(i);
			 		
			 		String feestermid1	= (String)hashMap.get("termfeesid");
			 		
			 		
			 		%>
				<%if(hashMap.get("scholarshipamountallocationid") != null){ %>
					<tr valign=top class="amtclassrow">
					<td><%=inc1++ %>.</td> 
					<td><%=hashMap.get("termname") %></td>
					<td><%=hashMap.get("termfeesamount") %></td>
						<%if(hashMap.get("schemeforstudentid") == null)
	    	 			{ %>
	    	 		
	    	 		<td class="amtclasscol1">
	    	 			<input type="text" 	name="deamount"  maxlength="8" value="<%=hashMap.get("amount")%>" id="amount<%=serialcount1%>" position="<%=serialcount1 %>"  value="" onkeyup="valid(this,'numbers')" validate="Amount"/>
	    	 			</td>
	    	 		<td><input type=hidden name="deallocatestate"><input type=hidden name="descholarshipamountallocationid"><input type=hidden name="determfeesid" value="<%=hashMap.get("termfeesid") %>"></input><input type=checkbox name="deallocatechk" chkstate='deallocate'  termamountval="<%=hashMap.get("termfeesamount") %>" value="<%=hashMap.get("scholarshipamountallocationid")%>" position="<%=serialcount1 %>" scholarshipamountallocationid="<%=hashMap.get("scholarshipamountallocationid") %>" onclick="chksel(this)"><input type="hidden" name="scholarshipamountallocationid" value="<%=hashMap.get("scholarshipamountallocationid") %>"/> </input></td>
	    	 		<td class=tablelight>
	    	 		<a href="#" feestermid1=<%=feestermid1 %> scholarshipamountallocationid="<%=hashMap.get("scholarshipamountallocationid")%>" schemeforstudentid="<%=hashMap.get("schemeforstudentid")%>" onClick="trashFun(this)" style="text-decoration:none;">DeAllocate</a>
	    	 		</td>
	    	 		<%}else
	    	 				{
	    	 				%>
	    	 				<td><%=hashMap.get("amount")%></td>
	    	 				<td colspan=2><i>Fees Collected</i></td>
	    	 				<%} %>
	    	 			
	    	 		
					</tr>
			 		<%
			 		serialcount1++;
				}
			 	}
			}
		 	else
				out.print("<tr><td colspan='7' align='center'>Data Not Found</td></tr>");
 
	 	%>
	   </tbody>
   </table>
   
   <a href="#" class="bt_green" onclick="updateallotment()"><span class="bt_green_lft"></span><strong>Update Amount</strong><span class="bt_green_r"></span></a>
   

   <input type="hidden" name="standardscheduleid"/>
   <input type="hidden" name="termfees" />
     <!--  <input type="hidden" name="amount" /> 
   <input type="hidden" name="deamount" />  --> 
   <input type="hidden" name="termfeesid"/>
   <input type="hidden" name="actionstate"/>
   <input type="hidden" name="scholarshipamountallocationid"/>
      <input type="hidden" name="determfeesid"/>
   
   
   
   
</form>
     </div><!-- end of right content--> 


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
  
<%@ include file="../include/footer.jsp" %>
     

</div>


</body>
</html>