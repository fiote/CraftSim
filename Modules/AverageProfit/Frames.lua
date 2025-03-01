AddonName, CraftSim = ...

CraftSim.AVERAGEPROFIT.FRAMES = {}

local print = CraftSim.UTIL:SetDebugPrint(CraftSim.CONST.DEBUG_IDS.AVERAGE_PROFIT)

function CraftSim.AVERAGEPROFIT.FRAMES:Init()
    local sizeX = 320
    local sizeY = 120
    local frameNonWorkOrder = CraftSim.GGUI.Frame({
        parent=ProfessionsFrame.CraftingPage.SchematicForm, 
        anchorParent=ProfessionsFrame.CraftingPage.SchematicForm,
        anchorA="BOTTOMRIGHT",anchorB="BOTTOMRIGHT",
        sizeX=sizeX,sizeY=sizeY,
        frameID=CraftSim.CONST.FRAMES.STAT_WEIGHTS, 
        title="CraftSim Average Profit",
        collapseable=true,
        closeable=true,
        moveable=true,
        backdropOptions=CraftSim.CONST.DEFAULT_BACKDROP_OPTIONS,
        onCloseCallback=CraftSim.FRAME:HandleModuleClose("modulesStatWeights"),
    })

    local frameWorkOrder = CraftSim.GGUI.Frame({
        parent=ProfessionsFrame.OrdersPage.OrderView.OrderDetails, 
        anchorParent=ProfessionsFrame.OrdersPage.OrderView.OrderDetails,
        anchorA="BOTTOMRIGHT",anchorB="BOTTOMRIGHT",
        sizeX=sizeX,sizeY=sizeY,
        frameID=CraftSim.CONST.FRAMES.STAT_WEIGHTS_WORK_ORDER, 
        title="CraftSim Average Profit " .. CraftSim.GUTIL:ColorizeText("WO", CraftSim.GUTIL.COLORS.GREY),
        collapseable=true,
        closeable=true,
        moveable=true,
        backdropOptions=CraftSim.CONST.DEFAULT_BACKDROP_OPTIONS,
        onCloseCallback=CraftSim.FRAME:HandleModuleClose("modulesStatWeights"),
    })

    local function createContent(frame, profitDetailsFrameID, statisticsFrameID)
        frame.content.breakdownButton = CraftSim.GGUI.Button({
            parent=frame.content,anchorParent=frame.title.frame,anchorA="TOP",anchorB="TOP",
            offsetX= -60, offsetY=-15,
            label="Show Explanation", sizeX=15,sizeY=20,adjustWidth=true,
            clickCallback=function ()
                local profitDetailsFrame = CraftSim.FRAME:GetFrame(profitDetailsFrameID) 
                local isVisible = profitDetailsFrame:IsVisible()
                CraftSim.FRAME:ToggleFrame(profitDetailsFrame, not isVisible)
                frame.content.breakdownButton:SetText(isVisible and "Show Explanation" or not isVisible and "Hide Explanation")
            end
        })

        frame.content.statisticsButton = CraftSim.GGUI.Button({
            label="Show Statistics", parent=frame.content,anchorParent=frame.content.breakdownButton.frame,anchorA="LEFT",anchorB="RIGHT",offsetX=1,sizeX=15,sizeY=20,
            adjustWidth=true,
            clickCallback=function() 
                local statisticsFrame = CraftSim.GGUI:GetFrame(statisticsFrameID)
                CraftSim.FRAME:ToggleFrame(statisticsFrame, not statisticsFrame:IsVisible())
            end
        })
        

        frame.content.statText = frame.content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        frame.content.statText:SetPoint("LEFT", frame.content, "LEFT", 15, -20)

        frame.content.valueText = frame.content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        frame.content.valueText:SetPoint("RIGHT", frame.content, "RIGHT", -15, -20)
        frame:Hide()
    end

    createContent(frameNonWorkOrder, CraftSim.CONST.FRAMES.PROFIT_DETAILS, CraftSim.CONST.FRAMES.STATISTICS)
    createContent(frameWorkOrder, CraftSim.CONST.FRAMES.PROFIT_DETAILS_WORK_ORDER, CraftSim.CONST.FRAMES.STATISTICS_WORKORDER)

    
end

