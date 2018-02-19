script "clanfortune.ash";
//To be included for writing pages, such as in relay scripts


record Page
{
	string title;
	buffer head_contents;
	buffer body_contents;
	string [string] body_attributes; //[attribute_name] -> attribute_value
	
    string css_file;
};

record stringwtags
{
	string text;
	boolean [string] tags;
};

void AddTag(stringwtags taggedstring, string tag)
{
	taggedstring.tags[tag] = true;
}



Page _mypage;

Page Page()
{
	return _mypage;
}

buffer HTMLGenerateTagPrefix(string tag, string [string] attributes)
{
	buffer result;
	result.append("<");
	result.append(tag);
	foreach attribute_name, attribute_value in attributes
	{
		//string attribute_value = attributes[attribute_name];
		result.append(" ");
		result.append(attribute_name);
		if (attribute_value != "")
		{
			boolean is_integer = attribute_value.is_integer(); //don't put quotes around integer attributes (i.e. width, height)
			
			result.append("=");
			if (!is_integer)
				result.append("\"");
			result.append(attribute_value);
			if (!is_integer)
				result.append("\"");
		}
	}
	result.append(">");
	return result;
}

buffer HTMLGenerateTagPrefix(string tag)
{
    buffer result;
    result.append("<");
    result.append(tag);
    result.append(">");
    return result;
}

buffer HTMLGenerateTagSuffix(string tag)
{
    buffer result;
    result.append("</");
    result.append(tag);
    result.append(">");
    return result;
}

buffer HTMLGenerateTagWrap(string tag, string source, string [string] attributes)
{
    buffer result;
    result.append(HTMLGenerateTagPrefix(tag, attributes));
    result.append(source);
    result.append(HTMLGenerateTagSuffix(tag));
	return result;
}

buffer HTMLGenerateTagWrap(string tag, string source)
{
    buffer result;
    result.append(HTMLGenerateTagPrefix(tag));
    result.append(source);
    result.append(HTMLGenerateTagSuffix(tag));
	return result;
}
/*
buffer Get_StringWTags_HTML(stringwtags taggedstring)
{
	buffer result;
	foreach tag in taggedstring.tags
	{
		result.append(HTMLGenerateTagPrefix(tag));
		
	}
	result.append(taggedstring.text);
	foreach tag in taggedstring.tags
	{
		result.append(HTMLGenerateTagSuffix(tag));
		
	}
	return result;
}

buffer Get_StringWTags_HTML(stringwtags [int] tagarray)
{
    buffer result;
	int n=0;
	int count=0;
	while(count < tagarray.count())
	{
		if(tagarray contains n)
		{
			result.append(Get_StringWTags_HTML(tagarray[n]));
			count++;
		}
		n++;
	}
	return result;
}

buffer Get_StringWTags_HTML(string [int, stringwtags] tagarray, string tag)
{
    buffer result;
	result.append(HTMLGenerateTagPrefix(tag));
    result.append(Get_StringWTags_HTML(tagarray));
	result.append(HTMLGenerateTagSuffix(tag));
	return result;
}
*/
buffer PageGenerateBodyContents(Page page_in)
{
    return page_in.body_contents;
}

buffer PageGenerateBodyContents()
{
    return Page().PageGenerateBodyContents();
}

buffer PageGenerateStyle(Page page_in)
{
	buffer result;
	if(page_in.css_file != "")
	{
		return result.append("<link rel=stylesheet type=text/css href=\"" + page_in.css_file + "\"");
	}
	else
	{
		return result;
	}
}

buffer PageGenerate(Page page_in)
{
	buffer result;
	
	result.append("<!DOCTYPE html>\n"); //HTML 5 target
	result.append("<html>\n");
	
	//Head:
	result.append("\t<head>\n");
	result.append("\t\t<title>");
	result.append(page_in.title);
	result.append("</title>\n");
	if (page_in.head_contents.length() != 0)
	{
        result.append("\t\t");
		result.append(page_in.head_contents);
		result.append("\n");
	}
	//Write CSS styles:
    result.append(PageGenerateStyle(page_in));
    result.append("\t</head>\n");
	
	//Body:
	result.append("\t");
	result.append(HTMLGenerateTagPrefix("body", page_in.body_attributes));
	result.append("\n\t\t");
	result.append(page_in.body_contents);
	result.append("\n");
		
	result.append("\t</body>\n");
	

	result.append("</html>");
	
	return result;
}

void PageGenerateAndWriteOut(Page page_in)
{
	write(PageGenerate(page_in));
}

void PageGenerateAndPrintOut(Page page_in)
{
	print_html(PageGenerate(page_in));
}

void PageSetTitle(Page page_in, string title)
{
	page_in.title = title;
}


void PageWriteHead(Page page_in, string contents)
{
	page_in.head_contents.append(contents);
}

void PageWriteHead(Page page_in, buffer contents)
{
	page_in.head_contents.append(contents);
}


void PageWrite(Page page_in, string contents)
{
	page_in.body_contents.append(contents);
}

void PageWrite(Page page_in, buffer contents)
{
	page_in.body_contents.append(contents);
}

void PageSetBodyAttribute(Page page_in, string attribute, string value)
{
	page_in.body_attributes[attribute] = value;
}


//Global:

buffer PageGenerate()
{
	return PageGenerate(Page());
}

void PageGenerateAndWriteOut()
{
	write(PageGenerate());
}
void PageGenerateAndPrintOut()
{
	print_html(PageGenerate());
}

void PageSetTitle(string title)
{
	PageSetTitle(Page(), title);
}


void PageWriteHead(string contents)
{
	PageWriteHead(Page(), contents);
}

void PageWriteHead(buffer contents)
{
	PageWriteHead(Page(), contents);
}

//Writes to body:

void PageWrite(string contents)
{
	PageWrite(Page(), contents);
}

void PageWrite(buffer contents)
{
	PageWrite(Page(), contents);
}

void PageSetBodyAttribute(string attribute, string value)
{
	PageSetBodyAttribute(Page(), attribute, value);
}

//General tools for scripting

///////////////////////
//Records
record strint
{
	string str;
	int num;
};


record player_info
{
//viewable info
	string my_name;
	string my_id;
	int my_clan_id;
	string my_clan_name;
	int my_ascensions;
	class my_class;
	int my_level;
	int my_adv_remaining;
	int my_total_turns;
	int my_turn_count;
	int my_daycount;
	int my_pvp_attacks;
	boolean my_pvp_enabled;
	
//character sheet
	string favorite_food;
	string favorite_booze;
	
//stats
	int my_base_mus;
	int my_base_mys;
	int my_base_mox;
	
	int my_buffed_mus;
	int my_buffed_mys;
	int my_buffed_mox;
	
//resources
	int my_hitpoints;
	int my_manapoints;
	int my_max_hitpoints;
	int my_max_manapoints;
	familiar my_current_familiar;

//sign & path
	string my_sign;
	string my_path;
	boolean can_use_mall;
	boolean in_hardcore;
	boolean in_badmoon;

//Consumption
	int my_inebriety;
	int my_inebriety_limit;
	int my_fullness;
	int my_fullness_limit;
	int my_spleen;
	int my_spleen_limit;

//Time and Date
	int my_moonlight;
	int my_moonphase;
};

record time
{
	int hour;
	int minute;
	int second;
	string time_zone;
};

record datetime
{
	string my_date;
	time my_time;
};

///////////////////////
//Constants
boolean [slot] norm_slots()
{
	return $slots[hat,back,weapon,off-hand,shirt,pants,acc1,acc2,acc3,familiar];
}
///////////////////////
//Date-Time functions
	///////////////////////
	//Date-Time conversions
	time to_time(string a)
	{

		string parsed_a = format_date_time("hh:mm:ss z",a,"HH:mm:ss:z");

		string [int] time_array = parsed_a.split_string(":");
		time time_a;
		time_a.hour = time_array[0].to_int();
		time_a.minute = time_array[1].to_int();
		time_a.second = time_array[2].to_int();
		time_a.time_zone = time_array[3];
		return time_a;
	}
	
	///////////////////////
	//Date-Time Math functions
