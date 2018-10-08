<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.stafflistview.title") %>| Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript">
function viewdepartment(obj)
{
	if(confirm("Do You Want to Edit the Staff...?" ))
	{
		document.f1.Staffid.value=obj.getAttribute("Staffid");
		document.f1.action= "./StaffProviewView.jsp";
		document.f1.submit();
	}
}
function backfun()
{
document.f1.action= "./Staff_List.jsp";
document.f1.submit();
}
function viewtrashlist(obj)
{
document.f1.action= "./Staffviewtrashlist.jsp";
document.f1.submit();
}
function viewDeactivelist(obj)
{
document.f1.action= "./Staff_Deactive_List_View.jsp";
document.f1.submit();
}
function updatestaffstatus(obj)
{
Status=obj.getAttribute("status");
var fieldname="";
if(Status=="D")
{
fieldname="Deactivate"
}
else if(Status=="A")
{
fieldname="Activate"
}
else if(Status=="T")
{
fieldname="Trash"
}

var design=obj.getAttribute("rolename");

if(document.f1.deptname.value.toLowerCase()=="administration")
{
	if(design.toLowerCase()=="administrator")
	{
		alert("You can't " +fieldname+" Administrator");
		return false;
	}
}

if(confirm("Do You Want to "+fieldname+" the Staff...?" ))
{
document.f1.Staffid.value=obj.getAttribute("Staffid");
document.f1.roleid.value=obj.getAttribute("roleid");
document.f1.status.value=obj.getAttribute("status");
document.f1.Staffname.value=obj.getAttribute("Staffname");
//document.f1.action= "./StaffupdateSubmit.jsp";
document.f1.action= "./staffdetailview.jsp";
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

    <h2><%=bundle.getString("label.stafflistview.viewrootpath") %> / <%=request.getParameter("deptname")%> </h2>
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
	String username = null;

	userid=(String)session.getValue("userid");
	
	if(userid!=null)
	{
	try
	{
			String instituteid="";
			instituid=(String)session.getValue("instituteid");
			departid=request.getParameter("departmentid");
			deptList =staffquery.departmentvisestaff(departid);
	}
	catch(NullPointerException e){}
%>
<form name="f1" method="post" action="" >
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.stafflistview.SL.No") %></th>
            <th scope="col" class="rounded" width="30%"><%=bundle.getString("label.stafflistview.StaffName") %></th>
            <th scope="col" class="rounded" width="15%">User Name</th>
            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.stafflistview.Designation") %></th>
            <th scope="col" class="rounded" width="15%"><%=bundle.getString("label.stafflistview.JobCategory") %></th>
            <th scope="col" class="rounded-q4" width="35%"><%=bundle.getString("label.stafflistview.Action") %></th>
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
			if(deptList.size()!=0)
			{
	 		HashMap deptMap = null;
	 		
	 		for(int i=0;i<deptList.size();i++) {
	 			deptMap = (HashMap)deptList.get(i);
	 			String Staffid = (String)deptMap.get("staffid");
	 			String Staffname = (String)deptMap.get("uname");
	    		String Staffstatus = (String)deptMap.get("staffstatus");
	    		String qualification = deptMap.get("qualification")+"";
					if(qualification.equals("null"))
						qualification="-";
					
		    	String rolename = (String)deptMap.get("rolename")+"";
	    		String roleid = (String)deptMap.get("roleid");
		    	String categoryname = (String)deptMap.get("categoryname")+"";
		    	username = (String)deptMap.get("username");
 		
	 		   	out.println("<tr>");
	 		   	out.println("<td align=left>"+(i+1)+"</td>");
	 		   	out.println("<td><a href='#' Staffid='"+Staffid+"' onclick='viewdepartment(this)' >"+Staffname+"</a>,&nbsp;"+qualification+" </td>");
	 		   out.println("<td>"+username+"</td>");
	 		   	out.println("<td>"+rolename+"</td>");
	 		   	
	 		   	out.println("<td>"+categoryname+"</td>");

	 			out.println("<td><a href='#' onclick='updatestaffstatus(this)' roleid='"+roleid+"' Staffid='"+Staffid+"' Staffname='"+Staffname+"'    rolename='"+rolename+"'   status='D'>"+bundle.getString("hlink.stafflistview.Deactive")+"</a>&nbsp;|&nbsp;<a href='#' Staffid='"+Staffid+"' onclick='viewdepartment(this)' ><img src='"+request.getContextPath()+"/jsp/kycpanel/images/user_edit.png' alt='EDIT' title='EDIT' border=0 /></a>&nbsp;|&nbsp;<a href='#' onclick='updatestaffstatus(this)' roleid='"+roleid+"' Staffid='"+Staffid+"' Staffname='"+Staffname+"' status='T'   rolename='"+rolename+"' ><img src='"+request.getContextPath()+"/jsp/kycpanel/images/trash.png' alt='Trash' title='Trash' border=0 /></a></td>");
	 		   	out.println("</tr>");  

	 		}
			}
			else
			{
				out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
				//out.println("<tr>");
	 		   	//out.println("<td colspan=5 align='center'>Data Not Found</td>");
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
	 <a href="#bbsb" name="bbsb" onclick=backfun() class="bt_blue" align=center><span class="bt_blue_lft"></span><strong><%= bundle.getString("button.stafflistview.Back")%></strong><span class="bt_blue_r"></span></a>

	 <a href="#bbb" name="bbb" onclick='viewtrashlist(this)' class="bt_red" align=center><span class="bt_red_lft"></span><strong><%= bundle.getString("button.stafflistview.TrashList")%></strong><span class="bt_red_r"></span></a>
	 <a href="#bbb" name="bbb" onclick='viewDeactivelist(this)' class="bt_green" align=center><span class="bt_green_lft"></span><strong><%= bundle.getString("button.stafflistview.DeactivateList")%></strong><span class="bt_green_r"></span></a>
	 
<input type="hidden" name="Staffid" value=""/>
<input type="hidden" name="roleid" value=""/>
<input type="hidden" name="status" value=""/>
<input type="hidden" name="Staffname" value=""/>

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