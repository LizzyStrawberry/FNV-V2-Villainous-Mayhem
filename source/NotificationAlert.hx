package;

class NotificationAlert {
    public static var sendMessage:Bool = false;
    public static var sendCategoryNotification:Bool = false;
    public static var sendShopNotification:Bool = false;
    public static var sendOptionsNotification:Bool = false;
    public static var sendInventoryNotification:Bool = false;
    public static var sendTutorialNotification:Bool = false;

    public static function addNotification(state:FlxState, target:FlxSprite, targetX:Float = 0, targetY:Float = 0):Void
    {
        var notification = createNotificationSprite(target, targetX, targetY);
        state.add(notification);
    }

    private static function createNotificationSprite(target:FlxSprite, targetX:Float, targetY:Float):FlxSprite
    {
        var notification:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('notifications/notifButton'));
        notification.frames = Paths.getSparrowAtlas('notifications/notifButton');
		notification.animation.addByPrefix('notifPlay', "notification0", 24);
        notification.animation.play('notifPlay');
        notification.scale.set(0.6, 0.6);
		notification.antialiasing = ClientPrefs.globalAntialiasing;
		notification.updateHitbox();

        // Position notification on top of the target sprite
        notification.x = target.x + (targetX);
        notification.y = target.y + (targetY);

