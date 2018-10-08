<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.staffprofiletrashpreview.title") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jconfirmaction.jquery.js"></script>
<script type="text/javascript">
function backfun()
{
	if(document.f1.status.value=="A")
		document.f1.action= "./Staff_Deactive_List_View.jsp";
	else
		document.f1.action= "./Staff_List_View.jsp";
		document.f1.submit();
}
function updatestaffstatus()
{
var Status=document.f1.status.value;
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
if(confirm("Do you want to "+fieldname+" the staff...?"))
{
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

<%@ page import="java.util.*"%>
<%@ page import="com.iGrandee.Registration.StaffRegistrationQuery"%>
<%
	String date_str="";
	ArrayList deptList = null;
	StaffRegistrationQuery staffquery=new StaffRegistrationQuery();
	String userid=null;
	String instituid=null;
	String Staffid=null;
	String departid=null;
	String roleid=null;
	String Status=null;
	String Staffname=null;
	String fieldname="";

	userid=(String)session.getValue("userid");

	if(userid!=null)
	{
	try
	{
		departid=request.getParameter("departmentid");
		Staffid=request.getParameter("Staffid");
		roleid=request.getParameter("roleid");
		Status=request.getParameter("status");
		Staffname=request.getParameter("Staffname");

			deptList =staffquery.staffdetails(Staffid); 
			//out.println(deptList);
			String instituteid="";
			
	}//SELECT * FROM subjectallotment a,subjectschedule b,subject c,standard d,sectionschedule e,section f where a.subjectscheduleid =b.subjectscheduleid and b.subjectid =c.subjectid and c.standardid =d.standardid  and a.sectionpublishid=e.sectionscheduleid and  e.sectionid=f.sectionid and a.staffid='1';
	
	
	catch(NullPointerException e){}
	if(Status.equals("D"))
	{
	fieldname="Deactivate";
	}
	else if(Status.equals("A"))
	{
	fieldname="Activate";
	}
	else if(Status.equals("T"))
	{
	fieldname="Trash";
	}
	else if(Status.equals("X"))
	{
		fieldname="Delete";

	}
%>
<h2> <%=bundle.getString("label.staffprofiletrashpreview.rootpath") %>&nbsp;<%=fieldname %></h2>

<form name="f1" method="post" action="" >
<table width="100%">
<tr>
<td>
<%=Staffname %> <%=bundle.getString("label.staffprofiletrashpreview.message1") %>
</td>
</tr>
</table>
<br>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.staffprofiletrashpreview.SL.No") %></th>
            <th scope="col" class="rounded" width="22%"><%=bundle.getString("label.staffprofiletrashpreview.YearofSession") %></th>
            <th scope="col" class="rounded" width="22%"><%=bundle.getString("label.staffprofiletrashpreview.StandardName") %></th>
            <th scope="col" class="rounded" width="22%"><%=bundle.getString("label.staffprofiletrashpreview.SectionName") %></th>
            <th scope="col" class="rounded-q4" width="24%"><%=bundle.getString("label.staffprofiletrashpreview.SubjectName") %></th>
            
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
	 			String sessionname = (String)deptMap.get("sessionname");
	 			String sectionname = (String)deptMap.get("sectionname");
	    		String subjectname = (String)deptMap.get("subjectname");
	    		String standardname = (String)deptMap.get("standardname");
	 		   	out.println("<tr>");
	 		   	out.println("<td>"+(i+1)+"</td>");
	 		   	out.println("<td>"+sessionname+"</td>");
	 		   	out.println("<td>"+standardname+"</td>");
	 		   	out.println("<td>"+sectionname+"</td>");
	 		   	out.println("<td>"+subjectname+"</td>");
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
<br>
<%if(deptList.size()!=0)
{ %>
<div class=warning_box><%=Staffname %> <%=bundle.getString("label.staffprofiletrashpreview.message") %>,So you Can't <%=fieldname %> the staff</div>
<% }%>
<a href="#na2" name="na2" class="bt_blue" onclick="backfun()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.staffprofiletrashpreview.Back") %></strong><span class="bt_blue_r"></span></a>
<%if(deptList.size()==0)
{ %>
<a href="#na3" name="na3" class="bt_red" onclick="updatestaffstatus()"><span class="bt_red_lft"></span><strong><%=fieldname %></strong><span class="bt_red_r"></span></a>
<% }%>
<input type="hidden" name="Staffid" value="<%=Staffid%>"/>
<input type="hidden" name="roleid" value="<%=roleid%>"/>
<input type="hidden" name="status" value="<%=Status%>"/>
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