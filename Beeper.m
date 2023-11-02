global key
InitKeyboard();
brick.SetColorMode(1,2);

disp("Ready")
finished = false;
while 1
    pause(0.1);
    if(key ~= 0)    
        switch key
            case "uparrow"
                move(brick,75, 0.3);
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
               brick.MoveMotor('AB', 30);
                pause(0.1)
                brick.StopMotor('AB', "Brake");  
            case "r"
                %Calibrate gyro at start
                brick.GyroCalibrate(3);
                pause(1)
                %Have to call angle at start becasue first angle is NaN
                disp(brick.GyroAngle(3));
                brick.MoveMotor('AB', 40);
                pause(0.1);
                %Set gyroStart for the adjustSpeed algorithm
                gyroStart = brick.GyroAngle(3);
                while(1==1)
                    if(key ~= 0 )
                        if(key == "q")
                            break;
                        end
                    end
                    %move foward
                    brick.MoveMotor('AB', 40);
                    brick.MoveMotor('B', 43.5);
                    %Move the motors with an offset and adjust
                    adjustSpeed(brick,gyroStart);
                    %Record the color ourputted by the brick
                    color = brick.ColorCode(1);
                    if(color == 2)
                        %If its blue, then stop moving and go back to
                        %overall control
                        disp("ITS BLUEE!!!!🟦🟦")
                        brick.StopMotor('AB', "Coast");
                        %brick.playTone(100, 600, 500);
                        pause(0.5)
                        brick.playTone(100, 600, 500);
                        qbreak;
                    end
                    if(color == 4)
                        %If it yellow, then stop moving, go back to control
                        disp("ITS YELLOW ⚠️⚠️⚠️")
                        brick.StopMotor('AB', "Coast");
                        finished = true;
                       % brick.playTone(100, 600, 500);
                       % pause(0.5)
                       % brick.playTone(100, 600, 500);
                       % pause(0.5)
                        %brick.playTone(100, 600, 500);
                       % pause(0.5)
                        %brick.playTone(100, 600, 500);
                        break;
                    end
                    if(color == 5)
                        %If its red, then stop for 2 seconds.
                        disp("ITS RED!!!!🍎🍎🍎")
                        brick.StopMotor('AB', "Coast");
                        pause(2.0);
                        brick.StopMotor('AB', "Brake");
                        %pause(0.7);
                         brick.MoveMotor('AB', 30);
                         brick.MoveMotor('B', 32);
                         pause(0.3)
                    end
                    if(color ==  3 && finished)
                        %If its green and, yellow has been reached, then
                        %stop
                        disp("ITS GREEN!!!!🍏🍏🍏")
                        brick.StopMotor('AB', "Brake");
                        %pause(0.5);
                        %brick.playTone(100, 600, 500);
                        %pause(0.5)
                        %brick.playTone(100, 600, 500);
                        %pause(0.5)
                        %brick.playTone(100, 600, 500);
                        %pause(0.5)
                        break;
                    end
                    disp("Moving Foward!")
                    distance = brick.UltrasonicDist(4);
                    if(distance > 65)
                      gyroStart = brick.GyroAngle(3);
                         tic
                         while(toc < 2)
                            brick.MoveMotor('AB', 40);
                            brick.MoveMotor('B', 43.5);
                            adjustSpeed(brick,gyroStart);
                         end
                        % pause(2)
                         brick.StopMotor('AB', "Brake");
                         turnLeft(brick);  
                         pause(0.5)
                         brick.GyroCalibrate(3);
                        pause(0.5)
                        disp(brick.GyroAngle(3));
                        disp(brick.GyroAngle(3));
                        gyroStart = brick.GyroAngle(3);
                        disp("AGAIN!")
                        pause(1)
                        tic
                        while(toc < 4)
                            brick.MoveMotor('AB', 40);
                            brick.MoveMotor('B', 43.5);
                            adjustSpeed(brick,gyroStart);
                        end
                        %pause(4)
                        brick.StopMotor('AB', "Brake");
                        brick.GyroCalibrate(3);
                        pause(0.5)
                        disp(brick.GyroAngle(3));
                         disp(brick.GyroAngle(3));
                        pause(1)
                        disp("AHHHHHHHHh")
                        gyroStart = brick.GyroAngle(3);
                        disp(gyroStart)
                        gyroStart = brick.GyroAngle(3);
                    end
                    if(brick.TouchPressed(2) == 1)                        
                       brick.StopMotor('AB', "Brake");
                        %ouch! hit a wall
                        disp("I just hit a wall")
                        brick.MoveMotor('AB', -40);
                        brick.MoveMotor('B', -43.5);
                        pause(1.33333)
                        brick.StopMotor('AB', "Brake");
                        distance = brick.UltrasonicDist(4);
                        if(distance < 45)
                            %turn right
                            turnRight(brick);
                            gyroStart = brick.GyroAngle(3);
                        else
                            %turn left
                            turnLeft(brick);
                            gyroStart = brick.GyroAngle(3);
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
        while( newAngle > -80)   
            newAngle = brick.GyroAngle(3);
            disp(newAngle)
            brick.MoveMotor('A', -25);
            brick.MoveMotor('B', 25);
            pause(0.05)
        end
        brick.StopMotor('AB', "Brake");
end
function turnRight(brick)
    brick.GyroCalibrate(3);
        pause(0.5)
        disp(brick.GyroAngle(3));    
        newAngle = brick.GyroAngle(3);
        while( newAngle < 80)   
            newAngle = brick.GyroAngle(3);
            disp(newAngle)
            brick.MoveMotor('A', 25);
            brick.MoveMotor('B', -25);
            pause(0.05)
        end
        brick.StopMotor('AB', "Brake");
end
function plotData(gyroData, ultrasonicData)
    figure;
    subplot(2, 1, 1);
    plot(gyroData, 'r', 'DisplayName', 'Gyro Angle');
    title('Gyro Angle Data');
    legend('show');
    subplot(2, 1, 2);
    plot(ultrasonicData, 'b', 'DisplayName', 'Ultrasonic Distance');
    title('Ultrasonic Distance Data');
    legend('show');
end
function adjustSpeed(brick,gyroStart)
     gyroReading = brick.GyroAngle(3);
     adj = (gyroStart - gyroReading) *-1;
     brick.MoveMotor('B', 43 + adj * 5.5);
     disp(43 + adj);
end