string previous_day(string date)
{//expects date in yyyyMMdd format
	int year = date.substring(0,4).to_int();
	int month = date.substring(4,6).to_int();
	int day = date.substring(6).to_int();
	print(year);
	print(month);
	print(day);
	boolean reduce_month = false;
	boolean reduce_year = false;
	
	if(day == 1)
	{
		switch(month - 1)
		{
			case 0: //december
			case 1:
			case 3:
			case 5:
			case 7:
			case 8:
			case 10:
				day = 31;
				break;			
			case 4:
			case 6:
			case 9:
			case 11:
				day = 30;
				break;
			case 2:
				int year_div4 = year / 4;
				if(year_div4 * 4 == year)
				{
					day = 29;
				}
				else
				{
					day = 28;
				}
				break;
		}
		reduce_month = true;
	}
	else
	{
		day = day - 1;
	}
	
	if(reduce_month)
	{
		if(month == 1)
		{
			month = 12;
			reduce_year = true;
		}
		else
		{
			month = month - 1;
		}
	}
	
	if(reduce_year)
	{
		year = year - 1;
	}
	int prev_date = year * 10000 + month * 100 + day;
	
	return prev_date.to_string();
	
}

int previous_day(int date)
{
	return previous_day(date.to_string()).to_int();
	
}

string previous_day(string date, int days)
{
	if(days < 1)
	{
		abort("previous_day given invalid number of past days, must be 0 or greater");
	}
	else if(days == 0)
	{
		return date;
	}
	else
	{
		string past_day = date;
		for num from 1 to days by 1
		{
			past_day = previous_day(past_day);
		}
		return past_day;
	}
	return date;
}

	///////////////////////
	//Date-Time Comparisons
boolean day_lt(string a, string b)
{
	if(a.to_int() < b.to_int())
	{
		return true;
	}
	return false;
}
boolean day_gt(string a, string b)
{
	if(a.to_int() > b.to_int())
	{
		return true;
	}
	return false;
}
boolean day_lte(string a, string b)
{
	if(a.to_int() >= b.to_int())
	{
		return true;
	}
	return false;
}
boolean day_gte(string a, string b)
{
	if(a.to_int() >= b.to_int())
	{
		return true;
	}
	return false;
}

boolean time_lt(string a, string b)
{
	time time_a = to_time(a);
	time time_b = to_time(b);
	if(time_a.hour < time_b.hour)
	{
		return true;
	}
	else if(time_a.hour > time_b.hour)
	{
		return false;
	}
	else
	{
		if(time_a.minute < time_b.minute)
		{
			return true;
		}
		else if(time_a.minute > time_b.minute)
		{
			return false;
		}
		else
		{
			if(time_a.second < time_b.second)
			{
				return true;
			}
			else if(time_a.second > time_b.second)
			{
				return false;
			}
			else
			{
				return false;
			}
		}
	}
	return false;
}
boolean time_gt(string a, string b)
{
	return time_lt(b,a);
}
boolean time_lte(string a, string b)
{
	if(a == b)
	{
		return true;
	}
	return time_lt(a,b);
}
boolean time_gte(string a, string b)
{
	if(a == b)
	{
		return true;
	}
	return time_lt(b,a);
}


///////////////////////
//Player Info

string [string] get_favorite_consumes()
{
	string [string] fav_consumes;
	//<tr><td align="right"><a class="nounder" href="showconsumption.php">Favorite Food:</a></td><td><b>Cheer-E-Os</b></td></tr>
	//<tr><td align="right"><a class="nounder" href="showconsumption.php#booze">Favorite Booze:</a></td><td><b>cheer wine</b></td></tr>
	string charsheet = visit_url("charsheet.php");
	string match_string = "href=\"showconsumption.php.*?\">Favorite (.*?):</a>.*?</td>.*?<td>.*?<b>(.*?)</b>";
	string [int,int] consumptions = group_string(charsheet,match_string);
	foreach num in consumptions
	{
		
		fav_consumes[consumptions[num][1].to_lower_case()] = consumptions[num][2].to_lower_case();
	
	}	
	return fav_consumes;
}

player_info get_player_info()
{
//viewable info
	player_info my_info;
	my_info.my_name = my_name();
	my_info.my_id = my_id();
	my_info.my_clan_id = get_clan_id();
	my_info.my_clan_name = get_clan_name();
	my_info.my_ascensions = my_ascensions();
	my_info.my_class = my_class();
	my_info.my_level = my_level();
	my_info.my_adv_remaining = my_adventures();
	my_info.my_total_turns = total_turns_played();
	my_info.my_turn_count = my_turncount();
	my_info.my_daycount = my_daycount();
	my_info.my_pvp_attacks = pvp_attacks_left();
	my_info.my_pvp_enabled = hippy_stone_broken();

//character sheet
	string [string] fav_consumes = get_favorite_consumes();
	my_info.favorite_food = fav_consumes["food"];
	my_info. favorite_booze = fav_consumes["booze"];
//stats
	my_info.my_base_mus =  my_basestat($stat[muscle]);
	my_info.my_base_mys = my_basestat($stat[mysticality]);
	my_info.my_base_mox = my_basestat($stat[moxie]);
	
	my_info.my_buffed_mus = my_buffedstat($stat[muscle]);
	my_info.my_buffed_mys = my_buffedstat($stat[mysticality]);
	my_info.my_buffed_mox = my_buffedstat($stat[moxie]);
	
//resources
	my_info.my_hitpoints = my_hp();
	my_info.my_manapoints = my_mp();
	my_info.my_max_hitpoints = my_maxhp();
	my_info.my_max_manapoints = my_maxmp();
	my_info.my_current_familiar = my_familiar();

	string favorite_food;
//sign & path
	my_info.my_sign = my_sign();
	my_info.my_path = my_path();
	my_info.can_use_mall = can_interact();
	my_info.in_hardcore = in_hardcore();
	my_info.in_badmoon = in_bad_moon();
	
//Consumption	
	my_info.my_inebriety = my_inebriety();
	my_info.my_inebriety_limit = inebriety_limit();
	my_info.my_fullness = my_fullness();
	my_info.my_fullness_limit = fullness_limit();
	my_info.my_spleen;
	my_info.my_spleen_limit;

//Time and Date
	my_info.my_moonlight;
	my_info. my_moonphase;
	
	return my_info;
}

///////////////////////
//String Handling
boolean contains_rgx(string text, string match)
{
	matcher m = create_matcher(match,text);
	if(m.find())
	{
		return true;
	}
	return false;
}


///////////////////////
//Array Tools
	int last(string [int] list)
	{
		return (list.count() - 1);
	}
	///////////////////////
	//Add Conversions
	string [int] Add(string [int] list, string a)
	{
		

		if(list contains list.last())
		{
			print_html("Array Addition Error, map not in array format");
		}	
		else
		{
			list[list.last()] = a;
		}

		return list;
	}

	///////////////////////
	//Array Conversions To (type) [int]
string [int] ItemToStringArray(item [int] it_array)
{
	string [int] string_array;
	foreach num in it_array
	{
		string_array[num] = it_array[num].to_string();
	}
	return string_array;
}

string [int] BooleanItemToStringArray(boolean [item] bool_it)
{
	string [int] string_array;
	int index = 0;
	foreach it in bool_it
	{
		string_array[index] = it.to_string();
		index++;
	}
	return string_array;
}

string [int] BooleanSlotToStringArray(boolean [slot] bool_slot)
{
	string [int] string_array;
	int index = 0;
	foreach slt in bool_slot
	{
		string_array[index] = slt.to_string();
		index++;
	}
	return string_array;
}
string [int] BooleanStringToStringArray(boolean [string] bool_str)
{
	string [int] string_array;
	int index = 0;
	foreach str in bool_str
	{
		string_array[index] = str;
		index++;
	}
	return string_array;
}

