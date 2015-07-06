package problem_nqueens;

import org.jfree.chart.ChartPanel;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.ui.ApplicationFrame;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.DefaultCategoryDataset;

public class charts extends ApplicationFrame
{
	private static final long serialVersionUID = 1L;

	public charts( String applicationTitle , String chartTitle, DefaultCategoryDataset dataset  )
	{
		super(applicationTitle);
		JFreeChart lineChart = ChartFactory.createLineChart(applicationTitle,"iteracja","f_oceny",dataset,PlotOrientation.VERTICAL,true,true,false);
		ChartPanel chartPanel = new ChartPanel( lineChart );
		chartPanel.setPreferredSize( new java.awt.Dimension( 560 , 367 ) );
		setContentPane( chartPanel );
	}

}
