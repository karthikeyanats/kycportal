<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.ArrayList"%>
<html>
<head>
<title><%=bundle.getString("label.datewisebooksearch.entrytitle") %></title>

<script type="text/javascript" src="../highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/highslide/highslide.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript">
hs.graphicsDir = "<%=request.getContextPath()%>/js/highslide/graphics/"; 
hs.outlineType = 'rounded-white'; 
hs.wrapperClassName = 'draggable-header';  
</script>     

<script language="JavaScript">

function printReport()
{
 	window.open("./printExceedDue.jsp?startdate="+document.MainForm.startdate.value+"&enddate="+document.MainForm.enddate.value+"&flage_temp="+document.MainForm.flage_temp.value,"Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=800,scrollbars=1;")
 	//window.open("./printIssue.jsp?req_sessionname="+document.MainForm.req_sessionname.value+"&req_boardname="+document.MainForm.req_boardname.value+"&req_sessionid="+document.MainForm.req_sessionid.value+"&req_boardid="+document.MainForm.req_boardid.value+"&standardnamegp="+document.MainForm.standardnamegp.value+"&standardpublishid="+document.MainForm.standardpublishid.value+"&req_sessionstatus="+document.MainForm.req_sessionstatus.value,"Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=800,scrollbars=1;")
}

</script>
</head>

<body>

	<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Library.Report.BookJournalReport" />
<%@ page import="java.util.HashMap"%>
<% 	java.util.ResourceBundle bundle1 	= 	java.util.ResourceBundle.getBundle("resources.serversetup");%>
<%
ArrayList BookList=new ArrayList();
String sessionid=session.getValue("sessionid")+"";
String rackwise="";
String instituteid=session.getValue("instituteid")+"";
String startdate="";
String enddate="";
String flage_temp=request.getParameter("flage_temp");

ArrayList JournalList=new ArrayList();
	startdate=request.getParameter("startdate");
	enddate=request.getParameter("enddate");
	
	if(flage_temp.equals("Book"))
	{
		BookList=query_object.get_All_BookExceedDuedate(startdate,enddate,rackwise,"bookMaster",instituteid); 
	}
	else if(flage_temp.equals("Journal"))
	{
		JournalList=query_object.get_All_BookExceedDuedate(startdate,enddate,rackwise,"Journal",instituteid);  

	}


%>
<form name="MainForm" method="post" action="">
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
    <%

	if(flage_temp.equals("Book"))
	{
    out.print("<h2>"+bundle.getString("label.bookexceedduedate.entryrootpath1")+"</h2>");
    
	}
	else if(flage_temp.equals("Journal"))
	{
	    out.print("<h2>"+bundle.getString("label.bookexceedduedate.entryrootpath2")+"</h2>");

	}



%>	

<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	<tr>
		<td>

<table id="rounded-corner" border=0 width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="20%"><%=bundle.getString("label.datewisebooksearch.SelectedInformation")%></th>
        	<th scope="col" class="rounded" width="1%"></th>
        	<th scope="col" class="rounded" width="20%" ></th>
            <th scope="col" class="rounded" width="20%" ></th>
            <th scope="col" class="rounded" width="1%" ></th>
            <th scope="col" class="rounded-q4" width="20%" ></th>
            
        </tr>
    </thead>
    <tbody>
    		<tr valign="top">
            <td class="tablebold" valign="top" width="20%"><%=bundle.getString("label.datewisebooksearch.StartDate") %>
            </td>
            <td class="tablebold" width="1%">:</td>
            <td width="20%" class="tablelight">
           <%=startdate %>
			</td>					
			<td class="tablebold" valign="top"  width="20%"><%=bundle.getString("label.datewisebooksearch.EndDate") %>
            </td>
               <td class="tablebold" width="1%">:</td>
             <td  width="20%" class="tablelight">
            <%=enddate %>
			</td>
			</tr> 
			
	</tbody>			

   <tfoot>
    	<tr>
        	<td colspan="5" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot> 
    </table>
		<br>
		<br>
  
   
</table>
<%