item [int] BooleanItemToArray(boolean [item] bool_it)
{
	item [int] item_array;
	int index = 0;
	foreach it in bool_it
	{
		item_array[index] = it;
		index++;
	}
	return item_array;
}

slot [int] BooleanSlotToArray(boolean [slot] bool_slot)
{
	slot [int] slot_array;
	int index = 0;
	foreach slt in bool_slot
	{
		slot_array[index] = slt;
		index++;
	}
	return slot_array;
}
	///////////////////////
	//Array Conversions To boolean [(type)]
boolean [string] StringInt2BooleanString(string [int] str_int)
{
	boolean [string] bool_string;
	foreach num in str_int
	{
		bool_string[str_int[num]] = true;
	}
	return bool_string;
}

	///////////////////////
	//Array Subarray
string [int] FromXtoY(string[int] my_array, int start, int end)
{
	string[int] new_array;
	for num from start to end by 1
	{
		new_array[num - start] = my_array[num];
	}
	return new_array;
}
string [int] FromX(string[int] my_array, int start)
{
	int count = my_array.count() - 1;
	string[int] new_array;
	//print_html("Count %s, size %s, start %s", string[int]{count,my_array.count(), start});
	for num from start to count by 1
	{
		new_array[num - start] = my_array[num];
	}
	return new_array;
}
	///////////////////////
	//Array Conversions To string
	string concat(string [int] intstr_array, string sep)
	{
		buffer output;
		int count = 0;
		foreach num in intstr_array
		{
			output.append(intstr_array[num]);
			count++;
			if(count < intstr_array.count())
			{
				output.append(sep);
			}			
		}
		return output.to_string();
	}

	string concat(boolean [string] str_array, string sep)
	{
		buffer output;
		int count = 0;
		foreach str in str_array
		{
			output.append(str);
			count++;
			if(count < str_array.count())
			{
				output.append(sep);
			}			
		}
		return output.to_string();
	}

	string concat(boolean [slot] slot_array, string sep)
	{
		buffer output;
		int count = 0;
		foreach slt in slot_array
		{
			output.append(slt.to_string());
			count++;
			if(count < slot_array.count())
			{
				output.append(sep);
			}			
		}
		return output.to_string();
	}

	string concat(boolean [item] item_array, string sep)
	{
		buffer output;
		int count = 0;
		foreach it in item_array
		{
			output.append(it.to_string());
			count++;
			if(count < item_array.count())
			{
				output.append(sep);
			}			
		}
		return output.to_string();
	}
	///////////////////////
	//Array Merge
string [int] merge(string [int] array1, string [int] array2)
{
	string [int] merge_array;
	int index = 0;
	foreach num in array1
	{
		merge_array[index] = array1[num];
		index++;
	}
	foreach num in array2
	{
		merge_array[index] = array2[num];
		index++;
	}
	return merge_array;
}

item [int] merge(item [int] array1, item [int] array2)
{
	item [int] merge_array;
	int index = 0;
	foreach num in array1
	{
		merge_array[index] = array1[num];
		index++;
	}
	foreach num in array2
	{
		merge_array[index] = array2[num];
		index++;
	}
	return merge_array;
}

effect [int] merge(effect [int] array1, effect [int] array2)
{
	effect [int] merge_array;
	int index = 0;
	foreach num in array1
	{
		merge_array[index] = array1[num];
		index++;
	}
	foreach num in array2
	{
		merge_array[index] = array2[num];
		index++;
	}
	return merge_array;
}

skill [int] merge(skill [int] array1, skill [int] array2)
{
	skill [int] merge_array;
	int index = 0;
	foreach num in array1
	{
		merge_array[index] = array1[num];
		index++;
	}
	foreach num in array2
	{
		merge_array[index] = array2[num];
		index++;
	}
	return merge_array;
}

monster [int] merge(monster [int] array1, monster [int] array2)
{
	monster [int] merge_array;
	int index = 0;
	foreach num in array1
	{
		merge_array[index] = array1[num];
		index++;
	}
	foreach num in array2
	{
		merge_array[index] = array2[num];
		index++;
	}
	return merge_array;
}
///////////////////////
//Properties
	///////////////////////
	//Property Set
		///////////////////////
		//Property Set Get
		
		boolean [string] get_property_set(string name, string delim)
		{
			string raw_property = get_property(name);
			return StringInt2BooleanString(raw_property.split_string(delim));
		}
		boolean [string] get_property_set(string name)
		{
			return get_property_set(name,";");
		}
		
		///////////////////////
		//Property Set Set
		
		void set_property_set(string name, string value)
		{
			set_property(name, value);
		}
		void set_property_set(string name, boolean [string] values, string delim)
		{
			buffer my_property;
			int count = 0;
			foreach val in values
			{
				if(val != "")
				{
					my_property.append(val);
					count++;
					if(count < values.count())
					{
						my_property.append(delim);
					}
				}
			}
			set_property(name,my_property.to_string());
		}
		void set_property_set(string name, string [int] values, string delim)
		{
			boolean [string] strbool_array = StringInt2BooleanString(values);
			set_property_set(name, strbool_array, delim);
		}
		void set_property_set(string name, boolean [string] values)
		{
			set_property_set(name,values,";");
		}
		void set_property_set(string name, string [int] values)
		{
			set_property_set(name,values,";");
		}
		///////////////////////
		//Property Set Add
		void property_set_add(string name, boolean [string] values, string delim)
		{
			boolean [string] prop_array = get_property_set(name);
			foreach val in values
			{
				prop_array[val] = true;
			}
			
			set_property_set(name, prop_array, delim);
		}
		void property_set_add(string name, string [int] values, string delim)
		{
			boolean [string] prop_array = get_property_set(name);
			foreach num in values
			{
				prop_array[values[num]] = true;
			}
			
			set_property_set(name, prop_array, delim);
		}
		void property_set_add(string name, string value, string delim)
		{
			boolean [string] prop_array;
			prop_array[value] = true;
			property_set_add(name, prop_array, delim);
		}
		void property_set_add(string name, boolean [string] values)
		{
			property_set_add(name, values, ";");
		}
		void property_set_add(string name, string [int] values)
		{
			property_set_add(name, values, ";");
		}
		void property_set_add(string name, string value)
		{
			property_set_add(name, value, ";");
		}		
		///////////////////////
		//Property Set Remove
		void property_set_remove(string name, boolean [string] values, string delim)
		{
			boolean [string] prop_array = get_property_set(name);
			foreach val in values
			{
				if(prop_array contains val)
				{
					remove prop_array[val];
				}
			}
			
			set_property_set(name, prop_array, delim);
		}
		void property_set_remove(string name, string [int] values, string delim)
		{
			boolean [string] prop_array = get_property_set(name);
			foreach num in values
			{
				if(prop_array contains values[num])
				{
					remove prop_array[values[num]];
				}
			}
			
			set_property_set(name, prop_array, delim);
		}
		void property_set_remove(string name, string value, string delim)
		{
			boolean [string] prop_array;
			prop_array[value] = true;
			property_set_remove(name, prop_array, delim);
		}
		void property_set_remove(string name, boolean [string] values)
		{
			property_set_remove(name, values, ";");
		}
		void property_set_remove(string name, string [int] values)
		{
			property_set_remove(name, values, ";");
		}
		void property_set_remove(string name, string value)
		{
			property_set_remove(name, value, ";");
		}
		///////////////////////
		//Property Set Command
		void property_set_cmd(string name, string command, boolean [string] values, string delim)
		{
			switch(command.to_lower_case())
			{
				case "set":
					set_property_set(name, values, delim);
					break;
				case "add":
					property_set_add(name, values, delim);
					break;
				case "remove":
					property_set_remove(name, values, delim);
					break;
				default:
					abort("Invalid command " + command + " sent to property_set_cmd");
					break;
			}
		}
		void property_set_cmd(string name, string command, string [int] values, string delim)
		{
			boolean [string] prop_array = StringInt2BooleanString(values);
			
			property_set_cmd(name, command, prop_array, delim);
		}
		void property_set_cmd(string name, string command, string value, string delim)
		{
			boolean [string] prop_array;
			prop_array[value] = true;
			property_set_cmd(name, command, prop_array, delim);
		}
		void property_set_cmd(string name, string command, boolean [string] values)
		{
			property_set_cmd(name, command, values, ";");
		}
		void property_set_cmd(string name, string command, string [int] values)
		{
			property_set_cmd(name, command, values, ";");
		}
		void property_set_cmd(string name, string command, string value)
		{
			property_set_cmd(name, command, value, ";");
		}
