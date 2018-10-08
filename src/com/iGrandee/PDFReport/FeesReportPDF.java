package com.iGrandee.PDFReport;

import java.awt.Color;
import java.io.File;
import java.io.FileOutputStream;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;
import java.util.ResourceBundle;

import com.iGrandee.Common.DateTime;
import com.iGrandee.Registration.InstitutionQurey;
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

public class FeesReportPDF {
	DateTime datobj = new DateTime();
	InstitutionQurey insquery = new InstitutionQurey();

	public int generatePdf(ArrayList pendingFeesList, String sessionid,
			String sessionname, String boardname, String instituteid) {

		com.iGrandee.Fees.FeesSchedule feesscheduleQuery = new com.iGrandee.Fees.FeesSchedule();
		int rows = 0;
		// String institutelogo = (String)session.getValue("institutelogo");
		ArrayList innerList2 = new ArrayList();

		String fileName = null;
		String tempPath = null;

		String applicationNo = null;
		String studentallocationId = "";
		// String dateofallocation=null;
		String studentapprovalId = "";
		String candidateregisterId = null;

		String feesPaid = null;
		String RemAmount = null;
		String feeStatus = null;
		String paidAmount = null;
		String remainAmount = null;

		String termFeesAmount = null;

		String standardscheduleId = "";
		String applicantName = "";
		String rollNo = "";
		String standardName = "";
		String groupName = "";
		String secName = "";
		String emailId = "";

		ArrayList standardList = new ArrayList();
		ArrayList termList = new ArrayList();

		int count = 0;
		int totPendingCount = 0;

		ArrayList pendingCountList = null;
		String formattedTermFeeCurrency = null;
		String formattedPaidCurrency = null;
		String formattedPendCurrency = null;
		ResourceBundle bundle = ResourceBundle
				.getBundle("resources.serversetup");
		Locale localcurrency = new Locale(bundle.getString("language"), bundle
				.getString("code"));

		// Locale localcurrency = new Locale("en", "IN");
		try {

			String storagepath = "";
			Document document = new Document(PageSize.A4, 30, 30, 105, 40);

			try {

				storagepath = bundle.getString("storagepath");
				// String storagepath = "C:/Documents and
				// Settings/subhashchandran_d.IGSTDEV/Desktop/";
				// tempPath=storagepath+"PDFReports/feesList1.pdf";
				// fileName=storagepath+"PDFReports/Fees List for
				// "+sessionname+"--"+boardname+".pdf";
				String time_stamp = datobj.showTime("WithTime");
				time_stamp = time_stamp.substring(0, time_stamp.length() - 3);
				time_stamp = time_stamp.replaceAll(":", "_");

				String fileLoc = storagepath + instituteid + "/archivalpdfs/"
						+ sessionname + "_" + sessionid + "/Fees Details";
				File createFile = new File(fileLoc);
				boolean fileFlag = createFile.exists();
				if (fileFlag) {

				} else {
					createFile.mkdirs();
				}

				tempPath = storagepath + instituteid + "/archivalpdfs/"
						+ sessionname + "_" + sessionid + "/Fees Details"
						+ "/output.pdf";
				fileName = storagepath + instituteid + "/archivalpdfs/"
						+ sessionname + "_" + sessionid + "/Fees Details"
						+ "/Fees Details " + time_stamp + ".pdf";

				// PdfWriter writer = PdfWriter.getInstance(document,new
				// FileOutputStream(storagepath+"PDFReports/feesList1.pdf"));
				PdfWriter writer = PdfWriter.getInstance(document,
						new FileOutputStream(tempPath));
				document.open();
				Paragraph p3 = new Paragraph("Fees Details", new Font(
						Font.TIMES_ROMAN, 14, Font.BOLD, Color.BLACK));
				p3.setAlignment(Element.ALIGN_CENTER);
				document.add(p3);
				Paragraph p1 = new Paragraph("Academic Year : " + sessionname,
						new Font(Font.TIMES_ROMAN, 14, Font.BOLD, Color.BLACK));
				p1.setAlignment(Element.ALIGN_CENTER);
				document.add(p1);
				Paragraph p2 = new Paragraph("( Board Name : " + boardname
						+ " )", new Font(Font.COURIER, 10, Font.BOLD,
						Color.BLACK));
				p2.setAlignment(Element.ALIGN_CENTER);
				document.add(p2);

				// Paragraph p = new Paragraph();
				// p.add(new Chunk("Timesheet status for the date :"+strartdae+"\t"+
				// "to"+"\t"+enddate, new Font(Font.TIMES_ROMAN, 12,Font.BOLD,Color.black)));
				// p.add(new Chunk("Fees List for the session :"+sessionname+"\t", new
				// Font(Font.TIMES_ROMAN, 12,Font.BOLD,Color.black)));
				// document.add(new Paragraph(p));
				Paragraph Twogapnext = new Paragraph("\n");
				document.add(Twogapnext);

				Paragraph Twogap = new Paragraph("\n\n");
				// document.add(Twogap);

				// System.out.println("studentList.size()-->"+studentList.size());
				ArrayList tempStdList = new ArrayList();
				ArrayList tempFeeIdList = new ArrayList();
				PdfPTable table = new PdfPTable(8);
				if (pendingFeesList != null && pendingFeesList.size() > 0) {
					// System.out.println("pendingFeesList.size()-->"+pendingFeesList.size());
					PdfPCell cell;
					// System.out.println("timesheetAList(3)-->"+applicantList.size()+"sessionname-->"+sessionname+"institutelogo-->"+institutelogo);
					// cell = new PdfPCell(new Paragraph("Board : "+boardname, new
					// Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
					// cell.setBackgroundColor(new Color(255,229,255));
					// cell.setBackgroundColor(new Color(14,118,188));
					// cell.setColspan(8);
					// table.addCell(cell);

					int headerwidths[] = { 3, 21, 10, 11, 15, 15, 15, 9 }; // percentage
					table.setWidths(headerwidths);
					table.setWidthPercentage(100); // percentage
					table.getDefaultCell().setPadding(1);
					table.getDefaultCell().setBorderWidth(0);
					table.getDefaultCell().setHorizontalAlignment(
							Element.ALIGN_LEFT);

					Color gencolor = Color.decode("0x009900");
					Color custColor = new Color(gencolor.getRed(), gencolor
							.getGreen(), gencolor.getBlue(), 150);

					int serialCount = 0;
					for (int i = 0, j = 1; i < pendingFeesList.size(); i++) {
						// System.out.println("0-->");

						HashMap map = (HashMap) pendingFeesList.get(i);
						standardName = (String) map.get("standardname");
						standardscheduleId = (String) map
								.get("standardscheduleid");
						groupName = (String) map.get("groupname");
						String termfeesId = (String) map.get("termfeesid");
						String termfeesAmount = (String) map
								.get("termfeesamount");
						String termName = (String) map.get("termname");
						String dueDate = (String) map.get("duedate");

						Long termFeeObj = Long.valueOf(termfeesAmount);
						NumberFormat termFeeFormat = NumberFormat
								.getCurrencyInstance(localcurrency);
						formattedTermFeeCurrency = termFeeFormat
								.format(termFeeObj);

						if (groupName != null)
							standardName = standardName + " - " + groupName;

						if (!standardList.contains(standardName)) {
							count = 0;
							boolean flag = false;
						}

						// System.out.println("standardscheduleId,termfeesId-->"+standardscheduleId+"--"+termfeesId);
						pendingCountList = (ArrayList) feesscheduleQuery
								.displayFeesDetailsPdf(standardscheduleId,
										termfeesId);
						int pendingCount = 0;
						// System.out.println("pendingCountList.size()-->"+pendingCountList.size());
						if (pendingFeesList.size() != 0) {
							// pendingCount = 0;

							for (int k = 0; k < pendingCountList.size(); k++) {

								HashMap pendingMap = (HashMap) pendingCountList
										.get(k);
								// System.out.println("pendingMap-->"+pendingMap);

								applicantName = (String) pendingMap
										.get("applicantname");
								rollNo = (String) pendingMap.get("rollno");
								secName = (String) pendingMap
										.get("sectionname");

								feeStatus = (String) pendingMap
										.get("feestatus");
								// termFeesAmount = (String)pendingMap.get("termfeesamount");
								paidAmount = (String) pendingMap
										.get("FeesPaid");
								remainAmount = (String) pendingMap
										.get("RemAmount");
								String pendingStatus = (String) pendingMap
										.get("pendingstatus");

								// System.out.println("rollno-->"+(String)pendingMap.get("rollno"));
								// System.out.println("feestatus-->"+(String)pendingMap.get("feestatus"));
								// System.out.println("pendingMap-->"+pendingMap+"feeStatus-->"+feeStatus);
								if (rollNo == null)
									rollNo = "-";

								Long paidFeeObj = Long.valueOf(paidAmount);
								NumberFormat paidFeeFormat = NumberFormat
										.getCurrencyInstance(localcurrency);
								formattedPaidCurrency = paidFeeFormat
										.format(paidFeeObj);

								Long pendFeeObj = Long.valueOf(remainAmount);
								NumberFormat pendFeeFormat = NumberFormat
										.getCurrencyInstance(localcurrency);
								formattedPendCurrency = pendFeeFormat
										.format(pendFeeObj);

								// if(!tempStdList.contains(standardscheduleId))
								{
									PdfPCell cell1;
									if (!standardList.contains(standardName)) {

										cell1 = new PdfPCell(
												new Paragraph(
														"Standard : "
																+ standardName,
														new Font(
																Font.TIMES_ROMAN,
																11, Font.BOLD,
																Color.black)));
										cell1.setBackgroundColor(new Color(255,
												115, 255));
										// cell1.setBackgroundColor(new Color(14,138,188));
										cell1.setColspan(8);
										table.addCell(cell1);
										// System.out.println("2-->");

										standardList.add(standardName);
									}
									// System.out.println("termList-->"+termList);
									if (!termList.contains(termfeesId)) {
										serialCount = 1;
										// PdfPCell cell2;
										cell1 = new PdfPCell(
												new Paragraph("Term Name : "
														+ termName, new Font(
														Font.TIMES_ROMAN, 11,
														Font.BOLD, Color.black)));
										cell1.setBackgroundColor(new Color(255,
												229, 255));
										// cell1.setBackgroundColor(new Color(14,138,188));
										cell1.setColspan(8);
										table.addCell(cell1);
										// System.out.println("2-->");
										termList.add(termfeesId);
										table.getDefaultCell()
												.setBorderWidth(1);
										table
												.addCell(new Paragraph(
														"Sl",
														new Font(
																Font.TIMES_ROMAN,
																11, Font.BOLD,
																Color.black)));
										table
												.addCell(new Paragraph(
														"Name of Student ",
														new Font(
																Font.TIMES_ROMAN,
																11, Font.BOLD,
																Color.black)));
										table
												.addCell(new Paragraph(
														"Roll No",
														new Font(
																Font.TIMES_ROMAN,
																11, Font.BOLD,
																Color.black)));
										table
												.addCell(new Paragraph(
														"Section",
														new Font(
																Font.TIMES_ROMAN,
																11, Font.BOLD,
																Color.black)));
										table
												.addCell(new Paragraph(
														"Term Fee",
														new Font(
																Font.TIMES_ROMAN,
																11, Font.BOLD,
																Color.black)));
										table
												.addCell(new Paragraph(
														"Paid Fee",
														new Font(
																Font.TIMES_ROMAN,
																11, Font.BOLD,
																Color.black)));
										table
												.addCell(new Paragraph(
														"Pending Fee",
														new Font(
																Font.TIMES_ROMAN,
																11, Font.BOLD,
																Color.black)));
										table
												.addCell(new Paragraph(
														"Status",
														new Font(
																Font.TIMES_ROMAN,
																11, Font.BOLD,
																Color.black)));
										table
												.getDefaultCell()
												.setBackgroundColor(Color.WHITE);
									}

								}
								// System.out.println("3-->");
								// String seri=(i+1)+"";
								String seri = (serialCount++) + "";
								cell = new PdfPCell(new Paragraph(seri));
								cell.setHorizontalAlignment(Element.ALIGN_LEFT);
								table.addCell(cell);

								// String names=timesheetAList.get(9).toString();
								cell = new PdfPCell(
										new Paragraph(applicantName));
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

								cell = new PdfPCell(new Paragraph(
										formattedTermFeeCurrency));
								cell.setHorizontalAlignment(Element.ALIGN_LEFT);
								table.addCell(cell);

								cell = new PdfPCell(new Paragraph(
										formattedPaidCurrency));
								cell.setHorizontalAlignment(Element.ALIGN_LEFT);
								table.addCell(cell);

								cell = new PdfPCell(new Paragraph(
										formattedPendCurrency));
								cell.setHorizontalAlignment(Element.ALIGN_LEFT);
								table.addCell(cell);

								// System.out.println("4-->");

								if (feeStatus.equals("Pending")) {
									cell = new PdfPCell(new Paragraph(
											feeStatus, new Font(
													Font.TIMES_ROMAN, 12,
													Font.NORMAL, Color.red)));
									cell
											.setHorizontalAlignment(Element.ALIGN_LEFT);
									table.addCell(cell);
								} else {
									cell = new PdfPCell(new Paragraph(
											feeStatus, new Font(
													Font.TIMES_ROMAN, 12,
													Font.NORMAL, custColor)));
									cell
											.setHorizontalAlignment(Element.ALIGN_LEFT);
									table.addCell(cell);
								}
								tempStdList.add(standardscheduleId);
								if (pendingStatus.equals("0")) {
									pendingCount = pendingCount + 1;
								}

							}
							// System.out.println("pendingCount-->"+pendingCount);

						}
						count = count + 1;
						totPendingCount = totPendingCount + pendingCount;
						// out.print("<tr><td>"+(count)+"</td><td>"+termName+"</td><td>"+formattedTermFeeCurrency+"</td><td>"+dueDate+"</td>");
						// if(pendingCount>0)
						// out.print("<td style='background-color:#B0FFB0'
						// >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='#'
						// standardscheduleid='"+standardscheduleId+"'
						// standardname='"+standardName+"' termfeesid='"+termfeesId+"'
						// termname='"+termName+"' termfeesamount='"+termfeesAmount+"'
						// duedate='"+dueDate+"'
						// onclick='pendingView(this)'>"+pendingCount+"</a></td></tr>");
						// else
						// out.print("<td style='background-color:lightblue'
						// >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+pendingCount+"</td></tr>");

					}
				} else {
					// out.println("<tr><td colspan=5 align=center><font
					// color=red><b>Data not found</b></font></td></tr>");
					// out.println("<tr align='center' class='tablebold'><td
					// colspan='5'><font color='red'>Data Not Found</font></td></tr>");

					//
				}
				// System.out.println("1-->");
				// }
				// }
				// }

				table.getDefaultCell().setBackgroundColor(
						new Color(96, 200, 242));

				document.add(table);
				// onEndPage(writer,document,instituteid,storagepath);
				document.close();
				rows = 1;
				// }
			}

			catch (DocumentException de) {
				System.err.println(de.getMessage());
			}
			FeesReportPDF pagenooo = new FeesReportPDF();
			// pagenooo.pagenumber(tempPath,fileName,document);
			onEverypage(tempPath, fileName, document, instituteid, storagepath);

		}

		catch (Exception sel) {
			System.out.println("GeneralException" + sel.getMessage());
		}
		return rows;
	}

