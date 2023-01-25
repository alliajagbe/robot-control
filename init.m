function [myserialdevice, cam] = init()
clear all; clc;
pi_obj = raspi('raspberrypi-t263BtM4ig','pi','raspberry')
myserialdevice = serialdev(pi_obj,'/dev/ttyACM0',9600)
cam = webcam(pi_obj)
end