///////////////////////
//pvp related
boolean is_pvp_stealable()
{
	if(hippy_stone_broken() && can_interact())
	{
		return true;
	}
	return false;
}

///////////////////////
//Print Tools

string Remove_Tags(string html)
{
	matcher tags_gone = create_matcher("<.+?>",html);
	return replace_all(tags_gone,"").to_string();
}
	///////////////////////
	//Printing
void print(string text, int logging)
{
	switch(logging)
	{
		case 1:
			print_html(text);
			break;
		case 2:
			logprint(text);
			break;
		default:
			//do nothing
			break;
	}
}

void print(string text, string [int] words, int logging)
{
	matcher replacer = create_matcher("%s",text);
	buffer output;
	for num from 0 to words.count() - 1 by 1
	{
		replacer.find();
		append_replacement(replacer,output,words[num]);		
	}
	append_tail(replacer,output);
	print(output.to_string(), logging);
}

void log_print(string text)
{
	logprint(text);
	if(get_property("print_logging") == "true")
	{
		print(text);
	}
}
	///////////////////////
	//HTML Printing
void print_html(string html, int logging)
{
	switch(logging)
	{
		case 1:
			print_html(html);
			break;
		case 2:
			logprint(Remove_Tags(html));
			break;
		default:
			//do nothing
			break;
	}
}

void print_html(string text, string word, string tag, int logging)
{
	string wrapped = HTMLGenerateTagWrap(tag,word);
	string output = to_string(replace_string(text,"%s",wrapped));
	print_html(output, logging);
}

void print_html(string text, string word, string tag)
{
	print_html(text, word, tag, 1);
}
void print_html(string text, string word)
{
	print_html(text, word, "b", 1);
}
void print_html(string text, string word, int logging)
{
	print_html(text, word, "b", logging);
}

void print_html(string text, string [int] words, string tag, int logging)
{
	matcher replacer = create_matcher("%s",text);
	//print(text);
	buffer output;
	for num from 0 to words.count() - 1 by 1
	{
		replacer.find();
		//print(num);
		replacer.append_replacement(output,HTMLGenerateTagWrap(tag,words[num]));
		//print(replacer.group());
	}
	append_tail(replacer,output);
	print_html(output.to_string(), logging);
}

void print_html(string text, string [int] words, int logging)
{
	print_html(text, words, "b", logging);
}
void print_html(string text, string [int] words)
{
	print_html(text, words, "b", 1);
}
void print_html(string text, string [int] words, string tag)
{
	print_html(text, words, tag, 1);
}

void print_html_list(string text, string name, string [int] my_array)
{
	buffer my_list;
	my_list.append(HTMLGenerateTagWrap("b",my_array[0]));
	if(my_array.count() > 1)
	{
		for num from 1 to my_array.count() - 1 by 1
		{
			my_list.append(", ");
			my_list.append(HTMLGenerateTagWrap("b",my_array[num]));
		}
	}
	buffer output;
	matcher replacer = create_matcher("%s",text);
	if(name != "")
	{
		replacer.find();
		append_replacement(replacer,output,HTMLGenerateTagWrap("b",name));
	}
	replacer.find();
	append_replacement(replacer,output,my_list.to_string());
	append_tail(replacer,output);
	print_html(output.to_string());
}
void print_html_list(string text, string name, boolean [string] my_array)
{
	print_html_list(text,name,BooleanStringToStringArray(my_array));
}
void print_html_list(string text, string [int] my_array)
{
	print_html_list(text, "", my_array);
}
void print_html_list(string text, boolean [string] my_array)
{
	print_html_list(text,"",BooleanStringToStringArray(my_array));
}


void print_html_list(string text, string [int] words, string [int] my_array)
{
	buffer my_list;
	my_list.append(HTMLGenerateTagWrap("b",my_array[0]));
	for num from 1 to my_array.count() - 1 by 1
	{
		my_list.append(", ");
		my_list.append(HTMLGenerateTagWrap("b",my_array[num]));
	}
	
	buffer output;
	matcher replacer = create_matcher("%s",text);
	for num from 0 to words.count() - 1 by 1
	{
		replacer.find();
		append_replacement(replacer,output,HTMLGenerateTagWrap("b",words[num]));
	}
	replacer.find();
	append_replacement(replacer,output,my_list.to_string());
	append_tail(replacer,output);
	print_html(output.to_string());
}

///////////////////////
//Food/Booze related

record consumables
{
	boolean loaded;
	int [item] food;
	int [item] booze;
	int [item] spleen;
	int [item] multi;
	int [item] potions;
	int [item] all_usables;
	int [item] reusables;
	int [item] other_usables;
	int [item] candy;
	int [item] other;
};

boolean is_potion(item potion)
{
	if(effect_modifier(potion, "effect") != $effect[none])
	{
		return true;
	}
	return false;
}

consumables get_consumables()
{

	consumables my_consumables;
	foreach it in get_inventory()
	{
		if(it.fullness > 0 && it.inebriety == 0 && it.spleen == 0)
		{
			my_consumables.food[it] = get_inventory()[it];
		}
		else if(it.fullness == 0 && it.inebriety > 0 && it.spleen == 0)
		{
			my_consumables.booze[it] = get_inventory()[it];
		}
		else if(it.fullness == 0 && it.inebriety == 0 && it.spleen > 0)
		{
			my_consumables.spleen[it] = get_inventory()[it];
		}
		else if(it.fullness > 0 || it.inebriety > 0 || it.spleen > 0)
		{
			my_consumables.multi[it] = get_inventory()[it];
		}
		else if(it.usable)
		{
			my_consumables.all_usables[it] = get_inventory()[it];
			
			if(is_potion(it))
			{
				my_consumables.potions[it] = get_inventory()[it];
			}
			
			if(it.reusable)
			{
				my_consumables.reusables[it] = get_inventory()[it];
			}

			if(!it.reusable && !is_potion(it))
			{
				my_consumables.other_usables[it] = get_inventory()[it];
			}
		}
		else if(!it.candy)
		{
			my_consumables.other[it] = get_inventory()[it];
		}
		
		if(it.candy)
		{
			my_consumables.candy[it] = get_inventory()[it];
		}		
	}
	return my_consumables;
}

int inebriety_left()
{
	return inebriety_limit() - my_inebriety();
}

int get_adv(item it)
{
	string [int] nums = it.adventures.split_string("-");
	switch(nums.count())
	{
		case 0:
			return 0;
		case 1:
			return it.adventures.to_int();
		case 2:
			return nums[0].to_int() + (nums[1].to_int() - nums[0].to_int())/2;
		default:
			print_html("Adventure format %s unrecognized for item %s, returning 0",string[int]{it.adventures,it.to_string()});
			return 0;
	}
}

int adv_from_items(int [item] it_list)
{
	int adv = 0;
	foreach it in it_list
	{
		adv += it_list[it] * it.get_adv();
	}
	return adv;

}
////////////////////
//Mail Functions
record mail
{
	string from_player;
	int from_id;

	string date;
	string day;
	string time;

	string body;

	item [int] attached_items;
	string [int] item_strings;
};

