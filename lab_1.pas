program lab_1;
//uses CRT;
const
  max_size=10000;
type 
  array_1=array [1..max_size]of integer;
  
procedure filling_array(var a:array_1; n,min,max:integer);
var i:integer;
begin
  for i:=1 to n do
  begin
    a[i]:=random(max-min+1)+min;
  end;
end;

procedure output_array(a:array_1; n:integer);
var i:integer;
begin
  for i:=1 to n do
  begin
    write(a[i],' ');
  end;
  writeln();
end;
procedure input_array(var a:array_1; n:integer);
var i:integer;
begin
  for i:=1 to n do
  begin
    write('Ââåäèòå ', i, ' ıëåìåíò: ');
    readln(a[i]);
  end;
end;

procedure linear_search(a:array_1; n:integer; elm:integer; var pos:integer); //ÏÎÈÑÊ
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

procedure binary_search(a:array_1; n:integer; elm:integer; var pos:integer);
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

procedure swap_elm(var a:array_1; pos_1,pos_2:integer);
var k:integer;
begin
  k:=a[pos_1];
  a[pos_1]:=a[pos_2];
  a[pos_2]:=k;
end;

procedure max_array(var a:array_1; n:integer; var max:integer);
var i:integer;
begin
  max:=a[1];
  for i:=2 to n do
  begin
    if a[i]>max then 
      max:=a[i];
  end;
end;

procedure min_array(var a:array_1; n:integer; var min:integer);
var i:integer;
begin
  min:=a[1];
  for i:=2 to n do
  begin
    if min>a[i] then 
      min:=a[i];
  end;
end;

procedure find_min_array(var a:array_1; start, n:integer; var pos_min:integer);
var i,min:integer;
begin
  min:=a[start];
  pos_min:=start;
  for i:=start to n do
  begin
    if min>a[i] then
    begin
      min:=a[i];
      pos_min:=i;
    end;
  end;
end;
{/////////////////////////////////////////////ÑÎĞÒÈĞÎÂÊÈ///////////////////////}
procedure sort_choice(var a:array_1; n:integer);
var i,j,min,pos_min:integer;
begin
  for i:=1 to n-1 do
    for j:=i to n do
    begin
      find_min_array(a,j,n,pos_min);
      swap_elm(a,pos_min,j);
    end;
end;

procedure sort_insert(var a:array_1; n:integer);
var i,elm,pos,p:integer;
begin
  for i:=2 to n do
  begin
    elm:=a[i];
    p:=i-1;
    while (p>0) do
    begin
      if a[p]>elm then 
      begin
        a[p+1]:=a[p];
        p:=p-1;
      end
      else
        break;
    end;
    a[p+1]:=elm;
  end;
end;

procedure sort_bubble(var a:array_1; n:integer);
var i,j:integer;
sw:boolean;
begin
  for i:=1 to n-1 do
  begin
    sw:=true;
    for j:=1 to n-i do
    begin
      if a[j]>a[j+1] then 
      begin
        swap_elm(a,j,j+1);
        sw:=false;
      end;
    end;
    if sw then 
      break;
  end;
end;

procedure sort_count(var a:array_1; n:integer);
var i,j,p,min,max:integer;
m:array_1;
begin
  max_array(a,n,max);
  min_array(a,n,min);
  for i:=1 to n do
    inc(m[a[i]-min+1]);
  p:=1;
  for i:=1 to max-min+1 do
  begin
    for j:=1 to m[i] do
    begin
      a[p]:=i+min-1;
      p:=p+1;
    end;
  end;
end;

procedure merge_array(var a:array_1; low,mid,high:integer);
var i,j,p:integer;
a_1:array_1;
begin
  i:=low;
  j:=mid+1;
  p:=low;
  while (i<=mid) or (j<=high) do
  begin
    if i>mid then
    begin
      a_1[p]:=a[j];
      j:=j+1;
      p:=p+1;
      continue;
    end;
    if j>high then
    begin
      a_1[p]:=a[i];
      i:=i+1;
      p:=p+1;
      continue;
    end;
    if a[i]<a[j] then
    begin
      a_1[p]:=a[i];
      i:=i+1;
    end
    else
    begin
      a_1[p]:=a[j];
      j:=j+1;
    end;
    p:=p+1;    
  end;
  
  for i:=low to high do
  begin
    a[i]:=a_1[i];
  end;
end;

procedure sort_merge(var a:array_1; low,high:integer);
var mid:integer;
begin
  mid:=(low+high) div 2;
  if low<high then 
  begin
    sort_merge(a,low,mid);
    sort_merge(a,mid+1,high); 
    merge_array(a,low,mid,high);
  end;
end;

procedure sort_quick(low,high:integer; var a:array_1);
var mid_elm,i,j,k:integer;
begin
  mid_elm:=a[(low+high) div 2];
  i:=low;
  j:=high;
  while (i<=j) do
  begin
    while (a[i]<mid_elm) do
      i:=i+1;
    while (a[j]>mid_elm) do
      j:=j-1;
    if i<=j then
    begin
      swap_elm(a,i,j);
      i:=i+1;
      j:=j-1;
    end;
  end;
  if low<j then 
    sort_quick(low,j,a);
  if i<high then 
    sort_quick(i,high,a);
end;

var a:array_1;
    a_sort:array_1;
i,j,min_value,max_value,n,key,pos_key:integer;

begin
  n:=10;
  min_value:=-10;
  max_value:=10;
  for i:=10 downto 1 do
    a[i]:=10-i;
  //filling_array(a,n,min_value,max_value);
  a_sort:=a;
  output_array(a,n);
  writeln();
  //sort_choice(a_sort,n);
  //sort_insert(a_sort,n);
  //sort_bubble(a_sort,n);
  //sort_count(a_sort,n);
  //sort_merge(a_sort,1,n);
  //sort_quick(1,n,a_sort);
  output_array(a_sort,n);
end.