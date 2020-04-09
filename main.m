clear all;
imaqreset;

% Ev3 stuff
myev3 = legoev3;
dir_motor = motor(myev3,'C');
esq_motor = motor(myev3,'B');

dir_motor.start();
esq_motor.start();

% Video Stuff
vid = videoinput('winvideo', 2, 'YUY2_640x480');
%vid = videoinput('macvideo', 1);
vid.FramesPerTrigger = 1;
vid.ReturnedColorspace = 'rgb';
vid.TriggerRepeat = inf;

triggerconfig(vid, 'Manual');
start(vid);



while(1)
    % Captura imagens 1 e 2 para ver a direção que a bola ta indo    
    [bw,data] = tratarImagem(vid,'red');
    
    stats = regionprops(bw, 'BoundingBox', 'Centroid');
        
    if length(stats) > 0

        bc = stats(1).Centroid;
        
        coord_x = bc(1);       
        coord_x = 320 - coord_x;

        if coord_x < -40
            clearLCD(myev3);
            writeLCD(myev3,'<-');
            dir_motor.Speed = -20;
            esq_motor.Speed = 20;
            dir_motor.start();
            esq_motor.start();
        else
            if coord_x > 40
                clearLCD(myev3);
                writeLCD(myev3, '->');
                dir_motor.Speed = 20;
                esq_motor.Speed = -20;
                dir_motor.start();
                esq_motor.start();
            else
                clearLCD(myev3);
                writeLCD(myev3, 'STOP');
                dir_motor.stop();
                esq_motor.stop();
            end;
        end;
    else
        dir_motor.stop();
        esq_motor.stop();
    end;    
    imshow(bw);
end
