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
		if(check_ForParticularElements(document.scholarsip_form.academicyear,"select",document.scholarsip_form.standard_board,"select",document.scholarsip_form.scholarship,"select")){
			
			document.scholarsip_form.action		= "scholarshipallotment.jsp";
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
				
			//	document.scholarsip_form.action		= "scholarshipallotmentinsert.jsp"; 
				document.scholarsip_form.action		= "scholarshipallotmentinsert1.jsp";
				document.scholarsip_form.submit();
			}
		}
		}else
			{alert("select any one of the standard"); return false;}
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

    <h2>Scholarship Allotment</h2> <a href="./newallottment1.jsp">new</a>

<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.AcademicSession.AcademicSessionEntry" />
<% 	

	ResourceBundle bundle1 			= ResourceBundle.getBundle("resources.serversetup");
	StandardQuery  standardQuery 	= new StandardQuery();
	FeesSchedule  feesscheduleQuery = new FeesSchedule();
	
	String 	instituteid 			= (String)session.getAttribute("instituteid");

	
	
	ArrayList academicList			= query_object.get_All_AcademicSessions(instituteid);
	ArrayList standardList			= null;
	ArrayList boardList				= null;
	ArrayList scholarshipList		= feesscheduleQuery.loadscholarship(instituteid);
	HashMap	hashMap					= null;
	HashMap hashMap1				= null;
	
	
	String sessionid				= request.getParameter("academicyear");
	String boardid					= request.getParameter("standard_board");
	String scholarshipid			= request.getParameter("scholarship");
	
	if(sessionid != null && !sessionid.equals("") && !sessionid.equalsIgnoreCase("null") && !sessionid.equals("0"))
		standardList				= standardQuery.getStandards(scholarshipid, sessionid, boardid);
	
	boardList 						= standardQuery.listBoard(instituteid);
	
%>
<form name="scholarsip_form" method="post">

<table id="rounded-corner" border=0  width="100%">
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
    	<td lass=tablebold width="15%"> <%=bundle.getString("label.standard.Board") %> </td><td class='tablelight' colspan="6">
			<select name="standard_board" class=tablelight validate="Board Name"> 
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
        	<td class=tablebold>Scholarship</td><td class=tablelight colspan="6">
        
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
    </tr>	 
     <tr> 
			<td colspan="3" align="center"> <a href="#" class="bt_green" onclick="loadStandard()"><span class="bt_green_lft"></span><strong>Submit</strong><span class="bt_green_r"></span></a>
			<!-- <a href="./newallottment1.jsp">New allotment</a> --></td>
			<td colspan="3"></td>
		</tr>
	
    </tbody>
</table>
<br/><br/>
	
	<table id="rounded-corner" border=0 summary="selectd Information" width="100%">
    	<thead>
        	<th scope="col" class="rounded-company">Check</th>
        	<th scope="col" class="rounded">Standard Name</th>
        	<th scope="col" class="rounded">Amount</th>
        	<th scope="col" class="rounded-q4">Term Name</th>
    	</thead>
    	<tfoot>
        	<td colspan=3 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
    	</tfoot>
     	 
     	<tbody>
 		<%
			

 			ArrayList termsList			= null;
 			int serialcount				= 0;
 			
 			String feestermid			= "";
 			String feestermid_t			= "";
 			

 			if(standardList!=null && standardList.size()>0)
			{
			 	for (int i = 0; i < standardList.size(); i++) {
			 		
			 		hashMap		= (HashMap)standardList.get(i);
			 		
			 		feestermid	= (String)hashMap.get("termfeesid");
			 		
			 		%>

					<tr valign=top class="amtclassrow"> 
	    	 			<td class="amtclasscol1"><input class="amtcheckcol1" type="checkbox" name="standardscheduleid" value="<%=hashMap.get("standardscheduleid")%>" position="<%=serialcount%>"   onclick="insertAmount(this)"  validate="Standard Name"/></td>
	    	 			<td class="amtclasscol1"><%=hashMap.get("standardname")%></td>
	    	 			<td class="amtclasscol1">
	    	 				<%if(hashMap.get("amount") == null){%>
	    	 					<input type="text" 		name="amount" class="amtinputcol3"  disabled="true" id="amount<%=serialcount%>" value="" onkeyup="valid(this,'numbers')"   validate="Amount"/>
	    	 				<%}else{%>
								<input type="text" 		name="amount" class="amtinputcol3"  disabled="true" id="amount<%=serialcount%>" value="<%=hashMap.get("amount")%>" onkeyup="valid(this,'numbers')"   validate="Amount"/>	    	 				
	    	 				<%}%>
	    	 			</td>
	    	 			<td class="amtclasscol1">
					        <select name="termfees" class=tablelight   validate="Term Fees" disabled="true" id="termfees<%=serialcount%>">
								<option value="0">-Select Term Fees-</option>
								<%
								
									termsList	= standardQuery.getStandardTerms(hashMap.get("standardscheduleid")+""); 
								
									if(termsList != null && termsList.size()>0)
									for (int j = 0; j < termsList.size(); j++){
										
										hashMap1		= (HashMap)termsList.get(j);
								 		feestermid_t	= (String)hashMap1.get("termfeesid");
								 		
										if(feestermid != null && feestermid_t != null && (feestermid.equals(feestermid_t)))
											out.print("<option value="+hashMap1.get("termfeesid")+" selected>"+hashMap1.get("termname")+"</option>");
										else
											out.print("<option value="+hashMap1.get("termfeesid")+">"+hashMap1.get("termname")+"</option>");
										
									}
								%>							
							</select>
						</td>
					</tr>
			 		<%
			 		serialcount++;
			 	}
			}
		 	else
				out.print("<tr><td colspan='4' align='center'>Data Not Found</td></tr>");
 
	 	%>
	   </tbody>
   </table>
   
   <a href="#" class="bt_green" onclick="submitAllot()"><span class="bt_green_lft"></span><strong>Allot</strong><span class="bt_green_r"></span></a>
   
   
   <input type="hidden" name="amount" 				disabled/>
   <input type="hidden" name="standardscheduleid" 	disabled/>
   <input type="hidden" name="termfees" 			disabled/>
   
   
</form>
     </div><!-- end of right content--> 


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
  
<%@ include file="../include/footer.jsp" %>
     

</div>


</body>
</html>