<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=bundle.getString("label.product.name")%> -  Standwise Report| Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>

<script type="text/javascript">

function checkamountradio()
{
	for(var i=0;i<document.ApplicantSearch.amountradio.length;i++)
	{
		if(document.ApplicantSearch.amountradio[i].checked)
		{
			if(document.ApplicantSearch.amountradio[i].value=="today")
			{
				document.ApplicantSearch.todaydate.disabled=false;
				document.ApplicantSearch.appFromdate.disabled=true;
				document.ApplicantSearch.appTodate.disabled=true;
				document.ApplicantSearch.fromdate.disabled=true;
				document.ApplicantSearch.todate.disabled=true;
			}
			else if(document.ApplicantSearch.amountradio[i].value=="fromtodate")
			{
				document.ApplicantSearch.todaydate.disabled=true;
				document.ApplicantSearch.appFromdate.disabled=false;
				document.ApplicantSearch.appTodate.disabled=false;
				document.ApplicantSearch.fromdate.disabled=false;
				document.ApplicantSearch.todate.disabled=false;	
			}
		}
	}
}
function viewReport()
{
		if(check_ForParticularElements(document.ApplicantSearch.sessionname,"select",document.ApplicantSearch.boardname,"select")){
				var sta=false;
				for(var i=0;i<document.ApplicantSearch.amountradio.length;i++)
				{
					if(document.ApplicantSearch.amountradio[i].checked)
					{
						sta=true;
					}
					
				}
				if(document.ApplicantSearch.amountradio[1].checked)
				{
					if(!check_ForParticularElements(document.ApplicantSearch.appFromdate,"text",document.ApplicantSearch.appTodate,"text"))
					{
						return false;
					}
				}
				/*else if(document.ApplicantSearch.amountradio[2].checked)
				{
					if(!check_ForParticularElements(document.ApplicantSearch.appdate,"text"))
					{
						return false;
					}
				}*/
				if(sta)
					{
						document.ApplicantSearch.req_sessionid.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value;
						document.ApplicantSearch.req_sessionname.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].text;
						document.ApplicantSearch.req_sessionstatus.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].getAttribute("status");
						document.ApplicantSearch.req_boardid.value  =document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].value;
						document.ApplicantSearch.req_boardname.value  =document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].text;
						document.ApplicantSearch.action="AmountCollectionReport.jsp";
						document.ApplicantSearch.submit();
					}
				else
					{
						alert("Select Any One Date Option");
						return false;
					}
				
			}
		
}

function goBack()
{
		document.ApplicantSearch.action="AmountCollection.jsp";
		document.ApplicantSearch.submit();
}
</script>
</head>
<body>
<form name="ApplicantSearch" action="" method="post">
<input type=hidden name=req_sessionid>
<input type=hidden name=req_sessionname>
<input type=hidden name=req_sessionstatus>
<input type=hidden name=req_boardid>
<input type=hidden name=req_boardname>


<div id="main_container">
	<div class="header">
