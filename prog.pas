program sort_research;
type
	T_elem=integer;

	{ FPC dynamic array https://wiki.freepascal.org/Dynamic_array }
	T_arr=array of T_elem;

	{T_gen_type=(sorted, inverted, rand, manual);}

var arr:T_arr;
    n:integer;

procedure generate_array(var arr:T_arr; n:integer; gen_type:integer);
begin

end;

begin
	randomize;
end.
