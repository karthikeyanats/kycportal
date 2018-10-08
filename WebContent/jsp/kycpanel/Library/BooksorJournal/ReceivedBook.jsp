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
<title><%=bundle.getString("label.receivedbook.entrytitle") %></title>

<script type="text/javascript" src="../highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/highslide/highslide.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript">
hs.graphicsDir = "<%=request.getContextPath()%>/js/highslide/graphics/"; 
hs.outlineType = 'rounded-white'; 
hs.wrapperClassName = 'draggable-header';  
</script>     

<script language="JavaScript">
function optionselect(obj)
{
var status=obj.value;
	if(status=="Book")
	{
		document.MainForm.flage.value="Book";
		document.MainForm.submit();
	
	}
	else
	{
		document.MainForm.flage.value="Journal";
		document.MainForm.submit();
	}
}
	


</script>
</head>

<body>
	<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Library.BooksorJournal.BookSearch" />
<%@ page import="java.util.HashMap,java.text.NumberFormat,java.util.Locale"%>
<% 	java.util.ResourceBundle bundle1 	= 	java.util.ResourceBundle.getBundle("resources.serversetup");%>
<%

ArrayList BookList_book=new ArrayList();
ArrayList BookList_journal=new ArrayList();

String sessionid=session.getValue("sessionid")+"";
String instituteid=session.getValue("instituteid")+"";
String flage=request.getParameter("flage")+"";
BookList_book=query_object.get_Received_Books(sessionid,"bookMaster",instituteid);      

if(flage!=null)
{
    
	 if(flage.equals("Journal"))
	{
		BookList_journal=query_object.get_Received_Journals(sessionid,"Journal",instituteid);   

	}      
}

Locale localcurrency = new Locale(bundle1.getString("language"), bundle1.getString("code"));

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

    out.print("<h2>"+bundle.getString("label.receivedbook.entryrootpath")+"</h2>");


%>	  
<input type="hidden" name="flage" value="<%=flage %>">
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	<tr>
		<td>

    <table  border=0  width="100%">
    <tr>
    <td align="center" colspan=6>
    <%
    if(flage==null || flage.equals("null") || flage.equalsIgnoreCase("NULL"))
    {
    %>
    <input type="radio" name="selectoption" value="Book" checked onclick="optionselect(this)"><font size=3>Book</font>&nbsp;
    <input type="radio" name="selectoption" value="Journal" onclick="optionselect(this)"><font size=3>Journal</font>
    <%
    }
    else
    {
    	if(flage.equals("Book"))
    	{
    		out.print("<input type='radio' name='selectoption' value='Book' checked onclick='optionselect(this)'><font size=3>Book</font>&nbsp;&nbsp;");
    		out.print("<input type='radio' name='selectoption' value='Journal'  onclick='optionselect(this)'><font size=3>Journal</font>");

    	}
    	else if(flage.equals("Journal"))
    	{
    		out.print("<input type='radio' name='selectoption' value='Book'  onclick='optionselect(this)'><font size=3>Book</font>&nbsp;&nbsp;");
    		out.print("<input type='radio' name='selectoption' value='Journal' checked onclick='optionselect(this)'><font size=3>Journal</font>");

    	}
    }
    %>
    </td>
    </tr>
  
    </table>
       </br>
    
   
</table>
<%
if(flage.equals("null") ||flage.equalsIgnoreCase("NULL") || flage.equals("Book") )
{


%>
<table width="100%" align="center">
<tr><td colspan=2 class="tablebold">Received Book List</td></tr>
</table>
 	<table id="rounded-corner" border=0  width="100%">
    <thead>
    	<tr> 
        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.receivedbook.SL.No") %></th>
        	<th scope="col" class="rounded" width="20%"><%=bundle.getString("label.receivedbook.Title") %> </th>
            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.receivedbook.Author") %> </th>
            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.receivedbook.Edition") %> </th>
            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.receivedbook.Price") %> </th>
      	    <th scope="col" class="rounded-q4" width="25%"><%=bundle.getString("label.receivedbook.DateofCreation") %> </th>
        	
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=5  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
   
		
				<% 
				
				 HashMap BookListMap=new HashMap();
				try
				{
			     if(BookList_book!=null && BookList_book.size()>0)
			     {
			    	 for(int i=0,j=1;i<BookList_book.size();i++,j++)
			    	 {
			    		 BookListMap=(HashMap)BookList_book.get(i);
			    		 String bookmasterid=BookListMap.get("bookmasterid")+"";
			    		 String newdates=BookListMap.get("newdates")+"";
			    		 String price=BookListMap.get("price")+"";
			    	     String formattedCurrency = null;
			    	     String booktype=BookListMap.get("booktype")+"";
			    	     String author=BookListMap.get("author")+"";
			    	     String edition=BookListMap.get("edition")+"";
			    	     String startdate=BookListMap.get("startdate")+"";
			    	     String enddate=BookListMap.get("enddate")+"";

			    		 if(price == null)
			       	 	 {
			    			 price = "0";
			       	  	 }
			    		 out.print("<tr valign='top'>");
			    		 out.print("<td class='tablelight'>"+j+"</td>");
			    		 %>
			    		<td>
			    		 <div>
			    		 <a href="./BookDetails.jsp?bookmasterid=<%=bookmasterid%>" onclick="return hs.htmlExpand(this, { objectType: 'iframe',headingText: '', maincontentId: 'credits', align: 'center', width: 950, height: 800 } )"><%= BookListMap.get("title")%></a>
			    		 </div>
			    		 </td>
			    		<%
			    		if(author == null || author.equals("") || author.equals("-") || author.equalsIgnoreCase("null"))
						{
			    			out.print("<td class='tablelight'>-</td>");
						}
			    		else
			    		{   
			    		 out.print("<td class='tablelight'>"+BookListMap.get("author")+"</td>"); 
			    		}
			    		if(edition == null || edition.equals("") || edition.equals("-") || edition.equalsIgnoreCase("null"))
						{
			    			out.print("<td class='tablelight'>-</td>");
						}
			    		else
			    		{
			    		 out.print("<td class='tablelight'>"+BookListMap.get("edition")+"</td>"); 
			    		}
			    		if(price == null || price.equals("") || price.equals("-") || price.equalsIgnoreCase("null"))
						{
			    			out.print("<td class='tablelight'>-</td>");

						}
			    		else
			    		{
			    			 Long lObj2 = Long.valueOf(price);
				      	     NumberFormat format = NumberFormat.getCurrencyInstance(localcurrency);
				      	     formattedCurrency = format.format(lObj2);
				      	    
				    		 out.print("<td class='tablelight'>"+formattedCurrency+"</td>"); 
			    		}
			    		
			    		 out.print("<td class='tablelight'>"+newdates+"</td>"); 
			    		 out.print("</tr>");
			    	 }
			     }
			     else
			     {
			    	 out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>Data Not Found</font></td></tr>");
			    	 //out.print("<tr><td colspan=6 align='center'>Data Not Found</td></tr>");
			     }
				}
				catch(Exception e)
				{
					System.out.println(e);
				}

				%>
			</table>
		 
		<%
		}

