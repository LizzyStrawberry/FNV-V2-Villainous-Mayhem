package;

import Achievements;

class NotificationAlert 
{
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
        var notification:FlxSprite = new FlxSprite().loadGraphic(Paths.image('notifications/notifButton'));
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
        notifMessage = new FlxSprite(MobileUtil.fixX(800), FlxG.height + 25);
        switch(type.toLowerCase())
        {
            case 'normal':
                notifMessage.loadGraphic(Paths.image('notifications/notifMessageNormal'));
            case 'freeplay':
                notifMessage.loadGraphic(Paths.image('notifications/notifMessageFreeplay'));
            case 'iniquitous':
                notifMessage.loadGraphic(Paths.image('notifications/notifMessageIniquitous'));
            case 'injection':
                notifMessage.loadGraphic(Paths.image('notifications/notifMessageInjection'));
            case 'mayhem':
                notifMessage.loadGraphic(Paths.image('notifications/notifMessageMayhem'));
            case 'tutorial':
                notifMessage.loadGraphic(Paths.image('notifications/notifMessageTutorial'));
            case 'badge':
                notifMessage.loadGraphic(Paths.image('notifications/notifMessageBadge'));
        }
		notifMessage.antialiasing = ClientPrefs.globalAntialiasing;
		notifMessage.updateHitbox();
        state.add(notifMessage);
        notifMessageSprites.push(notifMessage);

        FlxG.sound.play(Paths.sound('notifSound'));

        var tween = FlxTween.tween(notifMessage, {y:notifMessage.y - 200}, 1, {ease: FlxEase.circOut, type: PERSIST, onComplete: finishTween});
        tweens.push(tween);

