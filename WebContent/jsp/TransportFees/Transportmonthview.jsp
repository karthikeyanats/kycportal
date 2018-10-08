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

    <h2>Transport Fees / Fees Type</h2>
    
<form name="feestypeform" action="" method="post">
<input type=hidden name=examnameid_hidden>
<input type=hidden name=examname_hidden>
<input type=hidden name=examnameremarks_hidden>
<input type=hidden name=createdby_hidden>

<%
String transportfeestypeid = null;

String sessionid    = request.getParameter("sessionid");

transportfeestypeid = request.getParameter("transportfeestypeid");
String transportfeestypename = request.getParameter("tn");
//out.println("transportfeestypeid===>>>"+transportfeestypename);

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
			    		<td> 
			    			<h4></>Year of Session: <%=sessionname %> </h4>
			    		</td>
			    		<td> 
			    			<h4></>Fees Type: <%=transportfeestypename %> </h4>
			    		</td>
			    	</tr>
			    	
			    	<tr>
			    		<td> 
			    			<h4></>Start - End Year: <%=startyear %> - <%=endyear %> </h4>
			    		</td>
			    		<td> 
			    			<h4></>Start - End Month: <%=startmonth %> - <%=endmonth %>  </h4>
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
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.examnamelist.SL.No")%></th>
        	<th scope="col" class="rounded" width="35%">Month</th>
        	<th scope="col" class="rounded" width="35%">Alloted Stage</th>
        	<th scope="col" class="rounded-q4" width="20%">Allot</th>
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
     			
     		 	
     		 
			     FeesSettingsAction  transportmonth = new FeesSettingsAction();			     
			     ArrayList Loadtransportmonth = null;
				     try
				     {
				    	 
				    	 Loadtransportmonth = transportmonth.gettransportmonth(sessionid);
    	 								    	  

					    	 ArrayList archivalDetails = new ArrayList();
					    	  
					    	 if(Loadtransportmonth!=null && Loadtransportmonth.size()>0)
								{
					    		 for (int i = 0, j = 1; i < Loadtransportmonth.size(); i++) {
								
									HashMap feestypeListMap=(HashMap)Loadtransportmonth.get(i);
									
									String startmonth   = (String)feestypeListMap.get("startmonth");
									String endmonth   	= (String)feestypeListMap.get("endmonth");
									String startyear    = (String)feestypeListMap.get("startyear");
									String endyear    = (String)feestypeListMap.get("endyear");
									
				%> 
					
						<%
						
						String[] mths = {"January","February","March","April","May","June","July","August","September","October","November","December"};
						
						String searchingFor = startmonth;
						
						/* for(String s : mths)
					    {
							 if(!searchingFor.equals(s) && !endmonth.equals(s))
						        {
						           
								
								 	out.println("s===>>>"+s);
						           
						        }						 
					    } */
					    
					   
					    
					    int startmonthcount=0;
					    int endmonthcount=0;
					    
					    for(int m=0;m<mths.length;m++)
					    {
					    	if(startmonth.equals(mths[m]))
					    	{
					    		startmonthcount=m;
					    		break;
					    	}
					    	
					    }
					    startmonthcount=startmonthcount+1;
					    
					    
					    for(int m=startmonthcount;m<mths.length;m++)
					    {
					    	
					    	%>
						<tr>
							<td><%=j++ %>.</td>	
							<td>				    	
						    	<%
						    	out.println(mths[m]+" - "+startyear);
						    %>
						    </td>
						    <td>
						    	
						    </td>
						    <td>
						    	<a transportfeestypeid=<%=transportfeestypeid %> onClick="Stageallot(this)" style="text-decoration:none;"><input type=button name="allotbutton" value="Allot" /></a>
						    </td>
						 </tr>
						   <%
					    }
					    
					    for(int m=0;m<mths.length;m++)
					    {
					    	if(endmonth.equals(mths[m]))
					    	{
					    		break;
					    	}
					    	else
					    	{
					    		%>
							<tr>					    		
					    		<td><%=j++ %>.</td>	
					    		<td>
					    		<%
					    			out.println(mths[m]+" - "+endyear);
					    		%>
					    		</td>
					    		<td>
									stage count					    			
					    		</td>
					    		<td>
							    	<a transportfeestypeid=<%=transportfeestypeid %> onClick="Stageallot(this)" style="text-decoration:none;"><input type=button name="allotbutton" value="Allot" /></a>
							    </td>
					    	</tr>
					    		<%
					    	}
					    	
					    }
					    
					    
						
						%>
						
				
				
				<%			    		 }
									}
			     }catch(Exception e){}
			          
			     %>
     		
     		
    	
    </tbody>
      
</table>

	<input type="hidden" name="sessionid" value=<%=sessionid %>>
	<input type="hidden" name="transportfeestypeid" value=<%=transportfeestypeid %>>
	

</form>
		<a href="<%=request.getContextPath() %>/jsp/TransportFees/Transportyearview.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>

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