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
  writeln(table,'Способ,','Длина,','Перестановки,','Сравнения,','Время');
  repeat
    repeat
      permutation:=0;
      comparison:=0;
      time:=0;
      flag:=true;
      write('Введите способ заполнения массива(1-автоматический,2-ручной): ');
      readln(answer);
      if (answer<>1) and (answer<>2) then 
      begin
        writeln('Неверный ввод.');
        flag:=false;
      end;
    until(flag);
    
    repeat
      flag:=true;
      write('Введите длину массива: ');
      readln(n);
      if n<0 then 
      begin
        writeln('Неверный ввод.');
        flag:=false;
      end;
    until(flag);
    
    case answer of 
    1:begin
        write('Введите минимальное число: ');
        readln(min_value);
        write('Введите максимальное число: ');
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
      writeln('1-Выбором');
      writeln('2-Вставками');
      writeln('3-Пузырьком');
      writeln('4-Подчётом');
      writeln('5-Слиянием');
      writeln('6-Быстрая');
      repeat
        flag:=true;
        write('Выберите способ сортировки: ');
        readln(sort);
        if (sort<1) or (sort>7) then
        begin
          flag:=false;
          writeln('Неверный ввод.');
        end;
      until(flag);
      
      start:= Milliseconds(); 
      case sort of 
      1:begin
          sort_choice(a_sort,n,permutation,comparison);
          s:='Выбор';
        end;
      2:begin  
          sort_insert(a_sort,n,permutation,comparison);
          s:='Вставками';
        end;
      3:begin
          sort_bubble(a_sort,n,permutation,comparison);
          s:='Пузырьком';
        end;
      4:begin
          sort_count(a_sort,n,permutation,comparison);
          s:='Подсчётом';
        end;
      5:begin
          sort_merge(a_sort,1,n,permutation,comparison);
          s:='Слиянием';
        end;
      6:begin
          sort_quick(1,n,a_sort,permutation,comparison);
          s:='Быстрая';
        end;
      end;
      finish:= Milliseconds(); 
      time:=(finish-start)/millisec_in_sec;

      writeln(table,s,',',n,',',permutation,',',comparison,',',time);
      
      output_array(a_sort,n);
      check_array(a_sort,n);
      repeat
        flag:=true;
        write('Провести поиск в массиве? (0-нет,1-да)');
        readln(answer);
        if (answer<>0) and (answer<>1) then
        begin
          flag:=false;
          writeln('Неверный ввод.');
        end;
      until(flag);
      if answer=1 then 
        begin
        repeat
          repeat
            flag:=true;
            write('Искать в исходном или в отсортированном массиве? (0-исходный,1-отсортированный) ');
            readln(answer);
            if (answer<>0) and (answer<>1) then
            begin
              flag:=false;
              writeln('Неверный ввод.');
            end;
          until(flag);
            write('Введите элемент для поиска: ');
            readln(key);
          case answer of
          0:linear_search(a,n,key,pos_key);
          1:binary_search(a_sort,n,key,pos_key);
          end;
          if (pos_key=0) or (pos_key>n) then 
            writeln('Такого числа нет.')
          else
            writeln('Позиция числа ', key, ' в массиве: ', pos_key,'.');
          repeat
            flag:=true;
            write('Продолжить поиск? (0-нет,1-да) ');
            readln(answer);
            if (answer<>0) and (answer<>1) then
            begin
              flag:=false;
              writeln('Неверный ввод.');
            end;
          until(flag);
        until(answer=0);
      end;
      
      repeat
        flag:=true;
        write('Отсортировать массив другим способом? (0-нет,1-да) ');
        readln(answer);
        if (answer<>0) and (answer<>1) then
        begin
          flag:=false;
          writeln('Неверный ввод.');
        end;
      until(flag);
    until(answer=0);
    repeat
      flag:=true;
      write('Начать работу с другим массивом? (0-нет,1-да) ');
      readln(answer);
      if (answer<>0) and (answer<>1) then
      begin
        flag:=false;
        writeln('Неверный ввод.');
      end;
    until(flag);
  until(answer=0);
  close(table);
  writeln('Данные сохранены в файл.');
  
end.