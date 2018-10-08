package com.iGrandee.Report;
import com.lowagie.text.pdf.PdfWriter;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.awt.Color;
import com.lowagie.text.*;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.Element;
import java.util.ResourceBundle;

import org.apache.log4j.Logger;

import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfReader;
import com.lowagie.text.pdf.PdfStamper;
import com.lowagie.text.Image;
import com.iGrandee.Prinicipal.PrinicipalQuery;
import com.iGrandee.Common.DateTime;
import com.iGrandee.Registration.InstitutionQurey;
import com.lowagie.text.pdf.PdfPageEventHelper;
import com.iGrandee.Attendance.AttendanceQuery;
public class StudentAttendance extends PdfPageEventHelper
{
	static Logger log = Logger.getLogger(StudentAttendance.class);

	DateTime datobj =new DateTime();
	AttendanceQuery attencequery=new AttendanceQuery();
	InstitutionQurey insquery =new InstitutionQurey();
/*
 * Returns Void 
 * This Method is Used to Generate PDF
 *
 @param  sessionname  display Academic Year Label in PDF
 *

 @param  sessionid  Used to List the Selected Academic Content Only
 *

 @param  instituteid  used to List Selected Institute Content Only
 *

 @param  boardid  used to List Selected board Content Only
 *

 @param  boardname  display Board Name  Label in PDF
 *  
                          
 @return Generate PDf

 */
public void StudentAttendance(String sessionname,String sessionid,String instituteid,String boardid,String boardname,String status)
{
	log.info("Invoke StudentAttendance from com.iGrandee.Reports.");
String filepath=null;
String temppath=null;
HashMap hashmap=new HashMap();
try
{
	String storagepath="";
Document document = new Document(PageSize.A4, 30, 30, 111, 40);
try {
	ResourceBundle bundle  =ResourceBundle.getBundle("resources.serversetup");
	 storagepath = bundle.getString("storagepath");
	 File f1= new File(storagepath+instituteid+"/archivalpdfs/"+sessionname+"_"+sessionid+"/Attendance List");
	 if(!f1.isDirectory())
	 		f1.mkdirs();
	 		
	 String time=datobj.showTime("Time").replaceAll(":","_");
	temppath=storagepath+instituteid+"/archivalpdfs/"+sessionname+"_"+sessionid+"/Attendance List/output"+".pdf";
	filepath=storagepath+instituteid+"/archivalpdfs/"+sessionname+"_"+sessionid+"/Attendance List/StudentAttendanceList "+datobj.showTime("calendar")+" "+time+".pdf";
	PdfWriter writer = PdfWriter.getInstance(document,new FileOutputStream(temppath));
	document.open();
	Paragraph Twogapnext=new Paragraph("\n");
	Paragraph p3=new Paragraph("Student Attendance List",new Font(Font.TIMES_ROMAN, 14, Font.BOLD,Color.BLACK));
	p3.setAlignment(Element.ALIGN_CENTER);
	document.add(p3);
	Paragraph p1=new Paragraph("Academic Year : "+sessionname,new Font(Font.TIMES_ROMAN, 14, Font.BOLD,Color.BLACK));
	p1.setAlignment(Element.ALIGN_CENTER);
	document.add(p1);
	p1=new Paragraph("Board : "+boardname,new Font(Font.TIMES_ROMAN, 14, Font.BOLD,Color.BLACK));
	p1.setAlignment(Element.ALIGN_CENTER);
	document.add(p1);
	//p1=new Paragraph("( Student Attendance List )",new Font(Font.TIMES_ROMAN, 10, Font.COURIER,Color.BLACK));
	//p1.setAlignment(Element.ALIGN_CENTER);
	//document.add(p1);
	document.add(Twogapnext);
	Paragraph Twogap=new Paragraph("\n\n");
	
	ArrayList standList=new ArrayList();
	ArrayList studentList=new ArrayList();

	
	if(sessionid != null && boardid!= null )
	{
		 standList=attencequery.loadstandard(boardid,sessionid,instituteid);
	}
	if(standList!=null && standList.size()>0)
	{
		ArrayList tempList=new ArrayList();

		for(int i=0;i<standList.size();i++)
		{
			HashMap hashmap2 =(HashMap)standList.get(i);
			String Standardname=hashmap2.get("standardname")+"";
			String standardscheduleid=hashmap2.get("standardscheduleid")+"";
			String groupname=hashmap2.get("groupname")+"";
			if(!groupname.equals("null"))
				Standardname=Standardname+" -"+groupname;
			if(!tempList.contains(standardscheduleid))
			{
				document.add(Twogapnext);

				p1=new Paragraph("Standard : "+Standardname,new Font(Font.TIMES_ROMAN, 12, Font.BOLD,Color.red));
				p1.setAlignment(Element.ALIGN_LEFT);
				document.add(p1);
				tempList.add(standardscheduleid);
				document.add(Twogapnext);

			}
			
			PdfPTable table = new PdfPTable(7);
			int headerwidths[] = { 7, 20, 10, 15, 15, 15, 15}; // percentage
			table.setWidths(headerwidths);
			table.setWidthPercentage(100); // percentage
			table.getDefaultCell().setPadding(3);
			table.getDefaultCell().setBorderWidth(1);
			table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_LEFT);
			table.getDefaultCell().setBackgroundColor(new Color(236,214,255));
			table.addCell(new Paragraph("SL.No",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
			table.addCell(new Paragraph("Student Name",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
			table.addCell(new Paragraph("Roll No",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
			table.addCell(new Paragraph("No Of Working Days",new Font(Font.TIMES_ROMAN, 9,Font.BOLD,Color.black)));
			table.addCell(new Paragraph("No Of Present Days",new Font(Font.TIMES_ROMAN, 9,Font.BOLD,Color.black)));
			table.addCell(new Paragraph("No Of Absent Days",new Font(Font.TIMES_ROMAN, 9,Font.BOLD,Color.black)));
			table.addCell(new Paragraph("No Of On Duty Days",new Font(Font.TIMES_ROMAN, 9,Font.BOLD,Color.black)));
			table.getDefaultCell().setBackgroundColor(Color.WHITE);
			PdfPCell cell;

	ArrayList sectionList=new ArrayList();
	if(!standardscheduleid.equals("null") && instituteid!= null )
	{
		sectionList=	attencequery.loadsection(standardscheduleid,instituteid);
	}
	if(sectionList!=null && sectionList.size()>0)
	{
		ArrayList tempList1=new ArrayList();

		for(int j=0;j<sectionList.size();j++)
		{			
			HashMap hashmap3 =(HashMap)sectionList.get(j);
			String sectionscheduleid=hashmap3.get("sectionscheduleid")+"";
			String sectionname=hashmap3.get("sectionname")+"";
			if(!tempList1.contains(sectionscheduleid))
			{
				cell = new PdfPCell(new Paragraph("Section :"+sectionname, new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
				cell.setBackgroundColor(new Color(255,229,255));
				cell.setColspan(7);
				table.addCell(cell);
				tempList1.add(sectionscheduleid);
			}
			if(!sessionid.equals("null") && !boardid.equals("null") && !standardscheduleid.equals("null") && !sectionscheduleid.equals("null")) {
				studentList			= attencequery.loadstudentwithstatus(standardscheduleid,sessionid,sectionscheduleid,instituteid,status);
			}
			if(studentList != null && studentList.size()>0)
			{
			for(int y=0,sl=1;y<studentList.size();y++)
					{
					hashmap					= (HashMap)studentList.get(y);
					String Studname			= (String)hashmap.get("applicantname");
					String rollno			= (String)hashmap.get("rollno");
					String studallocationid	= (String)hashmap.get("studentallocationid");
					cell = new PdfPCell(new Paragraph(sl+""));
					cell.setHorizontalAlignment(Element.ALIGN_CENTER);
					table.addCell(cell);
					cell = new PdfPCell(new Paragraph(Studname,new Font(Font.TIMES_ROMAN, 10,Font.BOLD,Color.black)));
					cell.setHorizontalAlignment(Element.ALIGN_LEFT);
					table.addCell(cell);
					cell = new PdfPCell(new Paragraph(rollno));
					cell.setHorizontalAlignment(Element.ALIGN_LEFT);
					table.addCell(cell);
					
					ArrayList DetailList=new ArrayList();
					DetailList=attencequery.loadNoofworkingdayabsentod(studallocationid,sessionid,instituteid,standardscheduleid,status);
						if(DetailList!=null && DetailList.size()>0)
						{
							HashMap atten=(HashMap)DetailList.get(0);
							cell = new PdfPCell(new Paragraph(atten.get("totalworkingdays")+""));
							cell.setHorizontalAlignment(Element.ALIGN_LEFT);
							table.addCell(cell);
							cell = new PdfPCell(new Paragraph(atten.get("noofpreset")+""));
							cell.setHorizontalAlignment(Element.ALIGN_LEFT);
							table.addCell(cell);
							cell = new PdfPCell(new Paragraph(atten.get("noofabsent")+""));
							cell.setHorizontalAlignment(Element.ALIGN_LEFT);
							table.addCell(cell);
							cell = new PdfPCell(new Paragraph(atten.get("noofod")+""));
							cell.setHorizontalAlignment(Element.ALIGN_LEFT);
							table.addCell(cell);
							sl++;
						}
					}
				}
				else
				{
					cell = new PdfPCell(new Paragraph("Data Not Found"));
					cell.setHorizontalAlignment(Element.ALIGN_CENTER);
					cell.setColspan(7);
					table.addCell(cell);
				}
		}
	}
	document.add(table);
	}
	}

	document.close();
}
catch (DocumentException de)
{
	log.error(de);
//System.err.println(de.getMessage());
}
pagenumber(temppath,filepath,document,instituteid,storagepath);
}
catch(Exception sel)
{
	log.error(sel);
//System.out.println("GeneralException" + sel.getMessage());
}
}

public void pagenumber(String s,String s1,Document document,String insid,String storagepath) {
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
			        over.showText("Student Attendance List");
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
   			      de.printStackTrace();
   			    }
}


}

