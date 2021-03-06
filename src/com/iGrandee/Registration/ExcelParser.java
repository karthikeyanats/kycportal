package com.iGrandee.Registration;

import java.io.InputStream;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;

public class ExcelParser
{

    private static Logger logger = Logger.getLogger(ExcelParser.class.getName());
    private static final int MAX_ROW_COUNT = 10000;
/*
    public static String getHeaderName(String importDataTable, int index) throws Exception
    {
        TableDefinition tDef = MetaDataUtil.getTableDefinitionByName(importDataTable);
        ColumnDefinition colDef = tDef.getColumnDefinitionByName("Crm_" + index);
        return colDef.getDescription();
    }




	public static List getHeaders(String tempTableName) throws Exception
	{
		TableDefinition tDef = MetaDataUtil.getTableDefinitionByName(tempTableName);
		List colDefs = tDef.getColumnList();
		List headers = new ArrayList();
		for (int i = 0; i < colDefs.size(); i++)
		{
			ColumnDefinition colDef = (ColumnDefinition) colDefs.get(i);
			String name = colDef.getColumnName();
			String actualName = colDef.getDescription();
			if (name.startsWith("Crm_"))
			{
				headers.add(actualName);
			}
		}
		return headers;
	}

	 */


	public static String parseAndDumpToDB(String fileName, InputStream stream, boolean isDataMigration) throws Exception
	{
	        return parseAndDumpToDB(fileName, stream, isDataMigration, null, true, null);
	}


	public static String parseAndDumpToDB(String fileName, InputStream stream, boolean isDataMigration, String module, boolean dumpData) throws Exception
	{
		return parseAndDumpToDB(fileName, stream, isDataMigration, module, dumpData, null);
	}

	public static String parseAndDumpToDB(String fileName, InputStream stream, boolean isDataMigration, String module, boolean dumpData, Long userId) throws Exception
	{
		return parseAndDumpToDB(fileName, stream, isDataMigration, module, dumpData, null,null);
	}

