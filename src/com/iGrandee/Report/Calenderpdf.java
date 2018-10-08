package com.iGrandee.Report;
import com.iGrandee.Parent.ParentHome;
import com.iGrandee.Report.Calenderpdf;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.DateTime;
import com.iGrandee.SchoolCalender.SchoolCalenderBean;
import com.iGrandee.SchoolCalender.SchoolCalenderEntry;

import com.iGrandee.Registration.InstitutionQurey;

import org.apache.log4j.Logger;

import java.io.FileOutputStream;
import java.io.IOException;
import com.lowagie.text.pdf.PdfWriter;
import java.io.File;
import java.awt.Color;
import com.lowagie.text.*;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.Element;
import java.util.ResourceBundle;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfReader;
import com.lowagie.text.pdf.PdfStamper;
import com.lowagie.text.Image;
public class Calenderpdf
{
	com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery  examQuery = new com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery();
	ParentHome parentquery = new ParentHome();
	DateTime datobj =new DateTime();
	InstitutionQurey insquery=new InstitutionQurey();
	SchoolCalenderEntry query_object=new SchoolCalenderEntry();

	static Logger log = Logger.getLogger(ExamDetailspdf.class);
	public Calenderpdf()
	{
		
		 
	     common_data_object 	= new CommonDataAccess();
	     insert_query 			= null;
	     select_query 			= null;
	     return_value 			= 0;
	     connection				= null;
	 }
	/**
	  * This method is accessed from kycportal/jsp/Reports/ExamDetailspdf.jsp
	  * write all school calendar event  details to pdf          - prasanth
	  @param  instituteid that can be used to get all schoolcalendar Deatils,institution details  from  examname,institution table 
	  *
      @param reg_sessionid that can be used to get all schoolcalendar Deatils,institution details  from  examname,institution table 
      *
      @param sessionname that can be used to get all schoolcalendar Deatils,institution details  from  examname,institution table 
      *
      @param boardid that can be used to get all schoolcalendar Deatils,institution details  from  examname,institution table 
      *
      @param reg_boardnname that can be used to get all schoolcalendar Deatils,institution details  from  examname,institution table 
      *
      @return  int by which result can be printed on the screen
	*/
	public int loadCalenderEventDetails(String instituteid,String reg_sessionid,String sessionname,String boardid,String reg_boardnname) throws Exception
	{  
		log.info("Creating ExamDetails PDF from com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery.java");
		int pdffile=0;
		ArrayList institutearray=null;
			HashMap institutemap=null;
			 String temppath=null;
			 String filepath=null;

		 institutearray=parentquery.InstituteDetailForCircularStudentPage(instituteid);
			
	     

		
		try {  
			ResourceBundle bundle  =ResourceBundle.getBundle("resources.serversetup");
			ResourceBundle bundle1  =ResourceBundle.getBundle("resources.ApplicationResources");
			String storagepath = bundle.getString("storagepath");

		
			
			
			String tem_date=datobj.showTime("WithTime");   
			tem_date = tem_date.substring(0,tem_date.length()-3);  
			tem_date = tem_date.replaceAll(":", "_");
			

			
			String tepfile=storagepath+"/archivalpdfs/SchoolCalender";
			File F=new File(tepfile);
			boolean boo = F.exists(); 
			if(boo)
			{

			}
			else
			{
				F.mkdirs();
			}   

			temppath=storagepath+"/archivalpdfs/"+"/SchoolCalender"+"/output.pdf";
			filepath=storagepath+"/archivalpdfs/"+"/SchoolCalender"+"/SchoolCalender "+tem_date+".pdf" ;

			Document document = new Document(PageSize.A4, 30, 30, 111, 40); 
			PdfWriter writer = PdfWriter.getInstance(document,new FileOutputStream(temppath));
			document.open();
			Paragraph p3=new Paragraph("Calendar Event Details",new Font(Font.TIMES_ROMAN, 14, Font.BOLD,Color.BLACK));
			p3.setAlignment(Element.ALIGN_CENTER);
			document.add(p3);
			Paragraph p1=new Paragraph(bundle1.getString("label.schoolcalendar.academicsession")+" : "+sessionname,new Font(Font.TIMES_ROMAN, 14, Font.BOLD,Color.BLACK));
			p1.setAlignment(Element.ALIGN_CENTER);        
			document.add(p1);   
			Paragraph p2=new Paragraph("("+ bundle1.getString("label.schoolcalendar.boardname")+" : "+reg_boardnname+" )",new Font(Font.COURIER, 10, Font.BOLD,Color.BLACK));
			p2.setAlignment(Element.ALIGN_CENTER);
			document.add(p2);
			Paragraph newgap=new Paragraph("\n");   
			document.add(newgap);
			
			
			String institutename="";                      
			String photo="";   
			if(institutearray != null ||institutearray.size()>0 )                
			{
				for(int i=0;i<institutearray.size();i++)
				{
					institutemap=(HashMap)institutearray.get(i);

					 photo=storagepath+(String)institutemap.get("institutelogo");
					  institutename=(String)institutemap.get("institutename");
	 
					
				}
				
			}
			
			
			 
			 calendderbean	= new SchoolCalenderBean();
			 calendderbean.setSessionid(reg_sessionid);
			 calendderbean.setboardid(boardid);
			 calendderbean.setinstituteid(instituteid);

				ArrayList eventList = query_object.eventListRK(calendderbean);

			int inc =1;
			String temp_total  = "";
			String status_ori = null;
			PdfPTable table = new PdfPTable(4);
			PdfPCell cell;
			 
			int headerwidths[] = { 8, 15, 25, 12}; 
			table.setWidths(headerwidths);
			table.setWidthPercentage(100); 
			table.getDefaultCell().setPadding(2);
			table.getDefaultCell().setBorderWidth(1); 
			table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_LEFT);
			
			table.getDefaultCell().setBackgroundColor(new Color(236,214,255));
			table.addCell(new Paragraph(bundle1.getString("label.schoolcalendar.slno"),new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
			table.addCell(new Paragraph(bundle1.getString("label.schoolcalendar.eventdate"),new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
			table.addCell(new Paragraph(bundle1.getString("label.schoolcalendar.eventname"),new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
			table.addCell(new Paragraph(bundle1.getString("label.schoolcalendar.holidaystatus"),new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
			table.getDefaultCell().setBackgroundColor(Color.WHITE);
						
				
			
			if(eventList!=null &&eventList.size() > 0 )
			{
			for(int s=0,s1=1;s<eventList.size();s++,s1++)
			{
					HashMap map=(HashMap)eventList.get(s);
					String calendarid=(String)map.get("schoolcalendarid");
					String eventdescription=(String)map.get("eventdescription");
					String eventdate=(String)map.get("newdates");
					String newdates1=(String)map.get("newdates1");
	
					String status=(String)map.get("calendarstatus");
					String sessionstatus=(String)map.get("sessionstatus");
					String holidaystatus=(String)map.get("holidaystatus");
					

  
					 cell = new PdfPCell(new Paragraph(s1+""));   
					 table.addCell(cell);
					 cell = new PdfPCell(new Paragraph(eventdate));
					  table.addCell(cell);
			 		cell = new PdfPCell(new Paragraph(eventdescription));
			 		table.addCell(cell);
			 		//cell = new PdfPCell(new Paragraph(newdates1));
			 		//table.addCell(cell);
			 		if(holidaystatus.equals("Y"))
			 		{
			 			cell = new PdfPCell(new Paragraph("Holiday"));
				 		table.addCell(cell);
			 		}
			 		else
			 		{
			 			cell = new PdfPCell(new Paragraph("-"));
				 		table.addCell(cell);
			 		}
				}
			         pdffile=1;  
			
			}
			else
			{
				    cell = new PdfPCell(new Paragraph("Data Not Found", new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
					cell.setBackgroundColor(new Color(255,255,255));
					cell.setColspan(4);
					cell.setHorizontalAlignment(Element.ALIGN_CENTER);
					table.addCell(cell);
					 pdffile=0;  
			}
			document.add(table);
			document.close();  

		
			   	
			  

			 
			  pagenumber(temppath,filepath,document,instituteid,storagepath); 
	}
	
		catch (DocumentException de)      
		{
			log.error(de);
		} catch (IOException ioe) 
		{
			ioe.printStackTrace();

			log.error(ioe);
		}
		
		log.info("PDF is created sussecefully ");
		return pdffile;

	}
	
	public void pagenumber(String s,String s1,Document document,String insid,String storagepath)
	{
		try {					

	              Rectangle page = document.getPageSize();
			      PdfReader reader = new PdfReader(s);

			      int n = reader.getNumberOfPages();
			      PdfStamper stamp = new PdfStamper(reader, new FileOutputStream(s1));

			      int i = 0;

			      PdfContentByte over;
			      BaseFont bf = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED);

			      while (i < n) {
			        i++;
			        over = stamp.getOverContent(i);
			        /*over.beginText();
		        over.setFontAndSize(bf, 10);
		        over.setTextMatrix((page.width()-150), (page.height()-20));
		        over.showText("Calendar Event Details");
		        over.setFontAndSize(bf, 2f);
		        over.endText();*/
		        try {
		        	ArrayList insdetails=insquery.getInstituteDetails(insid);
		         	if(insdetails!=null && insdetails.size()>0)
		        	{
		        		HashMap map=(HashMap)insdetails.get(0);
			        	String inslogo=map.get("institutelogo")+"";
			        	String insname=map.get("institutename")+"";
			        	String contactaddress=map.get("contactaddress")+"";
			        	String country=map.get("country")+"";
			        	String landlinenumber="Phone :" + map.get("landlinenumber")+"";
			        	String state=map.get("state")+"";
			        	String zip=  map.get("zip")+"";
			        	String fax="Fax:" + map.get("fax")+"";

			        	String emailid="Email:"+map.get("emailid")+"";
			        	String url=map.get("url")+"";
			        	
			        	if(url.equals("-") || url.equals("") || url.trim()=="")
			        		url="";
			        	else
			        		url="Website :"+url;
			        	if(zip.equals("-") || zip.equals("") || zip.trim()=="")
			        		zip="";
			        	else
			        		zip="Zipcode :"+zip;
			        	
			        	Image jpg = Image.getInstance(storagepath+inslogo);
			        	jpg.scaleAbsolute(100, 100);
			        	jpg.setAbsolutePosition(10,(page.height()-100));
			        	over.addImage(jpg);
			        	over.beginText();
	   			        over.setFontAndSize(bf, 12);
	   			        over.setTextMatrix(120, (page.height()-50));
	   			        over.showText(insname);
	   			        over.endText();
	   			        over.beginText();
	   			        over.setFontAndSize(bf, 9);    
	   			        over.setTextMatrix((page.width()/2)+120, (page.height()-10));  
	   			        over.showText(contactaddress);
	   			        over.endText();
	   			        over.beginText();
	   			        over.setFontAndSize(bf, 9);
	   			        over.setTextMatrix((page.width()/2)+120, (page.height()-20));
	   			        over.showText(state);
	   			        over.endText(); 
	   			        over.beginText();
	   			        over.setFontAndSize(bf, 9);
	   			        over.setTextMatrix((page.width()/2)+120, (page.height()-30));
	   			        over.showText(country);
	   			        over.endText(); 
	   			        over.beginText();
	   			        over.setFontAndSize(bf, 9);
	   			        over.setTextMatrix((page.width()/2)+120, (page.height()-40));
	   			        over.showText(zip);
	   			        over.endText(); 
	   			        over.beginText();
	   			        over.setFontAndSize(bf, 9);
	   			        over.setTextMatrix((page.width()/2)+120, (page.height()-50));
	   			        over.showText(landlinenumber);
	   			        over.endText();
	   			        over.beginText();
				        over.setFontAndSize(bf, 9);
				        over.setTextMatrix((page.width()/2)+120, (page.height()-60));
				        over.showText(fax);
				        over.endText();
	   			        over.beginText();
	   			        over.setFontAndSize(bf, 9);
	   			        over.setTextMatrix((page.width()/2)+120, (page.height()-70));
	   			        over.showText(emailid);
	   			        over.endText();
	   			        over.beginText();
	   			        over.setFontAndSize(bf, 9);
	   			        over.setTextMatrix((page.width()/2)+120, (page.height()-80));
	   			        over.showText(url);
	   			        over.endText();   
		        	}
		        	}
		        	catch(Exception e)
		        	{
		        		log.error("",e);
		        	}
			        over.beginText();
			        over.setFontAndSize(bf, 10);
			        over.setTextMatrix((page.width()-20)/2, 20);
			        over.showText("- " + i+" -");
			        over.endText();
			        over.beginText();
		        over.setFontAndSize(bf, 9);
		        over.setTextMatrix((page.width()-100), 20);
		        over.showText(datobj.showTime("calendar")+" "+datobj.showTime("Time"));
		        over.endText();
		        for (int j=0;j<(page.width());j++)
		        {
		        over.beginText();
		        over.setFontAndSize(bf, 15);
		        over.setTextMatrix(j, (page.height()-108));
		        over.showText("-");
		        over.endText();
		        }
		        for (int j=0;j<(page.width());j++)
		        {
		        over.beginText();
		        over.setFontAndSize(bf, 15);
		        over.setTextMatrix(j, 30);
		        over.showText("-");
		        over.endText();
		        }
			      }
			      stamp.close();
			    }

			    catch (Exception de)
			    {
			    	log.error(de);
			    }
			    
		}


	

	CommonDataAccess common_data_object;
	String insert_query;
	String select_query;
	int 	return_value;
	int[] returnvalue;
	Connection connection;
	SchoolCalenderBean calendderbean;
}
