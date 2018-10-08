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
document.Staff_Form.boardname.value=document.Staff_Form.board.options[document.Staff_Form.board.options.selectedIndex].text;
document.Staff_Form.standardname.value=document.Staff_Form.standard.options[document.Staff_Form.standard.options.selectedIndex].text;
document.Staff_Form.staffid.value=obj.getAttribute("staffid");
document.Staff_Form.sectionscheduleid.value=obj.getAttribute("sectionscheduleid");
document.Staff_Form.action="./StaffSubjectView.jsp";
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

    <h2><%=bundle.getString("hmlabel.yearstafflist.rootpath")%> </h2>
<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Prinicipal.PrinicipalQuery,com.iGrandee.Common.DateTime"%>
<%

		PrinicipalQuery prinicipal			= new PrinicipalQuery();
		HashMap	hashmap				= null;
		ArrayList sessionList		=null;
		ArrayList DepartList		=null;
		ArrayList RoleList			=null;
		String sessionid="";
		String standardid= null;
		
		String sessionname="";
		String roleid="";
		ArrayList StandardList		= new ArrayList();
		ArrayList StaffList		= new ArrayList();
		ArrayList BoardList=new ArrayList();
		String boardid = null;

		try{
		String instituteid			= (String)session.getValue("instituteid");
		sessionname=(String)session.getValue("sessionname");
		sessionList		= prinicipal.loadyearofsession(instituteid);
		sessionid=session.getValue("sessionid")+"";
		roleid=request.getParameter("role")+"";
		boardid=request.getParameter("board")+"";
	    standardid=request.getParameter("standard")+"";
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
<input type="hidden" name="staffid" value="">
<input type="hidden" name="sectionscheduleid" value="">


		<table width='100%' id=rounded-corner align='center' border='0' >
			<thead>
			<tr>
				
				<th scope="col" class="rounded-company" width="90%">Subject Allotment</th>
				<th scope="col" class="rounded-q4" width="10%"></th>
			</tr>
		</thead>
		<tfoot>
			<tr>
				<td class="rounded-foot-left"><em></em></td>
				<td class="rounded-foot-right">&nbsp;</td>
			</tr>
		</tfoot>
		<tbody >
		<tr>
		<td colspan=2>
		<table width=100%>
		<tr>
				<td width='20%' class='tablebold'><%=bundle.getString("hmlabel.yearstafflist.academicyear")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='40%'>
						<%=session.getValue("sessionname")%>
				</td>
				<td width='5%' class='tablebold'><%=bundle.getString("hmlabel.yearstafflist.board")%></td>
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
			
			<td width='5%' class='tablebold'><%=bundle.getString("hmlabel.yearstafflist.standard")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='40%' >
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
									if(hashmap.get("standardscheduleid").equals(standardid))
										out.print("<option value='"+hashmap.get("standardscheduleid")+"' selected=true>"+standardname+"</option>");
										else
											out.print("<option value='"+hashmap.get("standardscheduleid")+"'>"+standardname+"</option>");
								}
						%>
					</select>
				</td>
				</tr>
				</table></td></tr>
		</tbody>
		</table>
		<br>
		<table    border='0' id=rounded-corner bordercolor=white width="100%" cellpadding=3 cellspacing=0>
			<thead>
			<tr class=tableheading>
				<th scope="col" class="rounded-company" width="5%" ><%=bundle.getString("hmlabel.yearstafflist.slno")%></th>
				<th scope="col" class="rounded" width="30%"><%=bundle.getString("hmlabel.yearstafflist.staffname")%> </th>
				<th scope="col" class="rounded" width="20%"><%=bundle.getString("hmlabel.yearstafflist.sectionname")%> </th>
				
				<th scope="col" class="rounded" width="20%"><%=bundle.getString("hmlabel.yearstafflist.departmentname")%></th>
				
				<th scope="col" class="rounded-q4" width="20%" ><%=bundle.getString("hmlabel.yearstafflist.designation")%></th>
			</tr>
			</thead>
			<tfoot>
			<tr>
				<td class="rounded-foot-left" colspan=4 ><em></em></td>
				<td class="rounded-foot-right">&nbsp;</td>
			</tr>
		</tfoot>
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
									String sectionscheduleid=hashmap.get("sectionscheduleid")+"";
									String departmentname=hashmap.get("departmentname")+"";
									
									out.print("<tr align=left ><td align=center>"+i+"</td><td><a href='#staff' name='staff' staffid='"+staffid+"' sectionscheduleid='"+sectionscheduleid+"' onclick='loadstaffdetail(this)'>"+uname+"</td>");
									out.println("<td>"+sectionname+"</td>");
									out.println("<td>"+departmentname+"</td>");
									out.println("<td>"+rolename+"</td>");
									out.print("</tr>");
								}
								}
							else
							{
								out.print("<tr><td colspan='5' class=tablebold align=center><font color=red>Data Not Found</font></td></tr>");
							}
									
						%>
		
		</tbody>
		
		
		</table>
			<input type="hidden" name="boardname" value="">
			<input type="hidden" name="sessionname_hidden" value="<%=sessionname %>">
			<input type="hidden" name="standardname" value="">
			<input type="hidden" name="sectionname" value="">
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