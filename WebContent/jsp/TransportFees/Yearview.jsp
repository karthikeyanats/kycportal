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


/* function SaveFesstype(obj){	
		
	var sessionid = obj.getAttribute("sessionid");	
	var transportfeestypeid = obj.getAttribute("feestypename");
	  if(confirm("Do you want to Select the Fees Type?"))
		{
		document.feestypeform.action = "FeesTypeSubmit.jsp?transportfeestypeid="+transportfeestypeid+"&sessionid="+sessionid;
		document.feestypeform.submit();
		} 
	} */
	
	
	function submitFun(){	
		
		
			var Flag=false;
			var chklength = document.feestypeform.chkname.length;
			//alert("chklength ===>>>"+chklength);

			if(chklength==undefined)
			{ 
				
				if(document.feestypeform.chkname.checked==true) 
				{

					Flag=true;
				}	
				
			}
			else 
			{
				for(var i=0;i<chklength;i++){
					
					if(document.feestypeform.chkname[i].checked==true)
					{

						Flag=true;
					}	
				}
				
			}  		
			
			if(Flag)
			{
				if(confirm("Are you sure want to Allocate this Category?"))
				{	
				document.feestypeform.action="./CategorySubmit.jsp";
				document.feestypeform.submit();
				}
				
			} 
			else 
			{
				alert("Select the option");
				return false;
				
			} 
			
		
	}
	


		function catupdate(obj)
		{
		if(obj.getAttribute("result")!='null'){
				
				alert("Amount Allocated for this Category");
				
			}
			else
			{
				if(confirm("Are you want to Deallocate this Category?"))
				{
					document.feestypeform.equalsmonth.value=obj.getAttribute("equalsmonth");
					document.feestypeform.action = "Categoryunselect.jsp";
					document.feestypeform.submit(); 
				}
			}	
		}
				
	
function Stageallot(obj)
{
	
	var transportfeestypeid = obj.getAttribute("transportfeestypeid");	
	//alert("transportfeestypeid===>>"+transportfeestypeid);
	if(confirm("Do you want to Allot the Fees?"))
	{
	document.feestypeform.action = "StageamountAllocation.jsp?transportfeestypeid="+transportfeestypeid;
	document.feestypeform.submit();
	} 
}


