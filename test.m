testing = randi([0 1], 57*8,1);

coded = Kodirovanie(testing);
result = Dekodirovanie(coded);
CHK = 0;
for i=1:length(testing)
   if testing(i)~=result(i)
       CHK = CHK+1;
   end
end

CHK = CHK/length(testing);
fprintf("Errors = %d\n", CHK);