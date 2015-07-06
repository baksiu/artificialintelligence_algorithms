package problem_nqueens;

import java.util.ArrayList;
import java.util.Random;
//import java.util.Scanner;

public class board 
{
	public int n;
	public int[][] nboard;
	public int[] queenspos;
	
	public int[][] newBoard()
	{
		//System.out.println("Podaj wielkosc problemu: ");
		//Scanner input = new Scanner(System.in);
		n = 8; //input.nextInt();
		
		
		nboard = new int[n][n];
		queenspos = new int[n];
		
		for(int j = 0; j < nboard.length; j++)
		{
			Random rand = new Random();
			int i = rand.nextInt(n);
			nboard[i][j] = 1;
			queenspos[j] = i;
			
		}
		//input.close();
		return nboard;
	}
	
	public int evaluateBoard(int[] qpos)
	{
		int h = 0;
		
		for(int i = 0; i < qpos.length; i++)
		{
			for(int j = i+1; j<qpos.length;j++)
			{
				if(qpos[i] == qpos[j])
				{
					h++;
				}
				
				int offset = j - i;
				
			    if((qpos[i] == (qpos[j] - offset)) || (qpos[i] == (qpos[j] + offset)))
			    {
			    	h++;
			    }
			}
		}
		
		return h;
	}
	
	public int[] neighbour(int[] qpos)
	{
		int[] bestneighbour = new int[n];
		int[] tmpqpos = new int[n];
		int[][] evalBoard = new int[n][n];
		
		for(int k=0;k<qpos.length;k++)
			bestneighbour[k] = qpos[k];
		
		for(int j = 0; j < qpos.length; j++)
		{
			for(int k=0;k<qpos.length;k++)
				tmpqpos[k] = qpos[k];

			for(int i = 0; i < qpos.length; i++)
			{
				tmpqpos[j] = i;
				evalBoard[i][j] = evaluateBoard(tmpqpos);
			}
		}
		
		/*for(int i = 0; i < qpos.length; i++)
		{
			for(int j = 0; j < qpos.length; j++)
			{
				System.out.print(evalBoard[i][j]);
			}
			System.out.println();
		}*/
		
		int min = evalBoard[0][0];
		ArrayList<Integer> idim = new ArrayList<Integer>();
		ArrayList<Integer> jdim = new ArrayList<Integer>();
		
		for(int i = 0; i < evalBoard.length; i++)
		{
			for(int j = 0; j < evalBoard.length; j++)
			{
				if(evalBoard[i][j] <= min)
				{
					min = evalBoard[i][j];
				}
			}
		}
		for(int i = 0; i < evalBoard.length; i++)
		{
			for(int j = 0; j < evalBoard.length; j++)
			{
				if(evalBoard[i][j] == min)
				{
					idim.add(i);
					jdim.add(j);
				}
			}
		}
		
		if(idim.size() > 1)
		{
			Random rand = new Random();
			int nrand = rand.nextInt(idim.size());	
			bestneighbour[jdim.get(nrand)] = idim.get(nrand);
		}
		else
		{
			bestneighbour[jdim.get(0)] = idim.get(0);
		}
		
		
		//System.out.println(min);
		
		return bestneighbour;
	}
	
	public int[][] testNeighbours(int[] qpos)
	{
		int[] bestneighbour = new int[n];
		int[] tmpqpos = new int[n];
		int[][] evalBoard = new int[n][n];
		
		for(int k=0;k<qpos.length;k++)
			bestneighbour[k] = qpos[k];
		
		for(int j = 0; j < qpos.length; j++)
		{
			for(int k=0;k<qpos.length;k++)
				tmpqpos[k] = qpos[k];

			for(int i = 0; i < qpos.length; i++)
			{
				tmpqpos[j] = i;
				evalBoard[i][j] = evaluateBoard(tmpqpos);
			}
		}
		return evalBoard;
	}
	
	public int[][] bestBoard(int[] qpos)
	{
		int[][] bestBoard = new int[n][n];
		
		for(int i = 0; i < bestBoard.length; i++)
		{
			for(int j = 0; j < bestBoard.length; j++)
			{
				bestBoard[i][j] = 0;
			}
		}
		
		for(int i = 0;i<qpos.length;i++)
		{
			bestBoard[qpos[i]][i] = 1;
		}
		
		return bestBoard;
	}
	
	public double changeTemp(double currentTemp)
	{
		double newTemp = 0;
		
		newTemp = currentTemp * 0.95f;
		
		return newTemp;
	}
}
