<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.curricularcategory.trashlisttitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="ddaccordion.js"></script>
<script type="text/javascript">

function gotoAction(obj)
{
var status=obj.getAttribute("reqstatus");
var statusword="";
//alert("status>>"+status);
if(status=="A")
{
		statusword="Restore Extracurricular...?";
}
else if(status=="D")
{
		statusword="Delete Extracurricular...?";
}

if(confirm("Do You Want to "+statusword))
{
	document.curricularcategorylistform.reqcurricularcategoryid.value = obj.getAttribute("extracurricularcategoryid");
	document.curricularcategorylistform.requeststatus.value = obj.getAttribute("reqstatus");

	document.curricularcategorylistform.action="./UpdateCurricularCategory.jsp";
	document.curricularcategorylistform.submit();
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
    
    <h2><%=bundle.getString("label.curricularcategory.trashlistrootpath") %></h2>
    <form name="curricularcategorylistform" action="" method="post">
<%@ page import="java.util.ArrayList,java.util.HashMap"%>

     <%
     
  	com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery extraCurricularQuery = new com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery();
     String instituteid = null;
%>

<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="7%"><%=bundle.getString("label.curricularcategory.SL.No") %></th>
            <th scope="col" class="rounded" width="35%"><%=bundle.getString("label.curricularcategory.CategoryName") %></th>
            <th scope="col" class="rounded" width="15%"><%=bundle.getString("label.curricularcategory.Dateofcreation") %></th>
            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.curricularcategory.Restore") %></th>
            <th scope="col" class="rounded-q4" width="10%"><%=bundle.getString("label.curricularcategory.Delete") %></th>
            
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
     
     ArrayList extracurricularCategoryList = null;
     String extracurricularcategoryid ="";
     try
     {
    	 
    	  instituteid = (String)session.getValue("instituteid");
    	  
    	  	extracurricularCategoryList = extraCurricularQuery.listExtraCurricularCategoryList(instituteid,"T");
    	
    	  	
    	//standardid, standardname, boardid, boardname, mediumname, mediumid
    	 if(extracurricularCategoryList!=null && extracurricularCategoryList.size()>0)
			{
    		 for (int i = 0, j = 1; i < extracurricularCategoryList.size(); i++) {
			
				HashMap extracurricularCategoryListMap=(HashMap)extracurricularCategoryList.get(i);

				extracurricularcategoryid       = (String)extracurricularCategoryListMap.get("extracurricularcategoryid");
				String extcurricularcategoryname      = (String)extracurricularCategoryListMap.get("extcurricularcategoryname");
			
				String stdcreateddate      = (String)extracurricularCategoryListMap.get("newdates");
				
				%>
				
				<tr>
        	 <td><%=j++ %></td>
            <td><%=extcurricularcategoryname %></td>
            <td><%=stdcreateddate %> </td>
            <td ><a href="#" extracurricularcategoryid="<%=extracurricularcategoryid %>" reqstatus="A" onclick="gotoAction(this)"> <img src="<%=request.getContextPath()%>/jsp/kycpanel/images/16-undo1.png" alt="restore" title="Restore" border="0" /></a></td> &nbsp;&nbsp;<td><a href="#"  extracurricularcategoryid="<%=extracurricularcategoryid %>" reqstatus="X" onclick="gotoAction(this)"> <img src="<%=request.getContextPath()%>/jsp/kycpanel/images/user_logout.png" alt="delete" title="Delete" border="0" /></a></td>
        </tr>
				<%
    		 }
			}
    	 	else{
    	 		out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
    	 			//out.println("<tr><td colspan=5 align=center>Data not found</td></tr>");	
    	    	 
    	 	}
     }catch(Exception e){e.printStackTrace();}
          
     %>
    	
    </tbody>
</table>

    <a href="./ExtraCurricularCategoryView.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.curricularcategory.BacktoCategoryList") %></strong><span class="bt_blue_r"></span></a>
     
    <input type="hidden" name="curricularoperation" value="UpdateCategoryStatus"/>
    <input type="hidden" name="reqcurricularcategoryid" value="<%=extracurricularcategoryid %>"/>
        <input type="hidden" name="requeststatus"/>
    
     
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>

