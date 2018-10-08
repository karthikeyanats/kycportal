<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Card Issue | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript">

function backfun()
{
document.f1.action= "./CardIssueStaff.jsp";
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
<%
String departmentname="";
departmentname=request.getParameter("departmentname");
%>
    <h2><%=bundle.getString("label.cardissue.entryrootpathother") %> / <%=departmentname %> </h2>
  <form name="f1" method="post" action="" >
       <%@ page import="java.util.*"%>
<%@ page import="com.iGrandee.Library.Report.BookJournalReport"%>
<%
	String date_str="";
	ArrayList deptList = null;
	BookJournalReport reportquery=new BookJournalReport();
	String userid=null;
	String instituid=null;
	String departid=null;
	String totalcount=null;
	String issuedcount=null;
	totalcount=request.getParameter("totalcount");
	issuedcount=request.getParameter("issuedcount");

	
	String instituteid="";
	instituid=(String)session.getValue("instituteid");
	departid=request.getParameter("departmentid");
	deptList =reportquery.departmentvisestaff(departid);
	
%>
<form name="f1" method="post" action="" >
<table id="rounded-corner" border=0 
							width="100%">
							<thead>
								<tr>
									<th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.cardissue.selectedinfo")%></th>
									<th scope="col" class="rounded-q4" width="1%"></th>
								</tr>
							</thead>
							 <tfoot>
    			<tr>
        			<td  class="rounded-foot-left"><em></em></td>
        			<td class="rounded-foot-right">&nbsp;</td>
       			</tr>
    			</tfoot>
    			<tbody>
    			<tr>
    			
    			<td colspan=2>
    			<table border=0 cellpadding=0 width="100%">
    			<tr>
    				<td class=tablebold >
    				<%=bundle.getString("label.cardissue.DepartmentName")%>
    				</td>
    			
	    			<td class=tablebold>:</td>
	    			<td class='tablelight'>
	    			<%=departmentname%>
	    			</td>
	    			
    				<td  class=tablebold align=right>
    				<%=bundle.getString("label.cardissue.TotalStaffs")%>
    				</td>	
    				
    			<td class=tablebold>:</td>
	    			<td class='tablelight'>
	    			<%=totalcount%>
	    			</td>
    			</tr>
    			<tr>
	    			
	    			<td  class=tablebold width=20%>
	    			<%=bundle.getString("label.cardissue.CardIssued")%>
	    			</td>
	    			<td class=tablebold>:</td>
	    			<td class='tablelight'>
	    			<%=issuedcount%>
	    			</td>
	    			
	    			
    			
    			</tr>
    			
    			</table>
    			</td></tr></tbody></table>
    			<br>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.cardissue.slno") %></th>
            <th scope="col" class="rounded" width="30%"><%=bundle.getString("label.cardissue.StaffName") %></th>
            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.cardissue.Designation") %></th>
            <th scope="col" class="rounded" width="15%"><%=bundle.getString("label.cardissue.issuedstatus") %></th>
            <th scope="col" class="rounded-q4" width="35%"><%=bundle.getString("label.cardissue.dateofissued") %></th>
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
	 			String agentid = (String)deptMap.get("agentid")+"";
	 			String Staffname = (String)deptMap.get("uname");
	 			String issueddate = (String)deptMap.get("issueddate");
	    		String qualification = deptMap.get("qualification")+"";
				if(qualification.equals("null"))
				qualification="-";
					
		    	String rolename = (String)deptMap.get("rolename")+"";
	    		String roleid = (String)deptMap.get("roleid");
	    		
	    		if(issueddate==null )
	    		issueddate="-";
	    		
 			if(agentid!=null &&  !agentid.equals("null") )
 			{
	 		   	out.println("<tr>");
	 		   	out.println("<td width='5%' class='tablelight'>"+(i+1)+"</td>");
	 		   	out.println("<td class='tablelight'>"+Staffname+"</a>,&nbsp;"+qualification+" </td>");
	 		   	out.println("<td class='tablelight'>"+rolename+"</td>");
	 		   	out.println("<td class='tablelight'>Issued</td>");
	 		   	out.println("<td class='tablelight'>"+issueddate+"</td>");
 			}
 			else
 			{
 			   	out.println("<tr>");
	 		   	out.println("<td class='tablelight' width='5%'><font color='red'>"+(i+1)+"</font></td>");
	 		   	out.println("<td class='tablelight'><font color='red' >"+Staffname+"</font></a><font color='red'>,</font>&nbsp;<font color='red'>"+qualification+"</font> </td>");
	 		   	out.println("<td class='tablelight'><font color='red' >"+rolename+"</font></td>");
	 		   	out.println("<td class='tablelight'><font color='red' >Not Issued</font></td>");
	 		   	out.println("<td class='tablelight'><font color='red' >"+issueddate+"</font></td>");
 			}
	 			
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
	
	%>
    </tbody>
</table>
	 <a href="#bbsb" name="bbsb" onclick=backfun() class="bt_blue" align=center><span class="bt_blue_lft"></span><strong><%= bundle.getString("button.cardissue.back")%></strong><span class="bt_blue_r"></span></a>

	 
<input type="hidden" name="Staffid" value=""/>
<input type="hidden" name="roleid" value=""/>
<input type="hidden" name="status" value=""/>
<input type="hidden" name="Staffname" value=""/>

<input type="hidden" name="departmentid" value="<%=departid%>"/>
</form>

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>