---@param statWeights CraftSim.Statweights
---@param exportMode number
function CraftSim.AVERAGEPROFIT.FRAMES:UpdateDisplay(statWeights, craftingCosts, exportMode)
    local statweightFrame = nil
    if exportMode == CraftSim.CONST.EXPORT_MODE.WORK_ORDER then
        statweightFrame = CraftSim.GGUI:GetFrame(CraftSim.CONST.FRAMES.STAT_WEIGHTS_WORK_ORDER)
    else
        statweightFrame = CraftSim.GGUI:GetFrame(CraftSim.CONST.FRAMES.STAT_WEIGHTS)
    end
    if statWeights == nil then
        statweightFrame.content.statText:SetText("")
        statweightFrame.content.valueText:SetText("")
    else
        local statText = ""
        local valueText = ""

        if statWeights.averageProfit then
            statText = statText .. "Ø Profit / Craft:" .. "\n"
            local relativeValue = CraftSimOptions.showProfitPercentage and craftingCosts or nil
            valueText = valueText .. CraftSim.GUTIL:FormatMoney(statWeights.averageProfit, true, relativeValue) .. "\n"
        end
        if statWeights.inspirationWeight then
            statText = statText .. "Inspiration:" .. "\n"
            valueText = valueText .. CraftSim.GUTIL:FormatMoney(statWeights.inspirationWeight) .. "\n"
        end
        if statWeights.multicraftWeight then
            statText = statText .. "Multicraft:" .. "\n"
            valueText = valueText .. CraftSim.GUTIL:FormatMoney(statWeights.multicraftWeight) .. "\n"
        end
        if statWeights.resourcefulnessWeight then
            statText = statText .. "Resourcefulness:"
            valueText = valueText .. CraftSim.GUTIL:FormatMoney(statWeights.resourcefulnessWeight)
        end
        statweightFrame.content.statText:SetText(statText)
        statweightFrame.content.valueText:SetText(valueText)
    end
end

function CraftSim.AVERAGEPROFIT.FRAMES:InitExplanation()
    
    local frameNO_WO = CraftSim.FRAME:CreateCraftSimFrame(
        "CraftSimProfitDetailsFrame", 
        "CraftSim Average Profit Explanation", 
        CraftSim.GGUI:GetFrame(CraftSim.CONST.FRAMES.STAT_WEIGHTS).frame,
        UIParent, 
        "CENTER", 
        "CENTER", 
        0, 
        0, 
        1000, 
        600,
        CraftSim.CONST.FRAMES.PROFIT_DETAILS, false, true, "DIALOG")

    local frameWO = CraftSim.FRAME:CreateCraftSimFrame(
        "CraftSimProfitDetailsWOFrame", 
        "CraftSim Average Profit Explanation", 
        CraftSim.GGUI:GetFrame(CraftSim.CONST.FRAMES.STAT_WEIGHTS_WORK_ORDER).frame,
        UIParent, 
        "CENTER", 
        "CENTER", 
        0, 
        0, 
        1000, 
        600,
        CraftSim.CONST.FRAMES.PROFIT_DETAILS_WORK_ORDER, false, true, "DIALOG")


    local function createContent(frame, statweightFrameID)
        frameNO_WO.closeButton:HookScript("OnClick", function(self) 
            CraftSim.GGUI:GetFrame(statweightFrameID).content.breakdownButton:SetText("Show Explanation")
        end)

        frame:Hide()
        frame.content.profitExplanationTab = CraftSim.FRAME:CreateTab("Basic Profit Calculation", frame.content, frame.title, "TOP", "BOTTOM", -50, -15, true, 900, 500, frame.content, frame.title, 0, -50)
        frame.content.hsvExplanationTab = CraftSim.FRAME:CreateTab("HSV Consideration", frame.content, frame.content.profitExplanationTab, "LEFT", "RIGHT", 0, 0, true, 900, 500, frame.content, frame.title, 0, -50)
        frame.content.profitExplanationTab.content.description = CraftSim.FRAME:CreateText(CraftSim.LOCAL:GetText(CraftSim.CONST.TEXT.PROFIT_EXPLANATION), 
        frame.content.profitExplanationTab.content, frame.content.profitExplanationTab.content, "TOPLEFT", "TOPLEFT", 0, -20, nil, nil, {type="H", value="LEFT"})
        frame.content.hsvExplanationTab.content.description = CraftSim.FRAME:CreateText(CraftSim.LOCAL:GetText(CraftSim.CONST.TEXT.PROFIT_EXPLANATION_HSV), 
        frame.content.hsvExplanationTab.content, frame.content.hsvExplanationTab.content, "TOPLEFT", "TOPLEFT", 0, -20, nil, nil, {type="H", value="LEFT"})

        CraftSim.FRAME:InitTabSystem({frame.content.profitExplanationTab, frame.content.hsvExplanationTab})
    end

    createContent(frameNO_WO, CraftSim.CONST.FRAMES.STAT_WEIGHTS)
    createContent(frameWO, CraftSim.CONST.FRAMES.STAT_WEIGHTS_WORK_ORDER)
end