mail _add_mail_items(mail my_mail, string item_table)
{
	//matcher m = create_matcher("alt=\"(.*\\?)\"",item_table);
	string [int,int] item_strings = item_table.group_string("alt=\"(.*?)\"");
	foreach num in item_strings
	{
		my_mail.attached_items[num] = item_strings[num][1].to_item();
		my_mail.item_strings[num] = item_strings[num][1];
	}
	return my_mail;
}

mail [int] get_mail()
{
	mail [int] my_mail;

	string mail_page = visit_url("messages.php");
	buffer mail_matcher;

	//player name and id
	mail_matcher.append("<b>From</b>.*?<a href=\"showplayer.php\\?who=(\\d*)\">(.*?)</a>");
	
	//date
	mail_matcher.append(".*?<b>Date:</b>.*?!--(.*?)-->");

	//body and items (if any)
	mail_matcher.append(".*?<blockquote>(.*?)(<center>.*?</center>)?</blockquote>");

	//matcher message_match = create_matcher(mail_matcher,mail_page);
	//print(mail_matcher.to_string());
	string [int,int] messages = group_string(mail_page,mail_matcher.to_string());

	print(messages.count().to_string());
	foreach num in messages
	{
		mail new_mail;
		new_mail.from_id =  messages[num][1].to_int();
		new_mail.from_player =  messages[num][2];
		new_mail.date = messages[num][3];
		new_mail.day = format_date_time("MM/dd/yy hh:mm:ss",new_mail.date,"yyyyMMdd");
		new_mail.time = format_date_time("MM/dd/yy hh:mm:ss",new_mail.date,"HH:mm:ss");
		
		
		new_mail.body = messages[num][4];
		if(messages[num].count() > 5 )
		{
			new_mail = new_mail._add_mail_items(messages[num][5]);
		}
		my_mail[num] = new_mail;
	}
	/*
	int index = 0;
	while(message_match.find())
	{
		mail new_mail;
		new_mail.from_id =  message_match.group(1).to_int();
		new_mail.from_id =  message_match.group(2);
		new_mail.date = message_match.group(1);
		
		results[index] = message_match.group(0);
	}
	*/
	return my_mail;
}

mail [string,string,int] sort_mail_by_name_date(mail [int] raw_mail)
{
	mail [string,string,int] sorted_mail;
	foreach num in raw_mail
	{
		string the_sender = raw_mail[num].from_player;
		string the_day = raw_mail[num].day;
		int count = sorted_mail[the_sender,the_day].count();
		
		sorted_mail[the_sender,the_day,count] =  raw_mail[num];
		
	}
	return sorted_mail;
}
/*
visit_url("clan_viplounge.php?preaction=lovetester", false)
"choice.php?whichchoice=1278&pwd&option=1
"&which=1"
"&whichid="
"&q1="
"&q2="
"&q3="
*/
buffer get_initial_url(int choice_id, int option)
{
	buffer url_text;
	url_text.append("choice.php?whichchoice=");
	url_text.append(choice_id.to_string());
	url_text.append("&pwd&option=");
	url_text.append(option.to_string());

	return url_text;
}

string visit_choicephp(int choice_id, int option, string [string] choices)
{
	buffer url_text = get_initial_url(choice_id, option);
	foreach name in choices
	{
		url_text.append("&");
		url_text.append(name);
		url_text.append("=");
		url_text.append(choices[name]);
	}
	print(url_text);
	return visit_url(url_text,true);
}
string visit_choicephp(int id, string [string] choices)
{
	return visit_choicephp(id, 1, choices);
}

string visit_choicephp(int id, int option, string [int] choices)
{
	buffer url_text = get_initial_url(id, option);
	foreach num in choices
	{
		url_text.append("&");
		url_text.append(choices[num]);
	}
	print(url_text);
	return visit_url(url_text,true);
}
string visit_choicephp(int id, string [int] choices)
{
	return visit_choicephp(id, 1, choices);
}

void main()
{

}


int _clan_fortune_id = 1278;

record cmd_info
{
	boolean [string] inputs;
	string output;
	string description;
};

record clan_fortune_status
{
	string [string] requests;
	int remaining;
	boolean npc_fortune_done;
};

record clan_fortune_entries
{
	string name;
	string fav_food;
	string fav_char;
	string fav_word;
};

record clan_fortune_transaction
{
	player_info sender_info;
	string send_date; //today_to_string().to_int()
	string send_date_game; // gameday_to_string()
	time send_time;
	int request_number;
	
	string receiver_name;
	player_info receiver_info;
	string response_date; // realworld
	time received_time;
	mail received_mail;
	
	string test_results;
	item [int] received_items;
	string [int] received_items_str;
	
	clan_fortune_entries send_entries;
	clan_fortune_entries received_entries;
	
	boolean complete;
	
	
};


///////////////////////
//global variables
clan_fortune_entries [string] clan_fortune_entries_array;
string _clan_fortune_entries_file = "clan_fortune_templates.txt";

	//YYYYMMDD, transaction #
clan_fortune_transaction [string, int] _clan_fortune_history_array;
string _clan_fortune_history_file = my_name() + "_clan_fortune_history.txt";

///////////////////////
//Record Saving
boolean SaveClanFortuneEntries()
{
	print("Saving clan_fortune_entries_array");
	return map_to_file(clan_fortune_entries_array,_clan_fortune_entries_file);
}

boolean SaveClanFortuneHistory()
{
	print("Saving _clan_fortune_history_array");
	return map_to_file(_clan_fortune_history_array,_clan_fortune_history_file);
}

////////////////////////////////
//Array Retrieval Functions
clan_fortune_entries [string] ClanFortuneEntries_Array()
{
	if (clan_fortune_entries_array.count() == 0)
	{
		print("clan_fortune_entries_array Map is empty, attempting to load from file...");
		if(file_to_map(_clan_fortune_entries_file,clan_fortune_entries_array))
		{
			if (clan_fortune_entries_array.count() == 0)
			{
				log_print("file empty, no clan fortune templates settings found...");
			}
			else
			{
				log_print("loaded clan_fortune_entries_array settings from file...");
			}
		}
		else
		{
			log_print("Could not load from " + _clan_fortune_entries_file + ", assuming no clan fortune template settings have been made");
		}
	}
	return clan_fortune_entries_array;
}

clan_fortune_transaction [string, int] ClanFortuneHistory_Array()
{
	if (_clan_fortune_history_array.count() == 0)
	{
		print("_clan_fortune_history_array Map is empty, attempting to load from file...");
		if(file_to_map(_clan_fortune_history_file,_clan_fortune_history_array))
		{
			if (_clan_fortune_history_array.count() == 0)
			{
				log_print("file empty, no _clan_fortune_history_array settings found...");
			}
			else
			{
				log_print("loaded _clan_fortune_history_array settings from file...");
			}
		}
		else
		{
			log_print("Could not load from " + _clan_fortune_history_file + ", assuming no clan fortune history settings have been made");
		}
	}
	return _clan_fortune_history_array;
}
////////////////////////////////
//Existance
boolean ClanFortuneEntries_Exists(string template)
{
	if(ClanFortuneEntries_Array() contains template)
	{
		print_html("Existence Check: Clan Fortune Template %s exists.",template);
		return true;
	}
	else
	{
		print_html("Existence Check: Clan Fortune Template %s not found.", template);
		return false;
	}
	return false;
}
////////////////////////////////
//Set/Add Records
boolean Set_ClanFortuneTemplate(string name, string fav_food, string fav_char, string fav_word, boolean override)
{
	if(!ClanFortuneEntries_Exists(name) || override)
	{
		clan_fortune_entries new_template;
		new_template.name = name;
		new_template.fav_food = fav_food;
		new_template.fav_char = fav_char;
		new_template.fav_word = fav_word;

		ClanFortuneEntries_Array()[name] = new_template;

		SaveClanFortuneEntries();
		print_html_list("Clan Fortune Template %s made with terms %s", new_template.name, string [int]{new_template.fav_food, new_template.fav_char, new_template.fav_word});
		return true;
	}
	else
	{
		print_html("Error: Can't make Clan Fortune Template %s.  It already exists.", name);
	}
	return false;
}

