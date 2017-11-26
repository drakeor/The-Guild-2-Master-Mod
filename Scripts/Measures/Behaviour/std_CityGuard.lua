function Run()
	local Player = false
	if GetSettlement("","Settlement") then	
		if GetOfficeTypeHolder("Settlement", 2 ,"Office") then		-- 2 = sheriff
			Player = DynastyIsPlayer("Office")
		end
		
		if not Player then
			RemoveItems("","Dagger",1,INVENTORY_EQUIPMENT)
			RemoveItems("","GuardsSword",1,INVENTORY_EQUIPMENT) 
			RemoveItems("","LeatherArmor",1,INVENTORY_EQUIPMENT) 
			RemoveItems("","IronCap",1,INVENTORY_EQUIPMENT) 
			
			SetSkillValue("",FIGHTING,1)
			SetSkillValue("",CONSTITUTION,1)
			SetSkillValue("",DEXTERITY,1)
		
			diseases_BurnWound("",true,true)
			AIExecutePlan("", "CityGuard", "SIM", "", "dynasty", "ServantDynasty")
			return
		end
	else
		PlayAnimation("","cogitate")
	end
	
	Sleep(Rand(20)+10)
end

function CleanUp()
end