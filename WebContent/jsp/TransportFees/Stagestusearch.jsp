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

function loadStudent1()
{
if(check_ForParticularElements(document.feescollectionpreform.rollnumbertext,"text"))
	{
		document.feescollectionpreform.action="./StageFeesStudentinfo.jsp";
		document.feescollectionpreform.submit();
	}
}

function loadStudent(process)
{

if(check_ForParticularElements(document.feescollectionpreform.rollnumbertext,"text"))
	{
  	   var url = "../StudentSearch/checkRollNo.jsp?fieldname="+document.feescollectionpreform.rollnumbertext.value;
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
		if(ask=="true" && process=="collectfees")
		{	
		document.feescollectionpreform.action="./StageFeesStudentinfo.jsp";
		document.feescollectionpreform.submit();	
		}
		else if(ask=="true" && process=="paidlist")
		{	
		document.feescollectionpreform.action="./FeesPaidListStudent.jsp";
		document.feescollectionpreform.submit();	
		}
		else
		{
			alert(" Roll No Not Found")
		}
}
	
function loadPaidlist()
{
if(check_ForParticularElements(document.feescollectionpreform.rollnumbertext,"text"))
	{
		document.feescollectionpreform.action="./FeesPaidListStudent.jsp";
		document.feescollectionpreform.submit();
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

    <h2>Transport Fees /  Stage Allocation for Student</h2>
<form name="feescollectionpreform" action="" method="post">

<table id="rounded-corner" border=0  width="100%">
    <thead>
    	<tr>
    
        	<th scope="col" class="rounded-company" width="80%">Fees Collection</th>
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
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Standard.StandardQuery"%>

     <%
     
     com.iGrandee.Fees.FeesHeadQuery  feesheadQuery = new com.iGrandee.Fees.FeesHeadQuery();  
     com.iGrandee.MasterEntries.Standard.StandardQuery  standardQuery = new com.iGrandee.MasterEntries.Standard.StandardQuery();

     String instituteid = null;
     ArrayList yearofsessionList = null;
     ArrayList BoardList = null;
     
     
     try
     {
    	  instituteid = (String)session.getValue("instituteid");
    	  yearofsessionList = feesheadQuery.listYearofSession(instituteid);
    	  BoardList = standardQuery.listBoard(instituteid);
    	  //out.println("BoardList===>>>"+BoardList);
    	  //out.println("yearofsessionList===>>>"+yearofsessionList);

    }catch(Exception e){}
    
    %>
    <tr><td colspan=2><table id="rounded-corner1" width="100%">
    	<tr>
    	<td>
	    	<table border="0" cellpadding="0" cellspacing="0" width="60%" align="center">
	    	<tr><td class="tablebold" align=center>
		    	<%=bundle1.getString("label.feescollection.EnterStudentRollNumber")%>&nbsp;<font color="red">*</font>&nbsp;&nbsp;
		    	
		    	<input type=text name="rollnumbertext" validate="Roll Number" class=tablelight onkeydown="if(event.keyCode==13) return loadStudent('collectfees');"/> 
	       </td></tr></table>
	    </td>
	    </tr>
     
    </table></td></tr>
    </tbody>
</table>

     <a href="#" onclick=loadStudent('collectfees') class="bt_green"><span class="bt_green_lft"></span><strong>Stage Allocation</strong><span class="bt_green_r"></span></a>
     
     <input type=hidden name="boardid">
	<input type=hidden name="boardname">
	<input type=hidden name="yearofsessionname">
	<input type=hidden name="yearofsessionid">
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>