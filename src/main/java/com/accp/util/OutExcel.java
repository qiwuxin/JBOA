package com.accp.util;

import java.io.File;
import java.io.FileOutputStream;
import java.lang.reflect.Field;
import java.util.List;

import org.springframework.stereotype.Service;

import com.accp.pojo.Count;

import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.UnderlineStyle;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

@Service("outExcel")
public class OutExcel {
	
	/**
	 * 
	 * @param fileName  Excel表的名字
	 * @param tbTitle   Excel表数据的头部名字
	 * @param counts	Excel表数据
	 */
	public Boolean outputStreamExcel(String fileName,String[] tbTitles,List<Count> counts) {
		String afterFileName = "C:\\Users\\lenovo\\Desktop\\";
		try {
			File file = new File(afterFileName+fileName+".xls");
			
			if(file.exists()) {
				System.err.println("删除表格");
				file.delete();//如果路径中存在该名称的文件则删除
			}
			WritableWorkbook wbook = Workbook
					.createWorkbook(new File(afterFileName+fileName + ".xls")); // 建立excel文件
			
			WritableSheet wsheet = wbook.createSheet("导出数据", 0); // sheet名称(Excel表下方页的名称,0)
			
			//设置单元格的样式
			WritableCellFormat cellFormatNumber = new WritableCellFormat();
			cellFormatNumber.setAlignment(Alignment.RIGHT);
			WritableFont wf = new WritableFont(WritableFont.ARIAL, 12,
					WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE,
					jxl.format.Colour.BLACK); // 定义格式、字体、粗体、斜体、下划线、颜色
			WritableCellFormat wcf = new WritableCellFormat(wf); // title单元格定义
			WritableCellFormat wcfc = new WritableCellFormat(); // 一般单元格定义
			WritableCellFormat wcfe = new WritableCellFormat(); // 一般单元格定义
			wcf.setAlignment(jxl.format.Alignment.CENTRE); // 设置对齐方式
			wcfc.setAlignment(jxl.format.Alignment.CENTRE); // 设置对齐方式

			wcf.setBorder(jxl.format.Border.ALL,
					jxl.format.BorderLineStyle.THIN);
			wcfc.setBorder(jxl.format.Border.ALL,
					jxl.format.BorderLineStyle.THIN);
			wcfe.setBorder(jxl.format.Border.ALL,
					jxl.format.BorderLineStyle.THIN);

			wsheet.setColumnView(0, 20);// 设置列宽
			wsheet.setColumnView(1, 10);
			wsheet.setColumnView(2, 20);
			
			Integer rowIndex = 0;		//列的下标
			Integer columnIndex = 0;	//行的下标
			for (String tbTitle : tbTitles) {//循环添加表数据的头部名字
				wsheet.setRowView(rowIndex, 380);// 设置项目名行高
				wsheet.addCell(new Label(columnIndex++, rowIndex, tbTitle, wcf));
			}
			for (Count count : counts) {
				rowIndex++;		//行下移一位
				columnIndex = 0;//列重新开始
				@SuppressWarnings("rawtypes")
				Class className = count.getClass(); 	//获取类
				Field[] vals = className.getDeclaredFields();	//获取字段
				for (Field val : vals) {	
					val.setAccessible(true);	//解除private保护
					if(columnIndex<tbTitles.length&&val.get(count)!=null) {	//判断字段是否为空
						wsheet.addCell(new Label(columnIndex++, rowIndex, val.get(count).toString(), wcfc));
					}
				}
			}
			wbook.write();  
			wbook.close();
			System.err.println("123");
			return true;
			
		}catch (Exception e) {
			// TODO: handle exception
			System.err.println("错误为："+e);
			return false;
		}
	}
	
}
