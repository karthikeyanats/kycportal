<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.standard.creationtitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>



<script type="text/javascript">
function addStandard()
{
	if(document.standardform.standardname.value == "")
	{
	alert("Standard Name should not be empty");
	document.standardform.standardname.focus();
	return false;
	}
	if(check_ForParticularElements(document.standardform.standardboard,"select"))
	{
		inc++;
		document.standardform.action="StandardSubmit.jsp";
		document.standardform.submit();
	}
	
}
var inc =0;
function checkNames()
{
	if(inc >0)
		{
		alert("please wait....")
		return false;
		
		}
  	   var url = "checkDuplicate.jsp?flage=standardentry&fieldname1="+document.standardform.standardname.value+"&standardboard_temp="+document.standardform.standardboard_temp.value;
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
	   var rootobj=parseXML.getElementsByTagName("complaintdetails");
		var clength=rootobj[0].childNodes.length;
		var ask=rootobj[0].childNodes.item(0).childNodes.item(0).firstChild.nodeValue;
		if(ask=="true")
		{
		alert("Standard Name already Exist")
		}
		else
		{
		addStandard()
		}
	}
	function boardchange()
	{
			document.standardform.standardboard_temp.value = document.standardform.standardboard.options[document.standardform.standardboard.options.selectedIndex].value;
	
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

    <h2><%=bundle.getString("label.standard.creationrootpath") %> </h2>
<form name="standardform" action="" method="post">
<input type="hidden" name="standardboard_temp" value="">
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        
        	<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.standard.creationtitle") %></th>
        	<th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font> <%=bundle.getString("label.standard.mandatoryfields") %></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Standard.StandardQuery"%>

     <%
     
     com.iGrandee.MasterEntries.Standard.StandardQuery  standardQuery = new com.iGrandee.MasterEntries.Standard.StandardQuery();
     String instituteid = null;
     ArrayList BoardList = null;
     
     try
     {
    	  instituteid = (String)session.getValue("instituteid");
    	  BoardList = standardQuery.listBoard(instituteid);
    }catch(Exception e){}
    
    %>
    <tr>
    
    <td colspan=2>
    <table id="rounded-corner1" width="100%">
    	<tr><td class=tablebold><%=bundle.getString("label.standard.StandardName") %> <font color="red">*</font></td><td class=tablebold>:</td><td><input type="text" class=tablelight name="standardname" size="50" maxlength="45"></td></tr>
    	<tr><td class=tablebold><%=bundle.getString("label.standard.StandardDescription") %> </td><td class=tablebold>:</td>
  			<td>
  <textarea validate="Description" cols=50 rows=2 name="standarddescription" onkeydown="textCounter_label(document.standardform.standarddescription,document.getElementById('labelid'),2000)" onkeyup="textCounter(document.standardform.standarddescription,document.getElementById('labelid'),2000)"></textarea>&nbsp; <br><br><i><font color="red"><label id="labelid" ><%=bundle.getString("label.standard.charactercount") %></label>&nbsp;&nbsp;<%=bundle.getString("label.standard.charactersleft") %></font></i>
	<label id="labelid"></label></td></tr>
        <tr><td class=tablebold><%=bundle.getString("label.standard.Board") %><font color="red">*</font></td><td class=tablebold>:</td><td><select name="standardboard" class=tablelight onchange="boardchange()"> <option>-Select Board-Medium- </option>
        <%
   			
        	if(BoardList!=null && BoardList.size()>0)
			{
   		 	for (int i = 0, j = 1; i < BoardList.size(); i++) {
			
				HashMap boardListMap=(HashMap)BoardList.get(i);
				String boardid     = (String)boardListMap.get("boardid");
				String boardname      = (String)boardListMap.get("boardname");
				String mediumid      = (String)boardListMap.get("mediumid");
				String mediumname      = (String)boardListMap.get("mediumname");
       		 out.println("<option value='"+boardid+"' class=tablelight >"+boardname+"-"+mediumname+"</option>");
   		 }
			}
   		 %>
        </select></td></tr>
        <tr>
        	<td class=tablebold><%=bundle.getString("label.standard.GroupStatus") %></td><td class=tablebold>:</td><td><input type=radio class=tablelight value="Yes" name="groupstatus"><a class=tablebold><%=bundle.getString("label.standard.Yes") %> </a><input type=radio class=tablelight value="No" name="groupstatus" checked > <a class=tablebold><%=bundle.getString("label.standard.No") %></a></td>
        	</tr>
    </table></td></tr>
    </tbody>
</table>

     <a href="./StandardList.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.standard.ViewallStandards") %> </strong><span class="bt_blue_r"></span></a>
     <a href="#" class="bt_green" id="submitbut" onclick="checkNames()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.standard.Submit") %></strong><span class="bt_green_r"></span></a>
     
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>