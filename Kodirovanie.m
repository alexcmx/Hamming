function Coded_msg = Kodirovanie(recv_msg)
j=4;
recv_msg = recv_msg';% ����������� ������� � ������. ��� ������� ����������
Coded_msg = [];
while j<=length(recv_msg)
dat = recv_msg(j-3:j);% ��� ������ ������ ������� ��������� 57 �� ����� �� �� ����� �� 57 �������� � �������� �� �� ������
j=j+4;
% ��������� ����������� ���� � �������� ��������� � �������� ��������������
% ��������� � �������������� ������������ ������
NewData = [0 0 dat(1) 0 dat(2:4)];
% ��������� ����������� ���� 1,2,4,8,16 � 32
NewData(1) = mod(sum(NewData(3:2:end)),2);
NewData(2) = mod(sum([NewData(6:4:end) NewData(3:4:end)]),2);
NewData(4) = mod(sum(NewData(5:7)),2);
Coded_msg = [Coded_msg NewData];% ���������� ����� �� 63 ��������� � ����
end
Coded_msg = Coded_msg'; %����������� ������� ������ � �������
end