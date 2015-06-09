package emagin.components
{
    import flash.display.*;
    import flash.geom.*;

/**
 * ...
 * @author Chakir
 */

    public class EPreloader extends Sprite
    {
        private var child:Shape;
        public var mc_fond:Sprite;
        private var _bgColor:int;

        public function EPreloader(param1:int = 0x4BB9DB)
        {
            child = new Shape();
            mc_fond.mask = child;
            bgColor = param1;
            return;
        }// end function

        public function setPourcent(param1:Number) : void
        {
            var _loc_2:Number = NaN;
            child.graphics.clear();
            _loc_2 = param1 * 2 * Math.PI;
            if (_loc_2 <= Math.PI)
            {
                drawAngle(bgColor, _loc_2);
            }
            else
            {
                drawAngle(bgColor, Math.PI);
                drawAngle(bgColor, _loc_2 - Math.PI, -1);
            }
            return;
        }// end function

        public function get bgColor() : int
        {
            return _bgColor;
        }// end function

        public function set bgColor(param1:int) : void
        {
            var _loc_2:ColorTransform = null;
            _bgColor = param1;
            _loc_2 = new ColorTransform();
            _loc_2.color = param1;
            mc_fond.transform.colorTransform = _loc_2;
            return;
        }// end function

        private function drawAngle(param1:Number, param2:Number, param3:int = 1) : void
        {
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            child.graphics.beginFill(16777215);
            child.graphics.moveTo(0, 0);
            child.graphics.lineTo(0, (-param3) * 20);
            _loc_4 = (-param3) * Math.cos(param2) * 20;
            _loc_5 = param3 * Math.sin(param2) * 20;
            _loc_6 = (-param3) * Math.cos(param2 / 2) * 34;
            _loc_7 = param3 * Math.sin(param2 / 2) * 34;
            child.graphics.curveTo(_loc_7, _loc_6, _loc_5, _loc_4);
            child.graphics.lineTo(0, 0);
            child.graphics.endFill();
            addChild(child);
            return;
        }// end function

    }
}
