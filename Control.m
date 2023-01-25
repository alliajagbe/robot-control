pi_obj = raspi('raspberrypi-Xua49uWurx','pi','raspberry');
myserialdevice = serialdev(pi_obj,'/dev/ttyACM0',9600);
cam = webcam(pi_obj);

%%
belief = ones(1,25)/25;
while true
waitforbuttonpress;
% 28 leftarrow
% 29 rightar row
% 30 uparrow
% 31 downarrow
% 32 space: stop
value = double(get(gcf,'CurrentCharacter'));

if value == 30
    %action = 'F';
    %action = input('F/B/L/R: ','s')
    write(myserialdevice,'F')
elseif value == 31
    %action = 'B';
    %action = input('F/B/L/R: ','s')
    write(myserialdevice,'B')
elseif value == 28
    %action = 'L';
    %action = input('F/B/L/R: ','s')
    write(myserialdevice,'L')
elseif value == 29
    %action = 'R';
    %action = input('F/B/L/R: ','s')
    write(myserialdevice,'R')
elseif value == 32
    write(myserialdevice,'S')
belief = imassignment(cam, belief)
%heatmap(belief)
end
end

%%
heatmap(belief)
