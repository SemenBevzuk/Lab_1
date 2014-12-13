unit sort_array;

interface
  uses utility_array;

  procedure sort_choice(var a:array_1; n:integer; var permutation:integer; var comparison:integer);
  procedure sort_insert(var a:array_1; n:integer; var permutation:integer; var comparison:integer);
  procedure sort_bubble(var a:array_1; n:integer; var permutation:integer; var comparison:integer);
  procedure sort_count(var a:array_1; n:integer; var permutation:integer; var comparison:integer);
  procedure sort_merge(var a:array_1; low,high:integer; var permutation:integer; var comparison:integer);
  procedure sort_quick(low,high:integer; var a:array_1; var permutation:integer; var comparison:integer);
  
implementation
  
  procedure find_min_array(var a:array_1; start, n:integer; var pos_min:integer; var comparison:integer);
  var i,min:integer;
  begin
    min:=a[start];
    pos_min:=start;
    for i:=start to n do
    begin
      comparison:=comparison+2;
      if min>a[i] then
      begin
        min:=a[i];
        pos_min:=i;
      end;
    end;
  end;
  //сортировки//
  procedure sort_choice;
  var i,j,pos_min:integer;
  begin
    for i:=1 to n-1 do
    begin
      comparison:=comparison+1;
      for j:=i to n do
      begin
        comparison:=comparison+1;
        find_min_array(a,j,n,pos_min,comparison);
        swap_elm(a,pos_min,j);
        permutation:=permutation+1;
      end;
    end;
  end;
  
  procedure sort_insert;
  var i,elm,p:integer;
  begin
    for i:=2 to n do
    begin
      comparison:=comparison+1;
      elm:=a[i];
      p:=i-1;
      while (p>0) do
      begin
        comparison:=comparison+2;
        if a[p]>elm then 
        begin
          a[p+1]:=a[p];
          permutation:=permutation+1;
          p:=p-1;
        end
        else
          break;
      end;
      a[p+1]:=elm;
      permutation:=permutation+1;
    end;
  end;
  
  procedure sort_bubble;
  var i,j:integer;
  sw:boolean;
  begin
    for i:=1 to n-1 do
    begin
      sw:=true;
      comparison:=comparison+1;
      for j:=1 to n-i do
      begin
        comparison:=+2;
        if a[j]>a[j+1] then 
        begin
          swap_elm(a,j,j+1);
          permutation:=permutation+1;
          sw:=false;
        end;
      end;
      comparison:=comparison+1;
      if sw then 
        break;
    end;
  end;
  
  procedure sort_count;
  var i,j,p,min,max:integer;
  m:array_1;
  begin
    max_array(a,n,max,comparison);
    min_array(a,n,min,comparison);
    for i:=1 to n do
    begin
      inc(m[a[i]-min+1]);
      permutation:=permutation+1;
      comparison:=comparison+1;
    end;
    p:=1;
    for i:=1 to max-min+1 do
    begin
      comparison:=comparison+1;
      for j:=1 to m[i] do
      begin
        comparison:=comparison+1;
        a[p]:=i+min-1;
        permutation:=permutation+1;
        p:=p+1;
      end;
    end;
  end;
  
  procedure merge_array(var a:array_1; low,mid,high:integer; var permutation:integer; var comparison:integer);
  var i,j,p:integer;
  a_1:array_1;
  begin
    i:=low;
    j:=mid+1;
    p:=low;
    while (i<=mid) or (j<=high) do
    begin
      comparison:=comparison+1;
      if i>mid then
      begin
        comparison:=comparison+1;
        a_1[p]:=a[j];
        permutation:=permutation+1;
        j:=j+1;
        p:=p+1;
        continue;
      end;
      if j>high then
      begin
        comparison:=comparison+1;
        a_1[p]:=a[i];
        permutation:=permutation+1;
        i:=i+1;
        p:=p+1;
        continue;
      end;
      if a[i]<a[j] then
      begin
        comparison:=comparison+1;
        a_1[p]:=a[i];
        permutation:=permutation+1;
        i:=i+1;
      end
      else
      begin
        a_1[p]:=a[j];
        permutation:=permutation+1;
        j:=j+1;
      end;
      p:=p+1;    
    end;
    
    for i:=low to high do
    begin
      comparison:=comparison+1;
      a[i]:=a_1[i];
      permutation:=permutation+1;
    end;
  end;
  
  procedure sort_merge;
  var mid:integer;
  begin
    mid:=(low+high) div 2;
    if low<high then 
    begin
      comparison:=comparison+1;
      sort_merge(a,low,mid,permutation,comparison);
      sort_merge(a,mid+1,high,permutation,comparison); 
      merge_array(a,low,mid,high,permutation,comparison);
    end;
  end;
  
  procedure sort_quick;
  var mid_elm,i,j:integer;
  begin
    mid_elm:=a[(low+high) div 2];
    i:=low;
    j:=high;
    while (i<=j) do
    begin
      comparison:=comparison+1;
      while (a[i]<mid_elm) do
      begin
        i:=i+1;
        comparison:=comparison+1;
      end;
      while (a[j]>mid_elm) do
      begin
        j:=j-1;
        comparison:=comparison+1;
      end;
      if i<=j then
      begin
        comparison:=comparison+1;
        swap_elm(a,i,j);
        permutation:=permutation+1;
        i:=i+1;
        j:=j-1;
      end;
    end;
    comparison:=comparison+1;
    if low<j then 
      sort_quick(low,j,a,permutation,comparison);
    comparison:=comparison+1;
    if i<high then 
      sort_quick(i,high,a,permutation,comparison);
  end;
end.