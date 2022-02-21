program sort_research;
type
	T_data=integer;
	T_elem=record
		data:T_data;
		next:^T_elem
	end;

{#################################}
{# TODO: decide how to make list #}
{#       ? var l:^T_elem ? or    #}
{#       ? var l:T_lisr  ?       #}
{#################################}

	T_list=record                        
		fst:^T_elem; { fst -- first }
		lst:^T_elem  { lst -- last  }
	end;

var l:T_list;
    n:integer;

procedure init_list(var l:T_list);  { without first element }
begin
	new(l.fst);
	l.lst:=l.fst;
	l.fst^.next:=nil;
end;

procedure push(var l:T_list; data:T_data);
var adr:^T_elem;
begin
	
end;
