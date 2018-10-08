<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.curricularcategory.listtitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="ddaccordion.js"></script>
<script type="text/javascript">

function trashfun(obj)
{
	
	document.extracurricularcategoryviewform.action="./ExtraCurricularCategoryTrash.jsp?reqcurricularcategoryid="+obj.getAttribute("extracurricularcategoryid")+"&reqcurricularcategoryname="+obj.getAttribute("extcurricularcategoryname");
	document.extracurricularcategoryviewform.submit();
}

function editfun(obj)
{
	
	document.extracurricularcategoryviewform.action="./ExtraCurricularCategoryEdit.jsp?reqcurricularcategoryid="+obj.getAttribute("extracurricularcategoryid")+"&reqcurricularcategoryname="+obj.getAttribute("extcurricularcategoryname");
	document.extracurricularcategoryviewform.submit();
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

    <h2><%=bundle.getString("label.curricularcategory.listrootpath") %></h2>
    <form name="extracurricularcategoryviewform" action="" method="post">
<%@ page import="java.util.ArrayList,java.util.HashMap"%>

     <%
     
 	com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery extraCurricularQuery = new com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery();
     ArrayList extracurricularcategoryList = null;
     String instituteid = null;
     
     try
     {
    	 instituteid = (String)session.getValue("instituteid");
    	  extracurricularcategoryList = extraCurricularQuery.listExtraCurricularCategoryList(instituteid,"A");
     
    }catch(Exception e){}
    
    %>
 
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.curricularcategory.SL.No") %></th>
            <th scope="col" class="rounded" width="35%"><%=bundle.getString("label.curricularcategory.CategoryName") %></th>
            <th scope="col" class="rounded" width="15%"><%=bundle.getString("label.curricularcategory.Dateofcreation") %></th>
              <th scope="col" class="rounded" width="15%"><%=bundle.getString("label.curricularcategory.Edit") %></th>
              <th scope="col" class="rounded-q4" width="15%"><%=bundle.getString("label.curricularcategory.Trash") %></th>
          
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="4" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>

     <%
     try
     {
    	 
    	 if(extracurricularcategoryList!=null && extracurricularcategoryList.size()>0)
			{
		 	for (int i = 0, j = 1; i < extracurricularcategoryList.size(); i++) {
			
				HashMap extracurricularcategoryListMap=(HashMap)extracurricularcategoryList.get(i);
				String extracurricularcategoryid     = (String)extracurricularcategoryListMap.get("extracurricularcategoryid");
				String extcurricularcategoryname      = (String)extracurricularcategoryListMap.get("extcurricularcategoryname");
				String dateofcreation      = (String)extracurricularcategoryListMap.get("newdates");
				%>
				<tr>
				<td width="2%"><%= j++ %></td>
				<td><%=extcurricularcategoryname %></td>
				<td><%= dateofcreation %></td>
				<td><a href="#"  extracurricularcategoryid="<%=extracurricularcategoryid %>" extcurricularcategoryname="<%= extcurricularcategoryname%>" onclick="editfun(this)"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/user_edit.png" alt="" title="<%=bundle.getString("hlink.curricularcategory.Edit") %>" border="0" /></a></td>
            <td><a href="#" class="ask"  extracurricularcategoryid="<%=extracurricularcategoryid %>" extcurricularcategoryname="<%= extcurricularcategoryname%>" onclick="trashfun(this)"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/trash.png" alt="" title="<%=bundle.getString("hlink.curricularcategory.Trash") %>" border="0" /></a></td>
				
				</tr>
				<%
		 }
			}
		 	else
		 	{
		 		out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
		 	//out.println("<tr><td colspan=5 align=center>Data not found</td></tr>");
		 	}
     }catch(Exception e){e.printStackTrace();}
          
     %>
    	
    </tbody>
</table>
          <a href="./ExtraCurricularStatusList.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.curricularcategory.TrashList") %></strong><span class="bt_blue_r"></span></a>

	<a href="./ExtraCurricularCategoryEntry.jsp" class="bt_green"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.curricularcategory.Addnewitem") %></strong><span class="bt_green_r"></span></a>

  
     
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>

