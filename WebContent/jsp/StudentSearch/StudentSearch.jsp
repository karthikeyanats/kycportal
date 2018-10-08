<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.studentsearch.viewtitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script language='javascript'>

function submitfun()
{
	if(check_ForParticularElements(document.wprkallotment.rollnumber,"text"))
	{
			document.wprkallotment.action= "HomePage.jsp";
			document.wprkallotment.submit();
		
		
	}

		

}
function checkrollno()
{

		if(document.wprkallotment.rollnumber.value == "")
		{
			alert("Enter the Roll Number");
			return;
		}
		else{
  	   	 var url = "checkRollNo.jsp?fieldname="+document.wprkallotment.rollnumber.value;
 	   var req =initRequest();
 	   req.onreadystatechange = function()
 	   {
 		   if (req.readyState == 4)
 		   {

 			   if (req.status == 200)
 			   {

  				  parseMessages(req.responseXML,"LoadReply");

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
function parseMessages(parseXML,check_var)
{
	   var rootobj=parseXML.getElementsByTagName("complaintdetails");
		var clength=rootobj[0].childNodes.length;
		var ask=rootobj[0].childNodes.item(0).childNodes.item(0).firstChild.nodeValue;
		if(ask=="true")
		{	submitfun()
	
		}
		else
		{
				alert(" Roll No Not Found")
		
		}
	}
	
function resetfun()
{
document.wprkallotment.rollnumber.value="";

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

    <h2><%=bundle.getString("label.studentsearch.viewrootpath") %></h2>


	

	<form name='wprkallotment' method='post'>
		<table class="bodyinnercolor" border=0 bordercolor='red' align="center" width="100%" height='100%' cellspacing=0 cellpadding=0>
			<tr>
				<td  valign='left'>
					
								<table id="rounded-corner" border=0 summary="Department List" width="100%">
								    <thead>
								    	<tr>
								        	
								            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.studentsearch.searchtableheading") %></th>
								            <th scope="col" class="rounded-q4" width="2%"></th>
								        </tr>
								    </thead>
								<tfoot>
							    	<tr>
							        	<td class="rounded-foot-left"><em></em></td>
							        	<td class="rounded-foot-right">&nbsp;</td>
							       </tr>
    </tfoot>
    
     <tbody>
     <table id="rounded-corner" border=0 summary="Department List" width="100%">


    <thead>
    		<tr>
            <td scope="col" class="tablebold" width="30%"><%=bundle.getString("label.studentsearch.studentrollnumber") %> :</td>
				<td colspan='4'><input type="text" name="rollnumber"
					validate="Roll Number" class=tablelight size="50" value=""
					maxlength=25></td>
			</tr>
			
   		<tfoot>
    	<tr>
        	<td colspan="3" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
    
    
</table>
     <a href="#" onclick="resetfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.studentsearch.reset") %></strong><span class="bt_blue_r"></span></a>

     <a href="#" class="bt_green" onclick="checkrollno()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.studentsearch.search") %></strong><span class="bt_green_r"></span></a>
   		
			    </thead>
			
		</table>
     
									</table>
													
			     						
			
		
		
		
	</form>


    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>