package
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.setTimeout;
	
	/**
	 * ...
	 * @author Stesel
	 */
	public class Game extends Sprite
	{
		
		[Embed(source="../lib/macthSound.mp3")]
		static private const matchSound:Class;
		static public const ONE_PLAYER:int = 1;
		static public const TWO_PLAYERS:int = 2;
		
		static public var gameMode:int = 1;
		
		private var soundMatch: Sound;
		private var soundMatchChannel:SoundChannel;
		
		
		private var correctRect:Shape
		
		private var gameZoneColor:uint;
		private var currentColor:uint;
		
		private var gameZoneBkg:GameZone_design;
		
		private var gameZone:Sprite;
		private var bk:Sprite;
		
		private var matchZone:Sprite;
		
		//private var lineShadow:DropShadowFilter;
		
		private var lineStep1:int = 0;
		private var lineStep2:int = 0;
		private var lineStep3:int = 0;
		private var lineStep4:int = 0;
		//private var bkBit:Class;
		
		private var signZone1:SignZone;
		private var signZone5:SignZone;
		private var signZone3:SignZone;
		private var signZone4:SignZone;
		private var signZone6:SignZone;
		private var signZone7:SignZone;
		private var signZone8:SignZone;
		private var signZone9:SignZone;
		private var signZone2:SignZone;
		private var matchShadow:DropShadowFilter;
		private var table:Table;
		private var numOfXs:int = 0;
		private var numOf0s:int = 0;
		private var isYouFirst:int;
		static public var compAvalible:Boolean = false;
		//private var bkBit:DisplayObject;
		
		//public var bitData1:BitmapData;
		//public var bitMap1:Bitmap;
		
		//public var bitDataVect:Array = new Array();
		//public var bitMapVect:Array = new Array();
		
		static public var game:Sprite;
		
		static public var flagRestart:Boolean;
		
		//static public var signZoneArr:Vector.<SignZone> = new Vector.<SignZone>();
		
		static public var previousSign:String = " ";
		
		public function Game()
		{
			Game.game = this;
			
			init();
		}
		
		private function init():void
		
		{
			isYouFirst = Math.round(Math.random());
			
			soundMatch = (new matchSound) as Sound;
			
			currentColor = 0x324365;
			gameZoneColor = 0x0480AA;
			
			//bkBit = new BkGr();
			//addChild(bkBit);
			
			correctRect = new Shape();
			correctRect.graphics.beginFill(0x000000, 0);
			correctRect.graphics.drawRect(0, 0, 762, 480);
			addChild(correctRect);
			
			//this.height =  Main.screenY;
			//this.width = Main.screenX * Main.screenY / 480;
			//this.x = (Main.screenX - this.width) / 2;
			
			//bitDataVect = [3];
			//bitMapVect = [3];
			//for (var i:int=0; i < 3; i++)
			//{ 
			//bitDataVect[i] = [3];
			//bitMapVect[i] = [3];
			//for (var j:int = 0; j < 3; j++)
			//{
			//bitDataVect[i][j] = new BitmapData(160, 160, true, 0x00000000);
			//bitMapVect[i][j] = new Bitmap(bitDataVect[i][j]);
			//bitMapVect[i][j].width = bitMapVect[i][j].height = 16;
			//bitMapVect[i][j].x = 16 * i;
			//bitMapVect[i][j].y = 16 * j;
			//addChild(bitMapVect[i][j]);
			//
			//}
			//} 
			
			gameZoneBkg = new GameZone_design();
			gameZoneBkg.alpha = 0.7;
			gameZoneBkg.x = 143.5;
			gameZoneBkg.y = 2.5;
			gameZoneBkg.mouseChildren = false;
			gameZoneBkg.mouseEnabled = false;
			addChild(gameZoneBkg);
			
			
			
			
			table = new Table("Xs", "0s");
			table.x = gameZoneBkg.x + gameZoneBkg.width - 24  + table.width;
			table.y = gameZoneBkg.y - table.height + 3;
			addChild(table);
			
			var xs:Number = 145;
			var ys:Number = 4;
			
			signZone1 = new SignZone();
			signZone1.name = "signZone1";
			signZone1.x = xs;
			signZone1.y = ys;
			addChild(signZone1);
			
			signZone2 = new SignZone();
			signZone2.name = "signZone2";
			signZone2.x = xs + signZone2.width;
			signZone2.y = ys;
			addChild(signZone2);
			
			signZone3 = new SignZone();
			signZone3.name = "signZone3";
			signZone3.x = xs + 2 * signZone3.width;
			signZone3.y = 4;
			addChild(signZone3);
			
			signZone4 = new SignZone();
			signZone4.name = "signZone4";
			signZone4.x = xs;
			signZone4.y = ys + signZone4.height;
			addChild(signZone4);
			
			signZone5 = new SignZone();
			signZone5.name = "signZone5";
			signZone5.x = xs + signZone5.width;
			signZone5.y = ys + signZone5.height;
			addChild(signZone5);
			
			signZone6 = new SignZone();
			signZone6.name = "signZone6";
			signZone6.x = xs + 2 * signZone6.width;
			signZone6.y = ys + signZone6.height;
			addChild(signZone6);
			
			signZone7 = new SignZone();
			signZone7.name = "signZone7";
			signZone7.x = xs;
			signZone7.y = ys + 2 * signZone7.height;
			addChild(signZone7);
			
			signZone8 = new SignZone();
			signZone8.name = "signZone8";
			signZone8.x = xs + signZone8.width;
			signZone8.y = ys + 2 * signZone8.height;
			addChild(signZone8);
			
			signZone9 = new SignZone();
			signZone9.name = "signZone9";
			signZone9.x = xs + 2 * signZone9.width;
			signZone9.y = ys + 2 * signZone9.height;
			addChild(signZone9);
			
			
			
			bk = new Sprite();
			bk.mouseChildren = false;
			bk.mouseEnabled = false;
			addChild(bk);
			
			matchZone = new Sprite();
			matchZone.mouseChildren = false;
			matchZone.mouseEnabled = false;
			//matchZone.graphics.lineStyle(14, 0x0C19AA);
			
			matchShadow = new DropShadowFilter();
			matchShadow.distance = 5;
			matchShadow.angle = 25;
			matchZone.filters = [matchShadow];
			
			addChild(matchZone);
			//trace(this.getChildIndex(gameZone));
			
			//setShadows();
			
			//addEventListener(MouseEvent.MOUSE_DOWN, gameZone_mouseDown);
			create4Lines();
		
		}
		
		public function setSignIndex(s:Sprite):void
		{
			//if(s is signZone8)
			setChildIndex(s, 10);
			//addChildAt(gameZone, numChildren);
			//trace(this.getChildIndex(gameZone));
			//trace(this.getChildIndex(s));
		
		}
		
		//private function setShadows():void 
		//{
		//lineShadow = new DropShadowFilter(); 
		//lineShadow.distance = 5; 
		//lineShadow.angle = 25; 
		//gameZone.filters = [lineShadow];
		//}
		
		public function create4Lines():void
		{
			flagRestart = true;
			
			Game.previousSign = " ";
			
			matchZone.graphics.clear();
			matchZone.graphics.lineStyle(15, 0x067A82);
			
			bk.graphics.clear();
			clearSignZone();
			
			if (isYouFirst == 0 && Game.gameMode == Game.ONE_PLAYER)
				blockSignZoneExclusion();
			//if(this.contains(matchZone))
			//removeChild(matchZone);
			
			//for (var i:int=0; i < 3; i++)
			//{ 
			//bitDataVect[i] = [3];
			//bitMapVect[i] = [3];
			//for (var j:int = 0; j < 3; j++)
			//{
			//bitDataVect[i][j].fillRect(bitDataVect[i][j].rect, 0);
			//
			//}
			//} 
			
			bk.graphics.lineStyle(10, currentColor);
			
			addEventListener(Event.ENTER_FRAME, this_enterFrame);
		
			//trace("addEventListener ENTER_FRAME");
		
		}
		
		private function clearSignZone():void
		{
			signZone1.clearLineZone();
			signZone2.clearLineZone();
			signZone3.clearLineZone();
			signZone4.clearLineZone();
			signZone5.clearLineZone();
			signZone6.clearLineZone();
			signZone7.clearLineZone();
			signZone8.clearLineZone();
			signZone9.clearLineZone();
		}
		
		private function blockSignZone():void
		{
			
			signZone1.matchedFlaf = true;
			signZone2.matchedFlaf = true;
			signZone3.matchedFlaf = true;
			signZone4.matchedFlaf = true;
			signZone5.matchedFlaf = true;
			signZone6.matchedFlaf = true;
			signZone7.matchedFlaf = true;
			signZone8.matchedFlaf = true;
			signZone9.matchedFlaf = true;
		}
		
		
		
		public function blockSignZoneExclusion(sp:Sprite = null):void
		{
			for (var i:int = 0; i < numChildren; i++)
			{
				//trace(this.getChildAt(i).name);
				if (this.getChildAt(i).name.substr(0, 8) == "signZone")
				{
					if (this.getChildAt(i) != sp)
					{
						try 
						{ 
							this.getChildAt(i).compareFlaf = true; 
						} 
						catch (error:ArgumentError) 
						{ 
							//trace(error.message); 
						}
						
					}
					
				}
			}
		}
		
		public function enableSignZone():void
		{
			for (var i:int = 0; i < numChildren; i++)
			{
				if (this.getChildAt(i).name.substr(0, 8) == "signZone")
				{
					if (this.getChildAt(i).sign == " ")
					{
						try 
						{ 
							this.getChildAt(i).compareFlaf = false; 
						} 
						catch (error:ArgumentError) 
						{ 
							//trace(error.message); 
						}
						
					}
					
				}
			}
		}
		
		
		private function this_enterFrame(e:Event):void
		{
			if (lineStep1 < 460)
			{
				
				//bk.graphics.lineTo( lineStep1,stage.stageWidth/3);
				
				bk.graphics.moveTo(151 + lineStep1, 160);
				lineStep1 += 46;
				bk.graphics.lineTo(151 + lineStep1, 160);
				//bk.graphics.moveTo(lineStep1, stage.stageWidth/3);
				
				return;
			}
			
			//bk.graphics.lineStyle(8, currentColor);
			
			if (lineStep2 < 460)
			{
				//trace("lineStep2");		
				
				//bk.graphics.lineTo( lineStep1,stage.stageWidth/3);
				
				bk.graphics.moveTo(151 + lineStep2, 320);
				lineStep2 += 46;
				bk.graphics.lineTo(151 + lineStep2, 320);
				//bk.graphics.moveTo(lineStep1, stage.stageWidth/3);
				
				return;
			}
			
			if (lineStep3 < 460)
			{
				//trace("lineStep2");		
				
				//bk.graphics.lineTo( lineStep1,stage.stageWidth/3);
				
				bk.graphics.moveTo(301, 10 + lineStep3);
				lineStep3 += 46;
				bk.graphics.lineTo(301, 10 + lineStep3);
				//bk.graphics.moveTo(lineStep1, stage.stageWidth/3);
				
				return;
			}
			
			if (lineStep4 < 460)
			{
				//trace("lineStep2");		
				
				//bk.graphics.lineTo( lineStep1,stage.stageWidth/3);
				
				bk.graphics.moveTo(461, 10 + lineStep4);
				lineStep4 += 46;
				bk.graphics.lineTo(461, 10 + lineStep4);
				//bk.graphics.moveTo(lineStep1, stage.stageWidth/3);
				
				return;
			}
			
			removeEventListener(Event.ENTER_FRAME, this_enterFrame);
			//trace("removeEventListenerstage ENTER_FRAME");
			
			lineStep1 = lineStep2 = lineStep3 = lineStep4 = 0;
			
			flagRestart = false;
			if (isYouFirst == 0 && Game.gameMode == Game.ONE_PLAYER)
				computerTurn();
		}
		
		private function gameZone_mouseDown(e:MouseEvent):void
		{
			//TweenMax.to(sphere, 0.3, { alpha: 0.7, scaleX: 0.9, scaleY: 0.9 } );
			
			if (gameZoneBkg.hitTestPoint(mouseX, mouseY))
			{
				//
				//trace("gameZone_mouseDown");
				addEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMove);
				addEventListener(MouseEvent.MOUSE_UP, stage_mouseUp);
					//x0 = sphere.x;
					//y0 = sphere.y;
					//gameZone.graphics.clear();
				
					//gameZone.graphics.lineStyle(12, gameZoneColor);
					//gameZone.graphics.moveTo(e.localX, e.localY);
			}
			else
			{
				stage_mouseUp(null);
			}
		
			//menu =  new Menu();
			//addChild(menu);
		
		}
		
		private function stage_mouseMove(e:MouseEvent):void
		{
			//trace("gameZone_mouseDown");
			if (gameZoneBkg.hitTestPoint(mouseX, mouseY))
			{
				
				gameZone.graphics.lineTo(e.localX, e.localY);
				gameZone.graphics.moveTo(e.localX, e.localY);
				
				//drawBitData();
				e.updateAfterEvent();
				
			}
			else
				removeEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMove);
		
		}
		
		private function stage_mouseUp(e:MouseEvent):void
		{
			removeEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMove);
			removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUp);
		
			//removeChild(menu);
		}
		
		public function checkMatch():void
		{
			if ((signZone1.sign == "X" && signZone2.sign == "X" && signZone3.sign == "X") || (signZone1.sign == "0" && signZone2.sign == "0" && signZone3.sign == "0"))
			{
				signZone1.inMatch();
				signZone2.inMatch();
				signZone3.inMatch();
				
				createMatchLine(signZone1.x, signZone1.y + signZone1.height / 2, signZone3.x + signZone3.width, signZone3.y + signZone1.height / 2);
				
				blockSignZone();
				return;
			}
			
			if ((signZone4.sign == "X" && signZone5.sign == "X" && signZone6.sign == "X") || (signZone4.sign == "0" && signZone5.sign == "0" && signZone6.sign == "0"))
			{
				signZone4.inMatch();
				signZone5.inMatch();
				signZone6.inMatch();
				
				createMatchLine(signZone4.x, signZone4.y + signZone4.height / 2, signZone6.x + signZone6.width, signZone6.y + signZone6.height / 2);
				
				blockSignZone();
				return;
			}
			
			if ((signZone7.sign == "X" && signZone8.sign == "X" && signZone9.sign == "X") || (signZone7.sign == "0" && signZone8.sign == "0" && signZone9.sign == "0"))
			{
				signZone7.inMatch();
				signZone8.inMatch();
				signZone9.inMatch();
				
				createMatchLine(signZone7.x, signZone7.y + signZone7.height / 2, signZone9.x + signZone9.width, signZone9.y + signZone9.height / 2);
				
				blockSignZone();
				return;
			}
			
			if ((signZone1.sign == "X" && signZone4.sign == "X" && signZone7.sign == "X") || (signZone1.sign == "0" && signZone4.sign == "0" && signZone7.sign == "0"))
			{
				signZone1.inMatch();
				signZone4.inMatch();
				signZone7.inMatch();
				
				createMatchLine(signZone1.x + signZone1.width / 2, signZone1.y, signZone7.x + signZone7.width / 2, signZone7.y + signZone7.height);
				
				blockSignZone();
				return;
			}
			
			if ((signZone2.sign == "X" && signZone5.sign == "X" && signZone8.sign == "X") || (signZone2.sign == "0" && signZone5.sign == "0" && signZone8.sign == "0"))
			{
				signZone2.inMatch();
				signZone5.inMatch();
				signZone8.inMatch();
				
				createMatchLine(signZone2.x + signZone2.width / 2, signZone2.y, signZone8.x + signZone8.width / 2, signZone8.y + signZone8.height);
				
				blockSignZone();
				return;
			}
			
			if ((signZone3.sign == "X" && signZone6.sign == "X" && signZone9.sign == "X") || (signZone3.sign == "0" && signZone6.sign == "0" && signZone9.sign == "0"))
			{
				signZone3.inMatch();
				signZone6.inMatch();
				signZone9.inMatch();
				
				createMatchLine(signZone3.x + signZone3.width / 2, signZone3.y, signZone9.x + signZone9.width / 2, signZone9.y + signZone9.height);
				
				blockSignZone();
				return;
			}
			
			if ((signZone1.sign == "X" && signZone5.sign == "X" && signZone9.sign == "X") || (signZone1.sign == "0" && signZone5.sign == "0" && signZone9.sign == "0"))
			{
				signZone1.inMatch();
				signZone5.inMatch();
				signZone9.inMatch();
				
				createMatchLine(signZone1.x, signZone1.y, signZone9.x + signZone9.width, signZone9.y + signZone9.height);
				
				blockSignZone();
				return;
			}
			
			if ((signZone3.sign == "X" && signZone5.sign == "X" && signZone7.sign == "X") || (signZone3.sign == "0" && signZone5.sign == "0" && signZone7.sign == "0"))
			{
				signZone3.inMatch();
				signZone5.inMatch();
				signZone7.inMatch();
				
				createMatchLine(signZone3.x + signZone3.width, signZone3.y, signZone7.x, signZone9.y + signZone7.height);
				
				blockSignZone();
				return;
			}
			if (signZone1.sign != " " && signZone2.sign != " " && signZone3.sign != " " && 
			signZone4.sign != " " && signZone5.sign != " " && signZone6.sign != " " && 
			signZone7.sign != " " && signZone8.sign != " " && signZone9.sign != " ")
			{
				showDrawMassege();
				return;
			}
			
			if (Game.gameMode == 1 && Game.compAvalible)
				computerTurn();
		}
		
		private function showDrawMassege():void 
		{
			Main.message = new Messages( "Draw!");
			Main.view.addChild(Main.message);
			setTimeout(newRestart, 2000);
		}
		
		private function createMatchLine(x1:Number, y1:Number, x2:Number, y2:Number):void
		{
			//trace(x1);
			soundMatchChannel = soundMatch.play(0, 0);
			
			matchZone.graphics.moveTo(x1, y1);
			//lineStep3 +=46;
			matchZone.graphics.lineTo(x2, y2);
		
			//matchZone.graphics.moveTo(x1, y1);
		
			//matchZone.graphics.lineTo(x2, y2);
			if (Game.previousSign == "X")
				numOfXs++;
			if (Game.previousSign == "0")
				numOf0s++;
			
			setTimeout(showWinnerMassege, 2000);
			
			
		}
		
		private function setTable():void 
		{
			table.setValues(numOfXs, numOf0s);
		}
		
		private function showWinnerMassege():void 
		{
			setTable();
			
			Main.message = new Messages(Game.previousSign + "s Win!");
			Main.view.addChild(Main.message);
			setTimeout(newRestart, 2000);
		}
		
		private function newRestart():void 
		{
			if(!Game.flagRestart)
			Game.game.create4Lines();
		}
		
		private function computerTurn():void 
		{
			Game.compAvalible = false;
			blockSignZoneExclusion();
			var itemMass:Vector.<SignZone> = new Vector.<SignZone>();
			for (var i:int = 0; i < numChildren; i++)
			{
				if (this.getChildAt(i).name.substr(0, 8) == "signZone")
				if (this.getChildAt(i).sign == " ")
				{
					itemMass.push(this.getChildAt(i));
				}
			}
			var sel:int = Math.round(Math.random() * itemMass.length) - 1;
			if (sel == -1)
				sel = 0;
				
			if (previousSign == "X")
				itemMass[sel].drawNaught();
			else
				itemMass[sel].drawCross();
			setTimeout(enableSignZone ,1000)
		}
		//public function drawBitData(): void
		//{
		//
		//for (var i:int=0; i < 3; i++)
		//{ 
		//
		//
		//for (var j:int = 0; j < 3; j++)
		//{
		//bitDataVect[i][j].draw(gameZone, new Matrix(1,0,0,1, -151 - 160 * i, -10 - 160*j));
		//trace(i + j);
		//}
		//
		//
		//}
		//
		//}
	
	}

}