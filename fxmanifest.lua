--[[ FX Information ]]--
fx_version   'cerulean'
use_experimental_fxv2_oal 'yes'
lua54        'yes'
game         'gta5'

--[[ Resource Information ]]--
name         'auzzie_scrapyard'
version      '1.0.0'
license      'GPL-3.0-or-later'
author       'Auzzie'

--[[ Manifest ]]--
shared_scripts {
	'@ox_lib/init.lua',
	'config.lua',
}

client_scripts {
	'client.lua',
}

server_scripts {
	'server.lua',
}


dependencies {
	'ox_target',
}

escrow_ignore {
	'config.lua',
	'client.lua',
	'server.lua',
}
