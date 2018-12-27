--
-- FishInfo2 (v10)
-- based on Impp's Fishing Info 1.2
--
-- by Bastian Pflieger <wbb1977@gmail.com>
--
-- Created: July 4, 2007
--
-- supports "myAddOns" up to v2.6: https://wow.curseforge.com/projects/my-add-ons
-- supports "Titan Panel" up to 2.20.0.11200: https://wow.curseforge.com/projects/titan-panel

-- December 27, 2018:
-- clean up for private server WoW Vanialla 1.12

-- Changes since testversion8x:
--   -updated toc file for 2.1
--   - myaddons support moved to toc file
--
-- Changes since testversion7:
--   - updated toc file for 1.7 / 1.10
--   - myaddon code corrected
--
-- Changes since testversion6:
--
-- August 25:
--   - Zone summary display improved, more compact if same fish catched in multiple subzones.
--   - Click fish icon to initiate a search for that fish.
--
-- Changes since testversion5:
--
-- July 23:
--   - Added french translation (contributed by Corwin Whitehorn).
--
-- July 21:
--   - Added tooltips
--
-- Changes since testversion4:
--
-- July 16:
--   - Added myAddOns 2.0 support
--
-- July 14:
--   - Added option to sort search results by percent.
--
-- Changes since testversion3:
--
-- July 12:
--   - Added pseudo sub zone "All fish of this zone". It is automatically
--     selected at the "zone" click event.
--
-- Changes since testversion2:
--
-- July 10:
--   - GUI tweaking
--   - Better chat command function added.
--
-- July 09:
--   - Modified <OnShow> behaviour, preselect only if it is first show after a subzone change.
--   - Added chat paramter "nopreselect" to disable preselection, eg "/fi2 nopreselect".
--
-- July 08:
--   - Completed code to handle multiple fish databases (from other characters).
--   - Changed framestrata to HIGH.
--   - Modified Titan Panel support (better tooltip, removed button text function).
--   - On first <OnShow> event, preselect current zone / subzone.
--
-- July 07:
--   - Import function modified for Emerald-UI.
--   - Added checkbox "Take the data from my other characters into account".
--
-- Changes since testversion1:
--
-- July 05:
--   - Added subzone dropdown list.
--     Database format changed to reflect this, renamed database variable to avoid conflict with testversion1.
--     Data from testversion1 thereforce lost.
--   - Added Titan Panel right-click menu.
--   - Two lines to display search criteria.
--
-- July 04:
--   - Fixed minor error in myAddons support.
--   - Added round function for percent display.
--

FISHINFO2_SCROLLHEIGHT = 40;
FISHINFO2_TITAN_ID = "FishInfo2";

local db;
local dbUser;
local dbOthers;
local results = {};
local linkCache = {};

-- store user input for this session
local lastSearchFunc = nil;
local lastSortFunc = nil;
local lastQuery = "";
local selectedZone = nil;
local selectedSubZone = nil;
local isFirstView = true;
local isEnableFirstViewOnHide = false;

------------------------------------------------------------------------------
-- Core                                                                     --
------------------------------------------------------------------------------
function FishInfo2_OnLoad()
  this:RegisterEvent("VARIABLES_LOADED");
  this:RegisterEvent("LOOT_OPENED");
  this:RegisterEvent("ZONE_CHANGED");
  this:RegisterEvent("ZONE_CHANGED_NEW_AREA");

  SlashCmdList["FISHINFO2"] = FishInfo2_ChatCommand;
  SLASH_FISHINFO21 = "/fi2";
  SLASH_FISHINFO22 = "/fishinfo2";

  table.insert(UISpecialFrames, "FishInfo2Frame");

  FishInfo2DataSub = {};
end

