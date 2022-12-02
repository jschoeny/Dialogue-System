function change_variable(obj, var_name_as_string, new_value) {
	with(obj) var oid = id;
	variable_instance_set(oid, var_name_as_string, new_value);
}

function create_dialogue(text, speaker, effects = -1, text_speed = -1, type = -1, next_line = -1, scripts = -1, text_col = -1, emotion = -1, emote = -1) {
	if(instance_exists(obj_textbox)){ exit; }

	//Create the Textbox
	var _textbox = instance_create_layer(x,y, "Text", obj_textbox);

	//Get arguments
	var _text = text;
	var _speaker, text_len;

	//If Text or Speaker aren't arrays (single line input), make them arrays 
	if(is_array(_text))		{ text_len = array_length(_text); }
	else					{ text_len = 1; _text[0] = _text;  }
	if(!is_array(speaker))	{ _speaker = array_create(text_len, id); }
	else					{ _speaker = speaker; }

	//Get rest of arguments, fill with default
	var _effects	= array_create(text_len, [1,0]);
	var _speed		= array_create(text_len, [1,0.5]);
	var _textcol	= array_create(text_len, [1,c_white]);
	var _type		= array_create(text_len, 0);
	var _nextline	= array_create(text_len, 0);
	var _script		= array_create(text_len, 0);
	var _emotion	= array_create(text_len, 0);
	var _emotes		= array_create(text_len, -1);
	var _creator	= array_create(text_len, id);
	
	//Copy given arguments into arrays if not undefined
	if(effects != -1) {
		if(is_array(effects)) {
			for(var i = 0; i < array_length(effects); i++) {
				if(is_array(effects[i])) { _effects[i] = effects[i]; }
			}
		}
	}
	if(text_speed != -1) {
		if(is_array(text_speed)) {
			for(var i = 0; i < array_length(text_speed); i++) {
				if(is_array(text_speed[i])) { _speed[i] = text_speed[i]; }
			}
		}
	}
	if(text_col != -1) {
		if(is_array(text_col)) {
			for(var i = 0; i < array_length(text_col); i++) {
				if(is_array(text_col[i])) { _textcol[i] = text_col[i]; }
			}
		}
	}
	if(type != -1) {
		if(is_array(type))
			array_copy(_type, 0, type, 0, array_length(type));
		else
			_type[0] = type;
	}
	if(next_line != -1) {
		if(is_array(next_line))
			array_copy(_nextline, 0, next_line, 0, array_length(next_line));
		else
			_nextline[0] = next_line;
	}
	if(scripts != -1) {
		if(is_array(scripts))
			array_copy(_script, 0, scripts, 0, array_length(scripts));
		else
			_script[0] = scripts;
	}
	if(emotion != -1) {
		if(is_array(emotion))
			array_copy(_emotion, 0, emotion, 0, array_length(emotion));
		else
			_emotion[0] = emotion;
	}
	if(emote != -1) {
		if(is_array(emote))
			array_copy(_emotes, 0, emote, 0, array_length(emote));
		else
			_emotes[0] = emote;
	}
		

	//Change the Textbox Values
	with(_textbox){
		self.creator		= _creator;
		self.effects		= _effects;
		self.text_speed		= _speed;
		self.type			= _type;
		self.text			= _text;
		self.nextline		= _nextline;
		self.executeScript	= _script;
		self.text_col		= _textcol;
		self.emotion		= _emotion;	
		self.emotes			= _emotes;
	
		//Speaker's Variables
		i = 0; repeat(text_len){
			self.portrait[i]		= _speaker[i].myPortrait;
			self.voice[i]			= _speaker[i].myVoice;
			self.font[i]			= _speaker[i].myFont;
			self.name[i]			= _speaker[i].myName;
			self.speaker[i]			= _speaker[i];
		
			if(variable_instance_exists(_speaker[i], "myPortraitTalk"))		{ portrait_talk[i] = _speaker[i].myPortraitTalk; }
			else { portrait_talk[i] = -1; }
			if(variable_instance_exists(_speaker[i], "myPortraitTalk_x"))	{ portrait_talk_x[i] = _speaker[i].myPortraitTalk_x; }
			else { portrait_talk_x[i] = -1; }
			if(variable_instance_exists(_speaker[i], "myPortraitTalk_y"))	{ portrait_talk_y[i] = _speaker[i].myPortraitTalk_y; }
			else { portrait_talk_y[i] = -1; }
			if(variable_instance_exists(_speaker[i], "myPortraitIdle"))		{ portrait_idle[i] = _speaker[i].myPortraitIdle; }
			else { portrait_idle[i] = -1; }
			if(variable_instance_exists(_speaker[i], "myPortraitIdle_x"))	{ portrait_idle_x[i] = _speaker[i].myPortraitIdle_x; }
			else { portrait_idle_x[i] = -1; }
			if(variable_instance_exists(_speaker[i], "myPortraitIdle_y"))	{ portrait_idle_y[i] = _speaker[i].myPortraitIdle_y; }
			else { portrait_idle_y[i] = -1; }
		
		
			if(portrait_talk[i] != -1){ 
				portrait_talk_n[i] = sprite_get_number(portrait_talk[i]);
				portrait_talk_s[i] = sprite_get_speed(portrait_talk[i])/room_speed;
			}
			if(portrait_idle[i] != -1){ 
				portrait_idle_n[i] = sprite_get_number(portrait_idle[i]);
				portrait_idle_s[i] = sprite_get_speed(portrait_idle[i])/room_speed;
			}
			i++;
		}
	
		draw_set_font(font[0]);
		charSize = string_width("M");
		stringHeight = string_height("M");
		event_perform(ev_alarm, 0);	//makes textbox perform "setup"
	}

	myTextbox = _textbox;
	return _textbox;
}

