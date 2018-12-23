
if GetLocale() == "deDE" then

  --
  -- German
  --
  FISHINFO2 = "Fisch-Info 2";
  FISHINFO2_VERSION = "testVersion9a";
  FISHINFO2_LOADED = " geladen.";

  -- MyAddons
  FISHINFO2_MYADDONS_DESCRIPTION = "Wo habe ich welchen Fisch gefangen?";

  FISHINFO2_MYADDONS_HELP1 = NORMAL_FONT_COLOR_CODE .. "Chatbefehle";
  FISHINFO2_MYADDONS_HELP2 = LIGHTYELLOW_FONT_COLOR_CODE .. "Alternativ eine Taste zum Aufrufen festlegen.";
  FISHINFO2_MYADDONS_HELP3 = NORMAL_FONT_COLOR_CODE .. "Tipp: " .. LIGHTYELLOW_FONT_COLOR_CODE .. "Vor den Namen ein '%'-Zeichen setzen. Die Ergebnisliste wird dann nach Prozent sortiert.";

  -- Titan Panel
  FISHINFO2_TITAN_TOOLTIP1 = GREEN_FONT_COLOR_CODE .. "Hinweis: Links-Klick schliesst das Fenster."
  -- 1st Parameter: Zone, 2nd Parameter: SubZone
  FISHINFO2_TITAN_TOOLTIP2 = GREEN_FONT_COLOR_CODE .. "Hinweis: Links-Klick zeigt bereits gefangene Fische bei\n" .. GREEN_FONT_COLOR_CODE .. "'%s (%s)'.";
  FISHINFO2_TITAN_MENU_TOGGLE = "Fenster anzeigen / ausblenden";

  -- 1st Paramter: Fishname, 2nd Parameter: Zone, 3rd Parameter: SubZone
  FISHINFO2_DBUPDATE = "Fisch '%s' (%s - %s) hinzugef\195\188gt.";
  FISHINFO2_NODATA = "Keine Daten / Suche ergab keine Treffer!";
  -- 1st Paramter: Zone
  --FISHINFO2_SELECTED_SUBZONE = LIGHTYELLOW_FONT_COLOR_CODE .. "Bitte Subzone f\195\188r '" .. NORMAL_FONT_COLOR_CODE .. "%s" .. LIGHTYELLOW_FONT_COLOR_CODE .. "' ausw\195\164hlen.";
  -- 1st Paramter: number of hits
  FISHINFO2_RESULTS1 = LIGHTYELLOW_FONT_COLOR_CODE .. "Die Suche ergab %d Treffer f\195\188r:";
  -- 1st Paramter: Query string
  FISHINFO2_RESULTS2 = LIGHTYELLOW_FONT_COLOR_CODE .. "'" .. NORMAL_FONT_COLOR_CODE .. "%s" .. LIGHTYELLOW_FONT_COLOR_CODE .. "'"
  FISHINFO2_RESULTS3 = LIGHTYELLOW_FONT_COLOR_CODE .. "'" .. NORMAL_FONT_COLOR_CODE .. "<alle Fische anzeigen, sortiert nach Zone>" .. LIGHTYELLOW_FONT_COLOR_CODE .. "'"
  FISHINFO2_RESULTS4 = LIGHTYELLOW_FONT_COLOR_CODE .. "'" .. NORMAL_FONT_COLOR_CODE .. "<alle Fische anzeigen, sortiert nach Prozent>" .. LIGHTYELLOW_FONT_COLOR_CODE .. "'"

  FISHINFO2_ALL_SUBZONES = "Alle Fische dieser Zone";
  FISHINFO2_LIST_SUBZONES = "Fisch gefangen in:";

  FISHINFO2_IMPORT = "Impp's fishinfo Datenbank gefunden. Daten werden importiert.";
  -- 1st Paramter: number of imported fishes
  FISHINFO2_IMPORTFINISHED = "%d Fische importiert.";
  FISHINFO2_NOIMPORT = "Impp's fishinfo Datenbank nicht gefunden. Kein Import m\195\182glich.";
  FISHINFO2_LOCATION = "(Sub)Zone:";
  FISHINFO2_NAME = "Name:";
  FISHINFO2_CLOSE = "Schliessen";
  FISHINFO2_INCLUDE_OTHERS = "Daten meiner anderen Charaktere ber\195\188cksichtigen.";

  -- Bindings
  BINDING_HEADER_FISHINFO2 = FISHINFO2;
  BINDING_NAME_TOGGLE_FISHINFO2 = "Anzeige umschalten";

  -- Chat
  FISHINFO2_CHATHELP1 = HIGHLIGHT_FONT_COLOR_CODE .. "/fi2" .. LIGHTYELLOW_FONT_COLOR_CODE .. " - Fenster von " .. FISHINFO2 .. " anzeigen.";
  FISHINFO2_CHATHELP2 = HIGHLIGHT_FONT_COLOR_CODE .. "/fi2 nopreselect" .. LIGHTYELLOW_FONT_COLOR_CODE .. " - Fenster anzeigen aber nicht die aktuelle Zone / Subzone automatisch ausw\195\164hlen.";
  FISHINFO2_CHATHELP3 = HIGHLIGHT_FONT_COLOR_CODE .. "/fi2 tooltip on/off" .. LIGHTYELLOW_FONT_COLOR_CODE .. " - Tooltips anzeigen oder nicht.";
  FISHINFO2_TOOLTIP_STATUS = {
    [true] = "Derzeitige Einstellung: " .. HIGHLIGHT_FONT_COLOR_CODE .. "Tooltips werden angezeigt.",
    [false] = "Derzeitige Einstellung: " .. HIGHLIGHT_FONT_COLOR_CODE .. "Tooltips werden nicht angezeigt."
  };


