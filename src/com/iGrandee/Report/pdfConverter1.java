// Decompiled by DJ v3.6.6.79 Copyright 2004 Atanas Neshkov  Date: 7/14/2005 12:23:48 PM
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   CircularQueryClass.java
package com.iGrandee.Report;

import java.awt.Color;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ResourceBundle;

import com.iGrandee.Common.DateTime;
import com.iGrandee.Registration.InstitutionQurey;
import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.ExceptionConverter;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfReader;
import com.lowagie.text.pdf.PdfStamper;
import com.lowagie.text.pdf.PdfWriter;

public class pdfConverter1 {
	DateTime datobj = new DateTime();
	InstitutionQurey insquery = new InstitutionQurey();

	public void methodpdf(ArrayList applicantList, String sessionname,
			String institutelogo, String institutename) {

		// String institutelogo = (String)session.getValue("institutelogo");
		ArrayList innerList2 = new ArrayList();

		String ddpage = null;
		String ddpagedd = null;

		String name = "";
		String role = "";
		String dept = "";
		// String sendmail="SendMail";
		String proper = "";
		String mailfor = "";
		/*
		 * String[] fromsplit=from.split("-"); String aa=fromsplit[2]; String
		 * aa1=fromsplit[1]; String aa2=fromsplit[0]; String
		 * strartdae=aa+"-"+aa1+"-"+aa2;
		 * 
		 * String[] tospilit=to.split("-"); String aaa=tospilit[2]; String
		 * aaa1=tospilit[1]; String aaa2=tospilit[0]; String
		 * enddate=aaa+"-"+aaa1+"-"+aaa2;
		 */

		try {

			Document document = new Document(PageSize.A4, 30, 30, 105, 40);

			try {

				// ResourceBundle bundle
				// =ResourceBundle.getBundle("resources.serversetup");
				// String storagepath = bundle.getString("egovvirtuald_serverpath");
				String storagepath = "C:/Documents and Settings/subhashchandran_d.IGSTDEV/Desktop/";
				ddpagedd = storagepath + "PDFReports/studentList1.pdf";

				// ddpage=storagepath+"PDFReports/Student List for "+from+" To
				// "+to+".pdf";
				ddpage = storagepath + "PDFReports/Student List for "
						+ sessionname + ".pdf";

				PdfWriter writer = PdfWriter.getInstance(document,
						new FileOutputStream(storagepath
								+ "PDFReports/studentList1.pdf"));
				// PdfWriter.getInstance(document,new FileOutputStream("HelloWorld.pdf"));
				document.open();

				/*
				 * String path = "C:/Documents and
				 * Settings/subhashchandran_d.IGSTDEV/Desktop/output.jpg";
				 * 
				 * PdfPTable table1 = new PdfPTable(2); Image image = Image.getInstance(path);
				 */

				// image.getAbsoluteY();
				/*
				 * PdfPCell cell1 = new PdfPCell(new Paragraph("Cell 1")); PdfPCell cell2 = new
				 * PdfPCell(image, false); table1.setWidthPercentage(10); table1.addCell(cell1);
				 * table1.addCell(cell2);
				 */

				/*
				 * Paragraph header_para = new Paragraph(new Chunk("\n\n\n", new Font(1, 10F, 0,
				 * new Color(0, 0, 255)))); header_para.add(new Chunk(Image.getInstance(path),
				 * 0.0F, 0.0F)); header_para.setAlignment(1); document.add(header_para);
				 */

				// Image jpg = Image.getInstance("RBlogo.gif");
				// *Image jpg = Image.getInstance(path);
				// System.out.println("jpg.getHeight()-->"+jpg.getHeight()+"jpg.getWidth()-->"+jpg.getWidth());

				/*
				 * Paragraph cc2=new Paragraph("i-Grandee Software Technologies",new
				 * Font(Font.TIMES_ROMAN, 10, Font.BOLD,Color.black));
				 * cc2.setAlignment(Element.ALIGN_LEFT); jpg.setAlignment(Image.RIGHT);
				 * document.add(jpg); document.add(cc2);
				 */
				Paragraph Twogap = new Paragraph("\n\n");
				// document.add(Twogap);

				PdfPTable table = new PdfPTable(5);

				PdfPCell cell;
				// System.out.println("timesheetAList(3)-->"+applicantList.size()+"sessionname-->"+sessionname+"institutelogo-->"+institutelogo);
				cell = new PdfPCell(new Paragraph("Board : State Board",
						new Font(Font.TIMES_ROMAN, 11, Font.BOLD, Color.black)));
				// cell.setBackgroundColor(new Color(255,229,255));
				cell.setBackgroundColor(new Color(14, 118, 188));
				cell.setColspan(5);
				table.addCell(cell);

				PdfPCell cell1;
				cell1 = new PdfPCell(new Paragraph("Standard : 1st Standard",
						new Font(Font.TIMES_ROMAN, 11, Font.BOLD, Color.black)));
				// cell.setBackgroundColor(new Color(255,229,255));
				cell1.setBackgroundColor(new Color(14, 138, 188));
				cell1.setColspan(5);
				table.addCell(cell1);

				int headerwidths[] = { 8, 25, 20, 20, 28 }; // percentage
				table.setWidths(headerwidths);
				table.setWidthPercentage(100); // percentage
				table.getDefaultCell().setPadding(1);
				table.getDefaultCell().setBorderWidth(0);
				table.getDefaultCell().setHorizontalAlignment(
						Element.ALIGN_LEFT);
				Paragraph p = new Paragraph();
				// p.add(new Chunk("Timesheet status for the date :"+strartdae+"\t"+
				// "to"+"\t"+enddate, new Font(Font.TIMES_ROMAN, 12,Font.BOLD,Color.black)));
				p.add(new Chunk("Student List for the session :" + sessionname
						+ "\t", new Font(Font.TIMES_ROMAN, 12, Font.BOLD,
						Color.black)));
				document.add(new Paragraph(p));
				Paragraph Twogapnext = new Paragraph("\n");
				document.add(Twogapnext);
				String temp_deptid = "";
				// table.getDefaultCell().setBackgroundColor(new Color(236,214,255));
				table.getDefaultCell().setBackgroundColor(
						new Color(96, 200, 242));

				// table.add(new Font(Font.TIMES_ROMAN, 12,Font.BOLD,Color.black));

				// table.getDefaultCell().new Font(Font.TIMES_ROMAN,
				// 12,Font.BOLD,Color.black)));
				table.addCell(new Paragraph("SL.No", new Font(Font.TIMES_ROMAN,
						11, Font.BOLD, Color.black)));
				table.addCell(new Paragraph("Name of Student ", new Font(
						Font.TIMES_ROMAN, 11, Font.BOLD, Color.black)));
				table.addCell(new Paragraph("Roll No", new Font(
						Font.TIMES_ROMAN, 11, Font.BOLD, Color.black)));
				table.addCell(new Paragraph("Section", new Font(
						Font.TIMES_ROMAN, 11, Font.BOLD, Color.black)));
				table.addCell(new Paragraph("Email ID", new Font(
						Font.TIMES_ROMAN, 11, Font.BOLD, Color.black)));
				table.getDefaultCell().setBackgroundColor(Color.WHITE);

				if (applicantList != null && applicantList.size() > 0) {
					for (int i = 0, j = 1; i < applicantList.size(); i++) {
						HashMap applicantListMap = (HashMap) applicantList
								.get(i);
						String applicationId = (String) applicantListMap
								.get("applicationid");
						String applicantName = (String) applicantListMap
								.get("applicantname");
						String applicationNo = (String) applicantListMap
								.get("applicationno");
						String emailId = (String) applicantListMap
								.get("emailid");
						// PdfPTable appTable = new PdfPTable(2);
						// appTable.addCell(applicantName);
						// appTable.addCell(applicationNo);
						// document.add(new Paragraph(applicantName));
						// document.add(table);

						String seri = (i + 1) + "";
						cell = new PdfPCell(new Paragraph(seri));
						cell.setHorizontalAlignment(Element.ALIGN_LEFT);
						table.addCell(cell);

						// String names=timesheetAList.get(9).toString();
						cell = new PdfPCell(new Paragraph(applicantName));
						cell.setHorizontalAlignment(Element.ALIGN_LEFT);
						table.addCell(cell);

						// String roles=timesheetAList.get(5).toString();
						cell = new PdfPCell(new Paragraph(applicationNo));
						cell.setHorizontalAlignment(Element.ALIGN_LEFT);
						table.addCell(cell);

						cell = new PdfPCell(new Paragraph("Section A"));
						cell.setHorizontalAlignment(Element.ALIGN_LEFT);
						table.addCell(cell);

						cell = new PdfPCell(new Paragraph(emailId));
						cell.setHorizontalAlignment(Element.ALIGN_LEFT);
						table.addCell(cell);

						String tstatus = "";

						// table.getDefaultCell().setBackgroundColor(Color.green);
						// document.add(new Paragraph(applicantName));
						// document.add(new Paragraph(applicationNo));

					}
				}
				/*
				 * for(int i=0,k=1;i<applicantList.size();i++) { ArrayList
				 * timesheetAList=(ArrayList)applicantList.get(i); HashMap
				 * timesheetAList1=(HashMap)applicantList.get(i);
				 * System.out.println("timesheetAList(3)-->"+(String)timesheetAList1.get("applicationid").toString());
				 * if(!timesheetAList.get(2).equals(temp_deptid)) { cell = new PdfPCell(new
				 * Paragraph("Department :"+timesheetAList.get(3).toString(), new
				 * Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
				 * cell.setBackgroundColor(new Color(255,229,255));
				 * 
				 * cell.setColspan(5); table.addCell(cell); temp_deptid
				 * =(String)timesheetAList.get(2); } //else //{
				 * if(timesheetAList.get(6).equals("yes")) {
				 * 
				 * String seri=k+""; cell = new PdfPCell(new Paragraph(seri));
				 * cell.setHorizontalAlignment(Element.ALIGN_LEFT); table.addCell(cell); String
				 * names=timesheetAList.get(9).toString(); cell = new PdfPCell(new
				 * Paragraph(names)); cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				 * 
				 * table.addCell(cell); String roles=timesheetAList.get(5).toString(); cell =
				 * new PdfPCell(new Paragraph(roles));
				 * cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				 * 
				 * table.addCell(cell); String tstatus = "";
				 * if(timesheetAList.get(6).equals("yes")) { tstatus = "Available";
				 * //table.getDefaultCell().setBackgroundColor(Color.green);
				 * 
				 *  } else { tstatus="Not available"; //table.addCell(tstatus); }
				 * 
				 * cell = new PdfPCell(new Paragraph(tstatus));
				 * cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				 * 
				 * table.addCell(cell);
				 * 
				 * //table.getDefaultCell().setBackgroundColor(Color.new Color(255,229,229));
				 * //table.getDefaultCell().setBackgroundColor(Color.new Color(255,229,229));
				 * 
				 * String mailstatus= (String)timesheetAList.get(10); String mail="";
				 * if(mailstatus.indexOf("@") == -1) { mail="Not a proper Mailid";
				 * //table.getDefaultCell().setBackgroundColor(Color.new Color(255,229,229));
				 *  } else { mail=mailstatus; } cell = new PdfPCell(new Paragraph(mail));
				 * cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				 * 
				 * table.addCell(cell);
				 * 
				 * 
				 *  /*
				 * 
				 * String seri=k+""; table.addCell(seri); String
				 * names=timesheetAList.get(9).toString(); table.addCell(names); String
				 * roles=timesheetAList.get(5).toString(); table.addCell(roles); String tstatus =
				 * ""; if(timesheetAList.get(6).equals("yes")) { tstatus = "Available"; } else {
				 * tstatus="Not available"; } //table.getDefaultCell().setBackgroundColor(new
				 * Color(255,229,229));
				 * 
				 * table.addCell(tstatus); String mailstatus= (String)timesheetAList.get(10);
				 * if(mailstatus.indexOf("@") == -1) { table.addCell("Not a proper Mailid"); }
				 * else { table.addCell(mailstatus); }
				 * 
				 *  } else { String seri=k+""; cell = new PdfPCell(new Paragraph(seri));
				 * cell.setBackgroundColor(new Color(255,229,229));
				 * cell.setHorizontalAlignment(Element.ALIGN_LEFT); table.addCell(cell); String
				 * names=timesheetAList.get(9).toString(); cell = new PdfPCell(new
				 * Paragraph(names)); cell.setBackgroundColor(new Color(255,229,229));
				 * cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				 * 
				 * table.addCell(cell); String roles=timesheetAList.get(5).toString(); cell =
				 * new PdfPCell(new Paragraph(roles)); cell.setBackgroundColor(new
				 * Color(255,229,229)); cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				 * 
				 * table.addCell(cell); String tstatus = "";
				 * if(timesheetAList.get(6).equals("yes")) { tstatus = "Available";
				 * //table.getDefaultCell().setBackgroundColor(Color.green);
				 * 
				 *  } else { tstatus="Not available"; //table.addCell(tstatus); }
				 * 
				 * cell = new PdfPCell(new Paragraph(tstatus)); cell.setBackgroundColor(new
				 * Color(255,229,229)); cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				 * 
				 * table.addCell(cell);
				 * 
				 * //table.getDefaultCell().setBackgroundColor(Color.new Color(255,229,229));
				 * //table.getDefaultCell().setBackgroundColor(Color.new Color(255,229,229));
				 * 
				 * String mailstatus= (String)timesheetAList.get(10); String mail="";
				 * if(mailstatus.indexOf("@") == -1) { mail="Not a proper Mailid";
				 * //table.getDefaultCell().setBackgroundColor(Color.new Color(255,229,229));
				 *  } else { mail=mailstatus; } cell = new PdfPCell(new Paragraph(mail));
				 * cell.setBackgroundColor(new Color(255,229,229));
				 * cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				 * 
				 * table.addCell(cell); } k++; }
				 */
				// document.add(table1);
				document.add(table);
				onEndPage(writer, document, institutelogo, institutename);

				document.close();

			}

			catch (DocumentException de) {
				System.err.println(de.getMessage());
			}
			pdfConverter pagenooo = new pdfConverter();
			pagenooo.pagenumber(ddpagedd, ddpage, document);

		}

		catch (Exception sel) {
			System.out.println("GeneralException" + sel.getMessage());
		}

	}

