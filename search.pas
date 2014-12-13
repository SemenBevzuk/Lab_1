unit search;

interface
  uses utility_array;
  
  procedure linear_search(a:array_1; n:integer; elm:integer; var pos:integer);
  procedure binary_search(a:array_1; n:integer; elm:integer; var pos:integer);
  
implementation
  
  procedure linear_search;
  var flag:boolean;
  i:integer;
  begin
    i:=0;
    pos:=0;
    repeat 
      i:=i+1;
      if a[i]=elm then 
      begin
        pos:=i;
        flag:=true;
      end;
    until(flag=true);
  end;
  
  procedure binary_search;
  var l,r:integer;
  begin
    l:=1;
    r:=n;
    while (l<=r) do
    begin
      pos:=(l+r) div 2;
      if a[pos]<elm then 
        l:=pos+1
      else
      begin
        if a[pos]>elm then 
          r:=pos-1
        else
          break;
      end;
    end;
    if (l>r) then 
      pos:=0;
  end;
end.