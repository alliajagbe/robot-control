function [colour] = ColourDetection(cam)

image = snapshot(cam);
image = snapshot(cam);
image = snapshot(cam);
image = snapshot(cam);
image = snapshot(cam);

%imshow(image)
R = image(:,:,1);
G = image(:,:,2);
B = image(:,:,3);

count = 0;
[l,w,~] = size(image);
for j=1:l
        for k=1:w
               count= count+1;
        end
end

r_sum=sum(R,"all");
g_sum=sum(G,"all");
b_sum=sum(B,"all");

r = r_sum/count;
g = g_sum/count;
b = b_sum/count;


if(r > b) && (r > g)
    colour = 2
    disp("Red")
elseif(r > 0 && r < 145) && (b > 0 && b < 145) && (g > 0 && g < 145)
    colour = 3
    disp("Black")
else
    colour = 1
    disp("Blue")
end