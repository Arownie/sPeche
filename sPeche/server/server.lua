ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("sPeche:AchatsItems")
AddEventHandler("sPeche:AchatsItems", function(item, name, price, types)
    if source then 
        local xPlayer = ESX.GetPlayerFromId(source)
        local item_in_inventory = xPlayer.getInventoryItem(item).count

        if xPlayer.getMoney() <= price then
            TriggerClientEvent("esx:showNotification", source, "~r~Vous n'avez pas assez d'argent sur vous") 

        elseif item == "fishingrod" and item_in_inventory > 0 then
            TriggerClientEvent("esx:showNotification", source, "~r~Vous avez déjà une "..name.." sur vous !") 

        else
            TriggerClientEvent("esx:showNotification", source, "Vous venez d'acheter ~b~1x "..name.."~s~ pour ~r~"..ESX.Math.GroupDigits(price).."$~s~ !")
            xPlayer.removeMoney(price)
            xPlayer.addInventoryItem(item, 1)

            if types then 
                TriggerEvent('esx_addonaccount:getSharedAccount', 'society_gouvernement', function(account)
                    societyAccount = account
                end) 
                societyAccount.addMoney(price) 
            end
        end       
    end
end)


RegisterServerEvent("sPeche:LouerBateau")
AddEventHandler("sPeche:LouerBateau", function(label, price)
    if source then 
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.getMoney() <= price then
            TriggerClientEvent("esx:showNotification", source, "~r~Vous n'avez pas assez d'argent sur vous") 

        else
            TriggerClientEvent("esx:showNotification", source, "Vous venez de louer ~b~1x "..label.."~s~ pour ~r~"..ESX.Math.GroupDigits(price).."$~s~ !")
            xPlayer.removeMoney(price)

            TriggerEvent('esx_addonaccount:getSharedAccount', 'society_gouvernement', function(account)
                societyAccount = account
            end) 
            societyAccount.addMoney(price)
        end       
    end
end)

RegisterServerEvent("sPeche:RetourLocation")
AddEventHandler("sPeche:RetourLocation", function(price_caution)

    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addMoney(price_caution)
    TriggerClientEvent("esx:showNotification", source, "Vous venez d'être rembourser de ~g~"..ESX.Math.GroupDigits(price_caution).."$ !") 

end)


RegisterServerEvent("sPeche:VentePoissons")
AddEventHandler("sPeche:VentePoissons", function(item, name, price)
    if source then 
        local xPlayer = ESX.GetPlayerFromId(source)
        local item_in_inventory = xPlayer.getInventoryItem(item).count
        local price_total = price * item_in_inventory

        if item_in_inventory > 0 then
            xPlayer.removeInventoryItem(item, item_in_inventory) 
            xPlayer.addMoney(price_total)
            TriggerClientEvent("esx:showNotification", source, "Vous venez de vendre "..item_in_inventory.." "..name.." pour une somme de ~g~"..ESX.Math.GroupDigits(price_total).."$ !") 
        else   
            TriggerClientEvent("esx:showNotification", source, "~r~Vous n'avez rien à vendre !") 
        end
    end
end)
      
RegisterServerEvent("sPeche:BateauDetruit")
AddEventHandler("sPeche:BateauDetruit", function(price)
    if source then 
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.removeMoney(price)
        TriggerClientEvent("esx:showNotification", source, "Votre bateau vient d'être détruit, pour cela vous venez de payer une caution de ~r~"..ESX.Math.GroupDigits(price).."$ !") 
    
    end
end)
     

RegisterServerEvent("sPeche:RandomPoisson")
AddEventHandler("sPeche:RandomPoisson", function(item, count, name)
    
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerClientEvent("esx:showNotification", source, "Vous venez de pêcher x1 ~g~"..name.." !")
    xPlayer.addInventoryItem(item, count)

end)

RegisterServerEvent("sPeche:UtilisationAppat")
AddEventHandler("sPeche:UtilisationAppat", function(xfishbait, number)
    
    fishbait = xfishbait
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem(fishbait, number)

end)


ESX.RegisterServerCallback('sPeche:AssezCAP', function(source, cb)

	local xPlayer = ESX.GetPlayerFromId(source)
	local result = xPlayer.getInventoryItem('fishingrod').count
	if result >= 1 then 
		cb(true)
	else 
	 	cb(false)
	end
end)

ESX.RegisterServerCallback('sPeche:AssezAppats', function(source, cb)

	local xPlayer = ESX.GetPlayerFromId(source)
	local result = xPlayer.getInventoryItem('fishbait').count
	if result >= 1 then 
		cb(true)
	else 
	 	cb(false)
	end
end)