<%@ include file="../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<%@ include file="../include/header.jsp" %>


    <div class="center_content">


    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.reports.finanicialreportstandardwise")%></h2>
   <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.ApplicationQuery,com.iGrandee.Common.DateTime"%>
  
	<%
	String today				= DateTime.showTime("calendar");

    try
    {	
    com.iGrandee.Application.ApplicationQuery  applicationQuery = new com.iGrandee.Application.ApplicationQuery();	
	com.iGrandee.MasterEntries.Standard.StandardQuery  standardQuery = new com.iGrandee.MasterEntries.Standard.StandardQuery();
		ArrayList valueList = null;
	
	    String instituteid = null;
	    ArrayList BoardList = null;

	 		
			//String temp=applicationQuery.receiptNo();

	    	  instituteid = (String)session.getValue("instituteid");
	    	  ArrayList yearList = applicationQuery.listYearofSession(instituteid);
	    	  BoardList = standardQuery.listBoard(instituteid);
	    
		//out.println("temp-->"+temp);
	%>
<input type="hidden" name="todaydate" value="<%=today %>">

<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="40%"><%=bundle.getString("label.schedule.standardwisereport")%></th>
            <th scope="col" class="rounded-q4" width="10%"><font color=red>*</font> <%=bundle.getString("label.applicationissue.MandatoryFields")%></th>
            
        </tr>
    </thead>
 <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
	<tr>
	<td class=tablebold  colspan=2>
	<table border=0 width=100% >
	<tr>
	<td class=tablebold>
		&nbsp;&nbsp;<%=bundle.getString("label.applicationissue.AcademicYear")%> &nbsp;<font color=red>*</font></td>
		<td width="1%"> :
		</td>
		<td width="20%"><select name=sessionname validate='Academic Year' class=tablelight>
			<option value="00">-Select Academic Year-</option>
			<%
			if(yearList!=null && yearList.size()>0)
			{
				for(int s=0;s<yearList.size();s++)
				{
					HashMap map=(HashMap)yearList.get(s);
					String sessionid=(String)map.get("sessionid");
					String yearofsession=(String)map.get("sessionname");
					String session_status=(String)map.get("sessionstatus");
					out.println("<option value='"+sessionid+"' status='"+session_status+"'>"+yearofsession+"</option>");
				}
			}

			%>
		</select>

		</td>
	<td class=tablebold align=left><%=bundle.getString("label.applicationissue.Board")%> &nbsp;<font color=red>*</font></td>
		<td width="1%">: 
		</td>
		<td width="20%" colspan=2><select name=boardname validate='Board' class=tablelight>
			<option value="00">- Select Board-Medium -</option>
			<%

        	if(BoardList!=null && BoardList.size()>0)
			{
	   		 	for (int i = 0, j = 1; i < BoardList.size(); i++) 
	   		 		{
					HashMap boardListMap=(HashMap)BoardList.get(i);
					String boardid     = (String)boardListMap.get("boardid");
					String boardname      = (String)boardListMap.get("boardname");
					String mediumid      = (String)boardListMap.get("mediumid");
					String mediumname      = (String)boardListMap.get("mediumname");
	       		 	out.println("<option value='"+boardid+"' class=tablelight >"+boardname+"-"+mediumname+"</option>");
	   		 		}
			}

	     }catch(Exception e){}
			%>
		</select>
</td>

	</tr>
    <tr>
			
			<td class='tablebold'>
			<input type="radio" name="amountradio" value="today"  onclick="checkamountradio()">
			<%=bundle.getString("label.schedule.todaydate")%>
			</td>
				<td></td>

				<td colspan=5 align=left>
					 <%=today %>
				</td>
			</tr>
			<!-- <tr>
			
			<td class='tablebold'>
			<input type="radio" name="amountradio" value="datewise"  onclick="checkamountradio()">
			<%=bundle.getString("label.schedule.datewise")%>
			</td>
				<td></td>
				<td colspan=5 align=left>
				<input type='text' name='appdate' validate='Date' size='15' value='' onfocus='this.blur()'><input type='button' value='^' name='datewise' onclick="Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','ApplicantSearch.appdate','0',event,'Not_Greater_Than_CurrentDate',ApplicantSearch.todaydate);">				</td>
			</tr>
			<tr> -->
			
			<td class='tablebold' width=20%><input type="radio" name="amountradio" value="fromtodate" onclick="checkamountradio()">
			 <%=bundle.getString("label.schedule.fromdate")%>
			</td>				<td></td>
			
				<td  width=30% >
					 <input type='text' name='appFromdate' validate='From Date ' size='15' value='' onfocus='this.blur()'><input type='button' value='^' name='fromdate' onclick="document.ApplicantSearch.appTodate.value='';Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','ApplicantSearch.appFromdate','0',event,'Not_Greater_Than_CurrentDate',ApplicantSearch.todaydate);">
				</td>
				
				<td align=left class=tablebold  width=10%>
				<%=bundle.getString("label.schedule.todate")%>
				</td>
				<td></td>
				<td  width=40% colspan=2> 
				<input type='text' name='appTodate' validate='To Date ' size='15' value='' onfocus='this.blur()'><input type='button' value='^' name='todate'  onclick=Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','ApplicantSearch.appTodate','0',event,'Not_Less_Than_StartDate',ApplicantSearch.appFromdate)>
				</td>
			</tr>
    </table>
    </td>
    </tr>
    
    
    	
    </tbody>
</table>

<a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a>
<a href="#" class="bt_green" onclick="viewReport()"><span class="bt_green_lft"></span><strong><%=bundle.getString("label.schedule.report")%></strong><span class="bt_green_r"></span></a>

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</form>
</body>

</html>