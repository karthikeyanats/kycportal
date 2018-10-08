<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.scalecreation.creationtitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>



<script type="text/javascript">
function addScale()
{

	if(check_ForParticularElements(document.scaleform.scalename,"text",document.scaleform.standardboard,"select"))
	{
		var scaleName = RTrim(document.scaleform.scalename.value);
		scaleName = LTrim(scaleName);
		document.scaleform.scalename.value = scaleName;
		document.scaleform.action="ScaleSubmit.jsp";
		document.scaleform.submit();
	}
	
}
function checkNames()
{
  	   var url = "checkDuplicate.jsp?flage=scaleentry&fieldname1="+document.scaleform.scalename.value+"&standardboard_temp="+document.scaleform.standardboard_temp.value;
 	  
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
		var exist=rootobj[0].childNodes.item(0).childNodes.item(0).firstChild.nodeValue;
		if(exist=="true")
		{
		alert("Scale Name already Exist")
		}
		else
		{
		addScale()
		}
	}
	function boardchange()
	{
			document.scaleform.standardboard_temp.value = document.scaleform.standardboard.options[document.scaleform.standardboard.options.selectedIndex].value;
	
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

    <h2><%=bundle.getString("label.scalecreation.creationrootpath") %> </h2>
<form name="scaleform" action="" method="post">
<input type="hidden" name="standardboard_temp" value="">
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        
        	<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.scalecreation.creationtitle") %></th>
        	<th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font> <%=bundle.getString("label.scalecreation.mandatoryfields") %></th>
            
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
    	<tr><td class=tablebold><%=bundle.getString("label.scalecreation.StandardName") %> <font color="red">*</font></td><td class=tablebold>:</td><td><input type="text" class=tablelight name="scalename" size="50" validate="Scale Name" maxlength="44"></td></tr>

        <tr><td class=tablebold><%=bundle.getString("label.scalecreation.Board-Medium") %><font color="red">*</font></td><td class=tablebold>:</td><td><select name="standardboard" class=tablelight validate="Board - Medium" onchange="boardchange()"> <option>-Select Board-Medium- </option>
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
    </table></td></tr>
    </tbody>
</table>

     <a href="./ScaleList.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.scalecreation.ViewallStandards") %> </strong><span class="bt_blue_r"></span></a>
     <a href="#" class="bt_green" onclick="checkNames()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.scalecreation.Submit") %></strong><span class="bt_green_r"></span></a>
     
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>