	public static String parseAndDumpToDB(String fileName, InputStream stream, boolean isDataMigration, String module, boolean dumpData, Long userId,HashMap entityMapString) throws Exception
	{
		Date startTime = new Date();
		/*
		if (fileName.endsWith(".csv") || fileName.endsWith(".CSV"))
		{
			String str = parseCSVAndDumpToDB(stream, isDataMigration, module, dumpData, userId,entityMapString);
			Date endTime = new Date();
			logger.info("Starting import for file = " + fileName + " at " + startTime.getTime());
			logger.info("Ending import for file = " + fileName + " at " + endTime.getTime());
			logger.info("Import took = " + (endTime.getTime() - startTime.getTime()));
			return str;
		}
		else */
		if (fileName.endsWith(".xls") || fileName.endsWith(".XLS"))
		{
			String str = parseXLSAndDumpToDB(stream, isDataMigration, module, dumpData, userId,entityMapString);
			Date endTime = new Date();
			logger.info("Starting import for file = " + fileName + " at " + startTime.getTime());
			logger.info("Ending import for file = " + fileName + " at " + endTime.getTime());
			logger.info("Import took = " + (endTime.getTime() - startTime.getTime()));
			return str;
		}

		//throw new FileTypeNotSupportedException();
		throw new Exception();
	}
/*
	private static String parseCSVAndDumpToDB(InputStream stream, boolean isDataMigration) throws Exception
	{
		return parseCSVAndDumpToDB(stream, isDataMigration, null, true, null,null);
	}


	private static String parseCSVAndDumpToDB(InputStream stream, boolean isDataMigration, String module, boolean dumpData, Long userId,HashMap entityMapString) throws Exception
	{
		Persistence persistanceHandle = PersistenceCacheUtil.getPersistenceLiteHandle();
		DataObject dObj = persistanceHandle.constructDataObject();
		String tableName = getUniqueTableName();
		Vector headers = new Vector();

		boolean isOwnerMapped=false;
		int ownerheader=-1;
		if(module.equals("Contacts") && entityMapString!=null)
		{
			ArrayList colmaps = (ArrayList)entityMapString.get("Contacts");
			for(int i=0;i<colmaps.size();i++)
			{
				String[] mapping = (String[])colmaps.get(i);
				if(mapping[0].equals("CrmSalesEntity") && mapping[1].equals("SMOWNERID"))
				{
					isOwnerMapped=true;
					ownerheader = Integer.parseInt(mapping[2]);
					break;
				}
			}
		}

		BufferedReader bfreader = new BufferedReader(new InputStreamReader(stream));
		if (isDataMigration)
		{
			bfreader = new BufferedReader(new InputStreamReader(stream, "ISO-8859-1"));
		}

		String headerLine = null;
		if ((headerLine = bfreader.readLine()) != null)
		{
			CSVReader reader = new CSVReader(new StringReader(headerLine), null);
			headers.addAll(reader.getAllFieldsInLine());
			reader.close();
		}
		Vector csvHeaders=new Vector(headers);
		createTempTableDefinition(tableName, headers, "csv", userId);

		if (dumpData)
		{
			long row = 0;
			long count = 0;
			long totalContacts = CommonDBService.getTotalNoOfContacts();
			boolean isContacts = module.equals("Contacts");
			String licenseType = LicenseUtil.getLicenseType();
			boolean isFree = (licenseType != null && licenseType.equals("Free"));
			boolean doLimitCheck = (isFree && isContacts);

			try
			{
				int rowCount = 0;
				HashMap headerVsLength=ImportDBService.getMaxLength(tableName, entityMapString);
				while (true) {
					if ((headerLine = bfreader.readLine()) != null && !headerLine.trim().equals("")) {
						CSVReader reader = new CSVReader(new StringReader(headerLine), bfreader);
						Vector data = reader.getAllFieldsInLine();

						Row rowObj = new Row(tableName);
						rowObj.set("ROWNUMBER", new Long(row + 2));
						for (int j = 0; j < headers.size(); j++) {
							String head = (String) headers.get(j);
							String csvHeader=(String)csvHeaders.get(j);
							int maxLength=3000;
							String dataType=null;
							Object val=null;
							String strData = (String) data.get(j);
							if(headerVsLength.containsKey(head))
							{
								Object[] columnData=(Object[])headerVsLength.get(head);
								dataType=(String)columnData[0];
								maxLength=(Integer)columnData[1];
								try
								{
									//	val=ImportDBHelper.convertValue(strData, maxLength, dataType, userId);
									if(isOwnerMapped && j==ownerheader)
									{
										val = strData;
									}
									else
									{
										val=ImportDBHelper.convertValue(strData, maxLength, dataType, userId);
									}
								}
								catch(Exception e)
								{
									e.printStackTrace();
									throw new ImportParseException(row+2,csvHeader,tableName);
								}
							}
							 rowObj.set(head, val);
						}
						row++;
						count++;

						boolean addRow = true;
						{
							if (doLimitCheck) {
								if (row > (50 - totalContacts)) {
									addRow = false;
								}
							}
						}
						if (addRow) {
							dObj.addRow(rowObj);
						}
						if (count > 2000) {
							persistanceHandle.add(dObj);
							dObj = null;
							dObj = persistanceHandle.constructDataObject();
							count = 0;

							Thread.yield();
							System.gc();
						}
						reader.close();
						reader = null;
					}
					else
					{
						if (!dObj.isEmpty())
						{
							persistanceHandle.add(dObj);
							dObj = null;
						}
						break;
					}
				}
			}
			catch (EOFException eof)
			{
			//  EOF is reached
			}
		}
		return tableName;
	}

	*/

	private static String parseXLSAndDumpToDB(InputStream stream, boolean isDataMigration) throws Exception
	{
		return parseXLSAndDumpToDB(stream, isDataMigration, null, true, null,null);
	}


