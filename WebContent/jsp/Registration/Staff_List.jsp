<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.stafflistadmin.title") %>| Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript">
function viewdepartment(obj)
{
document.f1.departmentid.value=obj.getAttribute("depid");
document.f1.deptname.value=obj.getAttribute("deptname");
document.f1.action= "./Staff_List_View.jsp";
document.f1.submit();
}
</script>

<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/niceforms.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="<%=request.getContextPath()%>/jsp/kycpanel/niceforms-default.css" />

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

    <h2><%=bundle.getString("label.stafflistadmin.rootpath") %></h2>
  <form name="f1" method="post" action="" >
       <%@ page import="java.util.*"%>
<%@ page import="com.iGrandee.Registration.StaffRegistrationQuery"%>
<%
	String date_str="";
	ArrayList deptList = null;
	StaffRegistrationQuery staffquery=new StaffRegistrationQuery();
	String userid=null;
	String instituid=null;
	userid=(String)session.getValue("userid");
	if(userid!=null)
	{
	try
	{
			String instituteid="";
			instituid=(String)session.getValue("instituteid");
			deptList =staffquery.departmentload(instituid);
	}
	catch(NullPointerException e){}
%>
<form name="f1" method="post" action="" >

<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.stafflistadmin.SL.No") %></th>
            <th scope="col" class="rounded" width="65%"><%=bundle.getString("label.stafflistadmin.DepartmentName") %></th>
            <th scope="col" class="rounded-q4" width="25%"><%=bundle.getString("label.stafflistadmin.NoOfStaff's") %></th>
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="2" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
        	
        	<%
		try
		{
	 		HashMap deptMap = null;
	 		for(int i=0;i<deptList.size();i++) {
	 			deptMap = (HashMap)deptList.get(i);
	 			String deptid = (String)deptMap.get("departmentid");
	    		String deptname = (String)deptMap.get("departmentname");
	 		   	out.println("<tr>");
	 		   	out.println("<td>"+(i+1)+"</td>");
	 		   	out.println("<td><a href='#' depid='"+deptid+"' deptname='"+deptname+"' onclick='viewdepartment(this)' >"+deptname+"</a></td>");
	 		   	out.println("<td>"+staffquery.departmentvisestaffcount(deptid)+"</td>");
	 		   	out.println("</tr>");

	 		}
		}
		catch(NullPointerException npe)
		{
			//System.out.println("IGST-ERROR : in Staff_Registration.jsp in deptMap"+npe);
			npe.printStackTrace();
			}
	}
	%>
    </tbody>
</table>
<input type="hidden" name="departmentid" value=""/>
<input type="hidden" name="deptname" value=""/>

</form>

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>