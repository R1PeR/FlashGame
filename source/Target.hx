 package;

 import flixel.FlxSprite;
 import flixel.FlxG;
 import flixel.math.FlxPoint;
 import flixel.math.FlxAngle;
 import flixel.FlxObject;
 import flixel.math.FlxMath;

 class Target extends FlxSprite
 {

    public function new(?X:Float=0, ?Y:Float=0)
    {
        super(X, Y);
        makeGraphic(8,8,flixel.util.FlxColor.WHITE);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }
 }