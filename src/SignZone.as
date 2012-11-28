package  
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BitmapFilterType;
	import flash.filters.DropShadowFilter;
	import flash.filters.GradientGlowFilter;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	/**
	 * ...
	 * @author Stesel
	 */
	public class SignZone extends Sprite 
	{
		
		
		//[Embed(source="../lib/drawSound.mp3")]
		//static private const drawSound:Class;
		
		//private var soundDraw: Sound;
		//private var soundDrawChannel:SoundChannel;
		
		
		
		private var zone:Sprite;
		private var lineZone:Sprite;
		private var lineShadow:DropShadowFilter;
		private var gameZoneColor:uint;
		private var gameZoneBkg:Shape;
		private var crossFilter:GradientGlowFilter;
		private var mdFilter:GradientGlowFilter;
		
		//private var _sign: String;
		public var compareFlaf:Boolean;
		public var matchedFlaf:Boolean;
		
		
		private var cX0: Number;
		private var cY0: Number;
		
		private var cX1: Number;
		private var cY1: Number;
		private var compArr: Vector.<Number> = new Vector.<Number>();
		
		private var dYX:Number;
		private var numOfN:int;
		private var numOfC:int;
		
		
		private var numOfM:int;
		private var numOfP:int;
		private var numOfNu:int;
		private var crossFilterFlaf:Boolean;
		private var interFilterrID:uint;
		
		private var crossStep1:int = 20;
		private var crossStep2:int = 20;
		private var naughtStep:int;
		private var naughtIntId:uint;
		
		public var sign:String = " ";
		
		public function SignZone() 
		{
			
			
			//Game.signZoneArr.push(this);
			
			//soundDraw = (new drawSound) as Sound;
			
			zone = new Sprite();
			
			gameZoneBkg = new Shape();
			gameZoneBkg.graphics.beginFill(0xffffff, 0.6);
			gameZoneBkg.graphics.drawRect(0, 0, 157.3, 157.3);
			addChild(gameZoneBkg);
			
			lineZone = new Sprite();
			addChild(lineZone);
			
			
			lineShadow = new DropShadowFilter(); 
			lineShadow.distance = 5; 
			lineShadow.angle = 25; 
			lineZone.filters = [lineShadow];
			
			gameZoneColor = 0x0480AA;
			
			createGrFilters();
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			//this.addEventListener(MouseEvent.MOUSE_WHEEL, drawNaught);
			
		}
		
		private function createGrFilters():void 
		{
			mdFilter = new GradientGlowFilter();
			mdFilter.distance = 0; 
			mdFilter.angle = 45; 
			mdFilter.colors = [0x000000, 0xB7FBFF];
			mdFilter.alphas = [0, 1]; 
			mdFilter.ratios = [0, 255]; 
			mdFilter.blurX = 3; 
			mdFilter.blurY = 3; 
			mdFilter.strength = 1;
			mdFilter.quality = BitmapFilterQuality.HIGH;
			mdFilter.type = BitmapFilterType.OUTER;
			
			
			crossFilter = new GradientGlowFilter();
			crossFilter.distance = 0; 
			crossFilter.angle = 45; 
			crossFilter.colors = [0x000000, 0x8BFF8B];
			crossFilter.alphas = [0, 1]; 
			crossFilter.ratios = [0, 255]; 
			crossFilter.blurX = 3; 
			crossFilter.blurY = 3; 
			crossFilter.strength = 2;
			crossFilter.quality = BitmapFilterQuality.HIGH;
			crossFilter.type = BitmapFilterType.OUTER;
		}
		
		private function mouseDown(e:MouseEvent):void 
		{
			//drawCross();
			
			
			
			if (!matchedFlaf)
			{
				Game.game.setSignIndex(this);
				
				cX0 = e.localX;
				cY0 = e.localY;
				
				e.stopPropagation();
				gameZoneBkg.filters = [mdFilter];
				if (!compareFlaf)
				{
					stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
					
				}
					stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
				
				lineZone.graphics.lineStyle(12, gameZoneColor);
				lineZone.graphics.moveTo(e.localX, e.localY);
			}	
		}
		
		private function mouseUp(e:MouseEvent):void 
		{
			resetFilters();
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			
			if (!compareFlaf)
			{
				countCompareArr();
			}
			
			
			//if (soundDrawChannel != 0)
			//{
				//try
				//{
					//soundDrawChannel.stop();
					//soundDrawChannel = null;
				//}
				//
			//}
		}
		
		private function countCompareArr():void 
		{
			//trace("l " + compArr.length);
			
			if (compArr.length < 3 || compArr.length > 300)
			{
				compArr = new Vector.<Number>();
				clearLineZone();
				return;
			}
			
			
			for (var i:int = 0; i < compArr.length; i++)
			{
							
				
				if (compArr[i] <=  - 0.05 )
				{
					numOfM ++;
				}
				if (compArr[i] >= 0.05 )
				{
					numOfP ++;
				}
				if (compArr[i] < 0.05 &&  compArr[i] > -0.05)
					numOfNu++;
				
				
				
				
			}
			
			
			if (Math.abs(numOfP - numOfM) >  (compArr.length/2) || (numOfNu > compArr.length/2))
			{
				if (sign == "X")
				{
					if (Game.previousSign != "X")
					{
						compareFlaf = true;
						//trace("SIGN " + sign);
						Game.previousSign = sign;
						Game.game.enableSignZone();
						if(Game.gameMode == Game.ONE_PLAYER)
							Game.compAvalible = true;
						Game.game.checkMatch();
						
					}
					
					else
					{
						Game.game.enableSignZone();
						createTurnMess();
						clearLineZone();
					}
				}
				else
				{
					sign = "X";
					Game.game.blockSignZoneExclusion(this);
				}
				
			}
			
			else
			{
				
				if (sign == "X")
				{
					Game.game.enableSignZone();
					clearLineZone();
				}
				else
				{
					if (Game.previousSign == " ")
					{
						createFirstMess();
						clearLineZone();
						
						
					}
					if(Game.previousSign == "0")
					{
						createTurnMess();
						clearLineZone();
					}
					if (Game.previousSign == "X")
					{
						compareFlaf = true;
						sign = "0";
						//trace("SIGN " + sign);
						Game.previousSign = sign;
						Game.game.enableSignZone();
						if(Game.gameMode == Game.ONE_PLAYER)
							Game.compAvalible = true;
						Game.game.checkMatch();
						
					}
					
					
				}
			}
				
				
				
				compArr = new Vector.<Number>();
				numOfM = 0;
				numOfP = 0;
				numOfNu = 0;
				
				
				
			
		}
		
		private function createFirstMess():void 
		{
			Main.message = new Messages("Xs go first!");
			Main.view.addChild(Main.message);
		}
		
		private function compareSign(e:MouseEvent):void 
		{
				
			cX1 = e.localX;
			cY1 = e.localY;
			
			dYX =  (cY1 - cY0)/ (cX1 - cX0);
			
			
			compArr.push(dYX);
		}
		
		
			
		private function mouseMove(e:MouseEvent):void 
		{
			
			if (gameZoneBkg.hitTestPoint(stage.mouseX, stage.mouseY))
			{
				
				lineZone.graphics.lineTo(e.localX, e.localY);
				lineZone.graphics.moveTo(e.localX, e.localY);
				
				
				e.updateAfterEvent();
				
				compareSign(e);
				
				
				
				//soundDrawChannel = soundDraw.play(0, 0);
				
			}
			else
			{
				mouseUp(null);
			}
			//
		}
		
		public function setCrossFilter(): void
		{
			gameZoneBkg.filters = [crossFilter];
		}
		
		public function resetFilters(): void
		{
			gameZoneBkg.filters = null;
		}
		
		//public function setSign(value:String):void 
		//{
			//sign = value;
		//}
		
		public function clearLineZone():void
		{
			resetFilters();
			lineZone.graphics.clear();
			compareFlaf = false;
			sign = " ";
			
			if(matchedFlaf)
			matchedFlaf = false;
			
			
			if(interFilterrID)
			clearInterval(interFilterrID);
			
		}
		
		private function createTurnMess():void
		{
			Main.message = new Messages("Not your turn!");
			Main.view.addChild(Main.message);
		}
		
		public function inMatch():void
		{
			matchedFlaf = true;
			//setCrossFilterInt();
			//interFilterrID = setInterval(setCrossFilterInt, 400);
			setCrossFilter();
		}
		
		private function setCrossFilterInt():void 
		{
			if (!crossFilterFlaf)
			{
				
				setCrossFilter();
				crossFilterFlaf = true;
			}
			else
			{
				
				resetFilters();
				crossFilterFlaf = false;
			}
		}
		
		public function drawCross():void
		{
				lineZone.graphics.lineStyle(12, gameZoneColor);
				//lineZone.graphics.moveTo(e.localX, e.localY);
				
				addEventListener(Event.ENTER_FRAME, crossEnterFrame);
		}
		//
		private function crossEnterFrame(e:Event):void 
		{
			if (crossStep1 <= 120)
			{
				lineZone.graphics.moveTo(crossStep1, crossStep1);
				crossStep1 += 20;
				lineZone.graphics.lineTo(crossStep1, crossStep1);
				
				return;
			}
			
			if (crossStep2 <= 120)
			{
				lineZone.graphics.moveTo(160 - crossStep2, crossStep2);
				crossStep2 += 20;
				lineZone.graphics.lineTo(160 - crossStep2, crossStep2);
				
				//trace()
				return;
			}
			
			removeEventListener(Event.ENTER_FRAME, crossEnterFrame);
			
			sign = "X";
			Game.previousSign = sign;
			compareFlaf = true;
			crossStep1 = crossStep2 = 20;
			
			Game.game.checkMatch();
		}
		
		public function drawNaught():void
		{
			//if (e.delta > 0)
			//{
				lineZone.graphics.lineStyle(12, gameZoneColor);
				naughtIntId = setInterval(naughtDo, 15);
			//}
			//if (e.delta < 0)
			//{
				//lineZone.graphics.lineStyle(12, ga7meZoneColor);
					//
				//addEventListener(Event.ENTER_FRAME, crossEnterFrame);
			//}
		}
		
		private function naughtDo():void 
		{
			if (naughtStep < 360)
			{
				lineZone.graphics.moveTo(-40*Math.cos((naughtStep)*Math.PI/180) + 78, -60*Math.sin((naughtStep)*Math.PI/180) + 78);
				naughtStep +=12;
				lineZone.graphics.lineTo( -40 * Math.cos((naughtStep) * Math.PI / 180) +78, -60 * Math.sin((naughtStep) * Math.PI / 180) + 78);
				
				return;
			}
			
			clearInterval(naughtIntId);
			sign = "0";
			Game.previousSign = sign;
			compareFlaf = true;
			naughtStep = 0;
			
			Game.game.checkMatch();
		}
		
	}

}