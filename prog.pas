{$define VERBOSE}
program sort_research;
type
	T_elem=integer;

	{ FPC dynamic array https://wiki.freepascal.org/Dynamic_array }
	T_arr=array of T_elem;

var arr:T_arr;
    n:integer;
    i:integer;

procedure write_array(var arr:T_arr; n:integer);
var i:integer;
begin
	write(arr[0]);
	for i:=1 to n-1 do
		write(' ', arr[i]);
	writeln
end;

procedure read_array(var arr:T_arr; n:integer);
var i,inp:integer;
begin
	SetLength(arr,n);
	for i:=0 to n-1 do
	begin
		read(inp);
		arr[i]:=inp;
	end;
end;


procedure generate_array(var arr:T_arr; n:integer; gen_type:integer);
  procedure gen_inverted(var arr:T_arr; n:integer);
  const MaxAdd=10;
  var i,j:integer;
  begin
      { writeln('gen sorted'); }
      j:=random(MaxAdd);
      for i:=0 to n-1 do
      begin
         arr[i]:=j;
	 j:=j+random(MaxAdd);
      end;
  end;
  procedure gen_sorted(var arr:T_arr; n:integer);
  const MaxSub=10;
  var i,j:integer;
  begin
      { writeln('gen inverted'); }
      j:=random(MaxSub);
      for i:=1 to n do
      begin
         arr[n-i]:=j;
	 j:=j+random(MaxSub);
      end;
  end;
  procedure gen_random(var arr:T_arr; n:integer);
  var i:integer;
  begin
      { writeln('gen random'); }
      for i:=0 to n-1 do
          arr[i]:=random(n)+1
  end;
begin
	SetLength(arr,n);
	case gen_type of
	1:   gen_sorted(arr,n);   { sorted  }
	2:   gen_inverted(arr,n); { iverted }
	3,4: gen_random(arr,n);   { random  }
	end;
end;


procedure bubble_sort(var arr:T_arr; n:integer);
var sorted:boolean;
    i:integer;
    cmp_count,swap_count:integer;
  procedure swap(var a,b:T_elem);
  var tmp:T_elem;
  begin
      tmp:=a;
      a:=b;
      b:=tmp;
  end;
begin
	cmp_count:=0; swap_count:=0;

	writeln('* Bubble sort started *');
	{$ifdef VERBOSE}
	write('* '); write_array(arr,n);
	{$endif}

	sorted:=false;
	while not sorted do
	begin
		sorted:=true;
		for i:=0 to n-2 do
		begin
			inc(cmp_count);
			if arr[i] < arr[i+1] then
			begin
				sorted:=false;
				inc(swap_count);
				swap(arr[i],arr[i+1]);
			end;
		end;
		{$ifdef VERBOSE}
		write('* '); write_array(arr,n);
		{$endif}
	end;
	writeln('* Bubble sort ended   *');
	writeln('* cmp=',cmp_count);
	writeln('* swap=',swap_count);
	writeln
end;


procedure heap_sort(var arr:T_arr; n:integer);
begin

end;


procedure testing; { temporaly for testing generation and bubble }
var arr:T_arr;
    n:integer;
    i:integer;
begin
	n:=6;                            
	for i:=1 to 4 do                 
	begin                            
		generate_array(arr,n,i);  
		write(i,': ');            
		write_array(arr, n);      
		bubble_sort(arr,n);
		write('arr=');
		write_array(arr,n);
		writeln
	end;                             
end;

begin
	randomize;

	{ ParamCount and ParamStr(i) command line options }
	if ParamCount <> 0 then
	begin
		if (ParamStr(1)='-m') then
		begin
			read(n);
			read_array(arr,n);
			bubble_sort(arr,n);
			heap_sort(arr,n);
			halt
		end
		else
		begin
			writeln(
		     'Please use only "./prog -m < input.txt" or "./prog"');
			halt
		end;
	end;
	testing;
end.
