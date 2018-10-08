<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Discount.DiscountAction" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.feesterm.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">

function updatediscount()
{
	if(validflag)
	{ 
	for(var k=0;k<document.discountform.check.length;k++)
				{
							if(document.discountform.check[k].checked)
							{
											document.discountform.editamount[k].disabled=false;
											document.discountform.discountamountid[k].disabled=false;
											
							}
							else
							{
										document.discountform.editamount[k].disabled=true;
										document.discountform.discountamountid[k].disabled=true;
							}
				} 
	if(confirm("Are you sure want to update?")){
		
		if(!document.discountform.editamount.length)
			document.discountform.editamount.disabled=false;

		
		document.discountform.action="Discountsubmit.jsp";
		document.discountform.submit();
		}
	}    

	else
	{     
	alert("select any one of the Discount Category");
	}  
}


function goback(){
	
	document.discountform.action="Discountcreation.jsp";
	document.discountform.submit();
	
}


function deleteamt(obj){
	
	if(confirm("Are you sure want to delete Discount Category Percentage?")){
		document.discountform.hiddendiscountamountid.value=obj.getAttribute("discountamountid");
		document.discountform.operation.value="delete";
		document.discountform.action="Discountsubmit.jsp";
		document.discountform.submit();
		
	}
	
}
 

var validflag  =false;
function checkfun(obj)
{
	chkid = obj.getAttribute("chkid");
	if(obj.checked)
	{
		if((document.discountform.editamount.length)){
			if(document.discountform.editamount[chkid].value == "")
			{
			alert("Amount should not be empty");
			document.discountform.editamount[chkid].focus();
			//document.discountform.check[chkid].checked=false;
			obj.checked=false;
		
			return false;
			} 
			else{
				
				validflag=true;
			}
			if(parseInt(document.discountform.editamount[chkid].value, 10)>100){
				
				alert("Amount should not exceed 100 percntage");
				obj.checked=false;
				return false;
			}
			
			else{
			}
			var amountname=	document.discountform.editamount[chkid].value;
			var amtlength=amountname.length;
			if(amountname[amtlength-1]=="."){
				
				alert("Not a Valid Percentage");
				obj.checked=false;
				return false;
			}
			
			if(amountname[0]!=""){
				if(amountname[0]=="."){
					alert("Not a Valid Percentage");
					obj.checked=false;
					return false;
			  }
			}	
			document.discountform.editamount[chkid].disabled=true;
			
	}
		else{

			var amountname=	document.discountform.editamount.value;
			var amtlength=amountname.length;
			if(amountname[amtlength-1]=="."){
				
				alert("Not a Valid Percentage");
				obj.checked=false;
				return false;
			}
			
			if(amountname[0]!=""){
				if(amountname[0]=="."){
					alert("Not a Valid Percentage");
					obj.checked=false;
					return false;
			  }
			}	
				if(document.discountform.editamount.value == "")
				{
				alert("Amount should not be empty");
				document.discountform.editamount.focus();
				//document.discountform.check[chkid].checked=false;
				obj.checked=false;
				//document.discountform.check.checked=false;
				return false;
				} 
			else{
					
					validflag=true;
				}
				
				if(parseInt(document.discountform.editamount.value, 10)>100){
					
					alert("Amount should not exceed 100 percntage");
					obj.checked=false;
					return false;
				}
				
				else{
					
					
				}
				document.discountform.editamount.disabled=true;
			
		}
		
		
	
	}
	else{
		
		
		if((document.discountform.editamount.length)){
			document.discountform.editamount[chkid].disabled=false;
			
		}
		else{
			
			document.discountform.editamount.disabled=false;
		}
		
	}
}


</script> 
</head>
<body>
<%
ArrayList Getcategorylist=null;
HashMap innermap=null;
String instituteid=null;
String createdby=(String)session.getValue("userid");
instituteid			= (String)session.getValue("instituteid");
String sessionid=null;
if(request.getParameter("yearsession")!=null){
	
	sessionid=request.getParameter("yearsession");	
}

	Getcategorylist=query_object.discountedit(sessionid);
	

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

    <h2>Discount / Discount Category / Discount Category Creation / Discount Category Edit /  Discount Category Percentage Update </h2>
    
<form name="discountform"  method="post">
<h2>Academic Year: <%= query_object.getsessioname(request.getParameter("yearsession"))%> </h2>
<table id="rounded-corner" border=0 summary="selectd Information" align=center>
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width='10%'>SL.No</th>
        	<th scope="col" class="rounded" width='30%'>Discount Category Name</th>
        	<th scope="col" class="rounded" width='30%'>Percentage</th>
        	<th scope="col" class="rounded" width='10%'>Option</th>
        	<th scope="col" class="rounded"  width='10%'>Chk</th>
        	
        	<th scope="col" class="rounded-q4" width='10%'></th>
        </tr>
    </thead>
    <tfoot>
    	<tr> 
        	<td colspan=5 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>  

 <%
 int count=0;String status=null;
 if(Getcategorylist!=null && Getcategorylist.size()!=0){
 for(int i=0;i<Getcategorylist.size();i++)
	{
	 count++;
	 innermap=(HashMap)Getcategorylist.get(i);
 %>
 	 <input type="hidden" name="discountamountid"  value="<%=innermap.get("discountamountid")%>"/>
 
  <tr>
 	<td><%=count%></td> 
	 <td><%=innermap.get("discountcategoryname") %></td> 
	 <%
	 out.println("<td><input type='text' name='editamount' value='"+innermap.get("discountpercentage")+"'  onkeypress='checkNumber(event);' maxlength='5'/></td>");
	 if(innermap.get("discountusersid")==null)
	 	out.println("<td><a href='#' discountamountid="+innermap.get("discountamountid")+" onclick='deleteamt(this)'>delete</a></td>");
	 else 
		 out.println("<td>User Allocated</td>");
	 out.println("<td><input type='checkbox' name='check' chkid="+i+" size='5' class='tablelight' onclick='checkfun(this)'/></td>");
	 
	 if(i!=Getcategorylist.size()-1)
	 out.println("<td></td>");

	 } 

 }
 else{
	 
		out.println("<tr align='center' class='tablebold'><td colspan='9'><font color='red'>Data Not Found</font></td></tr>");

 }
	%> 
	<td></td> 
	 </tr>    
	 
	 </tbody>
	 </table> 	
	
	 
	 
	      <a href="#" onclick="goback()" class="bt_blue"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
	 <%
	 if(Getcategorylist!=null && Getcategorylist.size()!=0){

	 %>     
     <a href="#" class="bt_green" onclick="updatediscount()"><span class="bt_green_lft"></span><strong>Update</strong><span class="bt_green_r"></span></a>
<%
	 }
%>
<%
if(request.getParameter("yearsession")!=null){
	out.println("<input type='hidden' name='sessionid' value='"+request.getParameter("yearsession")+"'/>");
}
if(request.getParameter("sessionname")!=null){ 
	out.println("<input type='hidden' name='sessionname' value='"+request.getParameter("sessionname")+"'/>");
}
%>


<input type="hidden" name="operation" value="updatestatus"/>
<input type="hidden" name="hiddendiscountamountid" value=""/>

</form>
     </div><!-- end of right content-->  


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>