        if (MusicBeatState.transitionType == 'stickers')  dur = 4;
        else if (checkForShop) dur = 0.45;
        else dur = 2;
    }

    public static function finishTween(tween:FlxTween):Void
    {
        if (multiPopup)
        {
            for (i in 0...notifMessageSprites.length - 1)
            {
                var index = tweens.indexOf(tween);
                if (index == -1) return trace('No Index Found!');
                
                var distance:Float = Math.abs(Math.round((notifMessageSprites[index].y - 745) * 100) / 100);
                var speed:Float = distance / 1;
                var duration:Float = (Math.round((distance / speed) * 100) / 100) - (index * 0.002);

                //trace('Index: ' + index);
                //trace('Distance of sprite on index ' + index + " : " + distance);
                //trace('Speed of sprite on index ' + index + " : " + speed);
                //trace('Duration of Tween on index ' + index + " : " + duration);

                // Start a timer to remove the notification after a delay
                var timer = new FlxTimer().start(dur, function(_) 
                {
                    tweens[index] = FlxTween.tween(notifMessageSprites[index], {y: 745}, duration, 
                                    {ease: FlxEase.cubeIn, type: PERSIST, onComplete: (index == 0) ? killSprite : null});
                });
                timers.push(timer);
            }
        }
        else
        {
             // Start a timer to remove the notification after a delay
            var timer = new FlxTimer().start(dur, function(_) 
            {
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

    public static function checkForNotifications(state:FlxState)
    {
        /**
            BADGES SECTION
        **/
        if (achievementCheck("main") && ClientPrefs.badgesCollected < 1)
		{
			showMessage(state, 'Badge');
			sendCategoryNotification = true;
			saveNotifications();

			ClientPrefs.badgesCollected += 1;
			ClientPrefs.saveSettings();
		}
        if (achievementCheck("bonus") && ClientPrefs.badgesCollected == 1)
		{
			NotificationAlert.showMessage(state, 'Badge');
			NotificationAlert.sendCategoryNotification = true;
			NotificationAlert.saveNotifications();

			ClientPrefs.badgesCollected += 1;
			ClientPrefs.saveSettings();
		}

        /**
            INIQUITOUS SECTION
        **/
        // Unlock Iniquitous Week
		if (!ClientPrefs.iniquitousWeekUnlocked && achievementCheck('mainVillainous'))
		{
			ClientPrefs.iniquitousWeekUnlocked = true;
			sendCategoryNotification = sendMessage = true;
			sendMessage = true;
			ClientPrefs.saveSettings();

			FlxG.sound.music.fadeOut(0.2);
			new FlxTimer().start(0.2, function(_)
            {
                FlxG.sound.playMusic(Paths.music('malumIctum'));
                FlxG.sound.music.fadeIn(2.0);
            });
		}
        // This unlocks Iniquitous Difficulty
        if (ClientPrefs.iniquitousWeekBeaten && !Achievements.isAchievementUnlocked('weekIniquitous_Beaten'))
		{
			var achieveID:Int = Achievements.getAchievementIndex('weekIniquitous_Beaten');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) 
            {
				giveNotificationAchievement('weekIniquitous_Beaten', achieveID, state);
				
				showMessage(state, 'Iniquitous');
                showMessage(state, 'Badge');
                sendCategoryNotification = true;
                saveNotifications();

                ClientPrefs.badgesCollected += 1;
				ClientPrefs.saveSettings();
			}
		}
        
        /**
            CROSSOVER SECTION
        **/
        // This unlocks the crossover section
        if (achievementCheck("main") && achievementCheck("bonus") && achievementCheck("xtrasBasic") 
            && !ClientPrefs.roadMapUnlocked && !ClientPrefs.crossoverUnlocked)
		{
			showMessage(state, 'Normal');
			sendCategoryNotification = true;
			saveNotifications();

			ClientPrefs.roadMapUnlocked = true;
			ClientPrefs.saveSettings();
		}
		if (ClientPrefs.crossoverUnlocked)
		{
			var achieveID:Int = Achievements.getAchievementIndex('crossover_Beaten');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2]))
            {
				giveNotificationAchievement('crossover_Beaten', achieveID, state);
                showMessage(state, 'Badge');
                sendCategoryNotification = true;
                saveNotifications();

                ClientPrefs.badgesCollected += 1;
				ClientPrefs.saveSettings();
			}
		}

        /**
            REMAINDER OF NOTIFICATIONS
        **/
        // This gives the short song achievement
        if (ClientPrefs.shortPlayed)
		{
			var achieveID:Int = Achievements.getAchievementIndex('short_Beaten');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) 
            {
				giveNotificationAchievement('short_Beaten', achieveID, state);
				ClientPrefs.saveSettings();
			}
		}

        // This unlocks Mayhem Mode
        if (!ClientPrefs.mayhemNotif &&achievementCheck("main") && achievementCheck("bonus") 
            && achievementCheck("xtrasBasic") && achievementCheck("crossover"))
		{
			ClientPrefs.mayhemNotif = true;
			NotificationAlert.showMessage(state, 'Mayhem');
			ClientPrefs.saveSettings();
		}

        // This gives out the 100% Completion Achievement
        if((achievementCheck('main') || achievementCheck('mainVillainous')) && (achievementCheck('bonus') || achievementCheck('bonusVillainous'))
            && (achievementCheck('xtrasbasic') || achievementCheck('xtras')) 
            && achievementCheck('crossover') && achievementCheck('iniquitous'))
		{
            trace("Accepted the 100% completion achievement!");
			var achieveID:Int = Achievements.getAchievementIndex('FNV_Completed');
			if((!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2]))) {
				giveNotificationAchievement('FNV_Completed', achieveID, state);

                showMessage(state, 'Badge');
                sendCategoryNotification = true;
                saveNotifications();

                ClientPrefs.badgesCollected += 1;
                ClientPrefs.saveSettings();
			}
		}
    }

    public static function achievementCheck(type:String):Bool
    {
        switch(type.toLowerCase())
        {
            case "main":
                return (Achievements.isAchievementUnlocked('Tutorial_Beaten') && Achievements.isAchievementUnlocked('WeekMarco_Beaten') && Achievements.isAchievementUnlocked('WeekNun_Beaten') && Achievements.isAchievementUnlocked('WeekKiana_Beaten'));
            case "mainvillainous":
                return (Achievements.isAchievementUnlocked('WeekMarcoVillainous_Beaten') && Achievements.isAchievementUnlocked('WeekNunVillainous_Beaten') && Achievements.isAchievementUnlocked('WeekKianaVillainous_Beaten'));
            case "maininiquitous":
                return (Achievements.isAchievementUnlocked('WeekMarcoIniquitous_Beaten') && Achievements.isAchievementUnlocked('WeekNunIniquitous_Beaten')&&  Achievements.isAchievementUnlocked('WeekKianaIniquitous_Beaten'));
       
            case "bonus":
                return (Achievements.isAchievementUnlocked('WeekMorky_Beaten') && Achievements.isAchievementUnlocked('WeekSus_Beaten') && Achievements.isAchievementUnlocked('WeekLegacy_Beaten') && Achievements.isAchievementUnlocked('WeekDside_Beaten'));
            case "bonusvillainous":
                return (Achievements.isAchievementUnlocked('WeekMorkyVillainous_Beaten') && Achievements.isAchievementUnlocked('WeekSusVillainous_Beaten') && Achievements.isAchievementUnlocked('WeekLegacyVillainous_Beaten') && Achievements.isAchievementUnlocked('WeekDsideVillainous_Beaten'));
        
            case "iniquitous":
                return Achievements.isAchievementUnlocked('weekIniquitous_Beaten');

            case "xtras":
                return (Achievements.isAchievementUnlocked('tofu_Beaten') && Achievements.isAchievementUnlocked('marcochrome_Beaten') && Achievements.isAchievementUnlocked('lustality_Beaten') && Achievements.isAchievementUnlocked('nunsational_Beaten')
			    && Achievements.isAchievementUnlocked('FNV_Beaten') && Achievements.isAchievementUnlocked('short_Beaten') && Achievements.isAchievementUnlocked('nic_Beaten') && Achievements.isAchievementUnlocked('fanfuck_Beaten')
			    && Achievements.isAchievementUnlocked('rainyDaze_Beaten') && Achievements.isAchievementUnlocked('marauder_Beaten'));
                
            case "xtrasbasic":
                return ClientPrefs.tofuPlayed && ClientPrefs.lustalityViewed && ClientPrefs.nunsationalPlayed && ClientPrefs.marcochromePlayed && ClientPrefs.nicPlayed 
                && Achievements.isAchievementUnlocked('short_Beaten') && ClientPrefs.debugPlayed && ClientPrefs.fnvPlayed && ClientPrefs.infatuationPlayed && ClientPrefs.rainyDazePlayed;

            case "crossover":
                return (Achievements.isAchievementUnlocked('vGuy_Beaten') && Achievements.isAchievementUnlocked('fastFoodTherapy_Beaten') && Achievements.isAchievementUnlocked('tacticalMishap_Beaten') && Achievements.isAchievementUnlocked('breacher_Beaten')
			    && Achievements.isAchievementUnlocked('negotiation_Beaten') && Achievements.isAchievementUnlocked('concertChaos_Beaten') && Achievements.isAchievementUnlocked('crossover_Beaten'));

            case "misc":
                return (Achievements.isAchievementUnlocked('itsKiana_Beaten') && Achievements.isAchievementUnlocked('hermit_found') && Achievements.isAchievementUnlocked('zeel_found') && Achievements.isAchievementUnlocked('shop_completed') 
                && Achievements.isAchievementUnlocked('flashbang') && Achievements.isAchievementUnlocked('pervert') && Achievements.isAchievementUnlocked('pervertX25'));
        }

        return false;
    }

    static function giveNotificationAchievement(achievementName:String, id:Int, state:FlxState) 
    {
		state.add(new AchievementObject(achievementName));
        Achievements.achievementsMap.set(Achievements.achievementsStuff[id][2], true);
		
        FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "${achievementName}"');
	}

    // Save - Reset - Load
    public static function resetNotifications()
    {
        notifMessageSprites = [];
        timers = [];
        tweens = [];
        multiPopup = sendMessage = false;

        notifMessage = null;

        sendCategoryNotification = sendShopNotification= sendOptionsNotification = 
        sendTutorialNotification = sendInventoryNotification = false;

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
        if(FlxG.save.data.sendMessage != null) sendMessage = FlxG.save.data.sendMessage;
        if(FlxG.save.data.sendCategoryNotification != null) sendShopNotification = FlxG.save.data.sendShopNotification;
        if(FlxG.save.data.sendShopNotification != null) sendShopNotification = FlxG.save.data.sendShopNotification;
        if(FlxG.save.data.sendOptionsNotification != null) sendShopNotification = FlxG.save.data.sendShopNotification;
        if(FlxG.save.data.sendInventoryNotification != null) sendInventoryNotification = FlxG.save.data.sendInventoryNotification;
        if(FlxG.save.data.sendTutorialNotification != null) sendTutorialNotification = FlxG.save.data.sendTutorialNotification;
    }
}