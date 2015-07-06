package problem_nqueens;



import java.util.ArrayList;
import java.util.Random;

import org.apache.commons.math3.stat.descriptive.DescriptiveStatistics;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.ui.RefineryUtilities;

public class simulatedannealing {

	board newboard = new board();
	int[][] nboard = newboard.newBoard();
	
	public double ostd()
	{
		double ostd = 0.0f;
		DescriptiveStatistics stats = new DescriptiveStatistics();
		ArrayList<Double> testEval = new ArrayList<Double>();
		
		int[] testcurrent = new int[newboard.n];
		testcurrent = newboard.queenspos;
		
		int[][] testforTemp = newboard.testNeighbours(testcurrent);
		
		for(int i = 0; i < testforTemp.length; i++)
		{
			for(int j = 0; j < testforTemp[i].length; j++)
			{
				testEval.add((double)testforTemp[i][j]);
			}
		}
			
		
		for(int i = 0; i < testEval.size(); i++) 
		{
	        stats.addValue(testEval.get(i));;
		}
	
		ostd = stats.getStandardDeviation();
			
		return ostd;
	}
	
	
	public int annealing()
	{
		double startingTemp = ostd();
		int nofIter = 10;
		int costDiff = 0;
		int[] current = new int[newboard.n];
		int[] neighbours = new int[newboard.n];
		
		current = newboard.queenspos;
		
		ArrayList<Integer> evalList = new ArrayList<Integer>();
		evalList.add(newboard.evaluateBoard(current));
		
		for(int k = 0; k < nofIter; k++)
		{
			for(int i = 0; i < nofIter; i++)
			{
				
				neighbours = newboard.neighbour(current);
				costDiff = newboard.evaluateBoard(neighbours) - newboard.evaluateBoard(current);
				if(costDiff < 0)
				{
					for(int j = 0;j<newboard.n;j++)
					{
						current[j] = neighbours[j];
					}
					evalList.add(newboard.evaluateBoard(current));
				}
				else
				{
					Random rand = new Random();
					double x = rand.nextDouble();
					if(x < Math.exp(-costDiff/startingTemp))
					{
						for(int j = 0;j<newboard.n;j++)
						{
							current[j] = neighbours[j];
						}
						evalList.add(newboard.evaluateBoard(current));
					}
				}
				
			}
			startingTemp = newboard.changeTemp(startingTemp);
		}
		
		int[][] best = newboard.bestBoard(current);
		for(int i = 0; i < best.length; i++)
		{
			for(int j = 0; j < best[i].length; j++)
			{
				System.out.print(best[i][j]);
			}
			System.out.println();
		}
		System.out.println();
		System.out.println(evalList);
		
		DefaultCategoryDataset dataset = new DefaultCategoryDataset( );
		
		for(int i = 0; i < evalList.size(); i++)
		{
			String strI = Integer.toString(i);
			dataset.addValue((double)evalList.get(i), "ocena_planszy", strI);
		}
		
		charts chart = new charts("simulatedannealing_chart","przebieg funkcji oceny",dataset);
		chart.pack();
		RefineryUtilities.centerFrameOnScreen(chart);
		chart.setVisible(true);
		
		return newboard.evaluateBoard(current);
		
	}
	
}
