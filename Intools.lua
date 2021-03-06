script_name('Inst Tools')
script_version('5.5')
script_author('Damien_Requeste')
local sf = require 'sampfuncs'
local key = require "vkeys"
local inicfg = require 'inicfg'
local sampev = require 'lib.samp.events'
local imgui = require 'imgui' -- ��������� ����������
local encoding = require 'encoding' -- ��������� ����������
local wm = require 'lib.windows.message'
local gk = require 'game.keys'
local dlstatus = require('moonloader').download_status
local second_window = imgui.ImBool(false)
local third_window = imgui.ImBool(false)
local first_window = imgui.ImBool(false)
local bMainWindow = imgui.ImBool(false)
local sInputEdit = imgui.ImBuffer(128)
local bIsEnterEdit = imgui.ImBool(false)
local ystwindow = imgui.ImBool(false)
local helps = imgui.ImBool(false)
local infbar = imgui.ImBool(false)
local updwindows = imgui.ImBool(false)
local tEditData = {
	id = -1,
	inputActive = false
}
encoding.default = 'CP1251' -- ��������� ��������� �� ���������, ��� ������ ��������� � ���������� �����. CP1251 - ��� Windows-1251
u8 = encoding.UTF8
require 'lib.sampfuncs'
seshsps = 1
ctag = "ITools {ffffff}|"
players1 = {'{ffffff}���\t{ffffff}����'}
players2 = {'{ffffff}���� ��������\t{ffffff}���\t{ffffff}����\t{ffffff}������'}
frak = nil
rang = nil
ttt = nil
dostavka = false
rabden = false
tload = false
changetextpos = false
tLastKeys = {}
prava = 0
pilot = 0
kater = 0
gun = 0
ribolov = 0
biznes = 0
departament = {}
vixodid = {}
local config_keys = {
    fastsms = { v = {}}
}
function apply_custom_style() -- ������ ������ ���������, ������� ������ � ������� �����

	imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    local ImVec2 = imgui.ImVec2

    style.WindowPadding = ImVec2(15, 15)
    style.WindowRounding = 5.0
    style.FramePadding = ImVec2(5, 5)
    style.FrameRounding = 4.0
    style.ItemSpacing = ImVec2(12, 8)
    style.ItemInnerSpacing = ImVec2(8, 6)
    style.IndentSpacing = 25.0
    style.ScrollbarSize = 15.0
    style.ScrollbarRounding = 9.0
    style.GrabMinSize = 5.0
	style.GrabRounding = 3.0
	style.WindowTitleAlign = ImVec2(0.5, 0.5)


	colors[clr.Text] = ImVec4(0.80, 0.80, 0.83, 1.00)
    colors[clr.TextDisabled] = ImVec4(0.24, 0.23, 0.29, 1.00)
    colors[clr.ChildWindowBg] = ImVec4(0.07, 0.07, 0.09, 0.50)
    colors[clr.PopupBg] = ImVec4(0.07, 0.07, 0.09, 0.80)
    colors[clr.Border] = ImVec4(0.80, 0.80, 0.83, 0.88)
    colors[clr.BorderShadow] = ImVec4(0.92, 0.91, 0.88, 0.00)
	--colors[clr.TitleBgCollapsed] = ImVec4(0.00, 0.00, 0.00, 0.51)
	colors[clr.TitleBgCollapsed] = ImVec4(0.24, 0.23, 0.29, 1.00)
    colors[clr.TitleBgActive] = ImVec4(0.07, 0.61, 0.92, 0.83)
	colors[clr.MenuBarBg] = ImVec4(0.10, 0.09, 0.12, 0.50) 	
    colors[clr.ScrollbarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.ScrollbarGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
    colors[clr.ScrollbarGrabHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.ScrollbarGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.ComboBg] = ImVec4(0.19, 0.18, 0.21, 0.50)
    colors[clr.CheckMark] = ImVec4(0.80, 0.80, 0.83, 0.31)
    colors[clr.SliderGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
    colors[clr.SliderGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.Button] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.ButtonHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
    colors[clr.ButtonActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.Header] = ImVec4(0.10, 0.09, 0.12, 1.00)
    --colors[clr.HeaderHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.HeaderHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
    colors[clr.HeaderActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.ResizeGrip] = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.ResizeGripHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
    colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
    colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
    colors[clr.PlotLines] = ImVec4(0.40, 0.39, 0.38, 0.63)
    colors[clr.PlotLinesHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
    colors[clr.PlotHistogram] = ImVec4(0.40, 0.39, 0.38, 0.63)
    colors[clr.PlotHistogramHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
    colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
    --colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.70)
    colors[clr.ModalWindowDarkening] = ImVec4(0.00, 0.00, 0.00, 0.80)

	colors[clr.WindowBg] = ImVec4(0.06, 0.05, 0.07, 0.98)
    --colors[clr.FrameBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.FrameBg] = ImVec4(0.13, 0.12, 0.15, 1.00)
    colors[clr.FrameBgHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
    colors[clr.FrameBgActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
	colors[clr.TitleBg] = ImVec4(0.07, 0.61, 0.92, 0.83)

end
apply_custom_style()

local fileb = getWorkingDirectory() .. "\\config\\instools.bind"
local tBindList = {}
if doesFileExist(fileb) then
	local f = io.open(fileb, "r")
	if f then
		tBindList = decodeJson(f:read())
		f:close()
	end
else
	tBindList = {
        [1] = {
            text = "/time",
            v = {key.VK_3}
        }
	}
end

local instools =
{
  main =
  {
    posX = 1738,
    posY = 974,
    widehud = 320,
    male = true,
    wanted == false,
    clear == false,
    hud = false,
    tar = '������',
	tarr = '���',
	tarb = false,
	clistb = false,
	clisto = false,
	givra = false,
    clist = 0
  },
  commands = 
  {
    ticket = false,
	zaderjka = 5
  },
   keys =
  {
	tload = 97,
	tazer = 97,
	fastmenu = 113
  }
}
cfg = inicfg.load(nil, 'instools/config.ini')

local libs = {'sphere.lua', 'rkeys.lua', 'imcustom/hotkey.lua', 'imgui.lua', 'MoonImGui.dll', 'imgui_addons.lua'}
function main()
  while not isSampAvailable() do wait(1000) end
  if seshsps == 1 then
    ftext("������ ������� ��������. /tset - �������� ����.", -1)
	ftext('������� ������� ������� �������� Damien_Requeste')
  end
  if not doesDirectoryExist('moonloader/config/instools/') then createDirectory('moonloader/config/instools/') end
  if cfg == nil then
    sampAddChatMessage("{139BEC}IT {ffffff}| ���������� ���� �������, �������.", -1)
    if inicfg.save(instools, 'instools/config.ini') then
      sampAddChatMessage("{139BEC}IT {ffffff}| ���� ������� ������� ������.", -1)
      cfg = inicfg.load(nil, 'instools/config.ini')
    end
  end
  if not doesDirectoryExist('moonloader/lib/imcustom') then createDirectory('moonloader/lib/imcustom') end
  for k, v in pairs(libs) do
        if not doesFileExist('moonloader/lib/'..v) then
            downloadUrlToFile('https://raw.githubusercontent.com/WhackerH/kirya/master/lib/'..v, getWorkingDirectory()..'\\lib\\'..v)
            print('����������� ���������� '..v)
        end
    end
	if not doesFileExist("moonloader/config/instools/keys.json") then
        local fa = io.open("moonloader/config/instools/keys.json", "w")
        fa:close()
    else
        local fa = io.open("moonloader/config/instools/keys.json", 'r')
        if fa then
            config_keys = decodeJson(fa:read('*a'))
        end
    end
  while not doesFileExist('moonloader\\lib\\rkeys.lua') or not doesFileExist('moonloader\\lib\\imcustom\\hotkey.lua') or not doesFileExist('moonloader\\lib\\imgui.lua') or not doesFileExist('moonloader\\lib\\MoonImGui.dll') or not doesFileExist('moonloader\\lib\\imgui_addons.lua') do wait(0) end
  if not doesDirectoryExist('moonloader/instools') then createDirectory('moonloader/instools') end
  hk = require 'lib.imcustom.hotkey'
  imgui.HotKey = require('imgui_addons').HotKey
  rkeys = require 'rkeys'
  imgui.ToggleButton = require('imgui_addons').ToggleButton
  while not sampIsLocalPlayerSpawned() do wait(0) end
  local _, myid = sampGetPlayerIdByCharHandle(playerPed)
  local name, surname = string.match(sampGetPlayerNickname(myid), '(.+)_(.+)')
  sip, sport = sampGetCurrentServerAddress()
  sampSendChat('/stats')
  while not sampIsDialogActive() do wait(0) end
  proverkk = sampGetDialogText()
  local frakc = proverkk:match('.+�����������%:%s+(.+)%s+����')
  local rang = proverkk:match('.+����%:%s+(.+)%s+������')
  local telephone = proverkk:match('.+�������%:%s+(.+)%s+�����������������')
  rank = rang
  frac = frakc
  tel = telephone
  sampCloseCurrentDialogWithButton(1)
  print(frakc)
  print(rang)
  print(telephone)
  ystf()
  update()
  sampCreate3dTextEx(641, '{ffffff}����� ��� ������� ��������', 4294927974, 2346.1362,1666.7819,3040.9387, 3, true, -1, -1)
  local spawned = sampIsLocalPlayerSpawned()
  for k, v in pairs(tBindList) do
		rkeys.registerHotKey(v.v, true, onHotKey)
  end
  fastsmskey = rkeys.registerHotKey(config_keys.fastsms.v, true, fastsmsk)
  sampRegisterChatCommand('r', r)
  sampRegisterChatCommand('f', f)
  sampRegisterChatCommand('dlog', dlog)
  sampRegisterChatCommand('dcol', cmd_color)
  sampRegisterChatCommand('dmb', dmb)
  sampRegisterChatCommand('smsjob', smsjob)
  sampRegisterChatCommand('where', where)
  sampRegisterChatCommand('tset', tset)
  sampRegisterChatCommand('vig', vig)
  sampRegisterChatCommand('giverank', giverank)
  sampRegisterChatCommand('invite', invite)
  sampRegisterChatCommand('oinv', oinv)
  sampRegisterChatCommand('uninvite', uninvite)
    sampRegisterChatCommand('sethud', function()
        if cfg.main.givra then
            if not changetextpos then
                changetextpos = true
                ftext('�� ���������� ������� ������� ��� ���.')
            else
                changetextpos = false
				inicfg.save(cfg, 'instools/config.ini') -- ��������� ��� ����� �������� � �������
            end
        else
            ftext('��� ������ �������� ����-���.')
        end
    end)
  sampRegisterChatCommand('yst', function() ystwindow.v = not ystwindow.v end)
  while true do wait(0)
    if #departament > 25 then table.remove(departament, 1) end
    if cfg == nil then
      sampAddChatMessage("{139BEC}IT {ffffff}| ���������� ���� �������, �������.", -1)
      if inicfg.save(instools, 'instools/config.ini') then
        sampAddChatMessage("{139BEC}IT {ffffff}| ���� ������� ������� ������.", -1)
        cfg = inicfg.load(nil, 'instools/config.ini')
      end
    end
	    local myhp = getCharHealth(PLAYER_PED)
        local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if wasKeyPressed(cfg.keys.fastmenu) and not sampIsDialogActive() and not sampIsChatInputActive() then
	if frac == 'Driving School' then
    submenus_show(fastmenu(id), "{139BEC}IT {ffffff}| ������� ����")
	else
	ftext('�������� �� �� �������� � ��������� {ff0000}[ctrl+R]')
	end
    end
          if valid and doesCharExist(ped) then
            local result, id = sampGetPlayerIdByCharHandle(ped)
            if result and wasKeyPressed(key.VK_Z) then
			if frac == 'Driving School' then
                gmegafhandle = ped
                gmegafid = id
                gmegaflvl = sampGetPlayerScore(id)
                gmegaffrak = getFraktionBySkin(id)
			    local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
                --[[ftext(gmegafid)
                ftext(gmegaflvl)
                ftext(gmegaffrak)]]
				megaftimer = os.time() + 300
                submenus_show(pkmmenu(id), "{139BEC}Inst Tools {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] {ffffff}������� - "..sampGetPlayerScore(id).." ")
				else
			ftext('�������� �� �� �������� � ��������� {ff0000}[ctrl+R]')
				end
            end
        end
	if cfg.main.givra == true then
      infbar.v = true
      imgui.ShowCursor = false
    end
    if cfg.main.givra == false then
      infbar.v = false
      imgui.ShowCursor = false
    end
		if changetextpos then
            sampToggleCursor(true)
            local CPX, CPY = getCursorPos()
            cfg.main.posX = CPX
            cfg.main.posY = CPY
        end
		imgui.Process = second_window.v or third_window.v or bMainWindow.v or ystwindow.v or updwindows.v or infbar.v
  end
  function rkeys.onHotKey(id, keys)
	if sampIsChatInputActive() or sampIsDialogActive() or isSampfuncsConsoleActive() then
		return false
	end
end
end

local fpt = [[
�������� �� ��������:

������������ �����
��� ����������� � ����� �� 1 �� 2-� ���: 500$.
��� ����������� � ����� �� 3� - �� 5-�� ���: 5.000$.
��� ����������� � ����� �� 6-�� �� 15-�� ���: 10.000$.
��� ����������� � ����� �� 16 ���: 30.000$.
�����������
������� ������ �����: 2.000$.
������ ���������
������� ������ �����: 5.000$.
��������� ���������
������� ������ �����: 10.000$.
�� ������
������� ������ �����: 50.000$.
�� ������
������� ������ �����: 100.000$.

����� ��������� ���������:

[1] ����� ��������� ���������:

� 1.1 ����� ��������� ������������� ���������, ������� ������ ��������� ��� ���������� ���������.
� 1.2 ���������� ��������� ������� ����������� ������� �� ���������.
� 1.3 ���������� ��������� ������� ����������� ����������� ����� ��������.
� 1.4 ���������� ��������� ����� �������� �� ������ ���. �������� ��� ������� ��������.
� 1.5 �������� ������ �� ����������� ��� �� ���������������.
� 1.6 ��������� ����� ��������� � ��������� ��� ���������� �� ����������� ��������� � ����� ����� ( � ����� ����, � ��� ����� /f, /fb, /b, /sms ).
� 1.7 ����� ����� ���� ������� � ����� ����� ����������� ���������.


[2] ����������� ����������� ���������:

� 2.1 ��������� ��������� ������ ��������� ����� ���������. 
� 2.2 ��������� ��������� ������ ����� � ��������� ��� ������� � ������ �����. 
� 2.3 ��������� ��������� ������ ������� �� ���������� ����������� ��� ������������ ��������.
� 2.4 ��������� ��������� ������ �������� ������ ��������� ��������� � �������� ������� ���.
� 2.5 ��������� ���������, ������ ��� ������ ��������, ������ ��������� ������� � ������� � ��������� ����� �� �������� ��� �������. ������� ������ �������� ��� �������� � ���������� ������ ������� � ��������� �������� ����������;?
� 2.6 ��������� ��������� ������� �������������� ������� � ����������� �����;?
� 2.7 ��������� ��������� ������� ������� �� ����� � �������� ����� ����������� � �������������� ��������;?
� 2.8 ��������� ��������� ������� �������� �� ���������� ������������ �������, �������� �������� � ���. �� �������, �� ����������� � ������ ������������, ��������� � ����� �� ��������;?
� 2.9 ���������� ������� ������ �������� �������� �������������� � ���� ��� ����� ������.
� 2.9.1 ���������� �������� ������� ������� ������ ������� - � 15. 
� 2.9.2 C��������� ��� ������ ������� ������ ������� - � 4. 
� 2.9.3 ����� ������ ����� ������� �12.
� 2.9.4 ����������� ����� ������ ����� ������� �8.
� 2.9.5 ��������� ������ Inspection Department ������ ������ ������� �21.
� 2.9.6 ��������� ������ ���������� ������ ������ ������� �6.
� 2.9.7 ������������� �� ������ � ������� ������� �26
� 2.9.8 ��������� ������� ���������� ������������� �� ������ ������ ������ ������� � 19.
� 2.9.9 ���������� ����������� �� ���������� ������� ������ ������� ������� - � 23.
� 2.9.10 ������� ��������� ������ ������ ������� - � 28.
� 2.10 ��������� ��������� ������ ����������� ������� �� ���������.
� 2.11 � ������� ����� ��������� ������ ������ �������� �������� � �����.
� 2.12 ��������� ��������� ������ ������� ����� ����� ��������� �� ��������� "�����������". (���������� ��� ������ �� ����� ����������).
� 2.13 ��������� ��������� ������ ����������� ����������� ����� ��������.
� 2.14 ��������� ��������� ������ ����� ������ � ������� ������ � ����� ���������. (����������: �������� ������� ��������� ����� � ������� ������ � ����� ��������� � �� �������� � ������ �����������)
� 2.15 ��������� ���������, ����������� � ��������� ��.��������� � ����, ������ ��������� ������ ������ ���� �� 00:00.
� 2.16 ��������� ���������, ����������� � ��������� ��.��������� � ����, ������ ����������� �� ����� � ������ ����������/���������/���������. 
� 2.17 ������ ��������� ����� ����� (������) � ������� ������ ������ ��������� �� ����� �����.
� 2.18 ��������� ���������, ��������� �������� �� ������ ��� ��������� ��������� �������� ������� I �������;
� 2.19 ��������� ���������, ���������� ��������� ��.����������� � ����, ������ �������� �� ������ �� ������ ��������.


[3] ������� ���� � ���������:

� 3.1 � �����, ������� ���� ������ � 09:00 �� 20:00. � �������� ��� ������� ���� ������ � 10:00 �� 19:00.
� 3.2 ����� ��� �������� (�����) � 13:00 �� 14:00.
� 3.3 � ������� ����� ��������� ������ ����� ����������. (����������: ����, ����, ��� � ��������)
� 3.4 ��������� �������� ���� � ������� ����� ��� ���������� ��.�������.
� 3.5 ����� �������� �� ������, ���������� �� ����� ���������� � 15 �����.
� 3.6 ������ ���������, ������������ �� ������ �� ����� ��������, ������ ��������� ���� ��������, �������� �� ���� ����������� ���������.(�� ����� ��� �� 10 �����)
� 3.7 �� ������� ��������� ����� �������� �� ������ ����� ����� ����� �������� ���.
� 3.8 ��������� ���������� �� ������������� ������� � ������� �����.
� 3.9 ��������� � ������� �������� ��� �������� �� �� ���������������, � ����� ��������� �� (����� / Base Jump / Paint Ball), �� ��� ���� �������� � �����, ��� �� ������������� �� �����������;?
� 3.10 ��������� �������� ���� ��� �������� ��������, ���������� ������ ���. ������������, � ����� ����� ��������.?


[4] ����������� ��������� �����������:

� 4.1 �������� ������� ����� ��� ���������� �������.
� 4.2 �������� ������� ��������� ����� ��� ������� ������.
� 4.3 ������ ������ �� �� ����� ���������.
� 4.4 ����� �������� ��� ����������.
� 4.5 ������ ��������.
� 4.6 ��������� ���������� � ������������ �������, ���� � ��� � ���� ������ ���������;?
� 4.7 ��������� �������� �������� ��� ���������� ��������;?
� 4.8 ��������� ������� � ����������� � ���������� ������� ������ � ������;?
� 4.9 �������� ���� � ����� ��������.
� 4.10 ���������� � ������ � ������� �����.
� 4.11 ������ ����� ����������, �� ����������� ����� � ����� � �������.
� 4.12 ����� ����� ������ ����� (600 ������) ������ ��� �� ����� �������� ���. ����������: ������ � ������ �����, ������ � ��. �������� (�����) ��� ���������� ������������.
� 4.13 �� ��� ��� ESC ������� ��������� �� ��������������, �� ����������.?
� 4.14 �������� ��������� � ��������� ��� ���������� �� ����������� ��������� � ����� ����� ( � ����� ����, � ��� ����� /f, /fb, /b, /sms ).
� 4.15 ������������ ���������, ������������� ���������, � ������ �����.
� 4.16 �������� �� ����� ��������������� ������, �� ������ ������� �����.
� 4.17 �������� ������������� ������� � ������� �����.
� 4.18 ����������� ������������ ���������� � ��������
� 4.19 ��������� ������������ ����� � ������� ������ � ��������������� ����������.
� 4.20 ��������� �������� �������� �� ������ ��� ��������� ���������.
� 4.21 ��������� ������������ ����������� ��������� (��� � IC ��� � � OOC ����)
� 4.22 ��������� ������� ����������� ��������� � ������������� ��������.


[5] �������� � ����������� ������� ���������:

� 5.1 � ������� ������ ��������� ������ ���������� � ��������� �������� ���������.
� 5.2 ���������� �������� ������� ��� ��������� �� ����� ���� � �����.
� 5.3 �������� � ���� � ����� ����������� ����� ������ � ��������� "�����������".
� 5.4 ������ ������ ����� ���� ��������� � ��������� ����������� � ����.
� 5.5 ������������ ����� ������ ����� ���� ��������� � ��������� ��. ����������� � ����.


[6] ��������� �� ��������� ������:

� 6.1 �� ��������� ������, ��������� ����� �������� ��������� �� ���������� �������� ������� ���������.

���������������� �����:

���������������� ����� - ��������� ������������ ����, ��� ������ ������� ������������ ����������� ��������������� �������� ������������ ��������� � �������������� ������ ��� (������������ �������� � ����� ������ ����������� ���������� ��������). 
�� ������� ������������ ������� ����, ������, � ������������������ ����� ���� ������� ������ ����, � ���� ��������� �����, ������� ��� �� �������� �� ����� ���� ����������� ��������� ���������� �����, �����, ��� � ��� ������� ������.

����� ������� ����� ������� �����, ��� ���������������� ����� ����������� ��������� ������������ ���������� ������������ ����������� �� ��� ���������. � ����������� � ��� ����� ������ ��� ����������� �� ���������. 
��� �� �� ������? ��������� ������ ������ ���� �� ����� ������� ������ ����� ��-�� ����, ��� �������� ����� �� ������ �����������, ������ ������� ��������� ����� ������ � ���������� ��� ������ �����, ��� ��� ����������� � ������� ��, � ������ ���������� ��������� ������ ���� ����������� �����������, ��� � ��������� � �������, ��� � �� ���������� ���������������� ����������.

� ������������ �������� � ��������� ����� ����������� ���� ��� �� ��������� ��������, � ����������� �������� - �������� ������������. 
� ������� ��������� "���������� �����", ��� ������� ��������� ��� �� ����� � �������� ����� � ����� ������� ����� ��������� ������������, �����������, ��������������� �������, � ����� ��������� ��������� ���� ���������� ���� ��������� ���� �������. 
� �� ����� ����������� ����� ���������� ����� �����, ���� �� ��� "��� � ���� �������" - ���������� ���� � ���-�� �������, � ���� � ��� ���� ��������� ������� �� � /sms ���. 
� ��� ��������� ������������. 
� ������� � ��������� ���������� � �������� ������ ��� �� ���������, ���� ��� ������� ��� �� � ���-�� �� ����, �� ������ ������ � ��. 
� �� ����������� ������ ���������� ������� ����������� ���������� � �� ��������, ������� ����� �������� ��������� ���������� � ���� ( �������� ���� ����� �������� ������ ����, ����������� ������ � ��, ����� �� ����� ����� ���������� ��� ������, ����� �������������).

����������:

�� ��������� ���� ������ � IC �� ������ ������� � �������� "��������� ����. �����". 
�� ��������� ���� ������ � ��� �� ������ ������� � �������� "���������� ���������", �������� �� ������� ��� ���� �� ��������� ����� ���������� ��������.
]]

function dmb()
	lua_thread.create(function()
		status = true
		players2 = {'{ffffff}���� ��������\t{ffffff}���\t{ffffff}����\t{ffffff}������'}
		players1 = {'{ffffff}���\t{ffffff}����'}
		sampSendChat('/members')
		while not gotovo do wait(0) end
		if gosmb then
			sampShowDialog(716, "{ffffff}� ����: "..gcount.." | {ae433d}����������� | {ffffff}Time: "..os.date("%H:%M:%S"), table.concat(players2, "\n"), "x", _, 5) -- ���������� ����������.
		elseif krimemb then
			sampShowDialog(716, "{ffffff}� ����: "..gcount.." | {ae433d}����������� | {ffffff}Time: "..os.date("%H:%M:%S"), table.concat(players1, "\n"), "x", _, 5) -- ���������� ����������.
		end
		gosmb = false
		krimemb = false
		gotovo = false
		status = false
		gcount = nil
	end)
end

function dmch()
	lua_thread.create(function()
		statusc = true
		players3 = {'{ffffff}���\t{ffffff}����\t{ffffff}������'}
		sampSendChat('/members')
		while not gotovo do wait(0) end
		if gosmb then
			sampShowDialog(716, "{139BEC}Inst Tools {ffffff}| {ae433d}���������� ��� ����� {ffffff}| Time: "..os.date("%H:%M:%S"), table.concat(players3, "\n"), "x", _, 5) -- ���������� ����������.
		end
		gosmb = false
		krimemb = false
		gotovo = false
		statusc = false
	end)
end

function dlog()
    sampShowDialog(97987, '{139BEC}Inst Tools {ffffff} | ��� ��������� ������������', table.concat(departament, '\n'), '�', 'x', 0)
end

function vig(pam)
  local id, pric = string.match(pam, '(%d+)%s+(.+)')
  if rank == '��.��������' or rank == '��.��������' or rank == '��������' or  rank == '�����������' then
  if id == nil then
    sampAddChatMessage("{139BEC}Inst Tools {ffffff}| �������: /vig ID �������", -1)
  end
  if id ~=nil and not sampIsPlayerConnected(id) then
    sampAddChatMessage("{139BEC}Inst Tools {ffffff}| ����� � ID: "..id.." �� ��������� � �������.", -1)
  end
  if id ~= nil and sampIsPlayerConnected(id) then
      if pric == nil then
        sampAddChatMessage("{139BEC}Inst Tools {ffffff}| �������: /vig ID �������", -1)
      end
      if pric ~= nil then
	   if cfg.main.tarb then
        name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
        sampSendChat(string.format("/r [%s]: %s - �������� ������� �� �������: %s.", cfg.main.tarr, rpname, pric))
		else 
		name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
		sampSendChat(string.format("/r %s - �������� ������� �� �������: %s.", rpname, pric))
      end
  end
end
end
end

function where(params) -- ������ ��������������
   if rank == '�����������' or rank == '��.��������' or rank == '��.��������' or rank == '��������' or  rank == '�����������' then
	if params:match("^%d+") then
		params = tonumber(params:match("^(%d+)"))
		if sampIsPlayerConnected(params) then
			local name = string.gsub(sampGetPlayerNickname(params), "_", " ")
			 if cfg.main.tarb then
			    sampSendChat(string.format("/r [%s]: %s, �������� ���� ��������������. �� ����� 20 ������.", cfg.main.tarr, name))
			else
			sampSendChat(string.format("/r %s, �������� ���� ��������������. �� ����� 20 ������.", name))
			end
			else
			ftext('{FFFFFF} ����� � ������ ID �� ��������� � ������� ��� ������ ��� ID.', 0x046D63)
		end
		else
		ftext('{FFFFFF} �����������: /where [ID].', 0x046D63)
		end
		else
		ftext('{FFFFFF}������ ������� �������� � 6 �����.', 0x046D63)
	end
end

function getrang(rangg)
local ranks = 
        {
		['1'] = '������',
		['2'] = '������������',
		['3'] = '������������',
		['4'] = '��.�����������',
		['5'] = '�����������',
		['6'] = '������������',
		['7'] = '��.���������',
		['8'] = '��.���������',
		['9'] = '���������'
		}
	return ranks[rangg]
end

function giverank(pam)
    lua_thread.create(function()
    local id, rangg, plus = pam:match('(%d+) (%d+)%s+(.+)')
	if sampIsPlayerConnected(id) then
	  if rank == '��.��������' or rank == '��.��������' or rank == '��������' or  rank == '�����������' then
        if id and rangg then
		if plus == '-' or plus == '+' then
		ranks = getrang(rangg)
		        local _, handle = sampGetCharHandleBySampPlayerId(id)
				if doesCharExist(handle) then
				local x, y, z = getCharCoordinates(handle)
				local mx, my, mz = getCharCoordinates(PLAYER_PED)
				local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)	
				if dist <= 5 then
				if cfg.main.male == true then
				sampSendChat('/me ���� ������ ������� � �������� �������� ��������')
				wait(1500)
				sampSendChat('/me ����� ������ ������� � ������')
				wait(1500)
                sampSendChat(string.format('/me ������ ����� ������� %s', ranks))
				wait(1500)
				sampSendChat('/me �������� �� ������� �������� �������� ����� �������')
				wait(1500)
				else
				sampSendChat('/me ����� ������ ������� � �������� �������� ��������')
				wait(1500)
				sampSendChat('/me ������ ������ ������� � ������')
				wait(1500)
                sampSendChat(string.format('/me ������� ����� ������� %s', ranks))
				wait(1500)
				sampSendChat('/me ��������� �� ������� �������� �������� ����� �������')
				wait(1500)
				end
				end
				end
				sampSendChat(string.format('/giverank %s %s', id, rangg))
				wait(1500)
				if cfg.main.tarb then
                sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - %s � ��������� �� %s%s.', cfg.main.tarr, plus == '+' and '�������(�)' or '�������(�)', ranks, plus == '+' and ', ����������' or ''))
                else
				sampSendChat(string.format('/r '..sampGetPlayerNickname(id):gsub('_', ' ')..' - %s � ��������� �� %s%s.', plus == '+' and '�������(�)' or '�������(�)', ranks, plus == '+' and ', ����������' or ''))
            end
			else 
			ftext('�� ����� �������� ��� [+/-]')
		end
		else 
			ftext('�������: /giverank [id] [����] [+/-]')
		end
		else 
			ftext('������ ������� �������� � 7 �����')
	  end
	  else 
			ftext('����� � ������ ID �� ��������� � ������� ��� ������ ��� ID')
	  end
   end)
 end

function invite(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
	  if rank == '��������' or  rank == '�����������' then
        if id then
		if sampIsPlayerConnected(id) then
                sampSendChat('/me ������(�) ������� � �������(�) ��� '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
				wait(1500)
				sampSendChat(string.format('/invite %s', id))
			else 
			ftext('����� � ������ ID �� ��������� � ������� ��� ������ ��� ID')
		end
		else 
			ftext('�������: /invite [id]')
		end
		else 
			ftext('������ ������� �������� � 9 �����')
	  end
   end)
 end
 
 function oinv(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
		local _, handle = sampGetCharHandleBySampPlayerId(id)
	if id then
	if doesCharExist(handle) then
		local x, y, z = getCharCoordinates(handle)
		local mx, my, mz = getCharCoordinates(PLAYER_PED)
		local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)	
	  if dist <= 5 then
	  if cfg.main.tarb then
		if sampIsPlayerConnected(id) then
                submenus_show(oinvite(id), "{139BEC}IT {ffffff}| ����� ������")
				else 
			ftext('����� � ������ ID �� ��������� � ������� ��� ������ ��� ID')
            end
		else 
			ftext('�������� ������� � ����������')
		end
		else 
			ftext('����� � ���� ��� ������� ��������')
	  end
	  else 
			ftext('����� � ���� ��� ������� ��������')
	end
	  else 
			ftext('�������: /oinv [id]')
	end
	  end)
   end
 
 function uninvite(pam)
    lua_thread.create(function()
        local id, pri4ina = pam:match('(%d+)%s+(.+)')
	  if rank == '��.��������' or rank == '��������' or  rank == '�����������' then
        if id and pri4ina then
		if sampIsPlayerConnected(id) then
                sampSendChat('/me ������(�) ����� � ������� � '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
				wait(2000)
				sampSendChat(string.format('/uninvite %s %s', id, pri4ina))
			else 
			ftext('����� � ������ ID �� ��������� � ������� ��� ������ ��� ID')
		end
		else 
			ftext('�������: /uninvite [id] [�������]')
		end
		else 
			ftext('������ ������� �������� � 8 �����')
	  end
   end)
 end
 
function oinvite(id)
 return
{
  {
   title = "{FFFFFF}����� {139BEC}����������",
    onclick = function()
	sampSendChat('/me ������(�) ������� ���������� �� � �������(�) ��� '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(1500)
	sampSendChat('/b /clist 6')
	wait(1500)
	sampSendChat('/b ��� � /r [��������� ��]')
	wait(1500)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - ����� ��������� ��.', cfg.main.tarr))
	end
   },
   {
   title = "{FFFFFF}����� {139BEC}��������",
    onclick = function()
	sampSendChat('/me ������(�) ������� ���������� �� � �������(�) ��� '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(1500)
	sampSendChat('/b /clist 21')
	wait(1500)
	sampSendChat('/b ��� � /r [��������� ��]')
	wait(1500)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - ����� ��������� ��.', cfg.main.tarr))
	end
   },
 }
end
function fastmenu(id)
 return
{
  {
   title = "{FFFFFF}���� {139BEC}������",
    onclick = function()
	submenus_show(fthmenu(id), "{139BEC}IT {ffffff}| ���� ������")
	end
   },
    {
   title = "{FFFFFF}���� {139BEC}���.�������� {ff0000}(��� ��.�������)",
    onclick = function()
	if rank == '��.��������' or rank == '��.��������' or rank == '��������' or  rank == '�����������' then
	submenus_show(govmenu(id), "{139BEC}IT {ffffff}| ���� ���.��������")
	else
	ftext('�� �� ���������� � ��.�������')
	end
	end
   },
   {
   title = "{FFFFFF}���� {139BEC}�������",
    onclick = function()
	if cfg.main.tarb then
	submenus_show(otmenu(id), "{139BEC}IT {ffffff}| ���� �������")
	else
	ftext('�������� ������� � ����������')
	end
	end
   },
   {
   title = "{FFFFFF}�������� �������� {139BEC}� ����� ����� ����� � /d{ff0000}(��� 4+ �����)",
    onclick = function()
	if rank == '��.����������' or rank == '����������' or rank == '�����������' or rank == '��.��������' or rank == '��.��������' or rank == '��������' or  rank == '�����������' then
	sampSendChat(string.format('/d OG, �������������� �������� �������� � ����� ����� �����. ���: %s.', tel))
	else
	ftext('��� ���� ������������ �����')
	end
	end
   },
   {
   title = "{FFFFFF}������ {139BEC}����������� ����������� �� � �����",
    onclick = function()
	pX, pY, pZ = getCharCoordinates(playerPed)
	if getDistanceBetweenCoords3d(pX, pY, pZ, 2351.8020, 1660.9800, 3041.0605) < 50 then
	dmch()
	else
	ftext('�� ������ ���������� � �����')
	end
	end
   },
   {
   title = "{FFFFFF}�������� � ����� � �������� �������� {ff0000}(����������� ��� ��������)",
    onclick = function()
    if cfg.main.tarb then
        sampSendChat(string.format('/r [%s]: ������ �� �������� ��������.', cfg.main.tarr))
        else
        sampSendChat(string.format('/r ������ �� �������� ��������.'))
        end
		dostavka = true
	end
   }
}
end

function otmenu(id)
 return
{
  {
   title = "{FFFFFF}���� ������ � ����� (��) {ff0000}(��� ����/����� ������)",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	sampSendChat(string.format('/r [%s]: ��������� ����������, ��������� ��������.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: � ����� ���������� ������������ ���������� �����������.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: �������� � ����� ����� � ��������� "�����������".', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: ��� ��������� ���������� ������ �� �.'..myid..'.', cfg.main.tarr))
	end
   },
    {
   title = "{FFFFFF}���� ������ � ����� (ID) {ff0000}(��� ����/����� ������)",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	sampSendChat(string.format('/r [%s]: ��������� ����������, ��������� ��������.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: � ����� �������� ������������ ���������� �����������.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: �������� � ����� ����� � ��������� "�����������".', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: ��� ��������� ���������� ������ �� �.'..myid..'.', cfg.main.tarr))
	end
   },
   {
   title = "{FFFFFF}���.������ ���� ���.�����������",
    onclick = function()
	if cfg.main.male == true then
	sampSendChat("/me ������� ������ � ����������� ���.�����������")
    wait(3500)
    sampSendChat("/me ����� ����������� ������� ��������� ����������")
    wait(3500)
    sampSendChat("/me ������ �����")
    wait(3500)
    sampSendChat("/do ����� ������.")
	wait(3500)
	sampSendChat("/me ������ � �������� ��� ������������ ������� � ����� ����������� ���������")
	wait(3500)
	sampSendChat("/try ��������� � �����")
	wait(3500)
	sampSendChat("/me ����� ��������� �������� � �����.")
	wait(3500)
	sampSendChat("/try �������� � �����")
	wait(3500)
	sampSendChat("/me ��������� ���������� �� ������� �����������")
	wait(3500)
	sampSendChat("/try ����������� �� ����������")
	wait(3500)
	sampSendChat("/me ������ ������� � ������, ����� ���� ������� ��� ���������� ��������")
	wait(3500)
	sampSendChat("/me �������� ������� � ������ �������")
	wait(1200)
        sampSendChat("/time")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
	end
	if cfg.main.male == false then
	sampSendChat("/me �������� ������ � ����������� ���.�����������")
    wait(3500)
    sampSendChat("/me ������ ����������� ������� ��������� ����������")
    wait(3500)
    sampSendChat("/me ������� �����")
    wait(3500)
    sampSendChat("/do ����� ������.")
	wait(3500)
	sampSendChat("/me ������� � �������� ��� ������������ ������� � ������ ����������� ���������")
	wait(3500)
	sampSendChat("/try ��������� � �����")
	wait(3500)
	sampSendChat("/me ������ ��������� �������� � �����.")
	wait(3500)
	sampSendChat("/try �������� � �����")
	wait(3500)
	sampSendChat("/me ��������� ���������� �� ������� �����������")
	wait(3500)
	sampSendChat("/try ����������� �� ����������")
	wait(3500)
	sampSendChat("/me ������� ������� � ������, ����� ���� �������� ��� ���������� ��������")
	wait(3500)
	sampSendChat("/me ��������� ������� � ������� �������")
	wait(1200)
        sampSendChat("/time")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
	end
	end
   }
}
end

function govmenu(id)
 return
{
  {
   title = "{FFFFFF}�������������",
    onclick = function()
	sampSendChat("/d OG, ����� ����� ��������������� ��������.")
    wait(5000)
    sampSendChat("/gov [Instructors]: ��������� ������ �����, �����y����, �����y����� ����������.")
    wait(5000)
    sampSendChat('/gov [Instructors]: � ������ ������ � ����� ��������� �������� ������������� �� ��������� "������".')
    wait(5000)
    sampSendChat("/gov [Instructors]: ���������� � �����������: ����� ��� ���������� � �����, �������������������, �������� ���.")
    wait(5000)
    sampSendChat("/d OG, ��������� ����� ��������������� ��������.")
	end
   },
    {
   title = "{FFFFFF}������ �� ������������",
    onclick = function()
	sampSendChat("/d OG, ����� ����� ��������������� ��������.")
        wait(5000)
        sampSendChat("/gov [Instructors]: ��������� ������ �����, �����y����, �����y����� ����������.")
        wait(5000)
        sampSendChat('/gov [Instructors]: � ������ ������ ������� ��������� �� ��������� "�����������".')
        wait(5000)
        sampSendChat("/gov [Instructors]: �� ����� ����������, �� ������ ������������ �� ��.������� �����. ")
        wait(5000)
        sampSendChat("/d OG, ��������� ����� ��������������� ��������.")
	end
   },
   {
   title = "{FFFFFF}���� ������� �����",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat("/d OG, ����� ����� ��������������� ��������.")
        wait(5000)
        sampSendChat("/gov [Instructors]: ��������� ������ �����, �����y����, �����y����� ����������.")
        wait(5000)
        sampSendChat('/gov [Instructors]: ��������� ����������� � ������������� ������ �� ������ �������� � ����� �������.')
        wait(5000)
        sampSendChat('/gov [Instructors]: ������ ��������� �� ������ ����� �����. � ���������, '..rank..' ��������� - '..myname:gsub('_', ' ')..'.')
        wait(5000)
        sampSendChat("/d OG, ��������� ����� ��������������� ��������.")
	end
   },
   {
   title = "{FFFFFF}������ ���. �����",
    onclick = function()
	sampSetChatInputEnabled(true)
	sampSetChatInputText("/d OG, ������� ���.����� �� X. ���������� �� �.")
	end
   },
   {
   title = "{FFFFFF}��������� � ����� ���. �����",
    onclick = function()
	sampSetChatInputEnabled(true)
	sampSetChatInputText("/d OG, ��������� ��� ����� ���.�������� �� X �� Inst.")
	end
   },
   {
   title = "{FFFFFF}���� ����� cash back {139BEC}",
    onclick = function()
	sampSendChat("/d OG, ��� ����������� ���. �������� Cash Back �� �������� ���������� 100 ���������.")
	wait(10000)
	sampSendChat("/d OG, ��������� � ��������� ����� ����� ������������ �� ��. �������.")
	end
   },
   {
   title = "{FFFFFF}���� ����� cash back {139BEC}[����� 2] (���� 2-�� ������� �� ���������)",
    onclick = function()
	sampSendChat("/d OG, ��������� � ��������� ����� ����� ������������ �� ��. �������.")
	end
   }
}
end

function fastsmsk()
	if lastnumber ~= nil then
		sampSetChatInputEnabled(true)
		sampSetChatInputText("/t "..lastnumber.." ")
	else
		ftext("�� ����� �� �������� �������� ���������.", 0x046D63)
	end
end

function fthmenu(id)
 return
{
  {
    title = "{FFFFFF}������ ��� {139BEC}������",
    onclick = function()
	    sampSendChat("�����������. �� ������� �� ���������� � ���������. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me �������(�) ������� ������� ��������� ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b /clist 23 ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("���������� ������ �� ���� �������, ���� �� �� ������ �������� �� ������������. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("��������� ������� ��������� ��� ���������� �� ����������� ��������� � ����� �����. ��� ������ ���� ��� �������. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("����������� �������: ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("�������� ��� �������� ������� � ������� � ���. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("� ������� ����� ���������� � �����. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("������� ����� � ������� ���������. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("��� ��������� � ���������, ��� ����� ����� ����� �������.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("����� � ��� ����� ���� ������� - ��� ��������� �� ������������. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("������� ������� �� ���� ������: ����� � �������� �� ��������. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("������� ��������� �� ������ ��� ����� 3 ���� ����� ��������.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b ����� � �������� �� �������� ����� ����� �� ������. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("���� ��������� ������ �������:")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("������ ����� �������� ������ �����. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("��������� ��������� ����������, ����������� �� ��������� ����� � ����������� (�� ������). ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("���� ��������� �������� ������ � ���������� ��. �������. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("�������� ����� ����� ���� ������ � ���������� ��. �������. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("�� ������� ����� ���������. ����� ��������� ������ � ������� ������. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('/b � ���� "������ ��� ��������" ���� ��� ������ �����, ��� ��� �� ��������! ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("���� ��������� ������� ����������� � ����������� �� ���� � ��. �������. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("�������,��� ���������� ��� ������. ")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("���� � ��� ������� �������, ���������. ")
		wait(1200)
		if cfg.main.hud then
        sampSendChat("/time")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
    end
  },
   {
    title = "{FFFFFF}������ ��� {139BEC}������������",
    onclick = function()
	sampSendChat("�����������")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("��������� �� ������� �� ������ �� ��������� ������������, ��� ���������� ������������ � �������.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b /clist 4")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("�� - ����� ����������, ������������ ��������������� ��������� �������.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("�� - ����� ��������, ������������ ������������� ��������� � ��������� ��������.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("� �������� ����������, ����� ���������� ������ � �������� ���. ��������")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("����� 4-� ���� �������� ������.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("�� �������� ������� ��.����������� � ������ ��������� ����������� �����������.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("��������� ������� ��������� ��� ���������� �� ����������� ��������� � ����� �����.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("��� ������ ���� ������ ��������� - ���������� � ��. �������")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("���� ��������� �������� ������ � ���������� ��. �������.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("�������� ����� ����� ���� ������ � ���������� ��. �������.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("�� ������� ����� ���������. ����� ��������� ������ � ������� ������.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("��������� ��������� ����������, ����������� �� ��������� ����� � ����������� (�� ������).")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('/b � ���� "������ ��� ��������" ���� ��� ������ �����, ��� ��� �� ��������!')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("���� ��������� ������� ����������� � ����������� �� ���� � ��. �������.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("�������, ��� ���������� ��� ������.")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("���� � ��� ������� �������, ���������. ")
		wait(1200)
		if cfg.main.hud then
        sampSendChat("/time")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
	end
   },
   {
    title = "{FFFFFF}������ ��� {139BEC}���",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("���� �����������. � ��������� ��������� "..myname:gsub('_', ' ')..". ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('������ � ������� ������ �� ���� "���". ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("������ �������� ������ ���� ���������� ������ ������������... ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("... � ������ ����� ����� �������� ��������. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("�������� ������ ���������� ��������� � ����������� ������ ��� ��������. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("� ������, ���� ��������� ������ ��� ������� ��������� ���������� �������� ����������...")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("...��� ������� �� ������� � ��������� ��������. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("� ����� ���������� ���������� �����: ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("� �������� ������ ����������� �������� ������������ ������� �� ��������� �� ����� 50 ��/�.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("� ����� ����� � �� �������� ����������� �������� �������� �� ����� 30 ��/�.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("�� ��������� ������� � �� ��������������� ����������� �� �������� ���. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("���� ��������� ���, �������� ������ ������� ������� � ����� ������� �����������. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("����� �� �������� ������ � ����� �������, ��� ���� �������� ������ ���������...")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("... ��� ��������� ������ �������� ��� ������. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("��������� �������� � ������������ ������. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("��������� �����������: ������� ������, ���������� ��� ����� ���������� ����� (�������). ")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("�������� �����������: ")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("���������� �������� ������. ")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("��������� ���������� �������� �� ������������ ������� ������. ")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("�������� ����� ��� ��� �������������� � ������ ���������� ����� ���. ")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("��������� ������ ������ ������������ ���������. ")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("������� �� ���� � ��������� ���������. ")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("�� ���� ������ ��������. ������� �� ��������.")
		wait(1200)
		if cfg.main.hud then
        sampSendChat("/time")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
	end
   },
   {
    title = "{FFFFFF}������ ��� {139BEC}���������� ��������� � �������",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("���� �����������. � ��������� ��������� "..myname:gsub('_', ' ')..". ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('������ � ������� ������ �� ���� "��������� � �������".')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("��������� ��������� ������ ������ �� ���� �� ���� ��������")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("��� ����������� ������� �������� �������� ����������. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("������ ��������� ������������ � ������:")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("1.�����������, ��� ��������� �� ���. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("2.��� ���������� ����� ��������� ������������.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("3.�� ������� ������� �����, ������� �� ��� ����������. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("��� �� �����, ���������� ��� �������� ��������� � �������: ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("1.��������� ������ ������ � �������� ���� � ����������� ������. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("2.��������� ����������� ������ ���������. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("3.��������� ������������� ������� ��� ������� �������.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("4.��������� ����������� ������ ��� ���������� ������ �����. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("� ������ ��������� ���� ������, � ��� ����� ������ ��������. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("��� �� �� �������� ��������� ��� ����� ��������� ��� ������. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("�� ���� ���, ������� �� ��������.")
		wait(1200)
		if cfg.main.hud then
        sampSendChat("/time")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
	end
   },
      {
    title = "{FFFFFF}������ ��� {139BEC}������� ���������� ������ �����������",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("���� �����������. � ��������� ��������� "..myname:gsub('_', ' ')..". ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('������ � ������� ������ �� ���� "������� ���������� ������ �����������".')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("1. ������, ��� ���������� � �������� �� ������:")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("��������� � ����������� ������.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("���������, ��� �� ������������ � ������� �����.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("���������, �� ������ �� �� ����� � ����� �������� �� ����� ���������� ������ �����������.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("������������ � ������������ ��������� ��� ������� �������� � ����� (������).")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("2. �����������:")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("���������� ���������� ������ ����������� ������� ���� ��� ��������������� �� �� ����������, �������� �����.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("�������� � �������� � ������� ������������ ���������, ���� ���� ����� �� ����������� ����������� ������.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("���������� ����� � ��������� ���������.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("��������� ������ ��� �������� �����.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("����������� � ������ ����� �� ������ �� ����� �� ��������.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("���������� ������������� � ����������� ����� �� �����, ��� ����� �� ���������������.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("��������� ����� ������� ������������� ��������, �������� �������, ������������ ��������� � ���������.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("��������� ������������ � �������� � �������� ���������� ������ �����������.")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("�� ���� ���, ������� �� ��������.")
		wait(1200)
		if cfg.main.hud then
        sampSendChat("/time")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
	end
   },
         {
    title = '{FFFFFF}������ {139BEC}"��� ����� ���� � ������������� ���������"',
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("���� �����������. � ��������� ��������� "..myname:gsub('_', ' ')..". ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('������ � ������� ������ �� ���� "��� ���� ����� � ������������� ���������".')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("������� ��������� �����, � ����� ��� � �������������� �� ������������.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("��� ������� ����, ������� �������� ��������.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("������ ��� ������� ���� �� ������� ������ ����������.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("- ������ ����������������� ��������� ������ �������� ��������...")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("...������ ��������� �������� ��-�� ��������������� �������.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("- �� ��� ����������� �� ������, ��������� ���� - ���������� �� �������� ���������� ������� ��������.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("- ������� ����� ������������ ���� �� ��������� ���������: ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("1. ���������� ����������.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("����� ��������� ���������� ����������, �� ���� ���������� �������� �������� ���� �� ������.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("2.��������� ������ �������� ��� ���������.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("���� ������� ������ ���, �� ����� ��������� ������ ������� �� ������ �������� � �������� ���������.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("3. ���������� ����������.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("��������� � ������� ����������� ������ ���� �����: ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("������, ����� ��� ������ �����, � ���� ����������� ��������� ��������.")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("��� ����� �������, ������ �� ������� ��� ���������� � �������.")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("������ � ����� ����������� ��������.")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("����� ����������� �������� ����� ������� ����������� �����������.")
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat("����� ��������� � �����������.")
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat("���������� ��� ����� �������� ����� ��� �������, ���� � ������ � ���������.")
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat("� ����� ��������� � ������ ����������, �������� ������, ���������.")
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat("��� ���� ����� �������� ������� ��������� ����������.")
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat("������� �� ���������� � �� ������� ������ ���� � �������� ���-�� �����.")
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat("�� ���� ��, ������� �� ��������, �������� ���� � ����� �������.")
		wait(1200)
		if cfg.main.hud then
        sampSendChat("/time")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
	end
   },
        {
    title = "{FFFFFF}������ ��� {139BEC}������� ������ �����",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("���� �����������. � ��������� ��������� "..myname:gsub('_', ' ')..". ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('������ � ������� ������ �� ���� "������� ������ �����".')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("1. ������� ������ �����:")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("������ ���� ����������� ������ � ����������� ������. (������ �� ����� �.���-������ � �� ����� ������ � �.���-��������)")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("������ ����� ��������� ������ ������������ �������� ������. (���� ������ � ����� ������� ���� ��������)")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("������ ����� ��������� ������������� � ����� ����������� ������.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("2. �����������:")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("������ ���� � �����.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("������ ���� � ����������� ���������� � ����������� �������, � ������� �����������, � �������������� ������� ������.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("������ ���� ��� ������� �������� ��������.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("������ ���� � ������� 500 ������ �� ��������, ���������� ����.")
		wait(1200)
		if cfg.main.hud then
        sampSendChat("/time")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
	end
   },
      {
    title = "{FFFFFF}������ ��� {139BEC}�������������",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("���� �����������. � ��������� ��������� "..myname:gsub('_', ' ')..". ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('������ � ������� ������ �� ���� "�������������". ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("1. ������� �������������: ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("��� ���������� ������ ����� ����� ��������� ��� ���������� � �� ����������� �� ���������� �����. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("����� ������� ������ ���� ��������� ������� �� ������� �� ������ ��������� �����. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("������������� ������ ����������� ������ ��� ������� �������. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("��������� ����� ������� ������������� ��������, �������� �������, ������������ ��������� � ���������.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("��������� ������������ � �������� � �������� ������. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("������ � ��������� � ������� �����, ���������� � ������� ��� �� �������� ������. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("����� ��� ����������� �������� � ����������� ����� �� �������� ��������� �� ������ ����� 300 ������.")
       wait(cfg.commands.zaderjka * 1000)
        sampSendChat("��������� ��������� ����� ������������� ������ ����������. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("�� ���� ���, ������� �� ��������.")
		wait(1200)
		if cfg.main.hud then
        sampSendChat("/time")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
	end
   }
}
end

do

function imgui.OnDrawFrame()
   if first_window.v then
	local tagfr = imgui.ImBuffer(u8(cfg.main.tarr), 256)
	local tagb = imgui.ImBool(cfg.main.tarb)
	local clistb = imgui.ImBool(cfg.main.clistb)
	local autoscr = imgui.ImBool(cfg.main.hud)
	local hudik = imgui.ImBool(cfg.main.givra)
	local clisto = imgui.ImBool(cfg.main.clisto)
	local stateb = imgui.ImBool(cfg.main.male)
	local waitbuffer = imgui.ImInt(cfg.commands.zaderjka)
	local clistbuffer = imgui.ImInt(cfg.main.clist)
    local iScreenWidth, iScreenHeight = getScreenResolution()
	local btn_size = imgui.ImVec2(-0.1, 0)
    imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(7, 3))
    imgui.Begin(u8'���������##1', first_window, imgui.WindowFlags.NoResize)
	imgui.PushItemWidth(200)
	imgui.AlignTextToFramePadding(); imgui.Text(u8("������������ �������"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'������������ �������', tagb) then
    cfg.main.tarb = not cfg.main.tarb
    end
	if tagb.v then
	if imgui.InputText(u8'������� ��� ���.', tagfr) then
    cfg.main.tarr = u8:decode(tagfr.v)
    end
	imgui.Text(u8("����-��� ������ ��������"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'��������/��������� ����-���', hudik) then
        cfg.main.givra = not cfg.main.givra
		ftext(cfg.main.givra and '����-��� �������, ���������� ��������� /sethud' or '����-��� ��������')
    end
	end
	imgui.Text(u8("������� ����� �� ��������� ���"))
	imgui.SameLine()
    if imgui.HotKey(u8'##������� ����� ���', config_keys.fastsms, tLastKeys, 100) then
	    rkeys.changeHotKey(fastsmskey, config_keys.fastsms.v)
		ftext('������� ������� ��������. ������ ��������: '.. table.concat(rkeys.getKeysName(tLastKeys.v), " + ") .. ' | ����� ��������: '.. table.concat(rkeys.getKeysName(config_keys.fastsms.v), " + "))
		saveData(config_keys, 'moonloader/config/instools/keys.json')
	end
	imgui.Text(u8("������������ ���������"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'������������ ���������', clistb) then
        cfg.main.clistb = not cfg.main.clistb
    end
    if clistb.v then
        if imgui.SliderInt(u8"�������� �������� ������", clistbuffer, 0, 33) then
            cfg.main.clist = clistbuffer.v
        end
		imgui.Text(u8("������������ ��������� ����������"))
	    imgui.SameLine()
		if imgui.ToggleButton(u8'������������ ��������� ����������', clisto) then
        cfg.main.clisto = not cfg.main.clisto
        end
    end
	imgui.Text(u8("������� ���������"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'������� ���������', stateb) then
        cfg.main.male = not cfg.main.male
    end
	if imgui.SliderInt(u8'�������� � ������� (���)', waitbuffer,  4, 10) then
     cfg.commands.zaderjka = waitbuffer.v
    end
	imgui.Text(u8("��������� ������"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'��������� ������', autoscr) then
        cfg.main.hud = not cfg.main.hud
    end
    if imgui.CustomButton(u8('��������� ���������'), imgui.ImVec4(0.08, 0.61, 0.92, 0.40), imgui.ImVec4(0.08, 0.61, 0.92, 1.00), imgui.ImVec4(0.08, 0.61, 0.92, 0.76), btn_size) then
	ftext('��������� ������� ���������.', -1)
    inicfg.save(cfg, 'instools/config.ini') -- ��������� ��� ����� �������� � �������
    end
    imgui.End()
   end
    if ystwindow.v then
                imgui.LockPlayer = true
                imgui.ShowCursor = true
                local iScreenWidth, iScreenHeight = getScreenResolution()
                imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
                imgui.SetNextWindowSize(imgui.ImVec2(iScreenWidth/2, iScreenHeight / 2), imgui.Cond.FirstUseEver)
                imgui.Begin(u8('Inst Tools | ����� ��'), ystwindow)
                for line in io.lines('moonloader\\instools\\ystav.txt') do
                    imgui.TextWrapped(u8(line))
                end
                imgui.End()
            end
  if second_window.v then
    imgui.LockPlayer = true
    imgui.ShowCursor = true
    local iScreenWidth, iScreenHeight = getScreenResolution()
    local btn_size1 = imgui.ImVec2(70, 0)
	local btn_size = imgui.ImVec2(130, 0)
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
    imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(7, 3))
    imgui.Begin('Inst Tools | Main Menu', second_window, imgui.WindowFlags.NoResize)
	local text = '�����������:'
    imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8(text)).x)/3)
    imgui.Text(u8(text))
	imgui.SameLine()
	imgui.TextColored(imgui.ImVec4(0.90, 0.16 , 0.30, 1.0), 'Damien_Requeste')
    imgui.Separator()
	if imgui.Button(u8'������', imgui.ImVec2(50, 30)) then
      bMainWindow.v = not bMainWindow.v
    end
	imgui.SameLine()
    if imgui.Button(u8'��������� �������', imgui.ImVec2(120, 30)) then
      first_window.v = not first_window.v
    end
	imgui.SameLine()
    if imgui.Button(u8'������������� ������', imgui.ImVec2(150, 30)) then
      showCursor(false)
      thisScript():reload()
    end
	imgui.SameLine()
    if imgui.Button(u8'������', imgui.ImVec2(55, 30)) then
      helps.v = not helps.v
    end
	imgui.Separator()
	imgui.BeginChild("����������", imgui.ImVec2(410, 100), true)
	imgui.Text(u8 '��� � �������:   '..sampGetPlayerNickname(myid):gsub('_', ' ')..'')
	imgui.Text(u8 '���������:') imgui.SameLine() imgui.Text(u8(rank))
	imgui.Text(u8 '����� ��������:   '..tel..'')
	if cfg.main.tarb then
	imgui.Text(u8 '��� � �����:') imgui.SameLine() imgui.Text(u8(cfg.main.tarr))
	end
	if cfg.main.clistb then
	imgui.Text(u8 '����� ��������:   '..cfg.main.clist..'')
	end
	imgui.EndChild()
	imgui.Separator()
	imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8("������� ����: %s")).x)/3.5)
	imgui.Text(u8(string.format("������� ����: %s", os.date())))
    imgui.End()
  end
  	if infbar.v then
                _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
                local myname = sampGetPlayerNickname(myid)
                local myping = sampGetPlayerPing(myid)
                imgui.SetNextWindowPos(imgui.ImVec2(cfg.main.posX, cfg.main.posY), imgui.ImVec2(0.5, 0.5))
                imgui.SetNextWindowSize(imgui.ImVec2(cfg.main.widehud, 180), imgui.Cond.FirstUseEver)
                imgui.Begin('������� ��������', infbar, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoTitleBar)
                imgui.CentrText(u8'������� �������� �� �����:')
                imgui.Separator()
				imgui.Text(u8 '������������ �����:') imgui.SameLine() imgui.Text(u8 ''..prava..'')
				imgui.Text(u8 '�������� ������:') imgui.SameLine() imgui.Text(u8 ''..pilot..'')
				imgui.Text(u8 '�������� �� ������:') imgui.SameLine() imgui.Text(u8 ''..kater..'')
				imgui.Text(u8 '�������� ��������:') imgui.SameLine() imgui.Text(u8 ''..ribolov..'')
				imgui.Text(u8 '�������� �� ������:') imgui.SameLine() imgui.Text(u8 ''..gun..'')
				imgui.Text(u8 '�������� �� ������:') imgui.SameLine() imgui.Text(u8 ''..biznes..'')
                imgui.End()
    end
    if helps.v then
                local iScreenWidth, iScreenHeight = getScreenResolution()
                imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(7, 3))
                imgui.Begin(u8 '������ �� �������', helps, imgui.WindowFlags.NoResize, imgui.WindowFlags.NoCollapse)
				imgui.BeginChild("������ ������", imgui.ImVec2(495, 230), true, imgui.WindowFlags.VerticalScrollbar)
                imgui.BulletText(u8 '/tset - ������� ���� �������')
                imgui.Separator()
                imgui.BulletText(u8 '/vig [id] [�������] - ������ ������� �� �����')
                imgui.BulletText(u8 '/dmb - ������� /members � �������')
                imgui.BulletText(u8 '/where [id] - ��������� �������������� �� �����')
                imgui.BulletText(u8 '/yst - ������� ����� ��')
				imgui.BulletText(u8 '/smsjob - ������� �� ������ ���� ��.������ �� ���')
                imgui.BulletText(u8 '/dlog - ������� ��� 25 ��������� ��������� � �����������')
				imgui.BulletText(u8 '/sethud - ���������� ������� ����-����')
				imgui.Separator()
                imgui.BulletText(u8 '�������: ')
                imgui.BulletText(u8 '���+Z �� ������ - ���� ��������������')
                imgui.BulletText(u8 'F2 - "������� ����"')
				imgui.EndChild()
                imgui.End()
    end
    if updwindows.v then
                local updlist = ttt
                imgui.LockPlayer = true
                imgui.ShowCursor = true
                local iScreenWidth, iScreenHeight = getScreenResolution()
                imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
                imgui.SetNextWindowSize(imgui.ImVec2(700, 330), imgui.Cond.FirstUseEver)
                imgui.Begin(u8('Inst Tools | ����������'), updwindows, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
                imgui.Text(u8('����� ���������� ������� Inst Tools �� ������ '..updversion..'. ��� �� ���������� ������� ������ �����. ������ ���������:'))
                imgui.Separator()
                imgui.BeginChild("uuupdate", imgui.ImVec2(690, 200))
                for line in ttt:gmatch('[^\r\n]+') do
                    imgui.Text(line)
                end
                imgui.EndChild()
                imgui.Separator()
                imgui.PushItemWidth(305)
                if imgui.Button(u8("��������"), imgui.ImVec2(339, 25)) then
                    lua_thread.create(goupdate)
                    updwindows.v = false
                end
                imgui.SameLine()
                if imgui.Button(u8("�������� ����������"), imgui.ImVec2(339, 25)) then
                    updwindows.v = false
                end
                imgui.End()
            end
  if bMainWindow.v then
  local iScreenWidth, iScreenHeight = getScreenResolution()
	local tLastKeys = {}
   
   imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
   imgui.SetNextWindowSize(imgui.ImVec2(800, 530), imgui.Cond.FirstUseEver)

   imgui.Begin(u8("IT | ������##main"), bMainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
	imgui.BeginChild("##bindlist", imgui.ImVec2(795, 442))
	for k, v in ipairs(tBindList) do
		if hk.HotKey("##HK" .. k, v, tLastKeys, 100) then
			if not rkeys.isHotKeyDefined(v.v) then
				if rkeys.isHotKeyDefined(tLastKeys.v) then
					rkeys.unRegisterHotKey(tLastKeys.v)
				end
				rkeys.registerHotKey(v.v, true, onHotKey)
			end
		end
		imgui.SameLine()
		if tEditData.id ~= k then
			local sText = v.text:gsub("%[enter%]$", "")
			imgui.BeginChild("##cliclzone" .. k, imgui.ImVec2(500, 21))
			imgui.AlignTextToFramePadding()
			if sText:len() > 0 then
				imgui.Text(u8(sText))
			else
				imgui.TextDisabled(u8("������ ��������� ..."))
			end
			imgui.EndChild()
			if imgui.IsItemClicked() then
				sInputEdit.v = sText:len() > 0 and u8(sText) or ""
				bIsEnterEdit.v = string.match(v.text, "(.)%[enter%]$") ~= nil
				tEditData.id = k
				tEditData.inputActve = true
			end
		else
			imgui.PushAllowKeyboardFocus(false)
			imgui.PushItemWidth(500)
			local save = imgui.InputText("##Edit" .. k, sInputEdit, imgui.InputTextFlags.EnterReturnsTrue)
			imgui.PopItemWidth()
			imgui.PopAllowKeyboardFocus()
			imgui.SameLine()
			imgui.Checkbox(u8("����") .. "##editCH" .. k, bIsEnterEdit)
			if save then
				tBindList[tEditData.id].text = u8:decode(sInputEdit.v) .. (bIsEnterEdit.v and "[enter]" or "")
				tEditData.id = -1
			end
			if tEditData.inputActve then
				tEditData.inputActve = false
				imgui.SetKeyboardFocusHere(-1)
			end
		end
	end
	imgui.EndChild()

	imgui.Separator()

	if imgui.Button(u8"�������� �������") then
		tBindList[#tBindList + 1] = {text = "", v = {}}
	end

   imgui.End()
  end
  end
end

function onHotKey(id, keys)
	local sKeys = tostring(table.concat(keys, " "))
	for k, v in pairs(tBindList) do
		if sKeys == tostring(table.concat(v.v, " ")) then
			if tostring(v.text):len() > 0 then
				local bIsEnter = string.match(v.text, "(.)%[enter%]$") ~= nil
				if bIsEnter then
					sampProcessChatInput(v.text:gsub("%[enter%]$", ""))
				else
					sampSetChatInputText(v.text)
					sampSetChatInputEnabled(true)
				end
			end
		end
	end
end

function showHelp(param) -- "��������" ��� �������
    imgui.TextDisabled('(?)')
    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
        imgui.PushTextWrapPos(imgui.GetFontSize() * 35.0)
        imgui.TextUnformatted(param)
        imgui.PopTextWrapPos()
        imgui.EndTooltip()
    end
end

function onScriptTerminate(scr)
	if scr == script.this then
		if doesFileExist(fileb) then
			os.remove(fileb)
		end
		local f = io.open(fileb, "w")
		if f then
			f:write(encodeJson(tBindList))
			f:close()
		end
		local fa = io.open("moonloader/config/instools/keys.json", "w")
        if fa then
            fa:write(encodeJson(config_keys))
            fa:close()
        end
	end
end

addEventHandler("onWindowMessage", function (msg, wparam, lparam)
	if msg == wm.WM_KEYDOWN or msg == wm.WM_SYSKEYDOWN then
		if tEditData.id > -1 then
			if wparam == key.VK_ESCAPE then
				tEditData.id = -1
				consumeWindowMessage(true, true)
			elseif wparam == key.VK_TAB then
				bIsEnterEdit.v = not bIsEnterEdit.v
				consumeWindowMessage(true, true)
			end
		end
	end
end)

function submenus_show(menu, caption, select_button, close_button, back_button)
    select_button, close_button, back_button = select_button or '�', close_button or 'x', back_button or '�'
    prev_menus = {}
    function display(menu, id, caption)
        local string_list = {}
        for i, v in ipairs(menu) do
            table.insert(string_list, type(v.submenu) == 'table' and v.title .. ' �' or v.title)
        end
        sampShowDialog(id, caption, table.concat(string_list, '\n'), select_button, (#prev_menus > 0) and back_button or close_button, sf.DIALOG_STYLE_LIST)
        repeat
            wait(0)
            local result, button, list = sampHasDialogRespond(id)
            if result then
                if button == 1 and list ~= -1 then
                    local item = menu[list + 1]
                    if type(item.submenu) == 'table' then -- submenu
                        table.insert(prev_menus, {menu = menu, caption = caption})
                        if type(item.onclick) == 'function' then
                            item.onclick(menu, list + 1, item.submenu)
                        end
                        return display(item.submenu, id + 1, item.submenu.title and item.submenu.title or item.title)
                    elseif type(item.onclick) == 'function' then
                        local result = item.onclick(menu, list + 1)
                        if not result then return result end
                        return display(menu, id, caption)
                    end
                else -- if button == 0
                    if #prev_menus > 0 then
                        local prev_menu = prev_menus[#prev_menus]
                        prev_menus[#prev_menus] = nil
                        return display(prev_menu.menu, id - 1, prev_menu.caption)
                    end
                    return false
                end
            end
        until result
    end
    return display(menu, 31337, caption or menu.title)
end

function r(pam)
    if #pam ~= 0 then
        if cfg.main.tarb then
            sampSendChat(string.format('/r [%s]: %s', cfg.main.tarr, pam))
        else
            sampSendChat(string.format('/r %s', pam))
        end
    else
        ftext('������� /r [�����]')
    end
end
function f(pam)
    if #pam ~= 0 then
        if cfg.main.tarb then
            sampSendChat(string.format('/f [%s]: %s', cfg.main.tarr, pam))
        else
            sampSendChat(string.format('/f %s', pam))
        end
    else
        ftext('������� /f [�����]')
    end
end
function ftext(message)
    sampAddChatMessage(string.format('%s %s', ctag, message), 0x139BEC)
end

function tset()
  if frac == 'Driving School' then
  second_window.v = not second_window.v
  else
  ftext('�������� �� �� �������� � ��������� {ff0000}[ctrl+R]')
  end
end	

function tloadtk()
    if tload == true then
     sampSendChat('/tload'..u8(cfg.main.norma))
    else if tload == false then
     sampSendChat("/tunload")
    end
  end
end
function imgui.CentrText(text)
            local width = imgui.GetWindowWidth()
            local calc = imgui.CalcTextSize(text)
            imgui.SetCursorPosX( width / 2 - calc.x / 2 )
            imgui.Text(text)
        end
        function imgui.CustomButton(name, color, colorHovered, colorActive, size)
            local clr = imgui.Col
            imgui.PushStyleColor(clr.Button, color)
            imgui.PushStyleColor(clr.ButtonHovered, colorHovered)
            imgui.PushStyleColor(clr.ButtonActive, colorActive)
            if not size then size = imgui.ImVec2(0, 0) end
            local result = imgui.Button(name, size)
            imgui.PopStyleColor(3)
            return result
        end

function pkmmenu(id)
    local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
    return
    {
      {
        title = "{ffffff}� ����������",
        onclick = function()
        pID = tonumber(args)
        submenus_show(instmenu(id), "{139BEC}Inst Tools {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
	  {
        title = "{ffffff}� ���� ��������",
        onclick = function()
        pID = tonumber(args)
	    pX, pY, pZ = getCharCoordinates(playerPed)
	    if sampGetPlayerNickname(Damien_Requeste) or dostavka or rank == '��.��������' or rank == '��.��������' or rank == '��������' or rank == '�����������' or getDistanceBetweenCoords3d(pX, pY, pZ, 2345.4177, 1667.5751, 3040.9524) < 2 or getDistanceBetweenCoords3d(pX, pY, pZ, 357.9535, 173.4858, 1008.3893) < 6 then
        submenus_show(pricemenu(id), "{139BEC}Inst Tools {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
		else
	    ftext('�� ������ ���������� �� �������')
		end
        end
      },
      {
        title = "{ffffff}� �������",
        onclick = function()
        pID = tonumber(args)
		pX, pY, pZ = getCharCoordinates(playerPed)
		if sampGetPlayerNickname(Damien_Requeste) or rank == '��.��������' or rank == '��.��������' or rank == '��������' or  rank == '�����������' or getDistanceBetweenCoords3d(pX, pY, pZ, 2345.4177, 1667.5751, 3040.9524) < 2 or getDistanceBetweenCoords3d(pX, pY, pZ, 357.9535, 173.4858, 1008.3893) < 6 then
        submenus_show(questimenu(id), "{139BEC}Inst Tools {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
		else
	    ftext('�� ������ ���������� �� �������')
		end
        end
      },
      {
        title = "{ffffff}� ����������",
        onclick = function()
        pID = tonumber(args)
		pX, pY, pZ = getCharCoordinates(playerPed)
		if sampGetPlayerNickname(Damien_Requeste) or dostavka or rank == '��.��������' or rank == '��.��������' or rank == '��������' or  rank == '�����������' or getDistanceBetweenCoords3d(pX, pY, pZ, 2345.4177, 1667.5751, 3040.9524) < 2 or getDistanceBetweenCoords3d(pX, pY, pZ, 357.9535, 173.4858, 1008.3893) < 6 then
        submenus_show(oformenu(id), "{139BEC}Inst Tools {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
		else
	    ftext('�� ������ ���������� �� �������')
        end
		end
      },
	  {
        title = "{ffffff}� ������� �������",
        onclick = function()
		if cfg.main.male == true then
        sampSendChat("/me ���� ����� � �����")
        wait(1500)
        sampSendChat("/itazer")
        wait(1500)
        sampSendChat("/me ������� ����� �� ����")
        end
	    if cfg.main.male == false then
        sampSendChat("/me ����� ����� � �����")
        wait(1500)
        sampSendChat("/itazer")
        wait(1500)
        sampSendChat("/me �������� ����� �� ����")
        end
		end
      }
    }
end

function questimenu(args)
    return
    {
      {
        title = '{5b83c2}� ������ �������� �� ��� �',
        onclick = function()
        end
      },
      {
        title = '{ffffff}� ���� ��������',
        onclick = function()
          sampSendChat("������ � ����� ��� ���� �������� �� ���. ������?")
		end
      },
      {
        title = '{ffffff}� �����{ff0000} 50 ��/�',
        onclick = function()
        sampSendChat("����� ������������ �������� ��������� � ������?")
        end
      },
      {
        title = '{ffffff}� ����� ���������{ff0000} 30 ��/�',
        onclick = function()
        sampSendChat("����� ������������ �������� ��������� � ����� ���������?")
        end
      },
      {
        title = '{ffffff}� �����{ff0000} � ����� �������.',
        onclick = function()
        sampSendChat("� ����� ������� �������� �����?")
        end
      },
      {
        title = '{ffffff}� ���',
        onclick = function()
        sampSendChat("�� ������ � ���. ���� ��������?")
		wait(1500)
		ftext("{FFFFFF}- ���������� �����: {A52A2A}������� ������ ������ ������������. ������� ��� � �� � ����� �� ��������.", -1)
        end
      },
	  {
        title = '{ffffff}� �������� ��� ���������',
        onclick = function()
        sampSendChat("�� ���� ���� ���������� � ���������� �������. ���� ��������?")
		wait(1500)
		ftext("{FFFFFF}- ���������� �����: {A52A2A}������� �������� � ��������� � �������.", -1)
        end
      },
	  {
        title = '{5b83c2}� ������ ������ ��������',
        onclick = function()
        end
      },
      {
        title = '{ffffff}���� ������� ������',
        onclick = function()
        sampSendChat("����� ��� �������� �� ������?")
        end
      },
	  {
        title = '{ffffff}�������� ������',
        onclick = function()
        sampSendChat("��� �� ������ ������� ������?")
        end
      }
    }
end

function oformenu(id)
    return
    {
      {
        title = '{5b83c2}� ������ ���������� �',
        onclick = function()
        end
      },
      {
        title = '{ffffff}� �����.',
        onclick = function()
          sampSendChat("/do ���� � ����������� � ����� �����������.")
		  wait(1700)
		  sampSendChat("/me ���������(�) ����, ����� ���� ������(�) ������ ����� � ����� ��� ���������")
		  wait(1700)
		  sampSendChat("/me �������(�) ���������� ������ ����������")
		  wait(1700)
		  sampSendChat("/do �������� � ����.")
		  wait(1700)
		  sampSendChat('/me ��������(�) ������ "Autoschool San Fierro" � �������(�) �������� '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
		  wait(1700)
		  sampSendChat("/givelicense "..id)
		  wait(1700)
		  sampCloseCurrentDialogWithButton(1)
		  wait(1700)
		  sampSendChat("����� �� �������.")
		  if getDistanceBetweenCoords3d(pX, pY, pZ, 2351.8020, 1660.9800, 3041.0605) < 50 then
		  dostavka = false
		  end
		end
      },
      {
        title = '{ffffff}� �������',
        onclick = function()
          sampSendChat("/do ���� � ����������� � ����� �����������.")
		  wait(1700)
		  sampSendChat("/me ���������(�) ����, ����� ���� ������(�) ������ ����� � ����� ��� ���������")
		  wait(1700)
		  sampSendChat("/me �������(�) ���������� ������ ����������")
		  wait(1700)
		  sampSendChat("/do �������� � ����.")
		  wait(1700)
		  sampSendChat('/me ��������(�) ������ "Autoschool San Fierro" � �������(�) �������� '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
		  wait(1700)
		sampSendChat("/givelicense "..id)
		wait(1700)
		sampSetCurrentDialogListItem(2)
		wait(1700)
		sampCloseCurrentDialogWithButton(1)
		if getDistanceBetweenCoords3d(pX, pY, pZ, 2351.8020, 1660.9800, 3041.0605) < 50 then
		  dostavka = false
		end
        end
      },
      {
        title = '{ffffff}� �����',
        onclick = function()
          sampSendChat("/do ���� � ����������� � ����� �����������.")
		  wait(1700)
		  sampSendChat("/me ���������(�) ����, ����� ���� ������ ������ ����� � ����� ��� ���������")
		  wait(1700)
		  sampSendChat("/me �������(�) ���������� ������ ����������")
		  wait(1700)
		  sampSendChat("/do �������� � ����.")
		  wait(1700)
		  sampSendChat('/me ��������(�) ������ "Autoschool San Fierro" � �������(�) �������� '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
		  wait(1700)
		sampSendChat("/givelicense "..id)
		wait(1700)
		sampSetCurrentDialogListItem(1)
		wait(1700)
		sampCloseCurrentDialogWithButton(1)
		if getDistanceBetweenCoords3d(pX, pY, pZ, 2351.8020, 1660.9800, 3041.0605) < 50 then
		  dostavka = false
		end
        end
      },
      {
        title = '{ffffff}� ������{ff0000} �� 2 ������.',
        onclick = function()
          sampSendChat("/do ���� � ����������� � ����� �����������.")
		  wait(1700)
		  sampSendChat("/me ���������(�) ����, ����� ���� ������(�) ������ ����� � ����� ��� ���������")
		  wait(1700)
		  sampSendChat("/me �������(�) ���������� ������ ����������")
		  wait(1700)
		  sampSendChat("/do �������� � ����.")
		  wait(1700)
		  sampSendChat('/me ��������(�) ������ "Autoschool San Fierro" � �������(�) �������� '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
		  wait(1700)
		sampSendChat("/givelicense "..id)
		wait(1700)
		sampSetCurrentDialogListItem(4)
		wait(1700)
		sampCloseCurrentDialogWithButton(1)
		if getDistanceBetweenCoords3d(pX, pY, pZ, 2351.8020, 1660.9800, 3041.0605) < 50 then
		  dostavka = false
		end
        end
      },
      {
        title = '{ffffff}� �����',
        onclick = function()
          sampSendChat("/do ���� � ����������� � ����� �����������.")
		  wait(1700)
		  sampSendChat("/me ���������(�) ����, ����� ���� ������ ������ ����� � ����� ��� ���������")
		  wait(1700)
		  sampSendChat("/me �������(�) ���������� ������ ����������")
		  wait(1700)
		  sampSendChat("/do �������� � ����.")
		  wait(1700)
		  sampSendChat('/me �������� ������ "Autoschool San Fierro" � �������(�) �������� '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
		  wait(1700)
		sampSendChat("/givelicense "..id)
		wait(1700)
		sampSetCurrentDialogListItem(3)
		wait(1700)
		sampCloseCurrentDialogWithButton(1)
		if getDistanceBetweenCoords3d(pX, pY, pZ, 2351.8020, 1660.9800, 3041.0605) < 50 then
		  dostavka = false
		end
        end
      },
      {
        title = '{ffffff}� ������',
        onclick = function()
          sampSendChat("/do ���� � ����������� � ����� �����������.")
		  wait(1700)
		  sampSendChat("/me ���������(�) ����, ����� ���� ������(�) ������ ����� � ����� ��� ���������")
		  wait(1700)
		  sampSendChat("/me �������(�) ���������� ������ ����������")
		  wait(1700)
		  sampSendChat("/do �������� � ����.")
		  wait(1700)
		  sampSendChat('/me ��������(�) ������ "Autoschool San Fierro" � �������(�) �������� '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
		  wait(1700)
        sampSendChat("/givelicense "..id)
		wait(1700)
		sampSetCurrentDialogListItem(5)
		wait(1700)
		sampCloseCurrentDialogWithButton(1)
		if getDistanceBetweenCoords3d(pX, pY, pZ, 2351.8020, 1660.9800, 3041.0605) < 50 then
		  dostavka = false
		end
        end
      },
	  {
        title = '{ffffff}� ���������� ���������',
        onclick = function()
        sampSendChat("/do ���� � ����������� � ����� �����������.")
		wait(1700)
		  sampSendChat("/me ���������(�) ����, ����� ���� ������(�) ������ ������ ������� � ����� �� ���������")
		  wait(1700)
		  sampSendChat("/me �������(�) ���������� ������ ����������")
		  wait(1700)
		  sampSendChat("/do ������ �������� � ����.")
		  wait(1700)
		sampSendChat('/me ���������(�) ������ "Autoschool San Fierro" � �������(�) �������� '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
		if getDistanceBetweenCoords3d(pX, pY, pZ, 2351.8020, 1660.9800, 3041.0605) < 50 then
		  dostavka = false
		end
        end
      }
    }
end

function saveData(table, path)
	if doesFileExist(path) then os.remove(path) end
    local sfa = io.open(path, "w")
    if sfa then
        sfa:write(encodeJson(table))
        sfa:close()
    end
end

function pricemenu(args)
    return
    {
      {
        title = '{5b83c2}� ������ ��������� �',
        onclick = function()
        end
      },
      {
        title = '{ffffff}� �����.',
        onclick = function()
		if gmegaflvl <= 2 then
          sampSendChat("��������� ������ �������� ���������� - 500$.")
		  wait(1500)
		  sampSendChat("���������?")	  
		else if gmegaflvl <= 5 then
		  sampSendChat("��������� ������ �������� ���������� - 5.000$.")
		  wait(1500)
		  sampSendChat("���������?")	  
		else if gmegaflvl <= 15 then
		  sampSendChat("��������� ������ �������� ���������� - 10.000$.")
		  wait(1500)
		  sampSendChat("���������?")	  
		else if gmegaflvl >= 16 then
		  sampSendChat("��������� ������ �������� ���������� - 30.000$.")
		  wait(1500)
		  sampSendChat("���������?")	  
        end
		end
		end
		end
		end
      },
      {
        title = '{ffffff}� �������',
        onclick = function()
        sampSendChat("��������� ������ �������� ���������� - 2.000$.")
		wait(1500)
		sampSendChat("���������?")
        end
      },
      {
        title = '{ffffff}� �����',
        onclick = function()
        sampSendChat("��������� ������ �������� ���������� - 10.000$.")
		wait(1500)
		sampSendChat("���������?")
        end
      },
      {
        title = '{ffffff}� ������{ff0000} �� 2 ������.',
        onclick = function()
		if gmegaflvl > 1 then
        sampSendChat("��������� ������ �������� ���������� - 50.000$.")
		wait(1500)
		sampSendChat("���������?")
		else
		sampSendChat("������ �������� ����� ���������� � 2-� ��� � �����.")
		end
        end
      },
	  {
        title = '{ffffff}� ������{ff0000} ��� ������� �������.',
        onclick = function()
        sampSendChat("��������� ������ �������� ���������� - 100.000$.")
		wait(1500)
		sampSendChat("���������?")
        end
      },
      {
        title = '{ffffff}� �����',
        onclick = function()
        sampSendChat("��������� ������ �������� ���������� - 5.000$.")
		wait(1500)
		sampSendChat("���������?")
        end
      },
      {
        title = '{ffffff}� ��������',
        onclick = function()
        sampSendChat("����������� - 2.000$, ����� - 5.000$, �������� ������ - 10.000$, �������� �� ������ - 50.000$.")
        end
      }
    }
end

function instmenu(id)
    return
    {
      {
        title = '{5b83c2}� ������ ����������� �',
        onclick = function()
        end
      },
      {
        title = '{ffffff}� �����������.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("������������. � ��������� ��������� "..myname:gsub('_', ' ')..", ��� ���� ������?")
		wait(1500)
		sampSendChat('/do �� ������� ������� � �������� "'..rank..' | '..myname:gsub('_', ' ')..'".')  
		end
      },
      {
        title = '{ffffff}� �������',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat("��� �������, ����������.")
		wait(1500)
		sampSendChat("/b /showpass "..myid.."")
        end
      },
	  {
        title = '{ffffff}� ����������� � ��������',
        onclick = function()
        sampSendChat("������� �� �������, ����� ��� �������.")
        end
      }
    }
end

function ystf()
    if not doesFileExist('moonloader/instools/ystav.txt') then
        local file = io.open("moonloader/instools/ystav.txt", "w")
        file:write(fpt)
        file:close()
        file = nil
    end
end

function getFraktionBySkin(playerid)
    fraks = {
        [0] = '�����������',
        [1] = '�����������',
        [2] = '�����������',
        [3] = '�����������',
        [4] = '�����������',
        [5] = '�����������',
        [6] = '�����������',
        [7] = '�����������',
        [8] = '�����������',
        [9] = '�����������',
        [10] = '�����������',
        [11] = '�����������',
        [12] = '�����������',
        [13] = '�����������',
        [14] = '�����������',
        [15] = '�����������',
        [16] = '�����������',
        [17] = '�����������',
        [18] = '�����������',
        [19] = '�����������',
        [20] = '�����������',
        [21] = 'Ballas',
        [22] = '�����������',
        [23] = '�����������',
        [24] = '�����������',
        [25] = '�����������',
        [26] = '�����������',
        [27] = '�����������',
        [28] = '�����������',
        [29] = '�����������',
        [30] = 'Rifa',
        [31] = '�����������',
        [32] = '�����������',
        [33] = '�����������',
        [34] = '�����������',
        [35] = '�����������',
        [36] = '�����������',
        [37] = '�����������',
        [38] = '�����������',
        [39] = '�����������',
        [40] = '�����������',
        [41] = 'Aztec',
        [42] = '�����������',
        [43] = '�����������',
        [44] = 'Aztec',
        [45] = '�����������',
        [46] = '�����������',
        [47] = 'Vagos',
        [48] = 'Aztec',
        [49] = '�����������',
        [50] = '�����������',
        [51] = '�����������',
        [52] = '�����������',
        [53] = '�����������',
        [54] = '�����������',
        [55] = '�����������',
        [56] = 'Grove',
        [57] = '�����',
        [58] = '�����������',
        [59] = '���������',
        [60] = '�����������',
        [61] = '�����',
        [62] = '�����������',
        [63] = '�����������',
        [64] = '�����������',
        [65] = '�����������', -- ��� ��������
        [66] = '�����������',
        [67] = '�����������',
        [68] = '�����������',
        [69] = '�����������',
        [70] = '���',
        [71] = '�����������',
        [72] = '�����������',
        [73] = 'Army',
        [74] = '�����������',
        [75] = '�����������',
        [76] = '�����������',
        [77] = '�����������',
        [78] = '�����������',
        [79] = '�����������',
        [80] = '�����������',
        [81] = '�����������',
        [82] = '�����������',
        [83] = '�����������',
        [84] = '�����������',
        [85] = '�����������',
        [86] = 'Grove',
        [87] = '�����������',
        [88] = '�����������',
        [89] = '�����������',
        [90] = '�����������',
        [91] = '�����������', -- ��� ��������
        [92] = '�����������',
        [93] = '�����������',
        [94] = '�����������',
        [95] = '�����������',
        [96] = '�����������',
        [97] = '�����������',
        [98] = '�����',
        [99] = '�����������',
        [100] = '������',
        [101] = '�����������',
        [102] = 'Ballas',
        [103] = 'Ballas',
        [104] = 'Ballas',
        [105] = 'Grove',
        [106] = 'Grove',
        [107] = 'Grove',
        [108] = 'Vagos',
        [109] = 'Vagos',
        [110] = 'Vagos',
        [111] = 'RM',
        [112] = 'RM',
        [113] = 'LCN',
        [114] = 'Aztec',
        [115] = 'Aztec',
        [116] = 'Aztec',
        [117] = 'Yakuza',
        [118] = 'Yakuza',
        [119] = 'Rifa',
        [120] = 'Yakuza',
        [121] = '�����������',
        [122] = '�����������',
        [123] = 'Yakuza',
        [124] = 'LCN',
        [125] = 'RM',
        [126] = 'RM',
        [127] = 'LCN',
        [128] = '�����������',
        [129] = '�����������',
        [130] = '�����������',
        [131] = '�����������',
        [132] = '�����������',
        [133] = '�����������',
        [134] = '�����������',
        [135] = '�����������',
        [136] = '�����������',
        [137] = '�����������',
        [138] = '�����������',
        [139] = '�����������',
        [140] = '�����������',
        [141] = 'FBI',
        [142] = '�����������',
        [143] = '�����������',
        [144] = '�����������',
        [145] = '�����������',
        [146] = '�����������',
        [147] = '�����',
        [148] = '�����������',
        [149] = 'Grove',
        [150] = '�����',
        [151] = '�����������',
        [152] = '�����������',
        [153] = '�����������',
        [154] = '�����������',
        [155] = '�����������',
        [156] = '�����������',
        [157] = '�����������',
        [158] = '�����������',
        [159] = '�����������',
        [160] = '�����������',
        [161] = '�����������',
        [162] = '�����������',
        [163] = 'FBI',
        [164] = 'FBI',
        [165] = 'FBI',
        [166] = 'FBI',
        [167] = '�����������',
        [168] = '�����������',
        [169] = 'Yakuza',
        [170] = '�����������',
        [171] = '�����������',
        [172] = '�����������',
        [173] = 'Rifa',
        [174] = 'Rifa',
        [175] = 'Rifa',
        [176] = '�����������',
        [177] = '�����������',
        [178] = '�����������',
        [179] = 'Army',
        [180] = '�����������',
        [181] = '������',
        [182] = '�����������',
        [183] = '�����������',
        [184] = '�����������',
        [185] = '�����������',
        [186] = 'Yakuza',
        [187] = '�����',
        [188] = '���',
        [189] = '�����������',
        [190] = 'Vagos',
        [191] = 'Army',
        [192] = '�����������',
        [193] = 'Aztec',
        [194] = '�����������',
        [195] = 'Ballas',
        [196] = '�����������',
        [197] = '�����������',
        [198] = '�����������',
        [199] = '�����������',
        [200] = '�����������',
        [201] = '�����������',
        [202] = '�����������',
        [203] = '�����������',
        [204] = '�����������',
        [205] = '�����������',
        [206] = '�����������',
        [207] = '�����������',
        [208] = 'Yakuza',
        [209] = '�����������',
        [210] = '�����������',
        [211] = '���',
        [212] = '�����������',
        [213] = '�����������',
        [214] = 'LCN',
        [215] = '�����������',
        [216] = '�����������',
        [217] = '���',
        [218] = '�����������',
        [219] = '���',
        [220] = '�����������',
        [221] = '�����������',
        [222] = '�����������',
        [223] = 'LCN',
        [224] = '�����������',
        [225] = '�����������',
        [226] = 'Rifa',
        [227] = '�����',
        [228] = '�����������',
        [229] = '�����������',
        [230] = '�����������',
        [231] = '�����������',
        [232] = '�����������',
        [233] = '�����������',
        [234] = '�����������',
        [235] = '�����������',
        [236] = '�����������',
        [237] = '�����������',
        [238] = '�����������',
        [239] = '�����������',
        [240] = '���������',
        [241] = '�����������',
        [242] = '�����������',
        [243] = '�����������',
        [244] = '�����������',
        [245] = '�����������',
        [246] = '������',
        [247] = '������',
        [248] = '������',
        [249] = '�����������',
        [250] = '���',
        [251] = '�����������',
        [252] = 'Army',
        [253] = '�����������',
        [254] = '������',
        [255] = 'Army',
        [256] = '�����������',
        [257] = '�����������',
        [258] = '�����������',
        [259] = '�����������',
        [260] = '�����������',
        [261] = '���',
        [262] = '�����������',
        [263] = '�����������',
        [264] = '�����������',
        [265] = '�������',
        [266] = '�������',
        [267] = '�������',
        [268] = '�����������',
        [269] = 'Grove',
        [270] = 'Grove',
        [271] = 'Grove',
        [272] = 'RM',
        [273] = '�����������', -- ���� ��������
        [274] = '���',
        [275] = '���',
        [276] = '���',
        [277] = '�����������',
        [278] = '�����������',
        [279] = '�����������',
        [280] = '�������',
        [281] = '�������',
        [282] = '�������',
        [283] = '�������',
        [284] = '�������',
        [285] = '�������',
        [286] = 'FBI',
        [287] = 'Army',
        [288] = '�������',
        [289] = '�����������',
        [290] = '�����������',
        [291] = '�����������',
        [292] = 'Aztec',
        [293] = '�����������',
        [294] = '�����������',
        [295] = '�����������',
        [296] = '�����������',
        [297] = 'Grove',
        [298] = '�����������',
        [299] = '�����������',
        [300] = '�������',
        [301] = '�������',
        [302] = '�������',
        [303] = '�������',
        [304] = '�������',
        [305] = '�������',
        [306] = '�������',
        [307] = '�������',
        [308] = '���',
        [309] = '�������',
        [310] = '�������',
        [311] = '�������'
    }
    if sampIsPlayerConnected(playerid) then
        local result, handle = sampGetCharHandleBySampPlayerId(playerid)
        local skin = getCharModel(handle)
        return fraks[skin]
    end
end

function update()
	local fpath = os.getenv('TEMP') .. '\\update.json'
	downloadUrlToFile('https://raw.githubusercontent.com/Damein68/lua/master/update.json', fpath, function(id, status, p1, p2)
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            local f = io.open(fpath, 'r')
            if f then
			    local info = decodeJson(f:read('*a'))
                updatelink = info.updateurl
                updlist1 = info.updlist
				updversion = info.latest
                ttt = updlist1
			    if info and info.latest then
                    version = tonumber(info.latest)
                    if version > tonumber(thisScript().version) then
                        ftext('���������� ���������� �� ������ '..updversion..'.')
					    updwindows.v = true
                    else
                        ftext('���������� ������� �� ����������. �������� ����.', -1)
                        update = false
				    end
			    end
		    end
	    end
    end)
end

function smsjob()
  if rank == '��.��������' or rank == '��.��������' or rank == '��������' or  rank == '�����������' then
    lua_thread.create(function()
        vixodid = {}
		status = true
		sampSendChat('/members')
        while not gotovo do wait(0) end
        wait(1200)
        for k, v in pairs(vixodid) do
            sampSendChat('/sms '..v..' �� ������')
            wait(1200)
        end
        players2 = {'{ffffff}���\t{ffffff}����\t{ffffff}������'}
		players1 = {'{ffffff}���\t{ffffff}����'}
		gotovo = false
        status = false
        vixodid = {}
	end)
	else 
	ftext('������ ������� �������� � 7 �����')
	end
end

function goupdate()
    ftext('�������� ���������� ����������. ������ �������������� ����� ���� ������.', -1)
    wait(300)
    downloadUrlToFile(updatelink, thisScript().path, function(id3, status1, p13, p23)
    if status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
        showCursor(false)
	    thisScript():reload()
    end
end)
end

function cmd_color() -- ������� ��������� ����� ������, �� ����� ��� ���, �� ����� �� ����
	local text, prefix, color, pcolor = sampGetChatString(99)
	sampAddChatMessage(string.format("���� ��������� ������ ���� - {934054}[%d] (���������� � ����� ������)",color),-1)
	setClipboardText(color)
end

function getcolor(id)
local colors = 
        {
		[1] = '������',
		[2] = '������-������',
		[3] = '����-������',
		[4] = '���������',
		[5] = 'Ƹ���-������',
		[6] = '�����-������',
		[7] = '����-������',
		[8] = '�������',
		[9] = '����-�������',
		[10] = '���������',
		[11] = '����������',
		[12] = 'Ҹ���-�������',
		[13] = '����-�������',
		[14] = 'Ƹ���-���������',
		[15] = '���������',
		[16] = '�������',
		[17] = '�����',
		[18] = '�������',
		[19] = '����� �����',
		[20] = '����-������',
		[21] = 'Ҹ���-�����',
		[22] = '����������',
		[23] = '������',
		[24] = '����-�����',
		[25] = 'Ƹ����',
		[26] = '����������',
		[27] = '�������',
		[28] = '������ ������',
		[29] = '���������',
		[30] = '�����',
		[31] = '�������',
		[32] = '������',
		[33] = '�����',
		}
	return colors[id]
end

function sampev.onSendSpawn()
    pX, pY, pZ = getCharCoordinates(playerPed)
    if cfg.main.clistb and getDistanceBetweenCoords3d(pX, pY, pZ, 2337.3574,1666.1699,3040.9524) < 20 then
        lua_thread.create(function()
            wait(1200)
			sampSendChat('/clist '..tonumber(cfg.main.clist))
			wait(500)
			local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
			local color = ("%06X"):format(bit.band(sampGetPlayerColor(myid), 0xFFFFFF))
			colors = getcolor(cfg.main.clist)
            ftext('���� ���� ������ ��: {'..color..'}'..cfg.main.clist..' ['..colors..']')
        end)
    end
end

function sampev.onServerMessage(color, text)
        if text:find('������� ���� �����') and color ~= -1 then
        if cfg.main.clistb then
		if rabden == false then
            lua_thread.create(function()
                wait(100)
				sampSendChat('/clist '..tonumber(cfg.main.clist))
				wait(500)
                local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
			    local color = ("%06X"):format(bit.band(sampGetPlayerColor(myid), 0xFFFFFF))
                colors = getcolor(cfg.main.clist)
                ftext('���� ���� ������ ��: {'..color..'}'..cfg.main.clist..' ['..colors..']')
                rabden = true
				wait(1000)
				if cfg.main.clisto then
				local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
                local myname = sampGetPlayerNickname(myid)
				if cfg.main.male == true then
				sampSendChat("/me ������ �������")
                wait(1500)
                sampSendChat("/me ���� ���� ������, ����� ���� ������ �� � ����")
                wait(1500)
                sampSendChat("/me ���� ������� ������, ����� ���������� � ���")
                wait(1500)
                sampSendChat("/me ������� ������� �� �������")
                wait(1500)
                sampSendChat('/do �� ������� ������� � �������� "'..rank..' | '..myname:gsub('_', ' ')..'".')  
				end
				if cfg.main.male == false then
				sampSendChat("/me ������� �������")
                wait(1500)
                sampSendChat("/me ����� ���� ������, ����� ���� ������� �� � ����")
                wait(1500)
                sampSendChat("/me ����� ������� ������, ����� ����������� � ���")
                wait(1500)
                sampSendChat("/me �������� ������� �� �������")
                wait(1500)
                sampSendChat('/do �� ������� ������� � �������� "'..rank..' | '..myname:gsub('_', ' ')..'".')
				end
			end
            end)
        end
	  end
    end
	if text:find('SMS:') and text:find('�����������:') then
		wordsSMS, nickSMS = string.match(text, 'SMS: (.+) �����������: (.+)');
		local idsms = nickSMS:match('.+%[(%d+)%]')
		lastnumber = idsms
	end
    if text:find('������� ���� �������') and color ~= -1 then
        rabden = false
    end
	if text:find('�������� �������� �� ��������� ���������') then
        local Nicks = text:match('����� (.+) �������� �������� �� ��������� ���������. ����� ��������� � ��������.')
		pilot = pilot + 1
   end
   	if text:find('�������� ������������ �����') then
        local Nicks = text:match('����� (.+) �������� ������������ �����. ����� ��������� � ��������.')
		prava = prava + 1
   end
   	if text:find('�������� �������� �� �����������') then
        local Nicks = text:match('����� (.+) �������� �������� �� �����������. ����� ��������� � ��������.')
		ribolov = ribolov + 1
   end
   	if text:find('�������� �������� �� ������� ���������') then
        local Nicks = text:match('����� (.+) �������� �������� �� ������� ���������. ����� ��������� � ��������.')
		kater = kater + 1
   end
   	if text:find('�������� �������� �� ������') then
        local Nicks = text:match('����� (.+) �������� �������� �� ������. ����� ��������� � ��������.')
		gun = gun + 1
   end
   	if text:find('�������� �������� �� ������') then
        local Nicks = text:match('����� (.+) �������� �������� �� �������� �������. ����� ��������� � ��������.')
		biznes = biznes + 1
   end
	if text:find('�� ������� (.+) �� �����������. �������: (.+)') then
        local un1, un2 = text:match('�� ������� (.+) �� �����������. �������: (.+)')
		lua_thread.create(function()
		wait(3000)
		if cfg.main.tarb then
        sampSendChat(string.format('/r [%s]: %s - ������(�) �� ������� "%s".', cfg.main.tarr, un1:gsub('_', ' '), un2))
        else
		sampSendChat(string.format('/r %s - ������(�) �� ������� "%s".', un1:gsub('_', ' '), un2))
		end
		end)
    end
	if text:find('�������(- �) ������������� (.+)') then
        local inv1 = text:match('�������(- �) ������������� (.+)')
		lua_thread.create(function()
		wait(5000)
		if cfg.main.tarb then
        sampSendChat(string.format('/r [%s]: ����� ��������� ��������� - %s. ����� ����������.', cfg.main.tarr, inv1:gsub('_', ' ')))
        else
		sampSendChat(string.format('/r ����� ��������� ��������� - %s. ����� ����������.', inv1:gsub('_', ' ')))
		end
		end)
    end
	if color == -8224086 then
        local colors = ("{%06X}"):format(bit.rshift(color, 8))
        table.insert(departament, os.date(colors.."[%H:%M:%S] ") .. text)
    end
	if statusc then
		if text:match('ID: .+ | .+: .+ %- .+') and not fstatus then
			gosmb = true
			local id, nick, rang, stat = text:match('ID: (%d+) | (.+): (.+) %- (.+)')
			local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
		    src_good = ""
            src_bad = ""
			local _, myid = sampGetPlayerIdByCharHandle(playerPed)
			local _, handle = sampGetCharHandleBySampPlayerId(id)
			local myname = sampGetPlayerNickname(myid)
				if doesCharExist(handle) then
					local x, y, z = getCharCoordinates(handle)
					local mx, my, mz = getCharCoordinates(PLAYER_PED)
					local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)
					
					if dist <= 50 then
						src_good = src_good ..sampGetPlayerNickname(id).. ""
					end
					else
						src_bad = src_bad ..sampGetPlayerNickname(id).. ""
			if src_bad ~= myname then
			table.insert(players3, string.format('{'..color..'}%s[%s]{ffffff}\t%s\t%s', src_bad, id, rang, stat))
			return false
		end
		end
		end
		if text:match('�����: %d+ �������') then
			local count = text:match('�����: (%d+) �������')
			gcount = count
			gotovo = true
			return false
		end
		if color == -1 then
			return false
		end
		if color == 647175338 then
			return false
        end
        if text:match('ID: .+ | .+: .+') and not fstatus then
			krimemb = true
			local id, nick, rang = text:match('ID: (%d+) | (.+): (.+)')
			local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
			table.insert(players1, string.format('{'..color..'}%s[%s]{ffffff}\t%s', nick, id, rang))
			return false
        end
    end
	if status then
		if text:match('ID: .+ | .+ | .+: .+ %- .+') and not fstatus then
			gosmb = true
			local id, data, nick, rang, stat = text:match('ID: (%d+) | (.+) | (.+): (.+) %- (.+)')
			local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
			local nmrang = rang:match('.+%[(%d+)%]')
            if stat:find('��������') and tonumber(nmrang) < 7 then
                table.insert(vixodid, id)
            end
			table.insert(players2, string.format('{ffffff}%s\t {'..color..'}%s[%s]{ffffff}\t%s\t%s', data, nick, id, rang, stat))
			return false
		end
		if text:match('�����: %d+ �������') then
			local count = text:match('�����: (%d+) �������')
			gcount = count
			gotovo = true
			return false
		end
		if color == -1 then
			return false
		end
		if color == 647175338 then
			return false
        end
        if text:match('ID: .+ | .+: .+') and not fstatus then
			krimemb = true
			local id, nick, rang = text:match('ID: (%d+) | (.+): (.+)')
			local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
			table.insert(players1, string.format('{'..color..'}%s[%s]{ffffff}\t%s', nick, id, rang))
			return false
        end
    end
end