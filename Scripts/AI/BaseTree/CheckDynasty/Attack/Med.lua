function Weight()
	if GetFavorToDynasty("dynasty", "VictimDynasty") > (gameplayformulas_GetMaxFavByDiffForAttack() - 15) then
		return 0
	end
	
	if ai_AICheckAction()==true then
		return 100
	else
		return 0
	end
end


function Execute()
end

