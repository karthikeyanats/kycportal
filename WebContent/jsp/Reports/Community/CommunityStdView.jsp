<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.community.alllisttitle")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>
<script type="text/javascript">
function loadStandard()
{
document.Standard_Form.submit();
}

function combView()
{
document.Standard_Form.action="./CombCommunityStdView.jsp";
document.Standard_Form.submit();
}

function Backfun()
{
document.Standard_Form.action="<%=request.getContextPath()%>/jsp/Reports/ReportIndexView.jsp";
document.Standard_Form.submit();
}
function loadSection(obj)
{
document.Standard_Form.boardname.value=document.Standard_Form.board.options[document.Standard_Form.board.options.selectedIndex].text;

var standardscheduleid=obj.getAttribute("standardscheduleid");
document.Standard_Form.standardscheduleid.value=standardscheduleid;
document.Standard_Form.standardname.value=obj.getAttribute("standardname");
document.Standard_Form.action="./CommunitySecView.jsp";
document.Standard_Form.submit();
}

function loadStudent(obj)
{
document.Standard_Form.boardname.value=document.Standard_Form.board.options[document.Standard_Form.board.options.selectedIndex].text;
document.Standard_Form.standardscheduleid.value=obj.getAttribute("standardscheduleid");
document.Standard_Form.operation.value=obj.getAttribute("operation");
	if(obj.getAttribute("operation")=="community"){
	document.Standard_Form.communityid.value=obj.getAttribute("communityid");
	document.Standard_Form.communityname.value=obj.getAttribute("communityname");
	}
	
document.Standard_Form.standardname.value=obj.getAttribute("standardname");
document.Standard_Form.action="./CommunityStdWiseStudentView.jsp";
document.Standard_Form.submit();
}
function printfun()
	{
		window.open("./PrintPreviewCommunityStudentList.jsp?&req_sessionname="+document.Standard_Form.req_sessionname.value+"&req_sessionid="+document.Standard_Form.req_sessionid.value+"&req_sessionstatus="+document.Standard_Form.req_sessionstatus.value+"&req_boardname="+document.Standard_Form.board.options[document.Standard_Form.board.options.selectedIndex].text+"&req_boardid="+document.Standard_Form.board.value+"","Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=650,scrollbars=1;")
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
<%@ page language="java" import="com.iGrandee.Prinicipal.PrinicipalQuery,com.iGrandee.MasterEntries.Community.CommunityQuery,com.iGrandee.Report.Reports,com.iGrandee.Common.DateTime"%>
<%

		PrinicipalQuery prinicipal			= new PrinicipalQuery();
		CommunityQuery communityQuery			= new CommunityQuery();
		Reports reportsQuery			= new Reports();

		HashMap	hashmap				= null;
		String instituteid			= (String)session.getValue("instituteid");
		ArrayList BoardList			= prinicipal.loadboard(instituteid);
		ArrayList CommunityList = communityQuery.loadCommunity(instituteid);
		String communityid = "";
		String communityname = "";
		String communityidtemp = "";
		String communitynametemp = "";
		int communityCount			= 0;
		
		if(CommunityList!=null && CommunityList.size()>0)
			communityCount			= CommunityList.size();
			
		ArrayList StandardList		= null;
		String sessionid=null;
		String sessionname=null;
		String rootlabel="";
		String	status  = "A";
		if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R"))
			status = "A','D','C";
		 	
		
		if(((session.getValue("userrolename")+"").toLowerCase()).startsWith("admin"))
			{
				   sessionid=request.getParameter("req_sessionid")+"";
				   sessionname=request.getParameter("req_sessionname")+"";
				   rootlabel=bundle.getString("label.reports.reportscommunitystudentlist");

			}
			else
			{
				sessionid=session.getValue("sessionid")+"";
				sessionname=session.getValue("sessionname")+"";
				rootlabel=bundle.getString("label.reports.standardstandardlist");

			}
		
		String boardid=request.getParameter("board")+"";
    
		String today				= DateTime.showTime("calendar");
%>
    <h2><%=rootlabel%></h2>

<form name="Standard_Form" action="" method="post">
<input type="hidden" name="todaydate" value="<%=today %>">
<input type="hidden" name="standardscheduleid" value="">
<input type="hidden" name="operation" value="">
<input type="hidden" name="communityid" value="">
<input type="hidden" name="communityname" value="">
<input type="hidden" name="hiddensession" value="<%=sessionid%>">
<input type="hidden" name="hiddenboard" value="<%=boardid%>">
<input type="hidden" name="standardname" value="">
<input type="hidden" name="req_sessionid" value="<%=sessionid %>">
<input type="hidden" name="req_sessionname" value="<%=sessionname%>">
<input type="hidden" name="boardname" value="">
<input type=hidden name=req_sessionstatus value="<%=request.getParameter("req_sessionstatus") %>">


<input type="hidden" name="sectionname" value="">
<input type="hidden" name="sessioninstituteid" value="<%=instituteid %>">
		
		<table width='80%' id=rounded-corner align='center' border='0' >
			<thead>
			<tr>
				
				<th scope="col" class="rounded-company" width="90%" >Community List</th>
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
				<td width='20%' class='tablebold'><%=bundle.getString("label.schedule.academicyear")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='40%'>
					<%=sessionname %>
				</td>
				<td width='5%' class='tablebold'><%=bundle.getString("label.schedule.board")%></td>
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
					if(document.Standard_Form.hiddenboard.value!="null" && document.Standard_Form.hiddenboard.value!="0" && document.Standard_Form.hiddensession.value!="0")
					{
						for(var i=0;i<document.Standard_Form.board.length;i++)
						{
						if(document.Standard_Form.board.options[i].value==document.Standard_Form.hiddenboard.value)
						{
							document.Standard_Form.board.options[i].selected=true;
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
		<table   align='center' border='0' id=rounded-corner1 bordercolor=white width="100%" cellpadding=3 cellspacing=3>
			<thead>
			<tr class=tableheading>
				<th scope="col" class="rounded" width="5%" rowspan=2><%=bundle.getString("label.schedule.slno")%></th>
				<th scope="col" class="rounded" width="30%" rowspan=2><%=bundle.getString("label.schedule.standardname")%></th>
				<th scope="col" class="rounded" width="5%" rowspan=2><%=bundle.getString("label.reports.totalstudents")%></th>
				<th scope="col" class="rounded" width="40%" colspan=<%=communityCount%>><%=bundle.getString("label.reports.community")%></th>
				<%-- <th scope="col" class="rounded" width="10%"  rowspan=2><%=bundle.getString("label.reports.exservice")%></th>
				<th scope="col" class="rounded" width="10%"  rowspan=2><%=bundle.getString("label.reports.phychal")%></th> --%>
				<% 
			   	 if(CommunityList!=null && CommunityList.size()>0)
					{
			   		 int percent = 40/CommunityList.size();
					 for (int i = 0; i < CommunityList.size(); i++) {
					
						HashMap CommunityListMap=(HashMap)CommunityList.get(i);
						communityid      = (String)CommunityListMap.get("communityid");
						communityname      = (String)CommunityListMap.get("communityname");
						
						if(i==0)
							out.print("<tr class=tableheading><th scope='col' class='rounded' width='"+percent+"%'>"+communityname+"</th>");
						else
							out.print("<th scope='col' class='rounded' width='"+percent+"%'>"+communityname+"</th>");
					 }
					}				
				%>
				  
				  <!--  <tr class=tableheading>
				  <th scope="col" class="rounded" width="20%" >BC</th>
				<th scope="col" class="rounded" width="20%" >SC</th> -->
			</tr>
			</thead>
		
		<tbody>
		<%
		int Totalstudent=0;
		int Totalmalestudent=0;
		int Totalfemalestudent=0;
		
		
			StandardList=reportsQuery.loadcommunitystandard(boardid,sessionid,instituteid,status);    
		int count=0;
		HashMap hashMap2= null;

							if(StandardList != null && StandardList.size()>0) 
								{
								
								for(int y=0,i=1;y<StandardList.size();y=y+communityCount){
									hashmap		= (HashMap)StandardList.get(y);
									count++;
									String standardscheduleid=hashmap.get("standardscheduleid")+"";
									String standardname=hashmap.get("standardname")+"";
									String groupname=hashmap.get("groupname")+"";
									if(!groupname.equals("null"))
									standardname=standardname+" -"+groupname;
									
									String totalcount=hashmap.get("totalcount")+"";
									
								out.print("<tr align=center  ><td>"+count+"</td>");
									
									
									for(int k=y;k<y+communityCount;k++){
										
										if(StandardList.size()>k)
										hashMap2	= (HashMap)StandardList.get(k);
										
										if(k==y)
										out.print("<td align=left><a href='#sectionhref' name='sectionhref' standardname='"+standardname+"'  standardscheduleid='"+standardscheduleid+"' onclick='loadSection(this)'>"+standardname+"</a></td><td>"+hashmap.get("totalcount1")+"</td>");

										
										
										String totalcounts=hashMap2.get("totalcount")+"";
										
										out.println("<td><a href='#religioncounthref' name='religioncounthref' operation='community' comunityname='"+hashMap2.get("comunityanme")+"' communityid='"+hashMap2.get("communityid")+"' standardname='"+standardname+"' standardscheduleid='"+standardscheduleid+"' onclick='loadStudent(this)'>[ "+totalcounts+" ]</a></td>");
										
									} 
									
									out.print("</tr>");
								}
								}
							else
							{
								out.println("<tr align='center' class='tablebold'><td colspan='"+(CommunityList.size()+5)+"'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
								//out.print("<tr><td colspan='7' class=tablebold align=center><font color=red>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");

							}
						%>
							
							<!--  <tr >
									<td colspan='7'><hr></td>
							</tr>					
						<tr  class=tablebold>
						
						<td colspan='2'><%=bundle.getString("label.reports.totalnoofstudents")%>:</td><td ></td><td align=center><%=Totalmalestudent %></td><td align=center><%=Totalfemalestudent %></td><td  align=center class=tablebold><%=Totalstudent %></td>
					</tr>-->
					
		</tbody>
		<tfoot>
		<tr >
				<td colspan='7'>&nbsp;</td>
			</tr>
			
		</tfoot>
		</table>
		<% if(((session.getValue("userrolename")+"").toLowerCase()).startsWith("admin"))
		{%>
		
						
						
						<a href="#" class="bt_blue" onclick='Backfun()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a>

		<%if(StandardList != null && StandardList.size()>0)
		{%>
						<a href="#" class="bt_blue" onclick='combView()'><span class="bt_blue_lft"></span><strong>Combined View</strong><span class="bt_blue_r"></span></a>
						<a href="#" class="bt_green" onclick='printfun()'><span class="bt_green_lft"></span><strong><%=bundle.getString("label.schedule.Print")%></strong><span class="bt_green_r"></span></a>
		<%} }%>

		</form>		

    </div><!-- end of right content--> 


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>

</html>