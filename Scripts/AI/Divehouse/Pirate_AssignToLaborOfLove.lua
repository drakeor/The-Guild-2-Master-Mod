function Weight()

	if not GetSettlement("SIM", "City") then
		return 0
	end

	if not SimGetWorkingPlace("SIM","MyWork") then
	    return 0
	end	

	if CityFindCrowdedPlace("City", "SIM", "pick_pos")==0 then
		return 0
	end

	if IsDynastySim("SIM") then
		return 0
	end

	if not HasProperty("MyWork", "ServiceActive") then
		return 0			
	end	

	if BuildingGetLevel("MyWork") > 1 then
		if not HasProperty("MyWork", "DanceShow") then
			return 33
		end	
	end

	return 100
end

function Execute()
	MeasureCreate("Measure")
	MeasureAddData("Measure", "TimeOut", Rand(6)+2)
	MeasureStart("Measure", "SIM", "pick_pos", "AssignToLaborOfLove")
end

