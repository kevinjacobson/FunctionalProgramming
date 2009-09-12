using System;
using System.Collections.Generic;

namespace HaskellBag
{
	class MainClass
	{

        List<List<Object>> list = new List<List<Object>> { new List<Object> {"Sandy" , "Ferrara" , 55178 , false} , 
                                                           new List<Object> {"Tina", "Sturgis" , 57905 , false} ,
                                                           new List<Object> {"Joanne" , "Catan" , 56084 , false} , 
                                                           new List<Object> {"Eileen" , "Wilczak" , 57146 , false} ,
                                                           new List<Object> {"Jason" , "Harrison" , 52529 , true} , 
                                                           new List<Object> {"Christina" , "Rohr" , 52995 , false} ,
                                                           new List<Object> {"Liane" , "Fitzgerald" , 52994 , false} ,
                                                           new List<Object> {"James" , "Craig" , 55254 , true} ,
                                                           new List<Object> {"Sam" , "Waters" , 54934 , true} ,
                                                           new List<Object> {3021 , 55178} ,
                                                           new List<Object> {3012 , 57905} ,
                                                           new List<Object> {3671 , 57905} ,
                                                           new List<Object> {3008 , 56084} ,
                                                           new List<Object> {3005 , 57146} ,
                                                           new List<Object> {3005 , 52529} ,
                                                           new List<Object> {3022 , 52995} ,
                                                           new List<Object> {3022 , 52994} ,
                                                           new List<Object> {3599 , 55254} ,
                                                           new List<Object> {3596 , 54934} };

		public static void Main(string[] args)
		{
			Console.WriteLine("Hello World!");
		}
	}
}