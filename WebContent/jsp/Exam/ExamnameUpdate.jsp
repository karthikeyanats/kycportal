<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=bundle.getString("label.product.name")%> - Exam Update | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="ddaccordion.js"></script>
<script type="text/javascript">
function updateExamname()
{

if(check_ForParticularElements(document.examnameuptform.examname,"text"))
	{
		if(check_StartingLetter(document.examnameuptform.examname,"Exam Name"))
   		{
if(confirm("Do you want to Update the Exam Name ...?"))
{

	document.examnameuptform.action= "ExamnameUpdateSubmit.jsp";
	document.examnameuptform.submit();
}
}
}
else{}
}

function backfun()
{
document.examnameuptform.action="ExamnameView.jsp";
document.examnameuptform.submit();

}

function checkNames(obj)
{
	var examnames=obj.getAttribute("examnames");
  	 var url = "Examinfo.jsp?action=checkDuplicate&examnames="+document.examnameuptform.examname.value;
  	 //alert("URL>>>>"+url);
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
 	
 
function parseMessages(parseXML,check_var)
{
	   var rootobj=parseXML.getElementsByTagName("exam");
		var clength=rootobj[0].childNodes.length;
		if(clength>0)
		{
		alert("Exam Name already Exist")
		reset()
		}
		else
		{
		updateExamname()
		}
	}
	function reset()
	{
	document.examnameuptform.reset();
	document.examnameuptform.examname.focus();
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

    <h2><%=bundle.getString("label.examnamelist.rootpathupdate")%></h2>
    
<form name="examnameuptform" action="" method="post">
<%
	String examnameid1=request.getParameter("examnameid_hidden");

	String examname=request.getParameter("examname_hidden");
	String examremarks=request.getParameter("examnameremarks_hidden");
	String createdby1=request.getParameter("createdby_hidden");
	
	
	
%>


<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10"></th>
        	<th scope="col" class="rounded" width="100%">Examname Updation</th>
        	<th scope="col" class="rounded-q4" width="10" ></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=2  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Exam.ExamnameEntry"%>

     <%
     
     com.iGrandee.Exam.ExamnameEntry  examNameQuery = new com.iGrandee.Exam.ExamnameEntry();
     String instituteid = null;
          
     try
     {
    	  instituteid = (String)session.getValue("instituteid");
    	  
    }catch(Exception e){}
    
    %>
    <input type=hidden name=examnameid1_hidden value=<%=examnameid1 %>>
    <input type=hidden name=createdby1_hidden value=<%=createdby1 %>>
    <tr><td><td><table id="rounded-corner1" width="100%">
    <tr ><td><%=bundle.getString("label.examnamelist.examname")%> <font color="red">*</font></td><td><input type="text" class=tablelight name="examname" size="38" value="<%=examname %>" maxlength="50"></td>
    <tr><td><%=bundle.getString("label.examnamelist.examremarks")%> </td>

    <td><textarea validate="examremarks" class=tablelight cols=50 rows=2 name="examremarks" onkeydown="textCounter_label(document.examnameuptform.examremarks,document.getElementById('labelid'),2000)" onkeyup="textCounter_label(document.examnameuptform.examremarks,document.getElementById('labelid'),2000)"><%=examremarks%></textarea>
    					&nbsp;<a> <br><br><i><font color="red"><label id="labelid" >2000</label>&nbsp;&nbsp;Characters Only</font></i>;</a>
						<label id="labelid"></label>
					</td>
	 </table></td><td></td></tr>
    </tbody>
</table>

<a href="#" class="bt_blue" onclick="backfun()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.examnamelist.back")%></strong><span class="bt_blue_r"></span></a>
     <!--  <a href="#" class="bt_green" onclick="checkNames(this)"><span class="bt_green_lft"></span><strong>Update Examname</strong><span class="bt_green_r"></span></a>-->
<a href="#" class="bt_green" onclick="updateExamname()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.examnamelist.updateexam")%></strong><span class="bt_green_r"></span></a>     
     
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>