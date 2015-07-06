package problem_nqueens;

import java.util.ArrayList;

import org.apache.commons.math3.stat.descriptive.DescriptiveStatistics;

public class Main {
	public static void main(String args[]){
		ArrayList<Double> meanhc = new ArrayList<Double>();
		ArrayList<Double> meansa = new ArrayList<Double>();
		DescriptiveStatistics statshc = new DescriptiveStatistics();
		DescriptiveStatistics statssa = new DescriptiveStatistics();
		
		for(int i = 0; i < 10; i++)
		{
			hillclimbing newhc = new hillclimbing();
			meanhc.add((double)newhc.climb());
			
			simulatedannealing newsa = new simulatedannealing();
			meansa.add((double)newsa.annealing());
		}
		for(int j = 0; j < meanhc.size(); j++) 
		{
	        statshc.addValue(meanhc.get(j));;
		}
		System.out.println("Hillclimbing mean: ");
		System.out.println(statshc.getMean());
		
		for(int j = 0; j < meansa.size(); j++) 
		{
	        statssa.addValue(meansa.get(j));;
		}
		System.out.println("Annealing mean: ");
		System.out.println(statssa.getMean());
	}

}
