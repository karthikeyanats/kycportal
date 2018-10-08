<jsp:useBean id="examname_query_object" scope="page"
	class="com.iGrandee.Exam.ExamnameEntry" />
<jsp:useBean id="examnameBean" scope="page"
	class="com.iGrandee.Exam.ExamnameBean" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<html>
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<head>
<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.examnamelist.title")%></title>

<LINK rel=stylesheet href="../css/kyccss.css">
<link rel="stylesheet" type="text/css" 	href="../../jsp/kycpanel/style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<script language="JavaScript">

function resetfun()
{
document.ExamnameTrashedForm.deptname.value="";
document.ExamnameTrashedForm.descryption.value="";

}

function GoExamnamview()
{
document.ExamnameTrashedForm.action= "ExamnameView.jsp";
document.ExamnameTrashedForm.submit();
}
function trashFun(obj)
{
var Deptid=obj.getAttribute("Deptid");
var departmentname=obj.getAttribute("departmentname");
var description=obj.getAttribute("description");
document.ExamnameTrashedForm.action= "DepartmentTrashPriview.jsp?Deptid="+Deptid+"&departmentname="+departmentname+"&description="+description;
document.ExamnameTrashedForm.submit();
}
function TrashListview()
{
document.ExamnameTrashedForm.action= "DepartmantTrashListview.jsp";
document.ExamnameTrashedForm.submit();
}
function deleteExamname(obj)
{
if(confirm("Do you want to Delete the Exam Name...?"))
{
	document.ExamnameTrashedForm.examnameid_hidden.value = obj.getAttribute("examnameid");
	//alert("ExamnameID>>>>>>"+document.ExamnameTrashedForm.examnameid_hidden.value);
	document.ExamnameTrashedForm.examname_hidden.value=obj.getAttribute("examname");
	document.ExamnameTrashedForm.examnameremarks_hidden.value=obj.getAttribute("examnameremarks");
	document.ExamnameTrashedForm.createdby_hidden.value=obj.getAttribute("createdby");
	//alert("CreatedBY>>>>>>"+document.ExamnameTrashedForm.createdby_hidden.value);
	document.ExamnameTrashedForm.action= "ExamnameDelete.jsp";
	document.ExamnameTrashedForm.submit();

}
else
{}
}
function restoreFun(obj)
{
if(confirm("Do you want to Restore the Exam Name?"))
{
	document.ExamnameTrashedForm.examnameid_hidden.value = obj.getAttribute("examnameid");
	//alert("ExamnameID>>>>>>"+document.ExamnameTrashedForm.examnameid_hidden.value);
	document.ExamnameTrashedForm.examname_hidden.value=obj.getAttribute("examname");
	document.ExamnameTrashedForm.examnameremarks_hidden.value=obj.getAttribute("examnameremarks");
	document.ExamnameTrashedForm.createdby_hidden.value=obj.getAttribute("createdby");
	//alert("CreatedBY>>>>>>"+document.ExamnameTrashedForm.createdby_hidden.value);
document.ExamnameTrashedForm.action= "ExamnameRestore.jsp";
document.ExamnameTrashedForm.submit();

}
else
{}
}
</script>
</head>

<body>
<form name="ExamnameTrashedForm" method="post" action="">

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
         <h2><%=bundle.getString("label.examnamelist.rootpathtrash")%></h2>
     
<%@ page import="java.io.*,java.util.*"%>

<form name="ExamnameTrashedForm" method="post" action="">

	<input type=hidden name=examnameid_hidden>
	<input type=hidden name=examname_hidden>
	<input type=hidden name=examnameremarks_hidden>
	<input type=hidden name=createdby_hidden>

<table id="rounded-corner" border=0 summary="Examname List" width="100%" align="center">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.examnamelist.SL.No")%></th>
            <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.examnamelist.examname")%></th>
            <th scope="col" class="rounded" width="35%"><%=bundle.getString("label.examnamelist.examremarks")%></th>
            <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.examnamelist.dateofcreation")%></th>
            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.examnamelist.Delete")%></th>
            <th scope="col" class="rounded-q4" width="10%"><%=bundle.getString("label.examnamelist.Restore")%></th>
            
                      
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="5" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Exam.ExamnameEntry"%>
		<%
			com.iGrandee.Exam.ExamnameEntry  examnameEntry = new com.iGrandee.Exam.ExamnameEntry();
     		String instituteid = null;
     		ArrayList ExamnameTrashedList = null;
     try
     {
    	  instituteid = (String)session.getValue("instituteid");
    	  ExamnameTrashedList=examnameEntry.get_All_ExamnameTrashList(instituteid);
    	  

    	ArrayList archivalDetails = new ArrayList();
    	 if(ExamnameTrashedList!=null && ExamnameTrashedList.size()>0)
			{
    		 for (int i = 0, j = 1; i < ExamnameTrashedList.size(); i++) {

				HashMap ExamnameTrashedListMap=(HashMap)ExamnameTrashedList.get(i);

				String examnameid       	= (String)ExamnameTrashedListMap.get("examnameid");
				String examname 		  	= (String)ExamnameTrashedListMap.get("examname");
				String examnameremarks  	= (String)ExamnameTrashedListMap.get("remarks");
				String dateofcreation      	= (String)ExamnameTrashedListMap.get("dateofcreation");
				String createdby      		= (String)ExamnameTrashedListMap.get("createdby");

				%>
				<tr>
				    	 <td><%=j++ %></td>
				            <td><%=examname %></td>
				            <td><%=examnameremarks %></td>
				            <td><%=dateofcreation %></td>
				            <td><a href="#" ahrefname="examnamehref=<%=i%>" examnameid="<%=examnameid%>" examname="<%=examname %>" examnameremarks="<%=examnameremarks %>" createdby="<%=createdby %>" onclick="deleteExamname(this)"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/user_logout.png" alt="delete" title="" border="0" /></a></td>
				            <td><a href="#" ahrefname="examnamehref=<%=i%>" examnameid="<%=examnameid%>" examname="<%=examname %>" examnameremarks="<%=examnameremarks %>" createdby="<%=createdby %>" onclick="restoreFun(this)" class="ask"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/16-undo1.png" alt="restore" title="" border="0" /></a></td>

				        </tr>
								<%
				    		 }
							}
				    	 	else{
				    	 		out.println("<tr align='center' class='tablebold'><td colspan='9'><font color='red'>Data Not Found</font></td></tr>");
				     			//out.println("<tr><td colspan=9 align=center>Data not found</td></tr>");
				    	 	}
				     }catch(Exception e){}

     %>			
			
	   </tbody>
</table>
<a href="./ExamnameEntry.jsp" class="bt_green"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.examnamelist.addnew")%></strong><span class="bt_green_r"></span></a>
     <a href="./ExamnameView.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.examnamelist.View")%></strong><span class="bt_blue_r"></span></a>
     <a href="./ExamnameDeactivatedViewList.jsp" class="bt_red"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.examnamelist.deactiveitems")%></strong><span class="bt_red_r"></span></a>
	
</div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../include/footer.jsp" %>

</div>

    </form>
	
</body>
</html>