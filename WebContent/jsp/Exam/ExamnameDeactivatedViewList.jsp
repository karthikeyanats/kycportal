<jsp:useBean id="examname_query_object" scope="page"
	class="com.iGrandee.Exam.ExamnameEntry" />
<jsp:useBean id="examnameBean" scope="page"
	class="com.iGrandee.Exam.ExamnameBean" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>

<head>
<title><%=bundle.getString("label.product.name")%> -  <%=bundle.getString("label.examnamelist.title")%></title>

<LINK rel=stylesheet href="../css/kyccss.css">
<link rel="stylesheet" type="text/css" href="../../jsp/kycpanel/style.css" />
<link rel="stylesheet" type="text/css" media="all" href="jsp/kycpanel/niceforms-default.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<script language="JavaScript">
function ActiveFun(obj)
{
if(confirm("Do you want to Activate Examname...?"))
{
	document.ExamnameDeactivatedListForm.examnameid_hidden.value = obj.getAttribute("examnameid");
	//alert("ExamnameID>>>>>>"+document.ExamnameDeactivatedListForm.examnameid_hidden.value);
	document.ExamnameDeactivatedListForm.examname_hidden.value=obj.getAttribute("examname");
	document.ExamnameDeactivatedListForm.examnameremarks_hidden.value=obj.getAttribute("examnameremarks");
	document.ExamnameDeactivatedListForm.createdby_hidden.value=obj.getAttribute("createdby");
	//alert("Created BY>>>>>>"+document.ExamnameDeactivatedListForm.createdby_hidden.value);
	document.ExamnameDeactivatedListForm.action= "ExamnameActivate.jsp";
	document.ExamnameDeactivatedListForm.submit();
}
else
{}
}
</script>
</head>
<body>
<form name="ExamnameDeactivatedListForm" method="post" action="">

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
         <h2><%=bundle.getString("label.examnamelist.rootpathdeactive")%></h2>
     
<%@ page import="java.io.*,java.util.*"%>

<form name="ExamnameDeactivatedListForm" method="post" action="">
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
            <th scope="col" class="rounded-q4" width="10%"><%=bundle.getString("label.examnamelist.Action")%></th>
          </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="4" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
	<tbody>
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Exam.ExamnameEntry"%>

     <%
     		com.iGrandee.Exam.ExamnameEntry  examnameEntry = new com.iGrandee.Exam.ExamnameEntry();
     		String instituteid = null;
     		ArrayList LoadDeactivatedExamnameList = null;
     	try
     	{
    	  instituteid = (String)session.getValue("instituteid");
    	  LoadDeactivatedExamnameList=examnameEntry.DeactivatedExamnameList(instituteid);
    	
    	//ArrayList archivalDetails = new ArrayList();
    	 if(LoadDeactivatedExamnameList!=null && LoadDeactivatedExamnameList.size()>0)
			{
    		 for (int i = 0, j = 1; i < LoadDeactivatedExamnameList.size(); i++) {
			
				HashMap DeactivatedExamnameListMap=(HashMap)LoadDeactivatedExamnameList.get(i);
				
				String examnameid       	= (String)DeactivatedExamnameListMap.get("examnameid");
				String examname 		  	= (String)DeactivatedExamnameListMap.get("examname");
				String examnameremarks  	= (String)DeactivatedExamnameListMap.get("remarks");
				String dateofcreation      	= (String)DeactivatedExamnameListMap.get("dateofcreation");
				String createdby      		= (String)DeactivatedExamnameListMap.get("createdby");
		%>
		<tr>
        	 <td><%=j++ %></td>
            <td><%=examname %></td>
            <td><%=examnameremarks %></td>
            <td><%=dateofcreation %></td>
            <td><a href="#" ahrefname="examnamehref=<%=i%>" examnameid="<%=examnameid%>" examname="<%=examname %>" examnameremarks="<%=examnameremarks %>" createdby="<%=createdby %>" onclick="ActiveFun(this)" class="ask"><%=bundle.getString("hlink.examnamelist.activate")%></a></td>
            <!--<td><a href="#" ahrefname="examnamehref=<%=i%>" examnameid="<%=examnameid%>" examname="<%=examname %>" examnameremarks="<%=examnameremarks %>" createdby="<%=createdby %>" onclick="trashFun(this)" class="ask"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/trash.png" alt="" title="" border="0" /></a></td> -->
        </tr>
			<%
    			 }
			}
    	 	else{
    	 		out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>Data Not Found</font></td></tr>");
     			//out.println("<tr><td colspan=6 align=center>Data not found</td></tr>");    	 
    	 	}
    	 }catch(Exception e){}
          
     %>
    	</tbody>
	</table>
		<a href="./ExamnameEntry.jsp" class="bt_green"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.examnamelist.addnew")%></strong><span class="bt_green_r"></span></a>
     	<a href="./ExamnameView.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.examnamelist.View")%></strong><span class="bt_blue_r"></span></a>
     	<a href="./ExamnameTrashedView.jsp" class="bt_red"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.examnamelist.trashitems")%></strong><span class="bt_red_r"></span></a>
	</div><!-- end of right content-->
  </div>   <!--end of center content -->

    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../include/footer.jsp" %>

</div>

    </form>
	
</body>
</html>