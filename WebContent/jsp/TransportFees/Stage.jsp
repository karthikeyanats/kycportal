<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.TransportFees.TransportStageAction" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.feesterm.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">


function addFeesTerm()
{
	
	
	if(validflag>0)
	{ 
	
	if(confirm("Are you sure want to insert?"))
	{
		for(var k=0;k<document.routeform.check.length;k++)
		{
					if(document.routeform.check[k].checked)
					{
									document.routeform.stagename[k].disabled=false;
						
					}
					else
					{
								document.routeform.stagename[k].disabled=true;
					
					}
		} 
		document.routeform.action="stagesubmit.jsp";
		document.routeform.submit();
	}	 
	}    

	else
	{     
		alert("select any one of the stage name option");
	}  
}



var validflag  =0;
function checkfun(obj)
{

	chkid = obj.getAttribute("chkid");
	var trimname=document.routeform.stagename[chkid].value;
	trimname=trimname.trim();
	if(obj.checked)
	{
	if(trimname == "")
	{
		alert("Stage Name should not be empty");
	document.routeform.stagename[chkid].focus();
	document.routeform.check[chkid].checked=false;
//	validflag  =true;

	return false;
	} 
	
	var checkoption="no";
	 	var checkoption1="no";
	 	
		if(document.routeform.check[chkid].checked)  
		{
			for(var k=0;k<document.routeform.check.length;k++)
			{
				if(chkid!=k)
					{
					if(document.routeform.check[k].checked)
						{
							if(document.routeform.stagename[chkid].value==document.routeform.stagename[k].value)
							{ 
							 checkoption="yes";
							}
						}
					}
				}
		}  
		if(checkoption=="yes")
		{
		alert("Same Stage Name Not Allowed");
		document.routeform.check[chkid].checked=false;
		document.routeform.stagename[chkid].focus();
		return false;
		}
		
		document.routeform.stagename[chkid].disabled=true;
		validflag++;
	}
	else
	{
		document.routeform.stagename[chkid].disabled=false;
		//validflag  =false;
		validflag--;
	}
	
	console.log("validflag>>>>>>"+validflag);
}



function Gostagelist()
{
document.routeform.action="StageListroutewise.jsp";	
document.routeform.submit();	
} 

function TrashListview()
{
document.routeform.action="Stagetrashroutewise.jsp";	
document.routeform.submit();	
}


</script>
</head>
<body>
<%
String transportstagename = null;
ArrayList Getstagelist=null;
HashMap innermap=null;
if(query_object.getstageforroute(request.getParameter("transportrouteid")+"")!=null){
	
	
	Getstagelist=query_object.getstageforroute(request.getParameter("transportrouteid")+"");
}
%>
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

    <h2>Transport / List Route / Stage Creation	</h2>
<form name="routeform" action="" method="post">
<%
String routename=null;
routename=query_object.getroutename(request.getParameter("transportrouteid")+"");
%>
 <h2>Route Name: &nbsp;&nbsp;<%=routename%></h2>
 <input  type="hidden" name="transportrouteid" value="<%=request.getParameter("transportrouteid")%>"/>
<table id="rounded-corner" border=0 summary="selectd Information" align=center>
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width='10%'>SL.No</th>
        	<th scope="col" class="rounded" width='30%'>Stage Name</th>
        	<th scope="col" class="rounded" width='40%'>Stage Description</th>
        	<th scope="col" class="rounded"  width='10%'>Chk</th>
        	
        	<th scope="col" class="rounded-q4" width='10%'></th>
        </tr>
    </thead>
    <tfoot>
    	<tr> 
        	<td colspan=4 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>  

 <%
 //out.println("insid==>>"+(String)session.getValue("instituteid"));
 for(int i=1,j=0;i<6;i++,j++)
	{ 
 %>
  <tr>
 	<td><%=i%>.</td> 
	 <td><input type="text" name="stagename" size="30" maxlength="100" class="tablelight"   validate="Stage Name" /></td> 
	 <td><textarea   validate="Description" validate="Stage Description" style="resize:none" class="tablelight" cols="45" rows="2" name="descryption" maxlength="400"></textarea></td>
	 	  <td colspan=2><input type="checkbox" name="check" chkid="<%=j%>" size="5" class="tablelight" onclick="checkfun(this)"/></td>
	 
	 </tr>    
	 <%} %>
	 </tbody>
	 </table> 
	  
	  <a href="./Stageno.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
	 
	 	 <a href="#" onclick="TrashListview()" class="bt_red"><span class="bt_red_lft"></span><strong>Trash List </strong><span class="bt_red_r"></span></a>
	 	 <a href="#" onclick="Gostagelist()" class="bt_blue"><span class="bt_blue_lft"></span><strong>Edit / Trash Stage</strong><span class="bt_blue_r"></span></a>
	 
     <a href="#" class="bt_green" routeid="<%=request.getParameter("transportrouteid") %>" onclick="addFeesTerm(this)"><span class="bt_green_lft"></span><strong>Submit</strong><span class="bt_green_r"></span></a> 
	 </br>
	   <h2>Existing Stage for the Route :	&nbsp;&nbsp;<%=routename%> </h2>
	 <table id="rounded-corner" border=0 summary="selectd Information" align=center>
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width='10%'>SL.No</th>
        	<th scope="col" class="rounded" width='30%'>Stage Name</th>
        	<th scope="col" class="rounded" width='50%'>Stage Description</th>
        	
        	
        	<th scope="col" class="rounded-q4" width='10%'></th>
        </tr>
    </thead>
    <tfoot>
    	<tr> 
        	<td colspan=3 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>   
     <%
     int count=0;
     if(Getstagelist!=null && Getstagelist.size()!=0){ 
    	 
    	 for(int k=0;k<Getstagelist.size();k++){
    		 innermap=(HashMap)Getstagelist.get(k);
    		 transportstagename = (String)innermap.get("transportstagename");
    		 count++;
     %>
  <tr>
 	<td><%=count%>.</td> 
	 <td><%=innermap.get("transportstagename") %></td> 
	 <td colspan="1"><%=innermap.get("transportstagedescription") %></td>
	 	  <td></td> 
	 
	 </tr>    
<%
    	 }
     }
     else{
    	 
			out.println("<tr align='center' class='tablebold'><td colspan='9'><font color='red'>Data Not Found</font></td></tr>");

     }
%>	
	 </tbody>
	 </table>
	 
	      
	  <input type=hidden name="routename" value="<%=routename%>"/>
     <input type=hidden name="transportoperation" value="insert"/>
     <input type="hidden" name="transportstagename" value="<%=transportstagename%>" />
     <%
     if(request.getParameter("transportrouteid")!=null){
     %>
     	<input type=hidden name="transportrouteid" value="<%=request.getParameter("transportrouteid")%>"/>
    <%
     }
    %> 
     
</form>
     </div><!-- end of right content-->   


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>