elseif GetLocale() == "zhTW" then

  --
  -- Traditional Chinese
  --
  FISHINFO2 = "Fish Info 2";
  FISHINFO2_VERSION = "testVersion9a";
  FISHINFO2_LOADED = " 已經載入";

  -- MyAddons
  FISHINFO2_MYADDONS_DESCRIPTION = "何處可以釣到這種魚類?";
  
  FISHINFO2_MYADDONS_HELP1 = NORMAL_FONT_COLOR_CODE .. "Slash commands";
  FISHINFO2_MYADDONS_HELP2 = LIGHTYELLOW_FONT_COLOR_CODE .. "你可以設定快捷鍵來顯示/隱藏這個視窗";
  FISHINFO2_MYADDONS_HELP3 = NORMAL_FONT_COLOR_CODE .. "提示: " .. LIGHTYELLOW_FONT_COLOR_CODE .. "在魚類名稱前加上字首 '%' 將搜尋列表以百分比顯示";

  -- Titan Panel
  FISHINFO2_TITAN_TOOLTIP1 = GREEN_FONT_COLOR_CODE .. "提示: 左鍵點擊關閉視窗"
  -- 1st Parameter: Zone, 2nd Parameter: SubZone
  FISHINFO2_TITAN_TOOLTIP2 = GREEN_FONT_COLOR_CODE .. "提示: 左鍵點擊顯示在\n 所捕獲魚種" .. GREEN_FONT_COLOR_CODE .. "'%s (%s)'.";
  FISHINFO2_TITAN_MENU_TOGGLE = "切換顯示";

  -- 1st Paramter: Fishname, 2nd Parameter: Zone, 3rd Paramter: SubZone
  FISHINFO2_DBUPDATE = "增加魚種 '%s' (%s - %s).";
  FISHINFO2_NODATA = " 無資料 / 無搜尋結果!";
  -- 1st Paramter: Zone
  --FISHINFO2_SELECTED_SUBZONE = LIGHTYELLOW_FONT_COLOR_CODE .. "請選擇區域 '" .. NORMAL_FONT_COLOR_CODE .. "%s" .. LIGHTYELLOW_FONT_COLOR_CODE .. "'.";
  -- 1st Paramter: number of hits
  FISHINFO2_RESULTS1 = LIGHTYELLOW_FONT_COLOR_CODE .. "搜尋 %d 結果如下:";
  -- 1st Paramter: Query string
  FISHINFO2_RESULTS2 = LIGHTYELLOW_FONT_COLOR_CODE .. "'" .. NORMAL_FONT_COLOR_CODE .. "%s" .. LIGHTYELLOW_FONT_COLOR_CODE .. "'"
  FISHINFO2_RESULTS3 = LIGHTYELLOW_FONT_COLOR_CODE .. "'" .. NORMAL_FONT_COLOR_CODE .. "<依照區域顯示所有魚種>" .. LIGHTYELLOW_FONT_COLOR_CODE .. "'"
  FISHINFO2_RESULTS4 = LIGHTYELLOW_FONT_COLOR_CODE .. "'" .. NORMAL_FONT_COLOR_CODE .. "<依照百分比顯示所有魚種>" .. LIGHTYELLOW_FONT_COLOR_CODE .. "'"

  FISHINFO2_ALL_SUBZONES = "此區域所有魚種";
  FISHINFO2_LIST_SUBZONES = "在此捕獲:";

  FISHINFO2_IMPORT = "發現漁獲資料庫 現在開始匯入";
  -- 1st Paramter: number of imported fishes
  FISHINFO2_IMPORTFINISHED = "%d 魚種 已經匯入";
  FISHINFO2_NOIMPORT = "未發現漁獲資料庫 無法匯入";
  FISHINFO2_LOCATION = "(子)區域:";
  FISHINFO2_NAME = "名稱:";
  FISHINFO2_CLOSE = "關閉";
  FISHINFO2_INCLUDE_OTHERS = "由其他角色將資料匯入";

  -- Bindings
  BINDING_HEADER_FISHINFO2 = FISHINFO2;
  BINDING_NAME_TOGGLE_FISHINFO2 = "Toggle display";

  -- Chat
  FISHINFO2_CHATHELP1 = HIGHLIGHT_FONT_COLOR_CODE .. "/fi2" .. LIGHTYELLOW_FONT_COLOR_CODE .. " - 顯示 " .. FISHINFO2 .. " 視窗"
  FISHINFO2_CHATHELP2 = HIGHLIGHT_FONT_COLOR_CODE .. "/fi2 nopreselect" .. LIGHTYELLOW_FONT_COLOR_CODE .. " - 顯示視窗但不選擇區域";
  FISHINFO2_CHATHELP3 = HIGHLIGHT_FONT_COLOR_CODE .. "/fi2 tooltip on/off" .. LIGHTYELLOW_FONT_COLOR_CODE .. " - 開啟提示/關閉提示";
  FISHINFO2_TOOLTIP_STATUS = {
    [true] = "目前設定: " .. HIGHLIGHT_FONT_COLOR_CODE .. "開啟提示",
    [false] = "目前設定: " .. HIGHLIGHT_FONT_COLOR_CODE .. "關閉提示"
  };


