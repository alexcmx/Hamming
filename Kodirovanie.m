function Coded_msg = Kodirovanie(recv_msg)
j=4;
recv_msg = recv_msg';% инвертируем столбец в строку. Так удобнее кодировать
Coded_msg = [];
while j<=length(recv_msg)
dat = recv_msg(j-3:j);% Для данных размер которых превышает 57 мы делим их на блоки по 57 символов и кодируем их по частям
j=j+4;
% добавляем проверочные биты в исходное сообщение и получаем закодированное
% сообщение с нерасчитанными проверочными битами
NewData = [0 0 dat(1) 0 dat(2:4)];
% вычисляем проверочные биты 1,2,4,8,16 и 32
NewData(1) = mod(sum(NewData(3:2:end)),2);
NewData(2) = mod(sum([NewData(6:4:end) NewData(3:4:end)]),2);
NewData(4) = mod(sum(NewData(5:7)),2);
Coded_msg = [Coded_msg NewData];% объединяем блоки по 63 элементов в один
end
Coded_msg = Coded_msg'; %инвертируем обратно строку в столбец
end