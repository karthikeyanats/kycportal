<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />


<script type="text/javascript">
function loadStandard()
{
document.Section_Form.submit();
}
function backfun()
{
document.Section_Form.action="./CombCommunityStdView.jsp";
document.Section_Form.submit();
}
function loadStudent(obj)
{
document.Section_Form.sectionscheduleid.value=obj.getAttribute("sectionscheduleid");
document.Section_Form.operation.value=obj.getAttribute("operation");
	//if(obj.getAttribute("operation")=="community"){
	//document.Section_Form.communityid.value=obj.getAttribute("communityid");
	//document.Section_Form.communityname.value=obj.getAttribute("communityname");
	//}
document.Section_Form.sectionname.value=obj.getAttribute("sectionname");
document.Section_Form.action="./CombCommunitySecWiseStudentView.jsp";
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

	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>
    <div class="left_content">

    </div>

    <div class="right_content">

<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Prinicipal.PrinicipalQuery,com.iGrandee.MasterEntries.Community.CommunityQuery,com.iGrandee.Report.Reports,com.iGrandee.Common.DateTime"%>
<%

		PrinicipalQuery prinicipal			= new PrinicipalQuery();
		CommunityQuery communityQuery			= new CommunityQuery();
		Reports reportsQuery			= new Reports();


		HashMap	hashmap				= null;
		String instituteid			= (String)session.getValue("instituteid");
		//ArrayList sessionList		= prinicipal.loadyearofsession(instituteid);
		//ArrayList BoardList			= prinicipal.loadboard(instituteid);
		//ArrayList CommunityList = communityQuery.loadCommunityList(instituteid);
		//String communityid = "";
		//String communityname = "";
		//String communityidtemp = "";
		//String communitynametemp = "";
		
		ArrayList StandardList		= null;
		String standardname=request.getParameter("standardname")+"";
		String standardscheduleid=request.getParameter("standardscheduleid")+"";
		String communityid=request.getParameter("communityid")+"";
		String boardid=request.getParameter("hiddenboard")+"";
		String boardname=request.getParameter("boardname")+"";

		String sessionid=null;//request.getParameter("hiddenboard")+"";
		String sessionname=null;
		String rootlabel="";
		String	status  = "A";
		if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R"))
		 	status = "A','D','C";
		if(((session.getValue("userrolename")+"").toLowerCase()).startsWith("admin"))
		{
			   sessionid=request.getParameter("req_sessionid")+"";
			   sessionname=request.getParameter("req_sessionname")+"";
			   rootlabel=bundle.getString("label.reports.reportscombcommunitystandardwise");

		}
		else
		{
			sessionid=session.getValue("sessionid")+"";
			sessionname=session.getValue("sessionname")+"";
			rootlabel=bundle.getString("label.reports.standardstandardliststandardwise");

		}

		//String today				= DateTime.showTime("calendar");
		//out.println(StandardList);
%>
    <h2><%=rootlabel %> </h2>

<form name="Section_Form" action="" method="post">

						<input type="hidden" name="standardscheduleid" value="<%=standardscheduleid %>">
						<input type="hidden" name="session" value="<%=sessionid%>">
						<input type="hidden" name="board" value="<%=boardid%>">
						<input type="hidden" name="standardname" value="<%=standardname %>">
						<input type="hidden" name="sectionname" value="">
						<input type="hidden" name="sectionscheduleid" value="">
						<input type="hidden" name="operation" value="">
						<input type="hidden" name="communityid" value="<%=request.getParameter("communityid")%>">
						<input type="hidden" name="communityname" value="<%=request.getParameter("communityname") %>">						
						<input type="hidden" name="sessioninstituteid" value="<%=instituteid %>">
						<input type="hidden" name="req_sessionid" value="<%=sessionid %>">
						<input type="hidden" name="req_sessionname" value="<%=sessionname%>">
						<input type="hidden" name="boardname" value="<%=boardname%>">
						<input type=hidden name=req_sessionstatus value="<%=request.getParameter("req_sessionstatus") %>">
						
			<table id="rounded-corner" border=0 summary="Department List"
							width="100%">
							<thead>
								<tr>
									<th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.schedule.selectedinfo")%></th>
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
    				<%=bundle.getString("label.schedule.academicyear")%>
    				</td>
    			
	    			<td class=tablebold>:</td>
	    			<td>
	    			<%=sessionname%>
	    			</td>
	    			
    				<td  class=tablebold align=right>
    				<%=bundle.getString("label.schedule.board")%>
    				</td>
    			<td class=tablebold>:</td>
	    			<td>
	    			<%=boardname%>
	    			</td>
    			</tr>
    			<tr>
	    			
	    			<td  class=tablebold width=20%>
	    			<%=bundle.getString("label.schedule.standardname")%>
	    			</td>
	    			<td class=tablebold>:</td>
	    			<td colspan=5>
	    			<%=standardname%>
	    			</td>
	    			
    			
    			</tr>
    			</table>
    			</td></tr></tbody></table>
    			<br>

					<table   align='center' border='0' id=rounded-corner1 bordercolor=white width="100%" cellpadding=3 cellspacing=3>
						<thead>
						<tr class=tableheading>
							<th scope="col" class="rounded" width="5%" rowspan=2><%=bundle.getString("label.schedule.slno")%></th>
							<th scope="col" class="rounded" width="30%" rowspan=2><%=bundle.getString("label.schedule.section")%></th>
							<th scope="col" class="rounded" width="5%" rowspan=2><%=bundle.getString("label.reports.totalstudents")%></th>
							<%
							out.print("<th scope='col' class='rounded' width='60%' colspan='3'>"+request.getParameter("communityname")+"</th>");
							out.print("<tr class=tableheading><th scope='col' class='rounded' width='20%'>"+bundle.getString("label.reports.exservice")+"</th>");
							out.print("<th scope='col' class='rounded' width='20%'>"+bundle.getString("label.reports.phychal")+"</th>");
							out.print("<th scope='col' class='rounded' width='20%'>Both</th>");

							if(!sessionid.equals("null") && !boardid.equals("null")&& !sessionid.equals("0") && !boardid.equals("0"))
							{
								StandardList=reportsQuery.loadcombcommunitysectionforview(standardscheduleid,status,communityid);   
							}
								

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
									//String communityId[]=null;
									//String communityName[]=null;
									
									//String sectioncount=hashmap.get("sectioncount")+"";
									//Totalstudent +=	Integer.parseInt(totalcount);				
									
									out.print("<tr align=center  ><td>"+i+"</td><td align=left>"+sectionname+"");
									out.print("</td>");
									//if(!totalcount.equals("null") && !totalcount.equals("0"))
										//out.println("<td><a href='#totalcounthref' name='totalcounthref' sex='T' sectionname='"+sectionname+"' sectionscheduleid='"+sectionschedid+"' onclick='loadStudent(this)'>[ "+totalcount+" ]</a></td>");
									//else
										out.println("<td>"+totalcount+"</td>");

										String exservicecount=hashmap.get("exsercount")+"";		
										String phychalcount=hashmap.get("phycount")+"";
										String bothcount=hashmap.get("bothcount")+"";
										
										if(!exservicecount.equals("null") && !exservicecount.equals("0"))
											out.println("<td><a href='#exservicecounthref' name='exservicecounthref' operation='exserviceman' sectionname='"+sectionname+"' sectionscheduleid='"+sectionschedid+"' onclick='loadStudent(this)'>[ "+exservicecount+" ]</a></td>");
										else
											out.println("<td>"+exservicecount+"</td>");
										if(!phychalcount.equals("null") && !phychalcount.equals("0"))
											out.println("<td><a href='#phychalcounthref' name='phychalcounthref' operation='phychal' sectionname='"+sectionname+"' sectionscheduleid='"+sectionschedid+"' onclick='loadStudent(this)'>[ "+phychalcount+" ]</a></td>");
										else
											out.println("<td>"+phychalcount+"</td>");										
										if(!bothcount.equals("null") && !bothcount.equals("0"))
											out.println("<td><a href='#bothcounthref' name='bothcounthref' operation='both' sectionname='"+sectionname+"' sectionscheduleid='"+sectionschedid+"' onclick='loadStudent(this)'>[ "+bothcount+" ]</a></td>");
										else
											out.println("<td>"+bothcount+"</td>");
							
					
									out.println("</tr>");
								}
								}
								else
								{
									out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");

								}								
								%>
		</tbody>
		<tfoot>

		  <tr >
				<td colspan='6'>&nbsp;</td>
			</tr>

		</tfoot>
		</table>

		 <a href="#" class="bt_blue" onclick='backfun()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a>
		</form>		

    </div><!-- end of right content--> 


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>

</html>