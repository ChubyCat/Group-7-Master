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
                driveStraight(brick);
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
               t = brick.TouchPressed("D");
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
                gyroStart = brick.GyroAngle(3);
                finished = false;
                while(1==1)
                    if(key ~= 0 )
                        if(key == "q")
                            break;
                        end
                    end
                    %move foward
                    brick.MoveMotor('AB', 40);
                    brick.MoveMotor('B', 43.5);
                    adjustSpeed(brick,gyroStart);
                    color = brick.ColorCode(1);
                    if(color == 2)
                        pause(0.3);
                        disp("ITS BLUEE!!!!🟦🟦")
                        brick.StopMotor('AB', "Coast");
                        CloseKeyboard();
                        enterManualMode(brick);
                    end
                    if(color == 4)
                        pause(0.3);
                        disp("ITS YELLOW ⚠️⚠️⚠️")
                        enterManualMode(brick,key);
                        finished = true;
                    end
                    if(color == 5)
                        disp("ITS RED!!!!🍎🍎🍎")
                        brick.StopMotor('AB', "Coast");
                        pause(1.5);
                        brick.StopMotor('AB', "Brake");
                        pause(0.5);
                    end
                    if(color ==  3 && finished)
                        disp("ITS GREEN!!!!🍏🍏🍏")
                        brick.StopMotor('AB', "Brake");
                        pause(0.5);
                        brick.playTone(100, 800, 500);
                        break;
                    end
                    disp("Moving Foward!")
                    disp(brick.TouchPressed(2))
                    distance = brick.UltrasonicDist(4);
                    if(distance > 65)
                        brick.GyroCalibrate(3);
                        disp("AHHHHHHHHHHHHH")
                        pause(1)
                        disp(brick.GyroAngle(3));
                         brick.MoveMotor('AB', 40);
                         brick.MoveMotor('B', 43.5);
                        pause(2)
                         brick.StopMotor('AB', "Brake");
                         turnRight(brick);
                        brick.MoveMotor('AB', 40);
                        brick.MoveMotor('B', 43.5);
                        pause(4)
                        brick.StopMotor('AB', "Brake");
                        gyroStart = brick.GyroAngle(3);
                    end
                    if(brick.TouchPressed(2) == 1)                        
                       brick.StopMotor('AB', "Brake");
                        %ouch! hit a wall
                        disp("I just hit a wall")
                        disp("Thinking...")
                        brick.MoveMotor('AB', -40);
                        brick.MoveMotor('B', -43.5);
                        pause(1.33333)
                        brick.StopMotor('AB', "Brake");
                        distance = brick.UltrasonicDist(4);
                        if(distance > 45)
                            %turn right
                            turnRight(brick);
                            
                            brick.GyroCalibrate(3);
                            pause(1)
                            disp(brick.GyroAngle(3));
                            gyroStart = brick.GyroAngle(3);
                        else
                            %turn left
                            turnLeft(brick);
                            brick.GyroCalibrate(3);
                            pause(1)
                            disp(brick.GyroAngle(3));
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
        while( newAngle > -75)   
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
        while( newAngle < 75)   
            newAngle = brick.GyroAngle(3);
            disp(newAngle)
            brick.MoveMotor('A', 40);
            brick.MoveMotor('B', -40);
            pause(0.01)
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
function driveStraight(brick)
    gyroData = [];
    ultrasonicData = [];
    duration = 12; % seconds

    % Create a figure and axes for plotting
    
  
    gyroStart = brick.GyroAngle(3);
    distanceStart = brick.UltrasonicDist(4);
    % Record sensor data for 5 seconds
    tic;  % Start timer
    while toc < duration
        brick.MoveMotor('AB', 40);
        brick.MoveMotor('B', 43);
        % Read gyro angle and ultrasonic distance
        gyroReading = brick.GyroAngle(3);
        ultrasonicReading = brick.UltrasonicDist(4);
        
        % Store the readings in arrays
        gyroData = [gyroData gyroReading];
        ultrasonicData = [ultrasonicData ultrasonicReading];
        
        % Plot the data in real-time
        adj = (gyroStart - gyroReading) *-1;
        brick.MoveMotor('B', 43 + adj * 7);
          disp(43 + adj);

         
    end
    brick.StopMotor('AB', "Brake");
    % Disconnect from the EV3 brick
    clear myLEGO;

    % Plot the recorded data
    plotData(gyroData, ultrasonicData);
end
function adjustSpeed(brick,gyroStart)
     gyroReading = brick.GyroAngle(3);
     adj = (gyroStart - gyroReading) *-1;
     brick.MoveMotor('B', 43 + adj * 5.5);
     disp(43 + adj);
end
function adjustSpeedBackward(brick,gyroStart)
     gyroReading = brick.GyroAngle(3);
     adj = (gyroStart - gyroReading);
     brick.MoveMotor('B', 43 + adj * 7);
     disp(43 + adj);
end
function enterManualMode(brick)
global key;
InitKeyboard();
    while 1
    pause(0.1);
        if(key ~= 0)    
            switch key
                case "uparrow"
                    brick.MoveMotor('AB', 40);
                    pause(0.4)
                    brick.StopMotor('AB', "Brake");
                case "downarrow"
                     brick.MoveMotor('AB', -40);
                    pause(0.4)
                    brick.StopMotor('AB', "Brake");
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
                 case "n"
                    brick.MoveMotor('AB', 30);
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
                case 0
                    disp("No key Pressed")
                case "q"
                    break;
            end
        end
    end
end
