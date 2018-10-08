<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.feesheadtrashlist.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="ddaccordion.js"></script>
<script type="text/javascript">

function loadStandard()
{
	document.standardForm.reqboardid.value = document.standardForm.standardboard.options[document.standardForm.standardboard.options.selectedIndex].value;
	document.standardForm.reqboardname.value = document.standardForm.standardboard.options[document.standardForm.standardboard.options.selectedIndex].text;
	
	document.standardForm.action="StandardList.jsp";
	document.standardForm.submit();
}
function goSubject(obj)
{

	document.standardForm.reqboardid.value = document.standardForm.standardboard.options[document.standardForm.standardboard.options.selectedIndex].value;
	document.standardForm.reqboardname.value = document.standardForm.standardboard.options[document.standardForm.standardboard.options.selectedIndex].text;
	document.standardForm.reqstandardid.value = obj.getAttribute("standardid");
	document.standardForm.reqstandardname.value = obj.getAttribute("standardname");
	document.standardForm.reqgroupstatus.value = obj.getAttribute("groupstatus");
	document.standardForm.action="../Subject/SubjectCreation.jsp";
	document.standardForm.submit();
	

}
function fessHeadEdit(obj)
{
if(confirm("Do you want to Update the Fees Head...?"))
{
var feesheadid=obj.getAttribute("feesheadid");
var feesheadname=obj.getAttribute("feesheadname");


	document.standardForm.feesheadid.value=feesheadid;
	document.standardForm.feesheadname.value=feesheadname;
document.standardForm.action="fessHeadEdit.jsp";
	document.standardForm.submit();
} 
else
{}
}
function fessHeadTrash(obj)
{

if(confirm("Do you want to Trash the Fees Head...?"))
{
var feesheadid=obj.getAttribute("feesheadid");
var feesheadname=obj.getAttribute("feesheadname");

document.standardForm.feesheadid_temp.value=feesheadid;
document.standardForm.feesheadname_temp.value=feesheadname;
document.standardForm.action="FeesAction.jsp?mode_of_operation=feesheadtrash";
document.standardForm.submit();


} 
else
{}
}
function TrashListview()
{
document.standardForm.action="feesheadTrashList.jsp";
	document.standardForm.submit();       
}
function backfun()
{
document.standardForm.action="FeesHeadView.jsp";
	document.standardForm.submit();  
}
function ActionFun(obj,action)
{                
var feesheadid=obj.getAttribute("feesheadid");
var feesheadname=obj.getAttribute("feesheadname"); 
document.standardForm.feesheadid_temp.value=feesheadid; 
if(action=="D")   
{
if(confirm("Do you Want To Delete the Fees Head...?"))
{
	document.standardForm.action="FeesAction.jsp?mode_of_operation=deleteststus";
	document.standardForm.submit(); 
}

}

if(action=="R")   
{
if(confirm("Do you Want To Restore the Fees Head...?"))
{
	document.standardForm.action="FeesAction.jsp?mode_of_operation=activeststus";
	document.standardForm.submit(); 
}
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

    <h2><%=bundle.getString("label.feesheadtrashlist.rootpath")%></h2>
    <form name="standardForm" action="" method="post">
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Standard.StandardQuery"%>

     <%
     
     com.iGrandee.Fees.FeesHeadQuery  feesheadQuery = new com.iGrandee.Fees.FeesHeadQuery();     String instituteid = null;
     ArrayList feesheadList = null;
     String reqboardid = null;
     
     try
     {
    	 instituteid = (String)session.getValue("instituteid");
    	  feesheadList = feesheadQuery.listFeesHead(instituteid,"T");
     
    }catch(Exception e){}
    
    %>
    
    


<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.feesheadtrashlist.SL.No")%></th>
            <th scope="col" class="rounded" width="42%"><%=bundle.getString("label.feesheadtrashlist.FeesHeadName")%> </th>
            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.feesheadtrashlist.Dateofcreation")%> </th>
              <th scope="col" class="rounded"  width="20%"><%=bundle.getString("label.feesheadtrashlist.Delete")%> </th>
              <th scope="col" class="rounded-q4"  width="20%"><%=bundle.getString("label.feesheadtrashlist.Restore")%> </th>
            
          
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
    	 
    	 if(feesheadList!=null && feesheadList.size()>0)
			{
		 	for (int i = 0, j = 1; i < feesheadList.size(); i++) {
			
				HashMap feesheadListMap=(HashMap)feesheadList.get(i);
				String feesheadid     = (String)feesheadListMap.get("feesheadid");
				String feesheadname      = (String)feesheadListMap.get("feesheadname");
				String dateofcreation      = (String)feesheadListMap.get("dateofcreation");
				%>
				<tr>
				<td width="2%"><%= j++ %></td>
				<td><%=feesheadname %></td>
				<td><%= dateofcreation %></td>
				<td><a href="#" feesheadid="<%=feesheadid%>" feesheadname="<%=feesheadname%>" onclick="ActionFun(this,'D')"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/user_logout.png" alt="delete" title="Delete" border="0" /></a></td>
            <td><a href="#" class="ask" feesheadid="<%=feesheadid%>" feesheadname="<%=feesheadname%>" onclick="ActionFun(this,'R')"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/16-undo1.png" alt="restore" title="Restore" border="0" /></a></td>
				
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
	<input type="hidden" name="feesheadid" value="">
		<input type="hidden" name="feesheadname" value="">
	
<input type="hidden" name="feesheadid_temp" value="">
		<input type="hidden" name="feesheadname_temp" value="">
	<a href="#" onclick="backfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.feesheadtrashlist.BackToFeesHead")%> </strong><span class="bt_blue_r"></span></a>


  
     
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>

