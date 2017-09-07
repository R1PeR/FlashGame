package;
import flixel.FlxState;
import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import GlobalVars.GlobalClass;

class GameOverState extends FlxState
{
    private var _btnPlay:FlxButton;
    private var _menuText1:FlxText;
    private var _menuText2:FlxText;
    private var _menuText3:FlxText;
    private var _menuText4:FlxText;
	override public function create():Void
	{
        _btnPlay = new FlxButton(0,0, "", clickPlay);
        _btnPlay.loadGraphic("assets/images/button.png", false, 128, 64);
        _btnPlay.scale.set(2,2);
        _btnPlay.screenCenter();
        _menuText1 = new FlxText(FlxG.width/2 - 300, 40, 600, "Game Over", 44);
        _menuText2 = new FlxText(FlxG.width/2 - 150, 100, 300, "Your Score", 32);
        _menuText3 = new FlxText(FlxG.width/2 - 150, 160, 300, "" + GlobalClass._score, 32);
        _menuText4 = new FlxText(FlxG.width/2 - 150, 160, 300, "Main Menu", 22);
        _menuText1.alignment = "center";
        _menuText2.alignment = "center";
        _menuText3.alignment = "center";    
        _menuText4.alignment = "center"; 
        _menuText4.screenCenter();
        add(_menuText1);
        add(_menuText2);
        add(_menuText3);  
        add(_btnPlay);
        add(_menuText4);
        super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

    public function clickPlay():Void
    {
        FlxG.switchState(new MenuState());
    }
}
