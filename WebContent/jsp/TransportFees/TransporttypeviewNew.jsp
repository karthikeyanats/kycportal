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


function UpdateFesstype(obj){	
		
	if(check_ForParticularElements(document.feestypeform.feestypename,"userdefinedradio"))
	{
		if(confirm("Do you want to change the Fees Type for this Session?"))
		{
		document.feestypeform.action = "FeesTypeUpdateSubmit.jsp";
		document.feestypeform.submit();
		}
	}
}

function clickfun(id)
{
	document.feestypeform.transportfeestypeid.value=id;
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

    <h2> Transport Fees / Type Selection / List Session / Set Fees Type</h2>
   
   
    
<form name="feestypeform" action="" method="post">
<input type=hidden name=examnameid_hidden>
<input type=hidden name=examname_hidden>
<input type=hidden name=examnameremarks_hidden>
<input type=hidden name=createdby_hidden>

<%
String transportfeestypeid = null;

String sessionid    = (String)request.getParameter("sessionid");

FeesSettingsAction  transportfeestype = new FeesSettingsAction();	
 
String sessionname = transportfeestype.getsessionname(sessionid);
	
	
String transportfeestypename = request.getParameter("tn");
String feestypeid = request.getParameter("f");
String feestypeinstituteid = null;						
					

%>


<table>
	<tr>
    		<td> 
    			<h4>Year of Session: <%=sessionname %> </h4>
    		</td>
    	</tr>
</table>

<table id="rounded-corner" border=0 summary="Examname List" width="100%" align="center">
    <thead>
    	
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.examnamelist.SL.No")%></th>
        	<th scope="col" class="rounded" width="35%">Fees Type</th>
            <th scope="col" class="rounded-q4" width="20%">Select</th>
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
     		 String result=null;
			   		     
			     ArrayList Loadtransportfeestype = null;
				     try
				     {
				    	 
				    	  Loadtransportfeestype = transportfeestype.gettransportfeestype();
    	 					
				    	  

					    	 ArrayList archivalDetails = new ArrayList();
					    	  
					    	 if(Loadtransportfeestype!=null && Loadtransportfeestype.size()>0)
								{
					    		 for (int i = 0, j = 1; i < Loadtransportfeestype.size(); i++) {
								
									HashMap feestypeListMap=(HashMap)Loadtransportfeestype.get(i);
									
									transportfeestypeid      = (String)feestypeListMap.get("transportfeestypeid");
									transportfeestypename   	= (String)feestypeListMap.get("transportfeestypename");
		
				%> 
				
					<tr>
						<td><%=j++ %>.</td>
						
						<%
						if(transportfeestypeid.equals(feestypeid))
						{	
						%>
						
						<td><%=transportfeestypename %></td>
						<td><input type="radio" value=<%=transportfeestypeid %> name="feestypename" checked onClick="clickfun(<%=transportfeestypeid %>)"/></td>
						<%
						}else
						{	
						%>
						<td><%=transportfeestypename %></td>
						<td><input type="radio" value=<%=transportfeestypeid %> name="feestypename" onClick="clickfun(<%=transportfeestypeid %>)"/></td>						
						<%
						}
						%>
					</tr>		
					
					<%
						if(transportfeestypeid.equals(feestypeid))
						{
							
							
							result=transportfeestype.checkfeestype(transportfeestypeid,sessionid);
							//out.println("result===>>>"+result);

						} 
						%>		 
			
				<%			    		 }
									}
			     }catch(Exception e){
			    	 e.printStackTrace();
			     }
			          
			     %>
     		
     		
    	
    </tbody>
      		<%
				feestypeinstituteid = transportfeestype.getidforupdatefeestype(feestypeid,sessionid);
				
				%>
</table>

	<input type="hidden" name="sessionid" value=<%=sessionid %>>
	<input type="hidden" name="transportfeestypeid" value='' />
	<input type="hidden" name="institutetransporttypeid" value='<%=feestypeinstituteid %>' />
	

</form>


		<a href="<%=request.getContextPath() %>/jsp/TransportFees/Transportyearview.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
<%
if(result==null){
%>
		<a href="#"  onClick="UpdateFesstype()" class="bt_green"><span class="bt_green_lft"></span><strong>Update</strong><span class="bt_green_r"></span></a>
		
<%
}
else{
	
	out.println("<h2>Category has been allocated to this Fees Term You Can't Update</h2>");
	
}
%>		
		
    <%--  <a href="./ExamnameDeactivatedViewList.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.examnamelist.deactivatelist")%></strong><span class="bt_blue_r"></span></a>
     <a href="./ExamnameTrashedView.jsp" class="bt_red"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.examnamelist.trashitems")%></strong><span class="bt_red_r"></span></a> --%>

     </div><!-- end of right content-->


  </div>   <!--end of center content -->

<%

%>


    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>