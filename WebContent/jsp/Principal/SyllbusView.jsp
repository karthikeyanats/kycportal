<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Syllbus| Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">
function loadStandard()
{
document.Syllbus_Form.submit();
}
function loadSubject(obj)
{
document.Syllbus_Form.boardname.value=document.Syllbus_Form.board.options[document.Syllbus_Form.board.options.selectedIndex].text;
document.Syllbus_Form.standardscheduleid.value=obj.getAttribute("standardscheduleid");
document.Syllbus_Form.standardname.value=obj.getAttribute("standardname");
document.Syllbus_Form.action="./StandardWiseSubjectView.jsp";
document.Syllbus_Form.submit();
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

    <h2><%=bundle.getString("hmlabel.syllabuslist.rootpath")%></h2>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Prinicipal.PrinicipalQuery,com.iGrandee.Common.DateTime"%>
<%

		PrinicipalQuery prinicipal			= new PrinicipalQuery();
		HashMap	hashmap				= null;
		String instituteid			= (String)session.getValue("instituteid");
		ArrayList BoardList			= prinicipal.loadboard(instituteid);
		ArrayList StandardList		= null;
		String sessionid=session.getValue("sessionid")+"";
		
		
		String boardid=request.getParameter("board")+"";
		if(!sessionid.equals("null") && !boardid.equals("null")&& !sessionid.equals("0") && !boardid.equals("0"))
		{
			StandardList=prinicipal.loadstandard(boardid,sessionid,instituteid);
		}
		String today				= DateTime.showTime("calendar");
%>
<form name="Syllbus_Form" action="" method="post">
<input type="hidden" name="todaydate" value="<%=today %>">
<input type="hidden" name="standardscheduleid" value="">
<input type="hidden" name="sex" value="">
<input type="hidden" name="hiddensession" value="<%=sessionid%>">
<input type="hidden" name="hiddenboard" value="<%=boardid%>">
<input type="hidden" name="standardname" value="">
<input type="hidden" name="sectionname" value="">
<input type="hidden" name="sessioninstituteid" value="<%=instituteid %>">
		
		<table width='100%' id=rounded-corner align='center' border='0' >
			<thead>
			<tr>
				<th scope="col" class="rounded-company" width="90%">Standard List</th>
				<th scope="col" class="rounded-q4" width="10%"></th>
			</tr>
		</thead>
		<tfoot>
			<tr>
				<td  class="rounded-foot-left"><em></em></td>
				<td class="rounded-foot-right">&nbsp;</td>
			</tr>
		</tfoot>
		<tbody ><tr>
		<td colspan=2>
		<table><tr>
				<td width='20%' class='tablebold'><%=bundle.getString("hmlabel.syllabuslist.academicyear")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='40%'>
					<%=session.getValue("sessionname") %>
				</td>
				<td width='5%' class='tablebold'><%=bundle.getString("hmlabel.syllabuslist.board")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='40%'>
					<select name='board' id='board' validate='Board Name' onchange="loadStandard()">
						<option value='0'>-Select Board-</option>
						<%
							if(BoardList != null && BoardList.size()>0)
								for(int y=0;y<BoardList.size();y++){
									hashmap		= (HashMap)BoardList.get(y);
									String boardname=hashmap.get("boardname")+"";
									String mediumname=hashmap.get("mediumname")+"";
									if(!mediumname.equals("null"))
										boardname=boardname+" -"+mediumname;
										out.print("<option value='"+hashmap.get("boardid")+"'>"+boardname+"</option>");
								}
						%>
					</select>
					<script>
					if(document.Syllbus_Form.hiddenboard.value!="null" && document.Syllbus_Form.hiddenboard.value!="0" && document.Syllbus_Form.hiddensession.value!="0")
					{
						for(var i=0;i<document.Syllbus_Form.board.length;i++)
						{
						if(document.Syllbus_Form.board.options[i].value==document.Syllbus_Form.hiddenboard.value)
						{
							document.Syllbus_Form.board.options[i].selected=true;
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
		<table   align='center' border='0' id=rounded-corner  cellpadding=0 cellspacing=0>
			<thead>
			<tr class=tableheading>
				<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("hmlabel.syllabuslist.slno")%></th>
				<th scope="col" class="rounded" width="70%" ><%=bundle.getString("hmlabel.syllabuslist.standardname")%></th>
				<th scope="col" class="rounded-q4" width="20%" ><%=bundle.getString("hmlabel.syllabuslist.totalstudents")%></th>
			</tr>
			</thead>
		
		<tbody>
		<%
		int Totalstudent=0;
							if(StandardList != null && StandardList.size()>0)
								{
								for(int y=0,i=1;y<StandardList.size();y++,i++){
									hashmap		= (HashMap)StandardList.get(y);
									String standardscheduleid=hashmap.get("standardscheduleid")+"";
									String standardname=hashmap.get("standardname")+"";
									String groupname=hashmap.get("groupname")+"";
									if(!groupname.equals("null"))
									standardname=standardname+" -"+groupname;
									String totalcount=hashmap.get("totalcount")+"";
									Totalstudent +=	Integer.parseInt(totalcount);						
									out.print("<tr align=center  ><td>"+i+"</td><td align=left><a href='#subjecthref' name='subjecthref' standardname='"+standardname+"'  standardscheduleid='"+standardscheduleid+"' onclick='loadSubject(this)'>"+standardname+"</a></td>");
									out.println("<td>"+totalcount+"</td>");
									out.print("</tr>");
								}
								}
							else
							{
								out.print("<tr><td colspan='3' class=tablebold align=center><font color='red'>Data Not Found</td></tr>");

							}
						%>
		</tbody>
		<tfoot>
		<tr >
				<td colspan='3'>&nbsp;</td>
			</tr>
			<tr>
				<td colspan='2' class=tablebold align=right><%=bundle.getString("hmlabel.syllabuslist.totalnoofstudents")%> </td><td  align=center class=tablebold><%=Totalstudent %></td>
			</tr>
		</tfoot>
		</table>
		<input type="hidden" name="boardname" value="">
			

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