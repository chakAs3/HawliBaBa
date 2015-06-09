package emagin.managers 
{
	import emagin.data.EventData;
	
	
	/**
	 * ...
	 * @author ©haki®
	 */
	public class AppManager 
	{
		
		 
		
		 
		public var current_events:Array;
		public var filtred_events:Array;
		public var categories:Array;
		
		public static var URL_CATS:String = "categories.xml";
		public static var URL_EVENTS:String = "xml/events.xml";
		
		public var params:Object={};
		
		
		
		private static var INSTANCE:AppManager;
		
		 
	
		public function AppManager(enfocer:SingletonEnforcer) 
		{
			 super()
		}
		public static function getInstance():AppManager {


          if (INSTANCE == null) {

           INSTANCE = new AppManager(new SingletonEnforcer());

           }
           return INSTANCE;
		}
		public function getListeVilles(data:Array):Array{
			// returner la liste des ville figurant sur le resultat de la recherche 
			
			return [];
		}
		public function getListeCategories(data:Array):Array{
			// returner la liste des categories  figurant sur le resultat de la recherche 
			
			return [];
		}
		public function getPriodeDate(arr:Array):Object {
			trace(this+" getPriodeDate ")
			var deArr:Array = arr.sort(compareInDateDebut);
			var min:Date = deArr[0].dateDebut;
			
			var finArr:Array = arr.sort(compareInDateFin);
			var max:Date = deArr[deArr.length-1].dateFin;
			
			
			return {min:min,max:max };
		}
		private function compareInDateDebut(a:Object, b:Object):int {
			trace(this + "compare-->" + a);
			if ( a.dateDebut.time > b.dateDebut.time) return 1;
			else if (a.dateDebut.time != a.dateDebut.time )
			return 0
			else return -1; 
			
			
		}
		private function compareInDateFin(a:Object, b:Object):int {
			 trace(this + "compareFin-->" + a);
			if ( (a.dateFin as Date).time > (b.dateFin as Date).time) return 1;
			else if ((a.dateFin as Date).time != (b.dateFin as Date).time )
			return 0
			else return -1; 
			
			
			 
		}
		
		
		 
		public function getVilleLabelFromId(id:int):String{
			for each ( var cat in categories ){
				if(cat.id==id)
				return cat.label;
			}
			return "inconu";
		}
		 
		
		public function getEventsCat(cat:String):Array
		{
            var arr:Array=[];
			for each ( var evenement:EventData in current_events ){
				if(evenement.categorie.toUpperCase()==cat.toUpperCase())
				 arr.push(evenement)
			}
			return arr;
		}
		public function getEventsSearch(mot:String):Array
		{
            var arr:Array=[];
			for each ( var evenement:EventData in current_events ){
				if( evenement.titre.toUpperCase().indexOf(mot.toUpperCase())>-1 || evenement.desrip.toUpperCase().indexOf(mot.toUpperCase())>-1 )
				 arr.push(evenement)
			}
			return arr;
		}
		
		private function getProjectsVille(ville:String):Array
		{
			var arr:Array=[];
			/*if(ville == "autres")
			return getAutreVilles();
			for each ( var projet:Project in current_projects ){
				if(projet.ville.toLowerCase()==ville.toLowerCase())
				 arr.push(projet)
			}*/
			return arr;
		}
		 
		
		 
		 
	 	
	}
	
}
class SingletonEnforcer {};