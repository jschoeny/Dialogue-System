var cv = executeScript[page];
if(is_method(cv)) {
	cv();
}
else if(is_array(cv)){
	cv = cv[choice];
	if(is_method(cv)) {
		cv();
	}
	else {
		var len = array_length(cv)-1;
		var cva = array_create(len, 0);
		array_copy(cva, 0, cv, 1, len); 
		script_execute_alt(cv[0], cva);
	}
}