<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
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
									document.routeform.routename[k].disabled=false;
						
					}
					else
					{
								document.routeform.routename[k].disabled=true;
					
					}
		} 
		document.routeform.action="transportroutesubmit.jsp";
		document.routeform.submit();
	}	
	}    

	else
	{     
		alert("select any one of the transportRoute option");
	}  
}



var validflag  =0;
function checkfun(obj)
{

	chkid = obj.getAttribute("chkid");
	var trimname=document.routeform.routename[chkid].value;
	trimname=trimname.trim();
	if(obj.checked)
	{
	if(trimname == "")
	{
		alert("Route Name should not be empty");
	document.routeform.routename[chkid].focus();
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
							if(document.routeform.routename[chkid].value==document.routeform.routename[k].value)
							{ 
							 checkoption="yes";
							}
						}
					}
				}
		}  
		if(checkoption=="yes")
		{
		alert("Same Route Name Not Allowed");
		document.routeform.check[chkid].checked=false;
		document.routeform.routename[chkid].focus();
		return false;
		}
		
		document.routeform.routename[chkid].disabled=true;
		validflag++;
	}
	else
	{
		document.routeform.routename[chkid].disabled=false;
		//validflag  =false;
		validflag--;
	}
	
	console.log("validflag>>>>>>"+validflag);
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

    <h2>Transport / TransportRoute</h2>
<form name="routeform" action="" method="post">

<table id="rounded-corner" border=0 summary="selectd Information" align=center>
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width='10%'>SL.No</th>
        	<th scope="col" class="rounded" width='30%'>Route Name</th>
        	<th scope="col" class="rounded" width='40%'>Route Description</th>
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
// out.println("insid==>>"+(String)session.getValue("instituteid"));
 for(int i=1,j=0;i<6;i++,j++)
	{
 %> <tr>
 	<td><%=i%></td>
	 <td><input type="text" name="routename" size="30" maxlength="50" class="tablelight" validate="Route Name" /></td> 
	 <td><textarea   validate="Description" validate="Route Description" style="resize:none" class="tablelight" cols="45" rows="2" name="descryption" maxlength="400"></textarea></td>
	 	  <td colspan=2><input type="checkbox" name="check" chkid="<%=j%>" size="5" class="tablelight" onclick="checkfun(this)"/></td>
	 
	 </tr>    
	 <%} %>
	 </tbody>
	 </table>
	 
	      <a href="./transportroutelist.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong>View TransportRoute</strong><span class="bt_blue_r"></span></a>
     <a href="#" class="bt_green" onclick="addFeesTerm()"><span class="bt_green_lft"></span><strong>Submit</strong><span class="bt_green_r"></span></a>
     <input type=hidden name="transportoperation" value="insert"/>
</form>
     </div><!-- end of right content-->  


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>