	public void onEndPage(PdfWriter writer, Document document,
			String institutelogo, String institutename) {
		try {

			ResourceBundle bundle = ResourceBundle
					.getBundle("resources.serversetup");
			String storagepath = bundle.getString("storagepath");

			// System.out.println("institutelogo-->"+institutelogo);
			// String path = "Y:/apps_storage/kycstorage/" + institutelogo;
			String path = storagepath + institutelogo;

			ArrayList insdetails = insquery.getInstituteDetails("1");
			if (insdetails != null && insdetails.size() > 0) {
				HashMap map = (HashMap) insdetails.get(0);
				String inslogo = map.get("institutelogo") + "";
				String insname = map.get("institutename") + "";
				String contactaddress = map.get("contactaddress") + "";
				String country = map.get("country") + "";
				String landlinenumber = map.get("landlinenumber") + "";
				String state = map.get("state") + "";
				String mobilenumber = map.get("mobilenumber") + "";
				String emailid = map.get("emailid") + "";
				String url = map.get("url") + "";

				Rectangle page = document.getPageSize();
				Image jpg = Image.getInstance(storagepath + inslogo);
				// Image jpg = Image.getInstance(path);

				Paragraph Twogapnext = new Paragraph("\n");

				jpg.scaleAbsolute(100, 120);
				jpg.setAlignment(Image.LEFT);

				float[] widths = { 2.5f, 2.5f, 1.5f, 3.5f };
				PdfPTable head = new PdfPTable(4);
				head.setWidths(widths);
				head.getDefaultCell().setBorderWidth(0);
				head.setWidthPercentage(100);
				head.addCell(new Paragraph("Student List ", new Font(
						Font.TIMES_ROMAN, 10, Font.BOLD, Color.black)));
				head.addCell("");
				head.addCell(jpg);

				PdfPTable head1 = new PdfPTable(1);
				head1.getDefaultCell().setBorderWidth(0);
				head1.setWidthPercentage(100);
				head1.getDefaultCell().setHorizontalAlignment(
						Element.ALIGN_CENTER);
				head1.getDefaultCell().setVerticalAlignment(Element.ALIGN_TOP);
				head1.addCell(new Paragraph(insname, new Font(Font.TIMES_ROMAN,
						11, Font.BOLD, Color.black)));
				head1.addCell(new Paragraph(contactaddress, new Font(
						Font.TIMES_ROMAN, 9, Font.BOLD, Color.black)));
				head1.addCell(new Paragraph(state + "," + country, new Font(
						Font.TIMES_ROMAN, 9, Font.BOLD, Color.black)));
				head1.addCell(new Paragraph(mobilenumber + "," + emailid,
						new Font(Font.TIMES_ROMAN, 9, Font.BOLD, Color.black)));
				head1.addCell(new Paragraph(url, new Font(Font.TIMES_ROMAN, 9,
						Font.BOLD, Color.black)));
				head.addCell(head1);
				/*
				 * head.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
				 * head.getDefaultCell().setVerticalAlignment(Element.ALIGN_TOP);
				 * head.addCell(new Paragraph(insname, new
				 * Font(Font.TIMES_ROMAN, 10,Font.BOLD,Color.black)));
				 */
				head.getDefaultCell().setColspan(4);
				head.addCell("");
				head.getDefaultCell().setBorderWidth(1);
				head.getDefaultCell().setColspan(4);
				head.getDefaultCell().setBackgroundColor(new Color(0, 0, 0));
				head.addCell("");
				head.setTotalWidth(page.width() - document.leftMargin()
						- document.rightMargin());
				head.writeSelectedRows(0, -1, document.leftMargin(), page
						.height()
						- document.topMargin() + head.getTotalHeight(), writer
						.getDirectContent());

				PdfPTable foot = new PdfPTable(1);
				foot.getDefaultCell().setBorderWidth(1);
				foot.getDefaultCell().setBackgroundColor(new Color(0, 0, 0));
				foot.addCell("");
				foot.getDefaultCell().setBackgroundColor(
						new Color(255, 255, 255));
				foot.getDefaultCell().setBorderWidth(0);
				foot.getDefaultCell().setHorizontalAlignment(
						Element.ALIGN_RIGHT);

				Paragraph footer = new Paragraph(datobj.showTime("calendar")
						+ " " + datobj.showTime("Time"), new Font(
						Font.TIMES_ROMAN, 8, Font.BOLD, Color.black));
				footer.setAlignment(Element.ALIGN_RIGHT);
				foot.addCell(footer);
				foot.setTotalWidth(page.width() - document.leftMargin()
						- document.rightMargin());
				foot.writeSelectedRows(0, -1, document.leftMargin(), document
						.bottomMargin(), writer.getDirectContent());
			}
		} catch (Exception e) {
			throw new ExceptionConverter(e);
		}
	}

