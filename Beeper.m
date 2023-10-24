global key
InitKeyboard();
brick.SetColorMode(1,2);
brick.GyroCalibrate(3);
pause(1)
disp(brick.GyroAngle(3));

disp("Ready")
while 1
    pause(0.1);
    if(key ~= 0)    
        switch key
            case "uparrow"
                brick.MoveMotor('AB', 40);
                brick.MoveMotor('B', 43.4);
                pause(6.0)
                brick.StopMotor('AB', "Brake");
            case "downarrow"
                move(brick,-75, 0.3);
            case "leftarrow"
                turnLeft(brick);
            case "rightarrow"
                turnRight(brick);
             case "comma"
                brick.MoveMotor('A', -30);
                brick.MoveMotor('B', 30);
                pause(0.1)
                brick.StopMotor('AB', "Brake");
            case "period"
                brick.MoveMotor('A', 30);
                brick.MoveMotor('B', -30);
                pause(0.1)
                brick.StopMotor('AB', "Brake");
              case "m"
                brick.MoveMotor('AB', -30);
                pause(0.1)
                brick.StopMotor('AB', "Brake");
             case "u"
                brick.MoveMotor('C', -30);
                pause(0.1)
                brick.StopMotor('C', "Brake");
             case "d"
                brick.MoveMotor('C', 30);
                pause(0.1)
                brick.StopMotor('C', "Brake");
             case "n" 
               t = brick.TouchPressed(2);
               disp("Button state is: " + t)   

               distance = brick.UltrasonicDist(4);
               disp("Distance is: " +distance)

               color = brick.ColorCode(1);
               disp("The color is: " + color)

               gyro = brick.GyroAngle(3);
               disp("Current angle is: " +gyro)  
            case "r"
                brick.MoveMotor('AB', 40);
                pause(0.1);
                while(1==1)
                    if(key ~= 0 )
                        if(key == "q")
                            break;
                        end
                    end
                    %move foward
                    brick.MoveMotor('AB', 40);
                    brick.MoveMotor('B', 43.5);
                    color = brick.ColorCode(1);
                    if(color == 2)
                        pause(0.3);
                        disp("ITS BLUEE!!!!🟦🟦")
                      
                    end
                    if(color == 5)
                        disp("ITS RED!!!!🍎🍎🍎")
                        brick.MoveMotor('C', 30);
                        pause(0.3)
                        brick.StopMotor('C', "Brake");
                        pause(0.5)
                        brick.MoveMotor('C', -30);
                        pause(0.3)
                        brick.StopMotor('C', "Brake");
                    end
                    disp("Moving Foward!")
                    disp(brick.TouchPressed(2))
                    distance = brick.UltrasonicDist(4);
                    if(distance > 65)
                         brick.MoveMotor('AB', 40);
                         brick.MoveMotor('B', 43.5);
                        pause(2.5)
                         brick.StopMotor('AB', "Brake");
                         turnRight(brick);
                        brick.MoveMotor('AB', 40);
                        brick.MoveMotor('B', 43.5);
                        pause(4)
                        brick.StopMotor('AB', "Brake");
                    end
                        
                    if(brick.TouchPressed(2) == 1)
                       brick.StopMotor('AB', "Brake");
                        %ouch! hit a wall
                        disp("I just hit a wall")
                        disp("Thinking...")
                        brick.MoveMotor('AB', -40);
                        brick.MoveMotor('B', -43.5);
                        pause(2.0)
                        brick.StopMotor('AB', "Brake");
                        distance = brick.UltrasonicDist(4);
                        if(distance > 45)
                            %turn right
                            turnRight(brick);
                        else
                            %turn left
                            turnLeft(brick);
                        end
                    end
                    pause(0.1)
                end
            case 0
                disp("No key Pressed")
            case "q"
                break;
        end
    end
end
CloseKeyboard();
function move(brick,maxSpeed, duration)
    for i =0.75:0.05:1.0
        brick.MoveMotor('AB', maxSpeed * (i));
        pause(duration/5);
    end    
    brick.StopMotor('AB', "Coast");
end
function turnLeft(brick)
    brick.GyroCalibrate(3);
        pause(0.5)
        disp(brick.GyroAngle(3));    
        newAngle = brick.GyroAngle(3);
        while( newAngle > -85)   
            newAngle = brick.GyroAngle(3);
            disp(newAngle)
            brick.MoveMotor('A', -40);
            brick.MoveMotor('B', 40);
            pause(0.01)
        end
        brick.StopMotor('AB', "Brake");
end
function turnRight(brick)
    brick.GyroCalibrate(3);
        pause(0.5)
        disp(brick.GyroAngle(3));    
        newAngle = brick.GyroAngle(3);
        while( newAngle < 85)   
            newAngle = brick.GyroAngle(3);
            disp(newAngle)
            brick.MoveMotor('A', 40);
            brick.MoveMotor('B', -40);
            pause(0.01)
        end
        brick.StopMotor('AB', "Brake");
end
%display("Running... NOWWWW");
%brick.playTone(25,500,0.3)
%brick.MoveMotor('AB', -50);
%brick.MoveMotor('AB', -50);

%pause(2)
%brick.StopMotor('AB');

%display('Done!')
