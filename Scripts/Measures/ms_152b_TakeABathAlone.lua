-- -----------------------
-- Run
-- -----------------------
function Run()

	-- hier muss noch der Preis anhand der Taverne und dem Sozialstatus des sims berechnet werden
	local MeasureID = GetCurrentMeasureID("")
	local TimeOut = mdata_GetTimeOut(MeasureID)
	local Price = SimGetRank("Owner")
	local BasicPrice = 20
	local RankPrice = 25
	local OverallPrice = BasicPrice + (Price * RankPrice)
	SetData("Price", OverallPrice)
	
	-- Stop a possibly following courtlover from following
	if SimGetCourtLover("", "CourtLover") then
		chr_StopFollowing("CourtLover", "")
	end
	
	local Money = GetMoney("")
	if Money < OverallPrice then
		MsgQuick("", "_TAVERN_152_TAKEABATH_FAILURES_+1", OverallPrice)
		return false
	end
	
	if not GetInsideBuilding("", "Tavern") then
		return false
	end		
	
	-----------------------------------------
	------ Check bath free and reserve ------
	-----------------------------------------
	if not GetLocatorByName("Tavern", "Bath1", "BathPosition") then
		MsgQuick("", "_TAVERN_152_TAKEABATH_FAILURES_+0", GetID("Tavern"))
		return false
	end
	
	if HasProperty("Tavern", "BathInUse") then
		MsgQuick("", "_TAVERN_152_TAKEABATH_FAILURES_+0", GetID("Tavern"))
		return false
	else
		SetProperty("Tavern", "BathInUse", 1)
	end	

	-- Go to the bath
	f_MoveTo("", "BathPosition")
	if not f_BeginUseLocator("", "BathPosition", GL_STANCE_STAND, true) then
		return false
	end
	
	SetData("Bathing", 1)

	local MaxHP = GetMaxHP("")
	local ToHeal = 0.02 * MaxHP
	
	SetMeasureRepeat(TimeOut)
	
	-- Pay if the tavern does not belong to the owners dynasty
	if GetDynastyID("Tavern") ~= GetDynastyID("") then
		if not SpendMoney("", GetData("Price"), "CostSocial") then
			MsgQuick("", "_TAVERN_152_TAKEABATH_FAILURES_+0", GetID("Tavern"))
			return
		end
		CreditMoney("Tavern",GetData("Price"),"Offering")
	end

	-- Bathing
	GfxStartParticle("Steam", "particles/bath_steam.nif", "BathPosition", 2.5)
	
	PlaySound3DVariation("", "measures/takeabath_alone", 1)
	Sleep(2)
	
	while(GetHP("") < MaxHP) do
		PlaySound3DVariation("", "measures/takeabath_alone", 1)
		Sleep(2)
		ModifyHP("", ToHeal)
	end
	
	GfxStopParticle("Steam")
	Sleep(4)
	
	if GetFreeLocatorByName("Tavern", "Stroll", 1, 5, "EndPos") then
		f_MoveTo("", "EndPos")
	end
	
end

-- -----------------------
-- CleanUp
-- -----------------------
function CleanUp()

	RemoveProperty("Tavern", "BathInUse")
	StopAnimation("")
	
end

-- -----------------------
-- GetOSHData
-- -----------------------
function GetOSHData(MeasureID)
	local Price = SimGetRank("Owner")
	local BasicPrice = 20
	local RankPrice = 25
	local OverallPrice = BasicPrice + (Price * RankPrice)
	--can be used again in:
	OSHSetMeasureRepeat("@L_ONSCREENHELP_7_MEASURES_TIMEINFOS_+2",Gametime2Total(mdata_GetTimeOut(MeasureID)))
	OSHSetMeasureCost("@L_INTERFACE_HEADER_+6",OverallPrice)
end

