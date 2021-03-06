package com.iGrandee.Report;
import com.iGrandee.Parent.ParentHome;
import com.iGrandee.Report.ExamDetailspdf;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.DateTime;
import com.iGrandee.Exam.ExamAllotment.ExamAllotmentBean;
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

public class ExamDetailspdfstdwise
{
	com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery  examQuery = new com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery();
	ParentHome parentquery = new ParentHome();
	DateTime datobj =new DateTime();
	InstitutionQurey insquery=new InstitutionQurey();

	static Logger log = Logger.getLogger(ExamDetailspdf.class);
	public ExamDetailspdfstdwise()
	{
		
		 
	     common_data_object 	= new CommonDataAccess();
	     insert_query 			= null;
	     select_query 			= null;
	     return_value 			= 0;
	     connection				= null;
	 }
	/**
	  * This method is accessed from kycportal/jsp/Reports/ExamDetailspdf.jsp
	  * write all exam details to pdf          - prasanth
	  @param  instituteid that can be used to get all Exam Deatils,institution details  from  examname,institution table 
	  *
      @param  reg_sessionid that can be used to get all Exam Deatils,institution details  from  examname,institution table 
      *
      @param reg_boardnname that can be used to get all Exam Deatils,institution details  from  examname,institution table 
      *
      @param  sessionname that can be used to get all Exam Deatils,institution details  from  examname,institution table 
      *
      @param boardid that can be used to get all Exam Deatils,institution details  from  examname,institution table 
      *
      @return  int by which result can be printed on the screen
	*/
	public int loadExamSubjectList(String instituteid,String reg_sessionid,String sessionname,String boardid,String reg_boardnname  ) throws Exception
	{  
		log.info("Creating ExamDetails PDF from com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery.java");

		int pdffile=0;
		ArrayList institutearray=null;
		ArrayList ExamList=null;
			HashMap institutemap=null;
			 String temppath=null;
			 String filepath=null;

		 institutearray=parentquery.InstituteDetailForCircularStudentPage(instituteid);
			ExamList=examQuery.LoadExamnameListRKbystdwise(instituteid,reg_sessionid,boardid);   
			
			ArrayList subjectList=null; 
	     

		
		try {  
			ResourceBundle bundle  =ResourceBundle.getBundle("resources.serversetup");
			ResourceBundle bundle1  =ResourceBundle.getBundle("resources.ApplicationResources");

			String storagepath = bundle.getString("storagepath");

			//temppath=storagepath+"problems/temp_examdetails.pdf";
			//filepath=storagepath+"problems/ExamDetails for " +sessionname +" "+reg_boardnname+".pdf" ; 
		
			
			
			String tem_date=datobj.showTime("WithTime");   
			tem_date = tem_date.substring(0,tem_date.length()-3);  
			tem_date = tem_date.replaceAll(":", "_");
			
			
			
			String tepfile=storagepath+"/archivalpdfs/StandardWiseExamList";
			File F=new File(tepfile);
			boolean boo = F.exists(); 
			if(boo)
			{
				
			}
			else
			{
				F.mkdirs(); 
			}   

			temppath=storagepath+"/archivalpdfs/StandardWiseExamList/output.pdf";
			filepath=storagepath+"/archivalpdfs/StandardWiseExamList/StandardWiseExamList"+tem_date+".pdf" ;

			Document document = new Document(PageSize.A4, 30, 30, 111, 40); 
			PdfWriter writer = PdfWriter.getInstance(document,new FileOutputStream(temppath));
			document.open();
			Paragraph p3=new Paragraph("Standard Wise Exam Details",new Font(Font.TIMES_ROMAN, 14, Font.BOLD,Color.BLACK));
			p3.setAlignment(Element.ALIGN_CENTER);
			document.add(p3);
			Paragraph p1=new Paragraph(bundle1.getString("label.examdetails.academicsession")+" : "+sessionname,new Font(Font.TIMES_ROMAN, 14, Font.BOLD,Color.BLACK));
			p1.setAlignment(Element.ALIGN_CENTER);
			document.add(p1);   
			Paragraph p2=new Paragraph("("+ bundle1.getString("label.examdetails.boardname")+" : "+reg_boardnname+" ",new Font(Font.COURIER, 12, Font.BOLD,Color.BLACK));
			p2.setAlignment(Element.ALIGN_CENTER);
			document.add(p2);
			/*Paragraph p3=new Paragraph("( Standard Name  : "+req_standardname+" )",new Font(Font.COURIER, 10, Font.BOLD,Color.BLACK));
			p3.setAlignment(Element.ALIGN_CENTER);
			document.add(p3);*/
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
			
			PdfPTable table = new PdfPTable(7);			
			PdfPCell cell;

			if(ExamList!=null && ExamList.size()>0)
			{	
				ArrayList stdscheduleList=new ArrayList();

		 			for (int i = 0, j = 1; i < ExamList.size(); i++,j++	) 
		 			{   
		 			
					HashMap ExamListMap=(HashMap)ExamList.get(i);
					String examId     = (String)ExamListMap.get("examnameid");
					String examName      = (String)ExamListMap.get("examname");
					String examallotmentid= (String)ExamListMap.get("examallotmentid");
					String standardscheduleid_temp      = (String)ExamListMap.get("standardscheduleid");
					String standardname_temp     = (String)ExamListMap.get("standardname");
		 			
					if(!stdscheduleList.contains(examId))
					{
					j=1;
					stdscheduleList.add(examId);
			 		
					Paragraph Twogapnext=new Paragraph("\n");
					document.add(Twogapnext);

					int headerwidths[] = { 8, 35, 19, 18, 12,8,8}; 
					table.setWidths(headerwidths);
					table.setWidthPercentage(100); 
					table.getDefaultCell().setPadding(3);
					table.getDefaultCell().setBorderWidth(1); 
					table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_LEFT);
					table.getDefaultCell().setBackgroundColor(new Color(236,214,255));

					 PdfPCell cell1;
					 cell1 = new PdfPCell(new Paragraph("Standard Name : "+standardname_temp+ "\t\t\t"+" Exam Name : "+examName));
					 cell1.setColspan(7);
					 cell1.setBackgroundColor(new Color(236,214,250));
					 table.addCell(cell1); 
						
					table.addCell(new Paragraph(bundle1.getString("label.examdetails.slno"),new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
					table.addCell(new Paragraph(bundle1.getString("label.examdetails.subjectname"),new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
					table.addCell(new Paragraph(bundle1.getString("label.examdetails.examdate"),new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
					table.addCell(new Paragraph(bundle1.getString("label.examdetails.starttime"),new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
					table.addCell(new Paragraph(bundle1.getString("label.examdetails.endtime"),new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
					table.addCell(new Paragraph(bundle1.getString("label.examdetails.duration"),new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
					table.addCell(new Paragraph(bundle1.getString("label.exam.examtype"),new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
				
					}

					String duration=null;
					String examtype=null;
							    String standardscheduleid="";
						 		
						 		
								String groupname      = (String)ExamListMap.get("groupname")+"";
								String standardname      = (String)ExamListMap.get("standardname");
								if(!groupname.equals("null"))
								{
								standardname=standardname+"  -"+groupname;
								}
								String subjectname      = (String)ExamListMap.get("subjectname");
								String standardid      = (String)ExamListMap.get("standardscheduleid");
								String examdate      = (String)ExamListMap.get("examdate");
								String examtimein      = (String)ExamListMap.get("examtimein");
								String examtimeout      = (String)ExamListMap.get("examtimeout");
								String examtimeinampm      = (String)ExamListMap.get("examtimeinampm");
								String examtimeoutampm      = (String)ExamListMap.get("examtimeoutampm");
								duration      = (String)ExamListMap.get("duration");
								examtype      = (String)ExamListMap.get("examtype");

								//duration = examQuery.getHourMin(examtimein,examtimeout);

								if(examdate == null){
									examdate= " ";}
								if(examtimein == null){   
									examtimein= " ";}   
								if(examtimeout == null){
									examtimeout= " ";}    
								if(ExamListMap.get("examtimein") != null && ExamListMap.get("examtimeout")!=null)
								
								if(!standardscheduleid.equals(standardid))
								{
							 	  
							 		standardscheduleid=standardid;
								}
						 		else
						 		{
						 		
						 		}
								
								
						 		 cell = new PdfPCell(new Paragraph(j+""));
								 table.addCell(cell);
						 		cell = new PdfPCell(new Paragraph(subjectname));
						 		table.addCell(cell);
						 		cell = new PdfPCell(new Paragraph(examdate));
						 		table.addCell(cell);
						 		cell = new PdfPCell(new Paragraph(examtimeinampm));
						 		table.addCell(cell);
						 		cell = new PdfPCell(new Paragraph(examtimeoutampm));
						 		table.addCell(cell);
						 		cell = new PdfPCell(new Paragraph(duration));
						 		table.addCell(cell);
						 		cell = new PdfPCell(new Paragraph(examtype));
						 		table.addCell(cell);
	 			
					
		 			}
		 			document.add(table);
		 			pdffile=1;
			}
			

			ExamDetailspdf pagenooo=new ExamDetailspdf();
			document.close();       
		
			pagenumber(temppath,filepath,document,instituteid,storagepath);  
			

		}
	
		catch (DocumentException de)      
		{
			log.error(de);
			//System.out.print(de);
		} catch (IOException ioe) 
		{
			log.error(ioe);
			//System.out.print(ioe);
		}
		
		log.info("PDF is created sussecefully ");
		//System.out.print("PDF is created sussecefully ");
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
		        over.showText("Standard Wise Exam Details");
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
			        	{log.error("",e);
			        		
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
	ExamAllotmentBean examallotmentBean;
}
