<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page language="java" import="java.util.ResourceBundle,java.util.Date,com.iGrandee.Registration.InstitutionQurey"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.ArrayList"%>
<html>
<head>
<title><%=bundle.getString("label.datewisebooksearch.entrytitle") %></title>

<script type="text/javascript" src="../highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/kyccss.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script language="JavaScript">
function printReport()
{
 	window.open("./printIssue.jsp?req_sessionname="+document.applicationForm.req_sessionname.value+"&req_boardname="+document.applicationForm.req_boardname.value+"&req_sessionid="+document.applicationForm.req_sessionid.value+"&req_boardid="+document.applicationForm.req_boardid.value+"&standardnamegp="+document.applicationForm.standardnamegp.value+"&standardpublishid="+document.applicationForm.standardpublishid.value+"&appFrom="+document.applicationForm.appFrom.value+"&appTo="+document.applicationForm.appTo.value+"&req_sessionstatus="+document.applicationForm.req_sessionstatus.value,"Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=800,scrollbars=1;")
 	//window.open("./printIssue.jsp?req_sessionname="+document.applicationForm.req_sessionname.value+"&req_boardname="+document.applicationForm.req_boardname.value+"&req_sessionid="+document.applicationForm.req_sessionid.value+"&req_boardid="+document.applicationForm.req_boardid.value+"&standardnamegp="+document.applicationForm.standardnamegp.value+"&standardpublishid="+document.applicationForm.standardpublishid.value+"&req_sessionstatus="+document.applicationForm.req_sessionstatus.value,"Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=800,scrollbars=1;")
}
	


</script>
</head>

<body  bgcolor="#ffffff" topmargin=10 leftmargin=0 rightmargin=0 onload="window.print()">

<%@ include file="../Report/printHead.jsp" %> 

<form name="MainForm" method="post" action="">
<div id="main_container">

	<div class="header">
	

   
	   </div>

    <div class="main_content">
    

    <div class="center_content">

     <div class="left_content">

    </div>

    <div class="right_content">
    
    <%
	if(flage_temp.equals("Book"))
	{
		BookList=query_object.get_All_IssuedBooks_DateWise(startdate,enddate,sessionid,"bookMaster",instituteid); 
	}
	else if(flage_temp.equals("Journal"))
	{
		JournalList=query_object.get_All_IssuedBooks_DateWise(startdate,enddate,sessionid,"Journal",instituteid);  

	}
    
	if(flage_temp.equals("Book"))
	{
    //out.print("<h2>"+bundle.getString("label.datewisebookissue.entryrootpath1")+"</h2>");
    
	}
	else if(flage_temp.equals("Journal"))
	{
	   // out.print("<h2>"+bundle.getString("label.datewisebookissue.entryrootpath2")+"</h2>");

	}



%>	

<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0 cellpadding=0>
	<tr>
		<td>

<table border=0 width="100%">
    		<tr valign="top">
            <td class="tablebold" valign="top" width="20%">
				<%				
				if(flage_temp.equals("Book"))
				{
				   out.print("<b>Book Issued List</b>");
				   
				}
				else if(flage_temp.equals("Journal"))
				{
				   out.print("<b>Journal Issued List</b>");
				
				}
		
				%>

            </td>
            <td class="tablebold" width="1%">:</td>
            <td width="20%" class="tablelight">
           
			</td>					
			<td class="tablebold" valign="top"  width="20%">
            </td>
               <td class="tablebold" width="1%"></td>
             <td  width="20%" class="tablelight">
            
			</td>
			</tr> 
			</table>
<br>
<table border=0 width="100%">
    		<tr valign="top">
            <td class="tablebold" valign="top" width="20%"><b><%=bundle.getString("label.datewisebooksearch.StartDate") %></b>
            </td>
            <td class="tablebold" width="1%">:</td>
            <td width="20%" class="tablelight">
           <%=startdate %>
			</td>					
			<td class="tablebold" valign="top"  width="20%"><b><%=bundle.getString("label.datewisebooksearch.EndDate") %></b>
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
 
   
</table>
<%

