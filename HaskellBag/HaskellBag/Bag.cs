using System.Collections.Generic;
using System;



namespace HaskellBag
{
	public delegate T MappingFunction<T>(T item);
	
	public delegate bool Predicate<T>(T item);
	
	public class Bag<T> : List<T>
	{	
		public Bag<T> Where(Predicate<T> predicate){
			Bag<T> newBag = new Bag<T>();
			foreach(T item in this){
				if(predicate(item)){
					newBag.Add(item);
				}
			}
			return newBag;
			
		}
		
		public Bag<T> Map(MappingFunction<T> function){
			Bag<T> newBag = new Bag<T>();
			foreach(T item in this){
				newBag.Add(function(item));
			}
			return newBag;
		}

		public Predicate Not(Predicate predicate){
			return x => !predicate;
		}
	}
	
	
}
