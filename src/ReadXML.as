package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Stesel
	 */
	public class ReadXML extends Sprite 
	{
		
		private var dataXML:XML;
		private var xmlList:XMLList;
		public var buttonName: String;
		
		
		
		static public var  attribute1: String = "empty";  
		
		
		
		
		public function ReadXML (attr: String)
		{
			attribute1 = attr;
			
			
			
			var request:URLRequest = new URLRequest("data.xml"); 
			var loader:URLLoader = new URLLoader(); 
			
			loader.addEventListener(Event.COMPLETE, completeHandler); 
           
			try 
            { 
                loader.load(request); 
            } 
            catch (error:ArgumentError) 
            { 
                trace("An ArgumentError has occurred."); 
            } 
            catch (error:SecurityError) 
            { 
                trace("A SecurityError has occurred."); 
            } 
			
        } 
		
		public function getButtonName():String 
		{
			return buttonName;
		}
		
		
		
		private function completeHandler(e:Event):void 
		{
			dataXML = XML(e.target.data); 
            //trace(dataXML.toXMLString()); 
			
			xmlList = dataXML.children();
			//trace(xmlList);
			//trace(xmlList.length());
			//xmlList
			for(var i:int=0; i,xmlList.length(); i++)
			{
				//trace(xmlList[i]);
				if (xmlList[i] == attribute1)
				{
					buttonName = xmlList[i].attributes()[0];
					//
					//
					//trace("1");
					break;
				}
				//
				//
			}
			
		}
		
		
		
	}

}