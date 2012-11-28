package  
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BitmapFilterType;
	import flash.filters.BlurFilter;
	import flash.filters.GradientGlowFilter;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Stesel
	 */
	public class MenuText extends Sprite 
	{
		
		private var format:TextFormat;
		
		private var textMenu:TextField;
		
		
		
		private var bkMenu:Shape;
		
		
		
		public function MenuText(text:String = "empty") 
		{
			//Формат тексту
            var format:TextFormat = new TextFormat();
            //format.font = "Arial";
            format.font = "Times New Roman";
            format.color = 0xffffff;
            format.size = 50;
			format.align = "center";
			format.bold = true;
			
			
			
			var tf:TextField = new TextField();
			
			tf.defaultTextFormat = format;
			//tf.antiAliasType = "advanced";
			tf.selectable = false;
			tf.multiline = true;
			tf.antiAliasType = AntiAliasType.ADVANCED;
			
			tf.htmlText = text;
			
			
			
			
			//Додаємо обводку
			var gradientGlow: GradientGlowFilter = new GradientGlowFilter(); 
			gradientGlow.distance = 0; 
			gradientGlow.angle = 45; 
			gradientGlow.colors = [0x000000, 0x000000];
			gradientGlow.alphas = [0, 1]; 
			gradientGlow.ratios = [0, 255]; 
			gradientGlow.blurX = 2; 
			gradientGlow.blurY = 2; 
			gradientGlow.strength = 3;
			gradientGlow.quality = BitmapFilterQuality.HIGH;
			gradientGlow.type = BitmapFilterType.OUTER;
			
			
			
			//Додаємо розмиття для даного тексту
			var myBlurFilter:BlurFilter = new BlurFilter(1, 1, 2);
			var myArrayFilters:Array = new Array(myBlurFilter, gradientGlow);
			
			tf.filters = myArrayFilters;
			
			//this.filters = myArrayFilters;
			
			
			tf.x = - tf.textWidth / 2;
			tf.y = - tf.textHeight / 2;
			
			tf.width = tf.textWidth + 5;
			tf.height = tf.textHeight + 5;
			
			this.addChild(tf);
			
			this.graphics.lineStyle(1, 0x1A171B);
			this.graphics.beginFill(0xffffff,0.8);
			this.graphics.drawRoundRect(tf.x - 5, tf.y - 3, tf.textWidth + 13, tf.textHeight + 9, 15);
			
			
		}
		
		
		
		
		
		
		
		private function setTextFormat():void 
		{
			format = new TextFormat();
            format.font = "Arial";
            format.color = 0x0480AA;
            format.size = 32;
			format.align = "center";
			format.bold = true;
			
			textMenu.defaultTextFormat = format;
			textMenu.antiAliasType = "advanced";
			textMenu.selectable = false;
			textMenu.multiline = true;
			
			this.addChild(textMenu);
			
		}
		
		private function setText():void 
		{
			
			
			textMenu.x = - textMenu.textWidth / 2;
			textMenu.y = - textMenu.textHeight / 2;
			
			textMenu.width = textMenu.textWidth + 5;
			textMenu.height = textMenu.textHeight + 5;
			
			
		}
		
		private function setBlur():void 
		{
			
			var myBlurFilter:BlurFilter = new BlurFilter(1, 1, 2);
			var myArrayFilters:Array = new Array(myBlurFilter);
			textMenu.filters = myArrayFilters;
			
			
			
			
		}
		
	}

}