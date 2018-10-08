<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<jsp:useBean id="query_object" scope="page"	class="com.iGrandee.SchoolCalender.SchoolCalenderEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.SchoolCalender.SchoolCalenderBean" />
<%@ page language="java" import="java.util.*,com.iGrandee.Common.DateTime"%>
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child -  <%=bundle.getString("label.schoolcalendar.entrytitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="jquery.min.js"></script>

<script language="JavaScript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>

<script type="text/javascript">



function manipulateFun(id)
{
if(confirm("Do you want to Activate the Event...?"))
{
	document.f1.mode_of_operation.value = "manipulateActive";
	document.f1.calendar_typeid.value=id;

	document.f1.action = "calendaractivity.jsp";
	document.f1.submit();
	}

}

function Nextmonth()
	{
		var date=document.f1.searchmonth.value.split("-");
		var monthdate="";
		
		if((date[0].charAt(0)) == 0)
			aa = parseInt((date[0]).charAt(1));			
		else 
			aa = parseInt(date[0]);
			
		if((aa+1)==13)
		{
		monthdate="1-"+(parseInt(date[1])+1)
		document.f1.displaymonth.value="01-"+(parseInt(date[1])+1);
		}
		else
		{
		if((aa+1)<10)
		{
		document.f1.displaymonth.value="0"+(aa+1)+"-"+date[1];
		}
		else
		{
		document.f1.displaymonth.value=(aa+1)+"-"+date[1];
		}
		monthdate=(aa+1)+"-"+date[1]
		}
		document.f1.searchmonth.value=monthdate;
		document.f1.submit();
	}
	function Previousmonth()
	{
		var date=document.f1.searchmonth.value.split("-");
		var monthdate="";
		
		if((date[0].charAt(0)) == 0)
			aa = parseInt((date[0]).charAt(1));			
		else 
			aa = parseInt(date[0]);
			
			
		if((aa-1)==0)
		{
		monthdate="12-"+(parseInt(date[1])-1);
		document.f1.displaymonth.value="12-"+(parseInt(date[1])-1);
		}
		else
		{
		if((parseInt(date[0])-1)<10)
		{
		document.f1.displaymonth.value="0"+(aa-1)+"-"+date[1];
		}
		else
		{
		document.f1.displaymonth.value=(aa-1)+"-"+date[1];
		}
		monthdate=(aa-1)+"-"+date[1]
		}
		document.f1.searchmonth.value=monthdate;
		document.f1.submit();
	}





</script>
</head>
<body>
<jsp:useBean id="datebeans" scope="page" class="com.iGrandee.Common.DateTime"/>
<%@ page import="java.io.*,java.util.*"%>

<%
HashMap	hashmap				= null;
String today				= DateTime.showTime("calendar");

DateTime dateobj=new DateTime();
String searchmonth="";
if((request.getParameter("searchmonth")+"").equals("null"))
{
	String datevar[]=(dateobj.getMySQLFormat(today)+"").split("/");
	 searchmonth=datevar[1]+"-"+datevar[0];

	// System.out.println("searchmonth==xxxxxxx=======>>>>>"+searchmonth);
}
else
{
	searchmonth=request.getParameter("searchmonth")+"";
	// System.out.println("searchmonth=====xxxxxxx====>>>>>"+searchmonth);

}
String prevmonth=request.getParameter("prevmonth")+"";
String nextmonth=request.getParameter("nextmonth")+"";
String attendancedate ="";
String forMonth="";
String convMonthPick ="";
if((request.getParameter("displaymonth")+"").equals("null"))
{
	 String datevar[]=(dateobj.getMySQLFormat(today)+"").split("/");
	 convMonthPick=datevar[1]+"-"+datevar[0];

	// System.out.print("searchmonth=========>>>>>"+convMonthPick); 
}
else
{
	convMonthPick=request.getParameter("displaymonth")+"";
	//System.out.println("convMonthPick=============>>>"+convMonthPick);
}
//out.println("convMonthPick"+convMonthPick);
	int totalmonth=0;
	String nextforMonth="";
	String prevtforMonth="";

if(!convMonthPick.equals("null"))
{//System.out.println("***********"+convMonthPick.substring(0,2));
	if(convMonthPick.substring(0,2).equals("01"))
	{
	forMonth = "January "+convMonthPick.substring(convMonthPick.lastIndexOf("-")+1);
	nextforMonth="February";
	prevtforMonth="December";
	
	
	}
	if(convMonthPick.substring(0,2).equals("02"))
	{
	forMonth = "February "+convMonthPick.substring(convMonthPick.lastIndexOf("-")+1);

		nextforMonth="March";
		prevtforMonth="January";
	}
	if(convMonthPick.substring(0,2).equals("03"))
	{
	forMonth = "March "+convMonthPick.substring(convMonthPick.lastIndexOf("-")+1);
	nextforMonth="April";
	prevtforMonth="February";
	}
	if(convMonthPick.substring(0,2).equals("04"))
	{
	forMonth = "April "+convMonthPick.substring(convMonthPick.lastIndexOf("-")+1);
	nextforMonth="May";
	prevtforMonth="March";
	}
	if(convMonthPick.substring(0,2).equals("05"))
	{
	forMonth = "May "+convMonthPick.substring(convMonthPick.lastIndexOf("-")+1);
	nextforMonth="June";
	prevtforMonth="April";
	}
	if(convMonthPick.substring(0,2).equals("06"))
	{
	forMonth = "June "+convMonthPick.substring(convMonthPick.lastIndexOf("-")+1);
	nextforMonth="July";
	prevtforMonth="May";
	}
	if(convMonthPick.substring(0,2).equals("07"))
	{
	forMonth = "July "+convMonthPick.substring(convMonthPick.lastIndexOf("-")+1);
	nextforMonth="August";
	prevtforMonth="June";
	}
	if(convMonthPick.substring(0,2).equals("08"))
	{
	forMonth = "August "+convMonthPick.substring(convMonthPick.lastIndexOf("-")+1);
	nextforMonth="September";
	prevtforMonth="July";
	}
	if(convMonthPick.substring(0,2).equals("09"))
	{
	forMonth = "September "+convMonthPick.substring(convMonthPick.lastIndexOf("-")+1);
	nextforMonth="October";
	prevtforMonth="August";
	}
	if(convMonthPick.substring(0,2).equals("10"))
	{
	forMonth = "October "+convMonthPick.substring(convMonthPick.lastIndexOf("-")+1);
	nextforMonth="November";
	prevtforMonth="September";
	}
	if(convMonthPick.substring(0,2).equals("11"))
	{
	forMonth = "November "+convMonthPick.substring(convMonthPick.lastIndexOf("-")+1);
	nextforMonth="December";
	prevtforMonth="October";
	}
	if(convMonthPick.substring(0,2).equals("12"))
	{
	forMonth = "December "+convMonthPick.substring(convMonthPick.lastIndexOf("-")+1);
	nextforMonth="January";
	prevtforMonth="November";
	}
	// totalmonth=Integer.parseInt(query_object.toGetAllDates(searchmonth));
}
String datevar[]=(dateobj.getMySQLFormat(today)+"").split("/");

String finalsdate=convMonthPick.substring(convMonthPick.lastIndexOf("-")+1)+"-"+convMonthPick.substring(0,2)+"-"+"01";
String finaledate=convMonthPick.substring(convMonthPick.lastIndexOf("-")+1)+"-"+convMonthPick.substring(0,2)+"-"+(String)query_object.toGetAllDates(searchmonth);

ArrayList eventDetails=new ArrayList();
%>
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
    <h2><%=bundle.getString("label.schoolcalendar.calendarview") %></h2>
<form name="f1" action="" method="post">
<input type=hidden name="previousmonth" value="<%=prevmonth%>">
	<input type=hidden name="nextmonth" value="<%=nextmonth%>">
	<input type=hidden name="searchmonth" value="<%=searchmonth%>">
	<input type=hidden name="displaymonth" value="">
			<%
	if(session.getValue("usercategory").equals("P")){%>
	<table id="rounded-corner" border=0 summary="Department List" width="100%">
					    <thead>
					    	<tr>
					        	
					            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.schoolcalendar.StudentDetails") %></th>
					            <th scope="col" class="rounded-q4" width="2%"></th>
					        </tr>
					    </thead>
					    <tr>		
					    	<td colspan='2'>					
				
								<%
									out.print("<table  border='0' bordercolor='blue' align='center' width='100%' cellspacing='0' cellpadding='5'>");
									out.print("<tr><td width='17%' class='tablebold'>Student Name</td><td width='1%' class='tablebold'>:</td><td>"+session.getValue("studentname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.schoolcalendar.AcademicYear") +"</td><td class='tablebold'>:</td><td>"+session.getValue("sessionname")+"</td></tr>");
									if(session.getValue("groupname") == null)
										out.print("<tr><td class='tablebold'>"+bundle.getString("label.schoolcalendar.StandardName") +"</td><td class='tablebold'>:</td><td>"+session.getValue("standardname")+"</td></tr>");
									else
										out.print("<tr><td class='tablebold'>"+bundle.getString("label.schoolcalendar.StandardName") +"</td><td class='tablebold'>:</td><td>"+session.getValue("standardname")+"&nbsp;&nbsp;[&nbsp;"+session.getValue("groupname")+"&nbsp;]</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.schoolcalendar.SectionName") +"</td><td class='tablebold'>:</td><td>"+session.getValue("sectionname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.schoolcalendar.BoardName") +"</td><td class='tablebold'>:</td><td>"+session.getValue("boardname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.schoolcalendar.MediumName") +"</td><td class='tablebold'>:</td><td>"+session.getValue("mediumname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.schoolcalendar.RollNo.") +"</td><td class='tablebold'>:</td><td>"+session.getValue("rollno") + "</td></tr>");

									out.print("</table>");
								%>	
							</td>
						</tr>
					</table>	
					
					<%} %>
					<br>
					
 <TABLE align="center" width="100%" height="100%" border=0 cellspacing=0 cellpadding=0>
	<tr>
		<td>
			<table  border='0' align="center" width="100%" cellspacing=5 cellpadding=0>
				<tr  height='25'>
					<td valign='top'>
						<table border=0 width="100%" class=tablebold>
							<tr>
								<td align=left width="30%"><a href="#" onclick='Previousmonth()'> &lt;&lt;<%=prevtforMonth %></a></td>
								<td align=center  width="40%"><%=forMonth%></td>
								<td align=right width="30%"><a href="#" onclick='Nextmonth()'><%=nextforMonth %>&gt;&gt;</a></td>
							</tr>
						</table>
 					</td>
 				</tr>
 
 <tr>
 <td>
