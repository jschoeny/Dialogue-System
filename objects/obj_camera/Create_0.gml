following = obj_player;
freeze = false;
debug = false;

//create_textevent(
//	["Welcome to the demo of the dialogue system! Hit 'E' to go to the next page.", 
//	"This is an example of a one-time 'text event'. It runs when the game starts.", 
//	"Hit 'Space' to make a player monologue happen. And 'D' to toggle debug."],
//	-1,
//	[ 
//		[1,EFFECT_TYPE.SHAKEY, 9,EFFECT_TYPE.WAVE, 16,EFFECT_TYPE.WAVE_AND_COLOUR_SHIFT],
//		-1,
//		[1,EFFECT_TYPE.COLOUR_SHIFT]
//	],
//	[ [1,0.2, 4,2, 10, 0.5]],
//	-1,
//	-1,
//	-1,
//	[ [1,c_lime, 9,c_fuchsia, 16,c_aqua] ],
//	-1,
//	-1,
	
//);

create_textevent_parsed(
	[
		"%1e%0.2s%00FF00cWel%2scome %2e%FF00FFct%0.5so the %4e%FFFF00cdemo of the dialogue system! Hit 'E' to go to the next page.", 
		"This is an example of a one-time 'text event'. It runs when the game starts.", 
		"%3eHit Space to make a player monologue happen. And 'D' to toggle debug."
	],
	-1
);

show_debug_overlay(true);