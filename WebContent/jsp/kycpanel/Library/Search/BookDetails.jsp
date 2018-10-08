<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Book Details | Powered by i-Grandee</title>
<LINK rel=stylesheet href="<%=request.getContextPath()%>/css/kyccss.css">
     

	<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Library.BooksorJournal.BookSearch" />
<%@page language="java" import="java.util.ResourceBundle"%>
<%@ page import="java.util.ArrayList,java.util.HashMap,java.text.NumberFormat,java.util.Locale"%>
<% 	java.util.ResourceBundle bundle1 	= 	java.util.ResourceBundle.getBundle("resources.serversetup");%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
String instituteid=session.getValue("instituteid")+"";

ArrayList BookDeatils=new ArrayList();
HashMap BookDeatilsMap=new HashMap();
String bookmasterid=request.getParameter("bookmasterid");
String sessionid=session.getValue("sessionid")+"";   
BookDeatils=query_object.getBookDeatils(bookmasterid,sessionid,instituteid); 

Locale localcurrency = new Locale(bundle1.getString("language"), bundle1.getString("code"));

 

String accessno="";  
String rackid="";  
String callno="";  
String issn="";  
String recddate="";
String title="";
String serialtitile="";
String location="";
String publisher="";
String price="";
String remarks="";
String keyword=""; 
String donatedby="";
String author="";
String  corporateauthor="";

String serialauthor="";
String supplier="";
String edition="";
String typeofpurchase="";
String  booktype="";
String  retperiod="";
String bookformat="";

String bookmasterstatus="";
String formattedCurrency="";
String newdates="";
String retperiod_temp="";
String recddate_temp="";

String rackname="";
String bookpurchasetypename="";
String sessionname="";
 
if(BookDeatils!=null && BookDeatils.size()>0)
{
	for(int i=0;i<BookDeatils.size();i++)
	{
		BookDeatilsMap=(HashMap)BookDeatils.get(i);
		
		
	
		
		title=BookDeatilsMap.get("title")+"";
			if(title == null || title.equals("") || title.equals("-") || title.equalsIgnoreCase("null"))
			{
				title="-";
			}
		 serialtitile=BookDeatilsMap.get("serialtitile")+"";
		if(serialtitile == null || serialtitile.equals("") || serialtitile.equals("-") || serialtitile.equalsIgnoreCase("null"))
		{
			 serialtitile="-";
		}
		 location=BookDeatilsMap.get("location")+"";
		if(location == null || location.equals("") || location.equals("-") || location.equalsIgnoreCase("null"))
		{
			 location="-";
		}
		 publisher=BookDeatilsMap.get("publisher")+"";
		if(publisher == null || publisher.equals("") || publisher.equals("-") || publisher.equalsIgnoreCase("null"))
		{
			publisher="-";
		}
		 price=BookDeatilsMap.get("price")+"";
		 if(price == null)
   	 	 {
			 price = "0";
   	  	 }
		 Long lObj2 = Long.valueOf(price);
  	     NumberFormat format = NumberFormat.getCurrencyInstance(localcurrency);
  	     formattedCurrency = format.format(lObj2);
  	     
  	     
		 remarks=BookDeatilsMap.get("remarks")+"";
		if(remarks == null || remarks.equals("") || remarks.equals("-") || remarks.equalsIgnoreCase("null"))
		{
			 remarks="-";
		}
		 keyword=BookDeatilsMap.get("keyword")+"";
		 if(keyword == null || keyword.equals("") || keyword.equals("-") || keyword.equalsIgnoreCase("null"))
		{
			 keyword="-"; 
		}
		 donatedby=BookDeatilsMap.get("donatedby")+"";
		if(donatedby == null || donatedby.equals("") || donatedby.equals("-") || donatedby.equalsIgnoreCase("null"))
		{
			 donatedby="-";
		}
		 author=BookDeatilsMap.get("author")+"";
		if(author == null || author.equals("") || author.equals("-") || author.equalsIgnoreCase("null"))
		{
			author="-";
		}
		 corporateauthor=BookDeatilsMap.get("corporateauthor")+"";
		if(corporateauthor == null || corporateauthor.equals("") || corporateauthor.equals("-") || corporateauthor.equalsIgnoreCase("null"))
		{
			corporateauthor="-";
		}
		 serialauthor=BookDeatilsMap.get("serialauthor")+"";
		 if(serialauthor == null || serialauthor.equals("") || serialauthor.equals("-") || serialauthor.equalsIgnoreCase("null"))
		{
			 serialauthor="-";
		}
		 supplier=BookDeatilsMap.get("supplier")+"";
		if(supplier == null || supplier.equals("") || supplier.equals("-") || supplier.equalsIgnoreCase("null"))
		{
			 supplier="-";
		}
		 edition=BookDeatilsMap.get("edition")+"";
		 if(edition == null || edition.equals("") || edition.equals("-") || edition.equalsIgnoreCase("null"))
		{
			 edition="-";
		}
		 typeofpurchase=BookDeatilsMap.get("typeofpurchase")+"";
	    if(typeofpurchase == null || typeofpurchase.equals("") || typeofpurchase.equals("-") || typeofpurchase.equalsIgnoreCase("null"))
		{
			 typeofpurchase="-";
		}
		 booktype=BookDeatilsMap.get("booktype")+"";
		if(booktype == null || booktype.equals("") || booktype.equals("-") || booktype.equalsIgnoreCase("null"))
		{
			 booktype="-";
		}
		 bookformat=BookDeatilsMap.get("bookformat")+"";
		if(bookformat == null || bookformat.equals("") || bookformat.equals("-") || bookformat.equalsIgnoreCase("null"))
		{
			 bookformat="-";
		}
		newdates=BookDeatilsMap.get("newdates")+"";
		if(newdates == null || newdates.equals("") || newdates.equals("-") || newdates.equalsIgnoreCase("null"))
		{
				newdates="-";
		}
		retperiod_temp=BookDeatilsMap.get("retperiod_temp")+"";
		if(retperiod_temp == null || retperiod_temp.equals("") || retperiod_temp.equals("-") || retperiod_temp.equalsIgnoreCase("null"))
		{
			retperiod_temp="-";
		}
		
		
		
		accessno=BookDeatilsMap.get("accessno")+"";
		if(accessno == null || accessno.equals("") || accessno.equals("-") || accessno.equalsIgnoreCase("null"))
		{
			accessno="-";
		}
		rackid=BookDeatilsMap.get("rackid")+"";
		if(rackid == null || rackid.equals("") || rackid.equals("-") || rackid.equalsIgnoreCase("null"))
		{
			rackid="-";
		}
		callno=BookDeatilsMap.get("callno")+"";
		if(callno == null || callno.equals("") || callno.equals("-") || callno.equalsIgnoreCase("null"))
		{
			callno="-";
		}
		issn=BookDeatilsMap.get("issn")+"";
		if(issn == null || issn.equals("") || issn.equals("-") || issn.equalsIgnoreCase("null"))
		{
			issn="-";
		}
		
		recddate_temp=BookDeatilsMap.get("recddate_temp")+"";
		if(recddate_temp == null || recddate_temp.equals("") || recddate_temp.equals("-") || recddate_temp.equalsIgnoreCase("null"))
		{
			recddate_temp="-";
		}
			
	}
	 rackname=BookDeatilsMap.get("rackname")+"";
	if(rackname == null || rackname.equals("") || rackname.equals("-") || rackname.equalsIgnoreCase("null"))
	{
		rackname="-";
	}
	
	bookpurchasetypename=BookDeatilsMap.get("bookpurchasetypename")+"";
	if(bookpurchasetypename == null || bookpurchasetypename.equals("") || bookpurchasetypename.equals("-") || bookpurchasetypename.equalsIgnoreCase("null"))
	{
		bookpurchasetypename="-";
	}
	sessionname=BookDeatilsMap.get("sessionname")+"";
	if(sessionname == null || sessionname.equals("") || sessionname.equals("-") || sessionname.equalsIgnoreCase("null"))
	{
		sessionname="-";
	}
}

