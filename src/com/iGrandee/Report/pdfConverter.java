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

public class pdfConverter {
	DateTime datobj = new DateTime();
	InstitutionQurey insquery = new InstitutionQurey();

	public void generatePdf(ArrayList studentList, String sessionname,
			String institutelogo, String institutename) {

		// String institutelogo = (String)session.getValue("institutelogo");
		ArrayList innerList2 = new ArrayList();

		String ddpage = null;
		String ddpagedd = null;

		String name = "";
		String role = "";
		String dept = "";

		try {

			Document document = new Document(PageSize.A4, 30, 30, 105, 40);

			try {
				// ResourceBundle bundle
				// =ResourceBundle.getBundle("resources.serversetup");
				// String storagepath = bundle.getString("egovvirtuald_serverpath");
				String storagepath = "C:/Documents and Settings/subhashchandran_d.IGSTDEV/Desktop/";
				ddpagedd = storagepath + "PDFReports/studentList1.pdf";

				ddpage = storagepath + "PDFReports/Student List for "
						+ sessionname + ".pdf";

				PdfWriter writer = PdfWriter.getInstance(document,
						new FileOutputStream(storagepath
								+ "PDFReports/studentList1.pdf"));
				document.open();

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
				// System.out.println("studentList.size()-->"+studentList.size());
				ArrayList tempStdList = new ArrayList();
				if (studentList != null && studentList.size() > 0) {
					for (int i = 0, j = 1; i < studentList.size(); i++) {
						// System.out.println("0-->");
						HashMap applicantListMap = (HashMap) studentList.get(i);
						String stdSchedId = (String) applicantListMap
								.get("standardscheduleid");
						String applicantName = (String) applicantListMap
								.get("applicantname");
						String rollNo = (String) applicantListMap.get("rollno");
						String standardName = (String) applicantListMap
								.get("standardname");
						String groupName = (String) applicantListMap
								.get("groupname");
						String secName = (String) applicantListMap
								.get("sectionname");
						String emailId = (String) applicantListMap
								.get("emailid");
						// System.out.println("1-->");
						if (!tempStdList.contains(stdSchedId)) {
							PdfPCell cell1;
							cell1 = new PdfPCell(new Paragraph("Standard : "
									+ standardName, new Font(Font.TIMES_ROMAN,
									11, Font.BOLD, Color.black)));
							// cell.setBackgroundColor(new Color(255,229,255));
							cell1.setBackgroundColor(new Color(14, 138, 188));
							cell1.setColspan(5);
							table.addCell(cell1);
							// System.out.println("2-->");
							table.addCell(new Paragraph("SL.No", new Font(
									Font.TIMES_ROMAN, 11, Font.BOLD,
									Color.black)));
							table.addCell(new Paragraph("Name of Student ",
									new Font(Font.TIMES_ROMAN, 11, Font.BOLD,
											Color.black)));
							table.addCell(new Paragraph("Roll No", new Font(
									Font.TIMES_ROMAN, 11, Font.BOLD,
									Color.black)));
							table.addCell(new Paragraph("Section", new Font(
									Font.TIMES_ROMAN, 11, Font.BOLD,
									Color.black)));
							table.addCell(new Paragraph("Email ID", new Font(
									Font.TIMES_ROMAN, 11, Font.BOLD,
									Color.black)));
							table.getDefaultCell().setBackgroundColor(
									Color.WHITE);
						}
						// System.out.println("3-->");
						String seri = (i + 1) + "";
						cell = new PdfPCell(new Paragraph(seri));
						cell.setHorizontalAlignment(Element.ALIGN_LEFT);
						table.addCell(cell);

						// String names=timesheetAList.get(9).toString();
						cell = new PdfPCell(new Paragraph(applicantName));
						cell.setHorizontalAlignment(Element.ALIGN_LEFT);
						table.addCell(cell);

						// String roles=timesheetAList.get(5).toString();
						if (rollNo == null || rollNo.equals("null"))
							rollNo = "-";

						cell = new PdfPCell(new Paragraph(rollNo));
						cell.setHorizontalAlignment(Element.ALIGN_LEFT);
						table.addCell(cell);

						cell = new PdfPCell(new Paragraph(secName));
						cell.setHorizontalAlignment(Element.ALIGN_LEFT);
						table.addCell(cell);
						// System.out.println("4-->");
						cell = new PdfPCell(new Paragraph(emailId));
						cell.setHorizontalAlignment(Element.ALIGN_LEFT);
						table.addCell(cell);
						tempStdList.add(stdSchedId);
					}
				}

				// String temp_deptid="";
				// table.getDefaultCell().setBackgroundColor(new Color(236,214,255));
				table.getDefaultCell().setBackgroundColor(
						new Color(96, 200, 242));

				// table.add(new Font(Font.TIMES_ROMAN, 12,Font.BOLD,Color.black));

				// table.getDefaultCell().new Font(Font.TIMES_ROMAN,
				// 12,Font.BOLD,Color.black)));
				/*
				 * table.addCell(new Paragraph("SL.No",new Font(Font.TIMES_ROMAN,
				 * 11,Font.BOLD,Color.black))); table.addCell(new Paragraph("Name of Student
				 * ",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black))); table.addCell(new
				 * Paragraph("Roll No",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
				 * table.addCell(new Paragraph("Section",new Font(Font.TIMES_ROMAN,
				 * 11,Font.BOLD,Color.black))); table.addCell(new Paragraph("Email ID",new
				 * Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
				 * table.getDefaultCell().setBackgroundColor(Color.WHITE);
				 */

				// if(applicantList!=null && applicantList.size()>0)
				// {
				// for (int i = 0, j = 1; i < applicantList.size(); i++) {
				// HashMap applicantListMap=(HashMap)applicantList.get(i);
				// String applicationId = (String)applicantListMap.get("applicationid");
				// String applicantName = (String)applicantListMap.get("applicantname");
				// String applicationNo = (String)applicantListMap.get("applicationno");
				// String emailId = (String)applicantListMap.get("emailid");
				// PdfPTable appTable = new PdfPTable(2);
				// appTable.addCell(applicantName);
				// appTable.addCell(applicationNo);
				// document.add(new Paragraph(applicantName));
				// document.add(table);
				/*
				 * String seri=(i+1)+""; cell = new PdfPCell(new Paragraph(seri));
				 * cell.setHorizontalAlignment(Element.ALIGN_LEFT); table.addCell(cell);
				 * 
				 * //String names=timesheetAList.get(9).toString(); cell = new PdfPCell(new
				 * Paragraph(applicantName)); cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				 * table.addCell(cell);
				 * 
				 * //String roles=timesheetAList.get(5).toString(); cell = new PdfPCell(new
				 * Paragraph(applicationNo)); cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				 * table.addCell(cell);
				 * 
				 * cell = new PdfPCell(new Paragraph("Section A"));
				 * cell.setHorizontalAlignment(Element.ALIGN_LEFT); table.addCell(cell);
				 * 
				 * cell = new PdfPCell(new Paragraph(emailId));
				 * cell.setHorizontalAlignment(Element.ALIGN_LEFT); table.addCell(cell);
				 */

				// String tstatus = "";
				// table.getDefaultCell().setBackgroundColor(Color.green);
				// document.add(new Paragraph(applicantName));
				// document.add(new Paragraph(applicationNo));
				// }
				// }
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
			System.out.println("institutelogo-->" + institutelogo);
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
