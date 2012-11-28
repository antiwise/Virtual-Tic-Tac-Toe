package  
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BitmapFilterType;
	import flash.filters.BlurFilter;
	import flash.filters.GradientGlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	/**
	 * ...
	 * @author Stesel
	 */
	public class MenuButton extends Sprite 
	{
		private var gradientGlow:GradientGlowFilter;
		private var glowFlag:Boolean = false;
		private var delay:int = 200;
		private var intervalId:uint;
		//private var buttonText: MenuText;
		
		private var buttonText: MenuText;
		private var format:TextFormat;
		
		//private var name: String;
		
		
		
		public function MenuButton(name:String) 
		{
			if(name != null)
			this.name = name;
			
			
			for (var i:int = 0; i < this.name.length; i++)
			{
				//if trace(this.name.slice(0, 1));
				if ( this.name.charAt(i) == " ")
				this.name = this.name.slice(0, i) + this.name.slice(i +1, this.name.length);
			}
			  //this.name.replace( new RegExp( " " ), "" );
			Menu["btn" + this.name] = this;
			
			
			
			
			
			setGradientFilter();
			buttonText = new MenuText(name);
			
			//this.buttonMode = true;
			
			//buttonText.x = this.width / 2;
			//buttonText.y = this.height / 2;
			
			//this.scaleX = this.scaleY = 1.2;
			addChild(buttonText);
			
			
			this.addEventListener(MouseEvent.CLICK, this_click);
		}
		
		private function setTextFormat():void 
		{
			
		}
		
		private function setGradientFilter():void 
		{
			gradientGlow = new GradientGlowFilter(); 
			gradientGlow.distance = 0; 
			gradientGlow.angle = 45; 
			gradientGlow.colors = [0x000000, 0x00A3FF];
			gradientGlow.alphas = [0, 1]; 
			gradientGlow.ratios = [0, 255]; 
			gradientGlow.blurX = 5; 
			gradientGlow.blurY = 5; 
			gradientGlow.strength = 2;
			gradientGlow.quality = BitmapFilterQuality.HIGH;
			gradientGlow.type = BitmapFilterType.OUTER;
		}
		
		private function this_click(e:MouseEvent):void 
		{	
			
			
			
			
			
			
			
			if(!glowFlag)
			onGlow();
			else
			clearTimeout(intervalId);
			
			intervalId = setTimeout(offGlow, delay);
			
			
			
		}
		
		public function onGlow(): void 
		{
			this.filters = [gradientGlow];
			
			glowFlag = true;
		}
		
		public function offGlow(): void 
		{
			Menu.menu["pressed" + this.name.valueOf()]();
			
			this.filters = null;
			
			glowFlag = false;
		}
		
	}

}