boolean Add_Transaction(int request_number, string receiver, clan_fortune_entries entries)
{
	clan_fortune_transaction new_transaction;
	new_transaction.sender_info = get_player_info();
	new_transaction.send_date = today_to_string();
	new_transaction.send_time = time_to_string().to_time();
	new_transaction.send_date_game = gameday_to_string();
	new_transaction.request_number = request_number;
	new_transaction.receiver_name = receiver;
	ClanFortuneHistory_Array()[new_transaction.send_date, request_number] = new_transaction;
	
	SaveClanFortuneHistory();
	return true;
}
boolean Add_Transaction(int request_number, string receiver, string fav_food, string fav_char, string fav_word)
{
	clan_fortune_entries entry;
	entry.fav_food = fav_food;
	entry.fav_char = fav_char;
	entry.fav_word = fav_word;
	return Add_Transaction(request_number, receiver, entry);
}

/*
boolean Finish_Transaction(clan_fortune_transaction response_info, clan_fortune_entries entry, string [int] received_items)
{
	mail [string,string,int] cf_mail = get_clanfortune_mail().sort_mail_by_name_date();
	string check_date = today_to_string();
	for back_days from 7 to 0 by -1
	{
		string check_date = previous_day(today_to_string(),back_days);
		if(ClanFortuneHistory_Array() contains check_date)
		{
			mail [int] candidates;
			foreach num in cf_mail
			{
				if(cf_mail[num].date.to_int() >= check_date.to_int())
				{
					candidates()
				}
			}
		}
		
	}
	
	
	
	return true;
}
*/
///////////////////////
//Info Array
cmd_info [string] clan_fortune_info()
{
	cmd_info [string] cf_info;

	//susie
	cmd_info susie;
	susie.inputs["susie, the arena master (npc)"] = true;
	susie.inputs["susie"] = true;
	susie.inputs["arena master"] = true;
	susie.inputs["susie, the arena master"] = true;
	susie.inputs["susie, the arena master (npc)"] = true;
	susie.inputs["familiar"] = true;
	susie.output = "-1";
	susie.description = "A Girl Named Sue: +5 familiar weight, +10 familiar damage, +5 familiar xp/fight";
	
	cf_info["susie"] = susie;

	//hangk
	cmd_info hangk;
	hangk.inputs["hangk"] = true;
	hangk.inputs["hangk (npc)"] = true;
	hangk.inputs["item"] = true;
	hangk.inputs["food"] = true;
	hangk.inputs["booze"] = true;
	hangk.output = "-2";
	hangk.description = "There's No N In Love:  +50% food drops, +50% booze drops, +50% item drops";
	
	cf_info["hangk"] = hangk;

	//meatsmith
	cmd_info meatsmith;
	meatsmith.inputs["meatsmith"] = true;
	meatsmith.inputs["meatsmith (npc)"] = true;
	meatsmith.inputs["the meatsmith (npc)"] = true;
	meatsmith.inputs["the meatsmith"] = true;
	meatsmith.inputs["meat"] = true;
	meatsmith.inputs["gear"] = true;
	meatsmith.output = "-3";
	meatsmith.description = "Meet The Meat:  +50% gear drops, +100% meat drops";
	
	cf_info["meatsmith"] = meatsmith;

	//gunther
	cmd_info gunther;
	gunther.inputs["gunther"] = true;
	gunther.inputs["gunther, lord of the smackdown (npc)"] = true;
	gunther.inputs["lord of the smackdown"] = true;
	gunther.inputs["mus"] = true;
	gunther.inputs["muscle"] = true;
	gunther.inputs["hp"] = true;
	gunther.output = "-4";
	gunther.description = "Gunther Than Thou:  +100% mus, +50% HP, +5 mus stats/fight";
	
	cf_info["gunther"] = gunther;

	//gorgonzola
	cmd_info gorgonzola;
	gorgonzola.inputs["gorgonzola"] = true;
	gorgonzola.inputs["gorgonzola, the chief chef (npc)"] = true;
	gorgonzola.inputs["the chief chef"] = true;
	gorgonzola.inputs["myst"] = true;
	gorgonzola.inputs["mysticality"] = true;
	gorgonzola.inputs["mp"] = true;
	gorgonzola.output = "-5";
	gorgonzola.description = "Everybody Calls Him Gorgon:  +100% myst, +50% MP, +5 myst stats/fight";
	
	cf_info["gorgonzola"] = gorgonzola;

	//shifty
	cmd_info shifty;
	shifty.inputs["shifty"] = true;
	shifty.inputs["shifty, the thief chief (npc)"] = true;
	shifty.inputs["the hief chief "] = true;
	shifty.inputs["mox"] = true;
	shifty.inputs["moxie"] = true;
	shifty.inputs["init"] = true;
	shifty.inputs["initiative"] = true;
	shifty.output = "-6";
	shifty.description = "They Call Me Shifty:  +100% mox, +50% combat init, +5 mox stats/fight";
	
	cf_info["shifty"] = shifty;

	return cf_info;

}
///////////////////////
//help
void print_clan_fortune_help()
{
	cmd_info [string] cf_info = clan_fortune_info();

	print("command in form npc|clan,name|id|choice,food,name,word");
	print("Basically, for npc options: npc,name|choice,food,name,word");
	print("for clan member options: clan,id,food,name,word");
	print("...or: clan,name,food,name,word");
	print("");
	print("For npc options, the following can be entered:");
	foreach name in cf_info
	{
		print_html_list("For NPC %s name/choice = %s",name,cf_info[name].inputs);
		print_html("Results in %s",cf_info[name].description);
	}
	print("");
	print("");
	print("Making default choices:");
	print("defaults,1st contact,<name>  -- saves <name> as first contact when sending requests");
	print("defaults,2nd contact,<name>  -- saves <name> as second contact when sending requests");
	print("defaults,3rd contact,<name>  -- saves <name> as third contact when sending requests");
	print("defaults,1st response,<name>  -- saves <name> as first answer when when responding to requests");
	print("defaults,2nd response,<name>  -- saves <name> as second answer when when responding to requests");
	print("defaults,3rd response,<name>  -- saves <name> as third answer when when responding to requests");
	print("defaults,1st answer,<name>  -- saves <name> as first answer when sending requests");
	print("defaults,2nd answer,<name>  -- saves <name> as second answer when sending requests");
	print("defaults,3rd answer,<name>  -- saves <name> as third answer when sending requests");
	print("");
	print("print defaults -- prints all set defaults");
	print("");
	print("");
	print("quicksend -- sends default answers to each default contact in order");
	print("respond all -- responds to all waiting requests with default answers");
	print("");
	print("status -- shows current status on how many requests you have made and who is waiting for responses");


}
///////////////////////
//Initialize visit

clan_fortune_status init_fortune_visit()
{
	string entry = visit_url("clan_viplounge.php?preaction=lovetester");
	clan_fortune_status my_status;

	string [int][int] request_array = entry.group_string("(clan_viplounge.php\\?preaction=testlove&testlove=\\d*)\">(.*?)</a>");

	foreach num in request_array
	{
		string req_url = request_array[num][1];
		string name = request_array[num][2];
		
		my_status.requests[name] = req_url;
	}
	matcher m = create_matcher("You may still consult Madame Zatara about your relationship with a clanmate (\\d) times? today", entry);
	if(m.find())
	{
		my_status.remaining = m.group(1).to_int();
	}
	else
	{
		my_status.remaining = 0;
	}
	return my_status;
}

mail [int] get_clanfortune_mail()
{
	mail [int] my_mail = get_mail();

	mail [int] fortune_mail;
	int index = 0;
	foreach num in my_mail
	{
		if (my_mail[num].body.contains_rgx("completed your relationship fortune test!.*?Here are your results:"))
		{
			fortune_mail[index] = my_mail[num];
			index++;
		}
	}

	return fortune_mail;
}

