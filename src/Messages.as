package  {
	import com.greensock.TweenLite;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BitmapFilterType;
	import flash.filters.BlurFilter;
	import flash.filters.GradientGlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.setTimeout;
	
	/**
	 * ...
	 * @author Stesel
	 */
	public class Messages extends Sprite 
	{
		
		private var myTextBox:TextField = new TextField(); 
       	private var format:TextFormat = new TextFormat();
		private var intID:uint;
		private var bkgr:Shape;
		
		
		
		public function Messages(text:String = "empty") 
		{
			//Messages.message = this;
			bkgr = new Shape();
			bkgr.graphics.beginFill(0x000000, 1);
			bkgr.graphics.drawRect(0, 0, Main.screenX, Main.screenY);
			bkgr.alpha = 0;
			addChild(bkgr);
			
			
			format.font = "Times New Roman"; 
            format.color = 0xffffff; 
            format.size = 50; 
			format.align = "center";
            format.bold = true; 
 
            myTextBox.defaultTextFormat = format; 
			
			//var myTextBox:TextField = new TextField();
			//myTextBox.text = myText; 
			myTextBox.htmlText = text; 
			myTextBox.textColor = 0xffffff; 
			
            myTextBox.width = myTextBox.textWidth + 5; 
            myTextBox.height = myTextBox.textHeight + 5;
            myTextBox.multiline = true; 
            myTextBox.wordWrap = true; 
			myTextBox.selectable = false;
			
			
            myTextBox.background = true; 
            myTextBox.backgroundColor = 0x4A2D48; 
            myTextBox.border = true; 
			
			//Додаємо обводку
			var gradientGlow: GradientGlowFilter = new GradientGlowFilter(); 
			gradientGlow.distance = 0; 
			gradientGlow.angle = 45; 
			gradientGlow.colors = [0x000000, 0xffffff];
			gradientGlow.alphas = [0, 1]; 
			gradientGlow.ratios = [0, 255]; 
			gradientGlow.blurX = 20; 
			gradientGlow.blurY = 20; 
			gradientGlow.strength = 2;
			gradientGlow.quality = BitmapFilterQuality.HIGH;
			gradientGlow.type = BitmapFilterType.OUTER;
			
			
			var myBlurFilter:BlurFilter = new BlurFilter(1, 1, 2);
			var myArrayFilters:Array = new Array(myBlurFilter, gradientGlow);
			
			
			myTextBox.filters = myArrayFilters;
			
			myTextBox.x = (Main.screenX - myTextBox.width) / 2;
			myTextBox.y = (Main.screenY - myTextBox.height) / 2 - 10;
			//myTextBox.alpha = 1;
			
           
            addChild(myTextBox);
			TweenLite.to(myTextBox, 1, { alpha: 1 } );
			TweenLite.to(bkgr, 1, { alpha: 0.2 } );
			
			//Main.view.addChild(Messages.message);
			//trace("addChild(");
			
			
			intID = setTimeout(tweenThis, 2000);
		}
		
		private function tweenThis():void 
		{
			TweenLite.to(myTextBox, 1, { alpha: 0 } );
			TweenLite.to(bkgr, 1, { alpha: 0 } );
			
			
			intID = setTimeout(remThis, 800);
			
		}
		
		private function remThis():void 
		{
			if (Main.view.contains(Main.message))
				Main.view.removeChild(Main.message);
            
			bkgr = null;
			myTextBox = null;
		}
		
	}

}