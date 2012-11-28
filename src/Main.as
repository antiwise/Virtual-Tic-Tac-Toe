package 
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BitmapFilterType;
	import flash.filters.BlurFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.GradientGlowFilter;
	import flash.system.Capabilities;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.ui.ContextMenu;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	/**
	 * ...
	 * @author Stesel
	 */
	public class Main extends Sprite 
	{
		
		[Embed(source = "../lib/stesel23.png")]	static private const StPng:Class;
		
		[Embed(source = "../lib/TicTacToe.png")]	static private const TicPng:Class;
		
		[Embed(source = "../lib/backGr.png")] 	static private const BkGr:Class;
		
			
		private var y0:Number;
		private var x0:Number;
			
		static private var pauseButton: PauseButton; 
			
		private var rbIntervall:uint;
		private var bkBit:Bitmap;
		private var bkPic:Sprite;
			
		static public var view:Sprite;
			
			
		static public var screenX: int;
		static public var screenY: int;
			
			
		static private var menu:Menu;
		static private var game:Game;
		static private var help:Help;
		static public var message:Messages;
		
		static private var blur:BlurFilter;
		private var uInterval:uint;
		
		
		//private var steselScreen: DisplayObject;
		//private var ticScreen: DisplayObject;
		
		static private var bkGame: DisplayObject;
		
		private var fps:FPSText;
		
		private var tapText:TextField = new TextField();
		private var verText:TextField = new TextField();
		private var textFormat:TextFormat = new TextFormat();
		private var gradientGlow:GradientGlowFilter = new GradientGlowFilter();
		private var verString: String = "Ver. 1";
		
		
		
		
	
		//private var dataXML:XML;
		//private var xmlList:XMLList;
		//private var buttomName:String;
		
		public function Main():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.CLOSE, windowCloseHandler);
			
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			
			// entry point
			if (!stage)
				addEventListener(Event.ADDED_TO_STAGE, init);
			else
				init();
		}
		
		private function init():void 
		{
			Main.screenX = stage.stageWidth;
			Main.screenY = stage.stageHeight;
			//Main.screenY = stage.stageWidth;
			//Main.screenX = stage.stageHeight;
			//trace("st x " + stage.stageHeight)
			
			
			
			Main.view = new Sprite();
			
			addChild(Main.view);
			initFPS();
			//StatisticFrame.init(stage, this);
			
			 removeEventListener(Event.ADDED_TO_STAGE, init);
			 
			 stage.addEventListener(KeyboardEvent.KEY_UP, fl_OptionsMenuHandler, false, 0, true);
			  
			 NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
			
			Main.bkGame = new StPng();
			Main.bkGame.width = Main.screenX;
			Main.bkGame.height = Main.screenY;
			Main.view.addChild(bkGame);
			
			uInterval = setTimeout(init2, 3000);
			
			
			
			onStageResize();
			
			
			pauseButton = new PauseButton();
			pauseButton.x = 2;
			pauseButton.y = 2;
			//Main.view.addChild(pauseButton);
			blur = new BlurFilter(); 
			blur.blurX = 6; 
			blur.blurY = 6; 
			blur.quality = BitmapFilterQuality.LOW; 
		}
		
		private function initFPS():void 
		{
			fps = new FPSText();
			fps.enable();
			fps.x = Main.screenX - 60; 
			fps.y = 2; 
			this.addChild(fps);
		}
		
		private function init2():void 
		{
			
			TweenLite.to(bkGame, 1, { alpha: 0 } );
			uInterval = setTimeout(init3, 1000);
		}
		
		private function init3():void 
		{
			Main.view.removeChild(bkGame);
			Main.bkGame = null;
			Main.bkGame = new TicPng();
			Main.bkGame.width = Main.screenX;
			Main.bkGame.height = Main.screenY;
			Main.view.addChild(Main.bkGame);
			
			stage.addEventListener(MouseEvent.CLICK, stage_click);
			
			textFormat.font = "Times New Roman"; 
            textFormat.color = 0xffffff; 
            textFormat.size = 30; 
            textFormat.bold = true;
			
			tapText.defaultTextFormat = textFormat;
			tapText.text = "TAP ANYWHERE";
			tapText.selectable = false;
			tapText.mouseEnabled = false;
			tapText.autoSize = TextFieldAutoSize.LEFT;
			tapText.antiAliasType = "advanced";
			tapText.x = (Main.screenX - tapText.width) / 2;
			tapText.y = Main.screenY - 2 * tapText.height;
			
			gradientGlow.distance = 1; 
			gradientGlow.angle = 45; 
			gradientGlow.colors = [0x000000, 0x000000];
			gradientGlow.alphas = [0, 1]; 
			gradientGlow.ratios = [0, 255]; 
			gradientGlow.blurX = 2; 
			gradientGlow.blurY = 2; 
			gradientGlow.strength = 10;
			gradientGlow.quality = BitmapFilterQuality.HIGH;
			gradientGlow.type = BitmapFilterType.OUTER;
			
			tapText.filters = [gradientGlow];
			Main.view.addChild(tapText);
			
			
			
			textFormat.size = 18; 
			verText.defaultTextFormat = textFormat;
			verText.text = verString;
			verText.selectable = false;
			verText.mouseEnabled = false;
			verText.autoSize = TextFieldAutoSize.LEFT;
			verText.antiAliasType = "advanced";
			verText.x = 1;
			verText.y = Main.screenY - verText.height;
			
			Main.view.addChild(verText);
		}
		
		private function stage_click(e:MouseEvent):void 
		{
			stage.removeEventListener(MouseEvent.CLICK, stage_click);
			if(Main.view.contains(verText))
				Main.view.removeChild(verText);
			if(Main.view.contains(tapText))
				Main.view.removeChild(tapText);
			
			verText = null;
			tapText = null;
			
			
			Menu.newFlag = true;
			Menu.helpFlag = true;
			Menu.exitFlag = true;
			Menu.numOfBut = 1;
			
			createMenu();
		}
			
			
		private function onStageResize():void 
		{
			//trace("resize");
			//resize view to stage size
			//view.width = stage.stageWidth;
			//view.width = Main.screenX;
			//view.width = Main.screenY;
			//view.height = Main.screenX;
			//view.height = Main.screenY;
			//view.height = stage.stageHeight;
		}
		private function fl_OptionsMenuHandler(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.BACK)
			{
				NativeApplication.nativeApplication.exit(0);
			}
			
			if (e.keyCode == Keyboard.MENU)
			{
				if(Main.view.contains(Main.pauseButton) && !Main.view.contains(Main.message))
				pauseButton.offGlow();
			}
		}
		
		
			
		private function s_mouseMove(e:MouseEvent):void 
		{
			trace("x: " + e.stageX + "  y: " + e.stageY);
		}
		
		
		
		private function deactivate(e:Event):void 
		{
			// auto-close
			NativeApplication.nativeApplication.exit();
		}
		
		private function windowCloseHandler(e:Event):void 
		{
			NativeApplication.nativeApplication.exit();
		}
		
		
		static public function removeMenu():void 
		{
			view.removeChild(menu);
			menu = null;
			
			if (Main.game != null)
			Main.game.filters = null;
			
			if (pauseButton != null)
				pauseButton.activate();
		}
		
		static public function createMenu():void 
		{
			if (Main.game != null)
			Main.game.filters = [blur];
			
			Main.menu =  new Menu();
			//Main.menu.width = Main.screenX;
			Main.menu.height = Main.screenY;
			Main.view.addChild(menu);
			
			if (pauseButton != null)
				pauseButton.deactivate();
		}
		
		
		static public function createGame():void
		{
			Main.view.removeChild(bkGame);
			Main.bkGame = new BkGr();
			Main.bkGame.width = Main.screenX;
			Main.bkGame.height = Main.screenY;
			Main.view.addChild(Main.bkGame);
			
			Main.game = new Game();
			Main.game.width = (Main.screenY / Main.screenX) / 0.63 * Main.screenX;
			Main.game.height = Main.screenY;
			Main.game.x = (Main.screenX - Main.game.width) / 2;
			
			Main.view.addChild(game);
			Main.view.addChild(Main.pauseButton);
			
			if (pauseButton != null)
				pauseButton.activate();
		}
		
		static public function createHelp():void
		{
			Main.help = new Help();
			//Main.help.width = Main.screenX / 2;
			//Main.help.height = Main.screenY / 2;
			Main.help.x = (Main.screenX - Main.help.width) / 2;
			Main.help.y = + 40;
			Main.view.addChild(help);
		}
		
		static public function removeHelp():void
		{
			if (Main.help != null)
			{
				Main.view.removeChild(help);
				Main.help = null;
			}	
			
			if (Main.game != null)
			{
				Menu.numOfBut = 0;
				//trace("0");
			}	
		}
		
	}
	
}