function FishInfo2_Setup()
  local databaseName = UnitName("player") .. "|" .. GetCVar("realmName"); --"AllCharacters";
  local userDatabaseName = databaseName .. "|User";

  if FishInfo2DataSub[databaseName] == nil then
    FishInfo2DataSub[databaseName] = {};
  end
  if FishInfo2DataSub[userDatabaseName] == nil then
    FishInfo2DataSub[userDatabaseName] = {};
  end

  db = FishInfo2DataSub[databaseName];
  dbUser = FishInfo2DataSub[userDatabaseName];
  dbOthers = FishInfo2_CollectDatabasesFromOtherCharacters(databaseName);

  -- Execute import function at first startup.
  --if dbUser["firstTime"] == nil then
  --  FishInfo2_ImportImpp();
  --  dbUser["firstTime"] = false;
  --end

  -- Default is to include data from other characters.
  if dbUser["IsIncludeOthers"] == nil then
    dbUser["IsIncludeOthers"] = true;
  end
  if dbUser["IsTooltipEnabled"] == nil then
    dbUser["IsTooltipEnabled"] = true;
  end
end

function FishInfo2_OnEvent(event)
  if event == "VARIABLES_LOADED"  then
    FishInfo2_Setup();
    FishInfo2_Message(FISHINFO2_VERSION .. FISHINFO2_LOADED);
  elseif event == "LOOT_OPENED" and IsFishingLoot() then
    local t1, t2, t3 = GetLootSlotLink(1);
    FishInfo2_UpdateDatabase(true, GetZoneText(), GetMinimapZoneText(), GetLootSlotLink(1), GetLootSlotInfo(1));
    if FishInfo2Frame:IsVisible() then
      FishInfo2_UpdateGui();
    end
  elseif event == "ZONE_CHANGED" or event == "ZONE_CHANGED_NEW_AREA" then
    if FishInfo2Frame:IsVisible() then
      -- preselect current zone/subzone not immediately, wait until window is reopened.
      isEnableFirstViewOnHide = true;
    else
      isFirstView = true;
    end
  end
end

function FishInfo2_UpdateDatabase(showMsg, zone, subZone, link, texture, name, quantity, rarity)
  if db[name] == nil then
    local fishdata = { texture = texture, rarity = rarity, zones = {} };
    db[name] = fishdata;
  end

  if db[name]["zones"][zone] == nil then
    db[name]["zones"][zone] = {}
  end

  if db[name]["zones"][zone][subZone] == nil then
    if showMsg then
      FishInfo2_Message(string.format(FISHINFO2_DBUPDATE, name, zone, subZone));
    end
    db[name]["zones"][zone][subZone] = 0;
  end

  db[name]["zones"][zone][subZone] = db[name]["zones"][zone][subZone] + quantity;

  -- Add optional gametooltip link, checked here so that already known fish gets updated.
  if db[name]["link"] == nil and link then
    db[name]["link"] = string.sub(link, string.find(link, "item:%d*:%d*:%d*:%d*"));
  end
end

function FishInfo2_ChatCommand(msg)
  msg = string.lower(msg);
  if msg == "help" or msg == "hilfe" then
    FishInfo2_Message(FISHINFO2_CHATHELP1);
    FishInfo2_Message(FISHINFO2_CHATHELP2);
    FishInfo2_Message(FISHINFO2_CHATHELP3);
    FishInfo2_Message(FISHINFO2_TOOLTIP_STATUS[dbUser["IsTooltipEnabled"]]);
  elseif msg == "nopreselect" then
    isFirstView = false;
    FishInfo2Frame:Show();
  elseif msg == "tooltip on" or msg == "tooltip off" then
    dbUser["IsTooltipEnabled"] =  msg == "tooltip on";
    FishInfo2_Message(FISHINFO2_TOOLTIP_STATUS[dbUser["IsTooltipEnabled"]]);
  else
    FishInfo2Frame:Show();
  end
end