///////////////////////
//Print Output
void print_fortune_status()
{
	clan_fortune_status my_status = init_fortune_visit();
	print_html("Incoming Fortune Requests");
	foreach name in my_status.requests
	{
		print_html("%s with url: %s", string[int]{name,my_status.requests[name]});
	}
	print_html("Remaining Outgoing Fortune Requests: %s ", my_status.remaining.to_string());
}

void print_clanfortune_mail()
{
	mail [int] my_mail = get_clanfortune_mail();

	print_html("There are a total of %s fortune messages", my_mail.count().to_string());
	foreach num in my_mail
	{
		print_html("Return Fortune #%s",num.to_string());
		print_html("from: %s (%s)", string[int]{my_mail[num].from_player,my_mail[num].from_id});
		print_html("date: %s", my_mail[num].date);
		print_html("day: %s", my_mail[num].day);
		print_html("time: %s", my_mail[num].time);
		print_html(my_mail[num].body);
		print_html_list("Attached Items: %s", my_mail[num].item_strings);
		print("");
	}
}

void Print_Fortune_Template(clan_fortune_entries template)
{
	print_html_list("%s, entries: %s", template.name, string[int]{template.fav_food,template.fav_char, template.fav_word});
}
void Print_Fortune_Template(string template_name)
{
	if(ClanFortuneEntries_Exists(template_name))
	{
		Print_Fortune_Template(template_name);
	}
	else
	{
		print_html("Clan Fortune Error:  Requested Template %s does not exist", template_name);
	}
}
void Print_Fortune_Templates()
{
	print_html("<b><u>Clan Fortune Templates</b></u>");
	foreach name in ClanFortuneEntries_Array()
	{
		Print_Fortune_Template(ClanFortuneEntries_Array()[name]);
	}

}

void print_clanfortune_defaults()
{
	print_html("Default 1st contact: %s", get_property("clanfortune_1stContact"));
	print_html("Default 2nd contact: %s", get_property("clanfortune_2ndContact"));
	print_html("Default 3rd contact: %s", get_property("clanfortune_3rdContact"));
	print_html("Default 1st response: %s", get_property("clanfortune_1stResponse"));
	print_html("Default 2nd response: %s", get_property("clanfortune_2ndResponse"));
	print_html("Default 3rd response: %s", get_property("clanfortune_3rdResponse"));
	print_html("Default 1st answer: %s", get_property("clanfortune_1stAnswer"));
	print_html("Default 2nd answer: %s", get_property("clanfortune_2ndAnswer"));
	print_html("Default 3rd answer: %s", get_property("clanfortune_3rdAnswer"));
}

///////////////////////
//Initiating Fortunes
	///////////////////////
	//Send to NPC
string npc_fortune(int npc_id, string fav_food, string fav_char, string fav_word)
{
	string [string] choices;
	choices["which"] = npc_id.to_string(); //doing an npc member
	choices["q1"] = fav_food;
	choices["q2"] = fav_char;
	choices["q3"] = fav_word;
	init_fortune_visit();
	return visit_choicephp(1278,choices);
}

string npc_fortune_select(string npc_string, string fav_food, string fav_char, string fav_word)
{
	cmd_info [string] cf_info = clan_fortune_info();
	foreach name in cf_info
	{
		foreach cmd in cf_info[name].inputs
		{
			if(npc_string.to_lower_case() == cmd)
			{
				return npc_fortune(cf_info[name].output.to_int(), fav_food, fav_char, fav_word);
			}
		}
	}
	return "";
}

string npc_fortune_select(string npc_string, clan_fortune_entries template)
{
	return npc_fortune_select(npc_string,template.fav_food,template.fav_char,template.fav_word);
}

string npc_fortune_select(string npc_string, string template_name)
{
	if(ClanFortuneEntries_Exists(template_name))
	{
		return npc_fortune_select(npc_string, ClanFortuneEntries_Array()[template_name]);
	}
	else
	{
		print_html("Clan Fortune Error:  Requested Template %s does not exist", template_name);
	}
	return "";
}

	///////////////////////
	//Send to Name

string clan_member_fortune(string member, string fav_food, string fav_char, string fav_word)
{
	string [string] choices;
	choices["which"] = "1"; //doing a clan member
	choices["whichid"] = member;//clan member id
	choices["q1"] = fav_food;
	choices["q2"] = fav_char;
	choices["q3"] = fav_word;
	clan_fortune_status my_status = init_fortune_visit();
	if(my_status.remaining != 0)
	{
		if(get_property("record_clan_fortune_info") == "true")
		{
			Add_Transaction(4 - my_status.remaining, member, fav_food, fav_char, fav_word);
		}
		string html = visit_choicephp(1278,choices);
		print_html_list("Sent fortune request #%s to %s with answers: %s (food), %s (character), %s (word)", string[int]{my_status.remaining.to_string(), member, fav_food,fav_char,fav_word});
		return html;
	}
	else
	{
		print("No more consultations left today");
	}
	return "";
}
string clan_member_fortune(int id, string fav_food, string fav_char, string fav_word)
{
	return clan_member_fortune(id.to_string(),fav_food,fav_char,fav_word);
}

string clan_member_fortune(string member, clan_fortune_entries template)
{
	return clan_member_fortune(member,template.fav_food,template.fav_char,template.fav_word);
}
string clan_member_fortune(int id, clan_fortune_entries template)
{
	return clan_member_fortune(id.to_string(), template);
}

string clan_member_fortune(string member, string template_name)
{
	if(ClanFortuneEntries_Exists(template_name))
	{
		return clan_member_fortune(member, ClanFortuneEntries_Array()[template_name]);
	}
	else
	{
		print_html("Clan Fortune Error:  Requested Template %s does not exist", template_name);
	}
	return "";
}
string clan_member_fortune(int id, string template_name)
{
	return clan_member_fortune(id.to_string(), template_name);
}

string clan_member_fortune(string name)
{
	string fav_food = get_property("clanfortune_1stAnswer");
	string fav_char = get_property("clanfortune_2ndAnswer");
	string fav_word = get_property("clanfortune_3rdAnswer");
	
	return clan_member_fortune(name,fav_food,fav_char,fav_word);
}

///////////////////////
//Returning Fortunes
string process_return_fortune(string url, string fav_food, string fav_char, string fav_word)
{
	buffer url_text;
	url_text.append(url);
	url_text.append("&pwd&option=1");

	string [string] choices;
	choices["q1"] = fav_food;
	choices["q2"] = fav_char;
	choices["q3"] = fav_word;	
	foreach response in choices
	{
		url_text.append("&");
		url_text.append(response);
		url_text.append("=");
		url_text.append(choices[response]);
	}
	//print(url_text);
	return visit_url(url_text,true);
}

	///////////////////////
	//Return to Name
string return_fortune(string name, string fav_food, string fav_char, string fav_word)
{
	clan_fortune_status my_status = init_fortune_visit();
	string response;
	if(my_status.requests contains name)
	{
		string response_url = my_status.requests[name];
		response_url = response_url.replace_string("preaction\=testlove","preaction\=dotestlove");
		//print(response_url);
		response = process_return_fortune(response_url,fav_food,fav_char,fav_word);
	}
	else
	{
		abort("Responding to Fortune Request Error! Invalid name provided: " + name);
	}
	print_html_list("Sent response to %s with responses: %s", name, string[int]{fav_food,fav_char,fav_word});
	return response;
}
string return_fortune(string name, clan_fortune_entries template)
{
	return return_fortune(name, template.fav_food,template.fav_char,template.fav_word);
}
string return_fortune(string name, string template_name)
{
	if(ClanFortuneEntries_Exists(template_name))
	{
		return return_fortune(name, ClanFortuneEntries_Array()[template_name]);
	}
	else
	{
		print_html("Clan Fortune Error:  Requested Template %s does not exist", template_name);
	}
	return "";
}

string return_fortune(string name)
{
	string fav_food = get_property("clanfortune_1stResponse");
	string fav_char = get_property("clanfortune_2ndResponse");
	string fav_word = get_property("clanfortune_3rdResponse");
	
	return return_fortune(name,fav_food,fav_char,fav_word);
}

	///////////////////////
	//Return All