function Openstage(obj)
{
	var equalsmonth = obj.getAttribute("equalsmonth");
	document.feestypeform.action = "stagecatamountallot.jsp?equalsmonth="+equalsmonth;
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

    <h2>Transport Fees / Type Selection / List Session / Set Year</h2>
    
    
<form name="feestypeform" action="" method="post">
<input type=hidden name=examnameid_hidden>
<input type=hidden name=examname_hidden>
<input type=hidden name=examnameremarks_hidden>
<input type=hidden name=createdby_hidden>
<input type=hidden name=equalsmonth value=""/>


<%
String transportfeestypeid = null;

String sessionid    = request.getParameter("sessionid");
String equalsmonth = null;
transportfeestypeid = request.getParameter("transportfeestypeid");
String transportfeestypename = request.getParameter("transportfeestypename");
String institutetransporttypeid = request.getParameter("ittid"); 
String sessionname = null;
//out.println("transportfeestypeid===>>>"+transportfeestypeid);

%>
<input type="hidden" name="ittid"  value="<%=institutetransporttypeid%>"/>
<input type="hidden" name="transportfeestypeid" value=<%=request.getParameter("transportfeestypeid") %> />
	<input type="hidden" name="sessionid" value=<%=sessionid %> /> 

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
									sessionname   	= (String)SessionListMap.get("sessionname");
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
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.examnamelist.SL.No")%></th>
        	<th scope="col" class="rounded" width="35%">Category</th>
        	<th scope="col" class="rounded-q4" width="20%">Allocation</th>
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
	class="com.iGrandee.TransportFees.FeesSettingsAction" />
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.TransportFees.FeesSettingsAction"%>

     		<!-- Sindhu -->
     		
     		
     			<tr>
     						
     				<%
     				
     				String sessionidyear = YearofSession.getsessionidforyear(sessionid);
     				//out.println("feestypeid for session==>>"+sessionidyear);
     				
     				%>		
     						
     						<%							
							
							 equalsmonth = YearofSession.getmonth("Year",institutetransporttypeid);
							//out.println("equalsmonth===>>"+equalsmonth);
							if(equalsmonth !=null )
							{
							%>
							<td>1.</td>	
							
							<td>				    	
						    	
						    		Year   
						   		
						    </td> 
						    
						    <td>
						 
						 	<%
							
						 	String status = YearofSession.getStatus(transportfeestypeid,sessionid);
						 	if(status != null)
						 	{ 
							%>   
						    <a href="#" result="<%=query_object.checkcategorydelete("Year", institutetransporttypeid) %>"  equalsmonth=<%=equalsmonth %> institutetransporttypeid=<%=institutetransporttypeid %>   onclick="catupdate(this)" style="text-decoration:none;cursor:pointer;">Deallocate
						    				    
						    </a>
						    <%
						 	}else
						 	{
						 	%>
						 	 <input type="checkbox" name="chkname" value='Year' /> 
						 	<%	
						 	}
						    %>
						    
						    </td>
						   
						    <%
							}else
							{
							%>
								<td>1.</td>	
							
							<td>				    	
						    	Year - <%=sessionname %>
						    </td>
						    
						    <td>
						   
						    <input type="checkbox" name="chkname" value='Year' /> </td>
							<%	
							}
							
						    %>
     				
     			</tr>
     			<%-- <tr>
     				<%							
							
							 equalsmonth = YearofSession.getmonth("Term 2");
							//out.println("equalsmonth===>>"+equalsmonth);
							if(equalsmonth !=null)
							{
							%>
							<td>2.</td>	
							
							<td>				    	
						    	
						    		<a href='#' equalsmonth='Term 2' onClick='Openstage(this)' style='text-decoration:none;'>Term 2</a>
						   		
						    </td>
						    
						    <td>Deallocate</td>
						    <%
							}else
							{
							%>
								<td>2.</td>	
							
							<td>				    	
						    	Term 2
						    </td>
						    
						    <td><input type="checkbox" name="chkname" value='Term 2' /> </td>
							<%	
							}
						    %>
     			</tr>
     			
     			<tr>
     				<%							
							
							 equalsmonth = YearofSession.getmonth("Term 3");
							//out.println("equalsmonth===>>"+equalsmonth);
							if(equalsmonth !=null)
							{
							%>
							<td>3.</td>	
							
							<td>				    	
						    	
						    		<a href='#' equalsmonth='Term 3' onClick='Openstage(this)' style='text-decoration:none;'>Term 3</a>
						   		
						    </td>
						    
						    <td>Deallocate</td>
						    <%
							}else
							{
							%>
								<td>3.</td>	
							
							<td>				    	
						    	Term 3
						    </td>
						    
						    <td><input type="checkbox" name="chkname" value='Term 3' /> </td>
							<%	
							}
						    %>
     			</tr>
     			
     			
     			<tr>
     				<%							
							
							 equalsmonth = YearofSession.getmonth("Term 4");
							//out.println("equalsmonth===>>"+equalsmonth);
							if(equalsmonth !=null)
							{
							%>
							<td>4.</td>	
							
							<td>				    	
						    	
						    		<a href='#' equalsmonth='Term 4' onClick='Openstage(this)' style='text-decoration:none;'>Term 4</a>
						   		
						    </td>
						    
						    <td>Deallocate</td>
						    <%
							}else
							{
							%>
								<td>2.</td>	
							
							<td>				    	
						    	Term 4
						    </td>
						    
						    <td><input type="checkbox" name="chkname" value='Term 4' /> </td>
							<%	
							}
						    %>
     			</tr> --%>
     			
     				
    	
    </tbody>
      
</table>

	<input type="hidden" name="operation" value="yearwise" /> 
	
	<input type="hidden" name="institutetransporttypeid" value=<%=institutetransporttypeid %> />
	<input type="hidden" name="transportfeestypename" value=<%=transportfeestypename %> />
	

</form>
		
		<a href="./Transportyearview.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
		<a href="#" onClick="submitFun()" class="bt_green"><span class="bt_green_lft"></span><strong>Submit</strong><span class="bt_green_r"></span></a>

	<%--	<a href="#" feestypename=<%=transportfeestypeid %> sessionid=<%=sessionid %> onClick="SaveFesstype(this)" class="bt_green"><span class="bt_green_lft"></span><strong>Save</strong><span class="bt_green_r"></span></a>
		
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