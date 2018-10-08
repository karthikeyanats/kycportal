<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Staff List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>


<script type="text/javascript">
	function loadStandard()
	{
		document.Staff_Form.submit();
	}

	function loadstaffdetail(obj)
	{
		document.Staff_Form.userid.value=obj.getAttribute("userid");
		document.Staff_Form.username.value=obj.getAttribute("username");
		
		document.Staff_Form.req_boardid.value=document.Staff_Form.board.options[document.Staff_Form.board.options.selectedIndex].value;
		document.Staff_Form.req_boardname.value=document.Staff_Form.board.options[document.Staff_Form.board.options.selectedIndex].text;
		document.Staff_Form.req_stdschedid.value=document.Staff_Form.standard.options[document.Staff_Form.standard.options.selectedIndex].value;
		document.Staff_Form.req_standardnamegp.value=document.Staff_Form.standard.options[document.Staff_Form.standard.options.selectedIndex].text;
		
		document.Staff_Form.action="./StaffTimeTableView.jsp";
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

    <h2><%=bundle.getString("label.schedule.stafftimetablestaff")%></h2>
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
		String standardid="";
		String roleid="";
		ArrayList StandardList		= null;
		ArrayList StaffList		= null;
		ArrayList BoardList=new ArrayList();
		String boardid = null;

		try{
		String instituteid			= (String)session.getValue("instituteid");
		sessionList		= prinicipal.loadyearofsession(instituteid);
		sessionid=session.getValue("sessionid")+"";
		standardid=request.getParameter("standard")+"";
		roleid=request.getParameter("role")+"";
		boardid=request.getParameter("board")+"";

		if(!sessionid.equals("null") && !sessionid.equals("0"))
		{
			BoardList	= prinicipal.loadboard(instituteid);
		}
		if(!sessionid.equals("null") && !sessionid.equals("0") && !boardid.equals("null") && !boardid.equals("0"))
		{
		 StandardList=prinicipal.loadstandardusingsessionid(sessionid,boardid);
		}
		if(!sessionid.equals("null") && !sessionid.equals("0") && !boardid.equals("null") && !boardid.equals("0") && !standardid.equals("null") && !standardid.equals("0") && StandardList.size()>0)
		{
			StaffList=prinicipal.loadstaffusingstandardscheduleid(standardid);
		}
		
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		String today				= DateTime.showTime("calendar");
		//out.println(StandardList);
%>
<form name="Staff_Form" action="" method="post">
<input type="hidden" name="hiddenyear" value="<%=sessionid %>">
<input type="hidden" name="hiddenstandardid" value="<%=standardid %>">
<input type="hidden" name=userid value="">
<input type="hidden" name=username value='""'>

<input type="hidden" name=req_boardid value='""'>
<input type="hidden" name=req_boardname value='""'>
<input type="hidden" name=req_stdschedid value='""'>
<input type="hidden" name=req_standardnamegp value='""'>


		<table width='80%' id=rounded-corner align='center' border='0' >
			<thead>
			<tr>
				<th scope="col" class="rounded-company" width="90%" colspan=6><%=bundle.getString("label.schedule.stafftimetable")%></th>
				<th scope="col" class="rounded-q4" width="10%"></th>
			</tr>
		</thead>
		<tfoot>
			<tr>
				<td colspan=6 class="rounded-foot-left"><em></em></td>
				<td class="rounded-foot-right">&nbsp;</td>
			</tr>
		</tfoot>
		<tbody ><tr>
		<td></td>
				<td width='40%' class='tablebold'><%=bundle.getString("label.schedule.academicyear")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='40%'>
					<%=session.getValue("sessionname") %>
				</td>
				<td width='5%' class='tablebold'>Board</td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='40%'>
				<select name='board' id='board' validate='Board Name' style="width:200px" onchange="loadStandard()">
						<option value='0'>-Select Board-</option>
						<%
							if(BoardList != null && BoardList.size()>0)
								for(int y=0;y<BoardList.size();y++){
									hashmap		= (HashMap)BoardList.get(y);
									String boardname=hashmap.get("boardname")+"";
									String mediumname=hashmap.get("mediumname")+"";
									if(!mediumname.equals("null"))
										boardname=boardname+" -"+mediumname;
									if(hashmap.get("boardid").equals(boardid))
									out.print("<option value='"+hashmap.get("boardid")+"' selected=true>"+boardname+"</option>");
									else
										out.print("<option value='"+hashmap.get("boardid")+"'>"+boardname+"</option>");
								}
						%>
					</select>
					
				</td>
			</tr>
			<tr>
					<td></td>
			<td width='5%' class='tablebold'><%=bundle.getString("label.schedule.standardname")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='40%' colspan=4>
			<select name='standard' id='standard' validate='Standard Name' onchange="loadStandard()">
						<option value='0'>-Select Standard-</option>
						<%
							if(StandardList != null && StandardList.size()>0)
								for(int y=0;y<StandardList.size();y++){
									hashmap		= (HashMap)StandardList.get(y);
									String standardname=hashmap.get("standardname")+"";
									String groupname=hashmap.get("groupname")+"";
									if(!groupname.equals("null"))
										standardname=standardname+" -"+groupname;
									out.print("<option value='"+hashmap.get("standardscheduleid")+"'>"+standardname+"</option>");
								}
						%>
					</select>
					<script>
					if(document.Staff_Form.hiddenstandardid.value!="null" && document.Staff_Form.hiddenstandardid.value!="0" && document.Staff_Form.hiddenyear.value!="0")
					{
						for(var i=0;i<document.Staff_Form.standard.length;i++)
						{
						if(document.Staff_Form.standard.options[i].value==document.Staff_Form.hiddenstandardid.value)
						{
							document.Staff_Form.standard.options[i].selected=true;
						}
						}
					}
					</script>
					</td>
			</tr>
			
		</tbody>
		</table>
		<br>
		<table   align='center' border='0' id=rounded-corner  width="100%" cellpadding=0 cellspacing=0>
			<thead>
			<tr class=tableheading>
				<th scope="col" class="rounded-company" width="10%" ><%=bundle.getString("label.schedule.slno")%></th>
				<th scope="col" class="rounded" width="30%"><%=bundle.getString("label.schedule.staffname")%></th>
				<th scope="col" class="rounded" width="20%"><%=bundle.getString("label.schedule.section")%></th>
				<th scope="col" class="rounded" width="20%"><%=bundle.getString("label.schedule.department")%></th>
				<th scope="col" class="rounded-q4" width="20%" ><%=bundle.getString("label.schedule.role")%></th>
			</tr>
			</thead>
		<tbody>
		<%
		if(StaffList != null && StaffList.size()>0)
								{
								for(int y=0,i=1;y<StaffList.size();y++,i++){
									hashmap		= (HashMap)StaffList.get(y);
									String rolename=hashmap.get("rolename")+"";
									String sectionname=hashmap.get("sectionname")+"";
									String uname=hashmap.get("uname")+"";
									String staffid=hashmap.get("staffid")+"";
									String userid=hashmap.get("userid")+"";
									String departmentname=hashmap.get("departmentname")+"";
									out.print("<tr align=left  ><td align=center>"+i+"</td><td><a href='#staff' name='staff' userid='"+userid+"' username='"+uname+"' onclick='loadstaffdetail(this)'>"+uname+"</td>");
									out.println("<td>"+sectionname+"</td>");
									out.println("<td>"+departmentname+"</td>");
									out.println("<td>"+rolename+"</td>");
									out.print("</tr>");
								}
								}
							else
							{
								out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
								//out.print("<tr><td colspan='5' align=center>"+bundle.getString("label.schedule.datanotfound")+"</td></tr>");
							}
						%>
		</tbody>
		<tfoot>
		<tr >
				<td colspan='5'>&nbsp;</td>
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