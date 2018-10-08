<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Staff | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>


<script type="text/javascript">
function loadStandard()
{
document.Staff_Form.submit();
}

function staffprofile(obj)
{
document.Staff_Form.Staffid.value=obj.getAttribute("staffid");
document.Staff_Form.action="./StaffProfileView.jsp";
document.Staff_Form.submit();
}
</script>
</head>
<body>
<div id="main_container">
	<div class="header">
<%@ include file="../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<%@ include file="../include/header.jsp" %>

	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>

    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("hmlabel.stafflist.rootpath")%></h2>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Prinicipal.PrinicipalQuery,com.iGrandee.Common.DateTime"%>
<%

		PrinicipalQuery prinicipal			= new PrinicipalQuery();
		HashMap	hashmap				= null;
		ArrayList sessionList		=null;
		ArrayList DepartList		=null;
		ArrayList RoleList			=null;
		String sessionid="";
		String departmentid="";
		String roleid="";
		ArrayList StaffList		= null;

		try{
		String instituteid			= (String)session.getValue("instituteid");
		DepartList			= prinicipal.loadActiveDepartments(instituteid);
		departmentid=request.getParameter("department")+"";
		if(!departmentid.equals("null") && !departmentid.equals("0"))
		{
			StaffList=prinicipal.loadstaffusingdepartment(departmentid);
		}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		String today				= DateTime.showTime("calendar");
	//	out.println(StaffList);
%>
<form name="Staff_Form" action="" method="post">
<input type="hidden" name="hiddendepart" value="<%=departmentid %>">
<input type="hidden" name="Staffid" value="">

		<table width='80%' id=rounded-corner align='center' border='0' >
			<thead>
			<tr>
			
				<th scope="col" class="rounded-company" width="90%" >Staff List</th>
				<th scope="col" class="rounded-q4" width="10%"></th>
			</tr>
		</thead>
		<tfoot>
			<tr>
				<td class="rounded-foot-left"><em></em></td>
				<td class="rounded-foot-right">&nbsp;</td>
			</tr>
		</tfoot>
		<tbody ><tr>
			<td colspan=2>
			<table width="100%">
			<tr>
				<td width='5%' class='tablebold'><%=bundle.getString("hmlabel.stafflist.department")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='80%'>
					<select name='department' id='department' validate='Department Name' onchange="loadStandard()">
						<option value='0'>-Select Department-</option>
						<%
						String depid="";

							if(DepartList != null && DepartList.size()>0)
							{
								for(int y=0;y<DepartList.size();y++){
									hashmap		= (HashMap)DepartList.get(y);
									String departmentname=hashmap.get("departmentname")+"";
									depid +=hashmap.get("departmentid")+",";
									out.print("<option value='"+hashmap.get("departmentid")+"'>"+departmentname+"</option>");
									
								}
								out.print("<option value='"+depid+"'>All Department</option>");
								//System.out.println("======"+depid.substring(0,depid.length()-1));
							}
								
						%>
					</select>
					<script>
					if(document.Staff_Form.hiddendepart.value!="null" && document.Staff_Form.hiddendepart.value!="0")
					{
						for(var i=0;i<document.Staff_Form.department.length;i++)
						{
						if(document.Staff_Form.department.options[i].value==document.Staff_Form.hiddendepart.value)
						{
							document.Staff_Form.department.options[i].selected=true;
						}
						}
					}
					</script>
				</td>
			</tr>
			</table></td></tr>
		</tbody>
		</table>
		<br>
		<table align='center' border='0' id=rounded-corner bordercolor=white width="100%" cellpadding=0 cellspacing=0>
			<thead>
			<tr class=tableheading>
				<th scope="col" class="rounded-company" width="20%" rowspan=2><%=bundle.getString("hmlabel.stafflist.slno")%></th>
				<th scope="col" class="rounded" width="40%" rowspan=2><%=bundle.getString("hmlabel.stafflist.staffname")%></th>
				<th scope="col" class="rounded-q4" width="50%" rowspan=2><%=bundle.getString("hmlabel.stafflist.designation")%></th>
			</tr>
			</thead>
		
		<tbody>
		<%
		int Totalstudent=0;
							if(StaffList != null && StaffList.size()>0)
								{	
								String tempid="";

								for(int y=0,i=1;y<StaffList.size();y++,i++){
									hashmap		= (HashMap)StaffList.get(y);

									if(!tempid.equals(hashmap.get("departmentid")+""))
									{
										out.print("<tr align=center  ><td align=left colspan=3 class=tablebold><font color=red>Department :"+hashmap.get("departmentname")+"</font></td></tr>");
										tempid=hashmap.get("departmentid")+"";
									}
									String username=hashmap.get("username")+"";
									String rolename=hashmap.get("rolename")+"";
									String staffid=hashmap.get("staffid")+"";
									out.print("<tr align=center  ><td>"+i+"</td><td align=left><a href='#' staffid='"+staffid+"' onclick='staffprofile(this)'>"+username+"</a></td>");
									out.println("<td align=left>"+rolename+"</td>");
									out.print("</tr>");
								}
								}
							else
							{
								out.print("<tr><td colspan='3' class=tablebold align=center><font color=red>Data Not Found</font></td></tr>");
							}
						%>
		</tbody>
		<tfoot>
		<tr >
				<td colspan='3'>&nbsp;</td>
			</tr>
		</tfoot>
		</table>

		<!--  <a href="#" class="bt_blue" onclick='loadstudent()'><span class="bt_blue_lft"></span><strong>Load Student</strong><span class="bt_blue_r"></span></a>-->
		</form>		

    </div><!-- end of right content--> 


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>