package problem_nqueens;

import java.util.ArrayList;

import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.ui.RefineryUtilities;

public class hillclimbing {
	
	board newboard = new board();
	int[][] nboard = newboard.newBoard();
	
	public int climb()
	{
		int[] current = new int[newboard.n];
		int[] neighbours = new int[newboard.n];
		
		for(int i = 0; i < nboard.length; i++)
		{
			for(int j = 0; j < nboard[i].length; j++)
			{
				System.out.print(nboard[i][j]);
			}
			System.out.println();
		}
		System.out.println();
		
		current = newboard.queenspos;
		//int it = 0;
		
		ArrayList<Integer> evalList = new ArrayList<Integer>();
		evalList.add(newboard.evaluateBoard(current));
		
		//while(newboard.evaluateBoard(current) != 0)
		for(int k = 0; k < 100; k++)
		{
			//it++;
			//System.out.println(it);
			neighbours = newboard.neighbour(current);
			if(newboard.evaluateBoard(neighbours) <= newboard.evaluateBoard(current))
			{
				//System.out.println(newboard.evaluateBoard(neighbours));
				//System.out.println("\t");
				//System.out.println(newboard.evaluateBoard(current));
				//System.out.println();
				for(int i = 0;i<newboard.n;i++)
				{
					current[i] = neighbours[i];
				}
				evalList.add(newboard.evaluateBoard(current));
			}
			
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
		
		charts chart = new charts("hillclimbing_chart","przebieg funkcji oceny",dataset);
		chart.pack();
		RefineryUtilities.centerFrameOnScreen(chart);
		chart.setVisible(true);
		
		return newboard.evaluateBoard(current);
	}
	
	/*public void showBoard()
	{
		for(int i = 0; i < nboard.length; i++)
		{
			for(int j = 0; j < nboard[i].length; j++)
			{
				System.out.print(nboard[i][j]);
			}
			System.out.println();
		}
		
		int eval = newboard.evaluateBoard(newboard.queenspos);
		System.out.println(eval);
		
		int[] newbest  = new int[newboard.n];
		newbest = newboard.neighbour(newboard.queenspos);
		
		for(int k=0;k<newbest.length;k++)
			System.out.print(newbest[k]);

		System.out.println();
		System.out.println();
		
		int[][] best = newboard.bestBoard(newbest);
		for(int i = 0; i < best.length; i++)
		{
			for(int j = 0; j < best[i].length; j++)
			{
				System.out.print(best[i][j]);
			}
			System.out.println();
		}
	}*/
	
	
}
