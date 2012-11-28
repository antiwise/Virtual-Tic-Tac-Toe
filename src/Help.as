package  
{
	
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BitmapFilterType;
	import flash.filters.BlurFilter;
	import flash.filters.GradientGlowFilter;
	import flash.html.HTMLLoader;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Stesel
	 */
	public class Help extends Sprite 
	{
		//private var headText:TextField = new TextField(); 
		private var myTextBox:TextField = new TextField(); 
        private var myText:String = "<p>				HELP			                    	<p/><p>The Game <i>Tic Tac Toe</i>, also called noughts and crosses - logic game played between two opponents on a square field of 3 by 3 cells.<p/><br>			                                                                            					     <p><i>Rules</i><p/><br><p>								X always goes first. Players alternate placing Xs and Os on the board until either (a) one player has three in a row, horizontally, vertically or diagonally; or (b) all nine squares are filled. If a player is able to draw three Xs or three Os in a row, that player wins. If all nine squares are filled and neither player has three in a row, the game is a draw.<p/>"; 
		private var format:TextFormat = new TextFormat();;
		private var content:HTMLLoader;
		
		
		public function Help() 
		{
			
			format.font = "Times New Roman"; 
            format.color = 0xffffff; 
            format.size = int(Main.screenY / 21); 
            format.bold = true; 
			
            myTextBox.defaultTextFormat = format; 
			
			//var myTextBox:TextField = new TextField();
			//myTextBox.text = myText; 
			myTextBox.htmlText = myText; 
			myTextBox.textColor = 0xffffff; 
			
            myTextBox.width = 600; 
            myTextBox.height = 300; 
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
			
			
			
			//Додаємо розмиття для даного тексту
			var myBlurFilter:BlurFilter = new BlurFilter(1, 1, 2);
			var myArrayFilters:Array = new Array(myBlurFilter, gradientGlow);
			
			
			myTextBox.filters = myArrayFilters;
			
			
            
			
			//myTextBox.x = (Main.screenX - myTextBox.width) / 2;
			//myTextBox.y = (Main.screenY - myTextBox.height) / 2 - 10;
			myTextBox.alpha = 0;
            addChild(myTextBox); 
			TweenLite.to(myTextBox, 0.7, { alpha: 1 } );
			
			
            //myTextBox.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownScroll); 
			
			
			
			
			
		}
		
		public function mouseDownScroll(event:MouseEvent):void 
        { 
            myTextBox.scrollV++; 
        } 
		
		
		
	}

}