package  {
	import flash.display.Sprite;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BitmapFilterType;
	import flash.filters.DropShadowFilter;
	import flash.filters.GradientGlowFilter;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Stesel
	 */
	public class Table extends Sprite {
		private var formatT:TextFormat;
		private var formatV:TextFormat;
		
		private var t1:TextField;
		private var t2:TextField;
		
		
		private var lineShadow:DropShadowFilter;
		private var gradientGlow:GradientGlowFilter;
		
		
		
		public function Table(name1: String = "1", name2: String = "2") 
		{
			formatT = new TextFormat();
            formatT.font = "Times New Roman";
            formatT.color = 0xe4f7ff;
            formatT.size = 30;
			formatT.align = "left";
			formatT.bold = true;
			
			formatV = new TextFormat();
            formatV.font = "Times New Roman";
            formatV.color = 0xffffff;
            formatV.size = 30;
			formatV.align = "left";
			formatV.bold = true;
			
			
			t1 = new TextField();
			t1.defaultTextFormat = formatT;
			t1.selectable = false;
			t1.multiline = true;
			t1.antiAliasType = AntiAliasType.ADVANCED;
			t1.text = name1 + " : " + "--";
			
			t2 = new TextField();
			t2.defaultTextFormat = formatT;
			t2.selectable = false;
			t2.multiline = true;
			t2.antiAliasType = AntiAliasType.ADVANCED;
			t2.text = name2 + " : " + "--";
			
			lineShadow = new DropShadowFilter(); 
			lineShadow.distance = 5; 
			lineShadow.angle = 25; 
			
			//Додаємо обводку
			gradientGlow = new GradientGlowFilter(); 
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
			
			
			t1.filters = [gradientGlow];
			t2.filters = [gradientGlow];
			
			t1.x = - t1.textWidth / 2;
			t1.y = - t1.textHeight /  2 + 100;
			
			t2.x = - t2.textWidth / 2;
			t2.y =  t2.textHeight /  2 + 100;
			
			t1.width = t1.textWidth + 5;
			t1.height = t1.textHeight + 5;
			
			t2.width = t2.textWidth + 5;
			t2.height = t2.textHeight + 5;
			
			this.addChild(t1);
			this.addChild(t2);
			
			this.graphics.lineStyle(2, 0x0480AA);
			this.graphics.beginFill(0xffffff,0.8);
			this.graphics.drawRect(t1.x - 5, t1.y - 3,  t2.textWidth + 20, 2 * t2.textHeight + 9);
			
			//setValues(1, 2);
		}
		
		public function setValues(v1:int = 0, v2:int = 0):void
		{
			t1.htmlText = t1.text.slice(0, 5) + String(v1);
			t2.htmlText = t2.text.slice(0, 5) + String(v2);;
			//trace(t1.htmlText.slice(0, 5));
			//trace(t2.htmlText.slice(0, 5));
			this.graphics.clear();
			this.graphics.lineStyle(2, 0x0480AA);
			this.graphics.beginFill(0xffffff,0.8);
			this.graphics.drawRect(t1.x - 5, t1.y - 3,  t2.textWidth + 20, 2*t2.textHeight + 9);
		}
		
	}

}