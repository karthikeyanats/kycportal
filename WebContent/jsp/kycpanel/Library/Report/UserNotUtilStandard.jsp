<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>
<title>Know Your Child - <%=bundle.getString("label.usernotutil.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript">
function loadStandard()
{
document.Standard_Form.submit();
}
function Backfun()
{
document.Standard_Form.action="./UserNotUtil.jsp";
document.Standard_Form.submit();
}
function loadSection(obj)
{
document.Standard_Form.boardname.value=document.Standard_Form.board.options[document.Standard_Form.board.options.selectedIndex].text;
var standardscheduleid=obj.getAttribute("standardscheduleid");
document.Standard_Form.req_sessionname.value	= document.Standard_Form.academicyear.options[document.Standard_Form.academicyear.options.selectedIndex].text;
document.Standard_Form.standardscheduleid.value=standardscheduleid;
document.Standard_Form.standardname.value=obj.getAttribute("standardname");
document.Standard_Form.totalcount.value=obj.getAttribute("totalcount");
document.Standard_Form.utilcount.value=obj.getAttribute("utilcount");
document.Standard_Form.action="./UserNotUtilSection.jsp";
document.Standard_Form.submit();
}

	
function loadSession()
{
	document.Standard_Form.submit();

}
function loadBoard()
{
	if(check_ForParticularElements(document.Standard_Form.academicyear,"select"))
	{
		document.Standard_Form.submit();

	}
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

<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Library.Report.BookJournalReport"%>
<%

		BookJournalReport reportquery			= new BookJournalReport();
		HashMap	hashmap				= null;
		String instituteid			= (String)session.getValue("instituteid");
		ArrayList SessionList			= reportquery.loadsession(instituteid); 
		ArrayList BoardList			= reportquery.loadboard(instituteid);
		String academicyear=request.getParameter("academicyear")+"";
		String board_id=request.getParameter("board")+"";
		ArrayList StandardList		= null;
		String rootlabel="";
		String	status  = "A";
		
			 	
		
		
		if(!academicyear.equals("null") && !board_id.equals("null")&& !academicyear.equals("0") && !board_id.equals("0"))
		{
			StandardList=reportquery.loadstandardNotUtilStudents(board_id,academicyear,instituteid,status);   
		}    
%>
         <h2><%=bundle.getString("label.usernotutil.entryrootpathstudent")%></h2>

<form name="Standard_Form" action="" method="post">
<input type="hidden" name="standardscheduleid" value="">
<input type="hidden" name="hiddenboard" value="<%=board_id%>">
<input type="hidden" name="standardname" value="">
<input type="hidden" name="boardname" value="">
<input type="hidden" name="sessioninstituteid" value="<%=instituteid %>">
<input type="hidden" name="req_sessionname" value="">
<input type="hidden" name="totalcount" value="">
<input type="hidden" name="utilcount" value="">

		
		<table width='80%' id=rounded-corner align='center' border='0' >
			<thead>
			<tr>
				
				<th scope="col" class="rounded-company" width="90%" ><%=bundle.getString("label.usernotutil.entryrootpathstudent")%></th>
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
				<td width='20%' class='tablebold'><%=bundle.getString("label.usernotutil.AcademicYear")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='40%'> 
					<select name='academicyear' id='Sission' validate='Academic Year' onchange="loadSession()">
						<option value='0'>-Select Academic Year-</option>
						<%
							if(SessionList != null && SessionList.size()>0)
								for(int y=0;y<SessionList.size();y++){
									hashmap		= (HashMap)SessionList.get(y);
									String sessionname=hashmap.get("sessionname")+"";
									String sessionid=hashmap.get("sessionid")+"";
									if(academicyear!=null && academicyear.equals(sessionid))
									{
									out.print("<option value='"+hashmap.get("sessionid")+"' selected>"+sessionname+"</option>");
									}
									else
									{
										out.print("<option value='"+hashmap.get("sessionid")+"' >"+sessionname+"</option>");

									}
									}
						%>
					</select>
					
				</td>
				<td width='5%' class='tablebold'><%=bundle.getString("label.usernotutil.Board")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='40%'>
					<select name='board' id='board' validate='Board Name' onchange="loadBoard()">
						<option value='0'>-Select Board-</option>
						<%
							if(BoardList != null && BoardList.size()>0)
								for(int y=0;y<BoardList.size();y++){
									hashmap		= (HashMap)BoardList.get(y);
									String boardname=hashmap.get("boardname")+"";
									String mediumname=hashmap.get("mediumname")+"";
									String boardid=hashmap.get("boardid")+"";

									if(!mediumname.equals("null"))
										boardname=boardname+" -"+mediumname;
									
									if(board_id!=null && board_id.equals(boardid))
									{
										out.print("<option value='"+hashmap.get("boardid")+"' selected>"+boardname+"</option>");
									}
									else
									{
										out.print("<option value='"+hashmap.get("boardid")+"'>"+boardname+"</option>");

									}
									}
						%>
					</select>
				
				</td>
			</tr>
			</table></td></tr>
		</tbody>
		</table>
		<br>
		<table   align='center' border='0' id=rounded-corner bordercolor=white width="100%" cellpadding=0 cellspacing=0>
			<thead>
			<tr class=tableheading>
				<th scope="col" class="rounded-company" width="10%" rowspan=2><%=bundle.getString("label.usernotutil.slno")%></th>
				<th scope="col" class="rounded" width="30%" rowspan=2><%=bundle.getString("label.usernotutil.standardname")%></th>
				<th scope="col" class="rounded" width="20%" colspan=2><%=bundle.getString("label.usernotutil.totalstudents")%></th>
				<th scope="col" class="rounded-q4" width="20%"  rowspan=2><%=bundle.getString("label.usernotutil.cardissued")%></th>
			</tr>
			</thead>
		
		<tbody>
		<%
							int Totalstudent=0;
							int TotalIssuedcount=0;

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
									String sectioncount=hashmap.get("sectioncount")+"";
									String utilcount=hashmap.get("utilcount")+"";
									
									int usernotutil = Integer.parseInt(totalcount) - Integer.parseInt(utilcount);
									
									utilcount = usernotutil+"";
									
									Totalstudent +=	Integer.parseInt(totalcount);	
									TotalIssuedcount+=	Integer.parseInt(utilcount);
									//if(!sectioncount.equals("null") && !sectioncount.equals("0"))
									if(!utilcount.equals("null") && !utilcount.equals("0"))	
									{
									out.print("<tr  ><td>"+i+"</td><td align=left><a href='#sectionhref' name='sectionhref' standardname='"+standardname+"'  standardscheduleid='"+standardscheduleid+"' totalcount='"+totalcount+"' utilcount='"+utilcount+"' onclick='loadSection(this)'>"+standardname+" </a></td>");
									}
									else
									{
										out.print("<tr ><td>"+i+"</td><td align=left>"+standardname+"</td>");

									} 
									
								
									
									if(!totalcount.equals("null") && !totalcount.equals("0"))
										out.println("<td colspan=2><font size='4'>"+totalcount+"</font></td>");
									else
										out.println("<td colspan=2>"+totalcount+"</td>");
									
									if(!utilcount.equals("null") && !utilcount.equals("0"))
										out.println("<td ><font size='4'> "+utilcount+" </font></td>");
									else
										out.println("<td >"+utilcount+"</td>");
									
									out.print("</tr>");
								}
								%>
								<tr>
									<td colspan='5'><hr></td>
								</tr>					
								<tr class=tablebold>
									<td></td><td align="right"><%=bundle.getString("label.usernotutil.total")%>:</td><td   class=tablebold colspan=2><font size='4'><%=Totalstudent %></font></td><td  class=tablebold><font size='4'><%=TotalIssuedcount %></font></td>
								</tr>								
								<%
								}
							else
							{
								out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>"+bundle.getString("label.usernotutil.datanotfound")+"</font></td></tr>");
								//out.print("<tr><td colspan='6' class=tablebold align=center><font color=red>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");

							}
						%> 

					
		</tbody>
		<tfoot>
		<tr >
				<td colspan='5'>&nbsp;</td>
			</tr>
			
		</tfoot>
		</table>
		
		
						
						
						<a href="#" class="bt_blue" onclick='Backfun()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.usernotutil.back")%></strong><span class="bt_blue_r"></span></a>
		
		</form>		

    </div><!-- end of right content--> 


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>

</html>