	private static String parseXLSAndDumpToDB(InputStream stream, boolean isDataMigration, String module, boolean dumpData, Long userId,HashMap entityMapString) throws Exception
	{
		String tableName = "";
		Vector valueVec = new Vector();
		boolean isOwnerMapped=false;
		int ownerheader=-1;
		if(module.equals("Contacts") && entityMapString!=null)
		{
			ArrayList colmaps = (ArrayList)entityMapString.get("Contacts");
			for(int i=0;i<colmaps.size();i++)
			{
				String[] mapping = (String[])colmaps.get(i);
				if(mapping[0].equals("CrmSalesEntity") && mapping[1].equals("SMOWNERID"))
				{
					isOwnerMapped=true;
					ownerheader = Integer.parseInt(mapping[2]);
					break;
				}
			}
		}
		HSSFWorkbook workBook = getWorkBook(stream);
		Vector headers = getXLSHeaders(workBook);
		logger.log(Level.FINER, "Headers in the file are: " + headers);
		//tableName = getUniqueTableName();
		//HashMap headerMap = createTempTableDefinition(tableName, headers, "xls", userId);
		HashMap headerMap =null;
		logger.log(Level.FINER, "Temp table created for XLS with name: " + tableName);
		if (dumpData)
		{
		long crow = 0;
		long count = 0;
		//Persistence persistanceHandle = PersistenceCacheUtil.getPersistenceLiteHandle();
		//DataObject dObj = persistanceHandle.constructDataObject();
		int sheets = workBook.getNumberOfSheets();
		//HashMap headerVsLength=ImportDBService.getMaxLength(tableName, entityMapString);
		for (int i = 0; i < sheets; i++)
		{
			HSSFSheet sheet = workBook.getSheetAt(i);
			int rows = sheet.getPhysicalNumberOfRows();
			if (rows <= 0)
			{
				continue;
			}

			if (!isDataMigration && rows > MAX_ROW_COUNT + 1)
			{
				//throw new RowCountOutOfLimitException();
				throw new Exception();
			}

			if (module != null && module.equals("Contacts"))
			{
				String licenseType ="Free"; //LicenseUtil.getLicenseType();
				if (licenseType != null && licenseType.equals("Free"))
				{
					long totalContacts =0; //CommonDBService.getTotalNoOfContacts();
					if ((rows - 1) > (50 - totalContacts))
					{
						rows = 50 - (int) totalContacts + 1;
					}
				}
			}
			HSSFRow row = sheet.getRow(0);
			int cells = row.getPhysicalNumberOfCells();
			for (int r = 1; r < rows; r++)
			{

				System.out.println("inside commented for loop");
				/*
				Row rowObj = new Row(tableName);
				rowObj.set("SHEETNUMBER", new Long(i + 1));
				rowObj.set("ROWNUMBER", new Long(r + 2));

				row = sheet.getRow(r);
				for (short c = 0; c < cells; c++)
				{
					HSSFCell cell = row.getCell(c);
					String xlHeader = getXLSHeader(sheet, c);
					String header = (String) headerMap.get(xlHeader);
					if (header == null || header.trim().length() == 0)
					{
						continue;
					}
					int maxLength=3000;
					String dataType=null;
					Object val=null;
					if(headerVsLength.containsKey(header))
					{
						Object[] columnData=(Object[])headerVsLength.get(header);
						dataType=(String)columnData[0];
						maxLength=(Integer)columnData[1];
						try
						{
							if(isOwnerMapped && c==ownerheader)
							{
								val = getStrValueOfCell(cell,dataType);
							}
							else
							{
								val = getValueOfCell(cell,dataType);
							}
						}
						catch(Exception e)
						{
							throw new ImportParseException(r,xlHeader,tableName);
						}
						 if (val != null)
						 {
							 String value=val.toString();
							 value = value.trim();
							 if (value.length()!=0 && maxLength!=0 && value.length() > maxLength)
							 {
								 val = value.substring(0, maxLength);
							 }
							 else if(value.length()<=0)
							 {
								val=null;
							 }
						 }
					}
					rowObj.set(header, val);
				}
				dObj.addRow(rowObj);*/
			  }
				crow++;
				count++;
				if (count > 1000)
				{
					//persistanceHandle.add(dObj);
					//dObj = null;
					//dObj = persistanceHandle.constructDataObject();
					count = 0;

					Thread.yield();
					System.gc();
				}
			}
			//if (!dObj.isEmpty())
			//{
				//persistanceHandle.add(dObj);
			//}
		}
		return tableName;
	}

	public static Vector getXLSHeaders(HSSFWorkbook workBook) throws Exception
	{
		Vector headerVec = new Vector();
		int sheets = workBook.getNumberOfSheets();
		for (int i = 0; i < sheets; i++)
		{
			Vector headers = getXLSHeaders(workBook, i);
			for (int j = 0; j < headers.size(); j++)
			{
				Object header = headers.get(j);
				if (!headerVec.contains(header))
				{
					headerVec.add(header);
				}
			}
		}
		return headerVec;
	}