------------------------------------------------------------------------------
-- Search + Sort Function                                                   --
------------------------------------------------------------------------------
function FishInfo2_Search(matchFunc, sortFunc, query)

  lastSearchFunc = matchFunc;
  lastSortFunc = sortFunc;
  lastQuery = query;

  results = {};

  if sortFunc ~=nil and matchFunc ~= nil then
    --FishInfo2_Message("Starte suche...!"); -- debug
    FishInfo2_DatabaseFunction(matchFunc, nil, nil, results);
    FishInfo2_AddStats();
    --FishInfo2_Message("Sortiere Suchergebnisse...!"); --debug
    table.sort(results, sortFunc);
  end

  --FishInfo2_Message("Treffer: " .. table.getn(results)); --debug
  getglobal("FishInfo2ScrollScrollBar"):SetValue(0);
  FishInfo2_UpdateResults();
end

function FishInfo2_AddStats()
  local count;
  local totalCount;
  local totalFunc;
  local fishCountFunc;
  local cacheId;
  local totalSubzoneCountCache = {};

  for index, resultdata in ipairs(results) do

    local name = resultdata["name"];
    local zone = resultdata["zone"];
    local subZone = resultdata["subZone"]; -- if selectedSubZone == FISHINFO2_ALL_SUBZONES contains all subzones where fish occured

    if FishInfo2_IsZoneSummary() then
      cacheId = zone;
      fishCountFunc = FishInfo2_GetSubzonesCount; --subzone is ignored
      totalFunc = FishInfo2_GetTotalZoneCount; --subzone is ignored
    else
      cacheId = zone .. subZone;
      fishCountFunc = FishInfo2_GetSubzoneCount;
      totalFunc = FishInfo2_GetTotalSubzoneCount;
    end

    count = FishInfo2_DatabaseFunction(fishCountFunc, FishInfo2_AddNumbers, 0, name, zone, subZone);

    if totalSubzoneCountCache[cacheId] == nil then
      totalSubzoneCountCache[cacheId] = FishInfo2_DatabaseFunction(totalFunc, FishInfo2_AddNumbers, 0, zone, subZone);
    end
    totalCount = totalSubzoneCountCache[cacheId];

    results[index]["count"] = count;
    results[index]["totalCount"] = totalCount;
    results[index]["percent"] = FishInfo2_Round(count * 100 / totalCount);
  end
end

function FishInfo2_MatchZone(name, fishdata, results)
  local selectedZone = UIDropDownMenu_GetText(FishInfo2ZoneFrame);
  local selectedSubZone = UIDropDownMenu_GetText(FishInfo2SubZoneFrame);

  if results[name] == nil and fishdata["zones"][selectedZone] ~= nil and fishdata["zones"][selectedZone][selectedSubZone] ~= nil then
    table.insert(results, { ["name"] = name,
                            ["zone"] = selectedZone,
                            ["subZone"] = selectedSubZone,
                            ["rarity"] = fishdata["rarity"],
                            ["texture"] = fishdata["texture"] } );
    results[name] = true;
  end
end

function FishInfo2_MatchFish(name, fishdata, results)
  local searchPattern = FishInfo2Edit:GetText();

  if string.sub(searchPattern, 1, 1) == "%" then
    searchPattern = string.sub(searchPattern, 2);
  end

  if string.find(string.lower(name), string.lower(searchPattern), 1, true) ~= nil then
    for zone, subZones in pairs(fishdata["zones"]) do
      for subZone in pairs(subZones) do
        if results[name..zone..subZone] == nil then
          table.insert(results, { ["name"] = name,
                                  ["zone"] = zone,
                                  ["subZone"] = subZone,
                                  ["rarity"] = fishdata["rarity"],
                                  ["texture"] = fishdata["texture"] } );
          results[name..zone..subZone] = true;
        end
      end
    end
  end
end

