package com.iGrandee.ExamManagement;

import java.awt.Color;
import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ResourceBundle;
import java.util.StringTokenizer;

import com.lowagie.text.Cell;
import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.HeaderFooter;
import com.lowagie.text.Image;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.Rectangle;
import com.lowagie.text.Table;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfReader;
import com.lowagie.text.pdf.PdfStamper;
import com.lowagie.text.rtf.RtfWriter;
import com.lowagie.text.rtf.RtfWriter2;
import com.lowagie.text.rtf.field.RtfPageNumber;
import com.lowagie.text.rtf.headerfooter.RtfHeaderFooter;
import com.lowagie.text.rtf.headerfooter.RtfHeaderFooterGroup;
import com.iGrandee.Common.CharacterConvertor;
import com.lowagie.text.rtf.field.RtfPageNumber;


public class IGRtfWriter {
	
	public IGRtfWriter(){
		
		storagepath		= null;
		resourcebundle	= null;
		filepath		= null;
		//document		= new Document(PageSize.A4);
		generator		= new QuestionPreparation();
		examList		= null;
		questionList	= null;
	    examname		= null;
	    examdate		= null;
	    instruction		= null;
	    starttime		= null;
	    endtime			= null;
	    duration		= null;
	    coursename		= null;
	    hashmap			= null;	
	    instituteid		= null;
	    currenttime		= null;
	    file			= null;
	    subjectcode		= null;
	}
	
