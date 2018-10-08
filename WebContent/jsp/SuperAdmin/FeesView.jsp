<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>
<script type="text/javascript">
function loadStandard()
{
document.Standard_Form.submit();
}
function Backfun()
{
document.Standard_Form.action="<%=request.getContextPath()%>/jsp/SuperAdmin/Fees_Brd_List.jsp";
document.Standard_Form.submit();
}
function loadSection(obj)
{
//document.Standard_Form.boardname.value=document.Standard_Form.board.options[document.Standard_Form.board.options.selectedIndex].text;
document.Standard_Form.boardname.value=document.Standard_Form.req_boardname.value;
var standardscheduleid=obj.getAttribute("standardscheduleid");
document.Standard_Form.standardscheduleid.value=standardscheduleid;
document.Standard_Form.standardname.value=obj.getAttribute("standardname");
document.Standard_Form.action="./SectionView.jsp";
document.Standard_Form.submit();
}

function loadStudent(obj)
{
document.Standard_Form.boardname.value=document.Standard_Form.req_boardname.value;
document.Standard_Form.standardscheduleid.value=obj.getAttribute("standardscheduleid");
document.Standard_Form.sex.value=obj.getAttribute("sex");
document.Standard_Form.standardname.value=obj.getAttribute("standardname");
document.Standard_Form.action="./StandardWiseStudentView.jsp";
document.Standard_Form.submit();
}
function printfun()
	{
		window.open("../Reports/PrintPreviewConsolidatedStudentList.jsp?&req_sessionname="+document.Standard_Form.req_sessionname.value+"&req_sessionid="+document.Standard_Form.req_sessionid.value+"&req_sessionstatus="+document.Standard_Form.req_sessionstatus.value+"&req_boardname="+document.Standard_Form.board.options[document.Standard_Form.board.options.selectedIndex].text+"&req_boardid="+document.Standard_Form.board.value+"","Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=650,scrollbars=1;")
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

<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,java.text.NumberFormat,java.util.Locale"%>
<%@ page language="java" import="com.iGrandee.Application.ApplicationQuery,com.iGrandee.Registration.StaffRegistrationQuery,com.iGrandee.Prinicipal.PrinicipalQuery,com.iGrandee.Common.DateTime"%>
<%

		PrinicipalQuery prinicipal			= new PrinicipalQuery();
		StaffRegistrationQuery staffquery=new StaffRegistrationQuery();
		ApplicationQuery applicationQuery=new ApplicationQuery();
		
		HashMap	hashmap				= null;
		//String instituteid			= (String)session.getValue("instituteid");
		String instituteid			= request.getParameter("req_instituteid");
		
		ArrayList BoardList			= prinicipal.loadboard(instituteid);
		ArrayList StandardList		= null;
		String sessionid=null;
		String sessionname=null;
		String rootlabel="";
		String	status  = "A";
		if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R"))
			status = "A','D','C";
		 	
//out.print("usercategory-->"+session.getValue("usercategory"));		
		//if(((session.getValue("userrolename")+"").toLowerCase()).startsWith("admin"))
			//{
				   sessionid=request.getParameter("req_sessionid")+"";
				   sessionname=request.getParameter("req_sessionname")+"";
				   rootlabel=bundle.getString("label.reports.reportsconsolidatedstudentlist");

			//}
			//else
			//{
				//sessionid=session.getValue("sessionid")+"";
				//sessionname=session.getValue("sessionname")+"";
				//rootlabel=bundle.getString("label.reports.standardstandardlist");

			//}
		
		String boardid=request.getParameter("req_boardid")+"";
		if(!sessionid.equals("null") && !boardid.equals("null")&& !sessionid.equals("0") && !boardid.equals("0"))
		{
			StandardList=applicationQuery.loadstandardfeeswithstatus(boardid,sessionid,instituteid,status);   
		}    
		String today				= DateTime.showTime("calendar");
%>
<br>
        <h2><%=staffquery.fieldValue("institutename","institution","instituteid",instituteid,"status",instituteid)%> / <%=bundle.getString("label.superadmin.feeslistrootpath") %></h2>

<form name="Standard_Form" action="" method="post">
<input type="hidden" name="todaydate" value="<%=today %>">
<input type="hidden" name="standardscheduleid" value="">
<input type="hidden" name="sex" value="">
<input type="hidden" name="hiddensession" value="<%=sessionid%>">
<input type="hidden" name="hiddenboard" value="<%=boardid%>">
<input type="hidden" name="standardname" value="">
<input type="hidden" name="req_sessionid" value="<%=sessionid %>">
<input type="hidden" name="req_sessionname" value="<%=sessionname%>">
<input type="hidden" name="boardname" value="">

<input type=hidden name=req_boardname value="<%=request.getParameter("req_boardname") %>">
<input type=hidden name=req_boardid value="<%=request.getParameter("req_boardid") %>">
<input type=hidden name=req_sessionstatus value="<%=request.getParameter("req_sessionstatus") %>">


<input type="hidden" name="sectionname" value="">
<input type="hidden" name="sessioninstituteid" value="<%=instituteid %>">
<input type=hidden name=req_instituteid value="<%=request.getParameter("req_instituteid") %>">		
		<table width='80%' id=rounded-corner align='center' border='0' >
			<thead>
			<tr>
				
				<th scope="col" class="rounded-company" width="90%" >Standard List</th>
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
					<%=request.getParameter("req_boardname") %>
					<script>
					//if(document.Standard_Form.hiddenboard.value!="null" && document.Standard_Form.hiddenboard.value!="0" && document.Standard_Form.hiddensession.value!="0")
					///{
						//for(var i=0;i<document.Standard_Form.board.length;i++)
						//{
						//if(document.Standard_Form.board.options[i].value==document.Standard_Form.hiddenboard.value)
						//{
							//document.Standard_Form.board.options[i].selected=true;
						//}
						//}
					//}
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
				<th scope="col" class="rounded" width="10%" rowspan=2><%=bundle.getString("label.schedule.slno")%></th>
				<th scope="col" class="rounded" width="30%" rowspan=2><%=bundle.getString("label.schedule.standardname")%></th>
				<th scope="col" class="rounded" width="20%" rowspan=2><%=bundle.getString("label.common.totalamount")%></th>
				<th scope="col" class="rounded" width="20%" colspan=2><%=bundle.getString("label.common.paidamount")%></th>
				<th scope="col" class="rounded" width="20%"  rowspan=2><%=bundle.getString("label.common.pendingamount")%></th>
			</tr>
			</thead>
		
		<tbody>
		<%
		int Totalstudent=0;
		int Totalamount=0;
		int collectedAmount=0;
		int amounttobeCollect=0;
		int pendtobeCollect=0;
		int totalPendamount=0;
		
		
		String totamounttobeCollectCurrency=null;
		String totcollectedAmountCurrency=null;
		String totpendtobeCollectCurrency=null;
		
		java.util.ResourceBundle serBundle 	= 	java.util.ResourceBundle.getBundle("resources.serversetup");
	    Locale localcurrency = new Locale(serBundle.getString("language"), serBundle.getString("code"));
		
		
							if(StandardList != null && StandardList.size()>0)
								{
								for(int y=0,i=1;y<StandardList.size();y++,i++){
									String amounttobeCollectCurrency=null;
									String collectedAmountCurrency=null;
									String pendtobeCollectCurrency=null;									
									hashmap		= (HashMap)StandardList.get(y);
									String standardscheduleid=hashmap.get("standardscheduleid")+"";
									String standardname=hashmap.get("standardname")+"";
									String groupname=hashmap.get("groupname")+"";
									if(!groupname.equals("null"))
									standardname=standardname+" -"+groupname;
									String collectedamount=hashmap.get("collectedamount")+"";
									String totalcount=hashmap.get("totalcount")+"";
									//String femalecount=hashmap.get("collectedamount")+"";
									String totalamount=hashmap.get("totalamount")+"";
									
									if(collectedamount.equals("null"))
										collectedamount = "0";
									else
										collectedamount = collectedamount;
									
									if(totalamount.equals("null"))
										totalamount = "0";
									else
										totalamount = totalamount;
									
									
									amounttobeCollect = Integer.parseInt(totalcount) * Integer.parseInt(totalamount);
									pendtobeCollect	  = amounttobeCollect - Integer.parseInt(collectedamount);
									
									Totalstudent +=	Integer.parseInt(totalcount);						
									//Totalamount +=Integer.parseInt(totalamount);
									Totalamount += amounttobeCollect;
									totalPendamount+=pendtobeCollect;
									collectedAmount +=Integer.parseInt(collectedamount);

								    Long amounttobeCollectObj 					= Long.valueOf(amounttobeCollect); 
									NumberFormat amounttobeCollectFormat 		= NumberFormat.getCurrencyInstance(localcurrency);
									amounttobeCollectCurrency 					= amounttobeCollectFormat.format(amounttobeCollectObj);

								    Long collectedAmountObj 					= Long.valueOf(collectedamount); 
									NumberFormat collectedAmountFormat 		= NumberFormat.getCurrencyInstance(localcurrency);
									collectedAmountCurrency 					= collectedAmountFormat.format(collectedAmountObj);

								    Long pendtobeCollectObj 					= Long.valueOf(pendtobeCollect); 
									NumberFormat pendtobeCollectFormat 		= NumberFormat.getCurrencyInstance(localcurrency);
									pendtobeCollectCurrency 					= pendtobeCollectFormat.format(pendtobeCollectObj);
									
							
									out.print("<tr align=center  ><td>"+i+"</td><td align=left>"+standardname+"</td><td align=right>"+amounttobeCollectCurrency);
									//if(!totalamount.equals("null") && !totalamount.equals("0"))
										//out.println("<a href='#sectionhref' name='sectionhref' standardname='"+standardname+"'  standardscheduleid='"+standardscheduleid+"' onclick='loadSection(this)'>[ "+totalamount+" ]</a>");
									//else
										//out.println(totalamount);
									out.print("</td>");
									out.println("<td colspan=2 align=right>"+collectedAmountCurrency+"</td>");
									out.println("<td align=right>"+pendtobeCollectCurrency+"</td>");
									
									//if(!collectedamount.equals("null") && !collectedamount.equals("0"))
										//out.println("<td colspan=2><a href='#collectedamounthref' name='collectedamounthref' sex='M' standardname='"+standardname+"' 		standardscheduleid='"+standardscheduleid+"' onclick='loadStudent(this)'>[ "+collectedamount+" ]</a></td>");
									//else
										//out.println("<td colspan=2>"+collectedamount+"</td>");
									//if(!femalecount.equals("null") && !femalecount.equals("0"))
										//out.println("<td><a href='#femalecounthref' name='femalecounthref' sex='F' standardname='"+standardname+"' 	standardscheduleid='"+standardscheduleid+"' onclick='loadStudent(this)'>[ "+femalecount+" ]</a></td>");
									//else
										//out.println("<td>"+femalecount+"</td>");
									//if(!totalcount.equals("null") && !totalcount.equals("0"))
										//out.println("<td><a href='#totalcounthref' name='totalcounthref' sex='T' standardname='"+standardname+"' 	standardscheduleid='"+standardscheduleid+"' onclick='loadStudent(this)'>[ "+totalcount+" ]</a></td>");
									//else
										//out.println("<td>"+totalcount+"</td>");
									out.print("</tr>");
								}

							    Long totamounttobeCollectObj 					= Long.valueOf(Totalamount); 
								NumberFormat totamounttobeCollectFormat 		= NumberFormat.getCurrencyInstance(localcurrency);
								totamounttobeCollectCurrency 					= totamounttobeCollectFormat.format(totamounttobeCollectObj);

							    Long totcollectedAmountObj 					= Long.valueOf(collectedAmount); 
								NumberFormat totcollectedAmountFormat 		= NumberFormat.getCurrencyInstance(localcurrency);
								totcollectedAmountCurrency 					= totcollectedAmountFormat.format(totcollectedAmountObj);

							    Long totalPendamountObj 					= Long.valueOf(totalPendamount); 
								NumberFormat totalPendamountFormat 		= NumberFormat.getCurrencyInstance(localcurrency);
								totpendtobeCollectCurrency 					= totalPendamountFormat.format(totalPendamountObj);
								
								
								}
							else
							{
								out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
								//out.print("<tr><td colspan='6' class=tablebold align=center><font color=red>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");

							}
						%>
							<tr >
									<td colspan='6'><hr></td>
							</tr>					
						<tr  class=tablebold>
						
						<td colspan='2' align=center><%=bundle.getString("label.common.total")%>:</td><td  align=right><%=totamounttobeCollectCurrency %></td><td align=right colspan=2><%=totcollectedAmountCurrency %></td><td  align=right class=tablebold><%=totpendtobeCollectCurrency %></td>
					</tr>
					
		</tbody>
		<tfoot>
		<tr >
				<td colspan='6'>&nbsp;</td>
			</tr>
			
		</tfoot>
		</table>
		<% if(((session.getValue("userrolename")+"").toLowerCase()).startsWith("admin"))
		{%>
		
						
						
						<a href="#" class="bt_blue" onclick='Backfun()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a>
		<%if(StandardList != null && StandardList.size()>0)
		{%>
						<!-- <a href="#" class="bt_green" onclick='printfun()'><span class="bt_green_lft"></span><strong><=bundle.getString("label.schedule.Print")%></strong><span class="bt_green_r"></span></a>-->
		<%} }%>

		</form>		

    </div><!-- end of right content--> 


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>