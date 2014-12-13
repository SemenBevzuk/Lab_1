program lab_1;
uses CRT;

type 
  array_1: array [1..N]of integer;
procedure filling_array(a:array_1; n,min,max:integer);
var i:integer;
begin
  for i:=1 to n do
  begin
    a[i]:=random(max)+1-min;
  end;
end;
procedure ();

var 

begin

end.