        return notification;
    }

    public static var notifMessage:FlxSprite = null;
    public static var notifMessageSprites:Array<FlxSprite> = [];
    public static var tweens:Array<FlxTween> = [];
    public static var timers:Array<FlxTimer> = [];
    public static var multiPopup:Bool = false;
    public static function showMessage(state:FlxState, type:String, checkForShop:Bool = false)
    {
        if (notifMessageSprites.length >= 1)
        {
            multiPopup = true;
            new FlxTimer().start(0.99, function(tmr:FlxTimer) {
                var index = notifMessageSprites.indexOf(notifMessage);
                if (tweens[index] != null)
                    tweens[index].cancel();
                fixExistingPopUp(notifMessageSprites, index);
                createMessagePopUp(state, type);
            });
        }
        else
        {
            multiPopup = false;
            createMessagePopUp(state, type, checkForShop);
        }
    }

    public static function fixExistingPopUp(sprite:Array<FlxSprite>, pos:Int)
    {
        if (tweens[pos] != null) tweens[pos] = FlxTween.tween(notifMessageSprites[pos], {y:notifMessageSprites[pos].y - 200}, 1, {ease: FlxEase.circOut, type: PERSIST, onComplete: finishTween});
    }

    public static var dur:Float = 2;
    public static function createMessagePopUp(state:FlxState, type:String, checkForShop:Bool = false)
    {
        notifMessage = new FlxSprite(800, 545);
        switch(type)
        {
            case 'Normal' |'normal' |'NORMAL':
                notifMessage.loadGraphic(Paths.image('notifications/notifMessageNormal'));
            case 'Freeplay' |'freeplay' | 'FREEPLAY':
                notifMessage.loadGraphic(Paths.image('notifications/notifMessageFreeplay'));
            case 'Iniquitous' |'iniquitous' | 'INIQUITOUS':
                notifMessage.loadGraphic(Paths.image('notifications/notifMessageIniquitous'));
            case 'Injection' |'injection' | 'INJECTION':
                notifMessage.loadGraphic(Paths.image('notifications/notifMessageInjection'));
            case 'Mayhem' |'mayhem' | 'MAYHEM':
                notifMessage.loadGraphic(Paths.image('notifications/notifMessageMayhem'));
            case 'Tutorial' |'tutorial' | 'TUTORIAL':
                notifMessage.loadGraphic(Paths.image('notifications/notifMessageTutorial'));
        }
		notifMessage.antialiasing = ClientPrefs.globalAntialiasing;
		notifMessage.updateHitbox();
        notifMessage.y += 200;
        state.add(notifMessage);
        notifMessageSprites.push(notifMessage);

        FlxG.sound.play(Paths.sound('notifSound'));

        var tween = FlxTween.tween(notifMessage, {y:notifMessage.y - 200}, 1, {ease: FlxEase.circOut, type: PERSIST, onComplete: finishTween});
        tweens.push(tween);

        if (MusicBeatState.transitionType == 'stickers')
            dur = 4;
        else if (checkForShop == true)
            dur = 0.45;
        else
            dur = 2;
    }

    public static function finishTween(tween:FlxTween):Void
    {
        if (multiPopup == true)
        {
            for (i in 0...notifMessageSprites.length - 1)
            {
                var index = tweens.indexOf(tween);
                if (index != -1)
                {
                    trace('Index: ' + index);
                    var distance:Float = Math.abs(Math.round((notifMessageSprites[index].y - 745) * 100) / 100);
                    trace('Distance of sprite on index ' + index + " : " + distance);
                    var speed:Float = distance / 1;
                    trace('Speed of sprite on index ' + index + " : " + speed);
                    var duration:Float = (Math.round((distance / speed) * 100) / 100) - (index * 0.002);
                    trace('Duration of Tween on index ' + index + " : " + duration);
                    // Start a timer to remove the notification after a delay
                    var timer = new FlxTimer().start(dur, function(tmr:FlxTimer) {
                        if (index == 0)
                            tweens[index] = FlxTween.tween(notifMessageSprites[index], {y: 745}, duration, {ease: FlxEase.cubeIn, type: PERSIST, onComplete: killSprite});
                        else
                            tweens[index] = FlxTween.tween(notifMessageSprites[index], {y: 745}, duration, {ease: FlxEase.cubeIn, type: PERSIST});
                    });
                    timers.push(timer);
                }
                else
                {
                    trace('No Index Found!');
                }
            }
        }
        else
        {
             // Start a timer to remove the notification after a delay
            var timer = new FlxTimer().start(dur, function(tmr:FlxTimer) {
                    tweens[0] = FlxTween.tween(notifMessage, {y: 745}, 1, {ease: FlxEase.cubeIn, type: PERSIST, onComplete: killSprite});
            });
            timers.push(timer);
        }
    }

    public static function killSprite(tween:FlxTween):Void
    {
        var index = notifMessageSprites.length - 1;
        while (index != -1) {
            var notification = notifMessageSprites[index];
            notification.kill();
            tweens.splice(index, 1);
            notifMessageSprites.splice(index, 1);
            if (timers[index] != null)
            timers[index].cancel();
            timers.splice(index, 1);
            index -= 1;
        }
        multiPopup = false;
    }

    public static function resetNotifications()
    {
        notifMessageSprites = [];
        timers = [];
        tweens = [];
        multiPopup = false;

        sendMessage = false;

        notifMessage = null;

        sendCategoryNotification = false;
        sendShopNotification = false;
        sendOptionsNotification = false;
        sendInventoryNotification = false;
        sendTutorialNotification = false;

        saveNotifications();
    }

    public static function saveNotifications()
    {
        FlxG.save.data.sendMessage = sendMessage;

        FlxG.save.data.sendCategoryNotification = sendShopNotification;
        FlxG.save.data.sendShopNotification = sendShopNotification;
        FlxG.save.data.sendOptionsNotification = sendShopNotification;
        FlxG.save.data.sendInventoryNotification = sendInventoryNotification;
        FlxG.save.data.sendTutorialNotification = sendTutorialNotification;
    }

    public static function loadNotifications()
    {
        if(FlxG.save.data.sendMessage != null) {
			sendMessage = FlxG.save.data.sendMessage;
		}

        if(FlxG.save.data.sendCategoryNotification != null) {
			sendShopNotification = FlxG.save.data.sendShopNotification;
		}
        if(FlxG.save.data.sendShopNotification != null) {
			sendShopNotification = FlxG.save.data.sendShopNotification;
		}
        if(FlxG.save.data.sendOptionsNotification != null) {
			sendShopNotification = FlxG.save.data.sendShopNotification;
		}
        if(FlxG.save.data.sendInventoryNotification != null) {
			sendInventoryNotification = FlxG.save.data.sendInventoryNotification;
		}
        if(FlxG.save.data.sendTutorialNotification != null) {
			sendTutorialNotification = FlxG.save.data.sendTutorialNotification;
		}
    }
}