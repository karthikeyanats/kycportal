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
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript">
hs.graphicsDir = "<%=request.getContextPath()%>/js/highslide/graphics/"; 
hs.outlineType = 'rounded-white'; 
hs.wrapperClassName = 'draggable-header';  
 

function Allotstage(obj){	
	
	if(check_ForParticularElements(document.stageamountform.checkstage,"radio"))
	{
		var Flag=false;
		 var transportcategoryid = obj.getAttribute("transportcategoryid");
		 var transportstageid = obj.getAttribute("transportstageid"); 
		var chklength = document.stageamountform.checkstage.length;
		alert("chklength ===>>>"+chklength);

		if(chklength==undefined)
		{ 
			
			if(document.stageamountform.checkstage.checked==true) 
			{
				alert("document.stageamountform.checkstage==>>"+document.stageamountform.checkstage.length);
				Flag=true;
			}	
			
		}
		else 
		{
			for(var i=0;i<chklength;i++){
				
				if(document.stageamountform.checkstage[i].checked==true)
				{

					alert("document.stageamountform.checkstage[i]==>>"+document.stageamountform.checkstage[i].length);
					Flag=true;
				}	
			}
			
		}  		
		
		if(Flag)
		{
			if("Do you want to allot the Stage?")
			{	
			document.stageamountform.action="./stageallotamountsubmit.jsp?transportcategoryid="+transportcategoryid+"&transportstageid="+transportstageid;
			document.stageamountform.submit();
			}
			
		} 
		else 
		{
			alert("Select any one checkbox");
			return false;
			
		}
		
	} 
}


function checkfun(obj)
{
	
	var transportstageid = obj.getAttribute("transportstageid");
	alert(transportstageid);
} 


function Amountallot(obj)
{
	var transportstageid = obj.getAttribute("transportstageids");
	//alert("transportstageid===>>"+transportstageid);
	document.stageamountform.action="./stagecatamountallot.jsp";
	document.stageamountform.submit();
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

    <h2>Transport Fees / </h2>
    
<form name="stageamountform" action="" method="post">


<%

String transportstageid = null;
String transportcategoryid = null;
transportcategoryid = request.getParameter("equalsmonth");
String transportfeestypename = request.getParameter("transportfeestypename");
String sessionid = (String)session.getValue("sessionid");
String transportcategoryname = null;
String transportstagename = null;
//out.println("transportfeestypename===>>>"+transportfeestypename);


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
			    			<h4></>Start - End Year: </h4>
			    		</td>
			    		<td>
			    			<%=startyear %> - <%=endyear %> 
			    		</td>
			    		<td width="15%"> 
			    			<h4></>Start - End Month:   </h4>
			    		</td>
			    		<td>
			    			<%=startmonth %> - <%=endmonth %>
			    		</td>
			    		
			    	</tr>
			    	
			    	<tr>
			    		<td width="15%"> 
			    			<h4></>Category Type: </h4>
			    		</td>
			    		<td>
			    			<%
			    			if(transportcategoryid == "Term 1" && transportcategoryid == "Term 2" && transportcategoryid == "Term 3")
			    			{	
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
			    		<td width="15%"> 
			    			<h4></>  </h4>
			    		</td>
			    		<td>
			    			
			    		</td>
			    	</tr>
			    	
			    	
			</table>
				
				<%	
				  
		    		 }					    		 
	    		 		
					}
			     }catch(Exception e){}
			          
			     %>	
			     
			     
			<table width=100% align=center>
				<tr>
					<td>  
						<a href="#" transportstageids="<%=transportstageid %>" onClick="Amountallot(this)" style="text-decoration:none;" onClick="Allotstage(this)" class="bt_green"><span class="bt_green_lft"></span><strong>Amount Settings</strong><span class="bt_green_r"></span></a>
					</td>
				</tr>
			</table>        
			     
	
	<table id="rounded-corner" border=0 summary="Examname List" width="100%" align="center">
	
	
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.examnamelist.SL.No")%></th>
        	<th scope="col" class="rounded" width="35%">Routes</th>
            <th scope="col" class="rounded" width="35%">Stages</th>
            <th scope="col" class="rounded-q4" width="35%">Select</th>
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
			     FeesSettingsAction  stageforamounallotment = new FeesSettingsAction();
			    instituteid = null;
			     ArrayList Loadstageforamounallotment = null;
				     try
				     {
				    	  instituteid = (String)session.getValue("instituteid"); 
				    	  //out.println("instituteid===>>"+instituteid);
				    	  Loadstageforamounallotment = stageforamounallotment.getstageforamounallotment();
    	 

					    	  ArrayList archivalDetails = new ArrayList();
					    	  if(Loadstageforamounallotment!=null && Loadstageforamounallotment.size()>0)
								{
					    		 for (int i = 0, j = 1; i < Loadstageforamounallotment.size(); i++) {
								
									HashMap SessionListMap=(HashMap)Loadstageforamounallotment.get(i);
									
									transportstageid        = (String)SessionListMap.get("transportstageid");
									transportstagename   	= (String)SessionListMap.get("transportstagename"); 
									String routename        = (String)SessionListMap.get("routename");
									String routeid        = (String)SessionListMap.get("transportrouteid");
		 
				%>  
				
					<tr>
						
						<%
							String Stageid = stageforamounallotment.getstageid(transportstageid);
							//out.println("Stageid===>>>"+Stageid);
							if(Stageid != null)
							{	
							%>
						
						<td><%=j++ %>.</td>
						
						<td>
														
							<%=routename %>
							
							
						</td>
						
						<td>
														
							<%=transportstagename %>
							
							
						</td>
						<td>Inserted</td>
						
						<%
							}else
							{
							%>
								<td><%=j++ %>.</td>
						<td>
														
							<%=routename %>
							
							
						</td>		
								
						<td>
														
							<%=transportstagename %>
							
							
						</td>
						<td><input type="checkbox" name="checkstage" chkid="<%=i+1%>" transportcategoryid=<%=transportcategoryid %> transportstageid="<%=transportstageid %>" value=<%=transportstageid %> size="5" class="tablelight" onclick="checkfun(this)"/></td>
						
						
						
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


	

	<a href="<%=request.getContextPath() %>/jsp/TransportFees/Transportyearview.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>

		<a href="#" transportcategoryid=<%=transportcategoryid %> transportstageid=<%=transportstageid %>  onClick="Allotstage(this)" class="bt_green"><span class="bt_green_lft"></span><strong>Save</strong><span class="bt_green_r"></span></a>

	<%-- <a href="./ExamnameEntry.jsp" class="bt_green"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.examnamelist.addnew")%></strong><span class="bt_green_r"></span></a>
     <a href="./ExamnameDeactivatedViewList.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.examnamelist.deactivatelist")%></strong><span class="bt_blue_r"></span></a>
     <a href="./ExamnameTrashedView.jsp" class="bt_red"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.examnamelist.trashitems")%></strong><span class="bt_red_r"></span></a> --%>

<input type='hidden' name="transportstageid" value="" />
<input type='hidden' name="transportstageids" value="<%=transportstageid %>" />
<input type='hidden' name="transportfeestypename" value="<%=transportfeestypename %>" />
<input type='hidden' name="transportstagename" value="<%=transportstagename %>" />
<input type='hidden' name="transportcategoryname" value="<%=transportcategoryname %>" /> 
<input type='hidden' name="transportcategoryid" value="<%=transportcategoryid %>" />
    
    </form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>