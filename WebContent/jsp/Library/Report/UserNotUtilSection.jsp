<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>
<title>Know Your Child - <%=bundle.getString("label.usernotutil.title")%>  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>


<script type="text/javascript">
function loadStandard()
{
document.Section_Form.submit();
}
function backfun()
{
document.Section_Form.action="./UserNotUtilStandard.jsp";
document.Section_Form.submit();
}
function loadStudent(obj)
{
document.Section_Form.sectionscheduleid.value=obj.getAttribute("sectionscheduleid");
document.Section_Form.sex.value=obj.getAttribute("sex");
document.Section_Form.sectionname.value=obj.getAttribute("sectionname");
document.Section_Form.action="./UserNotUtilStudent.jsp";
document.Section_Form.submit();
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
		ArrayList StandardList		= null;
		String standardname=request.getParameter("standardname")+"";
		String standardscheduleid=request.getParameter("standardscheduleid")+"";
		String boardid=request.getParameter("hiddensession")+"";
		String boardname=request.getParameter("boardname")+"";
		String academicyear=request.getParameter("academicyear")+"";
		String board=request.getParameter("board");
		String sessionid=null;
		String sessionname=null;
		String totalcount_temp=null;//request.getParameter("hiddenboard")+"";
		String utilcount=null;
		String	status  = "A";
		
		
	   sessionname=request.getParameter("req_sessionname")+"";
	   totalcount_temp=request.getParameter("totalcount")+"";
	   utilcount=request.getParameter("utilcount")+""; 
	   

		
		if(!standardname.equals("null") && !standardscheduleid.equals("null"))
		{
			StandardList=reportquery.loadsectionNotUtilStudents(standardscheduleid,status);    
		}
%>
    <h2><%=bundle.getString("label.usernotutil.entryrootpathsection")%> </h2>

<form name="Section_Form" action="" method="post">
						<input type="hidden" name="standardscheduleid" value="<%=standardscheduleid %>">
						<input type="hidden" name="session" value="<%=sessionid%>">
						<input type="hidden" name="board" value="<%=board%>">
						<input type="hidden" name="standardname" value="<%=standardname %>">
						<input type="hidden" name="sectionname" value="">
						<input type="hidden" name="sectionscheduleid" value="">
						<input type="hidden" name="sex" value="">
						<input type="hidden" name="sessioninstituteid" value="<%=instituteid %>">
						<input type="hidden" name="req_sessionid" value="<%=sessionid %>">
						<input type="hidden" name="req_sessionname" value="<%=sessionname%>">
						<input type="hidden" name="boardname" value="<%=boardname%>">
						<input type="hidden" name=req_sessionstatus value="<%=request.getParameter("req_sessionstatus") %>">
						<input type="hidden" name="totalcount" value="<%=totalcount_temp%>">
						<input type="hidden" name="utilcount" value="<%=utilcount%>">
						<input type="hidden" name="academicyear" value="<%=academicyear%>">
			
			<table id="rounded-corner" border=0 
							width="100%">
							<thead>
								<tr>
									<th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.usernotutil.selectedinfo")%></th>
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
    				<%=bundle.getString("label.usernotutil.AcademicYear")%>
    				</td>
    			
	    			<td class=tablebold>:</td>
	    			<td>
	    			<%=sessionname%>
	    			</td>
	    			
    				<td  class=tablebold >
    				<%=bundle.getString("label.usernotutil.Board")%>
    				</td>
    			<td class=tablebold>:</td>  
	    			<td>
	    			<%=boardname%>
	    			</td>
    			</tr>
    			<tr>
	    			
	    			<td  class=tablebold width=20%>
	    			<%=bundle.getString("label.usernotutil.standardname")%>
	    			</td>
	    			<td class=tablebold>:</td>
	    			<td >
	    			<%=standardname%>
	    			</td>
	    			<td  class=tablebold width=20% >
	    			<%=bundle.getString("label.usernotutil.totalstudents")%>
	    			</td>
	    			<td class=tablebold>:</td>
	    			<td >
	    			<%=totalcount_temp%>
	    			</td>
	    			
    			
    			</tr>
    			<tr>
    			<td  class=tablebold width=20%>
	    			<%=bundle.getString("label.usernotutil.cardissued")%>
	    			</td>
	    			<td class=tablebold>:</td>
	    			<td >
	    			<%=utilcount%>
	    			</td>
	    			
    			
    			</tr>
    			</table>
    			</td></tr></tbody></table>
    			<br>
		<table   align='center' border='0' id=rounded-corner bordercolor=white width="100%" cellpadding=0 cellspacing=0>
			<thead>
			<tr class=tableheading>
				<th scope="col" class="rounded-company" width="10%" rowspan=2><%=bundle.getString("label.usernotutil.slno")%></th>
				<th scope="col" class="rounded" width="30%" rowspan=2><%=bundle.getString("label.usernotutil.sectionname")%></th>
				<th scope="col" class="rounded" width="20%" colspan=2><%=bundle.getString("label.usernotutil.totalstudents")%></th>
				<th scope="col" class="rounded-q4" width="20%"  colspan=2><%=bundle.getString("label.usernotutil.cardissued")%></th>
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
									String sectionschedid=hashmap.get("sectionscheduleid")+"";
									String sectionname=hashmap.get("sectionname")+"";
									String groupname=hashmap.get("groupname")+"";
									if(!groupname.equals("null"))
									standardname=standardname+" -"+groupname;
									String totalcount=hashmap.get("totalcount")+"";
									String issuedcount_temp=hashmap.get("utilcount")+"";
									
									int usernotutil = Integer.parseInt(totalcount) - Integer.parseInt(issuedcount_temp);
									
									issuedcount_temp = usernotutil+"";									
									
									String sectioncount=hashmap.get("sectioncount")+"";
									Totalstudent +=	Integer.parseInt(totalcount);	
									TotalIssuedcount +=	Integer.parseInt(issuedcount_temp);	

									if(!issuedcount_temp.equals("null") && !issuedcount_temp.equals("0"))
									out.print("<tr  ><td>"+i+"</td><td align=left><a href='#totalcounthref' name='totalcounthref' sex='T' sectionname='"+sectionname+"' sectionscheduleid='"+sectionschedid+"' onclick='loadStudent(this)'>"+sectionname+"</a>");
									else
									out.print("<tr   ><td>"+i+"</td><td align=left>"+sectionname+"");

									out.print("</td>");
									
									if(!totalcount.equals("null") && !totalcount.equals("0"))
									{
									out.println("<td colspan=2><font size='4'>"+totalcount+"</font></td>");
									}
									else
									{
										out.println("<td colspan=2>"+totalcount+"</td>");

									}
									if(!issuedcount_temp.equals("null") && !issuedcount_temp.equals("0"))
									{
									out.println("<td colspan=2><font size='4'>"+issuedcount_temp+"</font></td>");
									}
									else
									{
										out.println("<td colspan=2>"+issuedcount_temp+"</td>");

									}

									out.println("</tr>");
								}
								}
							else
							{
								out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>"+bundle.getString("label.usernotutil.datanotfound")+"</font></td></tr>");
								//out.print("<tr><td colspan='6' align=center>"+bundle.getString("label.schedule.datanotfound")+"</td></tr>");

							}
						%>
		</tbody>
		<tfoot>
		<tr>
			<td colspan='6'><hr></td>
		</tr>
			<tr>
				<td colspan='2' class=tablebold align=right><%=bundle.getString("label.usernotutil.total")%>:</td><td  class=tablebold colspan=2 ><font size="4"><%=Totalstudent %></font></td><td   class=tablebold colspan=2><font size="4"><%=TotalIssuedcount %></font></td>
			</tr>
		</tfoot>
		</table>

		 <a href="#" class="bt_blue" onclick='backfun()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.usernotutil.back")%></strong><span class="bt_blue_r"></span></a>
		</form>		

    </div><!-- end of right content--> 


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>

</html>