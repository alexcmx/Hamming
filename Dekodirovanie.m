function decoded_message = Dekodirovanie(recieved_info)
j=63;
recieved_info = recieved_info';% ����������� ������� � ������. ��� ������� ������������
decoded_message = [];
while j<=length(recieved_info)
part_of_info = recieved_info(j-62:j);% ��� ������ ������ ������� ��������� 63 �� ����� �� �� ����� �� 63 �������� � �������� �� �� ������
j=j+63;
array_of_CHKbits = [0];
%��������� ����������� ����
bit1 = mod(sum(part_of_info(3:2:end)),2);
bit2 = mod(sum([part_of_info(6:4:end) part_of_info(3:4:end)]),2);
bit4 = mod(sum([part_of_info(12:8:end) part_of_info(5:8:end) part_of_info(6:8:end) part_of_info(7:8:end)]),2);
bit8 = mod(sum([part_of_info(9:15) part_of_info(24:21) part_of_info(40:47) part_of_info(56:end)]),2);
bit16 = mod(sum([part_of_info(17:31) part_of_info(48:end)]),2);
bit32 = mod(sum(part_of_info(32:end)),2);
%���������� ����������� ���� � ������ ������� ������ � ������� � ���������
%�� ������ � ������ array_of_CHKbits
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
%���� ����������� ���� ����������� �� ��������� � ���� ��� �� �����
%�������� �� ���������� �� �������, ����� ����� ��� � ������� � �����������
%���
if array_of_CHKbits~=[0]
part_of_info(sum(array_of_CHKbits)) = mod(part_of_info(sum(array_of_CHKbits))+1,2);
end
%������� ����������� ���� �������������� ������������ �������� ���������
part_of_result = [part_of_info(3) part_of_info(5:7) part_of_info(9:15) part_of_info(17:31) part_of_info(33:end)];
%���������� ����������� ����� �� � ����
decoded_message = [decoded_message part_of_result];
end
%����������� ������� ������ � �������
decoded_message = decoded_message';
end