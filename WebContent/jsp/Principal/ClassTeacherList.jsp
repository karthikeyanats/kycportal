<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Staff List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>


<script type="text/javascript">
	function loadboard()
	{
	document.Staff_Form.standard.options[0].selected=true;
		document.Staff_Form.submit();
	}
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

    <h2><%=bundle.getString("label.schedule.classteacherlist")%></h2>
    											 	 <%@ page import="com.iGrandee.StaffList.StaffEntry"%>
    
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
		ArrayList SectioList		= null;
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
			SectioList=prinicipal.loadsection(standardid,instituteid);
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
				<select name='board' id='board' validate='Board Name' style="width:200px" onchange="loadboard()">
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
				<th scope="col" class="rounded" width="20%"><%=bundle.getString("label.schedule.section")%></th>
				<th scope="col" class="rounded-q4" width="30%"><%=bundle.getString("label.schedule.staffdetails")%></th>
			</tr>
			</thead>
		<tbody>
		<%
		if(SectioList != null && SectioList.size()>0)
								{
								for(int y=0,i=1;y<SectioList.size();y++,i++){
								hashmap		= (HashMap)SectioList.get(y);
								String	sectionscheduleid=	hashmap.get("sectionscheduleid")+"";
								
								StaffEntry studentquery = new StaffEntry();  
								out.println("<tr valign=top><td>"+i+"</td><td>"+hashmap.get("sectionname")+"</td><td width='50%'>");
								ArrayList classTeacherList=studentquery.showClassTeacher(sectionscheduleid);
								  if(classTeacherList!=null && classTeacherList.size()>0)
									{
								%>
								
										 <%
												  //uname, mobilenumber, emailid, imagepath, qualification, subjectname, staffid, staffcategoryid, subjectscheduleid, standardscheduleid, personid, subjectypename
														for(int x=0,j=1;x<classTeacherList.size();x++,j++)
														{
															HashMap classTeacherListmap=(HashMap)classTeacherList.get(x);
															prefix = (String) classTeacherListmap.get("prefix");
															String qualification = (String) classTeacherListmap.get("qualification");
															String firstname = (String) classTeacherListmap.get("firstname");
															String middlename = (String) classTeacherListmap.get("middlename");
															if(middlename.equals("") || middlename.equals("-"))
																middlename = "";
															String lastname = (String) classTeacherListmap.get("lastname");
															String landlinenumber = (String) classTeacherListmap.get("landlinenumber");
															String mobilenumber = (String) classTeacherListmap.get("mobilenumber");
															String emailid = (String) classTeacherListmap.get("emailid");
															String imagepath = (String) classTeacherListmap.get("imagepath");
															String departmentname = (String) classTeacherListmap.get("departmentname");
															String rolename = (String) classTeacherListmap.get("rolename");
															String sex = (String) classTeacherListmap.get("sex");
															
															String fullname = firstname+" "+middlename+" "+lastname;
												%>			

											<table border=0 cellspacing=0 cellpadding=0 width="100%">
												<tr>
												<td class=tablebold  width='25%'><%=bundle.getString("label.studentprofile.Name")%></td><td width='1%' class='tablebold'>:</td><td><%=prefix%> <%=fullname%>, <%=qualification%></td><td rowspan=3 width='50%' align=center><img
															src="<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2=<%=imagepath%>"
															name='stphoto_img1' id=stphoto_img width=90 height=100></td>
												</tr>
												<tr>
																			<td class=tablebold width="25%"><%=bundle.getString("label.stafflist.mobilenumber")%></td><td width='1%' class='tablebold'>:</td><td><%=mobilenumber%></td>
												</tr>
												<tr>
																			<td class=tablebold>
																							<%=bundle.getString("label.stafflist.emailid")%>
																			</td>
																			<td width='1%' class='tablebold'>:</td><td><a href="mailto:<%=emailid %>"><%=emailid %></a></td>
												</tr>
											</table>
								<%
									}
								}
								  else
								  {
										out.println(bundle.getString("label.stafflist.noclassteacher"));

								  }
								}
								out.println("</td></tr>");
								}
							else
							{
								out.println("<tr align='center' class='tablebold'><td colspan='3'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
								//out.print("<tr><td colspan='5' align=center>"+bundle.getString("label.schedule.datanotfound")+"</td></tr>");
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