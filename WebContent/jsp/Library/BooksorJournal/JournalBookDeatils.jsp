<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Topper List | Powered by i-Grandee</title>
<LINK rel=stylesheet href="<%=request.getContextPath()%>/css/kyccss.css">
     

	<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Library.BooksorJournal.BookSearch" />
<%@page language="java" import="java.util.ResourceBundle"%>
<%@ page import="java.util.ArrayList,java.util.HashMap,java.text.NumberFormat,java.util.Locale"%>
<% 	java.util.ResourceBundle bundle1 	= 	java.util.ResourceBundle.getBundle("resources.serversetup");%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");

ArrayList BookDeatils=new ArrayList();
HashMap BookDeatilsMap=new HashMap();
String bookmasterid=request.getParameter("bookmasterid");
String sessionid=session.getValue("sessionid")+"";  
String instituteid=session.getValue("instituteid")+"";

BookDeatils=query_object.getBookDeatilsJournal(bookmasterid,sessionid,instituteid); 
Locale localcurrency = new Locale(bundle1.getString("language"), bundle1.getString("code"));


String codeno="";
String rackid="";
String recddate="";
String  publisher="";



 String price="";
 String remarks="";
  String booktype="";
  String retperiod="";
  String bookname="";
  String issn="";
  String issueno="";
  String country="";
  String frequencyid="";
  String deliverymode="";
  String validateperiod="";
  String supplierdetails="";
  String contactno="";
  String subcription="";
  String volumeno="";
  String bookmasterstatus="";
  String createdby="";
  String dateofcreation="";
 String newdates="";
String validateperiod_temp="";
String recddate_temp="";
String retperiod_temp="";
String booktype_temp="";
String formattedCurrency="";
String subcription_temp="";
 
 String rackname="";
 String frequencyname="";
String sessionname="";
try
{
if(BookDeatils!=null && BookDeatils.size()>0)
{
	for(int i=0;i<BookDeatils.size();i++)
	{
		BookDeatilsMap=(HashMap)BookDeatils.get(i);
	
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
		
	
		 booktype=BookDeatilsMap.get("booktype")+"";
		if(booktype == null || booktype.equals("") || booktype.equals("-") || booktype.equalsIgnoreCase("null"))
		{
			 booktype="-";
		}
		
		 bookname=BookDeatilsMap.get("bookname")+"";
		if(bookname == null || bookname.equals("") || bookname.equals("-") || bookname.equalsIgnoreCase("null"))
		{
			 bookname="-";
		}
		 country=BookDeatilsMap.get("country")+"";
		if(country == null || country.equals("") || country.equals("-") || country.equalsIgnoreCase("null"))
		{
			 country="-";
		}
		 deliverymode=BookDeatilsMap.get("deliverymode")+"";
		if(deliverymode == null || deliverymode.equals("") || deliverymode.equals("-") || deliverymode.equalsIgnoreCase("null"))
		{
			 deliverymode="-";
		}
		 supplierdetails=BookDeatilsMap.get("supplierdetails")+"";
		if(supplierdetails == null || supplierdetails.equals("") || supplierdetails.equals("-") || supplierdetails.equalsIgnoreCase("null"))
		{
			supplierdetails="-";
		}
		 contactno=BookDeatilsMap.get("contactno")+"";
		 if(contactno == null || contactno.equals("") || contactno.equals("-") || contactno.equalsIgnoreCase("null"))
			{
			 contactno="-";
			}
		 subcription_temp=BookDeatilsMap.get("subcription_temp")+"";
		 if(subcription_temp == null || subcription_temp.equals("") || subcription_temp.equals("-") || subcription_temp.equalsIgnoreCase("null"))
			{
			 subcription_temp="-";
			}
		 volumeno=BookDeatilsMap.get("volumeno")+"";
		 if(volumeno == null || volumeno.equals("") || volumeno.equals("-") || volumeno.equalsIgnoreCase("null"))
			{
			 volumeno="-";
			}
		 newdates=BookDeatilsMap.get("newdates")+"";
		 if(newdates == null || newdates.equals("") || newdates.equals("-") || newdates.equalsIgnoreCase("null"))
			{
			 newdates="-";
			}
		 validateperiod_temp=BookDeatilsMap.get("validateperiod_temp")+"";
		 if(validateperiod_temp == null || validateperiod_temp.equals("") || validateperiod_temp.equals("-") || validateperiod_temp.equalsIgnoreCase("null"))
			{
			 validateperiod_temp="-";
			}
		 recddate_temp=BookDeatilsMap.get("recddate_temp")+"";
		 if(recddate_temp == null || recddate_temp.equals("") || recddate_temp.equals("-") || recddate_temp.equalsIgnoreCase("null"))
			{
			 recddate_temp="-";
			}
		 retperiod_temp=BookDeatilsMap.get("retperiod_temp")+"";
		 if(retperiod_temp == null || retperiod_temp.equals("") || retperiod_temp.equals("-") || retperiod_temp.equalsIgnoreCase("null"))
			{
			 retperiod_temp="-";
			}

	codeno=BookDeatilsMap.get("codeno")+"";
	 if(codeno == null || codeno.equals("") || codeno.equals("-") || codeno.equalsIgnoreCase("null"))
		{
		 codeno="-";
		}
	 rackid=BookDeatilsMap.get("rackid")+"";
	 if(rackid == null || rackid.equals("") || rackid.equals("-") || rackid.equalsIgnoreCase("null"))
		{
		 rackid="-";
		}
	 
	 issn=BookDeatilsMap.get("issn")+"";
	 if(issn == null || issn.equals("") || issn.equals("-") || issn.equalsIgnoreCase("null"))
		{
		 issn="-";
		}
	 issueno=BookDeatilsMap.get("issueno")+"";
	 if(issueno == null || issueno.equals("") || issueno.equals("-") || issueno.equalsIgnoreCase("null"))
		{
		 issueno="-";
		}
	 frequencyid=BookDeatilsMap.get("frequencyid")+"";
	 if(frequencyid == null || frequencyid.equals("") || frequencyid.equals("-") || frequencyid.equalsIgnoreCase("null"))
		{
		 frequencyid="-";
		}
	 	rackname=BookDeatilsMap.get("rackname")+"";
		if(rackname == null || rackname.equals("") || rackname.equals("-") || rackname.equalsIgnoreCase("null"))
		{
			rackname="-";
		}
		frequencyname=BookDeatilsMap.get("frequencyname")+"";
		if(frequencyname == null || frequencyname.equals("") || frequencyname.equals("-") || frequencyname.equalsIgnoreCase("null"))
		{
			frequencyname="-";
		}
		sessionname=BookDeatilsMap.get("sessionname")+"";
		if(sessionname == null || sessionname.equals("") || sessionname.equals("-") || sessionname.equalsIgnoreCase("null"))
		{
			sessionname="-";
		}
	}
}
}
catch(Exception e)	
{
	System.out.println(e);
}
%> 

