<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.curricularcategory.trashpreviewtitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="ddaccordion.js"></script>
<script type="text/javascript">


function trashFun()
{
if(confirm("Do you want to trash the Details"))
{
	document.curriculartrashform.action="./UpdateCurricularCategory.jsp";
	document.curriculartrashform.submit();
	}
	else
	{}
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

    <h2><%=bundle.getString("label.curricularcategory.trashpreviewrootpath") %></h2>
    <form name="curriculartrashform" action="" method="post">
<%@ page import="java.util.ArrayList,java.util.HashMap"%>

     <%
     
     com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery extraCurricularQuery = new com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery();

   
     String reqcurricularcategoryname = null;
     String reqstandardname = null;
     String reqcurricularcategoryid = null;
     ArrayList curricularFlagList = null;
     String instituteid = null;
     
     try
     {
    	instituteid = (String)session.getValue("instituteid");
    	reqcurricularcategoryid = request.getParameter("reqcurricularcategoryid");
    	reqcurricularcategoryname = request.getParameter("reqcurricularcategoryname");
    	
  		
   		curricularFlagList = extraCurricularQuery.trackCurricularCategory(reqcurricularcategoryid);
   		
    }catch(Exception e){}
    
    %>
    
    <table id="rounded-corner" border=0 summary="Selected List" width="100%">
    <thead>
    	<tr>
    	<th scope="col" class="rounded-company" width="5"></th>
        	<th scope="col" class="rounded"><%=bundle.getString("label.curricularcategory.SelectedInformation") %></th>
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
    <table id="" border="0" cellpadding=5 width="100%">
	<tr>
	<td class=tablebold><%=bundle.getString("label.curricularcategory.CategoryName") %></td><td><%= reqcurricularcategoryname %></td>
	
	</table>
	</td>
	<td></td>
	</tr>
	</tbody>
	</table>
	
    
    <br>
    
 

<%
	if(curricularFlagList != null && curricularFlagList.size() > 0)
	{
		%>
		<div class="warning_box">
			<%=bundle.getString("label.curricularcategory.trashpreviemessage") %> 
    	</div>
		<%
	}
%>
  
           <a href="./ExtraCurricularCategoryView.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.curricularcategory.BacktoCategoryList") %></strong><span class="bt_blue_r"></span></a>
 

<%if(curricularFlagList == null || curricularFlagList.size() == 0)
{ %>
	<a href="#" onclick="trashFun()" class="bt_green"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.curricularcategory.Trash") %></strong><span class="bt_green_r"></span></a>
	<%} %>
     
     
    <input type="hidden" name="reqcurricularcategoryid" value="<%=reqcurricularcategoryid %>"/>

     <input type="hidden" name="requeststatus" value="T"/>
     <input type="hidden" name="curricularoperation" value="UpdateCategoryStatus"/>
     
     
     
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>

