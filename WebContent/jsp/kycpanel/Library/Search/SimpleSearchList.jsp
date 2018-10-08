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
<title><%=bundle.getString("label.simplesearch.entrytitle") %></title>

<script type="text/javascript" src="../highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/highslide/highslide.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript">
hs.graphicsDir = "<%=request.getContextPath()%>/js/highslide/graphics/"; 
hs.outlineType = 'rounded-white'; 
hs.wrapperClassName = 'draggable-header';  
</script> 


</head>

<body>
	<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Library.Search.Search" />
<%@ page import="java.util.HashMap,java.text.NumberFormat,java.util.Locale"%>
<% 	java.util.ResourceBundle bundle1 	= 	java.util.ResourceBundle.getBundle("resources.serversetup");%>
<%
ArrayList BookList_book=new ArrayList();
ArrayList BookList_journal=new ArrayList();
String flage=request.getParameter("flage")+"";
String typedbookname="";
String typedjournalname="";
String sessionid=session.getValue("sessionid")+"";
String instituteid=session.getValue("instituteid")+"";
boolean flage_msg=false;
if(flage.equals("null")) 
	flage="Book";

	
	if(flage.equals("Book"))
	{
		typedbookname=request.getParameter("typedbookname").trim()+"";
		if(typedbookname!=null && !typedbookname.equals("")&& !typedbookname.equals("null") && !typedbookname.equalsIgnoreCase("null"))
		{

			if(typedbookname.charAt(0)!='%' && typedbookname.charAt(1)!='%' && typedbookname.charAt(2)!='%')
			{
			BookList_book=query_object.get_Received_Books(sessionid,"bookMaster",instituteid,typedbookname);   
			}
			else
			{
				flage_msg=true;
			}
		}
	}
	else
	{
		typedjournalname=request.getParameter("typedjournalname").trim()+"";
		if(typedjournalname!=null && !typedjournalname.equals("")&& !typedjournalname.equals("null") && !typedjournalname.equalsIgnoreCase("null"))
		{
			if(typedjournalname.charAt(0)!='%' && typedjournalname.charAt(1)!='%' && typedjournalname.charAt(2)!='%')
			{
			BookList_journal=query_object.get_Received_Journals(sessionid,"Journal",instituteid,typedjournalname);
			}
			else
			{
				flage_msg=true;
			}
		}
	}
%>
<form name="MainForm" method="post" action="">
<input type="hidden" name="flage" value="<%=flage %>">

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
 
        out.print("<h2>"+bundle.getString("label.simplesearch.entryrootpath")+" / "+flage+"</h2>");

%>	  

<TABLE BORDER=0  bgColor=white CELLSPACING=0 WIDTH=97% align=center HEIGHT=92% CELLPADDING=0 id="center_main_table">
 
