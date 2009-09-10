using System.Collections.Generic;
using System;



namespace HaskellBag
{
	public delegate BagRecord MappingFunction(BagRecord item);
	
	public delegate bool Predicate(BagRecord item);
	
	public class Bag : List<BagRecord>
	{	
		public Bag Where(Predicate predicate){
			Bag newBag = new Bag();
			foreach(BagRecord item in this){
				if(predicate(item)){
					newBag.Add(item);
				}
			}
			return newBag;
			
		}
		
		public Bag Map(MappingFunction function){
			Bag newBag = new Bag();
			foreach(BagRecord item in this){
				newBag.Add(function(item));
			}
			return newBag;
		}

		public Predicate Not(Predicate predicate){
			return x => !predicate;
		}
	}

	public BagRecord : Dictionary<String,Object>{
	}
	
	
}