string [string] return_all_fortunes(string fav_food, string fav_char, string fav_word)
{
	clan_fortune_status my_status = init_fortune_visit();
	string [string] responses;
	foreach name in my_status.requests
	{
		responses[name] = return_fortune(name,fav_food,fav_char,fav_word);
	}
	return responses;
}
string [string] return_all_fortunes(clan_fortune_entries template)
{
	return return_all_fortunes(template.fav_food,template.fav_char,template.fav_word);
}
string [string] return_all_fortunes(string template_name)
{
	if(ClanFortuneEntries_Exists(template_name))
	{
		return return_all_fortunes(ClanFortuneEntries_Array()[template_name]);
	}
	else
	{
		print_html("Clan Fortune Error:  Requested Template %s does not exist", template_name);
	}
	string [string] empty;
	return empty;
}

string return_all_fortunes()
{
	string fav_food = get_property("clanfortune_1stResponse");
	string fav_char = get_property("clanfortune_2ndResponse");
	string fav_word = get_property("clanfortune_3rdResponse");
	
	return return_all_fortunes(fav_food,fav_char,fav_word);
}

///////////////////////
//Parsing Command Line
void clanfortune_parse(string command)
{
	string [int] cmd_array = split_string(command,",");
	string response;
	string [int] subarray;
	
	switch(cmd_array[0].to_lower_case())
	{
		case "help":
		case "?":
			print_clan_fortune_help();
			break;
		case "npc":
			switch(cmd_array.count())
			{
				case 2:
					response = npc_fortune_select(cmd_array[1],"send");
					break;
				case 3:
					response = npc_fortune_select(cmd_array[1],cmd_array[2]);
					break;
				case 5:
					response = npc_fortune_select(cmd_array[1],cmd_array[2],cmd_array[3],cmd_array[4]);
					break;
			}
			//print_html(response);
			break;
		case "clan":
			switch(cmd_array.count())
			{
				case 3:
					response = clan_member_fortune(cmd_array[1],cmd_array[2]);
					break;
				case 5:
					response = clan_member_fortune(cmd_array[1],cmd_array[2],cmd_array[3],cmd_array[4]);
					break;
			}
			//print_html(response);
			break;
		case "quicksend":
			string my1stsend = clan_member_fortune(get_property("clanfortune_1stContact"));
			string my2ndsend = clan_member_fortune(get_property("clanfortune_2ndContact"));
			string my3rdsend = clan_member_fortune(get_property("clanfortune_3rdContact"));
			break;
		case "status":
			print_fortune_status();
			break;
		case "respond":
		case "return":
			switch(cmd_array.count())
			{
				case 3:
					response = return_fortune(cmd_array[1],cmd_array[2]);
					break;
				case 5:
					response = return_fortune(cmd_array[1],cmd_array[2],cmd_array[3],cmd_array[4]);
					break;
			}
			return_fortune(cmd_array[1],cmd_array[2],cmd_array[3],cmd_array[4]);
			break;
		case "respond all":
		case "return all":
			switch(cmd_array.count())
			{
				case 1:
					return_all_fortunes();
					break;
				case 2:
					response = return_all_fortunes(cmd_array[1]);
					break;
				case 4:
					response = return_all_fortunes(cmd_array[1],cmd_array[2],cmd_array[3]);
					break;
			}
			break;
		case "mail":
			print_clanfortune_mail();
			break;
		case "write template":
		case "make template":
		case "mt":
		case "wt":
			Set_ClanFortuneTemplate(cmd_array[1],cmd_array[2],cmd_array[3],cmd_array[4],false);
			break;
		case "print template":
		case "list template":
		case "lt":
		case "pt":
			switch(cmd_array.count())
			{
				case 1:
					Print_Fortune_Templates();
					break;
				case 2:
					Print_Fortune_Template(cmd_array[1]);
					break;
			}
			break;
		case "favs":
			string [string] fav_consumes = get_favorite_consumes();
			print(fav_consumes["food"]);
			print(fav_consumes["booze"]);
			break;
		case "prevday":
			print(previous_day(cmd_array[1]));
			break;
		case "record":
			switch(cmd_array.count())
			{
				case 1:
					print_html("Recording status: ", get_property("record_clan_fortune_info"));
					break;
				case 2:
					switch(cmd_array[1])
					{
						case "on":
							set_property("record_clan_fortune_info","true");
							print_html("Recording status: %s", get_property("record_clan_fortune_info"));
							break;
						case "off":
							set_property("record_clan_fortune_info","false");
							print_html("Recording status: %s", get_property("record_clan_fortune_info"));
							break;
						default:
							print_html("Record command not recognized");
							break;
					}
					
					break;
				default:
					print_html("Record command not recognized");
					break;
			}
			break;
		case "defaults":
			switch(cmd_array[2])
			{
				case "1st contact":
					set_property("clanfortune_1stContact",cmd_array[3]);
					print_html("Default 1st contact: %s", get_property("clanfortune_1stContact"));
					break;
				case "2nd contact":
					set_property("clanfortune_2ndContact",cmd_array[3]);
					print_html("Default 2nd contact: %s", get_property("clanfortune_2ndContact"));
					break;
				case "3rd contact":
					set_property("clanfortune_3rdContact",cmd_array[3]);
					print_html("Default 3rd contact: %s", get_property("clanfortune_3rdContact"));
					break;
				case "1st response":
					set_property("clanfortune_1stResponse",cmd_array[3]);
					print_html("Default 1st response: %s", get_property("clanfortune_1stResponse"));
					break;
				case "2nd response":
					set_property("clanfortune_2ndResponse",cmd_array[3]);
					print_html("Default 2nd response: %s", get_property("clanfortune_2ndResponse"));
					break;
				case "3rd response":
					set_property("clanfortune_3rdResponse",cmd_array[3]);
					print_html("Default 3rd response: %s", get_property("clanfortune_3rdResponse"));
					break;
				case "1st answer":
					set_property("clanfortune_1stAnswer",cmd_array[3]);
					print_html("Default 1st answer: %s", get_property("clanfortune_1stAnswer"));
					break;
				case "2nd answer":
					set_property("clanfortune_2ndAnswer",cmd_array[3]);
					print_html("Default 2nd answer: %s", get_property("clanfortune_2ndAnswer"));
					break;
				case "3rd answer":
					set_property("clanfortune_3rdAnswer",cmd_array[3]);
					print_html("Default 3rd answer: %s", get_property("clanfortune_3rdAnswer"));
					break;
				default:
					print_html("%s is not default setting", cmd_array[2]);
					break;
			}
			break;
		case "print defaults":
		case "list defaults":
			print_clanfortune_defaults();
			break;
		case "quick defaults":
			set_property("clanfortune_1stContact","AverageChat");
			if(my_name().to_lower_case() == "rabbitfoot")
			{
				set_property("clanfortune_2ndContact","meowserio");
				set_property("clanfortune_3rdContact","Stewbeef");
			}
			else if(my_name().to_lower_case() == "meowserio")
			{
				set_property("clanfortune_2ndContact","Rabbitfoot");
				set_property("clanfortune_3rdContact","Stewbeef");
			}
			else
			{
				set_property("clanfortune_2ndContact","Rabbitfoot");
				set_property("clanfortune_3rdContact","meowserio");
			
			}
			set_property("clanfortune_1stResponse","beer");
			set_property("clanfortune_2ndResponse","robin");
			set_property("clanfortune_3rdResponse","thin");
			set_property("clanfortune_1stAnswer","pizza");
			set_property("clanfortune_2ndAnswer","batman");
			set_property("clanfortune_3rdAnswer","thick");
			
			
			print_clanfortune_defaults();
			break;
		default:
			print("invalid command, type ? or help for help");
			break;
	}
}

void main(string command)
{
	clanfortune_parse(command);
}