function create_instance_layer(x, y, layer, obj) {
	instance_create_layer(x, y, layer, obj);
}

function create_textevent(text, speaker, effects = undefined, text_speed = undefined, type = undefined, next_line = undefined, scripts = undefined, text_col = undefined, emotion = undefined, emote = undefined) {
	if(instance_exists(obj_textevent)){ exit; }

	var textevent = instance_create_layer(0,0,"Instances",obj_textevent);

	with(textevent){
		reset_dialogue_defaults();
		
		myText		= text;
		mySpeaker	= speaker;
		if(!is_undefined(effects))		myEffects	= effects;
		if(!is_undefined(text_speed))	myTextSpeed	= text_speed;
		if(!is_undefined(type))			myTypes		= type;
		if(!is_undefined(next_line))	myNextLine	= next_line;
		if(!is_undefined(scripts))		myScripts	= scripts;
		if(!is_undefined(text_col))		myTextCol	= text_col;
		if(!is_undefined(emotion))		myEmotion	= emotion;
		if(!is_undefined(emote))		myEmote		= emote;
	
		event_perform(ev_other, ev_user0);
	}

	return textevent;
}

function reset_dialogue_defaults() {
	myTextbox			= noone;
	myText				= -1;
	mySpeaker			= -1;
	myEffects			= 0;
	myTextSpeed			= 0;
	myTypes				= 0;
	myNextLine			= 0;
	myScripts			= 0;
	myTextCol			= 0;
	myEmotion			= 0;
	myEmote				= -1;
}

function script_execute_alt(_script, _args) {
	var s = _script;
	var a = _args;
	var len = array_length(_args);

	switch(len){
		case 0 : script_execute(s); break;
		case 1 : script_execute(s, a[0]); break;
		case 2:  script_execute(s, a[0], a[1]); break;
		case 3:  script_execute(s, a[0], a[1], a[2]); break;
		case 4:  script_execute(s, a[0], a[1], a[2], a[3]); break;
		case 5:  script_execute(s, a[0], a[1], a[2], a[3], a[4]); break;
		case 6:  script_execute(s, a[0], a[1], a[2], a[3], a[4], a[5]); break;
		case 7:  script_execute(s, a[0], a[1], a[2], a[3], a[4], a[5], a[6]); break;
		case 8:  script_execute(s, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7]); break;
		case 9:  script_execute(s, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8]); break;
		case 10: script_execute(s, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9]); break;
		case 11: script_execute(s, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10]); break;
		case 12: script_execute(s, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11]); break;
		case 13: script_execute(s, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12]); break;
		case 14: script_execute(s, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12], a[13]); break;
		case 15: script_execute(s, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12], a[13], a[14]); break;
		case 16: script_execute(s, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12], a[13], a[14], a[15]); break;
	}
}