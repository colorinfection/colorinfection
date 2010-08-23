package game.display {

	import flash.display.Sprite;
    import flash.display.Graphics;
    import flash.display.Shape;	
	
	public class PhysGround extends Sprite {
		
		public function PhysGround (w:Number, h:Number)
		{
			var child:Shape = new Shape();
         child.graphics.beginFill(0xFFDDDD);
         child.graphics.lineStyle(0, 0x666666);
         child.graphics.drawRect(-w/2, -h/2, w, h);
         child.graphics.endFill();
         addChild(child);
		}
	}

	            
}