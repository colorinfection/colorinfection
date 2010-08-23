package game.display {

	import flash.display.Sprite;
    import flash.display.Graphics;
    import flash.display.Shape;	
	
	public class PhysBox extends Sprite {
		
		public function PhysBox (w:Number, h:Number)
		{
			var child:Shape = new Shape();
            child.graphics.beginFill(0x00FF00);
            child.graphics.lineStyle(0, 0x666666);
            child.graphics.drawRect(-w/2, -h/2, w, h);
            child.graphics.endFill();
            addChild(child);
		}
	}

	            
}