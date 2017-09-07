package;
import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxRandom;
import flixel.group.FlxGroup;
import flixel.util.FlxCollision;
import flixel.math.FlxMath;
import GlobalVars.GlobalClass;


class PlayState extends FlxState
{
	public var _player:Player;
	private var _timer:FlxTimer;
	private var _random:FlxRandom;
	var gameOver:Bool = false;
	var _x:Float;
	var _y:Float;
	var border:FlxSprite;
	var score:FlxText;
	var textScore:String = "0";
	var textOnScreen:FlxText;
	var textSpeed:FlxText;
	var _speed:Float = 1.0;
	private var _grpEnemies:FlxTypedGroup<Target>;
	override public function create():Void
	{
		GlobalClass._score = 0;
		_random = new FlxRandom();
		_player = new Player(FlxG.width/2 - 8,FlxG.height/2 -8);
		border = new FlxSprite(20,50);
		border.makeGraphic((FlxG.width - 40),(FlxG.height - 70),FlxColor.BLACK);
		for(y in 0 ... FlxG.height - 70 )
		{
			for(x in 0 ... FlxG.width - 40)
			{
				if(x < 5 || y < 5 || x > FlxG.width - 45 || y > FlxG.height - 75)
				border.pixels.setPixel(x,y,0xffffff);
			}
		}
		score = new FlxText(20,5,200,"SCORE:" + textScore,32);
		textSpeed = new FlxText(225,5,250,"SPEED:" + _speed,32);
		textOnScreen = new FlxText(450,5,250,"DOTS:" + 0 ,32);
	   	FlxG.watch.add(_player, "_mouseAngle");
		FlxG.watch.add(_player, "_leftMouse");
		FlxG.watch.add(this, "loops");
		FlxG.watch.add(this, "_speed");
		FlxG.watch.add(_player, "mousePos");
		FlxG.watch.add(_player, "velocity");
		FlxG.watch.add(_player, "velocity.y");
		_timer = new FlxTimer().start(_speed, randomTarget, 0);
		_grpEnemies = new FlxTypedGroup<Target>();
		
		add(border);
 		add(_grpEnemies);
		add(_player);
		add(score);
		add(textSpeed);
		add(textOnScreen);
	

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		if(_grpEnemies.length - GlobalClass._score >= 10)
		{
			gameOver = true;
		}
		if(!gameOver)
		{
			if(FlxG.sound.music == null || FlxG.sound.music.playing == false)
			{
				FlxG.sound.playMusic("assets/music/" + _random.int(1,3) + ".mp3" , GlobalClass._volume, true);
			}
			if(_speed > 0.1){
			_speed = _speed - 0.01 * elapsed;
			}else{
				_speed = 0.1;
			}
			textSpeed.text = "SPEED:" + FlxMath.roundDecimal(_speed, 2);
			textOnScreen.text = "DOTS:" + (_grpEnemies.length - GlobalClass._score);
			_timer.time = _speed;
			for (i in 0..._grpEnemies.length) 
			{
			var _object = _grpEnemies.members[i];
			if (FlxCollision.pixelPerfectCheck(_object,_player,5) && _object.alive)
				{
					_object.kill();
					GlobalClass._score++;
					textScore = "" + GlobalClass._score;
					score.text = "SCORE:" + textScore;
				}	
			}
		}
		else
		{
			FlxG.sound.music.destroy();
			if(FlxG.sound.music.autoDestroy){
				FlxG.sound.music.destroy();
			}
			FlxG.switchState(new GameOverState());

		}
		super.update(elapsed);
	}
	public function randomTarget(Timer:FlxTimer):Void
	{
		_grpEnemies.add(new Target(_random.int(25, 608 ), _random.int(55,  448 )));
	}
}