	public void pagenumber(String s, String s1, Document document) {
		try {
			Rectangle page = document.getPageSize();
			PdfReader reader = new PdfReader(s);

			int n = reader.getNumberOfPages();
			PdfStamper stamp = new PdfStamper(reader, new FileOutputStream(s1));

			int i = 0;

			PdfContentByte over;
			BaseFont bf = BaseFont.createFont(BaseFont.HELVETICA,
					BaseFont.WINANSI, BaseFont.EMBEDDED);

			while (i < n) {
				i++;

				over = stamp.getOverContent(i);
				over.beginText();
				over.setFontAndSize(bf, 10);
				over.setTextMatrix((page.width() - 20) / 2, 20);
				over.showText("- " + i + " -");
				over.endText();
			}
			stamp.close();
		}

		catch (Exception de) {
			de.printStackTrace();
		}
	}

	public void onEndPage2(PdfWriter writer, Document document,
			String institutelogo, String institutename) {

		try {
			ResourceBundle bundle = ResourceBundle
					.getBundle("resources.serversetup");
			String storagepath1 = bundle.getString("storagepath");

			// System.out.println("institutelogo-->"+institutelogo);
			// String path = "Y:/apps_storage/kycstorage/" + institutelogo;
			String path = storagepath1 + institutelogo;
			Rectangle page = document.getPageSize();
			Image jpg = Image.getInstance(path);
			Paragraph Twogapnext = new Paragraph("\n");

			jpg.scaleAbsolute(100, 100);
			jpg.setAlignment(Image.LEFT);

			float[] widths = { 1.5f, 8.5f };
			PdfPTable head = new PdfPTable(2);
			head.setWidths(widths);
			head.getDefaultCell().setBorderWidth(1);
			head.setWidthPercentage(100);
			head.addCell(jpg);
			head.getDefaultCell().setVerticalAlignment(Element.ALIGN_BOTTOM);
			head.addCell(institutename);
			head.getDefaultCell().setColspan(2);
			head.addCell("");
			head.getDefaultCell().setBorderWidth(1);
			head.getDefaultCell().setColspan(2);
			head.getDefaultCell().setBackgroundColor(new Color(0, 0, 0));
			head.addCell("");

			head.getHorizontalAlignment();
			// head.setTotalWidth(page.width() - document.leftMargin() -
			// document.rightMargin());
			// head.writeSelectedRows(0, -1, document.leftMargin(), page.height() -
			// document.topMargin() +
			// head.getTotalHeight(),writer.getDirectContent());

			PdfPTable foot = new PdfPTable(1);
			foot.getDefaultCell().setBorderWidth(1);
			foot.getDefaultCell().setBackgroundColor(new Color(0, 0, 0));
			foot.addCell("");
			foot.getDefaultCell().setBackgroundColor(new Color(255, 255, 255));
			foot.getDefaultCell().setBorderWidth(0);
			foot.getDefaultCell().setHorizontalAlignment(Element.ALIGN_LEFT);
			Paragraph footer = new Paragraph("Powered by " + institutename
					+ "\n", new Font(Font.TIMES_ROMAN, 10, Font.BOLD,
					Color.black));
			footer.setAlignment(Element.ALIGN_LEFT);
			foot.addCell(footer);
			// foot.setTotalWidth(page.width() - document.leftMargin() -
			// document.rightMargin());
			foot.writeSelectedRows(0, -1, document.leftMargin(), document
					.bottomMargin(), writer.getDirectContent());
		} catch (Exception e) {
			throw new ExceptionConverter(e);
		}

	}