	public int createPdfRtf(String doctype,String qsid){
		
		try{
		
			
		resourcebundle	= ResourceBundle.getBundle("resources.serversetup");
		storagepath		= resourcebundle.getString("storagepath");
		examList		= generator.getExamDetails(qsid);
		if(examList != null && examList.size()>0){
			
			hashmap			= (HashMap)examList.get(0);
		    examname		= (String)hashmap.get("examname");
		    examdate		= (String)hashmap.get("examdate");
		    instruction		= (String)hashmap.get("instruction");
		    starttime		= (String)hashmap.get("starttime");
		    endtime			= (String)hashmap.get("endtime");
		    duration		= (String)hashmap.get("duration");
		    coursename		= (String)hashmap.get("standardname");
		    instituteid		= (String)hashmap.get("instituteid");
		    academicyear	= (String)hashmap.get("sessionname");
		    boardname		= (String)hashmap.get("boardname");
		    subjectname		= (String)hashmap.get("subjectname");
		    subjectcode		= (String)hashmap.get("subjectcode");

		    
		}
		}catch(Exception e){
		}
		
		try{
		
			  file			= new File(storagepath + "Reports/");	
			  if(!file.exists())
				 file.mkdirs();
			
			  document 		= new Document(PageSize.A4, 30, 30, 105, 40);

	          filepath 		= storagepath + "Reports/" + examname + "_" + qsid + ".rtf";
	  		  RtfWriter2 writer2 = RtfWriter2.getInstance(document,new FileOutputStream(filepath));
	  		  writer2.getInstance(document, new FileOutputStream(storagepath + "Reports/temp.rtf"));

		  	  Table headerTable = new Table(2);
			  headerTable.setBorder(0);
			  headerTable.setBorderColor(Color.WHITE);
			  int headerTablewidths[] = {25, 75 };
			  headerTable.setWidths(headerTablewidths);
			  headerTable.setWidth(90);


		      ArrayList insdetails=generator.getInstituteDetails(instituteid);
	        	if(insdetails!=null && insdetails.size()>0)
	        	{
	        		HashMap map=(HashMap)insdetails.get(0);
		        	String inslogo=map.get("institutelogo")+"";
		        	String insname=map.get("institutename")+"";
		        	Image img = Image.getInstance(storagepath+inslogo);
		        	img.scaleToFit(175, 225);
		        	Cell cell007 = new Cell(new Chunk(img, 0, 0));
		        	cell007.setBorder(Rectangle.NO_BORDER);
					cell007.setHorizontalAlignment(Element.ALIGN_LEFT);
				    headerTable.addCell(cell007);
				    Cell cell001 = new Cell(new Phrase(insname, FontFactory.getFont(FontFactory.HELVETICA, 14, Font.BOLD)));
					cell001.setHorizontalAlignment(Element.ALIGN_RIGHT);
					cell001.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell001.setBorder(Rectangle.NO_BORDER);
					headerTable.addCell(cell001);
	        	}
			  RtfHeaderFooterGroup header = new RtfHeaderFooterGroup();
			  header.setHeaderFooter(new RtfHeaderFooter(headerTable),com.lowagie.text.rtf.headerfooter.RtfHeaderFooter.DISPLAY_FIRST_PAGE);
			 
			  Table headerTable1 = new Table(2);
			  headerTable1.setBorder(0);
			  headerTable1.setBorderColor(Color.WHITE);
			  int headerTablewidths1[] = {25, 75 };
			  headerTable1.setWidths(headerTablewidths1);
			  headerTable1.setWidth(90);
			  Cell cell0007 = new Cell(new Phrase(examname, FontFactory.getFont(FontFactory.HELVETICA, 12, Font.BOLD,Color.black)));
			  cell0007.setBorder(Rectangle.NO_BORDER);
			  cell0007.setHorizontalAlignment(Element.ALIGN_LEFT);
			  headerTable1.addCell(cell0007);
			  Cell cell0001 = new Cell(new Phrase(subjectcode, FontFactory.getFont(FontFactory.HELVETICA, 12, Font.BOLD,Color.black)));
			  cell0001.setHorizontalAlignment(Element.ALIGN_RIGHT);
			  cell0001.setVerticalAlignment(Element.ALIGN_MIDDLE);
			  cell0001.setBorder(Rectangle.NO_BORDER);
			  headerTable1.addCell(cell0001);
			  
			  header.setHeaderFooter(new RtfHeaderFooter(headerTable1),com.lowagie.text.rtf.headerfooter.RtfHeaderFooter.DISPLAY_ALL_PAGES);
			  
			  
				
			  /*RtfHeaderFooterGroup header1 = new RtfHeaderFooterGroup();
			  header1.setHeaderFooter(new RtfHeaderFooter(headerTable1),com.lowagie.text.rtf.headerfooter.RtfHeaderFooter.DISPLAY_ALL_PAGES);*/
			 
			  document.setHeader(header);
			  //document.setFooter(header1);
			  //document.setFooter(header1);

	          document.open();
	          
			  document.add(new Paragraph("\t"));
				

			  
			  Table datatable = new Table(4);
			  int headerwidths[] = {30, 40 , 30 ,40};
			  datatable.setWidths(headerwidths);
			  datatable.setWidth(80);
			  datatable.setPadding(5);
				
		      Cell cellaca = new Cell(new Paragraph("Academic Year", FontFactory.getFont(FontFactory.HELVETICA, 12, Font.BOLD)));
		      cellaca.setHorizontalAlignment(Element.ALIGN_LEFT);
		      cellaca.setLeading(20);
		      cellaca.setBackgroundColor(new Color(0xC0, 0xC0, 0xC0));
		      datatable.addCell(cellaca);
		     
		      
		      Cell cellaca1 = new Cell(new Paragraph(academicyear, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
		      cellaca1.setHorizontalAlignment(Element.ALIGN_LEFT);
		      cellaca1.setLeading(20);
		      cellaca1.setBackgroundColor(Color.WHITE);
		      datatable.addCell(cellaca1);	
		      
		      Cell cellboard = new Cell(new Phrase("Board Name", FontFactory.getFont(FontFactory.HELVETICA, 12, Font.BOLD)));
		      cellboard.setHorizontalAlignment(Element.ALIGN_LEFT);
		      cellboard.setLeading(20);
		      cellboard.setBackgroundColor(new Color(0xC0, 0xC0, 0xC0));
		      datatable.addCell(cellboard);
		      
		      Cell cellboard1 = new Cell(new Phrase(boardname, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
		      cellboard1.setHorizontalAlignment(Element.ALIGN_LEFT);
		      cellboard1.setLeading(20);
		      cellboard1.setBackgroundColor(Color.WHITE);
		      datatable.addCell(cellboard1);
		      
		     Cell cellstandard = new Cell(new Phrase("Standard Name", FontFactory.getFont(FontFactory.HELVETICA, 12, Font.BOLD)));
		      cellstandard.setHorizontalAlignment(Element.ALIGN_LEFT);
		      cellstandard.setLeading(20);
		      cellstandard.setBackgroundColor(new Color(0xC0, 0xC0, 0xC0));
		      datatable.addCell(cellstandard);
		      
		      Cell cellstandard1 = new Cell(new Phrase(coursename, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
		      cellstandard1.setHorizontalAlignment(Element.ALIGN_LEFT);
		      cellstandard1.setLeading(20);
		      cellstandard1.setBackgroundColor(Color.WHITE);
		      datatable.addCell(cellstandard1);	

		      Cell cellsubject = new Cell(new Phrase("Subject Name", FontFactory.getFont(FontFactory.HELVETICA, 12, Font.BOLD)));
		      cellsubject.setHorizontalAlignment(Element.ALIGN_LEFT);
		      cellsubject.setLeading(20);
		      cellsubject.setBackgroundColor(new Color(0xC0, 0xC0, 0xC0));
		      datatable.addCell(cellsubject);
		      
		      Cell cellsubject1 = new Cell(new Phrase(subjectname, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
		      cellsubject1.setHorizontalAlignment(Element.ALIGN_LEFT);
		      cellsubject1.setLeading(20);
		      cellsubject1.setBackgroundColor(Color.WHITE);
		      datatable.addCell(cellsubject1);	
		      
		      Cell cell = new Cell(new Paragraph("Exam Name", FontFactory.getFont(FontFactory.HELVETICA, 12, Font.BOLD)));
		      cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		      cell.setLeading(20);
		      cell.setBackgroundColor(new Color(0xC0, 0xC0, 0xC0));
		      datatable.addCell(cell);
		     
		      Cell cell5 = new Cell(new Paragraph(examname, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
		      cell5.setHorizontalAlignment(Element.ALIGN_LEFT);
		      cell5.setLeading(20);
		      cell5.setBackgroundColor(Color.WHITE);
		      datatable.addCell(cell5);	
		      
		      Cell cell2 = new Cell(new Phrase(" ", FontFactory.getFont(FontFactory.HELVETICA, 12, Font.BOLD)));
		      cell2.setHorizontalAlignment(Element.ALIGN_LEFT);
		      cell2.setLeading(20);
		      cell2.setBackgroundColor(Color.WHITE);
		      datatable.addCell(cell2);
		      
		      Cell cell7 = new Cell(new Phrase(" ", FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
		      cell7.setHorizontalAlignment(Element.ALIGN_LEFT);
		      cell7.setLeading(20);
		      cell7.setBackgroundColor(Color.WHITE);
		      datatable.addCell(cell7);
		      
		  /*    Cell cell3 = new Cell(new Phrase("Duration", FontFactory.getFont(FontFactory.HELVETICA, 12, Font.BOLD)));
		      cell3.setHorizontalAlignment(Element.ALIGN_LEFT);
		      cell3.setLeading(20);
		      cell3.setBackgroundColor(Color.WHITE);
		      datatable.addCell(cell3);
		      
		      Cell cell8 = new Cell(new Phrase(duration, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
		      cell8.setHorizontalAlignment(Element.ALIGN_LEFT);
		      cell8.setLeading(20);
		      cell8.setBackgroundColor(Color.WHITE);
		      datatable.addCell(cell8);*/
		      document.add(datatable);	
		      document.add(new Paragraph("\t"));
		      
		      if(instruction == null)
		    	  instruction	= "";
			  else if(instruction.equals("-"))
		    	  instruction	= "There is no Instructions";
		      
			  StringTokenizer instrtoken	= new StringTokenizer(instruction,"|||");
		      Table instrucyiontable 		= new Table(1);
		      instrucyiontable.setWidth(80);
		      instrucyiontable.setPadding(0);
		      instrucyiontable.setBorder(0);
		      Cell cell10 = new Cell(new Phrase("Instruction(s) :", FontFactory.getFont(FontFactory.HELVETICA, 12, Font.UNDERLINE)));
		      cell10.setHorizontalAlignment(Element.ALIGN_LEFT);
		      cell10.setLeading(20);
		      cell10.setBorder(Rectangle.NO_BORDER);
		      cell10.setBackgroundColor(Color.WHITE);
		      instrucyiontable.addCell(cell10);		
		      
		      for(int z=0;instrtoken.hasMoreTokens();z++)
			  {
			      Cell cell11 = new Cell(new Phrase("             "+CharacterConvertor.setForString(instrtoken.nextToken()), FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
			      cell11.setHorizontalAlignment(Element.ALIGN_LEFT);
			      cell11.setLeading(25);
			      cell11.setBorder(Rectangle.NO_BORDER);
			      cell11.setBackgroundColor(Color.WHITE);
			      instrucyiontable.addCell(cell11);	
			  }	
		      document.add(instrucyiontable);		
		      document.newPage();

		      questionList			= generator.getFullQuestions(qsid);
		      String qsdid			= "";
		      String qsdidswap		= "";
		      String noqn			= "";
		      String marksperqn		= "";
		      
		      if(questionList != null && questionList.size()>0){
		  	
		  		for(int a=0;a<questionList.size();a++)
		  		{
		  			hashmap 				= (HashMap)questionList.get(a);
		  			String typeS 			= (String)hashmap.get("type");
		  			String FQuestion        = CharacterConvertor.setForString((String)hashmap.get("Question"));
		  			String A 				= CharacterConvertor.setForString((String)hashmap.get("A"));
		  			String B 				= CharacterConvertor.setForString((String)hashmap.get("B"));
		  			String C 				= CharacterConvertor.setForString((String)hashmap.get("C"));
		  			String D 				= CharacterConvertor.setForString((String)hashmap.get("D"));
		  			String E 				= CharacterConvertor.setForString((String)hashmap.get("E"));
		  			String F 				= CharacterConvertor.setForString((String)hashmap.get("H"));
		  			String G 				= CharacterConvertor.setForString((String)hashmap.get("G"));
		  			String image            = (String)hashmap.get("Image");
		  			qsdid					= (String)hashmap.get("qsdid");
		  			noqn					= (String)hashmap.get("noqn");
		  			marksperqn				= (String)hashmap.get("marksperqn");
		  			int CountAns            = Integer.parseInt((String)hashmap.get("CountAns"));
	

		  			if(A == null)
		  				A= "";
		  			if(B == null)
		  				B= "";
		  			if(C == null)
		  				C= "";
		  			if(D == null)
		  				D= "";
		  			if(E == null)
		  				E= "";
		  			if(F == null)
		  				F= "";
		  			if(G == null)
		  				G= "";
		  			
		  			
		  			if(qsdidswap.equals("") || !qsdidswap.equals(qsdid)){
		  				
		  				if(a >0)
						document.add(new Paragraph("\n"));	

						Table table123 = new Table(2, 1);
						table123.setWidth(80);
						table123.setPadding(0.0F);
						table123.setSpacing(0.0F);
						table123.setBorder(2);
						table123.setBorderWidth(0.0F);
						table123.setBorderColor(new Color(255, 255, 255));
						Phrase paragraph123 = new Phrase(typeS+" Type Question",FontFactory.getFont(FontFactory.HELVETICA, 12, Font.BOLD));
						Cell cell123 = new Cell(paragraph123);
						cell123.setBorder(0);
						cell123.setHorizontalAlignment(0);
						table123.addCell(cell123);
						
						Phrase paragraph124 = new Phrase("Total Marks :"+ noqn + " X " + marksperqn + " = " + Integer.parseInt(noqn)*Integer.parseInt(marksperqn),FontFactory.getFont(FontFactory.HELVETICA, 12, Font.BOLD));
						Cell cell124 = new Cell(paragraph124);
						cell124.setBorder(0);
						cell124.setHorizontalAlignment(2);
						table123.addCell(cell124);
												
						document.add(table123);
						document.add(new Paragraph("\n"));	
						qsdidswap	= qsdid;
		  			}
		  			
		  			
					Table wholetable 	= new Table(1);
					wholetable.setWidth(80);
					wholetable.setPadding(6.0F);
					wholetable.setSpacing(0.0F);
					wholetable.setBorder(0);
					wholetable.setBorderWidth(0.0F);
					wholetable.setBorderColor(new Color(255, 255, 255));	
					
					
		  			if(typeS.equals("Objectives")){
		  		
						Table questiontable = new Table(3);
		  		      	int questionwidths[] = {7, 88 , 15 };
		  		      	questiontable.setWidths(questionwidths);
						
						questiontable.setWidth(80);
						questiontable.setPadding(0.0F);
						questiontable.setSpacing(0.0F);
						questiontable.setBorder(0);
						questiontable.setBorderWidth(0.0F);
						questiontable.setBorderColor(new Color(255, 255, 255));	
						
						
					      Cell cell12 = new Cell(new Phrase(hashmap.get("serialnumber")+".", FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
					      cell12.setHorizontalAlignment(Element.ALIGN_LEFT);
					      cell12.setVerticalAlignment(Element.ALIGN_TOP);
					      cell12.setLeading(20);
					      cell12.setBorder(Rectangle.NO_BORDER);
					      cell12.setBackgroundColor(Color.WHITE);
					      questiontable.addCell(cell12);	
						
					      Cell cell13 = new Cell(new Phrase(FQuestion, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
					      cell13.setHorizontalAlignment(Element.ALIGN_LEFT);
					      cell12.setVerticalAlignment(Element.ALIGN_TOP);
					      cell13.setLeading(20);
					      cell13.setBorder(Rectangle.NO_BORDER);
					      cell13.setBackgroundColor(Color.WHITE);
					      questiontable.addCell(cell13);	
					      
					      Cell cell14 = new Cell(new Phrase("[        ]", FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
					      cell14.setHorizontalAlignment(Element.ALIGN_LEFT);
					      cell14.setLeading(20);
					      cell14.setBorder(Rectangle.NO_BORDER);
					      cell14.setBackgroundColor(Color.WHITE);
					      questiontable.addCell(cell14);	
					      
					      if(image != null && !image.equals("-") && !image.equalsIgnoreCase("null")){
					    	  
					    	  File file 		= new File(storagepath + "QnImage/" + image);
					    	  if(file.exists() && file.isFile()){
					    		  
			                        Image image1 = Image.getInstance(storagepath + "QnImage/" + image);
			                        image1.scalePercent(50F);
			                        image1.scaleAbsolute(80, 72);
		                            image1.setAlignment(1);
			                        
		                            Cell cell98 = new Cell();
		                            cell98.setHorizontalAlignment(Element.ALIGN_LEFT);
								    cell98.setLeading(20);
								    cell98.setColspan(3);
								    cell98.setBorder(Rectangle.NO_BORDER);
								    cell98.setBackgroundColor(Color.WHITE);
								    cell98.add(image1);
								    questiontable.addCell(cell98);	
								    
					    	  }
					      }
					      
					      
					      wholetable.insertTable(questiontable);
					     
					      

							Table optiontable = new Table(2);
							int optionwidths[] = {45, 45};
			  		      	optiontable.setWidths(optionwidths);
							
			  		      	optiontable.setWidth(80);
			  		      	optiontable.setPadding(0.0F);
			  		      	optiontable.setSpacing(0.0F);
							optiontable.setBorder(0);
							optiontable.setBorderWidth(0.0F);
							optiontable.setBorderColor(new Color(255, 255, 255));
							
							
							if(CountAns == 2){

							      Cell cell15 = new Cell(new Phrase("A. "+A, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
							      cell15.setHorizontalAlignment(Element.ALIGN_LEFT);
							      cell15.setLeading(60);
							      cell15.setBorder(Rectangle.NO_BORDER);
							      cell15.setBackgroundColor(Color.WHITE);

							      Cell cell16 = new Cell(new Phrase("B. "+B, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
							      //cell16.setHorizontalAlignment(Element.ALIGN_LEFT);
							      cell16.setLeading(20);
							      cell16.setBorder(Rectangle.NO_BORDER);
							      cell16.setBackgroundColor(Color.WHITE);
								
							      if(A.length()>35 || B.length()>35){
							    	  cell15.setColspan(2);
							    	  cell16.setColspan(2);
							      }
								
							      optiontable.addCell(cell15);	
							      optiontable.addCell(cell16);
							
							}
							else if(CountAns == 3){
								
							      Cell cell15 = new Cell(new Phrase("A. "+A, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
							      cell15.setHorizontalAlignment(Element.ALIGN_LEFT);
							      cell15.setLeading(20);
							      cell15.setBorder(Rectangle.NO_BORDER);
							      cell15.setBackgroundColor(Color.WHITE);
								
							      Cell cell16 = new Cell(new Phrase("B. "+B, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
							      cell16.setHorizontalAlignment(Element.ALIGN_LEFT);
							      cell16.setLeading(20);
							      cell16.setBorder(Rectangle.NO_BORDER);
							      cell16.setBackgroundColor(Color.WHITE);
									
							      Cell cell17 = new Cell(new Phrase("C. "+C, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
							      cell17.setHorizontalAlignment(Element.ALIGN_LEFT);
							      cell17.setLeading(20);
							      cell17.setColspan(2);
							      cell17.setBorder(Rectangle.NO_BORDER);
							      cell17.setBackgroundColor(Color.WHITE);
							      
							      
							      if(A.length()>35 || B.length()>35 || C.length()>35){
							    	  cell15.setColspan(2);
							    	  cell16.setColspan(2);
							      }
							      
							      optiontable.addCell(cell15);	
							      optiontable.addCell(cell16);	
							      optiontable.addCell(cell17);	
						      
								
							}
							else if(CountAns == 4){
								
							      Cell cell15 = new Cell(new Phrase("A. "+A, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
							      cell15.setHorizontalAlignment(Element.ALIGN_LEFT);
							      cell15.setLeading(20);
							      cell15.setBorder(Rectangle.NO_BORDER);
							      cell15.setBackgroundColor(Color.WHITE);
								
							      Cell cell16 = new Cell(new Phrase("B. "+B, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
							      cell16.setHorizontalAlignment(Element.ALIGN_LEFT);
							      cell16.setLeading(20);
							      cell16.setBorder(Rectangle.NO_BORDER);
							      cell16.setBackgroundColor(Color.WHITE);
									
							      Cell cell17 = new Cell(new Phrase("C. "+C, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
							      cell17.setHorizontalAlignment(Element.ALIGN_LEFT);
							      cell17.setLeading(20);
							      cell17.setBorder(Rectangle.NO_BORDER);
							      cell17.setBackgroundColor(Color.WHITE);
							      
							      Cell cell18 = new Cell(new Phrase("D. "+D, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
							      cell18.setHorizontalAlignment(Element.ALIGN_LEFT);
							      cell18.setLeading(20);
							      cell18.setBorder(Rectangle.NO_BORDER);
							      cell18.setBackgroundColor(Color.WHITE);
							      
							      if(A.length()>35 || B.length()>35 || C.length()>35 || D.length()>35){
							    	  cell15.setColspan(2);
							    	  cell16.setColspan(2);
							    	  cell17.setColspan(2);
							    	  cell18.setColspan(2);
							      }
							      
							      optiontable.addCell(cell15);	
							      optiontable.addCell(cell16);	
							      optiontable.addCell(cell17);	
							      optiontable.addCell(cell18);	
							      
						      
									
							}
							else if(CountAns == 5){
								
							      Cell cell15 = new Cell(new Phrase("A. "+A, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
							      cell15.setHorizontalAlignment(Element.ALIGN_LEFT);
							      cell15.setLeading(20);
							      cell15.setBorder(Rectangle.NO_BORDER);
							      cell15.setBackgroundColor(Color.WHITE);
								
							      Cell cell16 = new Cell(new Phrase("B. "+B, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
							      cell16.setHorizontalAlignment(Element.ALIGN_LEFT);
							      cell16.setLeading(20);
							      cell16.setBorder(Rectangle.NO_BORDER);
							      cell16.setBackgroundColor(Color.WHITE);
									
							      Cell cell17 = new Cell(new Phrase("C. "+C, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
							      cell17.setHorizontalAlignment(Element.ALIGN_LEFT);
							      cell17.setLeading(20);
							      cell17.setBorder(Rectangle.NO_BORDER);
							      cell17.setBackgroundColor(Color.WHITE);
							      
							      Cell cell18 = new Cell(new Phrase("D. "+D, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
							      cell18.setHorizontalAlignment(Element.ALIGN_LEFT);
							      cell18.setLeading(20);
							      cell18.setBorder(Rectangle.NO_BORDER);
							      cell18.setBackgroundColor(Color.WHITE);
							      
							      
							      Cell cell19 = new Cell(new Phrase("E. "+E, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
							      cell19.setHorizontalAlignment(Element.ALIGN_LEFT);
							      cell19.setLeading(20);
							      cell19.setColspan(2);
							      cell19.setBorder(Rectangle.NO_BORDER);
							      cell19.setBackgroundColor(Color.WHITE);
							      
							      
							      if(A.length()>35 || B.length()>35 || C.length()>35 || D.length()>35 || E.length()>35){
							    	  cell15.setColspan(2);
							    	  cell16.setColspan(2);
							    	  cell17.setColspan(2);
							    	  cell18.setColspan(2);
							      }
							      
							      optiontable.addCell(cell15);	
							      optiontable.addCell(cell16);	
							      optiontable.addCell(cell17);	
							      optiontable.addCell(cell18);	
							      optiontable.addCell(cell19);	
							      
									
							}
							else if(CountAns == 6){
								
							      Cell cell15 = new Cell(new Phrase("A. "+A, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
							      cell15.setHorizontalAlignment(Element.ALIGN_LEFT);
							      cell15.setLeading(20);
							      cell15.setBorder(Rectangle.NO_BORDER);
							      cell15.setBackgroundColor(Color.WHITE);
								
							      Cell cell16 = new Cell(new Phrase("B. "+B, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
							      cell16.setHorizontalAlignment(Element.ALIGN_LEFT);
							      cell16.setLeading(20);
							      cell16.setBorder(Rectangle.NO_BORDER);
							      cell16.setBackgroundColor(Color.WHITE);
									
							      Cell cell17 = new Cell(new Phrase("C. "+C, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
							      cell17.setHorizontalAlignment(Element.ALIGN_LEFT);
							      cell17.setLeading(20);
							      cell17.setBorder(Rectangle.NO_BORDER);
							      cell17.setBackgroundColor(Color.WHITE);
							      
							      Cell cell18 = new Cell(new Phrase("D. "+D, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
							      cell18.setHorizontalAlignment(Element.ALIGN_LEFT);
							      cell18.setLeading(20);
							      cell18.setBorder(Rectangle.NO_BORDER);
							      cell18.setBackgroundColor(Color.WHITE);
							      
							      
							      Cell cell19 = new Cell(new Phrase("E. "+E, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
							      cell19.setHorizontalAlignment(Element.ALIGN_LEFT);
							      cell19.setLeading(20);
							      cell19.setBorder(Rectangle.NO_BORDER);
							      cell19.setBackgroundColor(Color.WHITE);
							      
							      Cell cell20 = new Cell(new Phrase("F. "+F, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
							      cell20.setHorizontalAlignment(Element.ALIGN_LEFT);
							      cell20.setLeading(20);
							      cell20.setBorder(Rectangle.NO_BORDER);
							      cell20.setBackgroundColor(Color.WHITE);
							      
							      if(A.length()>35 || B.length()>35 || C.length()>35 || D.length()>35 || E.length()>35 || F.length()>35){
							    	  cell15.setColspan(2);
							    	  cell16.setColspan(2);
							    	  cell17.setColspan(2);
							    	  cell18.setColspan(2);
							    	  cell19.setColspan(2);
							    	  cell20.setColspan(2);
							    	  
							      }
							      
							      optiontable.addCell(cell15);	
							      optiontable.addCell(cell16);	
							      optiontable.addCell(cell17);	
							      optiontable.addCell(cell18);	
							      optiontable.addCell(cell19);	
							      optiontable.addCell(cell20);	
							      
									
							}
							else if(CountAns == 7){
								
							      Cell cell15 = new Cell(new Phrase("A. "+A, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
							      cell15.setHorizontalAlignment(Element.ALIGN_LEFT);
							      cell15.setLeading(20);
							      cell15.setBorder(Rectangle.NO_BORDER);
							      cell15.setBackgroundColor(Color.WHITE);
								
							      Cell cell16 = new Cell(new Phrase("B. "+B, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
							      cell16.setHorizontalAlignment(Element.ALIGN_LEFT);
							      cell16.setLeading(20);
							      cell16.setBorder(Rectangle.NO_BORDER);
							      cell16.setBackgroundColor(Color.WHITE);
									
							      Cell cell17 = new Cell(new Phrase("C. "+C, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
							      cell17.setHorizontalAlignment(Element.ALIGN_LEFT);
							      cell17.setLeading(20);
							      cell17.setBorder(Rectangle.NO_BORDER);
							      cell17.setBackgroundColor(Color.WHITE);
							      
							      Cell cell18 = new Cell(new Phrase("D. "+D, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
							      cell18.setHorizontalAlignment(Element.ALIGN_LEFT);
							      cell18.setLeading(20);
							      cell18.setBorder(Rectangle.NO_BORDER);
							      cell18.setBackgroundColor(Color.WHITE);
							      
							      
							      Cell cell19 = new Cell(new Phrase("E. "+E, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
							      cell19.setHorizontalAlignment(Element.ALIGN_LEFT);
							      cell19.setLeading(20);
							      cell19.setBorder(Rectangle.NO_BORDER);
							      cell19.setBackgroundColor(Color.WHITE);
							      
							      Cell cell20 = new Cell(new Phrase("F. "+F, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
							      cell20.setHorizontalAlignment(Element.ALIGN_LEFT);
							      cell20.setLeading(20);
							      cell20.setBorder(Rectangle.NO_BORDER);
							      cell20.setBackgroundColor(Color.WHITE);
							      
							      Cell cell21 = new Cell(new Phrase("F. "+F, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
							      cell21.setHorizontalAlignment(Element.ALIGN_LEFT);
							      cell21.setLeading(20);
							      cell21.setColspan(2);
							      cell21.setBorder(Rectangle.NO_BORDER);
							      cell21.setBackgroundColor(Color.WHITE);
							      
							
							      if(A.length()>35 || B.length()>35 || C.length()>35 || D.length()>35 || E.length()>35 || F.length()>35 || G.length()>35){
							    	  cell15.setColspan(2);
							    	  cell16.setColspan(2);
							    	  cell17.setColspan(2);
							    	  cell18.setColspan(2);
							    	  cell19.setColspan(2);
							    	  cell20.setColspan(2);
							    	  
							      }
							      
							      optiontable.addCell(cell15);	
							      optiontable.addCell(cell16);	
							      optiontable.addCell(cell17);	
							      optiontable.addCell(cell18);	
							      optiontable.addCell(cell19);	
							      optiontable.addCell(cell20);	
							      optiontable.addCell(cell21);	
							
							}
							
						Table optiontemp = new Table(2);
						int tempwidths[] = {5, 95};
						optiontemp.setWidths(tempwidths);
						
						Cell cellt = new Cell();
						cellt.setBorder(Rectangle.NO_BORDER);
						cellt.setBackgroundColor(Color.WHITE);						
						optiontemp.addCell(cellt);
						optiontemp.insertTable(optiontable);
						
						wholetable.insertTable(optiontemp);
						document.add(wholetable);
							
					      
		  			}else if(typeS.equals("Matching")){
		  				
			            try{
		  				
		  				StringTokenizer stringtokenizer = new StringTokenizer(FQuestion, "Û");
		  				
		  				System.out.println("stringtokenizer.countTokens() ===>"+stringtokenizer.countTokens());
			            
						Table optiontable = new Table(4);
		  		      	int optionwidths[] = {6, 47, 47, 10};
		  		      	optiontable.setWidths(optionwidths);
						
		  		      	optiontable.setWidth(80);
		  		      	optiontable.setPadding(0.0F);
		  		      	optiontable.setSpacing(0.0F);
						optiontable.setBorder(0);
						optiontable.setBorderWidth(0.0F);
						optiontable.setBorderColor(new Color(255, 255, 255));	
						
						Cell cell1151 = new Cell(new Phrase(hashmap.get("serialnumber")+".", FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						cell1151.setHorizontalAlignment(Element.ALIGN_LEFT);
						cell1151.setVerticalAlignment(Element.ALIGN_TOP);
						
						cell1151.setLeading(20);
						cell1151.setBorder(Rectangle.NO_BORDER);
						cell1151.setBackgroundColor(Color.WHITE);
						optiontable.addCell(cell1151);	
						
						if(stringtokenizer.countTokens() == 2){
						
					      Cell cell151 = new Cell(new Phrase(stringtokenizer.nextToken(), FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
					      cell151.setHorizontalAlignment(Element.ALIGN_LEFT);
					      cell151.setLeading(20);
					      cell151.setBorder(Rectangle.NO_BORDER);
					      cell151.setBackgroundColor(Color.WHITE);
					      optiontable.addCell(cell151);	
							
					      
						  Cell cell15 = new Cell(new Phrase("A. "+A, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
					      cell15.setHorizontalAlignment(Element.ALIGN_LEFT);
					      cell15.setLeading(20);
					      cell15.setBorder(Rectangle.NO_BORDER);
					      cell15.setBackgroundColor(Color.WHITE);
					      optiontable.addCell(cell15);	
					      
					      
					      Cell cell1521 = new Cell("[         ]");
					      cell1521.setHorizontalAlignment(Element.ALIGN_LEFT);
					      cell1521.setLeading(20);
					      cell1521.setBorder(Rectangle.NO_BORDER);
					      cell1521.setBackgroundColor(Color.WHITE);
					      optiontable.addCell(cell1521);	
					      
					      
					      Cell cell15111 = new Cell(new Phrase("", FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
					      cell15111.setHorizontalAlignment(Element.ALIGN_LEFT);
					      cell15111.setLeading(20);
					      cell15111.setBorder(Rectangle.NO_BORDER);
					      cell15111.setBackgroundColor(Color.WHITE);
					      optiontable.addCell(cell15111);	
					      
					      
					      
					      
					      Cell cell152 = new Cell(new Phrase(stringtokenizer.nextToken(), FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
					      cell152.setHorizontalAlignment(Element.ALIGN_LEFT);
					      cell152.setLeading(20);
					      cell152.setBorder(Rectangle.NO_BORDER);
					      cell152.setBackgroundColor(Color.WHITE);
					      optiontable.addCell(cell152);	
					      
						
					      Cell cell16 = new Cell(new Phrase("B. "+B, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
					      cell16.setHorizontalAlignment(Element.ALIGN_LEFT);
					      cell16.setLeading(20);
					      cell16.setBorder(Rectangle.NO_BORDER);
					      cell16.setBackgroundColor(Color.WHITE);
					      optiontable.addCell(cell16);	
					      
					      Cell cell1522 = new Cell("[         ]");
					      cell1522.setHorizontalAlignment(Element.ALIGN_LEFT);
					      cell1522.setLeading(20);
					      cell1522.setBorder(Rectangle.NO_BORDER);
					      cell1522.setBackgroundColor(Color.WHITE);
					      optiontable.addCell(cell1522);	
					      
					      
						}
						else if(stringtokenizer.countTokens() == 3){
							
					      Cell cell152 = new Cell(new Phrase(stringtokenizer.nextToken(), FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
					      cell152.setHorizontalAlignment(Element.ALIGN_LEFT);
					      cell152.setLeading(20);
					      cell152.setBorder(Rectangle.NO_BORDER);
					      cell152.setBackgroundColor(Color.WHITE);
					      optiontable.addCell(cell152);	
							
							
					      Cell cell15 = new Cell(new Phrase("A. "+A, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
					      cell15.setHorizontalAlignment(Element.ALIGN_LEFT);
					      cell15.setLeading(20);
					      cell15.setBorder(Rectangle.NO_BORDER);
					      cell15.setBackgroundColor(Color.WHITE);
					      optiontable.addCell(cell15);	
					      
					      Cell cell1522 = new Cell("[         ]");
					      cell1522.setHorizontalAlignment(Element.ALIGN_LEFT);
					      cell1522.setLeading(20);
					      cell1522.setBorder(Rectangle.NO_BORDER);
					      cell1522.setBackgroundColor(Color.WHITE);
					      optiontable.addCell(cell1522);	
					      
					      Cell cell15111 = new Cell(new Phrase("", FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
					      cell15111.setHorizontalAlignment(Element.ALIGN_LEFT);
					      cell15111.setLeading(20);
					      cell15111.setBorder(Rectangle.NO_BORDER);
					      cell15111.setBackgroundColor(Color.WHITE);
					      optiontable.addCell(cell15111);	
					      
					      
					      
					      Cell cell154 = new Cell(new Phrase(stringtokenizer.nextToken(), FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
					      cell154.setHorizontalAlignment(Element.ALIGN_LEFT);
					      cell154.setLeading(20);
					      cell154.setBorder(Rectangle.NO_BORDER);
					      cell154.setBackgroundColor(Color.WHITE);
					      optiontable.addCell(cell154);	
					      
						
					      Cell cell16 = new Cell(new Phrase("B. "+B, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
					      cell16.setHorizontalAlignment(Element.ALIGN_LEFT);
					      cell16.setLeading(20);
					      cell16.setBorder(Rectangle.NO_BORDER);
					      cell16.setBackgroundColor(Color.WHITE);
					      optiontable.addCell(cell16);	
					      
					      Cell cell1523 = new Cell("[         ]");
					      cell1523.setHorizontalAlignment(Element.ALIGN_LEFT);
					      cell1523.setLeading(20);
					      cell1523.setBorder(Rectangle.NO_BORDER);
					      cell1523.setBackgroundColor(Color.WHITE);
					      optiontable.addCell(cell1523);	
					      
					      Cell cell15112 = new Cell(new Phrase("", FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
					      cell15112.setHorizontalAlignment(Element.ALIGN_LEFT);
					      cell15112.setLeading(20);
					      cell15112.setBorder(Rectangle.NO_BORDER);
					      cell15112.setBackgroundColor(Color.WHITE);
					      optiontable.addCell(cell15112);	
					      
					      
					      Cell cell153 = new Cell(new Phrase(stringtokenizer.nextToken(), FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
					      cell153.setHorizontalAlignment(Element.ALIGN_LEFT);
					      cell153.setLeading(20);
					      cell153.setBorder(Rectangle.NO_BORDER);
					      cell153.setBackgroundColor(Color.WHITE);
					      optiontable.addCell(cell153);	
					      
							
					      Cell cell17 = new Cell(new Phrase("C. "+C, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
					      cell17.setHorizontalAlignment(Element.ALIGN_LEFT);
					      cell17.setLeading(20);
					      cell17.setColspan(2);
					      cell17.setBorder(Rectangle.NO_BORDER);
					      cell17.setBackgroundColor(Color.WHITE);
					      optiontable.addCell(cell17);	
					      
					      
					      Cell cell1524 = new Cell("[         ]");
					      cell1524.setHorizontalAlignment(Element.ALIGN_LEFT);
					      cell1524.setLeading(20);
					      cell1524.setBorder(Rectangle.NO_BORDER);
					      cell1524.setBackgroundColor(Color.WHITE);
					      optiontable.addCell(cell1524);						      
					      
							
						}
						else if(stringtokenizer.countTokens() == 4){
							
							
							
						      Cell cell153 = new Cell(new Phrase(stringtokenizer.nextToken(), FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell153.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell153.setLeading(20);
						      cell153.setBorder(Rectangle.NO_BORDER);
						      cell153.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell153);	
						      
						      
							
						      Cell cell15 = new Cell(new Phrase("A. "+A, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell15.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell15.setLeading(20);
						      cell15.setBorder(Rectangle.NO_BORDER);
						      cell15.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell15);	
						      
						      Cell cell1524 = new Cell("[         ]");
						      cell1524.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell1524.setLeading(20);
						      cell1524.setBorder(Rectangle.NO_BORDER);
						      cell1524.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell1524);
						      
						      
						      Cell cell15112 = new Cell(new Phrase("", FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell15112.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell15112.setLeading(20);
						      cell15112.setBorder(Rectangle.NO_BORDER);
						      cell15112.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell15112);	
						      
						      
						      
						      Cell cell160 = new Cell(new Phrase(stringtokenizer.nextToken(), FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell160.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell160.setLeading(20);
						      cell160.setBorder(Rectangle.NO_BORDER);
						      cell160.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell160);	
						      
							
						      Cell cell16 = new Cell(new Phrase("B. "+B, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell16.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell16.setLeading(20);
						      cell16.setBorder(Rectangle.NO_BORDER);
						      cell16.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell16);	
						      
						      Cell cell1525 = new Cell("[         ]");
						      cell1525.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell1525.setLeading(20);
						      cell1525.setBorder(Rectangle.NO_BORDER);
						      cell1525.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell1525);	
						      
						      Cell cell15111 = new Cell(new Phrase("", FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell15111.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell15111.setLeading(20);
						      cell15111.setBorder(Rectangle.NO_BORDER);
						      cell15111.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell15111);	
						      
						      
						      
						      Cell cell155 = new Cell(new Phrase(stringtokenizer.nextToken(), FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell155.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell155.setLeading(20);
						      cell155.setBorder(Rectangle.NO_BORDER);
						      cell155.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell155);	
						      
								
						      Cell cell17 = new Cell(new Phrase("C. "+C, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell17.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell17.setLeading(20);
						      cell17.setBorder(Rectangle.NO_BORDER);
						      cell17.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell17);	
						      
						      Cell cell1526 = new Cell("[         ]");
						      cell1526.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell1526.setLeading(20);
						      cell1526.setBorder(Rectangle.NO_BORDER);
						      cell1526.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell1526);
						      
						      
						      Cell cell15113 = new Cell(new Phrase("", FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell15113.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell15113.setLeading(20);
						      cell15113.setBorder(Rectangle.NO_BORDER);
						      cell15113.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell15113);	
						      
						      
						      
						      Cell cell154 = new Cell(new Phrase(stringtokenizer.nextToken(), FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell154.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell154.setLeading(20);
						      cell154.setBorder(Rectangle.NO_BORDER);
						      cell154.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell154);	
						      
						      
						      Cell cell18 = new Cell(new Phrase("D. "+D, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell18.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell18.setLeading(20);
						      cell18.setBorder(Rectangle.NO_BORDER);
						      cell18.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell18);	
						      
						      Cell cell1527 = new Cell("[         ]");
						      cell1527.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell1527.setLeading(20);
						      cell1527.setBorder(Rectangle.NO_BORDER);
						      cell1527.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell1527);						      
						      
								
						}
						else if(stringtokenizer.countTokens() == 5){
							
												
							  Cell cell154 = new Cell(new Phrase(stringtokenizer.nextToken(), FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell154.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell154.setLeading(20);
						      cell154.setBorder(Rectangle.NO_BORDER);
						      cell154.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell154);	
							
						      Cell cell15 = new Cell(new Phrase("A. "+A, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell15.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell15.setLeading(20);
						      cell15.setBorder(Rectangle.NO_BORDER);
						      cell15.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell15);
						      
						      Cell cell1527 = new Cell("[         ]");
						      cell1527.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell1527.setLeading(20);
						      cell1527.setBorder(Rectangle.NO_BORDER);
						      cell1527.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell1527);	
						      
						      Cell cell15112 = new Cell(new Phrase("", FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell15112.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell15112.setLeading(20);
						      cell15112.setBorder(Rectangle.NO_BORDER);
						      cell15112.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell15112);	
									      
						      
						      Cell cell55 = new Cell(new Phrase(stringtokenizer.nextToken(), FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell55.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell55.setLeading(20);
						      cell55.setBorder(Rectangle.NO_BORDER);
						      cell55.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell55);	
						      
							
						      Cell cell16 = new Cell(new Phrase("B. "+B, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell16.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell16.setLeading(20);
						      cell16.setBorder(Rectangle.NO_BORDER);
						      cell16.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell16);	
						      
						      Cell cell1526 = new Cell("[         ]");
						      cell1526.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell1526.setLeading(20);
						      cell1526.setBorder(Rectangle.NO_BORDER);
						      cell1526.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell1526);		
						      
						      
						      Cell cell15111 = new Cell(new Phrase("", FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell15111.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell15111.setLeading(20);
						      cell15111.setBorder(Rectangle.NO_BORDER);
						      cell15111.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell15111);	
						      
						      
						      Cell cell56 = new Cell(new Phrase(stringtokenizer.nextToken(), FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell56.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell56.setLeading(20);
						      cell56.setBorder(Rectangle.NO_BORDER);
						      cell56.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell56);	
						      
								
						      Cell cell17 = new Cell(new Phrase("C. "+C, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell17.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell17.setLeading(20);
						      cell17.setBorder(Rectangle.NO_BORDER);
						      cell17.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell17);	
						      
						      Cell cell1525 = new Cell("[         ]");
						      cell1525.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell1525.setLeading(20);
						      cell1525.setBorder(Rectangle.NO_BORDER);
						      cell1525.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell1525);	
						      
						      
						      Cell cell15113 = new Cell(new Phrase("", FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell15113.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell15113.setLeading(20);
						      cell15113.setBorder(Rectangle.NO_BORDER);
						      cell15113.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell15113);	
						      
						      Cell cell57 = new Cell(new Phrase(stringtokenizer.nextToken(), FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell57.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell57.setLeading(20);
						      cell57.setBorder(Rectangle.NO_BORDER);
						      cell57.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell57);	
						      
						      
						      Cell cell18 = new Cell(new Phrase("D. "+D, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell18.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell18.setLeading(20);
						      cell18.setBorder(Rectangle.NO_BORDER);
						      cell18.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell18);	
						      
						      Cell cell1528 = new Cell("[         ]");
						      cell1528.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell1528.setLeading(20);
						      cell1528.setBorder(Rectangle.NO_BORDER);
						      cell1528.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell1528);	
						      
						      
						      Cell cell15115 = new Cell(new Phrase("", FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell15115.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell15115.setLeading(20);
						      cell15115.setBorder(Rectangle.NO_BORDER);
						      cell15115.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell15115);	
						      
								      
						      Cell cell58 = new Cell(new Phrase(stringtokenizer.nextToken(), FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell58.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell58.setLeading(20);
						      cell58.setBorder(Rectangle.NO_BORDER);
						      cell58.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell58);	
						      
						      
						      
						      Cell cell19 = new Cell(new Phrase("E. "+E, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell19.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell19.setLeading(20);
						      cell19.setBorder(Rectangle.NO_BORDER);
						      cell19.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell19);	
						      
						      Cell cell1529 = new Cell("[         ]");
						      cell1529.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell1529.setLeading(20);
						      cell1529.setBorder(Rectangle.NO_BORDER);
						      cell1529.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell1529);
						      
								
						}
						else if(stringtokenizer.countTokens() == 6){
							
						      Cell cell154 = new Cell(new Phrase(stringtokenizer.nextToken(), FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell154.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell154.setLeading(20);
						      cell154.setBorder(Rectangle.NO_BORDER);
						      cell154.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell154);	
							
							
							
						      Cell cell15 = new Cell(new Phrase("A. "+A, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell15.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell15.setLeading(20);
						      cell15.setBorder(Rectangle.NO_BORDER);
						      cell15.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell15);	
						      
						      Cell cell1529 = new Cell("[         ]");
						      cell1529.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell1529.setLeading(20);
						      cell1529.setBorder(Rectangle.NO_BORDER);
						      cell1529.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell1529);	
						      
						      
						      Cell cell15112 = new Cell(new Phrase("", FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell15112.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell15112.setLeading(20);
						      cell15112.setBorder(Rectangle.NO_BORDER);
						      cell15112.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell15112);	
						      
						      
						      
						      Cell cell58 = new Cell(new Phrase(stringtokenizer.nextToken(), FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell58.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell58.setLeading(20);
						      cell58.setBorder(Rectangle.NO_BORDER);
						      cell58.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell58);	
						      
						      
							
						      Cell cell16 = new Cell(new Phrase("B. "+B, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell16.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell16.setLeading(20);
						      cell16.setBorder(Rectangle.NO_BORDER);
						      cell16.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell16);	
						      
						      Cell cell1528 = new Cell("[         ]");
						      cell1528.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell1528.setLeading(20);
						      cell1528.setBorder(Rectangle.NO_BORDER);
						      cell1528.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell1528);	
						      
						      Cell cell15111 = new Cell(new Phrase("", FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell15111.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell15111.setLeading(20);
						      cell15111.setBorder(Rectangle.NO_BORDER);
						      cell15111.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell15111);	
						      
						      
						      
						      Cell cell55 = new Cell(new Phrase(stringtokenizer.nextToken(), FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell55.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell55.setLeading(20);
						      cell55.setBorder(Rectangle.NO_BORDER);
						      cell55.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell55);	
						      
								
						      Cell cell17 = new Cell(new Phrase("C. "+C, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell17.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell17.setLeading(20);
						      cell17.setBorder(Rectangle.NO_BORDER);
						      cell17.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell17);	
						      
						      Cell cell1525 = new Cell("[         ]");
						      cell1525.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell1525.setLeading(20);
						      cell1525.setBorder(Rectangle.NO_BORDER);
						      cell1525.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell1525);	
						      
						      Cell cell15113 = new Cell(new Phrase("", FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell15113.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell15113.setLeading(20);
						      cell15113.setBorder(Rectangle.NO_BORDER);
						      cell15113.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell15113);	
						      
						      						      
						      
						      Cell cell57 = new Cell(new Phrase(stringtokenizer.nextToken(), FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell57.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell57.setLeading(20);
						      cell57.setBorder(Rectangle.NO_BORDER);
						      cell57.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell57);	
						      
						      
						      Cell cell18 = new Cell(new Phrase("D. "+D, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell18.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell18.setLeading(20);
						      cell18.setBorder(Rectangle.NO_BORDER);
						      cell18.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell18);	
						      
						      
						      Cell cell1530 = new Cell("[         ]");
						      cell1530.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell1530.setLeading(20);
						      cell1530.setBorder(Rectangle.NO_BORDER);
						      cell1530.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell1530);	
						      
						      Cell cell15114 = new Cell(new Phrase("", FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell15114.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell15114.setLeading(20);
						      cell15114.setBorder(Rectangle.NO_BORDER);
						      cell15114.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell15114);	
						      
						      						      
						      
						      Cell cell59 = new Cell(new Phrase(stringtokenizer.nextToken(), FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell59.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell59.setLeading(20);
						      cell59.setBorder(Rectangle.NO_BORDER);
						      cell59.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell59);	
						      
						      Cell cell19 = new Cell(new Phrase("E. "+E, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell19.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell19.setLeading(20);
						      cell19.setBorder(Rectangle.NO_BORDER);
						      cell19.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell19);	
						      
						      Cell cell1531 = new Cell("[         ]");
						      cell1531.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell1531.setLeading(20);
						      cell1531.setBorder(Rectangle.NO_BORDER);
						      cell1531.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell1531);	
						      
						      
						      Cell cell15115 = new Cell(new Phrase("", FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell15115.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell15115.setLeading(20);
						      cell15115.setBorder(Rectangle.NO_BORDER);
						      cell15115.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell15115);	
						      
						      
						      
						      Cell cell60 = new Cell(new Phrase(stringtokenizer.nextToken(), FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell60.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell60.setLeading(20);
						      cell60.setBorder(Rectangle.NO_BORDER);
						      cell60.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell60);	
						      
						      
						      Cell cell20 = new Cell(new Phrase("F. "+F, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell20.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell20.setLeading(20);
						      cell20.setBorder(Rectangle.NO_BORDER);
						      cell20.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell20);	
						      
						      
						      Cell cell1532 = new Cell("[         ]");
						      cell1532.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell1532.setLeading(20);
						      cell1532.setBorder(Rectangle.NO_BORDER);
						      cell1532.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell1532);						      
						      
								
						}
						else if(stringtokenizer.countTokens() == 7){
							
						      Cell cell154 = new Cell(new Phrase(stringtokenizer.nextToken(), FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell154.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell154.setLeading(20);
						      cell154.setBorder(Rectangle.NO_BORDER);
						      cell154.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell154);	
							
							
						      Cell cell15 = new Cell(new Phrase("A. "+A, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell15.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell15.setLeading(20);
						      cell15.setBorder(Rectangle.NO_BORDER);
						      cell15.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell15);	
						      
						      Cell cell1532 = new Cell("[         ]");
						      cell1532.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell1532.setLeading(20);
						      cell1532.setBorder(Rectangle.NO_BORDER);
						      cell1532.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell1532);	
						      
						      Cell cell15112 = new Cell(new Phrase("", FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell15112.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell15112.setLeading(20);
						      cell15112.setBorder(Rectangle.NO_BORDER);
						      cell15112.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell15112);	
						      
						      
						      Cell cell155 = new Cell(new Phrase(stringtokenizer.nextToken(), FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell155.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell155.setLeading(20);
						      cell155.setBorder(Rectangle.NO_BORDER);
						      cell155.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell155);	
						      
							
						      Cell cell16 = new Cell(new Phrase("B. "+B, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell16.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell16.setLeading(20);
						      cell16.setBorder(Rectangle.NO_BORDER);
						      cell16.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell16);	
						      
						      Cell cell1531 = new Cell("[         ]");
						      cell1531.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell1531.setLeading(20);
						      cell1531.setBorder(Rectangle.NO_BORDER);
						      cell1531.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell1531);	
						      
						      Cell cell15111 = new Cell(new Phrase("", FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell15111.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell15111.setLeading(20);
						      cell15111.setBorder(Rectangle.NO_BORDER);
						      cell15111.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell15111);	
						      
						      
						      Cell cell156 = new Cell(new Phrase(stringtokenizer.nextToken(), FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell156.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell156.setLeading(20);
						      cell156.setBorder(Rectangle.NO_BORDER);
						      cell156.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell156);	
						      
								
						      Cell cell17 = new Cell(new Phrase("C. "+C, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell17.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell17.setLeading(20);
						      cell17.setBorder(Rectangle.NO_BORDER);
						      cell17.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell17);	
						      
						      Cell cell1530 = new Cell("[         ]");
						      cell1530.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell1530.setLeading(20);
						      cell1530.setBorder(Rectangle.NO_BORDER);
						      cell1530.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell1530);	
						      
						      Cell cell15113 = new Cell(new Phrase("", FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell15113.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell15113.setLeading(20);
						      cell15113.setBorder(Rectangle.NO_BORDER);
						      cell15113.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell15113);	
						      
						      
						      Cell cell157 = new Cell(new Phrase(stringtokenizer.nextToken(), FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell157.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell157.setLeading(20);
						      cell157.setBorder(Rectangle.NO_BORDER);
						      cell157.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell157);	
						      
						      
						      Cell cell18 = new Cell(new Phrase("D. "+D, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell18.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell18.setLeading(20);
						      cell18.setBorder(Rectangle.NO_BORDER);
						      cell18.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell18);	
						      
						      Cell cell1529 = new Cell("[         ]");
						      cell1529.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell1529.setLeading(20);
						      cell1529.setBorder(Rectangle.NO_BORDER);
						      cell1529.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell1529);	
						      
						      Cell cell15114 = new Cell(new Phrase("", FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell15114.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell15114.setLeading(20);
						      cell15114.setBorder(Rectangle.NO_BORDER);
						      cell15114.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell15114);	
						      
						      
						      
						      Cell cell158 = new Cell(new Phrase(stringtokenizer.nextToken(), FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell158.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell158.setLeading(20);
						      cell158.setBorder(Rectangle.NO_BORDER);
						      cell158.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell158);	
						      
						      
						      
						      Cell cell19 = new Cell(new Phrase("E. "+E, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell19.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell19.setLeading(20);
						      cell19.setBorder(Rectangle.NO_BORDER);
						      cell19.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell19);	
						      
						      Cell cell1528 = new Cell("[         ]");
						      cell1528.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell1528.setLeading(20);
						      cell1528.setBorder(Rectangle.NO_BORDER);
						      cell1528.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell1528);	
						      
						      Cell cell15115 = new Cell(new Phrase("", FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell15115.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell15115.setLeading(20);
						      cell15115.setBorder(Rectangle.NO_BORDER);
						      cell15115.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell15115);	
						      
						      
						      Cell cell159 = new Cell(new Phrase(stringtokenizer.nextToken(), FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell159.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell159.setLeading(20);
						      cell159.setBorder(Rectangle.NO_BORDER);
						      cell159.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell159);	
						      
						      
						      Cell cell20 = new Cell(new Phrase("F. "+F, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell20.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell20.setLeading(20);
						      cell20.setBorder(Rectangle.NO_BORDER);
						      cell20.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell20);	
						      
						      Cell cell1527 = new Cell("[         ]");
						      cell1527.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell1527.setLeading(20);
						      cell1527.setBorder(Rectangle.NO_BORDER);
						      cell1527.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell1527);	
						      
						      Cell cell15116 = new Cell(new Phrase("", FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell15116.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell15116.setLeading(20);
						      cell15116.setBorder(Rectangle.NO_BORDER);
						      cell15116.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell15116);	
						      
						      
						      Cell cell160 = new Cell(new Phrase(stringtokenizer.nextToken(), FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell160.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell160.setLeading(20);
						      cell160.setBorder(Rectangle.NO_BORDER);
						      cell160.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell160);	
						      
						      
						      Cell cell21 = new Cell(new Phrase("G. "+G, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						      cell21.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell21.setLeading(20);
						      cell21.setColspan(2);
						      cell21.setBorder(Rectangle.NO_BORDER);
						      cell21.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell21);	
						      
						      Cell cell1526 = new Cell("[         ]");
						      cell1526.setHorizontalAlignment(Element.ALIGN_LEFT);
						      cell1526.setLeading(20);
						      cell1526.setBorder(Rectangle.NO_BORDER);
						      cell1526.setBackgroundColor(Color.WHITE);
						      optiontable.addCell(cell1526);							      
						      
						}
						
						document.add(optiontable);
			            
						if(image != null && !image.equals("-") && !image.equalsIgnoreCase("null")){
				    	  
							File file 		= new File(storagepath + "QnImage/" + image);
							if(file.exists() && file.isFile()){
				    		  
		                        Image image1 = Image.getInstance(storagepath + "QnImage/" + image);
		                        image1.scalePercent(50F);
		                        image1.scaleAbsolute(160F, 100F);
		                        image1.setAlignment(1);
		                        document.add(image1);
		                        document.add(new Paragraph("\n"));
							}
						}
						
						/*Table optiontemp = new Table(2);
						int tempwidths[] = {5, 95};
						optiontemp.setWidths(tempwidths);
						
						Cell cellt = new Cell();
						cellt.setBorder(Rectangle.NO_BORDER);
						cellt.setBackgroundColor(Color.WHITE);						
						optiontemp.addCell(cellt);
						optiontemp.insertTable(optiontable);
						
						wholetable.insertTable(optiontemp);
						document.add(wholetable);*/
			            }
			            catch(Exception e){
			            	e.printStackTrace();
			            }
						
		  			}else{
		  				
						Table questiontable = new Table(2);
		  		      	int questionwidths[] = {6, 94 };
		  		      	questiontable.setWidths(questionwidths);
						
						questiontable.setWidth(80);
						questiontable.setPadding(0.0F);
						questiontable.setSpacing(0.0F);
						questiontable.setBorder(0);
						questiontable.setBorderWidth(0.0F);
						questiontable.setBorderColor(new Color(255, 255, 255));	
						
						
						Cell cell12 = new Cell(new Phrase(hashmap.get("serialnumber")+".", FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						cell12.setHorizontalAlignment(Element.ALIGN_LEFT);
						cell12.setLeading(20);
						cell12.setBorder(Rectangle.NO_BORDER);
						cell12.setBackgroundColor(Color.WHITE);
						questiontable.addCell(cell12);	
					
						Cell cell13 = new Cell(new Phrase(FQuestion, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
						cell13.setHorizontalAlignment(Element.ALIGN_LEFT);
						cell13.setLeading(20);
						cell13.setBorder(Rectangle.NO_BORDER);
						cell13.setBackgroundColor(Color.WHITE);
						questiontable.addCell(cell13);	
						document.add(questiontable);	
						
						
					      if(image != null && !image.equals("-") && !image.equalsIgnoreCase("null")){
					    	  
					    	  File file 		= new File(storagepath + "QnImage/" + image);
					    	  if(file.exists() && file.isFile()){
					    		  
			                        Image image1 = Image.getInstance(storagepath + "QnImage/" + image);
			                        image1.scalePercent(50F);
			                        image1.scaleAbsolute(160F, 100F);
			                        if(doctype.equals("pdf"))
			                            image1.setAlignment(2);
			                        else
			                            image1.setAlignment(1);
			                        document.add(image1);
			                        document.add(new Paragraph("\n"));
					    	  }
					      }
		  			}
		  		}
		  	}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			if(document != null)
				document.close();
		}
		
		
		return 1;
	}

	public void pagenumber(String s,String s1,Document document,String instituteid,String storagepath) {
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
		   			        //over.beginText();
					        //over.setFontAndSize(bf, 10);
					        //over.setTextMatrix(10, (page.height()-20));
					        //over.showText("Question Paper");
					        //over.setFontAndSize(bf, 2f);
					        //over.endText();
					        try {
					        	ArrayList insdetails=generator.getInstituteDetails(instituteid);
					        	if(insdetails!=null && insdetails.size()>0)
					        	{
					        		HashMap map=(HashMap)insdetails.get(0);
						        	String inslogo=map.get("institutelogo")+"";
						        	String insname=map.get("institutename")+"";
						        	String contactaddress=map.get("contactaddress")+"";
						        	String country=map.get("country")+"";
						        	String state=map.get("state")+"";
						        	String mobilenumber=map.get("mobilenumber")+"";
						        	String emailid=map.get("emailid")+"";
						        	String url=map.get("url")+"";
								    currenttime		= (String)hashmap.get("currenttime");
						           	Image jpg = Image.getInstance(storagepath+inslogo);
						        	jpg.scaleAbsolute(80, 72);
						        	jpg.setAbsolutePosition(10, (page.height()-80));
						        	over.addImage(jpg);
						        	over.beginText();
				   			        over.setFontAndSize(bf, 11);
				   			        over.setTextMatrix(110, (page.height()-20));
				   			        over.showText(insname);
				   			        over.endText();
				   			        over.beginText();
				   			        over.setFontAndSize(bf, 9);
				   			        over.setTextMatrix(110, (page.height()-40));
				   			        over.showText(contactaddress);
				   			        over.endText();
				   			        over.beginText();
				   			        over.setFontAndSize(bf, 9);
				   			        over.setTextMatrix(110, (page.height()-50));
				   			        over.showText(state+","+country);
				   			        over.endText(); 
				   			        over.beginText();
				   			        over.setFontAndSize(bf, 9);
				   			        over.setTextMatrix(110, (page.height()-60));
				   			        over.showText(mobilenumber);
				   			        over.endText();
				   			        over.beginText();
				   			        over.setFontAndSize(bf, 9);
				   			        over.setTextMatrix(110, (page.height()-70));
				   			        over.showText(emailid);
				   			        over.endText();
				   			        over.beginText();
				   			        over.setFontAndSize(bf, 9);
				   			        over.setTextMatrix(110, (page.height()-80));
				   			        over.showText(url);
				   			        over.endText();
					        	}
					        	}
					        	catch(Exception e)
					        	{
					        		System.out.println("Problem in header..");
					        		e.printStackTrace();
					        	}
		   			        over.beginText();
		   			        over.setFontAndSize(bf, 10);
		   			        over.setTextMatrix((page.width()-20)/2, 20);
		   			        over.showText("- " + i+" -");
		   			        over.endText();
		   			        over.beginText();
					        over.setFontAndSize(bf, 9);
					        over.setTextMatrix((page.width()-100), 20);
					        over.showText(currenttime);
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
			        		System.out.println("Problem in out header..");
			        		de.printStackTrace();
		   			    }
		}	


    ResourceBundle resourcebundle;
    String storagepath;
    String filepath;
    Document document;
    ArrayList examList;
    ArrayList questionList;
    String examname;
    String examdate;
    String instruction;
    String starttime;
    String endtime;
    String duration;
    String subjectname;
    String boardname;
    String academicyear;
    String coursename;
    String instituteid;
    String currenttime;
    String temppath;
    String subjectcode;

    
    QuestionPreparation generator;
    HashMap hashmap;
    File file;

}


