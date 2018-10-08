<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child -<%=bundle.getString("label.stafftrashlist.title") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript">
function backfun()
{
document.f1.action= "./Staff_List_View.jsp";
document.f1.submit();
}
function updatestaffstatus(obj)
{
Status=obj.getAttribute("status");
var fieldname="";
if(Status=="A")
{
fieldname="Restore"
}
else if(Status=="X")
{
fieldname="Delete"
}
if(confirm("Do you want to "+fieldname+" the Staff...? "))
{
document.f1.Staffid.value=obj.getAttribute("Staffid");
document.f1.roleid.value=obj.getAttribute("roleid");
document.f1.status.value=obj.getAttribute("status");
document.f1.action= "./StaffupdateSubmit.jsp";
document.f1.submit();
}
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

    <h2><%=bundle.getString("label.stafftrashlist.rootpath") %></h2>
  <form name="f1" method="post" action="" >
       <%@ page import="java.util.*"%>
<%@ page import="com.iGrandee.Registration.StaffRegistrationQuery"%>
<%
	String date_str="";
	ArrayList deptList = null;
	StaffRegistrationQuery staffquery=new StaffRegistrationQuery();
	String userid=null;
	String instituid=null;
	String departid=null;

	userid=(String)session.getValue("userid");
	
	if(userid!=null)
	{
	try
	{
			String instituteid="";
			instituid=(String)session.getValue("instituteid");
			departid=request.getParameter("departmentid");
			deptList =staffquery.departmentvisestafftrashlist(departid);
	}
	catch(NullPointerException e){}
%>
<form name="f1" method="post" action="" >
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.stafftrashlist.SL.No") %></th>
            <th scope="col" class="rounded" width="55%"><%=bundle.getString("label.stafftrashlist.StaffName") %></th>
            <th scope="col" class="rounded" width="10%"><%=bundle.getString("hlink.stafftrashlist.Restore") %></th>
            <th scope="col" class="rounded-q4" width="10%"><%=bundle.getString("hlink.stafftrashlist.Delete") %></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="3" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
        	
        	<%
		try
		{
			if(deptList.size()!=0)
			{
	 		HashMap deptMap = null;
	 		for(int i=0;i<deptList.size();i++) {
	 			deptMap = (HashMap)deptList.get(i);
	 			String Staffid = (String)deptMap.get("staffid");
	 			String Staffname = (String)deptMap.get("uname");
	    		String Staffstatus = (String)deptMap.get("staffstatus");
	    		String roleid = (String)deptMap.get("roleid");
	 		   	out.println("<tr>");
	 		   	out.println("<td>"+(i+1)+"</td>");
	 		   	out.println("<td>"+Staffname+"</td>");
	 		  	out.println("<td><a href='#' onclick='updatestaffstatus(this)' roleid='"+roleid+"' Staffid='"+Staffid+"' status='A'><img src='"+request.getContextPath()+"/jsp/kycpanel/images/16-undo1.png' alt='restore' title='Restore' border='0' /></a></td>");
	 		  	out.println("<td><a href='#' onclick='updatestaffstatus(this)' roleid='"+roleid+"' Staffid='"+Staffid+"' status='X'><img src='"+request.getContextPath()+"/jsp/kycpanel/images/user_logout.png' alt='delete' title='Delete' border='0' /></a></td>");
	 		   	out.println("</tr>");

	 		}
			}
			else
			{
				out.println("<tr align='center' class='tablebold'><td colspan='4'><font color='red'>Data Not Found</font></td></tr>");
				//out.println("<tr>");
	 		   	//out.println("<td colspan=3 align='center'>Data Not Found</td>");
				//out.println("</tr>");
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
<a href="#na2" name="na2" class="bt_blue" onclick="backfun()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.stafftrashlist.Back") %></strong><span class="bt_blue_r"></span></a>

<input type="hidden" name="Staffid" value=""/>
<input type="hidden" name="roleid" value=""/>
<input type="hidden" name="status" value=""/>
<input type="hidden" name="departmentid" value="<%=departid%>"/>
<input type="hidden" name="deptname" value="<%=request.getParameter("deptname")%>"/>

</form>

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>