<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle1  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle1.getString("label.feescollection.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">
function loadStudent(process)
{

if(check_ForParticularElements(document.feescollectionpreform.rollnumbertext,"text"))
	{
  	   var url = "<%=request.getContextPath()%>/jsp/StudentSearch/checkRollNo.jsp?fieldname="+document.feescollectionpreform.rollnumbertext.value;
 	   var req =initRequest();
 	   req.onreadystatechange = function()
 	   {
 		   if (req.readyState == 4)
 		   {

 			   if (req.status == 200)
 			   {

  				  parseMessages(req.responseXML,"LoadReply",process);

 			   }
 			   else if (req.status == 204)
 			   {

 			   }
 		   }
 	   };
 	   req.open("GET", url, true);
 	   req.send(null);
 	   }	
}

function parseMessages(parseXML,check_var,process)
{
		//alert(process);
	   var rootobj=parseXML.getElementsByTagName("complaintdetails");
		var clength=rootobj[0].childNodes.length;
		var ask=rootobj[0].childNodes.item(0).childNodes.item(0).firstChild.nodeValue;
		
	/* 	if(ask=="true" && process=="collectfees") */
	if(ask=="true")
		{	
		document.feescollectionpreform.action="./Feescollectionstudentinfo.jsp";
		document.feescollectionpreform.submit();	
		}
		else
		{
			alert(" Roll No Not Found");
			document.feescollectionpreform.rollnumbertext.focus();
		}
}





function loadfeesreceipt()
{

if(check_ForParticularElements(document.feescollectionpreform.rollnumbertext,"text"))
	{
  	   var url = "<%=request.getContextPath()%>/jsp/StudentSearch/checkRollNo.jsp?fieldname="+document.feescollectionpreform.rollnumbertext.value;
 	   var req =initRequest();
 	   req.onreadystatechange = function()
 	   {
 		   if (req.readyState == 4)
 		   {

 			   if (req.status == 200)
 			   {

 				  parseMessagesfees(req.responseXML,"LoadReply");

 			   }
 			   else if (req.status == 204)
 			   {

 			   }
 		   }
 	   };
 	   req.open("GET", url, true);
 	   req.send(null);
 	   }	
}

function parseMessagesfees(parseXML,check_var)
{
		//alert(process);
	   var rootobj=parseXML.getElementsByTagName("complaintdetails");
		var clength=rootobj[0].childNodes.length;
		var ask=rootobj[0].childNodes.item(0).childNodes.item(0).firstChild.nodeValue;
		
	/* 	if(ask=="true" && process=="collectfees") */
	if(ask=="true")
		{	
		document.feescollectionpreform.action="./Feescollectionreceipt.jsp";
		document.feescollectionpreform.submit();	
		}
		else
		{
			alert(" Roll No Not Found");
			document.feescollectionpreform.rollnumbertext.focus();
		}
}
	 
	function getfeesreceipt()
	{
		document.feescollectionpreform.action="./Feescollectionreceipt.jsp";
		document.feescollectionpreform.submit();
		
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

    <h2>Transport Fees / Fees Collection / Enter Roll Number</h2>
<form name="feescollectionpreform" action="" method="post">

<table id="rounded-corner" border=0  width="100%">
    <thead>
    	<tr>
    
        	<th scope="col" class="rounded-company" width="80%">Transport Fees Collection </th>
        	<th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font> <%=bundle1.getString("label.feescollection.MandatoryFields")%></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     
    <tr><td colspan=2><table id="rounded-corner1" width="100%">
    	<tr>
    	<td>
	    	<table border="0" bordercolor="red" cellpadding="0" cellspacing="0" width="100%" align="center">
	    	<tr><td class="tablebold" colspan="3" align="center">
		    	<%=bundle1.getString("label.transportfees.enterrollnumber")%>&nbsp;<font color="red">*</font>&nbsp;&nbsp;
		    	<input type=text name="rollnumbertext" validate="Roll Number" class=tablelight onkeydown="if(event.keyCode==13) return loadStudent('collectfees');"/>
		    </td> 
	      </tr> 
	        
	       </table>
	       <a  href="#" onclick="loadfeesreceipt()" class="bt_green"><span class="bt_green_lft"></span><strong>Get Fees Receipt </strong><span class="bt_green_r"></span></a>
	       <a href="#" onclick="loadStudent()"  class="bt_blue"><span class="bt_blue_lft"></span><strong>Search</strong><span class="bt_blue_r"></span></a>
	    </td>
	    </tr>
 			      
    </table></td></tr>
    </tbody>
</table>

</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>