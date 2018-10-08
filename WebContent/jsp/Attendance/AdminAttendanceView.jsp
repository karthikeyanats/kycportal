<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Attendance View  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script language='javascript'>
	
	function changeBoard(){
		if(check_ForParticularElements(document.wprkallotment.board,"select")){
			document.wprkallotment.submit();
		}
	}
	function smsdetails(obj)
	{
		var standardscheduleid=obj.getAttribute("standardscheduleid");
		var standardname=obj.getAttribute("standardname");
		document.wprkallotment.standardname.value=standardname;
		document.wprkallotment.boardname.value=document.wprkallotment.board[document.wprkallotment.board.selectedIndex].text;
		document.wprkallotment.standardscheduleid.value=standardscheduleid;
		document.wprkallotment.action = "./AttendanceStatusSms.jsp";
		document.wprkallotment.submit();
	}
	function standarddetails(obj)
	{
		var standardname=obj.getAttribute("standardname");
		var standardscheduleid=obj.getAttribute("standardscheduleid");
		document.wprkallotment.standardscheduleid.value=standardscheduleid;
		document.wprkallotment.boardname.value=document.wprkallotment.board[document.wprkallotment.board.selectedIndex].text;
		document.wprkallotment.standardname.value=standardname;
		document.wprkallotment.action = "./StandardWiseAttendanceView.jsp";
		document.wprkallotment.submit();
	}
	function Studentdetails(obj)
	{
	var standardscheduleid=obj.getAttribute("standardscheduleid");
	var standardname=obj.getAttribute("standardname");
	
	document.wprkallotment.attendancestate.value=obj.getAttribute("state");
	document.wprkallotment.standardname.value=standardname;
	document.wprkallotment.boardname.value=document.wprkallotment.board[document.wprkallotment.board.selectedIndex].text;
	document.wprkallotment.standardscheduleid.value=standardscheduleid;
	document.wprkallotment.action = "./AbsenteesListView.jsp";
	document.wprkallotment.submit();
	}
	function previousdatefun()
	{
		document.wprkallotment.searchdate.value=document.wprkallotment.previousdate.value;
		document.wprkallotment.submit();
	}
	function nextdatefun()
	{
		document.wprkallotment.searchdate.value=document.wprkallotment.nextdate.value;
		document.wprkallotment.submit();
	}
	function sendsms()
	{  
			if(check_ForParticularElements(document.wprkallotment.board,"select"))
			{
	
		document.wprkallotment.boardname.value=document.wprkallotment.board[document.wprkallotment.board.selectedIndex].text;
		document.wprkallotment.boardid.value=document.wprkallotment.board[document.wprkallotment.board.selectedIndex].value;
		
	document.wprkallotment.action = "./AbsenteesListViewSMS.jsp";
	document.wprkallotment.submit();
	}  
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


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2>Attendance Details</h2>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.Common.DateTime,com.iGrandee.Attendance.AttendanceQuery"%>
	
<%
	DateTime dateobj=new DateTime();
///	ResourceBundle bundle 	= ResourceBundle.getBundle("ResourceBundle.English_en");
	AttendanceQuery attenquery		= new AttendanceQuery();
	HashMap	hashmap				= null;
	String sectionid			= request.getParameter("section");
	String instituteid			= (String)session.getValue("instituteid");
	String userid				= (String)session.getValue("userid");
	String boardid				= request.getParameter("board")+"";
	String Sessionid			= (String)session.getValue("sessionid");
	String Sessionname			= (String)session.getValue("sessionname");
	/*
	String array []				=session.getValueNames();
		for(int i=0;i<array.length;i++)
		{
			//out.println("==="+array[i]);
		}
	*/
ArrayList StandardList	= null;
	ArrayList boardList	= attenquery.loadboard(instituteid);
	if(!boardid.equals("null"))
	{
	StandardList	= attenquery.loadstandard(boardid,Sessionid,instituteid);
	}
	String searchdate=null;
	String Displaydate []=null;
	String Displaydate1="";
	if((request.getParameter("searchdate")+"").equals("null"))
	{
		searchdate=dateobj.showTime("databaseinsert").replace("/","-")+"";
	}
	else
	{
		searchdate=request.getParameter("searchdate")+"";
	}
	//out.println(searchdate+"============");
	//
		String[] removedate=searchdate.split("-");
	String[] newcurdate=null;
	String finaldate="";  
	String[] removezero=null;
	//out.println(removedate[1].charAt(0));
	if((removedate[1].charAt(0))=='0')
	{   	
		newcurdate=removedate[1].split("0");
		
			if((removedate[2].charAt(0))=='0')
			{
			removezero=removedate[2].split("0");
			removedate[2]=removezero[1];
			}
		finaldate=removedate[0]+"-"+newcurdate[1]+"-"+removedate[2];
	}  
	else
	{  
		finaldate=removedate[0]+"-"+removedate[1]+"-"+removedate[2];

	}  
	try{
	Displaydate =searchdate.split("-");
	Displaydate1=Displaydate[2]+"-"+Displaydate[1]+"-"+Displaydate[0];
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	String prevdate="";
	String nextdate="";
	
	%>
<jsp:useBean id="common_data_object"  scope="page" class="com.iGrandee.Common.CommonDataAccess"/>

<body topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0>
	<form name='wprkallotment' method='post'>
	<input type="hidden" name="standardscheduleid" value="">
	<input type="hidden" name="standardname" value="">
	<input type="hidden" name="boardname" value="">
	<input type="hidden" name="attendancestate" value="">
	<input type="hidden" name="boardid" value="">
	
		<input type="hidden" name="searchdate" value="<%=searchdate %>">
	
		<table class="bodyinnercolor" border='0' align="center" width="100%" height='100%' cellspacing=0 cellpadding=0>
			<tr>
				<td width='100%' align='center'>
					<table  border=0 bordercolor='blue' align="center" width="80%" cellspacing=0 cellpadding=0>
			<tr>
				<td align='left' width='100%' height='100%'>
				
						<table id="rounded-corner" border=0 summary="Department List"
							width="100%">
							<thead>
								<tr>
									<th scope="col" class="rounded-company" width="98%">Board Details</th>
									<th scope="col" class="rounded-q4" width="2%"></th>
								</tr>
							</thead>
							<tr>
								<td colspan='2'>
								<table border='0' align="center" width="100%" >
									<tr>
									<td  class=tablebold>Academic Year</td>
									<td class=tablebold>:</td>
									<td  width='25%'><%= Sessionname%></td>
									<td class=tablebold width='20%'>Board</td>
									<td class=tablebold>:</td>
									<td width='30%'><select name='board' validate='Board' onchange='changeBoard()'>
											<option value='0'>-Select board-</option>
											<%
												if(boardList != null && boardList.size()>0){
													for(int y=0;y<boardList.size();y++){
														hashmap		= (HashMap)boardList.get(y);
														
														if(boardid != null && boardid.equals(""+hashmap.get("boardid")))
															out.print("<option selected value='"+hashmap.get("boardid")+"'>"+hashmap.get("boardname")+" - "+hashmap.get("mediumname")+"</option>");
														else
															out.print("<option value='"+hashmap.get("boardid")+"'>"+hashmap.get("boardname")+" - "+hashmap.get("mediumname")+"</option>");

													}
												}
											%>
										</select></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						<br></br>
																		</td>

											</tr>
<tr>
										<td align='left' width='100%' height='100%'>
										<%if(!boardid.equals("null") )
										{ %>
										<table border=0 width="100%" class=tablebold>
										<tr>
										<td align=left width="20%"><a href="#Previous" name="Previous" onclick=previousdatefun()><div id=PreviousDate></div></a></td><td align=center width="60%">
										<%=Displaydate1%>						
										</td><td align=right width="20%" id=nexttd style="visibility:hidden">
										<a href="#next" name="next" onclick=nextdatefun()><div id=NextDate></div></a>
										</td>
										</tr>
										</table>
										<%}%>
										
									<table border='0' id=rounded-corner  align="center" width="100%">
									<thead>
											<tr >
											<th scope="col" class="rounded-company" width="10%">Sl.No</th>
											<th scope="col" class="rounded" width="45%">Standard</th>
											<th scope="col" class="rounded" width="15%">No of Present</th>
											<th scope="col" class="rounded" width="17%">No of Absentees</th>
											<th scope="col" class="rounded-q4" width="5%">Total</th>
											<!-- <td width='13%'>SMS</td> -->
											</tr>
									</thead>
											<%int ansent_temp=0;
												if(StandardList != null && StandardList.size()>0){
													int count=0;
													int count1=0;
													
													ArrayList datelist =attenquery.nextpreviousdate(searchdate);
													for(int y=0;y<datelist.size();y++)
													{
													hashmap		= (HashMap)datelist.get(y);
													prevdate=hashmap.get("previousdate")+"";
													nextdate=hashmap.get("nextdate")+"";
													}
													for(int y=0;y<StandardList.size();y++){
														hashmap		= (HashMap)StandardList.get(y);
														out.println("<tr>");
														String standid=hashmap.get("standardscheduleid")+"";
														String standardname=hashmap.get("standardname")+"";
														String groupname=hashmap.get("groupname")+"";
														if(!groupname.equals("null"))
															standardname=standardname+" -"+groupname;
														out.print("<td align=center>"+(y+1)+"</td><td>"+standardname+"<a href='#absent' name='absent' standardscheduleid='"+standid+"' standardname='"+standardname+"' onclick='standarddetails(this)'>  <br>  [ Show Section Wise ]</a></td>");
														ArrayList present = attenquery.loadpresentcount(Sessionid,standid,searchdate);
														ArrayList absentees = attenquery.loadAbsentesscount(Sessionid,standid,searchdate);

														if(present.size()>0)
														{
														for(int i=0;i<present.size();i++)
														{
														HashMap innermap=(HashMap)present.get(i);
														String noofpresent=innermap.get("present")+"";
															if(noofpresent.equals("0"))
																out.print("<td align=center>"+noofpresent+"</td>");
															else
																out.print("<td align=center style='background-color:#b0ffb0'><a href='#present' name='present' standardscheduleid='"+standid+"' standardname='"+standardname+"' state='P' onclick='Studentdetails(this)'>[ "+noofpresent+" ]</a></td>");
															count +=Integer.parseInt(noofpresent);
															}
														}
														else
														{
															out.print("<td align=center>0</td>");

														}
														if(absentees.size()>0)
														{
														for(int i=0;i<absentees.size();i++)
														{
														HashMap innermap=(HashMap)absentees.get(i);
														String noofabsentees=innermap.get("absentees")+"";
														
															if(noofabsentees.equals("0"))
															{
																out.print("<td align=center>"+noofabsentees+"</td>");
																out.println("<td>-</td>");
															}
															else
															{
																out.print("<td align=center style='background-color:#ffb0b0'><a href='#absent' name='absent' standardscheduleid='"+standid+"' standardname='"+standardname+"' onclick='Studentdetails(this)'>[ "+noofabsentees+" ]</a></td>");
																ansent_temp++;
															}
															count1 +=Integer.parseInt(noofabsentees);
														}
													}
													else
													{
														out.print("<td align=center>0</td>");
													}
														
														if(present.size()>0 || absentees.size()>0)
														{
															out.print("<td align=center>"+(count+count1)+"</td>");
														//<td><a href='#absent' name='absent' standardscheduleid='"+standid+"' standardname='"+standardname+"' onclick='smsdetails(this)'>Send SMS</a></td>");
														}
														else
														{
															out.print("<td align=center>0</td>");
														//<td align=center>-</td>");
														}
														
							
														
														out.println("</tr>");
														
														
														if(y==StandardList.size()-1)
														{
															out.println("<tr><td align=right colspan=2 class=tablebold>Total No of Students:</td><td align=center>"+count+"</td><td align=center>"+count1+"</td><td align=center>"+(count+count1)+"</td></tr>");
														}
													}
												}
												else
												{
													out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
													//out.println("<tr><td align=center colspan=5>Data Not Found</td></tr>");
												}
											%>
										</table>
																	</td>

											</tr>

										</table>
										</td>
										<td></td>
									</tr>
								</table>
	<input type=hidden name="previousdate" value="<%=prevdate%>">
	<input type=hidden name="nextdate" value="<%=nextdate%>">
		<input type=hidden name="backstatus" value="Admin">
	
	<%													

	try{
		if(!nextdate.equals("null") && !boardid.equals("null")  && !prevdate.equals("null") && !nextdate.equals("") && !prevdate.equals(""))
	
	{ String Displaydate2 [] =prevdate.split("-");
	String Displaydate3 [] =nextdate.split("-");
	%>
	<script>
	document.getElementById("PreviousDate").innerHTML="<< <%=Displaydate2[2]+"-"+Displaydate2[1]+"-"+Displaydate2[0]%>";
	document.getElementById("NextDate").innerHTML=" <%=Displaydate3[2]+"-"+Displaydate3[1]+"-"+Displaydate3[0]%> >>";
	document.getElementById("nexttd").style.visibility="visible";
	</script>
	<% }
	else if(nextdate.equals("null") && !prevdate.equals("null") && !nextdate.equals("") && !prevdate.equals(""))
	{
		 String Displaydate2 [] =prevdate.split("-");
	%>
	<script>
	document.getElementById("PreviousDate").innerHTML="<< <%=Displaydate2[2]+"-"+Displaydate2[1]+"-"+Displaydate2[0]%>";
	</script>
	<%	
	}
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	if(finaldate.equals(dateobj.showTime("databaseinsert").replace("/","-")+""))
	{
		if(ansent_temp>0)
		{
	%>
				 	<a href="#" class="bt_green" onclick='sendsms()'><span class="bt_green_lft"></span><strong>Send SMS</strong><span class="bt_green_r"></span></a> 
<%} 
}%>
	</form>
    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>