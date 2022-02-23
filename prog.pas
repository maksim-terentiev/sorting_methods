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
      { writeln('gen inverted'); }
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
      { writeln('gen sorted'); }
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

procedure swap(var a,b:T_elem);
var tmp:T_elem;
begin
	tmp:=a;
	a:=b;
	b:=tmp;
end;

procedure bubble_sort(var arr:T_arr; n:integer);
var sorted:boolean;
    i:integer;
    cmp_count,swap_count:integer;
begin
	cmp_count:=0; swap_count:=0;

	writeln('** Bubble sort started *');
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
	writeln('** Bubble sort ended   *');
	writeln('* cmp=',cmp_count);
	writeln('* swap=',swap_count);
	writeln
end;


procedure heap_sort(var arr:T_arr; n:integer);
var swap_count,cmp_count:integer;
  function left(i:integer):integer;
    begin left:= 2*i+1 end;
  function right(i:integer):integer;
    begin right:= 2*i+2 end;
  function parent(i:integer):integer;
    begin parent:= (i-1) div 2 end;
  procedure min_heapify(var arr:T_arr;n,i:integer);
    var l,r,smallest:integer;
    begin
        l:=left(i);
        r:=right(i);
        inc(cmp_count);inc(cmp_count);
        if (l<n) and (arr[l] < arr[i])
            then smallest:= l
            else smallest:=i;
        inc(cmp_count);inc(cmp_count);
        if (r<n) and (arr[r] < arr[smallest])
            then smallest:=r;
        inc(cmp_count);
        if smallest<>i then
        begin
            inc(swap_count);
            swap(arr[i],arr[smallest]);
            min_heapify(arr,n,smallest);
        end;
    end;
  procedure build_min_heap(var arr:T_arr;n:integer);
  var i:integer;
  begin
      for i:= (n-1) div 2 downto 0 do       { ? }
          min_heapify(arr,n,i);
  end;
begin
	cmp_count:=0; swap_count:=0;
	writeln('** Heap sort started *');
	{$ifdef VERBOSE}
	write('* Init:      '); write_array(arr,n);
	{$endif}

	build_min_heap(arr,n);
	{$ifdef VERBOSE}
	write('* Min_heap:  '); write_array(arr,n);
	{$endif}
	for i:=(n-1) downto 1 do
	begin
		inc(swap_count);
		swap(arr[0],arr[i]);
		{$ifdef VERBOSE_HEAP_SWAP}
		write('* Swap:      '); write_array(arr,n);
		{$endif}
		min_heapify(arr,i,0);
		{$ifdef VERBOSE}
		write('* Sort step: '); write_array(arr,n);
		{$endif}
	end;
	writeln('** Heap sort ended *');
	writeln('* cmp=',cmp_count);
	writeln('* swap=',swap_count);
	writeln
end;


procedure testing; { temporaly for testing generation and bubble }
var arr,init_arr:T_arr;
    n:integer;
    i:integer;
begin
	n:=6;                            
	for i:=1 to 4 do                 
	begin                            
		generate_array(init_arr,n,i);  
		write(i,': ');            
		write_array(init_arr, n);      

		arr:=copy(init_arr,0,length(init_arr)); {dynArray copy}
		bubble_sort(arr,n);
		write('arr=');
		write_array(arr,n);
		writeln;


		arr:=copy(init_arr,0,length(init_arr)); {dynArray copy}
		write(i,': ');            
		write_array(arr, n);      
		heap_sort(arr,n);
		write('arr=');
		write_array(arr,n);
		writeln;
	end;                             
end;

procedure manual_input;
var arr,init_arr:T_arr;
    n:integer;
    i:integer;
begin
	read(n);
	read_array(init_arr,n);
	arr:=copy(init_arr,0,length(init_arr)); {dynArray copy}
	bubble_sort(arr,n);
	arr:=copy(init_arr,0,length(init_arr)); {dynArray copy}
	heap_sort(arr,n);
end;

begin
	randomize;

	{ ParamCount and ParamStr(i) command line options }
	if ParamCount <> 0 then
	begin
		if (ParamStr(1)='-m') then
		begin
			manual_input;
			halt
		end
		else
		begin
			writeln(
		     'Please use only "./prog -m < input.txt" or "./prog"');
			halt
		end;
	end
	else testing;
end.