function FishInfo2_MatchEntireZone(name, fishdata, results)
  local selectedZone = UIDropDownMenu_GetText(FishInfo2ZoneFrame);

  if fishdata["zones"][selectedZone] ~= nil then
    for subZone in pairs(fishdata["zones"][selectedZone]) do
      if results[name] == nil then
        table.insert(results, { ["name"] = name,
                                ["zone"] = selectedZone,
                                ["subZone"] = "",
                                ["rarity"] = fishdata["rarity"],
                                ["texture"] = fishdata["texture"] } );
        results[name] = {};
      end

      if results[name][subZone] == nil then
        results[name][subZone] = true;
        table.insert(results[name], subZone);
        table.sort(results[name]);
        results[table.getn(results)]["subZone"] = table.concat(results[name], ", ");
      end
    end
  end
end

function FishInfo2_SortFishProcent(data1, data2)
  if string.lower(data1["name"]) == string.lower(data2["name"]) then
    if data1["percent"] == data2["percent"] then
      return data1["zone"] .. data1["subZone"] < data2["zone"] .. data2["subZone"]
    else
      return data1["percent"] >  data2["percent"]
    end
  else
    return string.lower(data1["name"]) < string.lower(data2["name"])
  end
end

function FishInfo2_SortZone(data1, data2)
  return data1["zone"] .. data1["subZone"] .. string.lower(data1["name"]) < data2["zone"] .. data2["subZone"] .. string.lower(data2["name"]);
end

function FishInfo2_SortFish(data1, data2)
  return string.lower(data1["name"]) < string.lower(data2["name"]);
end


------------------------------------------------------------------------------
-- GUI                                                                      --
------------------------------------------------------------------------------
function FishInfo2_UpdateResults()

  FauxScrollFrame_Update(FishInfo2Scroll, table.getn(results), 5, FISHINFO2_SCROLLHEIGHT);

  for i = 1, 5 do
    local index = i + FauxScrollFrame_GetOffset(FishInfo2Scroll);

    -- to make the following code easier to maintain
    local frame = getglobal("FishInfo" .. i);
    local icon = getglobal("FishInfo" .. i .. "Icon");
    local nameText = getglobal("FishInfo" .. i .. "Name");
    local zoneText = getglobal("FishInfo" .. i .. "Zone");
    local procentText = getglobal("FishInfo" .. i .. "Percent");
    local countText = getglobal("FishInfo" .. i .. "Count");

    if index <= table.getn(results) then
      local fishdata = results[index];

      -- fill in info about fish
      icon:SetTexture(fishdata["texture"]);
      icon:SetAlpha(0.65);
      nameText:SetText(fishdata["name"]);
      nameText:SetTextColor(ITEM_QUALITY_COLORS[fishdata["rarity"]].r,
                            ITEM_QUALITY_COLORS[fishdata["rarity"]].g,
                            ITEM_QUALITY_COLORS[fishdata["rarity"]].b);

      if FishInfo2_IsZoneSummary() then
        zoneText:SetText(fishdata["subZone"]);
      else
        zoneText:SetText(fishdata["zone"] .. " - " .. fishdata["subZone"]);
      end

      -- fill in stats
      countText:SetText(fishdata["count"]);
      procentText:SetText(fishdata["percent"] .. "%");

      frame:Show();
    else
      frame:Hide();
    end
  end

  if table.getn(results) == 0 then
    FishInfo2InfoText:SetText(FISHINFO2_NODATA);
    FishInfo2InfoText:SetTextColor(1.0, 0.5, 0.5);
    FishInfo2InfoText2:SetText("");
  else
    FishInfo2InfoText:SetText(string.format(FISHINFO2_RESULTS1, table.getn(results)));
    if lastQuery == "" and lastSearchFunc ~= nil then
      FishInfo2InfoText2:SetText(FISHINFO2_RESULTS3);
    elseif lastQuery == "%" and lastSearchFunc ~= nil then
      FishInfo2InfoText2:SetText(FISHINFO2_RESULTS4);
    else
      FishInfo2InfoText2:SetText(string.format(FISHINFO2_RESULTS2, lastQuery));
    end
  end
end