elseif GetLocale() == "frFR" then

  --
  -- Francais (contributed by Corwin Whitehorn)
  --
  -- ?= \195\160
  -- ?= \195\169
  -- ?= \195\170
  -- ?= \195\174
  -- ?= \195\185
  -- ?= \195\187

  FISHINFO2 = "Fish Info 2";
  FISHINFO2_VERSION = "testVersion9a";
  FISHINFO2_LOADED = " charg\195\169.";

  -- MyAddons
  FISHINFO2_MYADDONS_DESCRIPTION = "O\195\185 ai-je pris ce poisson?";

  FISHINFO2_MYADDONS_HELP1 = NORMAL_FONT_COLOR_CODE .. "Commandes";
  FISHINFO2_MYADDONS_HELP2 = LIGHTYELLOW_FONT_COLOR_CODE .. "Vous pouvez \195\169galement assigner une touche pour faire appara\195\174tre/dispara\195\174tre la fen\195\170tre";
  FISHINFO2_MYADDONS_HELP3 = NORMAL_FONT_COLOR_CODE .. "Hint: " .. LIGHTYELLOW_FONT_COLOR_CODE .. "Faites commencer le nom du poisson par un '%'. La liste sera alors class\195\169e par pourcentage.";

  -- Titan Panel
  FISHINFO2_TITAN_TOOLTIP1 = GREEN_FONT_COLOR_CODE .. "Truc: Cliquez gauche pour fermer la fen\195\170tre."
  -- 1st Parameter: Zone, 2nd Parameter: SubZone
  FISHINFO2_TITAN_TOOLTIP2 = GREEN_FONT_COLOR_CODE .. "Truc: Cliquez gauche pour afficher les poissons p\195\170ch\195\169s \195\160\n" .. GREEN_FONT_COLOR_CODE .. "'%s (%s)'.";
  FISHINFO2_TITAN_MENU_TOGGLE = "Toggle display";

  -- 1st Paramter: Fishname, 2nd Parameter: Zone, 3rd Paramter: SubZone
  FISHINFO2_DBUPDATE = "Poisson ajout\195\169 : '%s' (%s - %s).";
  FISHINFO2_NODATA = " Pas de donn\195\169es / Pas de r\195\169sultats!";
  -- 1st Paramter: Zone
  --FISHINFO2_SELECTED_SUBZONE = LIGHTYELLOW_FONT_COLOR_CODE .. "Veuillez s\195\169lectionner une sous-zone pour '" .. NORMAL_FONT_COLOR_CODE .. "%s" .. LIGHTYELLOW_FONT_COLOR_CODE .. "'.";
  -- 1st Paramter: number of hits
  FISHINFO2_RESULTS1 = LIGHTYELLOW_FONT_COLOR_CODE .. "La recherche a donn\195\169 %d occurences pour:";
  -- 1st Paramter: Query string
  FISHINFO2_RESULTS2 = LIGHTYELLOW_FONT_COLOR_CODE .. "'" .. NORMAL_FONT_COLOR_CODE .. "%s" .. LIGHTYELLOW_FONT_COLOR_CODE .. "'"
  FISHINFO2_RESULTS3 = LIGHTYELLOW_FONT_COLOR_CODE .. "'" .. NORMAL_FONT_COLOR_CODE .. "<Affiche tous les poissons, class\195\169s par zone>" .. LIGHTYELLOW_FONT_COLOR_CODE .. "'"
  FISHINFO2_RESULTS4 = LIGHTYELLOW_FONT_COLOR_CODE .. "'" .. NORMAL_FONT_COLOR_CODE .. "<Affiche tous les poissons, class\195\169s par pourcentage>" .. LIGHTYELLOW_FONT_COLOR_CODE .. "'"

  FISHINFO2_ALL_SUBZONES = "Tous les poissons de cette zone";
  FISHINFO2_LIST_SUBZONES = "Poisson recueilli:";

  FISHINFO2_IMPORT = "Base de donn\195\169es Impp fishinfo d\195\169tect\195\169e. Importation en cours.";
  -- 1st Paramter: number of imported fishes
  FISHINFO2_IMPORTFINISHED = "%d poissons import\195\169s.";
  FISHINFO2_NOIMPORT = "Base de donn\195\169es Impp fishinfo non d\195\169tect\195\169e. Pas d'importation.";
  FISHINFO2_LOCATION = "(Sous)Zone:";
  FISHINFO2_NAME = "Nom:";
  FISHINFO2_CLOSE = "Fermer";
  FISHINFO2_INCLUDE_OTHERS = "Prendre en compte les donn\195\169es de mes autres persos.";

  -- Chat
  FISHINFO2_CHATHELP1 = HIGHLIGHT_FONT_COLOR_CODE .. "/fi2" .. LIGHTYELLOW_FONT_COLOR_CODE .. " - afficher " .. FISHINFO2 .. "."
  FISHINFO2_CHATHELP2 = HIGHLIGHT_FONT_COLOR_CODE .. "/fi2 nopreselect" .. LIGHTYELLOW_FONT_COLOR_CODE .. " - afficher la fen\195\170tre sans s\195\169lectionner la (sous)zone.";
  FISHINFO2_CHATHELP3 = HIGHLIGHT_FONT_COLOR_CODE .. "/fi2 tooltip on/off" .. LIGHTYELLOW_FONT_COLOR_CODE .. " - Active / D\195\169sactive les messages d'aide.";
  FISHINFO2_TOOLTIP_STATUS = {
    [true] = "R\195\169glage actuel: " .. HIGHLIGHT_FONT_COLOR_CODE .. "Messages d'aides activ\195\169s.",
    [false] = "R\195\169glage actuel: " .. HIGHLIGHT_FONT_COLOR_CODE .. "Messages d'aides d\195\169sactiv\195\169es."
  };

  -- Bindings
  BINDING_HEADER_FISHINFO2 = FISHINFO2;
  BINDING_NAME_TOGGLE_FISHINFO2 = "Toggle display";

