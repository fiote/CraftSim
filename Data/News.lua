AddonName, CraftSim = ...

CraftSim.NEWS = {}

function CraftSim.NEWS:GET_NEWS()
    -- minimize names to make manual formatting easier :p
    local f = CraftSim.UTIL:GetFormatter()
    local function newP(v) return f.l("\n\n                                   --- Version " .. v .. " ---\n") end

    return 
        f.bb("                   Hello and thank you for using CraftSim!\n") .. 
        f.bb("                                 ( You are awesome! )") ..
        newP("8.0.0") ..
        f.P .. "New Module: " .. f.g("Craft Data") ..
        f.P .. f.g("All Item Icons") .. " can now be " .. f.bb("shift-clicked") .. " to insert the" ..
        f.a .. "respective item link into the active chat" ..
        f.s .. "Module windows now stay anchored to the ProfessionsFrame" ..
        f.a .. "and position/collapsed status is saved and restored over sessions" ..
        f.s .. "Renamed Modules:" ..
        f.a .. "Cost Overview -> " .. f.g("Price Details") ..
        f.s .. f.l("API Update: ") .. "RecipeData.ResultData" ..
        f.a .. "now includes a craft chance per quality table and" ..
        f.a .. "an expected crafts per quality table" .. 
        newP("7.8.2") ..
        f.p .. "Backend Changes" ..
        f.p .. "Added an exception for " .. f.bb("Sturdy Expedition Shovel") ..
        f.a .. "because due to a bug on blizzards side the api" ..
        f.a .. "tells us it produces 2 instead of 1 items per craft" ..
        newP("7.8.1") ..
        f.p .. f.bb("Salvage Recipes ") .. "are now again showing" ..
        f.a .. "a minus profit based on crafting cost alone." ..
        f.a .. "At one point a profit forecast for such recipes will" .. 
        f.a .. "be implemented but this will take a while!" ..
        f.p .. "Fixed the " .. f.bb("Price Override ") .. "currency input" ..
        f.a .. "validation being bugged due to GGUI changes" ..
        newP("7.8.0") ..
        f.s .. f.r("Warning: ") .. "Collapsed status of frames is" .. 
        f.a .. "currently not saved and restored on login." ..
        f.a .. "This is due to preparation for a rework of the frame backend" .. 
        f.p .. "Fixed a bug when trying to collapse frames" ..
        f.p .. "Many backend changes" ..
        newP("7.7.1") ..
        f.s .. "Started to extract GUI and UTIL methods into separate libraries" ..
        f.a .. "to make it easier for me to create other addons in the future" ..
        f.p .. "Fixed " .. f.bb("Inspiration Skill") .. " consideration" ..
        f.p .. "Some fixes for " .. f.bb("Alchemy Specialization Info") .. " for transmutation" ..
        f.p .. f.bb("Material Optimization Module") .. " now considers" .. 
        f.a .. "up to 6 different reagents and shows item tooltips" ..
        f.p .. "Fixes to " .. f.bb("Simulation Mode") .. " for " .. f.bb("Cooking") ..
        f.p .. f.bb("Work Order Profits") .. " are now correctly only" ..
        f.a .. "considering comission and consortium cut" .. 
        f.p .. ".1 Hotfix: Inscription Inks Multicraft Bonus" ..
        newP("7.6.0") ..
        f.p .. "Started mapping the " .. f.bb("Specialization Info") .. " for rest professions" ..
        f.p .. "Partially mapped professions now show but with warning" ..
        f.p .. "Fixed CraftResults subtracting multicraft quantity twice" .. 
        f.a .. "(display only)" ..
        newP("7.5.0") ..
        f.P .. f.bb("Price Override") .. " Module reworked to be more compact and handy" ..
        f.a .. "Also allows for more precise prices now" ..
        f.a .. f.r("WARNING:") .. " all your current overrides have been reset" ..
        f.p .. "Fixed old world professions trying to parse specialization data" ..
        newP("7.4.1") ..
        f.p .. "Added mappings for all old world enchants" ..
        f.a .. "Big thanks goes to the discontinued addon " .. f.bb("OneClickEnchant") ..
        f.a .. "that had still all this data mapped"
end