function FishInfo2_SetFirstView(newFirstView)
  isFirstView = true;
end

function FishInfo2_UpdateGui()
  if isFirstView then
    selectedZone = GetZoneText();
    selectedSubZone = GetMinimapZoneText();
    lastSearchFunc = FishInfo2_MatchZone;
    lastSortFunc = FishInfo2_SortFish;
    lastQuery = selectedZone .. " (" .. selectedSubZone .. ")";
  end

  UIDropDownMenu_Initialize(FishInfo2ZoneFrame, FishInfo2_UpdateZoneList);
  UIDropDownMenu_Initialize(FishInfo2SubZoneFrame, FishInfo2_UpdateSubZoneList);

  if FishInfo2_IsIncludeOthers() then
    FishInfo2CheckOthers:SetChecked(1);
  else
    FishInfo2CheckOthers:SetChecked(0);
  end

  FishInfo2_Search(lastSearchFunc, lastSortFunc, lastQuery);

  if isFirstView then
    -- In case zone or subZone is not in database the text gets deleted.
    -- To give visual feedback, we just display them again.
    UIDropDownMenu_SetText(selectedZone, FishInfo2ZoneFrame);
    UIDropDownMenu_SetText(selectedSubZone, FishInfo2SubZoneFrame);
    isFirstView = false;
  end
end

function FishInfo2_FillInZones(name, fishdata, zones)
  for zone in pairs(fishdata["zones"]) do
    if zones[zone] == nil then
      zones[zone] = true;
      table.insert(zones, zone);
    end
  end
end

function FishInfo2_UpdateZoneList()
  local zones = {};

  FishInfo2_DatabaseFunction(FishInfo2_FillInZones, nil, nil, zones);
  table.sort(zones);

  local info = { func = FishInfo2_ZoneClicked };
  for index, zone in ipairs(zones) do
    info["text"] = zone;
    UIDropDownMenu_AddButton(info);
  end

  if zones[selectedZone] ~= nil then
    UIDropDownMenu_SetSelectedValue(FishInfo2ZoneFrame, selectedZone);
  else
    UIDropDownMenu_SetSelectedValue(FishInfo2ZoneFrame, nil);
    UIDropDownMenu_SetText("", FishInfo2ZoneFrame);
  end
end

function FishInfo2_FillInSubZones(name, fishdata, subZones, forZone)
  if fishdata["zones"][forZone] ~= nil then
    for subZone in pairs(fishdata["zones"][forZone]) do
      if subZones[subZone] == nil then
        subZones[subZone] = true;
        table.insert(subZones, subZone);
      end
    end
  end
end

function FishInfo2_UpdateSubZoneList()
  local subZones = {};

  FishInfo2_DatabaseFunction(FishInfo2_FillInSubZones, nil, nil, subZones, UIDropDownMenu_GetText(FishInfo2ZoneFrame));
  table.sort(subZones);

  -- fill in subzone combobox
  local subzonesCount = 0;
  local info = { func = FishInfo2_StartZoneSearch };
  for index, subZone in ipairs(subZones) do
    info["text"] = subZone;
    UIDropDownMenu_AddButton(info);
    subzonesCount = subzonesCount + 1;
  end

  if subzonesCount > 0 then
    info["text"] = FISHINFO2_ALL_SUBZONES;
    UIDropDownMenu_AddButton(info);
  end

  if subZones[selectedSubZone] or (selectedSubZone == FISHINFO2_ALL_SUBZONES and subzonesCount > 0) then
    UIDropDownMenu_SetSelectedValue(FishInfo2SubZoneFrame, selectedSubZone);
  else
    UIDropDownMenu_SetSelectedValue(FishInfo2SubZoneFrame, nil);
    UIDropDownMenu_SetText("", FishInfo2SubZoneFrame);
  end
end


------------------------------------------------------------------------------
-- GUI Event handlers                                                       --
------------------------------------------------------------------------------