	public void onEverypage(String s, String s1, Document document,
			String insid, String storagepath) {
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
				/*
				 * over.beginText(); over.setFontAndSize(bf, 10);
				 * over.setTextMatrix((page.width()-60), (page.height()-20));
				 * over.showText("Fees Details"); over.setFontAndSize(bf, 2f);
				 * over.endText();
				 */
				try {
					ArrayList insdetails = insquery.getInstituteDetails(insid);
					if (insdetails != null && insdetails.size() > 0) {
						HashMap map = (HashMap) insdetails.get(0);
						String inslogo = map.get("institutelogo") + "";
						String insname = map.get("institutename") + "";
						String contactaddress = map.get("contactaddress") + "";
						String country = map.get("country") + "";
						String landlinenumber = "Phone :"
								+ map.get("landlinenumber") + "";
						String state = map.get("state") + "";
						String zip = map.get("zip") + "";
						String fax = "Fax:" + map.get("fax") + "";

						String emailid = "Email:" + map.get("emailid") + "";
						String url = map.get("url") + "";

						if (url.equals("-") || url.equals("")
								|| url.trim() == "")
							url = "";
						else
							url = "Website :" + url;
						if (zip.equals("-") || zip.equals("")
								|| zip.trim() == "")
							zip = "";
						else
							zip = "Zipcode :" + zip;

						Image jpg = Image.getInstance(storagepath + inslogo);
						jpg.scaleAbsolute(100, 100);
						jpg.setAbsolutePosition(10, (page.height() - 100));
						over.addImage(jpg);
						over.beginText();
						over.setFontAndSize(bf, 12);
						over.setTextMatrix(120, (page.height() - 50));
						over.showText(insname);
						over.endText();
						over.beginText();
						over.setFontAndSize(bf, 9);
						over.setTextMatrix((page.width() / 2) + 120, (page
								.height() - 10));
						over.showText(contactaddress);
						over.endText();
						over.beginText();
						over.setFontAndSize(bf, 9);
						over.setTextMatrix((page.width() / 2) + 120, (page
								.height() - 20));
						over.showText(state);
						over.endText();
						over.beginText();
						over.setFontAndSize(bf, 9);
						over.setTextMatrix((page.width() / 2) + 120, (page
								.height() - 30));
						over.showText(country);
						over.endText();
						over.beginText();
						over.setFontAndSize(bf, 9);
						over.setTextMatrix((page.width() / 2) + 120, (page
								.height() - 40));
						over.showText(zip);
						over.endText();
						over.beginText();
						over.setFontAndSize(bf, 9);
						over.setTextMatrix((page.width() / 2) + 120, (page
								.height() - 50));
						over.showText(landlinenumber);
						over.endText();
						over.beginText();
						over.setFontAndSize(bf, 9);
						over.setTextMatrix((page.width() / 2) + 120, (page
								.height() - 60));
						over.showText(fax);
						over.endText();
						over.beginText();
						over.setFontAndSize(bf, 9);
						over.setTextMatrix((page.width() / 2) + 120, (page
								.height() - 70));
						over.showText(emailid);
						over.endText();
						over.beginText();
						over.setFontAndSize(bf, 9);
						over.setTextMatrix((page.width() / 2) + 120, (page
								.height() - 80));
						over.showText(url);
						over.endText();
					}
				} catch (Exception e) {
e.printStackTrace();
				}
				over.beginText();
				over.setFontAndSize(bf, 10);
				over.setTextMatrix((page.width() - 20) / 2, 20);
				over.showText("- " + i + " -");
				over.endText();
				over.beginText();
				over.setFontAndSize(bf, 9);
				over.setTextMatrix((page.width() - 100), 20);
				over.showText(datobj.showTime("calendar") + " "
						+ datobj.showTime("Time"));
				over.endText();
				for (int j = 0; j < (page.width()); j++) {
					over.beginText();
					over.setFontAndSize(bf, 15);
					over.setTextMatrix(j, (page.height() - 108));
					over.showText("-");
					over.endText();
				}
				for (int j = 0; j < (page.width()); j++) {
					over.beginText();
					over.setFontAndSize(bf, 15);
					over.setTextMatrix(j, 30);
					over.showText("-");
					over.endText();
				}
			}
			stamp.close();
		}

		catch (Exception de) {
			de.printStackTrace();
		}

	}

	public void onEndPage(PdfWriter writer, Document document,
			String instituteid, String storagepath) {
		try {

			// String path = "Y:/apps_storage/kycstorage/"+institutelogo;
			// String storagepath = "Y:/apps_storage/kycstorage/";
			ArrayList insdetails = insquery.getInstituteDetails(instituteid);
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
				head.addCell(new Paragraph("Fees List ", new Font(
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
			// System.out.println("institutelogo-->"+institutelogo);
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
