package  
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	
	public class MyPreloader extends MovieClip
	{
		public function MyPreloader()
		{
			trace("preloader")
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stop();
		}
		public var mainClassName:String = "MacFlash"
		private var _appWidth:int = 640;
		private var _appHeight:int = 480;
		private var _firstEnterFrame:Boolean;
		private var _preloaderBackground:Shape 
		private var _preloaderPercent:Shape;
		public function start():void {
			_firstEnterFrame=true;
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onAddedToStage(event:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.scaleMode=StageScaleMode.SHOW_ALL;
			stage.align=StageAlign.TOP_LEFT;
			start()
		}
		private function onEnterFrame(event:Event):void {
			if (_firstEnterFrame) {
				_firstEnterFrame=false;
				if (root.loaderInfo.bytesLoaded >= root.loaderInfo.bytesTotal) {
					dispose()
					run()
				} else {
					beginLoading();
				}
				return;
			}
			//trace(root.loaderInfo.bytesLoaded + "/" + root.loaderInfo.bytesTotal)
			if (root.loaderInfo.bytesLoaded >= root.loaderInfo.bytesTotal) {
				dispose()
				run()
			} else {
				var percent:Number=root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal;
				updateLoading(percent);
			}
		}
		
		// this function may never be called if the load is instant
		private function updateLoading(a_percent:Number):void {
			_preloaderPercent.scaleX = a_percent
		}
		
		// this function may never be called if the load is instant
		private function beginLoading():void {
			trace("begin Loading")
			_preloaderBackground = new Shape()
			_preloaderBackground.graphics.beginFill(0x333333)
			_preloaderBackground.graphics.lineStyle(2,0x000000)
			_preloaderBackground.graphics.drawRect(0,0,200,20)
			_preloaderBackground.graphics.endFill()
			
			//
			_preloaderPercent = new Shape()
			_preloaderPercent.graphics.beginFill(0xFFFFFFF)
			_preloaderPercent.graphics.drawRect(0,0,200,20)
			_preloaderPercent.graphics.endFill()
			//
			addChild(_preloaderBackground)
			addChild(_preloaderPercent)
			_preloaderBackground.x = (_appWidth - _preloaderBackground.width) / 2;
			_preloaderBackground.y = (_appHeight - _preloaderBackground.height) / 2;
			_preloaderPercent.x = (_appWidth - _preloaderPercent.width) / 2 - 1;
			_preloaderPercent.y = (_appHeight - _preloaderPercent.height) / 2 - 1;
			_preloaderPercent.scaleX = 0
		}
		
		
		private function dispose():void {
			trace("dispose preloader")
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			if (_preloaderBackground){
				removeChild(_preloaderBackground)
			}
			if (_preloaderPercent){
				removeChild(_preloaderPercent)
			}
			_preloaderBackground = null
			_preloaderPercent = null
		}
		private function run():void {
			nextFrame();
			var MainClass:Class=getDefinitionByName(mainClassName) as Class;
			if (MainClass == null) {
				throw new Error("AbstractPreloader:initialize. There was no class matching that name. Did you remember to override mainClassName?");
			}
			var main:DisplayObject=new MainClass() as DisplayObject;
			if (main == null) {
				throw new Error("AbstractPreloader:initialize. Main class needs to inherit from Sprite or MovieClip.");
			}
			addChildAt(main, 0);
			
		}
	}
}