else

  --
  -- English
  --
  FISHINFO2 = "Fish Info 2";
  FISHINFO2_VERSION = "testVersion9a";
  FISHINFO2_LOADED = " loaded.";

  -- MyAddons
  FISHINFO2_MYADDONS_DESCRIPTION = "Where I catched that fish?";
  
  FISHINFO2_MYADDONS_HELP1 = NORMAL_FONT_COLOR_CODE .. "Slash commands";
  FISHINFO2_MYADDONS_HELP2 = LIGHTYELLOW_FONT_COLOR_CODE .. "You can also bind a key to show/hide the window.";
  FISHINFO2_MYADDONS_HELP3 = NORMAL_FONT_COLOR_CODE .. "Hint: " .. LIGHTYELLOW_FONT_COLOR_CODE .. "Prefix the fish name with a '%'. Then the result list will be sorted by percent.";

  -- Titan Panel
  FISHINFO2_TITAN_TOOLTIP1 = GREEN_FONT_COLOR_CODE .. "Hint: Left-click to close the window."
  -- 1st Parameter: Zone, 2nd Parameter: SubZone
  FISHINFO2_TITAN_TOOLTIP2 = GREEN_FONT_COLOR_CODE .. "Hint: Left-click to show catched fishes at\n" .. GREEN_FONT_COLOR_CODE .. "'%s (%s)'.";
  FISHINFO2_TITAN_MENU_TOGGLE = "Toggle display";

  -- 1st Paramter: Fishname, 2nd Parameter: Zone, 3rd Paramter: SubZone
  FISHINFO2_DBUPDATE = "Added fish '%s' (%s - %s).";
  FISHINFO2_NODATA = " No data / No search results!";
  -- 1st Paramter: Zone
  --FISHINFO2_SELECTED_SUBZONE = LIGHTYELLOW_FONT_COLOR_CODE .. "Please, select a subzone for '" .. NORMAL_FONT_COLOR_CODE .. "%s" .. LIGHTYELLOW_FONT_COLOR_CODE .. "'.";
  -- 1st Paramter: number of hits
  FISHINFO2_RESULTS1 = LIGHTYELLOW_FONT_COLOR_CODE .. "The search resulted in %d hits for:";
  -- 1st Paramter: Query string
  FISHINFO2_RESULTS2 = LIGHTYELLOW_FONT_COLOR_CODE .. "'" .. NORMAL_FONT_COLOR_CODE .. "%s" .. LIGHTYELLOW_FONT_COLOR_CODE .. "'"
  FISHINFO2_RESULTS3 = LIGHTYELLOW_FONT_COLOR_CODE .. "'" .. NORMAL_FONT_COLOR_CODE .. "<show all fish, sort by zone>" .. LIGHTYELLOW_FONT_COLOR_CODE .. "'"
  FISHINFO2_RESULTS4 = LIGHTYELLOW_FONT_COLOR_CODE .. "'" .. NORMAL_FONT_COLOR_CODE .. "<show all fish, sort by percent>" .. LIGHTYELLOW_FONT_COLOR_CODE .. "'"

  FISHINFO2_ALL_SUBZONES = "All fish of this zone";
  FISHINFO2_LIST_SUBZONES = "Fish catched in:";

  FISHINFO2_IMPORT = "Impp fishinfo database found. Importing now.";
  -- 1st Paramter: number of imported fishes
  FISHINFO2_IMPORTFINISHED = "%d fishes imported.";
  FISHINFO2_NOIMPORT = "Impp fishinfo database not found. No Import.";
  FISHINFO2_LOCATION = "(Sub)Zone:";
  FISHINFO2_NAME = "Name:";
  FISHINFO2_CLOSE = "Close";
  FISHINFO2_INCLUDE_OTHERS = "Take the data from my other characters into account.";

  -- Chat
  FISHINFO2_CHATHELP1 = HIGHLIGHT_FONT_COLOR_CODE .. "/fi2" .. LIGHTYELLOW_FONT_COLOR_CODE .. " - show " .. FISHINFO2 .. " window."
  FISHINFO2_CHATHELP2 = HIGHLIGHT_FONT_COLOR_CODE .. "/fi2 nopreselect" .. LIGHTYELLOW_FONT_COLOR_CODE .. " - show window and do not select the current zone / subzone for me.";
  FISHINFO2_CHATHELP3 = HIGHLIGHT_FONT_COLOR_CODE .. "/fi2 tooltip on/off" .. LIGHTYELLOW_FONT_COLOR_CODE .. " - enable / disable tooltips.";
  FISHINFO2_TOOLTIP_STATUS = {
    [true] = "Present setup: " .. HIGHLIGHT_FONT_COLOR_CODE .. "Tooltips are shown.",
    [false] = "Present setup: " .. HIGHLIGHT_FONT_COLOR_CODE .. "Tooltips are not shown."
  };

  -- Bindings
  BINDING_HEADER_FISHINFO2 = FISHINFO2;
  BINDING_NAME_TOGGLE_FISHINFO2 = "Toggle display";

end

FISHINFO2_MYADDONS_XHELP = {
  FISHINFO2_MYADDONS_HELP1 .. "\n\n" ..
  FISHINFO2_CHATHELP1 .. "\n\n" ..
  FISHINFO2_CHATHELP2 .. "\n\n" ..
  FISHINFO2_CHATHELP3 .. "\n\n" ..
  FISHINFO2_MYADDONS_HELP2 .. "\n\n\n" ..
  FISHINFO2_MYADDONS_HELP3
};