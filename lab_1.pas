program lab_1;
uses CRT,sort_array,search,utility_array;
const
  millisec_in_sec = 1000;

var a:array_1;
    a_sort:array_1;
    i,min_value,max_value,n,key,pos_key,answer:integer;
    sort,permutation,comparison,start,finish:integer;
    time:real;
    s:string;
    table:text;
    flag:boolean;
    

begin
  assign(table,'table.csv');
  rewrite(table);
  writeln(table,'������,','�����,','������������,','���������,','�����');
  repeat
    repeat
      permutation:=0;
      comparison:=0;
      time:=0;
      flag:=true;
      write('������� ������ ���������� �������(1-��������������,2-������): ');
      readln(answer);
      if (answer<>1) and (answer<>2) then 
      begin
        writeln('�������� ����.');
        flag:=false;
      end;
    until(flag);
    
    repeat
      flag:=true;
      write('������� ����� �������: ');
      readln(n);
      if n<0 then 
      begin
        writeln('�������� ����.');
        flag:=false;
      end;
    until(flag);
    
    case answer of 
    1:begin
        write('������� ����������� �����: ');
        readln(min_value);
        write('������� ������������ �����: ');
        readln(max_value);
        if max_value<min_value then 
        begin
          swap(max_value,min_value)
        end;
        filling_array(a,n,min_value,max_value);
      end;
    2:input_array(a,n);
    end;
    output_array(a,n);
    a_sort:=a;
    
    repeat
      writeln('1-�������');
      writeln('2-���������');
      writeln('3-���������');
      writeln('4-��������');
      writeln('5-��������');
      writeln('6-�������');
      repeat
        flag:=true;
        write('�������� ������ ����������: ');
        readln(sort);
        if (sort<1) or (sort>7) then
        begin
          flag:=false;
          writeln('�������� ����.');
        end;
      until(flag);
      
      start:= Milliseconds(); 
      case sort of 
      1:begin
          sort_choice(a_sort,n,permutation,comparison);
          s:='�����';
        end;
      2:begin  
          sort_insert(a_sort,n,permutation,comparison);
          s:='���������';
        end;
      3:begin
          sort_bubble(a_sort,n,permutation,comparison);
          s:='���������';
        end;
      4:begin
          sort_count(a_sort,n,permutation,comparison);
          s:='���������';
        end;
      5:begin
          sort_merge(a_sort,1,n,permutation,comparison);
          s:='��������';
        end;
      6:begin
          sort_quick(1,n,a_sort,permutation,comparison);
          s:='�������';
        end;
      end;
      finish:= Milliseconds(); 
      time:=(finish-start)/millisec_in_sec;

      writeln(table,s,',',n,',',permutation,',',comparison,',',time);
      
      output_array(a_sort,n);
      check_array(a_sort,n);
      repeat
        flag:=true;
        write('�������� ����� � �������? (0-���,1-��)');
        readln(answer);
        if (answer<>0) and (answer<>1) then
        begin
          flag:=false;
          writeln('�������� ����.');
        end;
      until(flag);
      if answer=1 then 
        begin
        repeat
          repeat
            flag:=true;
            write('������ � �������� ��� � ��������������� �������? (0-��������,1-���������������) ');
            readln(answer);
            if (answer<>0) and (answer<>1) then
            begin
              flag:=false;
              writeln('�������� ����.');
            end;
          until(flag);
            write('������� ������� ��� ������: ');
            readln(key);
          case answer of
          0:linear_search(a,n,key,pos_key);
          1:binary_search(a_sort,n,key,pos_key);
          end;
          if (pos_key=0) or (pos_key>n) then 
            writeln('������ ����� ���.')
          else
            writeln('������� ����� ', key, ' � �������: ', pos_key,'.');
          repeat
            flag:=true;
            write('���������� �����? (0-���,1-��) ');
            readln(answer);
            if (answer<>0) and (answer<>1) then
            begin
              flag:=false;
              writeln('�������� ����.');
            end;
          until(flag);
        until(answer=0);
      end;
      
      repeat
        flag:=true;
        write('������������� ������ ������ ��������? (0-���,1-��) ');
        readln(answer);
        if (answer<>0) and (answer<>1) then
        begin
          flag:=false;
          writeln('�������� ����.');
        end;
      until(flag);
    until(answer=0);
    repeat
      flag:=true;
      write('������ ������ � ������ ��������? (0-���,1-��) ');
      readln(answer);
      if (answer<>0) and (answer<>1) then
      begin
        flag:=false;
        writeln('�������� ����.');
      end;
    until(flag);
  until(answer=0);
  close(table);
  writeln('������ ��������� � ����.');
  
end.