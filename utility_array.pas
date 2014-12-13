unit utility_array;

interface
  uses crt;
  const
    max_size=10000;
  type 
    array_1=array [1..max_size]of integer;
    
  procedure filling_array(var a:array_1; n,min,max:integer);
  procedure output_array(a:array_1; n:integer);
  procedure input_array(var a:array_1; n:integer);
  procedure check_array(a:array_1; n:integer);
  procedure min_array(var a:array_1; n:integer; var min:integer; var comparison:integer);
  procedure max_array(var a:array_1; n:integer; var max:integer; var comparison:integer);
  procedure swap_elm(var a:array_1; pos_1,pos_2:integer);
    
implementation
  procedure filling_array;
  var i:integer;
  begin
    for i:=1 to n do
    begin
      a[i]:=random(max-min+1)+min;
    end;
  end;
  
  procedure output_array;
  var i:integer;
  begin
    for i:=1 to n do
    begin
      write(a[i],' ');
    end;
    writeln();
  end;
  
  procedure input_array;
  var i:integer;
  begin
    for i:=1 to n do
    begin
      write('Введите ', i, ' элемент: ');
      readln(a[i]);
    end;
  end;
  
  procedure check_array;
  var i:integer;
      check:boolean;
  begin
    check:=true;
    for i:=2 to n do
    begin
      if a[i-1]>a[i] then
      begin
        check:=false;
        continue;
      end;
    end;
    if check=true then 
    begin
      textcolor(2);
      writeln('Массив отсортирован верно.');
    end
    else
    begin
      textcolor(4);
      writeln('Массив отсортирован неверно.');
    end;
    textcolor(7);
  end;
  
  procedure swap_elm;
  var k:integer;
  begin
    k:=a[pos_1];
    a[pos_1]:=a[pos_2];
    a[pos_2]:=k;
  end;
  
  procedure max_array;
  var i:integer;
  begin
    max:=a[1];
    for i:=2 to n do
    begin
      comparison:=comparison+2;
      if a[i]>max then 
        max:=a[i];
    end;
  end;
  
  procedure min_array;
  var i:integer;
  begin
    min:=a[1];
    for i:=2 to n do
    begin
      comparison:=comparison+2;
      if min>a[i] then 
        min:=a[i];
    end;
  end;
end.