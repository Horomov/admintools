
require "lib.moonloader" -- ����������� ����������
--require "lib.moonloader"
require 'lib.sampfuncs'
local tag = '[O.A.S]:' -- ��������� ����������
local main_color = 0x5A90CE
local main_color_text = "{5A90CE}"
local imgui = require 'imgui'
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8
local inicfg = require 'inicfg'
update_state = false

local dlstatus = require('moonloader').download_status

local script_vers = 1
local script_vers_text = "1.00"

local update_url = "https://raw.githubusercontent.com/Horomov/admintools/master/update.ini"
local update_path = getWorkingDirectory() .. "/upate.ini"

local script_url = ""
local script_path = thisScript().path


local atools = imgui.ImBool(false) -- 1 
--------------------------------------------------------------------------------
------------------------------------MAIN--------------------------------------
--------------------------------------------------------------------------------
function main()
 if not isSampLoaded() or not isSampfuncsLoaded() then return end
 while not isSampAvailable() do wait(100) end
 
 sampAddChatMessage("{5A90CE}[Admin Tools]:{FFFFFF} Admin Tools ��� ������� GOLD RP ������� ��������!", 0xFFFFFF)
 ------------------------------------------------------------------------------
 sampRegisterChatCommand ("at", cmd_at)
  -----------------------------------------------------------------------------
 -- ���� ����������� ���� ��� ����� ������ �����
downloadUrlToFile(update_url, update_path, function(id, status)
    if status == dlstatus.STATUS_ENDDOWNLOADDATA then
        updateIni = inicfg.load(nil, update_path)
        if tonumber(updateIni.info.vers) > script_vers then
            sampAddChatMessage("���� ����������! ������: " .. updateIni.info.vers_text, -1)
            update_state = true
        end
        os.remove(update_path)
    end
end)
 while true do
  wait(0)
  
        if update_state then
            downloadUrlToFile(script_url, script_path, function(id, status)
                if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                    sampAddChatMessage("������ ������� ��������!", -1)
                    thisScript():reload()
                end
            end)
            break
        end
  
 end
end

--------------------------------------------------------------------------------
------------------------------------AT------------------------------------------
--------------------------------------------------------------------------------

function cmd_at(arg)
	sampShowDialog(14, "{5A90CE}Admin Tools", string.format("{5A90CE}[0]{FFFFFF} �����-�������\n{5A90CE}[1]{FFFFFF} ������� ������� \n{5A90CE}[2]{FFFFFF} ���������\n{5A90CE}[2]{FFFFFF} ���������"), "�������", "�������", 2)
	lua_thread.create(checker)
end

function checker()
	while sampIsDialogActive() do
		wait(0)
	  local result, button, list, input = sampHasDialogRespond(14)
		if result then
		  if list == 0 and  button == 1 then 
			sampAddChatMessage("{5A90CE}[O.A.S.]:{FFFFFF} � ���������", -1) 
			end 
		  if button == 1 and list == 1 then 
			sampShowDialog(1, "{5A90CE}O.A.S. | {FFFFFF}������� �������", 
			"\n{5A90CE}>>{A8A8FF} /cheat [id] {ffffff}- �������� ������ �� 14 ���� �� ����\n{5A90CE}>>{A8A8FF} /neadek [id] {ffffff}- �������� ������ �� ���������� �� 3 ���\n{5A90CE}>>{A8A8FF} /oskadm [id] {ffffff}- �������� �� ����������� ������ �� 7 ����", "����", "�������",0)
			end
		  if button == 1 and list == 2 then
			sampAddChatMessage("{5A90CE}[O.A.S.]:{FFFFFF} � ���������� �����", -1) 
			end 

		end
	end
end

