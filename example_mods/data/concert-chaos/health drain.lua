function opponentNoteHit(id,d,t,ns)
	health = getProperty('health')
	if not isMayhemMode and mechanics and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
		if curStep >= 1872 and curStep < 2400 then
			if getProperty('health') > 0.2 and t =='' then
				if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
					setProperty('health', health- 0.00375);
				else
					setProperty('health', health- 0.0075);
				end
			end
		else
			if getProperty('health') > 0.2 and t~='protag' then
				if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
					setProperty('health', health- 0.00375);
				else
					setProperty('health', health- 0.0075);
				end
			end
		end
	end
end