<table align="center" border=0 width="100%" cellspacing=3 cellpadding=5>

<tr>
<td class="tablebold" colspan=6 align=center><font color="blue" size="3"><u>Journal Details for <%=bookname%></u></font></td>
</tr>
<tr></tr><tr></tr><tr></tr><tr></tr> 

<tr valign="top">
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.codeno") %> </td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%" ><%=codeno%></td>
	
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.JournalName") %> </td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=bookname%></td>

</tr>
<tr valign="top">
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.volumeno") %> </td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=volumeno%></td>
	
	
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.publisher") %></td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=publisher%></td> 
</tr>

<tr valign="top"> 

	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.price") %> </td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=formattedCurrency%></td>
	
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.issn") %></td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=issn%></td> 

</tr>

<tr valign="top">
	
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.rackname") %> </td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=rackname%></td>
	
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.frequencyname") %></td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=frequencyname%></td>     
</tr>
<tr valign="top">
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.recddate") %></td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=recddate_temp%></td>   
	
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.retperiod") %> </td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%" ><%=retperiod_temp%></td>
	    
</tr>
<tr>
<tr valign="top">
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.contactno") %> </td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=contactno%></td>
	
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.country") %></td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=country%></td>  
</tr>
<tr valign="top">	   
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.subcription") %></td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=subcription_temp%></td>   
	
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.sessionname") %></td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=sessionname%></td> 
</tr>
<tr valign="top">	   
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.issueno") %> </td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=issueno%></td>
	
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.deliverymode") %> </td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=deliverymode%></td>
	
</tr>
<tr valign="top">
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.supplierdetails") %></td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=supplierdetails%></td> 
	
	    <td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.validateperiod") %> </td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=validateperiod_temp%></td>
</tr>

<tr valign="top">
	
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.DateofCreation") %></td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=newdates%></td>   
	
	<td class="tablebold" width="20%"><%=bundle.getString("label.datewisebooksearch.remarks") %></td>
	<td class="tablebold" width="1%">:</td>
	<td class="tablelight" width="20%"><%=remarks%></td>  
</tr>
</table>
 
