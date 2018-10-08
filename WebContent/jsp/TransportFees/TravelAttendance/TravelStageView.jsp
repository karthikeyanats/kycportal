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

function Openstage(obj)
{
	var equalsmonth = obj.getAttribute("equalsmonth");
	document.feestypeform.action = "stagecatamountallot.jsp?equalsmonth="+equalsmonth;
	document.feestypeform.submit();
}

function LoadingStage(obj)
{
	
	document.feestypeform.transportrouteid.value = obj.getAttribute("transportrouteid");
	document.feestypeform.action = "stagecatamountallot.jsp";
	document.feestypeform.submit();
}
 
function back()
{
	document.feestypeform.action="TravelRoute.jsp";	
	document.feestypeform.submit();
}

function StudentView(obj)
{
	document.feestypeform.transportrouteid.value = obj.getAttribute("transportrouteid");
	document.feestypeform.action = "TravelStageView.jsp"; 
	document.feestypeform.submit();
}


function gostudentview(obj)
{
	document.feestypeform.routename.value=obj.getAttribute("routename");
	document.feestypeform.studentapprovalid.value=obj.getAttribute("studentapprovalid");
	document.feestypeform.transportstagename.value=obj.getAttribute("transportstagename");
	document.feestypeform.action= "TravelStudentView.jsp";
	document.feestypeform.submit();
} 

</script>

</head>
<body>
<div id="main_container">
	<div class="header">
<%@ include file="../../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">


<%@ include file="../../include/header.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2>Transport Fees / Travel Attendance / Category View / Route List / Stage List </h2>
    
<form name="feestypeform" action="" method="post">
<input type=hidden name=examnameid_hidden>
<input type=hidden name=examname_hidden>
<input type=hidden name=examnameremarks_hidden>
<input type=hidden name=createdby_hidden>

<%
String transportfeestypeid = null;

String sessionid    = (String)session.getValue("sessionid"); ;
String sessionname = (String)session.getValue("sessionname"); 
transportfeestypeid = request.getParameter("transportfeestypeid");
String transportrouteid = request.getParameter("transportrouteid");

//out.println("transportrouteid===>>"+transportrouteid);
String transportfeestypename = request.getParameter("tn"); 
String transportcategoryname = request.getParameter("transportcategoryname");
String transportcategoryid = request.getParameter("transportcategoryid");
String institutetransporttypeid = request.getParameter("institutetransporttypeid");
String routename = null; 
routename = request.getParameter("routename");
//out.println("routename===>>>"+routename); 

String equalsmonth = null;

%>
	<input type="hidden" name="sessionid" value=<%=sessionid %> />
	
	<input type="hidden" name="transportcategoryname" value=<%=transportcategoryname %> />
		<input type="hidden" name="transportcategoryid" value=<%=transportcategoryid %> />
		<input type="hidden" name="transportrouteid" value=<%=transportrouteid %> />
	
  	<input type="hidden" name="transportstagename" value=""/>
	<input type="hidden" name="studentapprovalid" value=""/>
	<input type="hidden" name="routename" value="<%=routename%>"/>
				
				<table width="100%" >
				<tr>
			    		<td width="15%">  
			    			<h4></>Year of Session: </h4>
			    		</td>
			    		<td>
			    			<%=sessionname %>
			    		</td>
			    		<td width="15%">  
			    			<h4></>Category Name: </h4>
			    		</td>
			    		<td>
			    			
			    			<%
			    			
			    			 FeesSettingsAction  YearofSession = new FeesSettingsAction();
			    			
			    			if(transportcategoryid.equals("Term 1") || transportcategoryid.equals("Term 2") || transportcategoryid.equals("Term 3"))
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
			    	<td>
			    		<h4>Route Name:</h4>
			    	</td>
			    	<td>
			    		<%=routename %>
			    	</td>
			    	</tr>
			    	
			</table>
				
				

