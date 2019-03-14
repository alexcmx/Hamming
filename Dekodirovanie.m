function decoded_message = Dekodirovanie(recieved_info)
j=63;
recieved_info = recieved_info';% инвертируем столбец в строку. “ак удобнее декодировать
decoded_message = [];
while j<=length(recieved_info)
part_of_info = recieved_info(j-62:j);% ƒл€ данных размер которых превышает 63 мы делим их на блоки по 63 символов и кодируем их по част€м
j=j+63;
array_of_CHKbits = [0];
%вычисл€ем проверочные биты
bit1 = mod(sum(part_of_info(3:2:end)),2);
bit2 = mod(sum([part_of_info(6:4:end) part_of_info(3:4:end)]),2);
bit4 = mod(sum([part_of_info(12:8:end) part_of_info(5:8:end) part_of_info(6:8:end) part_of_info(7:8:end)]),2);
bit8 = mod(sum([part_of_info(9:15) part_of_info(24:21) part_of_info(40:47) part_of_info(56:end)]),2);
bit16 = mod(sum([part_of_info(17:31) part_of_info(48:end)]),2);
bit32 = mod(sum(part_of_info(32:end)),2);
%сравниваем проверочные биты с битами которые пришли в декодер и добавл€ем
%их индекс в массив array_of_CHKbits
if bit1~=part_of_info(1)
    array_of_CHKbits(1)=1;
end
if bit2~=part_of_info(2)
    array_of_CHKbits(2)=2;
end
if bit4~=part_of_info(4)
    array_of_CHKbits(4)=4;
end
if bit8~=part_of_info(8)
    array_of_CHKbits(8)=8;
end
if bit16~=part_of_info(16)
    array_of_CHKbits(16)=16;
end
if bit32~=part_of_info(32)
    array_of_CHKbits(32)=32;
end
%если проверочные биты расчитанные не совпадают с теми что на входе
%декодера то складываем их позиции, чтобы найти бит с ошибкой и инвертируем
%его
if array_of_CHKbits~=[0]
part_of_info(sum(array_of_CHKbits)) = mod(part_of_info(sum(array_of_CHKbits))+1,2);
end
%убираем проверочные биты восстанавлива€ исправленное исходное сообщение
part_of_result = [part_of_info(3) part_of_info(5:7) part_of_info(9:15) part_of_info(17:31) part_of_info(33:end)];
%объедин€ем разделенные блоки по в один
decoded_message = [decoded_message part_of_result];
end
%инвертируем обратно строку в столбец
decoded_message = decoded_message';
end