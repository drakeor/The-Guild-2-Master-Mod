function Run()
	
	SpendMoney("",1000,"blabla",true)
	
	
	
	--AUTOMATIC TRADE
--	if not AliasExists("Destination") then
--		StopMeasure()
--	end
--	
--	CopyAlias("Destination","Source")
--	
--	if not AliasExists("Target") then
--		StopMeasure()
--	end
--	
--	--cart information
--	local	CartType = CartGetType("")
--	local	CartSlots = 1
--	local	CartSlotSize = 20
--	if CartType == 0 then
--		--0 = schubkarre  1x20	
--		CartSlots = 1
--		CartSlotSize = 20
--	elseif CartType == 1 then
--		--1 = karren 2x20
--		CartSlots = 2
--		CartSlotSize = 20
--	elseif CartType == 2 then
--		--2 = ochsenkarren 3x40
--		CartSlots = 3
--		CartSlotSize = 40	
--	elseif CartType == 3 then
--		--3 pferdekarren 3x20
--		CartSlots = 3
--		CartSlotSize = 20
--	else
--		MsgDebugMeasure("Invalid Cart Type selected")
--		StopMeasure()
--	end	
--		
--	local	Slots = InventoryGetSlotCount("Source", INVENTORY_STD)
--	local	Number 
--	local	ItemId
--	local	ItemCount
--	local	NumItems = 0
--	local	ItemName = {}
--	local	ItemLabel = {}
--	local	ItemTexture
--	local 	btn = ""
--	local	added = {}
--	
--	--count all items, remove duplicates
--	for Number = 0, Slots-1 do
--		ItemId, ItemCount = InventoryGetSlotInfo("Source", Number, INVENTORY_STD)
--		local ShowItem = true
--		if BuildingGetType("Source")==14 then
--			if ItemGetCategory(ItemId) ~= ITEM_CATEGORY_RESOURCE then
--				ShowItem = false
--			end
--		end
--		if ShowItem and ItemCount and ItemCount > 0 then
--			if not added[ItemId] then
--				
--				added[ItemId] = true
--			
--				--create labels for replacements
--				ItemName[NumItems] = ItemId 
--				ItemTextureName = ItemGetName(ItemId)
--				ItemTexture = "Hud/Items/Item_"..ItemTextureName..".tga"
--				btn = btn.."@B[BTN"..NumItems..",,%"..2+NumItems.."l,"..ItemTexture.."]"
--				ItemLabel[NumItems] = ""..ItemGetLabel(ItemName[NumItems],true)
--				NumItems = NumItems + 1
--			end
--		end
--		
--	end
--	SetData("NumItems",NumItems)
--	
--	local		SelectionDone = false
--	local 	Result
--	local 	ToUse = 0
--	if Slots > 0 then
--		for i=0,CartSlots-1 do
--			Result = InitData("@P"..btn,
--					ms_thomasf_AIDecide,  --AIFunc
--					"Slot %1n: Beladen",
--					"",i+1,
--					ItemLabel[0],ItemLabel[1],
--					ItemLabel[2],ItemLabel[3],
--					ItemLabel[4],ItemLabel[5],
--					ItemLabel[6],ItemLabel[7],
--					ItemLabel[8],ItemLabel[9],
--					ItemLabel[10],ItemLabel[11],
--					ItemLabel[12],ItemLabel[13],
--					ItemLabel[14],ItemLabel[15])
--			
--			if Result == "C" then
--				break
--			end
--						
--			local ItemIndex
--			if Result == "BTN0" then
--				ItemIndex = 0
--			elseif Result == "BTN1" then
--				ItemIndex = 1
--			elseif Result == "BTN2" then
--				ItemIndex = 2
--			elseif Result == "BTN3" then
--				ItemIndex = 3
--			elseif Result == "BTN4" then
--				ItemIndex = 4
--			elseif Result == "BTN5" then
--				ItemIndex = 5
--			elseif Result == "BTN6" then
--				ItemIndex = 6
--			elseif Result == "BTN7" then
--				ItemIndex = 7
--			elseif Result == "BTN8" then
--				ItemIndex = 8
--			elseif Result == "BTN9" then
--				ItemIndex = 9
--			elseif Result == "BTN10" then
--				ItemIndex = 10
--			elseif Result == "BTN11" then
--				ItemIndex = 11
--			elseif Result == "BTN12" then
--				ItemIndex = 12
--			elseif Result == "BTN13" then
--				ItemIndex = 13
--			elseif Result == "BTN14" then
--				ItemIndex = 14
--			elseif Result == "BTN15" then
--				ItemIndex = 15
--			end
--			
--			local CargoCntBtn = 	"@B[A,,"..CartSlotSize * 0.25.." Einheiten,Hud/Buttons/btn_Money_Small.tga]"..
--						"@B[B,,"..CartSlotSize * 0.5.." Einheiten,Hud/Buttons/btn_Money_SmallLarge.tga]"..
--						"@B[D,,"..CartSlotSize * 0.75.." Einheiten,Hud/Buttons/btn_Money_Medium.tga]"..
--						"@B[E,,"..CartSlotSize.." Einheiten,Hud/Buttons/btn_Money_MediumLarge.tga]"
--					
--			local CargoCntResult = InitData("@P"..
--				CargoCntBtn,
--				ms_sendcartandunload_AIInit,
--				"Slot %1n: Menge",
--				"",i+1)
--				
--			if CargoCntResult == "C" then
--				break
--			end
--			
--			local CargoCnt = 0
--			if CargoCntResult == "A" then
--				CargoCnt = CartSlotSize * 0.25
--			elseif CargoCntResult == "B" then
--				CargoCnt = CartSlotSize * 0.5
--			elseif CargoCntResult == "D" then
--				CargoCnt = CartSlotSize * 0.75
--			elseif CargoCntResult == "E" then
--				CargoCnt = CartSlotSize
--			end
--			
--			ToUse = ToUse + 1
--			SelectionDone = true
--			SetData("CartCargoCntSlot"..i,CargoCnt)
--			SetData("CartSlot"..i,ItemIndex)
--		end
--		
--	else
--		MsgQuick("","@L_REPLACEMENTS_FAILURE_MSG_NOITEM_+0")
--		StopMeasure()
--	end
--	if SelectionDone == false then
--		StopMeasure()
--	end
--	
--	Result = InitData("@P"..
--			"@B[A,,Route aktivieren,Hud/Buttons/UnloadAndSendBack.tga]",
--			ms_sendcartandunload_AIInit,
--			"@L_GENERAL_MEASURES_SENDCARTANDUNLOAD_TEXT_+0",
--			"")
--	
--	
--	
--	if Result == "C" then
--		StopMeasure()
--	end
--	
--	if ToUse == 0 then
--		StopMeasure()
--	end
--	
--	--start the trade route
--	while true do
--		SetData("WaitForGoods",1)
--		SetData("WaitForUnload",1)
--			
--		if not f_MoveTo("","Source") then
--			StopMeasure()
--		end
--		
--		local	Error
--		local	ItemTransfered
--		local	Amount = 0
--		local	TotalCargo = 0
--		
--		--load items from source to cart
--		while GetData("WaitForGoods") == 1 do
--			--transfer from source to cart
--			if not AliasExists("Source") then
--				StopMeasure()
--			end
--			for i=0, ToUse-1 do
--				Error, ItemTransfered = Transfer("","",INVENTORY_STD,"Source",INVENTORY_STD,ItemName[GetData("CartSlot"..i)],GetData("CartCargoCntSlot"..i))
--				Amount = Amount + ItemTransfered
--				Sleep(0.7)
--			end
--			if Amount == 0 then
--				SetData("WaitForGoods",1)
--			else
--				SetData("WaitForGoods",0)
--			end
--			Sleep(2)
--		end
--		
--		TotalCargo = Amount
--		Amount = 0
--		
--		--cargo full, move to target
--		if not f_MoveTo("","Target") then
--			StopMeasure()
--		end
--	
--		--unload items from cart to target
--		--while GetData("WaitForUnload") == 1 do
--			--transfer from source to cart
--			if not AliasExists("Target") then
--				StopMeasure()
--			end
--			for i=0, ToUse-1 do
--				Error, ItemTransfered = Transfer("","Target",INVENTORY_STD,"",INVENTORY_STD,ItemName[GetData("CartSlot"..i)],CartSlotSize)
--				Amount = Amount + ItemTransfered
--				Sleep(0.7)
--			end
--			
--			--wait till complete unload?
----			if Amount == TotalCargo then
----				SetData("WaitForUnload",0)
----			else
----				SetData("WaitForUnload",1)
----			end
--			
--			Sleep(2)
--		--end
--
--	--end of transfer while
--	end
	


end

function AIDecide()
	--NumItems = GetData("NumItems")
	return "A"
end

function AIInit()
	
end

function CleanUp()

	
end

