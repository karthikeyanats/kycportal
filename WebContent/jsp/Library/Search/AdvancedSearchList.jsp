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
<title><%=bundle.getString("label.advancesearch.entrytitle") %></title>

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

String searchValue1="";
String searchValue2="";
String searchValue3="";
searchValue1=request.getParameter("searchValue1").trim()+"";
searchValue2=request.getParameter("searchValue2").trim()+"";
searchValue3=request.getParameter("searchValue3").trim()+"";
/*

*/
String operator="";
operator=request.getParameter("operator");

String Like1=request.getParameter("Like1")+"";
String Like2=request.getParameter("Like2")+"";
String Like3=request.getParameter("Like3")+"";

String Link1_temp="";
String Link2_temp="";
String Link3_temp="";

if(Like1.equals("1"))
	Link1_temp="Start With";
else
	Link1_temp="End With";

if(Like2.equals("1"))
	Link2_temp="Start With";
else
	Link2_temp="End With";

if(Like3.equals("1"))
	Link3_temp="Start With";
else
	Link3_temp="End With";


String sessionid=session.getValue("sessionid")+"";
String instituteid=session.getValue("instituteid")+"";
String flage=request.getParameter("flage")+"";
String message="";
int check_count=0;
boolean flage_msg=false;

if(flage.equals("null")) 
flage="Book";

if(flage.equals("Book"))  
{
	if(searchValue1!=null &&  !searchValue1.equals("") && !searchValue1.equals("null") && !searchValue1.equalsIgnoreCase("null"))
	{
		if(searchValue1.charAt(0)=='%' && searchValue1.charAt(1)=='%' && searchValue1.charAt(2)=='%')
		{
			flage_msg=true;
			message=" Book Title ";
			check_count++;
		}
	}
	if(searchValue2!=null &&  !searchValue2.equals("") && !searchValue2.equals("null") && !searchValue2.equalsIgnoreCase("null"))
	{
		if(searchValue2.charAt(0)=='%' && searchValue2.charAt(1)=='%' && searchValue2.charAt(2)=='%')
		{
			flage_msg=true;
			message+=" Publisher ";
			check_count++;
	
		}
	}
	if(searchValue3!=null &&  !searchValue3.equals("") && !searchValue3.equals("null") && !searchValue3.equalsIgnoreCase("null"))
	{
		if(searchValue3.charAt(0)=='%' && searchValue3.charAt(1)=='%' && searchValue3.charAt(2)=='%')
		{
			flage_msg=true;
			message+=" Author ";
			check_count++;
	
		}
	}
	if(check_count==0)
	{
	BookList_book=query_object.get_Received_Books_Advance(sessionid,"bookMaster",instituteid,searchValue1,searchValue2,searchValue3,operator,Like1,Like2,Like3);
	}
	
	}
else
{
	if(searchValue1!=null &&  !searchValue1.equals("") && !searchValue1.equals("null") && !searchValue1.equalsIgnoreCase("null"))
	{
		if(searchValue1.charAt(0)=='%' && searchValue1.charAt(1)=='%' && searchValue1.charAt(2)=='%')
		{
			flage_msg=true;
			message=" Journal Name  ";
			check_count++;
		}
	}
	if(searchValue2!=null &&  !searchValue2.equals("") && !searchValue2.equals("null") && !searchValue2.equalsIgnoreCase("null"))
	{
		if(searchValue2.charAt(0)=='%' && searchValue2.charAt(1)=='%' && searchValue2.charAt(2)=='%')
		{
			flage_msg=true;
			message+=" Publisher ";
			check_count++;
	
		}
	}
	
	if(check_count==0)
	{
	BookList_journal=query_object.get_Received_Journals_Advance(sessionid,"Journal",instituteid,searchValue1,searchValue2,searchValue3,operator,Like1,Like2,Like3);
	}
	
}
if(searchValue1.equals("null") || searchValue1.equals("")) 
	searchValue1="-";
if(searchValue2.equals("null") || searchValue2.equals("")) 
	searchValue2="-";
if(searchValue3.equals("null")|| searchValue3.equals("")) 
	searchValue3="-";
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
 
        out.print("<h2>"+bundle.getString("label.advancesearch.entryrootpath")+" / "+flage+"</h2>");

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
		<td  class="tablebold" width="20%"><%=bundle.getString("label.receivedbook.Title") + " ( "+Link1_temp+" ) "%>
		</td>
		<td class="tablebold" width="1%">:
		</td>
		<td  class="tablelight" width="20%"><%=searchValue1 %> 
		</td>
		<td  class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.publisher")  + " ( "+Link2_temp+" ) "%>
		</td>
		<td class="tablebold" width="1%">:
		</td>
		<td  class="tablelight" width="20%"><%=searchValue2%>
		</td>
	</tr>
	<tr>
	<td  class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.author")  + " ( "+Link3_temp+" ) "%>
		</td>
		<td class="tablebold" width="1%">:
		</td>
		<td  class="tablelight" width="20%"><%=searchValue3%>
		</td>
		<td  class="tablebold" width="20%"><%=bundle.getString("label.advancesearch.operator") %>
		</td>
		<td class="tablebold" width="1%">:
		</td>
		<td  class="tablelight" width="20%"><%=operator %>
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
    		if(avail == null || avail.equals("null") || avail.equalsIgnoreCase("null")  )
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
    	 if(check_count==0)
    	 {
    	 out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
    	 //out.print("<tr><td colspan=6 align='center'>Data Not Found</td></tr>");
    	 }
    	 else
    	 {
        	 out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found Given "+message+" is Invalid</font></td></tr>");

    	 }
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
		<td  class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.JournalName") + " ( "+Link1_temp+" ) "%>
		</td>
		<td class="tablebold" width="1%">:
		</td>
		<td  class="tablelight" width="20%"><%=searchValue1 %>
		</td>
		<td  class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.publisher") + " ( "+Link2_temp+" ) "%>
		</td>
		<td class="tablebold" width="1%">:
		</td>
		<td  class="tablelight" width="20%"><%=searchValue2 %>
		</td>
	</tr>
	<tr>
	<td  class="tablebold" width="20%"><%=bundle.getString("label.newarrivaljournallist.volumeno") + " ( "+Link3_temp+" ) " %>
		</td>
		<td class="tablebold" width="1%">:
		</td>
		<td  class="tablelight" width="20%"><%=searchValue3 %>
		</td>
		<td  class="tablebold" width="20%"><%=bundle.getString("label.advancesearch.operator") %>
		</td>
		<td class="tablebold" width="1%">:
		</td>
		<td  class="tablelight" width="20%"><%=operator %>
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
    	 if(check_count==0)
    	 {
    	 out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
    	 }
    	 else
    	 {
        	 out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found Given "+message+" is Invalid</font></td></tr>");
 
    	 }
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


		 <a href="./AdvancedSearch.jsp"  class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.cardissue.back") %> </strong><span class="bt_blue_r"></span></a>


          
     

     
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