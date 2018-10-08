<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child -<%=bundle.getString("label.staffpromotionview.title") %>| Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>


<script type="text/javascript">
function viewdepartment(obj)
{
document.f1.Staffid.value=obj.getAttribute("Staffid");
document.f1.roleid.value=obj.getAttribute("roleid");
document.f1.action= "./StaffpromotionPreviewView.jsp";
document.f1.submit();
}
function backfun()
{

document.f1.action= "./Staff_Promotion.jsp";
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

    <h2><%=bundle.getString("label.staffpromotionview.rootpath") %></h2>
  <form name="f1" method="post" action="" >
       <%@ page import="java.util.*"%>
<%@ page import="com.iGrandee.Registration.StaffRegistrationQuery"%>
<%@ page import="com.iGrandee.Common.DateTime"%>

<%
	String date_str="";
	ArrayList deptList = null;
	StaffRegistrationQuery staffquery=new StaffRegistrationQuery();
		DateTime datebeans =new DateTime();

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
			
			deptList =staffquery.departmentvisestaff(departid);
			 date_str = datebeans.showTime("");
			//out.println("====>>>"+date_str);
	}
	catch(NullPointerException e){}
%>
<form name="f1" method="post" action="" >

<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.staffpromotionview.SL.No") %></th>
            <th scope="col" class="rounded" width="30%"><%=bundle.getString("label.staffpromotionview.StaffName") %></th>
            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.staffpromotionview.Qualification") %></th>
            <th scope="col" class="rounded" width="15%"><%=bundle.getString("label.stafflistview.JobCategory") %></th>
            <th scope="col" class="rounded-q4" width="30%"><%=bundle.getString("label.staffpromotionview.Experience") %></th>
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
	 			String Qualification = (String)deptMap.get("qualification");
	    		String Staffstatus 	= (String)deptMap.get("staffstatus");
	    		String rolename 	= (String)deptMap.get("rolename");

	    		String roleid 		= (String)deptMap.get("roleid");
	    		String dateofjoin 	= (String)deptMap.get("datejoin");
	    		String experienceday 	= (String)deptMap.get("experienceday");
	    		int experiencedayint =Integer.parseInt(experienceday);
		    	String categoryname = (String)deptMap.get("categoryname")+"";

	    		
	 		   	dateofjoin=dateofjoin.substring(0,10);
	 		   
	 		   /*	String current [] = date_str.split("/");
	 		  	int currentyear =Integer.parseInt(current[0]);
	    		int currentMonth =Integer.parseInt(current[1]);
	    		int currentday =Integer.parseInt(current[2]);
	    		String Experi [] = dateofjoin.split("-");
	    		int Experiyear =Integer.parseInt(Experi[0]);
	    		int ExperiMonth =Integer.parseInt(Experi[1]);
	    		int Experiday =Integer.parseInt(Experi[2]);*/
	 		   	out.println("<tr>");
	 		   	out.println("<td>"+(i+1)+"</td>");
	 		   	out.println("<td><a href='#' Staffid='"+Staffid+"' roleid='"+roleid+"' onclick='viewdepartment(this)' >"+Staffname+"</a>&nbsp;,"+Qualification+"</td>");
	 			out.println("<td>"+rolename+"</td>");
	 		   	out.println("<td>"+categoryname+"</td>");

		 		out.println("<td>");
	 		   	int year=(experiencedayint/365);
	 		   	int month=((experiencedayint%365)/30);
	 		   	int day=(((experiencedayint%365)%30));
	 		   	if(year==1)
				{
	 		   	out.println((year+" year").replaceAll("-",""));
				}
	 		   	else if(year!=0)
				{
	 		   	out.println((year+" years").replaceAll("-",""));
				}
	 		   	if(month==1)
				{
	 		  	out.println((month+" month").replaceAll("-",""));
				}
	 		   	else if(month!=0)
				{
	 		  	out.println((month+" months").replaceAll("-",""));
				}
	 		  	if(day==1)
				{
	 		   	out.println((day+" day").replaceAll("-",""));
				}
	 		  	else if(day!=0)
				{
	 		   	out.println((day+" days").replaceAll("-",""));
				}
	 		  	else
	 		  	{
		 		   out.println("No Experience");
	 		  	}
	 		   	//out.println(experienceday+" days");

	 		   	out.println("</td>");

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
<a href="#"  onclick="backfun()" class="bt_blue"><span
		class="bt_blue_lft"></span><strong><%=bundle.getString("button.staffpromotionview.Back") %></strong><span
		class="bt_blue_r"></span></a> 
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
<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>