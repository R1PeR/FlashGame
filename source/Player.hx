 package;

 import flixel.FlxSprite;
 import flixel.FlxG;
 import flixel.math.FlxPoint;
 import flixel.math.FlxAngle;
 import flixel.FlxObject;
 import flixel.math.FlxMath;
 import flixel.math.FlxVector;

 class Player extends FlxSprite
 {
    
    var _leftMouse:Bool = false;
    var _mouseAngle:Float = 0;
    var _speed:Float = 2;
    var _drag:Float = 1;
    var outOfLeft:Bool = false;
    var outOfRight:Bool = false;
    var outOfUp:Bool = false;
    var outOfDown:Bool = false;
    var distanceToMouse:FlxVector;

    public function new(?X:Float=0, ?Y:Float=0)
    {
        super(X, Y);
        makeGraphic(16,16,flixel.util.FlxColor.WHITE);
        distanceToMouse = new FlxVector((FlxG.mouse.x - x) - 8, (FlxG.mouse.y - y) - 8);
    }
    private function mouseLogic():Void
    {
        _leftMouse = FlxG.mouse.pressed;
        distanceToMouse.x = (FlxG.mouse.x - x) - 8;
        distanceToMouse.y = (FlxG.mouse.y - y) - 8;
    }
    private function addForce(elapsed:Float):Void
    {   
        if(x <= 25){
        velocity.x = 0;
        x = 25;
        outOfLeft = true;
        }else{
        outOfLeft = false;
        }
        if(y <= 55){
        velocity.y = 0;
        y = 55;
        outOfUp = true;
        }
        else{
        outOfUp = false;
        }
        if(x >= 600)
        {
        velocity.x = 0;
        x = 600;
        outOfRight = true;
        }
        else{
        outOfRight = false;
        }
        if(y >= 440)
        {
        velocity.y = 0;
        y = 440;
        outOfDown = true;
        }
        else{
        outOfDown = false;
        }
        if(_leftMouse)
        {
            if(distanceToMouse.x >= 0 && !outOfRight)
            {
            velocity.x = (_speed * distanceToMouse.x);
            }
            if(distanceToMouse.x <= 0 && !outOfLeft)
            {
            velocity.x = (_speed * distanceToMouse.x);
            }
            if(distanceToMouse.y >= 0 && !outOfDown)
            {
            velocity.y = (_speed * distanceToMouse.y);
            }
            if(distanceToMouse.y <= 0 && !outOfUp)
            {
            velocity.y = (_speed * distanceToMouse.y);
            }
        }
        if(!_leftMouse)
        {
            if(velocity.x > 0)
            velocity.x -= _drag;
            if(velocity.x < 0)
            velocity.x += _drag;
            if(velocity.y > 0)
            velocity.y -= _drag;
            if(velocity.y < 0)
            velocity.y += _drag;
            if(velocity.x < 1 && velocity.x > -1)
            velocity.x = 0;
            if(velocity.y < 1 && velocity.y > -1)
            velocity.y = 0; 
        }
    }
    override public function update(elapsed:Float):Void
    {
        mouseLogic();
        addForce(elapsed);
        super.update(elapsed);
    }
 }