-------------------------------------------------------------------------------
----
----	OVERVIEW "as_UseMediPackBox1"
----
-------------------------------------------------------------------------------

function Run()

	local random = Rand(3) + 1
	local Object = "MediPackBox1"
	local RawMaterial = "MediPack"
	local ObjectLabel = ItemGetLabel(Object, true)
	local choice

	if AiDriven then
		choice = 0
	else
		choice = MsgBox("", "", "@P@B[0,@LJa_+0]"..
							"@B[1,@LNein_+0]",
							"@L_UNPACK_RAWMATERIAL_HEAD_+0",
							"@L_UNPACK_RAWMATERIAL_TEXT_+0",
							ObjectLabel, GetID(""))
	end

	if choice == 0 then
		RemoveItems("",Object,1)
		if GetRemainingInventorySpace("",RawMaterial) < random then
			MsgQuick("", "@L_UNPACK_RAWMATERIAL_FAILURE_+0", ObjectLabel)
			AddItems("",Object,1)
			StopMeasure()
		else
			AddItems("",RawMaterial,random)
		end
	end
end


function CleanUp()
end