else if(flage.equals("Journal"))
{
		%>
<table width="100%" align="center">
<tr><td colspan=2 class="tablebold">Received Journal List</td></tr>
</table>
		<table id="rounded-corner" border=0  width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.receivedbook.SL.No") %></th>
        	<th scope="col" class="rounded" width="20%"><%=bundle.getString("label.receivedbook.BookName") %> </th>
            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.receivedbook.issueno") %> </th>
            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.receivedbook.volumeno") %> </th>
            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.receivedbook.Price") %> </th>
      	    <th scope="col" class="rounded-q4" width="25%"><%=bundle.getString("label.receivedbook.DateofCreation") %> </th>
        	
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=5  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
   
		
				<% 
				 HashMap BookListMap=new HashMap();
				try
				{
			     if(BookList_journal!=null && BookList_journal.size()>0)
			     {
			    	 for(int i=0,j=1;i<BookList_journal.size();i++,j++)
			    	 {
			    		 BookListMap=(HashMap)BookList_journal.get(i);
			    		 String bookmasterid=BookListMap.get("bookmasterid")+"";
			    		 String newdates=BookListMap.get("newdates")+"";
			    		 String price=BookListMap.get("price")+"";
			    	     String formattedCurrency = null;
			    	     String booktype=BookListMap.get("booktype")+"";
			    	     String issueno=BookListMap.get("issueno")+"";
			    	     String volumeno=BookListMap.get("volumeno")+"";
			    	     String startdate=BookListMap.get("startdate")+"";
			    	     String enddate=BookListMap.get("enddate")+"";
			    		
						 if(price == null)
			       	 	 {
			    			 price = "0";
			       	  	 }
			    		 out.print("<tr valign='top'>");
			    		 out.print("<td class='tablelight'>"+j+"</td>");
			    		 %>
			    		<td>
			    		 <div>
			    		 <a href="./JournalBookDeatils.jsp?bookmasterid=<%=bookmasterid%>" onclick="return hs.htmlExpand(this, { objectType: 'iframe',headingText: '', maincontentId: 'credits', align: 'center', width: 950, height: 800 } )"><%= BookListMap.get("bookname")%></a>
			    		 </div>
			    		 </td>
			    		<%
			    		if(issueno == null || issueno.equals("") || issueno.equals("-") || issueno.equalsIgnoreCase("null"))
						{
			    			out.print("<td class='tablelight'>-</td>");
						}
			    		else
			    		{   
			    		 out.print("<td class='tablelight'>"+BookListMap.get("issueno")+"</td>"); 
			    		}
			    		if(volumeno == null || volumeno.equals("") || volumeno.equals("-") || volumeno.equalsIgnoreCase("null"))
						{
			    			out.print("<td class='tablelight'>-</td>");
						}
			    		else
			    		{
			    		 out.print("<td class='tablelight'>"+BookListMap.get("volumeno")+"</td>"); 
			    		}
			    		if(price == null || price.equals("") || price.equals("-") || price.equalsIgnoreCase("null"))
						{
			    			out.print("<td class='tablelight'>-</td>");

						}
			    		else
			    		{
			    			 Long lObj2 = Long.valueOf(price);
				      	     NumberFormat format = NumberFormat.getCurrencyInstance(localcurrency);
				      	     formattedCurrency = format.format(lObj2);
				      	    
				    		 out.print("<td class='tablelight'>"+formattedCurrency+"</td>"); 
			    		}
			    		

			    		 out.print("<td class='tablelight'>"+newdates+"</td>"); 
			    		 out.print("</tr>");
			    	 }
			     }
			     else
			     {
			    	 out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>Data Not Found</font></td></tr>");
			    	 //out.print("<tr><td colspan=6 align='center'>Data Not Found</td></tr>");
			     }
				}
				catch(Exception e)
				{
					System.out.println(e);
				}

				%>
			
			
		</table>
<%
}
%>

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../../include/footer.jsp" %>

</div>

    </form>
	
</body>
</html>