<table id="rounded-corner" border=0 summary="Examname List" width="100%" align="center">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.examnamelist.SL.No")%></th>
        	<th scope="col" class="rounded" width="20%">Stage Name</th>
        	<th scope="col" class="rounded" width="20%">No.of. Students</th>
        	<th scope="col" class="rounded-q4" width="20%">Attendance</th>
        </tr>
    </thead>
    
   <!--  <tfoot>
    	<tr>
        	<td colspan="6" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot> -->
    
     <jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.TransportFees.TransportRouteAction" />
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.TransportFees.FeesSettingsAction"%>

     		<!-- Sindhu -->
     		
     		 <%
			     FeesSettingsAction  amountsettin = new FeesSettingsAction();
			     String instituteid = null;
			     ArrayList LoadamountsettinList = null;
			     ArrayList Stagecount=null;
				     try
				     {
				    	  instituteid = (String)session.getValue("instituteid"); 
				    	  //out.println("instituteid===>>"+instituteid);
				    	//  LoadamountsettinList = query_object.gettransportroutecount(transportrouteid);
				    	  LoadamountsettinList = query_object.gettransportstagestucount(transportrouteid);
				    	//out.println("LoadamountsettinList===>>"+LoadamountsettinList);
					    	  ArrayList archival = new ArrayList();
					    	  if(LoadamountsettinList!=null && LoadamountsettinList.size()>0)
								{
					    		 for (int k = 0, m = 1; k < LoadamountsettinList.size(); k++) {
								
									HashMap AmountListMap=(HashMap)LoadamountsettinList.get(k);
									
									String transportstageid          = (String)AmountListMap.get("transportstageid");
									String transportstagename        = (String)AmountListMap.get("transportstagename");
									String studentcount              = (String)AmountListMap.get("studentcount");
									String studentapprovalid         = (String)AmountListMap.get("studentapprovalid");
									
									
									//Stagecount=query_object.gettransportroutestagecount(transportrouteid);
		
				%>  
				
									<tr>
							    		<td>
							    			<%=m++ %>.
							    		</td>
							    		
							    		<td>
							    			
							    				<%=transportstagename %>
							    			
							    		</td>	
							    		
							    		<td>
							    		<%
							    			if(studentcount != null)
							    			{	
							    			%>
							    			<a href='#' routename='<%=routename %>' transportstagename='<%=transportstagename %>' studentapprovalid="<%=studentapprovalid %>" onclick='gostudentview(this)'><%=studentcount %></a>
							    			<%
							    			}else
							    			{
							    			%>
							    			<%=studentcount %>
							    			<%	
							    			}
							    			%> 
							    		</td>		    		
							    		
							    		<td>
							    			
							    		</td>
							    		
							    		
							    		
							    	</tr>
			    	
			    	
			
				
				<%	
				  
		    		 }					    		 
	    		 		
					}else
					{
						out.print("<tr><td colspan='4' align='center'><font color='red'><b>Data not Found</b></font></td></tr>");
					}
			     }catch(Exception e){}
			          
			     %>
     		</table>
    	
    </tbody>
      
</table>

	
	
		 
		<a href="#" onclick="back()" class="bt_blue"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
		 
		

	<%--	<a href="#" feestypename=<%=transportfeestypeid %> sessionid=<%=sessionid %> onClick="SaveFesstype(this)" class="bt_green"><span class="bt_green_lft"></span><strong>Save</strong><span class="bt_green_r"></span></a>
		
      <a href="./ExamnameDeactivatedViewList.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.examnamelist.deactivatelist")%></strong><span class="bt_blue_r"></span></a>
     <a href="./ExamnameTrashedView.jsp" class="bt_red"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.examnamelist.trashitems")%></strong><span class="bt_red_r"></span></a> --%>

     </div><!-- end of right content-->


  </div>   <!--end of center content -->

 
</form>


    <div class="clear"></div>
    </div> <!--end of main content--> 

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>