%>            

<table align="center" border=0 width="100%" cellspacing=3 cellpadding=5>
<tr>
<td class="tablebold" colspan=6 align=center><font color="blue" size="3"><u>Book Details for <%=title%></u></font></td>
</tr>
<tr></tr><tr></tr><tr></tr><tr></tr> 
<tr valign="top">
	<td class="tablebold" width="20%" ><%=bundle.getString("label.datewisebooksearch.accessno") %></td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=accessno%></td> 
	
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.title") %> </td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=title%></td>
	
</tr>
<tr valign="top">
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.serialtitile") %></td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=serialtitile%></td>     
	
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.author") %> </td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=author%></td>
	
	
</tr>
<tr valign="top">

	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.serialauthor") %> </td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=serialauthor%></td>
	
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.corporateauthor") %></td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=corporateauthor%></td> 
	
	    
</tr>
<tr valign="top">
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.edition") %> </td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=edition%></td>
	
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.price") %> </td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=formattedCurrency%></td>
	
	 
</tr>
<tr valign="top">

<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.rackname") %> </td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%" ><%=rackname%></td>
	
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.publisher") %></td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=publisher%></td>
	
    
</tr>
<tr valign="top">

	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.donatedby") %></td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=donatedby%></td>    
	
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.supplier") %></td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=supplier%></td>
    
</tr>
<tr valign="top">
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.bookpurchasetypename") %></td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=bookpurchasetypename%></td>  
	
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.bookformat") %></td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=bookformat%></td>    

	   
</tr>
<tr valign="top">

	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.retperiod") %> </td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%" ><%=retperiod_temp%></td>
	
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.location") %> </td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=location%></td>

	   
</tr>

<tr valign="top">

	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.sessionname") %> </td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=sessionname%></td>
	
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.keyword") %> </td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=keyword%></td>

</tr>

<tr valign="top">
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.recddate") %> </td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%" ><%=recddate_temp%></td>
	
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.callno") %> </td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%" ><%=callno%></td>

</tr>

<tr valign="top">   
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.isbn") %> </td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%" ><%=issn%></td>
	
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.DateofCreation") %></td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=newdates%></td>   
</tr>   
<tr valign="top">
	
	
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.remarks") %></td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=remarks%></td> 
	
</tr>
</table>

