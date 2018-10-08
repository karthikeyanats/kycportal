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
		
function categoryupdation(obj)
{ 
	if(obj.getAttribute("result")!='null'){
		
		alert("Amount Allocated for this Category");
		
	}
	else
	{
		if(confirm("Are you sure want to DeAllocate this Category?")){
			document.feestypeform.equalsmonth.value=obj.getAttribute("equalsmonth");
			
		//	document.feestypeform.institutetransporttypeid.value=obj.getAttribute("institutetransporttypeid");
			document.feestypeform.action="./Categoryunselect.jsp";
			document.feestypeform.submit();
		}
	}
}		 

function submitFun(){
	
	if(validflag>0)
		{
			if(confirm("Do you want to Allocate this Category?"))
			{	
				document.feestypeform.action="./CategorySubmit.jsp";
				document.feestypeform.submit();
			}
		}
	else{
		alert("Select any one option");
	}
}


function CheckFun(obj)
{
	var chkid = obj.getAttribute("value");
	//alert("chkid===>>"+chkid);		
		
	
}		


var validflag  =0;
function CheckFun(obj)
{
	chkid = obj.getAttribute("chkid");
	if(obj.checked)
	{
			validflag++;
	}
	else
	{
		validflag--;
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

    <h2>Transport Fees / Type Selection / List Session /  Set Month</h2>
    
<form name="feestypeform" action="" method="post">
<input type=hidden name=examnameid_hidden>
<input type=hidden name=examname_hidden>
<input type=hidden name=examnameremarks_hidden>
<input type=hidden name=createdby_hidden>
<input type=hidden name=equalsmonth>
<input type="hidden" name="ittid" value="<%=request.getParameter("ittid")%>"/>
<input type=hidden name="sessionid" value="<%=request.getParameter("sessionid")%>">
<input type="hidden" name="transportfeestypename" value="<%=request.getParameter("transportfeestypename")%>">

<% 
String transportfeestypeid = null;
String sessionid    = request.getParameter("sessionid");
transportfeestypeid = request.getParameter("transportfeestypeid");  
String transportfeestypename = request.getParameter("transportfeestypename");
String institutetransporttypeid = null;
institutetransporttypeid=(String)request.getParameter("ittid");
String equalsmonth = null;
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
				
			
<table id="rounded-corner" border=0  width="100%" align="center">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="20%" >Selected Info</th>
        	<th scope="col" class="rounded-q4" colspan=3  width="3%"></th>
        </tr>
    </thead>
				<tr>
			    		<td width="15%" class=tablebold> 
			    			Academic Year:
			    		</td>
			    		<td>
			    			<%=sessionname %>
			    		</td>
			    		<td width="15%"  class=tablebold> 
			    			Fees Type:
			    		</td>
			    		<td>
			    			<%=transportfeestypename %> 
			    		</td>
			    	</tr>
			    	
			    	<tr>
			    		
			    		<td width="15%" class=tablebold> 
			    			Start - End: 
			    		</td>
			    		<td colspan=3>
			    			<%=startmonth %>&nbsp;<%=startyear %> - <%=endmonth %>&nbsp;<%=endyear %>
			    		</td>
			    		
			    	</tr>
			    	
			</table>
				<br></br>
				<%	
				  
		    		 }					    		 
	    		 		
					}
			     }catch(Exception e){}
			          
			     %>

		
<table id="rounded-corner" border=0 summary="Examname List" width="100%" align="center">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.examnamelist.SL.No")%></th>
        	<th scope="col" class="rounded" width="20%">Category</th>
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
					    startmonthcount=startmonthcount; 
					    
					    
					    for(int m=startmonthcount;m<mths.length;m++)
					    {
					    	 String month = mths[m]+" - "+startyear;

					    	%>
						<tr>
							<%							 
							
							 equalsmonth = transportmonth.getmonth(month,institutetransporttypeid);
							//out.println("equalsmonth===>>"+equalsmonth);
							if(equalsmonth !=null)
							{
								
							%>
							<td><%=j++ %>.</td>	
							
							<td>				    	
						    	<%
						    		//out.println("<a href='#' equalsmonth='"+equalsmonth+"' onClick='Openstage(this)' style='text-decoration:none;'>"+month+"</a>");
						    		out.println(month);
						   		 %>
						    </td>
						    
						   <td><a href= "#" result="<%=query_object.checkcategorydelete(month, institutetransporttypeid) %>" equalsmonth=<%=equalsmonth %> institutetransporttypeid=<%=institutetransporttypeid %> onclick="categoryupdation(this)">DeAllocate</a></td>
						    <%
							}else
							{
							%>
								<td><%=j++ %>.</td>	
							
							<td>				    	
						    	<%
						    		out.println(month);
						   		 %>
						    </td>
						    
						    <td><input type="checkbox" name="chkname" validate="options" chkid=<%=j %> value="<%=month %>" onClick="CheckFun(this)" /></td>
							<%	
							}
						    %>
						    
						   
						 </tr>
						   <%
					    }
					    
					    for(int m=0;m<mths.length;m++)
					    {
					    	if(endmonth.equals(mths[m]))
					    	{
					    		 String month = mths[m]+" - "+endyear;
					    		
					    		%>
							<tr>					    		
					    		<%					    	
					    		equalsmonth = transportmonth.getmonth(month,institutetransporttypeid);
					    		//out.println("equalsmonth===>>"+equalsmonth);
								if(equalsmonth !=null)
							{
							%>
							<td><%=j++ %>.</td>	
							
							<td>				    	
						    	<%
						    	out.println(month);						   		
						    	%>
						    </td>
						    
						   <td><a href= "#" result="<%=query_object.checkcategorydelete(month, institutetransporttypeid) %>" equalsmonth=<%=equalsmonth %> institutetransporttypeid=<%=institutetransporttypeid %> onclick="categoryupdation(this)">DeAllocate</a></td>
						    <%
							}else
							{
							%>
								<td><%=j++ %>.</td>	
							
							<td>				    	
						    	<%
						    	out.println(month);
						   		 %>
						    </td>
						    
						    <td><input type="checkbox" name="chkname" validation="Check" chkid=<%=j %> value="<%=month %>" onClick="CheckFun(this)" /></td>
							<%	
							}
						    %>
					    		
					    	</tr> 
					    		<%					    		
					    		
					    		break;
					    	}
					    	else
					    	{
						    	 String month = mths[m]+" - "+endyear;

					    		%>
							<tr>					    		
					    		<%					    		 
					    		equalsmonth = transportmonth.getmonth(month,institutetransporttypeid);
					    		//out.println("equalsmonth===>>"+equalsmonth);
							if(equalsmonth !=null)
							{
							%>
							<td><%=j++ %>.</td>	
							
							<td>				    	
						    	<%
						    	out.println(month);						   		 %>
						    </td>
						    
						    <td><a href= "#" result="<%=query_object.checkcategorydelete(month, institutetransporttypeid) %>" equalsmonth=<%=equalsmonth %> institutetransporttypeid=<%=institutetransporttypeid %> onclick="categoryupdation(this)">DeAllocate</a></td>
						    <%
							}else
							{
							%>
								<td><%=j++ %>.</td>	 
							
							<td>				    	
						    	<%
						    	out.println(month);
						   		 %>
						    </td>
						    
						    <td><input type="checkbox" name="chkname" validation="Check" chkid=<%=j %> value="<%=month %>" onClick="CheckFun(this)" /></td>
							<%	
							}
						    %>
					    		
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

	
	<input type="hidden" name="operation" value="monthwise" />
	<input type="hidden" name="transportfeestypeid" value=<%=transportfeestypeid %> /> 
	

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