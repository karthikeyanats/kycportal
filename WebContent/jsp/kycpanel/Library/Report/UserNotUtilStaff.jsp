<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.usernotutil.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript">
function viewdepartment(obj)
{
document.f1.departmentid.value=obj.getAttribute("depid");
document.f1.departmentname.value=obj.getAttribute("deptname");
document.f1.totalcount.value=obj.getAttribute("totalcount");
document.f1.issuedcount.value=obj.getAttribute("issuedcount");

document.f1.action= "./UserNotUtilStaffList.jsp";
document.f1.submit();
}
function Backfun()
{
document.f1.action="./UserNotUtil.jsp";
document.f1.submit();
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

    <h2><%=bundle.getString("label.usernotutil.entryrootpathother") %></h2>
  <form name="f1" method="post" action="" >
       <%@ page import="java.util.*"%>
<%@ page import="com.iGrandee.Library.Report.BookJournalReport"%>
<%
	ArrayList deptList = null;
	BookJournalReport reportquery=new BookJournalReport();
	String userid=null;
	String instituid=null;
	userid=(String)session.getValue("userid");
	if(userid!=null)
	{
	try
	{
			String instituteid="";
			instituid=(String)session.getValue("instituteid");
			deptList =reportquery.departmentload(instituid); 
	}
	catch(NullPointerException e){}  
%>
<form name="f1" method="post" action="" >

<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.usernotutil.slno") %></th>
            <th scope="col" class="rounded" width="40%"><%=bundle.getString("label.usernotutil.DepartmentName") %></th>
            <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.usernotutil.TotalStaffs") %></th>
            <th scope="col" class="rounded-q4" width="25%"><%=bundle.getString("label.usernotutil.NotUtilizedUsers") %></th>
       
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
			int TotalCount=0;
			int IssuedCount=0;
	 		HashMap deptMap = null;
	 		if(deptList!=null && deptList.size()>0)
	 		{
	 		for(int i=0;i<deptList.size();i++) {
	 			deptMap = (HashMap)deptList.get(i);
	 			String deptid = (String)deptMap.get("departmentid");
	    		String deptname = (String)deptMap.get("departmentname");
	    		String totalcount=reportquery.departmentvisestaffcount(deptid);
	    		String issuedcount=reportquery.loadNotUtilStaff(deptid);

				int usernotutil = Integer.parseInt(totalcount) - Integer.parseInt(issuedcount);
			
				issuedcount = usernotutil+"";
				
		 		TotalCount+=Integer.parseInt(totalcount);
		 		IssuedCount+=Integer.parseInt(issuedcount);

	 		   	out.println("<tr>");
	 		   	out.println("<td>"+(i+1)+"</td>");
	 		   	
				if(!issuedcount.equals("null") && !issuedcount.equals("0"))
					out.println("<td><a href='#' depid='"+deptid+"' totalcount='"+totalcount+"' issuedcount='"+issuedcount+"' deptname='"+deptname+"' onclick='viewdepartment(this)' >"+deptname+"</a></td>");
					else
					out.print("<td align=left>"+deptname+"");	 		   	
	 		   	//out.println("<td><a href='#' depid='"+deptid+"' totalcount='"+totalcount+"' issuedcount='"+issuedcount+"' deptname='"+deptname+"' onclick='viewdepartment(this)' >"+deptname+"</a></td>");
	 		  if(!totalcount.equals("null") && !totalcount.equals("0"))
	 		  {
	 		   	out.println("<td><font size='4'>"+totalcount+"</font></td>");
	 		  }
	 		  else
	 		  {
		 		   	out.println("<td>"+totalcount+"</td>");

	 		  }
	 		 if(!issuedcount.equals("null") && !issuedcount.equals("0"))
	 		 {
	 		   	out.println("<td><font size='4'>"+issuedcount+"</font></td>"); 
	 		 }
	 		 else
	 		 {
		 		   	out.println("<td>"+issuedcount+"</td>"); 

	 		 }
	 		   	out.println("</tr>"); 

	 		}
	 		out.println("<t ><td colspan='6'><hr></td></tr>");
	 		out.print("<tr><td></td><td class='tablebold' align='right'>Total : </td><td class='tablebold'><font size='4'>"+TotalCount+"</font></td><td class='tablebold'><font size='4'>"+IssuedCount+"</font></td></tr>");
	 		
		}
	 		else
	 		{
				out.println("<tr align='center' class='tablebold'><td colspan='4'><font color='red'>"+bundle.getString("label.usernotutil.datanotfound")+"</font></td></tr>");
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

<a href="#" class="bt_blue" onclick='Backfun()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.usernotutil.back")%></strong><span class="bt_blue_r"></span></a>

<input type="hidden" name="departmentid" value=""/>
<input type="hidden" name="departmentname" value=""/>
<input type="hidden" name="totalcount" value=""/>
<input type="hidden" name="issuedcount" value=""/>

</form>

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>