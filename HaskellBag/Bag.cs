using System.Collections.Generic;
using System;



namespace HaskellBag
{
    public delegate T CombineFunction<T>(T itemone , T itemtwo);

    public delegate bool CompareFunction<T>(T itemone , T itemtwo);

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

        public Bag<T> Join(Bag<T> other , CompareFunction<T> compare , CombineFunction<T> combine)
        {
            Bag<T> newBag = new Bag<T>();
            foreach(T thisItem in this)
            {
                foreach(T otherItem in this)
                {
                    if(compare(thisItem , otherItem))
                        newBag.Add(combine(thisItem , otherItem));
                }
            }

            return newBag;
        }

		public Predicate<T> Not(Predicate<T> predicate){
			return x => !predicate(x);
		}

        public Predicate<T> And(Predicate<T> predone , Predicate<T> predtwo)
        {
            return x => predone(x) && predtwo(x);
        }
	}	
}
