<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.curricularcategory.updatetitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="ddaccordion.js"></script>
<script type="text/javascript">


function updateFun()
{
	///document.extracurricularcategoryedit.reqcurricularcategoryid.value = document.extracurricularcategoryedit.standardboard.options[document.extracurricularcategoryedit.standardboard.options.selectedIndex].value;
	//document.extracurricularcategoryedit.reqboardname.value = document.extracurricularcategoryedit.standardboard.options[document.extracurricularcategoryedit.standardboard.options.selectedIndex].text;
	if(check_ForParticularElements(document.extracurricularcategoryedit.reqcurricularcategoryname,"text"))
	{
	document.extracurricularcategoryedit.action="./UpdateCurricularCategory.jsp";
	document.extracurricularcategoryedit.submit();
	}
}



function checkNames(obj)
{
var date = new Date();
  	 var url = "checkDuplicate.jsp?tabname=extracuriculaerupdateupdate&fieldname1="+document.extracurricularcategoryedit.reqcurricularcategoryname.value+"&reqcurricularcategoryid="+document.extracurricularcategoryedit.reqcurricularcategoryid.value+"&date="+date;
  	// alert(url);
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
	   var fromarray=new Array();
       var toarray=new Array();
		
			var rootObj=parseXML.getElementsByTagName("complaintdetails");
			var cNode_1=rootObj.length;
			//alert(cNode_1);   
	 		for(var i=0;i<parseInt(cNode_1);i++)
			{
				var temp=rootObj[0].childNodes.item(i).childNodes.item(0).firstChild.nodeValue;
			}
				
				//alert(temp);
				
					if(temp=="true")
						{
							alert("Category Name  already exists");
							document.extracurricularcategoryedit.reqcurricularcategoryname.focus();
							return false;
						}
					else
						{
							updateFun();
						}
				
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

    <h2><%=bundle.getString("label.curricularcategory.updaterootpath") %></h2>
    <form name="extracurricularcategoryedit" action="" method="post">
<%@ page import="java.util.ArrayList,java.util.HashMap"%>

     <%
     
     String instituteid = null;
     ArrayList BoardList = null;
     ArrayList standardList = null;
     
     String reqcurricularcategoryname = null;
     String reqcurricularcategoryid = null;
     
     try
     {
    	instituteid = (String)session.getValue("instituteid");
    	reqcurricularcategoryid = request.getParameter("reqcurricularcategoryid");
    	reqcurricularcategoryname = request.getParameter("reqcurricularcategoryname");

   		
   		
    }catch(Exception e){}
    
    %>
 
 <table id="rounded-corner" border=0 summary="Selected List" width="100%">
    <thead>
    	<tr>
    	<th scope="col" class="rounded-company" width="5"></th>
        	<th scope="col" class="rounded"><%=bundle.getString("label.curricularcategory.UpdateCategory") %></th>
        	<th scope="col" class="rounded-q4" width="5" colspan=3></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=2  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
   
  <tr><td></td>
  <td>
<table border="0" width="100%">
	<tr><td class=tablebold><%=bundle.getString("label.curricularcategory.CategoryName") %> <font color="red">*</font> </td><td><input type=text validate="Curricular Category Name" name="reqcurricularcategoryname" value="<%=reqcurricularcategoryname %>" size="27" maxlength="100"/></td>
</table>
  
  </td>
  <td></td>
 </tr>
</tbody>
</table>

          <a href="./ExtraCurricularCategoryView.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.curricularcategory.BacktoCategoryList") %> </strong><span class="bt_blue_r"></span></a>

	<!--  <a href="#" onclick="checkNames(this)" class="bt_green"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.curricularcategory.UpdateCategory") %> </strong><span class="bt_green_r"></span></a>-->
	<a href="#" onclick="updateFun()" class="bt_green"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.curricularcategory.UpdateCategory") %> </strong><span class="bt_green_r"></span></a>
     
     
     <input type="hidden" name="reqcurricularcategoryid" value="<%=reqcurricularcategoryid %>"/>
      <input type="hidden" name="curricularoperation" value="UpdateCategory"/>
     
     
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>

