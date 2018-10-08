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

	
function submitfun()
{
	if(check_ForParticularElements(document.MainForm.startdate,"text",document.MainForm.enddate,"text"))
	{
		document.MainForm.action= "BookSearch.jsp";
		document.MainForm.submit(); 
		
	}

		

}


</script>
</head>

<body>

	<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Library.BooksorJournal.BookSearch" />
<%@ page import="java.util.ArrayList,java.util.HashMap,java.text.NumberFormat,java.util.Locale"%>
<% 	java.util.ResourceBundle bundle1 	= 	java.util.ResourceBundle.getBundle("resources.serversetup");%>
<%
ArrayList BookList=new ArrayList();
String flage="";
flage=request.getParameter("flage");
String sessionid=session.getValue("sessionid")+"";
String instituteid=session.getValue("instituteid")+"";
String startdate="";
String enddate="";
String department="";
String departmentname="";
String flage_temp=request.getParameter("flage_temp");
String count="";
count=request.getParameter("count");
ArrayList JournalList=new ArrayList();
if(flage.equals("DateWise"))
{
	startdate=request.getParameter("startdate");
	enddate=request.getParameter("enddate");
	if(flage_temp.equals("Book"))
	{
		BookList=query_object.get_All_Books_DateWise(startdate,enddate,sessionid,"bookMaster",instituteid); 
	}
	else if(flage_temp.equals("Journal"))
	{
		JournalList=query_object.get_All_Books_DateWise(startdate,enddate,sessionid,"Journal",instituteid);  

	}
}
else if(flage.equals("DepartmentWise"))
{	
	department=request.getParameter("department");
	departmentname=request.getParameter("departmentname");
	BookList=query_object.get_All_Books_RackWise(department,sessionid,"bookMaster",instituteid); 

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
if(flage.equals("DateWise"))
{
	if(flage_temp.equals("Book"))
	{
    out.print("<h2>"+bundle.getString("label.datewisebooksearch.entryrootpath1")+"</h2>");
    
	}
	else if(flage_temp.equals("Journal"))
	{
	    out.print("<h2>"+bundle.getString("label.datewisebooksearch.entryrootpath2")+"</h2>");

	}

}
else
{
    out.print("<h2>"+bundle.getString("label.departmentwisewisebookmastersearch.entryrootpath")+"</h2>");

}
%>	

<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	<tr>
		<td>

<%
if(flage.equals("DateWise"))
{
%>	
	<table id="rounded-corner" border=0 summary="Department List" width="100%">
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
  
    <%}else
    {%>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	  <th scope="col" class="rounded-company" width="20%"><%=bundle.getString("label.datewisebooksearch.SelectedInformation")%></th>
        	  <th scope="col" class="rounded" width="1%"></th>
              <th scope="col" class="rounded" width="20%"></th>
              <th scope="col" class="rounded" width="20%"></th>
              <th scope="col" class="rounded" width="1%"></th>
              <th scope="col" class="rounded-q4" width="20%" ></th>
            
        </tr>
    </thead>
   <tbody>
    		<tr valign="top">
            <td class="tablebold" valign="top" width="20%"><%=bundle.getString("label.datewisebooksearch.departmentname") %>
            </td>
            <td class="tablebold" width="1%">:</td>
            <td width="20%" class="tablelight" >
           <%=departmentname %>
			</td>
			 <td class="tablebold" valign="top" width="20%"><%=bundle.getString("label.datewisebooksearch.NoofBooks") %>
            </td>
            <td class="tablebold" width="1%">:</td>
            <td width="20%" class="tablelight" >
           <%=count %>
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
<%
}
%>
</table>
<%
if(flage_temp.equals("Book"))
{
%>
 	<table id="rounded-corner" border=0  width="100%">
    <thead>
    	<tr> 
        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.datewisebooksearch.SL.No") %></th>
        	<th scope="col" class="rounded" width="20%"><%=bundle.getString("label.datewisebooksearch.Title") %> </th>
            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.datewisebooksearch.Author") %> </th>
            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.datewisebooksearch.Edition") %> </th>
            <th scope="col" class="rounded" width="15%"><%=bundle.getString("label.datewisebooksearch.Price") %> </th>
      	    <th scope="col" class="rounded-q4" width="25%"><%=bundle.getString("label.datewisebooksearch.DateofCreation") %> </th>
        	
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
			     if(BookList!=null && BookList.size()>0)
			     {
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
}
else if(flage_temp.equals("Journal"))
{%>

				
				<table id="rounded-corner" border=0  width="100%">
			    <thead>
			    	<tr>
			        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.datewisebooksearch.SL.No") %></th>
			        	<th scope="col" class="rounded" width="20%"><%=bundle.getString("label.datewisebooksearch.JournalName") %> </th>
			            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.datewisebooksearch.issueno") %> </th>
			            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.datewisebooksearch.volumeno") %> </th>
			            <th scope="col" class="rounded" width="15%"><%=bundle.getString("label.datewisebooksearch.Price") %> </th>
			      	    <th scope="col" class="rounded-q4" width="25%"><%=bundle.getString("label.datewisebooksearch.DateofCreation") %> </th>
			        	
			            
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
						     if(JournalList!=null && JournalList.size()>0)
						     {
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

						    		 if(price == null)
						       	 	 {
						    			 price = "0";
						       	  	 }
						    		 out.print("<tr valign='top'>");
						    		 out.print("<td class='tablelight'>"+j+"</td>");
						    		 %>
						    		<td>
						    		 <div>
						    		 <a href="./JournalBookDeatils.jsp?bookmasterid=<%=bookmasterid%>" onclick="return hs.htmlExpand(this, { objectType: 'iframe',headingText: ' ', maincontentId: 'credits', align: 'center', width: 950, height: 800 } )"><%= BookListMap.get("bookname")%></a>
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

							
						
						
					
					
				
				}
%>
			</table>
		<% if(flage.equals("DateWise"))
		{%>
		<a href="DateWiseBooks.jsp" class="bt_green" ><span class="bt_green_lft"></span><strong><%=bundle.getString("button.datewisebooksearch.Back") %> </strong><span class="bt_green_r"></span></a>
		
		<%}else
		{
		%>
		<!-- <a href="DepartmentWiseBookMasterSearch.jsp" class="bt_green" ><span class="bt_green_lft"></span><strong><%=bundle.getString("button.datewisebooksearch.Back") %> </strong><span class="bt_green_r"></span></a> -->
			<a href="RackWiseSearch.jsp" class="bt_green" ><span class="bt_green_lft"></span><strong><%=bundle.getString("button.datewisebooksearch.Back") %> </strong><span class="bt_green_r"></span></a>
	
		<%
		}%>

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../../include/footer.jsp" %>

</div>

    </form>
	
</body>
</html>