<table id="rounded-corner" border=0 summary="Calender List" width="100%" align="center">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.schoolcalendar.eventdate") %></th>
             <th scope="col" class="rounded" width="30%"><%=bundle.getString("label.schoolcalendar.dayfordate") %></th>
               <th scope="col" class="rounded" width="40%"><%=bundle.getString("label.schoolcalendar.eventdetails") %></th>
              <th scope="col" class="rounded-q4" width="20%"><%=bundle.getString("label.schoolcalendar.holidaystatus") %></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="3" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>		
     		<%	
						String instituteid=session.getValue("instituteid")+""; 
						HashMap newStudstate=new HashMap();      
							ArrayList Studstate=query_object.getCalenderDetails(finalsdate,finaledate,instituteid);
							if( Studstate.size()>0)
							{             
								String tempdate="";
							  String newtempdate="";
							  String eventdate="";
							  String holidaystatus="";
							  String holidaystatusnew="";

								for(int i=0,j=1;i<Studstate.size();i++,j++)
								{
									 newStudstate=(HashMap)Studstate.get(i);
									String dayname=(String)newStudstate.get("dayname");
									String eventdescription=(String)newStudstate.get("eventdescription");
									
									eventdate=(String)newStudstate.get("newdates");
									 holidaystatus=(String)newStudstate.get("holidaystatus");
										if(holidaystatus.equals("Y"))
										{
											holidaystatusnew="Holiday";
										}
										else if(holidaystatus.equals("N"))
										{
											holidaystatusnew="-";
										}

									if(!newtempdate.equals(eventdate))
									{
										newtempdate=eventdate;
										out.println("<tr><td class='tablebold'width=12% >"+eventdate+"</td>");
										out.println("<td width='12%' >"+dayname+"</td>");

										out.println("<td class='tablelight' width='35%' >"+eventdescription+"</td>");
										out.println("<td class='tablelight'>"+holidaystatusnew+"</td>");

										out.println("</tr>");										
									}
									else
									{
									out.println("<tr><td class='tablebold' ></td>");
									out.println("<td width='12%' >"+dayname+"</td>");
									out.println("<td class='tablelight'>"+eventdescription+"</td>");
									out.println("<td class='tablelight'>"+holidaystatusnew+"</td>");

									out.println("</tr>");
									}
								}
							}
							else
							{
								out.println("<td class='tablelight' align='center' colspan='4'>No Event Found</td>");
	
							}
        
							
			%>
</table>


	</table>
	
    
    </thead>
</table>


 
     </td>
     </tr>
     </TABLE>
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>