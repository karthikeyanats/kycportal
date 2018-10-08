<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child  - Fees Head | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">

function addFeesHead()
{
	if(validflag)
	{
		for(var k=0;k<document.feesheadform.check.length;k++)
				{
							if(document.feesheadform.check[k].checked)
							{
											document.feesheadform.feesheadname[k].disabled=false;
								
							}
							else
							{
										document.feesheadform.feesheadname[k].disabled=true;
							
							}
				}
		document.feesheadform.action="FeesHeadSubmit.jsp";
		document.feesheadform.submit();
	}
	else
	{
	alert("Select any one of the Fees Head option");
	}  
}




var validflag  =false;
function checkfun(obj)
{

	chkid = obj.getAttribute("chkid");
	if(obj.checked)
	{
		if(document.feesheadform.feesheadname[chkid].value == "")
		{
			alert("Fess Head should not be empty");
			document.feesheadform.feesheadname[chkid].focus();
			document.feesheadform.check[chkid].checked=false;
			return false;
		}

	 	var checkoption="no";
	 	var checkoption1="no";
	 	
		if(document.feesheadform.check[chkid].checked)  
		{
			for(var k=0;k<document.feesheadform.check.length;k++)
			{
				if(chkid!=k)
					{
					if(document.feesheadform.check[k].checked)
					{
							if(document.feesheadform.feesheadname[chkid].value==document.feesheadform.feesheadname[k].value)
							{ 
							 	checkoption		= "yes";
							}
						}
					}
				}
		}  
		if(checkoption=="yes")
		{
		alert("Same Fees Head Not Allowed");
		document.feesheadform.check[chkid].checked=false;
		document.feesheadform.feesheadname[chkid].focus();
		return false;
		}
			document.feesheadform.feesheadname[chkid].disabled=true;
			validflag  =true;
	}
	else
	{
		document.feesheadform.feesheadname[chkid].disabled=false;
		validflag  =false;
	}
}

function parseMessages1(parseXML,check_var,chkid)
{
	   var rootobj=parseXML.getElementsByTagName("complaintdetails");
		var clength=rootobj[0].childNodes.length;
		var ask=rootobj[0].childNodes.item(0).childNodes.item(0).firstChild.nodeValue;
		
		if(ask=="true")
		{
		alert("Fees Head Name already Exist");
		document.feesheadform.feesheadname[chkid].value="";
		document.feesheadform.check[chkid].checked=false;
		}
		else
		{
			document.feesheadform.feesheadname[chkid].disabled=true;
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

    <h2><%=bundle.getString("label.feeshead.rootpath") %></h2>
<form name="feesheadform" action="" method="post">

<table id="rounded-corner" border=0 summary="selectd Information" align=center>
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width='10%'><%=bundle.getString("label.feeshead.SL.No")%></th>
        	<th scope="col" class="rounded" width='40%'><%=bundle.getString("label.feeshead.FeesHeadName")%></th>
        	 <th scope="col" class="rounded"  width='10%'><%=bundle.getString("label.feeshead.Chk")%></th>
        	
        	<th scope="col" class="rounded-q4" width='40%'></th>
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
 for(int i=1,j=0;i<6;i++,j++)
	{
 %> <tr>
 	<td><%=i %></td>
	 <td><input type="text" name="feesheadname" size="30" class="tablelight" maxlength="100"/></td>
	  <td colspan=2><input type="checkbox" name="check" chkid="<%=j%>" size="5" class="tablelight" onclick="checkfun(this)"/></td>
	 
	 </tr>
	 <%} %>
	 </tbody>
	 </table>
 
	      <a href="./FeesHeadView.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.feeshead.ViewFeesHead")%></strong><span class="bt_blue_r"></span></a>
     <a href="#" class="bt_green" onclick="addFeesHead()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.feeshead.Submit")%></strong><span class="bt_green_r"></span></a>
     <input type=hidden name="feesheadoperation" value="insert"/>
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>