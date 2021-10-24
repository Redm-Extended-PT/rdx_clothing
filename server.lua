RDX = nil

TriggerEvent('rdx:getSharedObject', function(obj) RDX = obj end)

RegisterServerEvent('rdx_clothing:Save')
AddEventHandler('rdx_clothing:Save', function(clothes, price, saveOutfit , name, cb)
    local _clothes = clothes
    local _price = price
	local _name = name
    local decode = json.decode(clothes)
	local xPlayer = RDX.GetPlayerFromId(source)
    local ukko = RDX.GetPlayerFromId(source)
    local identifier = ukko.getIdentifier()
        local currentMoney = xPlayer.getMoney()
        print (currentMoney)
        if currentMoney >= currentMoney then
           xPlayer.removeMoney(_price) --user.removeMoney(_price)
            TriggerEvent("rdx_clothing:retrieveClothes", identifier, function(call)

                    if call then

                        MySQL.Async.execute("UPDATE clothes SET `clothes`='" .. _clothes .. "' WHERE `identifier`=@identifier", {identifier = identifier}, function(done)
                            end)
                    else

                        MySQL.Async.execute('INSERT INTO clothes (`identifier`, `clothes`) VALUES (@identifier, @clothes);',
                            {
                                identifier = identifier,
                                clothes = _clothes
                            }, function(rowsChanged)
                            end)
                    end
            end)
		if saveOutfit then	
		
		TriggerEvent("rdx_clothing:retrieveOutfits", identifier, _name, function(call)

                    if call then 

                        MySQL.Async.execute("UPDATE outfits SET `clothes`='" .. _clothes .. "' WHERE `identifier`=@identifier AND `name`=@name", {identifier = identifier, name = name}, function(done)
                            end)
                    else

                        MySQL.Async.execute('INSERT INTO outfits (`identifier`, `clothes`, `name`) VALUES (@identifier, @clothes , @name);',
                            {
                                identifier = identifier,
                                clothes = _clothes,
								name = _name
                            }, function(rowsChanged)
                            end)
                        end
                end)
            end
            else
              TriggerClientEvent("rdx_clothing:LoadSkinClient" , _source)
            end
        end)



RegisterServerEvent('rdx_clothing:loadClothes')
AddEventHandler('rdx_clothing:loadClothes', function(value)
    local _value = value
    local _source = source
    local skin = nil
    local clothes = nil
    local ubranie2 = 0
    local ukko = RDX.GetPlayerFromId(source)
    local identifier = ukko.getIdentifier()
        print("skinidata")
        MySQL.Async.fetchAll('SELECT * FROM skins WHERE `identifier`=@identifier;', {identifier = identifier}, function(skins)
            if skins[1]then
                skin = skins[1].skin
            else
                skin = nil
            end
            print("clothe data")
            MySQL.Async.fetchAll('SELECT * FROM clothes WHERE `identifier`=@identifier;', {identifier = identifier}, function(clothes)
                if clothes[1] then
                    clothes = clothes[1].clothes
                else
                    local elementy = {
                        ["hat"] = 1,
                        ["shirt"] = 1,
                        ["vest"] = 1,
                        ["pants"] = 1,
                        ["mask"] = 1,
                        ["boots"] =1,
                        ["skirt"] = 1,
                        ["coat"] = 1,
                        ["rekawiczki"] = 1,
                        ["bandana"] = 1,					
						["gunbelts"] =1,
                        ["belts"] = 1,
                        ["beltbuckle"] = 1,
                        ["offhand"] = 1,
                        ["neckties"] = 1,
						["suspenders"] = 1,
                        ["spurs"] = 1,
						["poncho"] = 1,
                        ["eyewear"] = 1,



                    }
                    local json = json.encode(elementy)
                    clothes = json
                end

                if clothes ~= nil and skin ~= nil then
                    if _value == 1 then
                        TriggerClientEvent("rdx_clothing:load", _source, skin, clothes)
                    elseif _value == 2 then
                        TriggerClientEvent("rdx_clothing:sex", _source, skin, clothes)
			
                    end
                else
                    TriggerClientEvent("rdx_clothing:load_def" , _source)
                end
            end)
             end)
        end)


RegisterServerEvent('rdx_clothing:SetOutfits')
AddEventHandler('rdx_clothing:SetOutfits', function(name)
    local _source = source
	local _name = name
     TriggerEvent('rdx:getPlayerFromId', source, function(user)
        local identifier = user.getIdentifier()
    TriggerEvent('rdx_clothing:retrieveOutfits',identifier,_name, function(call)
        if call then
		print(call)
          MySQL.Async.execute("UPDATE clothes SET `clothes`='" .. call .. "' WHERE `identifier`=@identifier", {identifier = identifier}, function(done)
             end)
			TriggerClientEvent("rdx_skin:FastLoad" , _source)
         end
    end)
	 end)
end)
RegisterServerEvent('rdx_clothing:DeleteOutfit')
AddEventHandler('rdx_clothing:DeleteOutfit', function(name)
    local _source = source
	local _name = name
     TriggerEvent('rdx:getPlayerFromId', _source, function(user)
        local identifier = user.getIdentifier()
 MySQL.Async.fetchAll('DELETE FROM outfits  WHERE `identifier`=@identifier AND`name`=@name;', {identifier = identifier,  name = _name}, function(result)
            end)        
	 end)
end)

RegisterServerEvent('rdx_clothing:getOutfits')
AddEventHandler('rdx_clothing:getOutfits', function()
    local _source = source
     TriggerEvent('rdx:getPlayerFromId', source, function(user)
        local identifier = user.getIdentifier()
    TriggerEvent('rdx_db:getOutfits',identifier, function(call)
        if call then
            TriggerClientEvent('rdx_clothing:putInTable', _source, call)
         end
		end)
	 end)
end)

AddEventHandler('rdx_db:getOutfits', function(identifier,callback)
    local Callback = callback
	 MySQL.Async.fetchAll('SELECT * FROM outfits WHERE `identifier`=@identifier;', {identifier = identifier}, function(outfits)
        if outfits[1] then
            Callback(outfits)
        else
            Callback(false)
        end
    end)
end)

AddEventHandler('rdx_clothing:retrieveClothes', function(identifier, callback)
    local Callback = callback
    MySQL.Async.fetchAll('SELECT * FROM clothes WHERE `identifier`=@identifier;', {identifier = identifier,}, function(clothes)
        if clothes[1] then
            Callback(clothes[1])
        else
            Callback(false)
        end
    end)
end)

AddEventHandler('rdx_clothing:retrieveOutfits', function(identifier, name, callback)
    local Callback = callback
    MySQL.Async.fetchAll('SELECT * FROM outfits WHERE `identifier`=@identifier AND `name`=@name;', {identifier = identifier, name = name}, function(clothes)
        if clothes[1] then
            Callback(clothes[1]["clothes"])
        else
            Callback(false)
        end
    end)
end)

            
RegisterServerEvent("rdx_clothing:deleteClothes")
AddEventHandler("rdx_clothing:deleteClothes", function(Callback) 
    local _source = source
    local id
    for k,v in ipairs(GetPlayerIdentifiers(_source))do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            id = v
            break
        end
    end
	
  local Callback = callback
	MySQL.Async.fetchAll('DELETE FROM clothes WHERE `identifier`=@identifier;', {identifier = id}, function(result)
		if result then
		else
		end
	end)
	MySQL.Async.fetchAll('DELETE FROM outfits WHERE `identifier`=@identifier;', {identifier = id}, function(result)
		if result then
		else
		end
	end)
end)
