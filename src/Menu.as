package  


{
	import com.greensock.easing.Back;
	import com.greensock.TweenLite;
	import flash.desktop.NativeApplication;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BitmapFilterType;
	import flash.filters.BlurFilter;
	import flash.filters.GradientGlowFilter;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Stesel
	 */
	public class Menu extends Sprite 
	{
		
		
		static public var numOfBut:Number;
		static public var bgMenuA:Number = 0.2;
		
		
		static public var menu: Sprite;
		
		
		
		static public var btnSTART: Sprite;
		static public var btnEXIT: Sprite;
		static public var btnHELP: Sprite;
		static public var btnRESUME: Sprite;
		static public var btnRESTART: Sprite;
		
		
		static public var btn1PLAYER: Sprite;
		static public var btn2PLAYERS: Sprite;
		
		
		
		
		
		
		
		static public var newFlag:Boolean;
		static public var exitFlag:Boolean;
		static public var helpFlag:Boolean;
		static public var resumeFlag:Boolean;
		static public var restartFlag:Boolean;
		
		
		
		
		
		public function Menu() 
		{
			init();
		}
		
		
		
		private function init():void
		{
			
			Menu.menu = this;
			//
			//
			//
					
			
			
			
			//bkgr
			var bkgr: Shape = new Shape();
			bkgr.graphics.beginFill(0x000000, bgMenuA);
			bkgr.graphics.drawRect(0, 0, Main.screenX, Main.screenY);
			addChild(bkgr);
			
			//Powered Text
			var formatBy:TextFormat = new TextFormat();
            //format.font = "Arial";
            formatBy.font = "Times New Roman";
            formatBy.color = 0xCFFFE8;
            formatBy.size = 20;
			formatBy.align = "center";
			formatBy.bold = true;
			
			var poweredBy: TextField = new TextField();
			
			
			poweredBy.defaultTextFormat = formatBy;
			poweredBy.antiAliasType = "advanced";
			poweredBy.selectable = false;
			poweredBy.multiline = true;
			poweredBy.mouseEnabled = false;
			poweredBy.autoSize = TextFieldAutoSize.LEFT;
			poweredBy.antiAliasType = AntiAliasType.ADVANCED;
			poweredBy.htmlText = "Powered By Stesel23";
			
			
			
			
			
			poweredBy.x = Main.screenX - poweredBy.width - 1;
			poweredBy.y = Main.screenY - poweredBy.height - 1;
			
			addChild(poweredBy);
			
			
			
			
			initMainMenu();
			
			
		}
		
		private function initMainMenu():void
		{
			
			
			//
			
			if (Menu.resumeFlag)
			{
				createButton("RESUME");
			}
			
			if (Menu.restartFlag)
			{
				createButton("RESTART");
			}
			if (Menu.newFlag)
			{
				createButton("NEW GAME");
			}
			if (Menu.helpFlag)
			{
				createButton("HELP");
			}
				
			if (Menu.exitFlag)
			{
				createButton("EXIT");
			}
			
		}
		
		private function createButton(st:String):void 
		{
			numOfBut++;
			
			var button: MenuButton = new MenuButton(st);
			button.scaleY = 0.001;
			button.x = - 150;
			button.y = Main.screenY; 
			addChild(button);
			TweenLite.to(button, 0.5, {x:Main.screenX / 2 - 2, y: 1.2 * numOfBut * 60 + 150, scaleY:1, ease:Back.easeOut});
		}
		
		
		public function pressedNEWGAME(): void
		{
			
			removeBtns();
			numOfBut = 1;
			createButton("1 PLAYER");
			createButton("2 PLAYERS");
			createButton("BACK");
			
		}
		
		
		public function pressedRESUME(): void
		{
			Main.removeMenu();
			//Main.view.filters = null;
		}
		
		public function pressedEXIT(): void
		{
			NativeApplication.nativeApplication.exit();
		}
		
		
		public function pressedHELP(): void
		{
			removeBtns();
			numOfBut = 3.8;
			createButton("BACK");
			Main.createHelp();
			
		}
		
		public function pressed1PLAYER(): void
		{
			Main.removeMenu();
			Main.view.filters = null;
			Game.gameMode = Game.ONE_PLAYER;
			Main.createGame();
		}
		
		public function pressed2PLAYERS(): void
		{
			Main.removeMenu();
			Main.view.filters = null;
			Game.gameMode = Game.TWO_PLAYERS;
			Main.createGame();
		}
		
		public function pressedBACK(): void
		{
			removeBtns();
			Menu.numOfBut = 1;
			Main.removeHelp();
			//Menu.numOfBut = 1;
			initMainMenu();
		}
		
		private function removeBtns():void
		{
			numOfBut = 0;
			while (this.numChildren > 2)
				this.removeChildAt(numChildren-1);
		}
		
		public function pressedRESTART():void
		{
			Main.removeMenu();
			if(!Game.flagRestart)
			Game.game.create4Lines();
			//trace("restart");
		}
		
	}

}