package com.iGrandee.Report;
import com.lowagie.text.pdf.PdfWriter;
import java.io.FileOutputStream;
import java.io.File;
import org.apache.log4j.Logger;
import java.util.ArrayList;
import java.util.HashMap;
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
import com.iGrandee.Prinicipal.PrinicipalQuery;
import com.iGrandee.Application.RegistrationProcess;
import com.iGrandee.Common.DateTime;
import com.iGrandee.Registration.InstitutionQurey;
import com.lowagie.text.pdf.PdfPageEventHelper;



public class SubjectAllotmentList extends PdfPageEventHelper
{
	static Logger log = Logger.getLogger(SubjectAllotmentList.class);

	 public static void main(String[] args)
	    {
	    }
	DateTime datobj =new DateTime();
	InstitutionQurey insquery=new InstitutionQurey();
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

	 @return  PDf 
	 
	 */
public void SubjectAllotmentList(String sessionname,String sessionid,String instituteid,String boardid,String boardname)
{
	log.info("invoking sessionname,sessionid for allot the  subject ");

ArrayList StandardList=new ArrayList();
ArrayList StaffList=new ArrayList();
PrinicipalQuery prinicipal =new PrinicipalQuery();
String filepath=null;
String temppath=null;
String storagepath=null;


HashMap hashmap=new HashMap();
try
{
Document document = new Document(PageSize.A4, 30, 30, 111, 40);
try {
	ResourceBundle bundle  =ResourceBundle.getBundle("resources.serversetup");
	 storagepath = bundle.getString("storagepath");
	 File f1= new File(storagepath+instituteid+"/archivalpdfs/"+sessionname+"_"+sessionid+"/Subject allotment List");
	 if(!f1.isDirectory())
	 		f1.mkdirs();
	 		
	 		String time=datobj.showTime("Time").replaceAll(":","_");
	temppath=storagepath+instituteid+"/archivalpdfs/"+sessionname+"_"+sessionid+"/Subject allotment List/output.pdf";
	filepath=storagepath+instituteid+"/archivalpdfs/"+sessionname+"_"+sessionid+"/Subject allotment List/SubjectAllotmentList "+datobj.showTime("calendar")+" "+time+".pdf";
	PdfWriter writer = PdfWriter.getInstance(document,new FileOutputStream(temppath));
    writer.setPageEvent(new SubjectAllotmentList());
	document.open();
	Paragraph p3=new Paragraph("Subject  Allotment List",new Font(Font.TIMES_ROMAN, 14, Font.BOLD,Color.BLACK));
	p3.setAlignment(Element.ALIGN_CENTER);
	document.add(p3);
	Paragraph p1=new Paragraph("Academic Year : "+sessionname,new Font(Font.TIMES_ROMAN, 14, Font.BOLD,Color.BLACK));
	p1.setAlignment(Element.ALIGN_CENTER);
	document.add(p1);
	p1=new Paragraph("Board : "+boardname,new Font(Font.TIMES_ROMAN, 14, Font.BOLD,Color.BLACK));
	p1.setAlignment(Element.ALIGN_CENTER);
	document.add(p1);
	//p1=new Paragraph("( Subject Allotment List )",new Font(Font.TIMES_ROMAN, 10, Font.COURIER,Color.BLACK));
	//p1.setAlignment(Element.ALIGN_CENTER);
	//document.add(p1);
	Paragraph Twogapnext=new Paragraph("\n");
	document.add(Twogapnext);
	Paragraph Twogap=new Paragraph("\n\n");
	if(!sessionid.equals("null") && !sessionid.equals("0"))
	{
		StandardList=prinicipal.loadstandardusingsessionid(sessionid,boardid);
	}
	if(StandardList != null && StandardList.size()>0)
	{
	for(int f=0;f<StandardList.size();f++){
	hashmap		= (HashMap)StandardList.get(f);
	String standardname=hashmap.get("standardname")+"";
	String groupname=hashmap.get("groupname")+"";
	if(!groupname.equals("null"))
	standardname=standardname+" -"+groupname;
	
	p1=new Paragraph("Standard : "+standardname,new Font(Font.TIMES_ROMAN, 12, Font.BOLD,Color.red));
	p1.setAlignment(Element.ALIGN_LEFT);
	document.add(p1);
	document.add(Twogapnext);

	PdfPTable table = new PdfPTable(4);
	int headerwidths[] = { 8, 33, 33, 27}; // percentage
	table.setWidths(headerwidths);
	table.setWidthPercentage(100); // percentage
	table.getDefaultCell().setPadding(1);
	table.getDefaultCell().setBorderWidth(1);
	table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_LEFT);
	table.getDefaultCell().setBackgroundColor(new Color(236,214,255));
	table.addCell(new Paragraph("SL.No",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
	table.addCell(new Paragraph("Staff Name",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
	table.addCell(new Paragraph("Subject Name",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
	table.addCell(new Paragraph("Subject code",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
	table.getDefaultCell().setBackgroundColor(Color.WHITE);
	PdfPCell cell;
	String stdid="";

	if(!sessionid.equals("null") && !sessionid.equals("0"))
	{
		StaffList=prinicipal.loadstaffusingstandardscheduleid(hashmap.get("standardscheduleid")+"");
		stdid=hashmap.get("standardscheduleid")+"";
	}
	ArrayList SubjectList=null;
	if(StaffList != null && StaffList.size()>0)
				{		
				ArrayList sectionList=new ArrayList();
				ArrayList unameList=new ArrayList();
				String tempuname="";

				int gg=1;
				for(int y=0,i=1;y<StaffList.size();y++,i++){
				hashmap		= (HashMap)StaffList.get(y);
				String rolename=hashmap.get("rolename")+"";
				String sectionname=hashmap.get("sectionname")+"";
				String uname=hashmap.get("uname")+"";
				String staffid=hashmap.get("staffid")+"";
				String departmentname=hashmap.get("departmentname")+"";
				String sectionpublishid=hashmap.get("sectionpublishid")+"";

				
				if(!sectionList.contains(sectionname))
				{
					cell = new PdfPCell(new Paragraph("Section :"+sectionname, new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
					cell.setBackgroundColor(new Color(255,229,255));
					cell.setColspan(4);
					table.addCell(cell);
					sectionList.add(sectionname);
				}
				if(!staffid.equals("null") )
				{
					SubjectList=prinicipal.loadsubjectusingstaffid(staffid,stdid,sectionpublishid); 
				}
				if(SubjectList != null && SubjectList.size()>0)
				{
					
					String tempsectionid="";
					for(int g=0;g<SubjectList.size();g++){
					hashmap		= (HashMap)SubjectList.get(g);
					String subjectname=hashmap.get("subjectname")+"";
					String subjectscheduleid=hashmap.get("subjectscheduleid")+"";
					String standardid=hashmap.get("standardid")+"";
					String subjectid=hashmap.get("subjectid")+"";
					String subjectcode=hashmap.get("subjectcode")+"";
					if(subjectcode.equals(""))
					subjectcode="-";
					String sectionid=hashmap.get("sectionid")+"";
					if(!uname.equals(tempuname))
					{
						cell = new PdfPCell(new Paragraph(gg+""));
						cell.setHorizontalAlignment(Element.ALIGN_LEFT);
						table.addCell(cell);
						cell = new PdfPCell(new Paragraph(uname));
						cell.setHorizontalAlignment(Element.ALIGN_LEFT);
						table.addCell(cell);
						cell = new PdfPCell(new Paragraph(subjectname));
						cell.setHorizontalAlignment(Element.ALIGN_LEFT);
						table.addCell(cell);
						cell = new PdfPCell(new Paragraph(subjectcode));
						cell.setHorizontalAlignment(Element.ALIGN_LEFT);
						table.addCell(cell);
						tempuname=uname;
					gg++;
					}
					else
					{
						cell = new PdfPCell(new Paragraph(""));
						cell.setHorizontalAlignment(Element.ALIGN_LEFT);
						cell.setColspan(2);
						table.addCell(cell);
						cell = new PdfPCell(new Paragraph(subjectname));
						cell.setHorizontalAlignment(Element.ALIGN_LEFT);
						table.addCell(cell);
						cell = new PdfPCell(new Paragraph(subjectcode));
						cell.setHorizontalAlignment(Element.ALIGN_LEFT);
						table.addCell(cell);
					}
				}
				}
			else
			{
				cell = new PdfPCell(new Paragraph("Data Not Found", new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
				cell.setBackgroundColor(new Color(255,229,255));
				cell.setColspan(4);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(cell);
			}
			}			

			}
		else
		{
			cell = new PdfPCell(new Paragraph("Staff Not Allotted", new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
			cell.setColspan(4);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(cell);
		}
	document.add(table);

	}

	}

	document.close();
}

catch (DocumentException de)
{
//System.err.println(de.getMessage());
	log.error(de);
}
pagenumber(temppath,filepath,document,instituteid,storagepath);
}
catch(Exception sel)
{
//System.out.println("GeneralException" + sel.getMessage());
	log.error(sel);
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
				        over.setTextMatrix((page.width()-125), (page.height()-20));
				        over.showText("Subject  Allotment List");
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

