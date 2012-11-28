package  
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BitmapFilterType;
	import flash.filters.GradientGlowFilter;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	/**
	 * ...
	 * @author Stesel
	 */
	public class PauseButton extends Sprite 
	{
		private var graph: Sprite;
		private var gradientGlow:GradientGlowFilter;
		private var intervalId:uint;
		private var glowFlag:Boolean = false;
		private var delay:int = 200;
		
		
		
		public function PauseButton() 
		{
			
			
			graph = new PauseButton_graph();
			addChild(graph);
			
			this.addEventListener(MouseEvent.CLICK, mousePauseHandler);
			
			
			setGradientFilter();
			//this.buttonMode = true;
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
		
		private function mousePauseHandler(e:MouseEvent):void 
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
		
		public function activate(): void 
		{
			this.addEventListener(MouseEvent.CLICK, mousePauseHandler);
		}
		public function deactivate(): void 
		{
			this.removeEventListener(MouseEvent.CLICK, mousePauseHandler);
		}
		public function offGlow(): void 
		{
			Menu.resumeFlag = true;
			Menu.restartFlag = true;
			Menu.numOfBut = 0;
			
			
			Main.createMenu();
			
			
			this.filters = null;
			
			glowFlag = false;
		}
	}

}