if(flage_temp.equals("Book"))
{
%>
   
   
   <table id="rounded-corner1" border=1 summary="Department List" width="100%" cellpadding=0 cellspacing=0 >
    <thead>
    	<tr class=tableheading  >
        	<th scope="col" class="rounded-company" width="5%" rowspan=2><%=bundle.getString("label.datewisebookissue.Sl.No") %></th>
            <th scope="col" class="rounded" width="10%"  rowspan=2 ><%=bundle.getString("label.datewisebookissue.Title") %> </th>
            <th scope="col" class="rounded" width="10%"  rowspan=2><%=bundle.getString("label.datewisebookissue.AccessNo") %></th>
             <th scope="col" class="rounded" width="10%"  rowspan=2><%=bundle.getString("label.datewisebookissue.Author") %></th>
             <th scope="col" class="rounded" width="11%"  rowspan=2><%=bundle.getString("label.datewisebookissue.IssuedDate") %></th>
            <th scope="col" class="rounded" width="10%" colspan=<%=3 %>>Issued To </th>
            <tr  class=tableheading><th width="10%"><%=bundle.getString("label.datewisebookissue.Username") %></th><th width="10%"><%=bundle.getString("label.datewisebookissue.CardNo") %></th><th width="10%"><%=bundle.getString("label.datewisebookissue.Designation") %></th>
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
			    		 String price=BookListMap.get("price")+"";
			    	     String formattedCurrency = null;
			    	     String booktype=BookListMap.get("booktype")+"";
			    	     String author=BookListMap.get("author")+"";
			    	     String edition=BookListMap.get("edition")+"";
			    	     String accessno=BookListMap.get("accessno")+"";
			    	     String uname=BookListMap.get("uname")+"";
			    	     String cardno=BookListMap.get("cardno")+"";
			    	     String rolename=BookListMap.get("rolename")+"";
			    	     String issuedate=BookListMap.get("issuedate")+"";
			    	     String rackname=BookListMap.get("rackname")+"";

		    			if(!tempListRack.contains(rackname))
		    			{
		    				rackname=rackname.trim();
		    				tempListRack.add(rackname);  
			    		 out.print("<tr valign='top'>");
			    		 out.print("<td colspan=8 class='tablebold' width='5%'><b>Rack Name : </b>"+rackname+"</td></tr>");
		    			}
			    		 out.print("<tr valign='top'>");
			    		 out.print("<td class='tablelight' width='5%'>"+j+"</td>");
			    		 %>
			    		<td>
			    		 <%= BookListMap.get("title")%>
			    		 <!--  <div>
			    		 <a href="./BookDetails.jsp?bookmasterid=<%=bookmasterid%>" onclick="return hs.htmlExpand(this, { objectType: 'iframe',headingText: '', maincontentId: 'credits', align: 'center', width: 950, height: 800 } )"><%= BookListMap.get("title")%></a>
			    		 </div>-->
			    		 </td>
			    		<%
			    		if(accessno == null || accessno.equals("") || accessno.equals("-") || accessno.equalsIgnoreCase("null"))
						{
			    			out.print("<td class='tablelight' align='center'>-</td>");
						}
			    		else
			    		{   
			    		 out.print("<td class='tablelight' align='center'>"+BookListMap.get("accessno")+"</td>"); 
			    		}
			    		if(author == null || author.equals("") || author.equals("-") || author.equalsIgnoreCase("null"))
						{
			    			out.print("<td class='tablelight' align='center'>-</td>");
						}
			    		else
			    		{   
			    		 out.print("<td class='tablelight' align='center'>"+BookListMap.get("author")+"</td>"); 
			    		}
			    		if(issuedate == null || issuedate.equals("") || issuedate.equals("-") || issuedate.equalsIgnoreCase("null"))
						{
			    			out.print("<td class='tablelight' align='center'>-</td>");
						}
			    		else
			    		{   
			    		 out.print("<td class='tablelight' align='center'>"+BookListMap.get("issuedate")+"</td>"); 
			    		}
			    		if(uname == null || uname.equals("") || uname.equals("-") || uname.equalsIgnoreCase("null"))
						{
			    			out.print("<td class='tablelight' align='center' align='center'>-</td>");
						}
			    		else
			    		{   
			    		 out.print("<td class='tablelight' align='center'>"+BookListMap.get("uname")+"</td>"); 
			    		}
			    		if(cardno == null || cardno.equals("") || cardno.equals("-") || cardno.equalsIgnoreCase("null"))
						{
			    			out.print("<td class='tablelight' align='center'>-</td>");
						}
			    		else
			    		{   
			    		 out.print("<td class='tablelight' align='center'>"+BookListMap.get("cardno")+"</td>"); 
			    		}
			    		if(rolename == null || author.equals("") || rolename.equals("-") || rolename.equalsIgnoreCase("null"))
						{
			    			out.print("<td class='tablelight' align='center' align='center'>-</td>");
						}
			    		else
			    		{   
			    		 out.print("<td class='tablelight' align='center'>"+BookListMap.get("rolename")+"</td>"); 
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
			
			    
			   
			   
			   <table id="rounded-corner1" border=1 summary="Department List" width="100%" cellpadding=0 cellspacing=0>
    <thead>
    	<tr class=tableheading  >
        	<th scope="col" class="rounded-company" width="5%" rowspan=2><%=bundle.getString("label.datewisebookissue.Sl.No") %></th>
            <th scope="col" class="rounded" width="10%"  rowspan=2 ><%=bundle.getString("label.datewisebookissue.JournalName") %> </th>
            <th scope="col" class="rounded" width="10%"  rowspan=2><%=bundle.getString("label.datewisebookissue.CodeNo") %></th>
             <th scope="col" class="rounded" width="10%"  rowspan=2><%=bundle.getString("label.datewisebookissue.BookType") %></th>
             <th scope="col" class="rounded" width="11%"  rowspan=2><%=bundle.getString("label.datewisebookissue.IssuedDate") %></th>
            <th scope="col" class="rounded" width="10%" colspan=<%=3 %>>Issued To </th>
            <tr  class=tableheading><th width="10%"><%=bundle.getString("label.datewisebookissue.Username") %></th><th width="10%"><%=bundle.getString("label.datewisebookissue.CardNo") %></th><th width="10%"><%=bundle.getString("label.datewisebookissue.Designation") %></th>
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
						    		 String price=BookListMap.get("price")+"";
						    	     String formattedCurrency = null;
						    	     String booktype=BookListMap.get("booktype")+"";
						    	     String issueno=BookListMap.get("issueno")+"";
						    	     String volumeno=BookListMap.get("volumeno")+"";
						    	     String cardno=BookListMap.get("cardno")+"";
						    	     String rolename=BookListMap.get("rolename")+"";
						    	     String issuedate=BookListMap.get("issuedate")+"";
						    	     String uname=BookListMap.get("uname")+"";
						    	     String codeno=BookListMap.get("codeno")+"";
						    	     String rackname=BookListMap.get("rackname")+"";
						    		
						    	     if(!tempListRack.contains(rackname))
						    			{
						    				rackname=rackname.trim();
						    				tempListRack.add(rackname);  
							    		 out.print("<tr valign='top'>");
							    		 out.print("<td colspan=8 class='tablebold' width='5%'><b>Rack Name : </b>"+rackname+"</td></tr>");
						    			}						    	     
						    		 out.print("<tr valign='top'>");
						    		 out.print("<td class='tablelight' width='5%'>"+j+"</td>");
						    		 %>
						    		<td>
						    		<%= BookListMap.get("bookname")%>
						    		 <!--  <div>
						    		 <a href="./JournalBookDeatils.jsp?bookmasterid=<%=bookmasterid%>" onclick="return hs.htmlExpand(this, { objectType: 'iframe',headingText: ' ', maincontentId: 'credits', align: 'center', width: 950, height: 800 } )"><%= BookListMap.get("bookname")%></a>
						    		 </div> -->
						    		 </td>
						    		<%
						    		if(codeno == null || codeno.equals("") || codeno.equals("-") || codeno.equalsIgnoreCase("null"))
									{
						    			out.print("<td class='tablelight' align='center'>-</td>");
									}
						    		else
						    		{   
						    		 out.print("<td class='tablelight' align='center'>"+BookListMap.get("codeno")+"</td>"); 
						    		}
						    		if(booktype == null || booktype.equals("") || booktype.equals("-") || booktype.equalsIgnoreCase("null"))
									{
						    			out.print("<td class='tablelight' align='center'>-</td>");
									}
						    		else
						    		{
						    		 out.print("<td class='tablelight' align='center'>"+BookListMap.get("booktype")+"</td>"); 
						    		}
						    		if(issuedate == null || issuedate.equals("") || issuedate.equals("-") || issuedate.equalsIgnoreCase("null"))
									{
						    			out.print("<td class='tablelight' align='center'>-</td>");
									}
						    		else
						    		{
						    		 out.print("<td class='tablelight' align='center'>"+BookListMap.get("issuedate")+"</td>"); 
						    		}
						    		if(uname == null || uname.equals("") || uname.equals("-") || uname.equalsIgnoreCase("null"))
									{
						    			out.print("<td class='tablelight' align='center'>-</td>");
									}
						    		else
						    		{
						    		 out.print("<td class='tablelight' align='center'>"+BookListMap.get("uname")+"</td>"); 
						    		}
						    		
						    		if(cardno == null || cardno.equals("") || cardno.equals("-") || cardno.equalsIgnoreCase("null"))
									{
						    			out.print("<td class='tablelight' align='center'>-</td>");
									}
						    		else
						    		{
						    		 out.print("<td class='tablelight' align='center'>"+BookListMap.get("cardno")+"</td>"); 
						    		}
						    		if(rolename == null || rolename.equals("") || rolename.equals("-") || rolename.equalsIgnoreCase("null"))
									{
						    			out.print("<td class='tablelight' align='center'>-</td>");
									}
						    		else
						    		{
						    		 out.print("<td class='tablelight' align='center'>"+BookListMap.get("rolename")+"</td>"); 
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
<br>
<%@ include file="../Report/printFoot.jsp" %>

			</table>
		


     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->



</div>

    </form>
	
</body>
</html>