if(flage_temp.equals("Book"))
{
%>
   
   
   <table id="rounded-corner1" border=0 summary="Department List" width="100%">
    <thead>
    	<tr class=tableheading  >
        	<th scope="col" class="rounded-company" width="5%" rowspan=2><%=bundle.getString("label.bookreturn.Sl.No") %></th>
            <th scope="col" class="rounded" width="10%"  rowspan=2 ><%=bundle.getString("label.bookreturn.Title") %> </th>
            <th scope="col" class="rounded" width="10%"  rowspan=2><%=bundle.getString("label.bookreturn.AccessNo") %></th>
             <th scope="col" class="rounded" width="10%"  rowspan=2><%=bundle.getString("label.bookreturn.Author") %></th>
             <th scope="col" class="rounded" width="10%"  rowspan=2>Expected<br><%=bundle.getString("label.bookreturn.ReturnDate") %></th>
            <th scope="col" class="rounded" width="10%" colspan=<%=3 %>><%=bundle.getString("label.bookreturn.IssuedTo")%></th>
            <tr  class=tableheading><th width="10%"><%=bundle.getString("label.bookreturn.Username") %></th><th width="10%"><%=bundle.getString("label.bookreturn.CardNo") %></th><th width="10%"><%=bundle.getString("label.bookreturn.Designation") %></th>
		     </tr>
		    </thead>
      		<tfoot>
      		
      		
		
				<% 
				 HashMap BookListMap=new HashMap();
				try
				{
			     if(BookList!=null && BookList.size()>0)
			     {
			    	 ArrayList tempListRack = new ArrayList();
			    	 for(int i=0,j=1;i<BookList.size();i++,j++)
			    	 {
			    		 BookListMap=(HashMap)BookList.get(i);
			    		 String bookmasterid=BookListMap.get("bookmasterid")+"";
			    		 String newdates=BookListMap.get("newdates")+"";
			    	     String booktype=BookListMap.get("booktype")+"";
			    	     String author=BookListMap.get("author")+"";
			    	     String edition=BookListMap.get("edition")+"";
			    	     String accessno=BookListMap.get("accessno")+"";
			    	     String uname=BookListMap.get("uname")+"";
			    	     String cardno=BookListMap.get("cardno")+"";
			    	     String rolename=BookListMap.get("rolename")+"";
			    	     //String returndate=BookListMap.get("returndate")+"";
			    	     String returndate=BookListMap.get("expectedreturndate")+"";
			    	     String rackname=BookListMap.get("rackname")+"";
				    		
			    	     if(!tempListRack.contains(rackname))
			    			{
			    				rackname=rackname.trim();
			    				tempListRack.add(rackname);  
				    		 out.print("<tr valign='top'>");
				    		 out.print("<td colspan=8 class='tablebold' width='5%'>Rack Name : "+rackname+"</td></tr>");
			    			}						    	     

			    		
			    		 out.print("<tr valign='top'>");
			    		 out.print("<td class='tablelight' width='5%'>"+j+"</td>");
			    		 %>
			    		<td>
			    		 <div>
			    		 <a href="./BookDetails.jsp?bookmasterid=<%=bookmasterid%>" onclick="return hs.htmlExpand(this, { objectType: 'iframe',headingText: '', maincontentId: 'credits', align: 'center', width: 950, height: 800 } )"><%= BookListMap.get("title")%></a>
			    		 </div>
			    		 </td>
			    		<%
			    		if(accessno == null || accessno.equals("") || accessno.equals("-") || accessno.equalsIgnoreCase("null"))
						{
			    			out.print("<td class='tablelight'>-</td>");
						}
			    		else
			    		{   
			    		 out.print("<td class='tablelight' align='center'>"+BookListMap.get("accessno")+"</td>"); 
			    		}
			    		if(author == null || author.equals("") || author.equals("-") || author.equalsIgnoreCase("null"))
						{
			    			out.print("<td class='tablelight' >-</td>");
						}
			    		else
			    		{   
			    		 out.print("<td class='tablelight' >"+BookListMap.get("author")+"</td>"); 
			    		}
			    		if(returndate == null || returndate.equals("") || returndate.equals("-") || returndate.equalsIgnoreCase("null"))
						{
			    			out.print("<td class='tablelight' >-</td>");
						}
			    		else
			    		{   
			    		 out.print("<td class='tablelight' >"+BookListMap.get("expectedreturndate")+"</td>"); 
			    		}
			    		if(uname == null || uname.equals("") || uname.equals("-") || uname.equalsIgnoreCase("null"))
						{
			    			out.print("<td class='tablelight' >-</td>");
						}
			    		else
			    		{   
			    		 out.print("<td class='tablelight' >"+BookListMap.get("uname")+"</td>"); 
			    		}
			    		if(cardno == null || cardno.equals("") || cardno.equals("-") || cardno.equalsIgnoreCase("null"))
						{
			    			out.print("<td class='tablelight' >-</td>");
						}
			    		else
			    		{   
			    		 out.print("<td class='tablelight' align='center'>"+BookListMap.get("cardno")+"</td>"); 
			    		}
			    		if(rolename == null || author.equals("") || rolename.equals("-") || rolename.equalsIgnoreCase("null"))
						{
			    			out.print("<td class='tablelight' >-</td>");
						}
			    		else
			    		{   
			    		 out.print("<td class='tablelight' >"+BookListMap.get("rolename")+"</td>"); 
			    		}
			    		
			    		 out.print("</tr>");
			    	 }
			     }
			     else
			     {
			    	 out.println("<tr align='center' class='tablebold'><td colspan='8'><font color='red'>Data Not Found</font></td></tr>");
			    	 //out.print("<tr><td colspan=8 align='center'>Data Not Found</td></tr>");
			     }
				}
				catch(Exception e)
				{
					System.out.println(e);
				}
}
else if(flage_temp.equals("Journal"))
{
%>
			
			    
			   
			   
			   <table id="rounded-corner1" border=0 summary="Department List" width="100%">
    <thead>
    	<tr class=tableheading  >
        	<th scope="col" class="rounded-company" width="5%" rowspan=2><%=bundle.getString("label.bookreturn.Sl.No") %></th>
            <th scope="col" class="rounded" width="10%"  rowspan=2 ><%=bundle.getString("label.bookreturn.JournalName") %> </th>
            <th scope="col" class="rounded" width="10%"  rowspan=2><%=bundle.getString("label.bookreturn.CodeNo") %></th>
             <th scope="col" class="rounded" width="10%"  rowspan=2><%=bundle.getString("label.bookreturn.BookType") %></th>
             <th scope="col" class="rounded" width="10%"  rowspan=2>Expected<br><%=bundle.getString("label.bookreturn.ReturnDate") %></th>
            <th scope="col" class="rounded" width="10%" colspan=<%=3 %>><%=bundle.getString("label.bookreturn.IssuedTo")%></th>
            <tr  class=tableheading><th width="10%"><%=bundle.getString("label.bookreturn.Username") %></th><th width="10%"><%=bundle.getString("label.bookreturn.CardNo") %></th><th width="10%"><%=bundle.getString("label.bookreturn.Designation") %></th>
		     </tr>
		    </thead>
      		<tfoot>
      		
					
							<% 
							 HashMap BookListMap=new HashMap();
							try
							{
						     if(JournalList!=null && JournalList.size()>0)
						     {
						    	 ArrayList tempListRack = new ArrayList();
						    	 for(int i=0,j=1;i<JournalList.size();i++,j++)
						    	 {
						    		 BookListMap=(HashMap)JournalList.get(i);
						    		 String bookmasterid=BookListMap.get("bookmasterid")+"";
						    		 String newdates=BookListMap.get("newdates")+"";
						    	     String formattedCurrency = null;
						    	     String booktype=BookListMap.get("booktype")+"";
						    	     String issueno=BookListMap.get("issueno")+"";
						    	     String volumeno=BookListMap.get("volumeno")+"";
						    	     String cardno=BookListMap.get("cardno")+"";
						    	     String rolename=BookListMap.get("rolename")+"";
						    	     //String returndate=BookListMap.get("returndate")+"";
						    	     String returndate=BookListMap.get("expectedreturndate")+"";
						    	     String uname=BookListMap.get("uname")+"";
						    	     String codeno=BookListMap.get("codeno")+"";
						    	     String rackname=BookListMap.get("rackname")+"";
							    		
						    	     if(!tempListRack.contains(rackname))
						    			{
						    				rackname=rackname.trim();
						    				tempListRack.add(rackname);  
							    		 out.print("<tr valign='top'>");
							    		 out.print("<td colspan=8 class='tablebold' width='5%'>Rack Name : "+rackname+"</td></tr>");
						    			}						    	     

						    		
						    		 out.print("<tr valign='top'>");
						    		 out.print("<td class='tablelight' width='5%'>"+j+"</td>");
						    		 %>
						    		<td >
						    		 <div>
						    		 <a href="./JournalBookDeatils.jsp?bookmasterid=<%=bookmasterid%>" onclick="return hs.htmlExpand(this, { objectType: 'iframe',headingText: ' ', maincontentId: 'credits', align: 'center', width: 950, height: 800 } )"><%= BookListMap.get("bookname")%></a>
						    		 </div>
						    		 </td>
						    		<%
						    		if(codeno == null || codeno.equals("") || codeno.equals("-") || codeno.equalsIgnoreCase("null"))
									{
						    			out.print("<td class='tablelight' >-</td>");
									}
						    		else
						    		{   
						    		 out.print("<td class='tablelight' >"+BookListMap.get("codeno")+"</td>"); 
						    		}
						    		if(booktype == null || booktype.equals("") || booktype.equals("-") || booktype.equalsIgnoreCase("null"))
									{
						    			out.print("<td class='tablelight' >-</td>");
									}
						    		else
						    		{
						    		 out.print("<td class='tablelight' >"+BookListMap.get("booktype")+"</td>"); 
						    		}
						    		if(returndate == null || returndate.equals("") || returndate.equals("-") || returndate.equalsIgnoreCase("null"))
									{
						    			out.print("<td class='tablelight' >-</td>");
									}
						    		else
						    		{
						    		 out.print("<td class='tablelight' >"+BookListMap.get("expectedreturndate")+"</td>"); 
						    		}
						    		if(uname == null || uname.equals("") || uname.equals("-") || uname.equalsIgnoreCase("null"))
									{
						    			out.print("<td class='tablelight' >-</td>");
									}
						    		else
						    		{
						    		 out.print("<td class='tablelight' >"+BookListMap.get("uname")+"</td>"); 
						    		}
						    		
						    		if(cardno == null || cardno.equals("") || cardno.equals("-") || cardno.equalsIgnoreCase("null"))
									{
						    			out.print("<td class='tablelight' >-</td>");
									}
						    		else
						    		{
						    		 out.print("<td class='tablelight' >"+BookListMap.get("cardno")+"</td>"); 
						    		}
						    		if(rolename == null || rolename.equals("") || rolename.equals("-") || rolename.equalsIgnoreCase("null"))
									{
						    			out.print("<td class='tablelight' >-</td>");
									}
						    		else
						    		{
						    		 out.print("<td class='tablelight' >"+BookListMap.get("rolename")+"</td>"); 
						    		}
						    		
						    		
						    		 out.print("</tr>");
						    	 }
						     }
						     else
						     {
						    	 out.println("<tr align='center' class='tablebold'><td colspan='8'><font color='red'>Data Not Found</font></td></tr>");
						    	 //out.print("<tr><td colspan=8 align='center'>Data Not Found</td></tr>");
						     }
							}
							catch(Exception e)
							{
								System.out.println(e);
							}

							
						
						
					
					
							
				}
%>
			</table>
		
		<a href="BookExceedDuedate.jsp" class="bt_blue" ><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.datewisebooksearch.Back") %> </strong><span class="bt_blue_r"></span></a>
		<a href="#" class="bt_green" onclick="printReport()"><span class="bt_green_lft"></span><strong><%=bundle.getString("label.button.Print")%></strong><span class="bt_green_r"></span></a>
		
		

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../../include/footer.jsp" %>

</div>
<input type=hidden name="startdate" value = "<%=request.getParameter("startdate")%>">
<input type=hidden name="enddate" value = "<%=request.getParameter("enddate")%>">
<input type=hidden name="flage_temp" value = "<%=request.getParameter("flage_temp")%>">
    </form>
	
</body>
</html>