	public void onEndPage1(PdfWriter writer, Document document,
			String institutelogo, String institutename) {
		try {
			Rectangle page = document.getPageSize();
			PdfPTable foot = new PdfPTable(1);
			foot.getDefaultCell().setBorderWidth(1);
			foot.getDefaultCell().setHorizontalAlignment(Element.ALIGN_LEFT);
			Paragraph footer = new Paragraph("Powered by i-Grandee Software\n",
					new Font(Font.TIMES_ROMAN, 10, Font.BOLD, Color.black));
			footer.setAlignment(Element.ALIGN_LEFT);
			foot.addCell(footer);
			// foot.setTotalWidth(page.width() - document.leftMargin() -
			// document.rightMargin());
			foot.writeSelectedRows(0, -1, document.leftMargin(), document
					.bottomMargin(), writer.getDirectContent());

		} catch (Exception e) {
			throw new ExceptionConverter(e);
		}

	}

	public void pagenumber1(String s, String s1, Document document) {
		/*
		 * try { Rectangle page = document.getPageSize(); PdfReader reader = new
		 * PdfReader(s);
		 * 
		 * int n = reader.getNumberOfPages(); PdfStamper stamp = new
		 * PdfStamper(reader, new FileOutputStream(s1));
		 * 
		 * int i = 0;
		 * 
		 * PdfContentByte over; BaseFont bf =
		 * BaseFont.createFont(BaseFont.HELVETICA, BaseFont.WINANSI,
		 * BaseFont.EMBEDDED);
		 * 
		 * while (i < n) { i++;
		 * 
		 * over = stamp.getOverContent(i); over.beginText(); over.setFontAndSize(bf,
		 * 10); //over.setTextMatrix((page.width()-20)/2, 20); over.showText("- " +
		 * i+" -"); over.endText(); } stamp.close(); }
		 * 
		 * catch (Exception de) { de.printStackTrace(); }
		 */
	}

}
