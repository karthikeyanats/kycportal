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
	
	
	if(validflag)
	{
	for(var k=0;k<document.feestermform.check.length;k++)
				{
							if(document.feestermform.check[k].checked)
							{
											document.feestermform.feestermname[k].disabled=false;
								
							}
							else
							{
										document.feestermform.feestermname[k].disabled=true;
							
							}
				} 
		document.feestermform.action="FeesTermSubmit.jsp";
		document.feestermform.submit();
	}    

	else
	{     
	alert("select any one of the Fees Term option");
	}  
}



var validflag  =false;
function checkfun(obj)
{

	chkid = obj.getAttribute("chkid");
	if(obj.checked)
	{
	if(document.feestermform.feestermname[chkid].value == "")
	{
	alert("Fees Term should not be empty");
	document.feestermform.feestermname[chkid].focus();
	document.feestermform.check[chkid].checked=false;
	return false;
	}  
	
	
	
	var checkoption="no";
	 	var checkoption1="no";
	 	
		if(document.feestermform.check[chkid].checked)  
		{
			for(var k=0;k<document.feestermform.check.length;k++)
			{
				if(chkid!=k)
					{
					if(document.feestermform.check[k].checked)
						{
							if(document.feestermform.feestermname[chkid].value==document.feestermform.feestermname[k].value)
							{ 
							 checkoption="yes";
							}
						}
					}
				}
		}  
		if(checkoption=="yes")
		{
		alert("Same Fees Term Not Allowed");
		document.feestermform.check[chkid].checked=false;
		document.feestermform.feestermname[chkid].focus();
		return false;
		}
		
		document.feestermform.feestermname[chkid].disabled=true;
		validflag  =true;
	}
	else
	{
		document.feestermform.feestermname[chkid].disabled=false;
		validflag  =false;
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

    <h2><%=bundle.getString("label.feesterm.rootpath")%></h2>
<form name="feestermform" action="" method="post">

<table id="rounded-corner" border=0 summary="selectd Information" align=center>
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width='10%'><%=bundle.getString("label.feesterm.SL.No")%></th>
        	<th scope="col" class="rounded" width='40%'><%=bundle.getString("label.feesterm.FeesTermName")%></th>
        	        	 <th scope="col" class="rounded"  width='10%'><%=bundle.getString("label.feesterm.Chk")%></th>
        	
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
 	<td><%=i%></td>
	 <td><input type="text" name="feestermname" size="30" maxlength="100" class="tablelight" /></td>
	 	  <td colspan=2><input type="checkbox" name="check" chkid="<%=j%>" size="5" class="tablelight" onclick="checkfun(this)"/></td>
	 
	 </tr>    
	 <%} %>
	 </tbody>
	 </table>
	 
	      <a href="./FeesTermView.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.feesterm.ViewFeesTerm")%></strong><span class="bt_blue_r"></span></a>
     <a href="#" class="bt_green" onclick="addFeesTerm()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.feesterm.Submit")%></strong><span class="bt_green_r"></span></a>
     <input type=hidden name="feestermoperation" value="insert"/>
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>