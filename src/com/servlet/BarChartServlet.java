package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.CategoryLabelPositions;
import org.jfree.chart.axis.ValueAxis;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.BarRenderer3D;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;

public class BarChartServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public BarChartServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//设置返回类型为图片
		response.setContentType("image/png");
		//获取数据集对象
		CategoryDataset dataset=createDataset();
		//创建图形对象
		JFreeChart jfreechart=ChartFactory.createBarChart3D(" ", "by person", "using time", dataset,PlotOrientation.VERTICAL, true,true,false);
		//获得图表区域对象
		CategoryPlot categoryplot=(CategoryPlot)jfreechart.getPlot();
		//设置网格线可见
		categoryplot.setDomainGridlinesVisible(true);
		//获得x轴对象
		CategoryAxis categoryAxis=categoryplot.getDomainAxis();
		//设置x轴显示的分类名称的显示位置，如果不设置则为水平显示，设置后，可以斜像显示。分类角度，图表空间有限时建议使用
		categoryAxis.setCategoryLabelPositions(CategoryLabelPositions.createUpRotationLabelPositions(0.39269908169872414D));
		categoryAxis.setCategoryMargin(0.0D);
		//获显示图形对象
		BarRenderer3D barrenderer3d=(BarRenderer3D)categoryplot.getRenderer();
		//设置不显示边框线
		barrenderer3d.setDrawBarOutline(false);
		
		//将图表以数据流的形式传到前端
		ChartUtilities.writeChartAsPNG(response.getOutputStream(), jfreechart, 750, 400);
	}
  private static CategoryDataset createDataset(){
	  String[] category1={"lee","liyunlong","zhangsan","lisi","simon"};
      String[] category2={"meetingroom1","meetingroom2","meetingroom3","meetingroom4","meetingroom5"};
      DefaultCategoryDataset defaultdataset=new DefaultCategoryDataset();
      for(int i=0;i<category1.length;i++){
    	  String category=category1[i];
    	  for(int j=0;j<category2.length;j++){
    		  String cat=category2[j];
    	  defaultdataset.addValue(DataUtils.getBarData(cat,category), cat, category);
    	  }
      }
      return defaultdataset;
  
  }
	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
