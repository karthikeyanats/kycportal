<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.examnamelist.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script language='javascript'>

	function changeSession(){
		
		if(check_ForParticularElements(document.examnameform.session,"select")){
			document.examnameform.submit();
		}
	}
	
	function textCounter(field,cntfield,maxlimit)
{
  if (field.value.length > maxlimit) // if too long...trim it!
    {
       alert("Maximum "+maxlimit+" Characters only Allowed");
       field.value = field.value.substring(0, maxlimit);
    }
  else
    {
       cntfield.value = maxlimit - field.value.length;
    }
}
	function insertexamname(){
		
		if(check_ForParticularElements(document.examnameform.examname,"text")){
			
			//document.examnameform.sessionname.value	= document.examnameform.session.options[document.examnameform.session.options.selectedIndex].text;
			//if(confirm("Do you want to enter the Exam Name?"))
			{
			document.examnameform.action = "ExamnameSubmit.jsp";
			document.examnameform.submit();
			}
		}
	}	
	
function ViewExamname(){
document.examnameform.action="ExamnameView.jsp";
document.examnameform.submit();

}
function checkNames(obj)
{
	var examnames=obj.getAttribute("examnames");
  	 var url = "Examinfo.jsp?action=checkDuplicate&examnames="+document.examnameform.examname.value;
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
		insertexamname()
		}
	}
	function reset()
	{
	document.examnameform.reset();
	document.examnameform.examname.focus();
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
    <h2><%=bundle.getString("label.examnamelist.rootpath")%></h2>
    <form name='examnameform' method='post'>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.Exam.ExamnameEntry"%>
	
<%
	
	
	HashMap	hashmap			= null;
	
	//String sessionid		= request.getParameter("session");
	String sessionid		= (String)session.getValue("sessionid");
	String examname			= request.getParameter("examname_hidden");
	String instituteid		= (String)session.getValue("instituteid");
	ExamnameEntry exnameentry 	= new ExamnameEntry();
	ArrayList academicList	= exnameentry.loadAcademicYear(instituteid);
		
	
%>

<table id="rounded-corner" border=0 summary="Exam name List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="80%">Exam Name Entry</th>
        	<th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font> <%=bundle.getString("label.examnamelist.mandatory")%></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>

    		<tbody>
    		<tr><td colspan=2><table id="rounded-corner1" width="100%">
    		<tr height='23'>
    			<td  class='tablebold' width='20%'><%=bundle.getString("label.examnamelist.academic")%></td>
				<td class=tablebold width="2%">:</td>
				<td  class='tablelight' ><%=session.getValue("sessionname") %>

				</td>
			</tr>
			<tr ><td class="tablebold"><%=bundle.getString("label.examnamelist.title")%> <font color="red">*</font></td>
			<td class=tablebold width="2%">:</td>
			<td><input type="text" class=tablelight validate="Exam Name" name="examname" size="38"  maxlength="50"></td>
    		<tr valign="top"><td class="tablebold" ><%=bundle.getString("label.examnamelist.remarks")%> </td>
    		<td class=tablebold width="2%">:</td>
    			<td><textarea validate="Remarks" class=tablelight cols=50 rows=2 name="examremarks" onkeydown="textCounter_label(document.examnameform.examremarks,document.getElementById('labelid'),2000)" onkeyup="textCounter_label(document.examnameform.examremarks,document.getElementById('labelid'),2000)"></textarea>
    					&nbsp;<a> <br><br><i><font color="red"><label id="labelid" >2000</label>&nbsp;&nbsp;Characters Only</font></i>;</a>
						<label id="labelid"></label>
					</td>
	 </table></td></tr>
											  </tbody>
											  </table>
   		
							<a href="#" class="bt_blue" onclick='ViewExamname()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.examnamelist.View")%> </strong><span class="bt_blue_r"></span></a>
							<!--  <a href="#" class="bt_green" onclick='checkNames(this)'><span class="bt_green_lft"></span><strong>Submit</strong><span class="bt_green_r"></span></a>-->
							<a href="#" class="bt_green" onclick='insertexamname()'><span class="bt_green_lft"></span><strong><%=bundle.getString("button.examnamelist.Submit")%></strong><span class="bt_green_r"></span></a>
				
		<input type='hidden' name='sessionname' 	value='<%=session.getValue("sessionname") %>'>
		
		
		
	</form>


    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>