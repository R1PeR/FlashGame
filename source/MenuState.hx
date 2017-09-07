package;
import flixel.FlxState;
import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.math.FlxPoint;
import flixel.util.FlxAxes;
import GlobalVars.GlobalClass;

class MenuState extends FlxState
{
	private var _btnPlay:FlxButton;
    private var _btnOptions:FlxButton;
    private var _menuText1:FlxText;
    private var _menuText2:FlxText;
    var sound:String = "Sound";
	override public function create():Void
	{
        _btnPlay = new FlxButton(0,0, "" , clickPlay);
        _btnPlay.loadGraphic("assets/images/button.png",false , 128, 64);
        _btnPlay.scale.set(2,2);
        _btnPlay.screenCenter();
        _btnOptions = new FlxButton(0,300, "" , clickOptions);
        _btnOptions.loadGraphic("assets/images/button.png",false , 128, 64);
        _btnOptions.scale.set(2,2);
        _btnOptions.screenCenter(FlxAxes.X);
        _menuText1 = new FlxText(0, 0, 300, "Play", 24);
        _menuText1.alignment = "center";
        _menuText1.screenCenter();
        _menuText2 = new FlxText(0, 300, 300, "" + sound, 24);
        _menuText2.alignment = "center";
        _menuText2.screenCenter(FlxAxes.X);
        GlobalClass._volume = 1.0;
        add(_btnOptions);
        add(_btnPlay);
        add(_menuText1);
        add(_menuText2);
        super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
        _menuText2.text = "" + sound;
	}

    public function clickPlay():Void
    {
        FlxG.switchState(new PlayState());
    }
     public function clickOptions():Void
    {
            if(sound == "Sound"){
                sound = "No Sound";
                GlobalClass._volume = 0.0;
            }
            else{
                sound = "Sound";   
                GlobalClass._volume = 1.0;
            }
           
    }
}
