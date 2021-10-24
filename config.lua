Config = {}
Config.Shoptext = 'Press ~INPUT_JUMP~ to open clothes shop' -- Text to open the clothing shop
Config.OpenKey = 0xD9D0E1C0 -- Opening key hash
Config.BlipName = 'Loja Roupa' -- Blip Name Showed on map
Config.EnableCommand = true -- Enable/Disable /clothing command
Config.BlipSprite = 1195729388	 -- Clothing shop sprite
Config.BlipScale = 0.2 -- Blip scale
Config.Price = 5 -- Price for clothes
Config.Zones = {
	vector3(-325.5,774.57,117.45), -- VALENTINE
	--vector3(1225.60,-1293.85,76.90), -- RHODES
	vector3(2550.81,-1166.28,53.68), -- SAINT DENIS
	vector3(-766.94,-1292.65,43.84), -- BLACK WATER
	vector3(-1794.89,-385.22,160.33) -- STRAWBERRY
}

Config.ZonasR = {
    ['roupa'] = { x=-325.5, y=774.57, z=117.45 },
	['roupa1'] = { x=2550.81, y=-1166.28, z=53.68}, 
    ['roupa2'] = { x=-766.94, y=-1292.65, z=43.84}, 
	['roupa3'] = { x=-1794.89, y=-385.22, z=160.33}, 
}
