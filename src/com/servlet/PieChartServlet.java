package com.servlet;

import java.awt.Font;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PiePlot;
import org.jfree.data.general.DefaultPieDataset;
import org.jfree.data.general.PieDataset;

public class PieChartServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public PieChartServlet() {
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
      request.setCharacterEncoding("utf-8");
	  response.setContentType("image/png");
	  response.setCharacterEncoding("utf-8");
	  PieDataset dataset=createPieDataset();
	  JFreeChart jfreechart=ChartFactory.createPieChart(
			  " ", dataset, true, true, false);
	  PiePlot pieplot=(PiePlot)jfreechart.getPlot();
	  pieplot.setLabelFont(new Font("宋体", 0, 12));
	  pieplot.setNoDataMessage("沒有使用记录");
	  pieplot.setCircular(false);
	  pieplot.setLabelGap(0.02D);
	  ChartUtilities.writeChartAsPNG(response.getOutputStream(), jfreechart,720, 400); 
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	private static PieDataset createPieDataset(){
		DefaultPieDataset defaultpiedataset=new DefaultPieDataset();
		defaultpiedataset.setValue("meetingroom1", DataUtils.getData1());
		defaultpiedataset.setValue("meetingroom2", DataUtils.getData2());
		defaultpiedataset.setValue("meetingroom3", DataUtils.getData3());
		defaultpiedataset.setValue("meetingroom4", DataUtils.getData4());
		defaultpiedataset.setValue("meetingroom5", DataUtils.getData5());
		return defaultpiedataset;
	}
	public void init() throws ServletException {
		// Put your code here
	}

}