<%
if(flage.equals("Book"))
{
%>
 <TR VALIGN="TOP">
  <td>
<table id="rounded-corner" border=0  width="100%">
    <thead>
    	<tr>  
        	<th scope="col" class="rounded-company" width="20%"><%=bundle.getString("label.studentpromotion.SelectedInformation") %></th>
        	<th scope="col" class="rounded" width="1%"></th>
        	<th scope="col" class="rounded" width="20%" ></th>
            <th scope="col" class="rounded" width="20%" ></th>
            <th scope="col" class="rounded" width="1%" ></th>
            <th scope="col" class="rounded-q4" width="20%" ></th>
            
        </tr>
    </thead>
    <tbody>
    
	<tr>
		<td  class="tablebold" width="20%"><%=bundle.getString("label.receivedbook.Title") %>
		</td>
		<td class="tablebold" width="1%">:
		</td>
		<td  class="tablelight" width="20%" colspan=4><%=typedbookname %>
		</td>
		
	</tr>
	
    </tbody>
    <tfoot> 
    	<tr>
        	<td colspan=5  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
</table>
</td>
</TR>
</table>
<br>
 <table width="100%" align="center">
<tr><td colspan=2 class="tablebold"><%=bundle.getString("label.simplesearch.searchedbooknames") %></td></tr>
</table>
 	<table id="rounded-corner" border=0  width="100%">
    <thead>
    	<tr> 
        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.receivedbook.SL.No") %></th>
        	<th scope="col" class="rounded" width="20%"><%=bundle.getString("label.receivedbook.Title") %> </th>
            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.receivedbook.Author") %> </th>
            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.receivedbook.Edition") %> </th>
      	    <th scope="col" class="rounded-q4" width="25%"><%=bundle.getString("label.simplesearch.Availability") %> </th>
        	
        </tr>
    </thead>
    <tbody>
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
    		 String avail=BookListMap.get("avail")+"";
    	     String formattedCurrency = null;
    	     String booktype=BookListMap.get("booktype")+"";
    	     String author=BookListMap.get("author")+"";
    	     String edition=BookListMap.get("edition")+"";

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
    		if(avail == null || avail.equals("null") || avail.equalsIgnoreCase("null") )
			{
    			out.print("<td class='tablelight'>Yes</td>");

			}
    		else
    		{
    						      	    
	    		 out.print("<td class='tablelight'>No</td>"); 
    		}
    		
    		 out.print("</tr>");
    	 }
     }
     else
     {
    	
    	 out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
    	
     }
	}
	catch(Exception e)
	{
		System.out.println(e);
	}

	
    %>
    </tbody>
    <tfoot>
    	<tr>
        	<td colspan=4  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
    </table>
    
	<%
	}else{%>
		
		<TR VALIGN="TOP">
		  <td>
		<table id="rounded-corner" border=0  width="100%">
		    <thead>
		    	<tr>  
		        	<th scope="col" class="rounded-company" width="20%"><%=bundle.getString("label.studentpromotion.SelectedInformation") %></th>
		        	<th scope="col" class="rounded" width="1%"></th>
		        	<th scope="col" class="rounded" width="20%" ></th>
		            <th scope="col" class="rounded" width="20%" ></th>
		            <th scope="col" class="rounded" width="1%" ></th>
		            <th scope="col" class="rounded-q4" width="20%" ></th>
		            
		        </tr>
		    </thead>
		    <tbody>
		    
			<tr>
		<td  class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.JournalName") %>
		</td>
		<td class="tablebold" width="1%">:
		</td>
		<td  class="tablelight" width="20%" colspan=4><%=typedjournalname %>
		</td>
		
	</tr>
	
		    </tbody>
		    <tfoot> 
		    	<tr>
		        	<td colspan=5  class="rounded-foot-left"><em></em></td>
		        	<td class="rounded-foot-right">&nbsp;</td>
		       </tr>
		    </tfoot>
		</table>
		</td>
		</TR>
		</table>
<br>
		<table width="100%" align="center">
<tr><td colspan=2 class="tablebold"><%=bundle.getString("label.simplesearch.searchedjournalnames") %></td></tr>
</table>
 	<table id="rounded-corner" border=0  width="100%">
    <thead>
    	<tr> 
        		<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.receivedbook.SL.No") %></th>
        	<th scope="col" class="rounded" width="20%"><%=bundle.getString("label.datewisebooksearch.JournalName") %> </th>
            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.receivedbook.issueno") %> </th>
            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.receivedbook.volumeno") %> </th>
      	    <th scope="col" class="rounded-q4" width="25%"><%=bundle.getString("label.simplesearch.Availability") %> </th>
        	
        </tr>
    </thead>
    <tbody>
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
    		 String avail=BookListMap.get("avail")+"";
    	     String formattedCurrency = null;
    	     String booktype=BookListMap.get("booktype")+"";
    	     String issueno=BookListMap.get("issueno")+"";
    	     String volumeno=BookListMap.get("volumeno")+"";
    	    
    		
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
    		if(avail == null || avail.equals("null") || avail.equalsIgnoreCase("null") )
			{
    			out.print("<td class='tablelight'>Yes</td>");

			}
    		else
    		{
    						      	    
	    		 out.print("<td class='tablelight'>No</td>"); 
    		}
    		

    		 out.print("</tr>");
    	 }
     }
     else
     {
    	
    	 out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
    	
     }
	}
	catch(Exception e)
	{
		System.out.println(e);
	}

    %>
    </tbody>
    <tfoot>
    	<tr>
        	<td colspan=4  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
    </table>
<%	} %>
</table>


		 <a href="./SimpleSearch.jsp"  class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.cardissue.back") %> </strong><span class="bt_blue_r"></span></a>


          
     

     
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../../include/footer.jsp" %>

</div>

    </form>

<script language="JavaScript">




</script>	
</body>
</html>