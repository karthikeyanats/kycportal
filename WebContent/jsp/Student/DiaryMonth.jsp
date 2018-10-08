<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Monthwise Diary View | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script language='javascript'>

	function callDairyView(obj){
	
		document.workallotment.dayname.value 	= obj.getAttribute("dayname");
		document.workallotment.dairydate.value 	= obj.getAttribute("dairydate");
		document.workallotment.cdairydate.value = obj.getAttribute("cdairydate");
		document.workallotment.action			= "MonthDairyView.jsp";
		document.workallotment.submit();
	
	}
	
	function Nextmonth()
	{

		document.workallotment.index.value	= parseInt(document.workallotment.index.value,10)+1;
		document.workallotment.submit();

	}
	
	function Previousmonth()
	{
		document.workallotment.index.value	= parseInt(document.workallotment.index.value,10)-1;
		document.workallotment.submit();
	}	
	
	function goBack(){
		
		document.workallotment.action	= "Dairyview.jsp";
		document.workallotment.submit();
		
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

    <h2><%=bundle.getString("label.diary.studentroot2")%></h2>
    
	<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
	<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Dairy.Dairy"%>

	<%
	
		String sectionid		= (String)session.getValue("sectionscheduleid");
		String studentid		= (String)session.getValue("studentid");
		String index			= request.getParameter("index");
		int indexint			= 0;
		
		if(index != null && !index.equals("") && !index.equalsIgnoreCase("null"))
			indexint			= Integer.parseInt(index);
		
		Dairy	dairy			= new Dairy();
		HashMap	hashmap			= null;
		ArrayList diaryList		= null;
		ArrayList monthList		= dairy.loadMonthandYear(indexint);

		String currentmonth		= null;
		String currentyear		= null;
		String nextmonth		= null;
		String nextyear			= null;
		String prevmonth		= null;
		String prevyear			= null;

		
		
		if(monthList != null && monthList.size()>0){
			hashmap				= (HashMap)monthList.get(0);
			
			currentyear			= (String)hashmap.get("currentyear");
			currentmonth		= (String)hashmap.get("currentmonth");
			nextmonth			= (String)hashmap.get("nextmonth");
			nextyear			= (String)hashmap.get("nextyear");
			prevyear			= (String)hashmap.get("previousyear");
			prevmonth			= (String)hashmap.get("previousmonth");
			
		}
		
		diaryList				= dairy.loadDairyStudentSubject(sectionid,currentmonth,currentyear);
		
	%>    

	<form name='workallotment' method='post'>
	
		<table border=0 width="100%" class=tablebold>
			<tr>
				<td align=left width="30%"><a href="#" onclick='Previousmonth()'> &lt;&lt;<%=prevmonth %>&nbsp;<%=prevyear %></a></td>
				<td align=center  width="40%"><%=currentmonth %>&nbsp;<%=currentyear %></td>
				<td align=right width="30%"><a href="#" onclick='Nextmonth()'><%=nextmonth %>&nbsp;<%=nextyear %>&gt;&gt;</a></td>
			</tr>
		</table>
		
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
		    <thead>
		    	<tr>
		        	<th scope="col" class="rounded-company" width="15%"><%=bundle.getString("label.diary.S.No")%></th>
		            <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.diary.date")%></th>
		            <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.diary.day")%></th>
		            <th scope="col" class="rounded-q4" width="35%"><%=bundle.getString("label.diary.totaltask")%></th>
		    	</tr>
		    </thead>
		
		    
		    <%
		
		    	if(diaryList != null && diaryList.size()>0){
					
					for(int y=0;y<diaryList.size();y++){
						hashmap		= (HashMap)diaryList.get(y);
						out.print("<tr><td>"+(y+1)+"</td><td><a href='#' dairydate='"+hashmap.get("dairydate")+"'  cdairydate='"+hashmap.get("cdairydate")+"'  dayname='"+hashmap.get("dayname")+"'onclick='callDairyView(this)'>"+hashmap.get("dairydate")+"</td><td>"+hashmap.get("dayname")+"</td><td>"+hashmap.get("totaldiary")+"</td></tr>");
					}
		    	}
		    	else
		    		out.print("<tr><td align='center' colspan='4'><a class='nodata'>Data Not Found</td></tr>");
		    %>
		    
		</table>	
		
		<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.diary.Back")%></strong><span class="bt_blue_r"></span></a>
		
		
		<input type='hidden' name='dairydate' 	value=''>
		<input type='hidden' name='cdairydate' 	value=''>
		<input type='hidden' name='dayname' 	value=''>
		<input type='hidden' name='index' 		value='<%=indexint%>'>
		
		
	</form>    
    

    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>