	public static Vector getXLSHeaders(HSSFWorkbook workBook, int numOfSheet) throws Exception
	{
		Vector headers = new Vector();
		HSSFSheet sheet = workBook.getSheetAt(numOfSheet);
		int rows = sheet.getPhysicalNumberOfRows();
		if (rows > 0)
		{
			HSSFRow row = sheet.getRow(0);
			int cells = row.getPhysicalNumberOfCells();
			for (short cell = 0; cell < cells; cell++)
			{
				HSSFCell cellObj = row.getCell(cell);
				Object value = getValueOfCell(cellObj,"CHAR");
				if (value != null)
				{
					value = value.toString().trim();
				}
				if (value != null && !headers.contains(value))
				{
					headers.add(value);
				}
			}
		}

		return headers;
	}

	public static String getXLSHeader(HSSFSheet sheet, short column) throws Exception
	{
		HSSFRow row = sheet.getRow(0);
		HSSFCell cell = row.getCell(column);
		String header =(String) getValueOfCell(cell,"CHAR");
		if (header != null)
		{
			header = header.trim();
		}
		return header;
	}

	public static Object getStrValueOfCell(HSSFCell cell,String dataType) throws Exception
	{
		Object value = null;
		String subVal=null;
		if (cell != null)
		{
			switch (cell.getCellType())
			{
				case HSSFCell.CELL_TYPE_NUMERIC:
					subVal = "" + cell.getNumericCellValue();
					if (subVal != null && subVal.trim().length()!=0)
					{
						subVal = NumberFormat.getNumberInstance().parse(subVal).toString();
					}
					break;
				case HSSFCell.CELL_TYPE_STRING:
					subVal = ""+cell.getStringCellValue();
					break;
				case HSSFCell.CELL_TYPE_BOOLEAN:
					subVal = ""+cell.getBooleanCellValue();
					break;
				default:
				subVal=null;
			}
			if(subVal==null || subVal.trim().length()==0)
			{
				return null;
			}

		}
		return subVal;
	}

	public static Object getValueOfCell(HSSFCell cell,String dataType) throws Exception
	{
		Object value = null;
		String subVal=null;
		if (cell != null)
		{
			switch (cell.getCellType())
			{
				case HSSFCell.CELL_TYPE_NUMERIC:
					subVal = "" + cell.getNumericCellValue();
					if (subVal != null && subVal.trim().length()!=0)
					{
						subVal = NumberFormat.getNumberInstance().parse(subVal).toString();
					}
					break;
				case HSSFCell.CELL_TYPE_STRING:
					subVal = ""+cell.getStringCellValue();
					break;
				case HSSFCell.CELL_TYPE_BOOLEAN:
					subVal = ""+cell.getBooleanCellValue();
					break;
				default:
					subVal=null;
			}
			if(subVal==null || subVal.trim().length()==0)
			{
				return null;
			}
			if (dataType.equals("BIGINT"))
			{
				value =new Long(subVal);
			}
			else if (dataType.equals("INTEGER"))
			{
				value = new Integer(subVal);
			}
			else if (dataType.equals("FLOAT"))
			{
				value =new Float(subVal);
			}
			else if (dataType.equals("BOOLEAN"))
			{
				value=subVal;
			}
			else if (dataType.equals("DOUBLE"))
			{
				value = new Double(subVal);
			}
			else if (dataType.equals("CHAR"))
			{
				value = new String(subVal);
			}
			else if (dataType.equals("DATE"))
			{
				double d = cell.getNumericCellValue();
				value = HSSFDateUtil.getJavaDate(d);
				SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
				value=df.format(value);
			}
			else if (dataType.equals("DATETIME"))
			{
				double d = cell.getNumericCellValue();
				value = HSSFDateUtil.getJavaDate(d);
				SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd hh:mm");
				value=df.format(value);
			}
		}
		return value;
	}

	public static HSSFWorkbook getWorkBook(InputStream stream) throws Exception
	{
		POIFSFileSystem fs = new POIFSFileSystem(stream);
		HSSFWorkbook workBook = new HSSFWorkbook(fs);
		return workBook;
	}

    private static Vector fillVector(Vector vec, Object val)
    {
        for (int i = 0; i < vec.capacity(); i++)
        {
            vec.add(val);
        }
        return vec;
    }




}








