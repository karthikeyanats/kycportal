<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.TransportFees.TransportStageAction" />
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
		<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>TransportRoute Edit</title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></SCRIPT>
<script language="JavaScript">


function goToBack()
{
	document.stageform.action= "StageListroutewise.jsp";
document.stageform.submit();
}
function goToUpdate()
{
if(check_ForParticularElements(document.stageform.transportstagename,"text"))
	{
		
if(confirm("Do you want to Update the Stage...?"))
{
	document.stageform.action= "Stageupdate.jsp";
document.stageform.submit();
}
else{}

}
}
function charcount()
{
var countlen=2000-document.stageform.transportstagedescription.value.length;
document.getElementById("labelid").innerHTML	= countlen;

}	

	 
</script>

</head>

<body onload="charcount()">
<form name="stageform" method="post" action="">

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
         <h2>Transport / List Route / Stage Creation / Stage List / Stage Edit</h2>
         <%
String routename=null;
if(request.getParameter("routename")!=null){
	routename=request.getParameter("routename");
	out.println("<input type='hidden' name='routename' value='"+routename+"'>");
	out.println("<h2>Route Name: &nbsp;&nbsp;"+routename+"</h2>");  
	
} 
         
         %>
<%@ page language="java" import="java.util.*"%>
<%
try{
	String transportrouteid=null;
	String transportstageid = null;

	if(request.getParameter("transportrouteid")!=null){
		transportrouteid=(String)request.getParameter("transportrouteid");
		out.println("<input type='hidden' name='transportrouteid' value='"+transportrouteid+"'>");
	} 
	
	if(request.getParameter("transportstageid")!=null){
		transportstageid = request.getParameter("transportstageid");
		out.println("<input type='hidden' name='transportstageid' value='"+transportstageid+"'>");
	} 
	



	

	ArrayList getEditdetails=query_object.getedittransportstage(transportstageid); 
	HashMap DetailsForuadate=null;
	String transportstagename=null;
	String transportstagedescription=null;
	
	for(int k=0;k<getEditdetails.size();k++)
	{
		DetailsForuadate=(HashMap)getEditdetails.get(k);
		 transportstagename=(String)DetailsForuadate.get("transportstagename");
		 transportstagedescription=(String)DetailsForuadate.get("transportstagedescription");

	}
	if(transportstagedescription.equals(""))
	{
	transportstagedescription="-";
	}
	
%>
<form name="stageform" method="post" action="">
  <input type="hidden" name="transportstageid" value="<%=transportstageid %>">

<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	

	<tr>
		<td>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	
            
              <th scope="col" class="rounded-company" width="20%">Stage Update</th>
        	<th scope="col" class="rounded" width="1%"></th>
        	<th scope="col" class="rounded" width="20%" ></th>
            <th scope="col" class="rounded" width="20%" ></th>
            <th scope="col" class="rounded" width="20%" ></th>
            <th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font> <%=bundle.getString("label.role.mandatoryfields") %></th>
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=5  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
</tbody>
</table>
	
		<table id="rounded-corner" border=0 summary="Department List" width="100%">


    <thead>

			<tr  valign="top">
				<td  class="tablebold">Stage Name <font color=red>*</font></td>
				<td width="1%" class="tablebold">:</td>
				<td class="tablelight"><input type="text"   name="transportstagename" validate="Route Name" maxlength=45 size=50 value="<%=transportstagename.replaceAll("\"","&quot;")%>"></td>
			</tr>
			<tr valign="top">
				<td a class="tablebold">Stage Description </td>
							
			<td width="1%" class="tablebold">:</td>
			<td class="tablelight">
			<textarea validate="Stage Description" class="tablelight" style="resize:none" cols=75 rows=2 name="transportstagedescription" maxlength="400"><%=transportstagedescription %></textarea>			</td>	
			</tr>
			
		
		</table>
		     		  <a href="#" onclick="goToBack()"  class="bt_blue"><span class="bt_blue_lft"></span><strong>Back </strong><span class="bt_blue_r"></span></a>
		
	     <a href="#" class="bt_green" onclick="goToUpdate()"><span class="bt_green_lft"></span><strong>Update</strong><span class="bt_green_r"></span></a>
     
   <tfoot>
    	<tr>
        	<td colspan="2" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
    
			</thead>
</table>
	

	</td>
</tr>
   <tfoot>
    	<tr>
        	<td colspan="6" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
</TABLE>


     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../include/footer.jsp" %>
<%
}
catch(Exception e){
	e.printStackTrace();
	
	
}
%>
</div>

    </form>
	
</body>
</html>