-- called when a zone is selected
function FishInfo2_ZoneClicked()
  UIDropDownMenu_SetSelectedID(FishInfo2ZoneFrame, this:GetID())
  selectedZone = UIDropDownMenu_GetText(FishInfo2ZoneFrame);

  -- reset subzone combobox
  selectedSubZone = FISHINFO2_ALL_SUBZONES;
  UIDropDownMenu_SetSelectedValue(FishInfo2SubZoneFrame, FISHINFO2_ALL_SUBZONES);
  UIDropDownMenu_SetText(FISHINFO2_ALL_SUBZONES, FishInfo2SubZoneFrame);

  FishInfo2_Search(FishInfo2_MatchEntireZone, FishInfo2_SortFish,
                   UIDropDownMenu_GetText(FishInfo2ZoneFrame) .. " (" .. FISHINFO2_ALL_SUBZONES .. ")");
end

-- called when a subzone is selected
function FishInfo2_StartZoneSearch()
  UIDropDownMenu_SetSelectedID(FishInfo2SubZoneFrame, this:GetID())
  selectedSubZone = UIDropDownMenu_GetText(FishInfo2SubZoneFrame)

  -- Start zone search
  if selectedSubZone == FISHINFO2_ALL_SUBZONES then
    FishInfo2_Search(FishInfo2_MatchEntireZone, FishInfo2_SortFish,
                     UIDropDownMenu_GetText(FishInfo2ZoneFrame) .. " (" .. UIDropDownMenu_GetText(FishInfo2SubZoneFrame) .. ")");
  else
    FishInfo2_Search(FishInfo2_MatchZone, FishInfo2_SortFish,
                     UIDropDownMenu_GetText(FishInfo2ZoneFrame) .. " (" .. UIDropDownMenu_GetText(FishInfo2SubZoneFrame) .. ")");
  end
end

-- called from OnEnterPressed (editbox)
function FishInfo2_StartFishSearch()
  -- Start fish name search
  if FishInfo2Edit:GetText() ~= "" then
    FishInfo2Edit:AddHistoryLine(FishInfo2Edit:GetText());
  end
  if string.sub(FishInfo2Edit:GetText(), 1, 1) == "%" then
    FishInfo2_Search(FishInfo2_MatchFish, FishInfo2_SortFishProcent, FishInfo2Edit:GetText());
  else
    FishInfo2_Search(FishInfo2_MatchFish, FishInfo2_SortZone, FishInfo2Edit:GetText());
  end
end

function FishInfo2_IconClicked()
  local index = string.sub(this:GetName(), -1) + FauxScrollFrame_GetOffset(FishInfo2Scroll);
  GameTooltip:Hide();
  FishInfo2Edit:SetText("%" .. results[index]["name"]);
  FishInfo2_StartFishSearch();
end

------------------------------------------------------------------------------
-- Helper Functions                                                         --
------------------------------------------------------------------------------
function FishInfo2_IsZoneSummary()
  return lastSearchFunc == FishInfo2_MatchEntireZone;
end

function FishInfo2_UpdateGametooltip()
  if dbUser["IsTooltipEnabled"] then
    local index = string.sub(this:GetName(), -1) + FauxScrollFrame_GetOffset(FishInfo2Scroll);
    local name = results[index]["name"];

    if linkCache[name] == nil then
      linkCache[name] = FishInfo2_DatabaseFunction(FishInfo2_FindLink, FishInfo2_KeepFirst, nil, name);
    end

    if linkCache[name] and GetItemInfo(linkCache[name]) then
      GameTooltip:SetOwner(this, "ANCHOR_LEFT");
      GameTooltip:SetHyperlink(linkCache[name]);

      if FishInfo2_IsZoneSummary() then
        local tooltipLines = GameTooltip:NumLines();
        GameTooltip:AddLine(" ");
        GameTooltip:AddLine(FISHINFO2_LIST_SUBZONES, 1.0, 1.0, 1.0);
        for index, subZone in ipairs(results[name]) do
          GameTooltip:AddLine(subZone);
          -- change width if necessary
          local strwidth = getglobal("GameTooltipTextLeft" .. GameTooltip:NumLines()):GetStringWidth() + 20;
          if strwidth > GameTooltip:GetWidth() then
            GameTooltip:SetWidth(strwidth);
          end
        end
        GameTooltip:SetHeight(GameTooltip:GetHeight() + 14 * (GameTooltip:NumLines() - tooltipLines));
      end
    end
  end
