program sort_research;
type
	T_elem=integer;

	{ FPC dynamic array https://wiki.freepascal.org/Dynamic_array }
	T_arr=array of T_elem;

var arr:T_arr;
    n:integer;
    i:integer;

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

procedure select_sort(var arr:T_arr; n:integer);
begin

end;

procedure heap_sort(var arr:T_arr; n:integer);
begin

end;

procedure write_array(var arr:T_arr; n:integer);
var i:integer;
begin
	write(arr[0]);
	for i:=1 to n-1 do
		write(' ', arr[i]);
	writeln
end;

begin
	randomize;
	{
	n:=6;                            
	for i:=1 to 4 do                 
	begin                            
		generate_array(arr,n,i);  
		write(i,': ');            
		write_array(arr, n);      
	end;                             
	}
end.
