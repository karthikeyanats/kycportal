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


function Edit(){
	
	document.discountform.action="Discountedit.jsp";
	document.discountform.submit();
	
}

function goBack(){
	
	document.discountform.action="Discountcategory.jsp";
	document.discountform.submit();
}


function addFeesTerm()
{
	
	
	if(validflag>0)
	{ 
	for(var k=0;k<document.discountform.check.length;k++)
				{
							if(document.discountform.check[k].checked)
							{
											document.discountform.amount[k].disabled=false;
											document.discountform.discountcategoryid[k].disabled=false;
											
							}
							else
							{
										document.discountform.amount[k].disabled=true;
										document.discountform.discountcategoryid[k].disabled=true;

							
							}
				} 
	if(confirm("Are you sure want to insert?")){
		if(!document.discountform.amount.length)
			document.discountform.amount.disabled=false;

		document.discountform.action="Discountsubmit.jsp";
		document.discountform.submit();
	 }	
	}    

	else
	{     
	alert("select any one of the Discount Category");
	}  
}



var validflag  =0;
function checkfun(obj)
{

	chkid = obj.getAttribute("chkid");
	if(obj.checked)
	{
		if((document.discountform.amount.length)){
			if(isNaN(document.discountform.amount[chkid].value)){
				
				alert("Not a Valid Percentage");
				obj.checked=false;
				return false;
			}
			else{
				
				
			}
			
			if(document.discountform.amount[chkid].value == "")
			{
			alert("Amount should not be empty");
			document.discountform.amount[chkid].focus();
			//document.discountform.check[chkid].checked=false;
			obj.checked=false;
		
			return false;
			} 
			else{
				
				
			}
			if(parseFloat(document.discountform.amount[chkid].value, 10)>100){
				
				alert("Amount should not exceed 100 percntage");
				obj.checked=false;
				return false;
			}
			
			else{
				
				
			}
			
			var amountname=	document.discountform.amount[chkid].value;
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
			
			document.discountform.amount[chkid].disabled=true;
			validflag++;
	}
		else{
			validflag++;
			
			var amountname=	document.discountform.amount.value;
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
		if(isNaN(document.discountform.amount.value)){
				
				alert("Not a Valid Percentage");
				obj.checked=false;
				return false;
			}
			else{
			}
				if(document.discountform.amount.value == "")
				{
				alert("Amount should not be empty");
				document.discountform.amount.focus();
				//document.discountform.check[chkid].checked=false;
				obj.checked=false;
				//document.discountform.check.checked=false;
				return false;
				} 
			else{
					
					
				}
				
				if(parseFloat(document.discountform.amount.value, 10)>100){
					
					alert("Amount should not exceed 100 percntage");
					obj.checked=false;
					return false;
				}
				
				else{
					
					
				}
				document.discountform.amount.disabled=true;
			
		}
		
		
	
	}
	else{
		
		if((document.discountform.amount.length)){
		
			document.discountform.amount[chkid].disabled=false;
			validflag--;

		}
		else{ 
			validflag--;

			document.discountform.amount.disabled=false;
		}
		
	}


}


function valid(o,w){ 
	o.value = o.value.replace(valid.r[w],'');
	}
	valid.r={
	'special':/[\W]/g,
	'quotes':/['\''&'\"']/g,
	'numbers':/[^\d]/g
	} 

</script> 
</head>
<body>
<%
ArrayList Getcategorylist=null;
HashMap innermap=null;
String instituteid=null;String sessionstatus=null;
String createdby=(String)session.getValue("userid");
instituteid			= (String)session.getValue("instituteid");
	Getcategorylist=query_object.getCategoryname(instituteid);
	if(request.getParameter("sessionid")!=null){
		sessionstatus=query_object.getsessionstatus(request.getParameter("sessionid"));

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

    <h2>Discount / Discount Category Session Wise / Discount Category Percentage Creation / Discount Category Percentage Edit </h2>
<form name="discountform" action="" method="post">

<%
if(sessionstatus.equals("R")){
%>

<h2>Year of Session: <%=  query_object.getsessioname(request.getParameter("sessionid")) %> &nbsp; You can't insert or Edit  in an Archived Year </h2>
<table id="rounded-corner" border=0 summary="selectd Information" align=center>
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width='10%'>SL.No</th>
        	<th scope="col" class="rounded" width='30%'>Discount Category Name</th>
        	<th scope="col" class="rounded" width='40%'>Percentage</th>
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


 int count=0;String status=null;int amtcount=0;
 for(int i=0;i<Getcategorylist.size();i++)
	{
	 count++;
	 innermap=(HashMap)Getcategorylist.get(i);
 %>
  <tr>
 	<td><%=count%></td> 
	 <td><%=innermap.get("discountcategoryname") %></td> 
	 
	 <%
	 status= query_object.checkamount(innermap.get("discountcategoryid")+"", request.getParameter("sessionid"));
	 
	 if(status!=null && status!=""){
		 
		 out.println("<td>"+status+"%</td>");
		 out.println("<td>-</td>");
		// out.println("<input type='hidden' name='amount' value='"+status+"' maxlength='3'/>");

	 }
	 else{
		 out.println("<td>-</td>");
		 out.println("<td>-</td>");
		 amtcount++;
	 }
	%> 
	<td></td> 
	 </tr>    
	 <%} %>
	 </tbody>
	 </table> 
	 
	      <a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
     
<%
}
else{
%>	
<h2>Academic Year: <%=  query_object.getsessioname(request.getParameter("sessionid")) %></h2>
	<table id="rounded-corner" border=0 summary="selectd Information" align=center>
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width='10%'>SL.No</th>
        	<th scope="col" class="rounded" width='30%'>Discount Category Name</th>
        	<th scope="col" class="rounded" width='40%'>Percentage</th>
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
 int count=0;String status=null;int amtcount=0;
 for(int i=0;i<Getcategorylist.size();i++)
	{
	 count++;
	 innermap=(HashMap)Getcategorylist.get(i);
 %>
  <tr>
 	<td><%=count%></td> 
	 <td><%=innermap.get("discountcategoryname") %></td> 
	 
	 <%
	 status= query_object.checkamount(innermap.get("discountcategoryid")+"", request.getParameter("sessionid"));
	 
	 if(status!=null && status!=""){
		 
		 out.println("<td>"+status+"%</td>");
		 out.println("<td>-</td>");
		// out.println("<input type='hidden' name='amount' value='"+status+"' maxlength='3'/>");

	 }
	 else{
		 out.println("<td><input type='text' name='amount' value=''  maxlength='5'  onkeypress='checkNumber(event);' /></td>");
		 out.println("<td><input type='checkbox' name='check' chkid="+amtcount+" size='5' class='tablelight' onclick='checkfun(this)'/></td>");
		 amtcount++;
		 out.println("<input type='hidden' name='discountcategoryid'  value="+innermap.get("discountcategoryid")+">");

	 }
	%> 
	<td></td> 
	 </tr>    
	 <%} %>
	 </tbody>
	 </table> 
	
	 
	 
	      <a href="#" onclick="Edit()" class="bt_blue"><span class="bt_blue_lft"></span><strong>Edit</strong><span class="bt_blue_r"></span></a>
     <a href="#" class="bt_green" onclick="addFeesTerm()"><span class="bt_green_lft"></span><strong>Submit</strong><span class="bt_green_r"></span></a>
          <a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
     
<input type="hidden" name="operation" value="insert"/>
<input type="hidden" name="yearsession" value="<%=request.getParameter("sessionid")%> "/>
<input type="hidden" name="sessionname" value="<%=request.getParameter("sessionname")%>  "/>
	
	

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