end

function FishInfo2_FindLink(name, fishdata, matchName)
  if name == matchName and fishdata["link"] then
    return fishdata["link"];
  else
    return nil;
  end
end

function FishInfo2_GetSubzoneCount(name, fishdata, matchName, matchZone, matchSubZone)
  if name == matchName then
    return FishInfo2_GetTotalSubzoneCount(name, fishdata, matchZone, matchSubZone);
  else
    return 0;
  end
end

function FishInfo2_GetTotalSubzoneCount(name, fishdata, matchZone, matchSubZone)
  if fishdata["zones"][matchZone] ~= nil and fishdata["zones"][matchZone][matchSubZone] ~= nil then
    return fishdata["zones"][matchZone][matchSubZone];
  else
    return 0;
  end
end

function FishInfo2_GetSubzonesCount(name, fishdata, matchName, matchZone)
  if name == matchName then
    return FishInfo2_GetTotalZoneCount(name, fishdata, matchZone);
  else
    return 0;
  end;
end

function FishInfo2_GetTotalZoneCount(name, fishdata, matchZone)
  local count = 0;
  if fishdata["zones"][matchZone] ~= nil then
    for subZone in pairs(fishdata["zones"][matchZone]) do
      count = count + fishdata["zones"][matchZone][subZone];
    end
  end
  return count;
end

function FishInfo2_Round(number)
  if number < 0.5 then
    return 1;
  else
    return math.floor(number + 0.5);
  end
end

function FishInfo2_IsIncludeOthers()
  return dbUser["IsIncludeOthers"];
end

function FishInfo2_SetIncludeOthers(isIncludeOthers)
  if isIncludeOthers then
    dbUser["IsIncludeOthers"] = true;
  else
    dbUser["IsIncludeOthers"] = false;
  end
end

function FishInfo2_Message(msg)
  ChatFrame1:AddMessage(NORMAL_FONT_COLOR_CODE .. "FishInfo2: " .. LIGHTYELLOW_FONT_COLOR_CODE.. msg);
end

function FishInfo2_OnHide()
  if isEnableFirstViewOnHide then
    isFirstView = true;
    isEnableFirstViewOnHide = false;
  end
end

------------------------------------------------------------------------------
-- Converter function, import Impp's Database                               --
------------------------------------------------------------------------------
function FishInfo2_ImportImpp()
  if imppfishinfoDB and db then
    local importCount = 0;
    local isEmeraldUi = false;
    local zoneName = "Impp Zone";
    local subZoneName;

    FishInfo2_Message(FISHINFO2_IMPORT);
    for subZone in pairs(imppfishinfoDB) do
      for name, data in pairs(imppfishinfoDB[subZone]["itemnames"]) do
        if isEmeraldUi then
          -- Emerald-UI stores "<Subzone name>, <Zone name>" or "<Zone name>"
          local commapos = string.find(subZone, ",", 1, true);
          if commapos then
            zoneName = string.sub(subZone, commapos + 2);
            subZoneName = string.sub(subZone, 1, commapos - 1);
          else
            zoneName = subZone;
            subZoneName = subZone;
          end
        else
          -- Std ImppDB, no <Zone name>, only <Subzone name> available
          subZoneName = subZone;
        end
        FishInfo2_UpdateDatabase(false, zoneName, subZoneName, nil, data["texture"], name, data["number"], data["quality"]);
        importCount = importCount + 1;
      end
    end

    FishInfo2_Message(string.format(FISHINFO2_IMPORTFINISHED, importCount));
  else
    FishInfo2_Message(FISHINFO2_NOIMPORT);
  end
