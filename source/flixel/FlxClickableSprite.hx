package flixel;
// Borrowed from Yoshi Engine -Ralsi
import flixel.math.FlxPoint;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxRect;
import flixel.math.FlxMath;

class FlxClickableSprite extends FlxSprite
{
	public var onClick:Void->Void = null;
	public var hoverColor:Null<FlxColor> = null;
	public var hovering:Bool = false;
	public var key:Null<FlxKey> = null;
	public var justPressed:Bool = false;
	public var pressed:Bool = false;
	public var justReleased:Bool = false;
	public var hitbox:FlxPoint = null;

	public var isChanged:Bool = false;
	public var draggable:Bool = false;
	public var changable:Bool = false;
	public var hasBoundaries:Bool = false;

	public var hoverable:Bool = true;

	public override function new(x:Float, y:Float, spriteDir:String, itemName:String, draggable:Bool = false, changable:Bool = false, ?onClick:Void->Void)
	{
		super(x, y);
		this.onClick = onClick;
		this.draggable = draggable;
		this.changable = changable;
		this.frames = Paths.getSparrowAtlas(spriteDir);
		this.animation.addByPrefix('idle', itemName + ' Idle0', 24, true);
		this.animation.addByPrefix('hover', itemName + ' Hover0', 24, true);
		if (changable)
		{
			this.animation.addByPrefix('idleChanged', itemName + ' IdleChanged', 24, true);
			this.animation.addByPrefix('hoverChanged', itemName + ' HoverChanged', 24, true);
		}
	}

	var dragBounds:FlxRect;
	public function addBoundaries(x:Float, y:Float, width:Float, height:Float) // Easily create boundaries for your assets to move
	{
		hasBoundaries = true;
		dragBounds = new FlxRect(x, y, width, height);
	}

	public function _overlaps(point:FlxPoint)
	{
		var pos = this.getScreenPosition(null, this.camera);
		return (point.x > pos.x && point.x < pos.x + hitbox.x && point.y > pos.y && point.y < pos.y + hitbox.y);
	}

	public function setHitbox()
	{
		hitbox = new FlxPoint(frameWidth, frameHeight);
	}

	var clickTime:Float = 0;
	var dragTime:Float = 0;
	var clicks:Int = 0;
	public override function update(elapsed)
	{
		super.update(elapsed);
		var goodHover = false;
		
		if (hitbox == null)
			setHitbox();
		if (hoverable)
		{
			#if android
			for (t in FlxG.touches.list)
			{
				if (_overlaps(t.getScreenPosition(this.camera)))
				{
					justPressed = t.justPressed;
					pressed = t.pressed;
					justReleased = t.justReleased;
					goodHover = true;
					break;
				}
			}
			#else
			if (_overlaps(FlxG.mouse.getScreenPosition(this.camera)))
			{
				hovering = true;
				justPressed = FlxG.mouse.justPressed;
				pressed = FlxG.mouse.pressed;
				justReleased = FlxG.mouse.justReleased;
				goodHover = true;
			}
			#end

			if (!goodHover)
			{
				justPressed = pressed = justReleased = false;
				if (changable && isChanged)
					this.animation.play('idleChanged');
				else
					this.animation.play('idle');
			}
			else
			{
				if (changable && isChanged)
					this.animation.play('hoverChanged');
				else
					this.animation.play('hover');
			}

			// Clicking
			if (justPressed && onClick != null)
			{
				clicks++;
				if(clicks == 2)
				{
					onClick();

					if (changable && isChanged)
						isChanged = false;
					else if (changable && !isChanged)
						isChanged = true;
				}
			}

			if(clicks > 0)
			{
				clickTime += elapsed;
				if(clickTime > 0.25)
				{
					clicks = 0;
					clickTime = 0;
				}
				if (draggable)
				{
					dragTime += elapsed;
					if(dragTime > 1.5) dragTime = 0;
				}
			}

			// Dragging
			if (draggable)
				dragIcon();
		}
		else
			this.animation.play('idle');
	}

	private var dragging:Bool = false;
	private var dragOffsetX:Float = 0;
	private var dragOffsetY:Float = 0;
	public static var curSpriteDragging:FlxClickableSprite = null;
	function dragIcon()
	{
		if (FlxG.mouse.pressed && FlxG.mouse.overlaps(this) && curSpriteDragging == null)
		{
			if (!dragging && clickTime < 1.5)
			{
				dragging = true;
				curSpriteDragging = this;
				dragOffsetX = FlxG.mouse.x - this.x;
				dragOffsetY = FlxG.mouse.y - this.y;
			}
		}
		else if (!FlxG.mouse.pressed)
		{
			curSpriteDragging = null;
			dragging = false;
		}

		if (dragging && curSpriteDragging == this)
		{
			this.x = FlxG.mouse.x - dragOffsetX;
			this.y = FlxG.mouse.y - dragOffsetY;

			if (hasBoundaries)
			{
				this.x = FlxMath.bound(this.x, dragBounds.left, dragBounds.right - this.width);
				this.y = FlxMath.bound(this.y, dragBounds.top, dragBounds.bottom - this.height);
			}
		}
	}
}
