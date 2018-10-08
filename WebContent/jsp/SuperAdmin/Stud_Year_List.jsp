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
function viewboard(obj)
{
document.f1.req_sessionid.value=obj.getAttribute("yearid");
document.f1.req_sessionname.value=obj.getAttribute("yearname");
document.f1.req_sessionstatus.value=obj.getAttribute("yearstatus");
document.f1.action= "./Stud_Brd_List.jsp";
document.f1.submit();
}

function backfun()
{
document.f1.action= "./SuperAdminPage.jsp";
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
<br>

  <form name="f1" method="post" action="" >
       <%@ page import="java.util.*"%>
<%@ page import="com.iGrandee.Registration.StaffRegistrationQuery,com.iGrandee.Application.ApplicationQuery"%>
<%
	String date_str="";
	ArrayList yearList = null;
	StaffRegistrationQuery staffquery=new StaffRegistrationQuery();
	com.iGrandee.Application.ApplicationQuery  applicationQuery = new com.iGrandee.Application.ApplicationQuery();
	String userid=null;
	String instituid=null;
	userid=(String)session.getValue("userid");
	if(userid!=null)
	{
	try
	{
			String instituteid="";
			//instituid=(String)session.getValue("instituteid");
			instituid=request.getParameter("req_instituteid");
			
			//out.print(staffquery.fieldValue("institutename","institution","instituteid",instituid,"status",instituid));
			 yearList = applicationQuery.listYearwithBoard(instituid);
			//deptList =staffquery.departmentload(instituid);
	}
	catch(NullPointerException e){}
%>
    <h2><%=staffquery.fieldValue("institutename","institution","instituteid",instituid,"status",instituid)%> / <%=bundle.getString("label.superadmin.studentlistrootpath") %></h2>
<form name="f1" method="post" action="" >

<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.stafflistadmin.SL.No") %></th>
            <th scope="col" class="rounded" width="65%"><%=bundle.getString("label.common.academicyear") %></th>
            <th scope="col" class="rounded-q4" width="25%"><%=bundle.getString("label.superadmin.NoOfBoard") %></th>
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
	 		HashMap yearMap = null;
			
	 		if(yearList.size()>0){
	 		for(int i=0;i<yearList.size();i++) {
	 			yearMap = (HashMap)yearList.get(i);
	 			String yearid = (String)yearMap.get("sessionid");
	    		String yearname = (String)yearMap.get("sessionname");
	    		String boardcount = (String)yearMap.get("boardcount");
	 		   	out.println("<tr>");
	 		   	out.println("<td>"+(i+1)+"</td>");
	 		   	out.println("<td>"+yearname+"</td>");
	 		   	
	 		   	if(Integer.parseInt(boardcount) > 0)
	 		   		out.println("<td><a href='#' yearid='"+yearid+"' yearname='"+yearname+"' yearstatus='"+yearMap.get("sessionstatus")+"' onclick='viewboard(this)' >"+yearMap.get("boardcount")+"</a></td>");	 		   		
	 		   	else
	 		   		out.println("<td>"+yearMap.get("boardcount")+"</td>");
	 		   	//out.println("<td><a href='#' yearid='"+yearid+"' yearname='"+yearname+"' onclick='viewdepartment(this)' >"+yearname+"</a></td>");
	 		   	//out.println("<td>"+staffquery.departmentvisestaffcount(yearid)+"</td>");
	 		   	out.println("</tr>");

	 		}
	 		}
	 		else
	 			out.println("<tr align='center' class='tablebold'><td colspan='8'><font color='red'>Data Not Found</font></td></tr>");
		}
		catch(NullPointerException npe)
		{
			//System.out.println("IGST-ERROR : in Staff_Registration.jsp in yearMap"+npe);
			npe.printStackTrace();
			}
	}
	%>
    </tbody>
</table>
<a href="#bbsb" name="bbsb" onclick=backfun() class="bt_blue" align=center><span class="bt_blue_lft"></span><strong><%= bundle.getString("button.stafflistview.Back")%></strong><span class="bt_blue_r"></span></a>
<input type="hidden" name="req_sessionid" value=""/>
<input type="hidden" name="req_sessionname" value=""/>
<input type="hidden" name="req_sessionstatus" value=""/>

<input type="hidden" name="req_instituteid" value="<%=request.getParameter("req_instituteid")%>"/>

</form>

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>