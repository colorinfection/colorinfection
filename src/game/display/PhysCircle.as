package game.display {

	import flash.display.Sprite;
    import flash.display.Graphics;
    import flash.display.Shape;	
	
	public class PhysCircle extends Sprite {
		
		public function PhysCircle (d:Number)
		{
			var child:Shape = new Shape();
			
			var halfSize:uint = Math.round(d / 2);
            child.graphics.beginFill(0x0000FF);
            child.graphics.lineStyle(0, 0x666666);
            child.graphics.drawCircle(0, 0, halfSize);
            child.graphics.endFill();
			
            addChild(child);
		}
	}

	            
}