end


------------------------------------------------------------------------------
-- Database functions, helps managing multiple databases                    --
------------------------------------------------------------------------------

-- find databases from other characters and save the pointers
function FishInfo2_CollectDatabasesFromOtherCharacters(excludeDatabaseName)
  local databases = { };
  for dbName, db in pairs(FishInfo2DataSub) do
    if dbName ~= excludeDatabaseName and string.find(dbName, "|User", 1, true) == nil then
      --FishInfo2_Message("Adding database: " .. dbName) --debug
      databases[dbName] = db;
    end
  end
  return databases;
end

-- collects data via 'func'/'funcReturn' within the current character database or within all.
function FishInfo2_DatabaseFunction(func, funcReturn, returnDefault, arg1, arg2, arg3)
  local returnValue = returnDefault;
  local addValue;
  -- execute 'func' for current character database
  for name, fishdata in pairs(db) do
    addValue = func(name, fishdata, arg1, arg2, arg3);
    if funcReturn ~= nil then
      returnValue = funcReturn(returnValue, addValue);
    end
  end
  -- execute 'func' for databases from other characters (if enabled)
  if FishInfo2_IsIncludeOthers() then
    for dbName, dbOther in pairs(dbOthers) do
      for name, fishdata in pairs(dbOther) do
        addValue = func(name, fishdata, arg1, arg2, arg3);
        if funcReturn ~= nil then
          returnValue = funcReturn(returnValue, addValue);
        end
      end
    end
  end
  return returnValue;
end

--
function FishInfo2_AddNumbers(num1, num2)
  return num1 + num2;
end

function FishInfo2_KeepFirst(obj1, obj2)
  if obj1 ~= nil then
    return obj1;
  end

  if obj2 ~= nil then
    return obj2;
  end

  return nil;
end

------------------------------------------------------------------------------
-- Titan Panel support                                                      --
------------------------------------------------------------------------------
function TitanPanelFishInfo2Button_OnLoad()
  this.registry = {
    id = FISHINFO2_TITAN_ID,
    menuText = FISHINFO2,
    buttonTextFunction = nil,
    tooltipTitle = FISHINFO2,
    tooltipTextFunction = "TitanPanelFishInfo2Button_GetTooltipText",
    frequency = 0,
    icon = "Interface\\Icons\\INV_Misc_Fish_03",
    savedVariables = {
      testcheck = 0;
    }
  };
end

function TitanPanelFishInfo2Button_GetTooltipText()
  if FishInfo2Frame:IsVisible() then
    return FISHINFO2_TITAN_TOOLTIP1;
  else
    return string.format(FISHINFO2_TITAN_TOOLTIP2, GetZoneText(), GetMinimapZoneText());
  end
end

function TitanPanelFishInfo2Button_OnClick(arg1)
  if arg1 == "LeftButton" then
    if FishInfo2Frame:IsVisible() then
      FishInfo2Frame:Hide();
    else
      isFirstView = true;
      FishInfo2Frame:Show();
    end
  end
end

function TitanPanelRightClickMenu_PrepareFishInfo2Menu()
  TitanPanelRightClickMenu_AddTitle(TitanPlugins[FISHINFO2_TITAN_ID].menuText);
  TitanPanelRightClickMenu_AddSpacer();
  TitanPanelRightClickMenu_AddCommand(FISHINFO2_TITAN_MENU_TOGGLE, nil, "TitanPanelFishInfo2Toggle");
  TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, FISHINFO2_TITAN_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

function TitanPanelFishInfo2Toggle()
  if FishInfo2Frame:IsVisible() then
    FishInfo2Frame:Hide();
  else
    FishInfo2Frame:Show()
  end
end
