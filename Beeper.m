global key
global gyroStart
InitKeyboard();
brick.SetColorMode(1, 4);  % Set Color Sensor connected to Port 1 to Color Code Mode
disp("Ready")
finished = false;
%Have to call angle at start becasue first angle is NaN
%1 -  color
%2 -  touch
%3 - gyro
%4 -  ultrasonic

%A - left
%B - right
%C - tail
while 1
    pause(0.1);
    if(key ~= 0)    
        switch key
            case "uparrow"
                try
                    while(key == "uparrow" )
                        
                        brick.MoveMotor('A', 95);
                        brick.MoveMotor('B', 100);
                    end
                catch
                    brick.StopMotor('AB', "Brake");
                end
                 brick.StopMotor('AB', "Brake");
            case "downarrow"
                try
                    while(key == "downarrow" )
                        
                        brick.MoveMotor('A', -75);
                        brick.MoveMotor('B', -75);
                    end
                catch
                    brick.StopMotor('AB', "Brake");
                end
                 brick.StopMotor('AB', "Brake");
            case "leftarrow"
                try
                    while(key == "leftarrow" )
                        
                        brick.MoveMotor('A', -40);
                        brick.MoveMotor('B', 40);
                    end
                catch
                    brick.StopMotor('AB', "Brake");
                end
                 brick.StopMotor('AB', "Brake");
            case "rightarrow"
                try
                    while(key == "rightarrow" )
                        
                        brick.MoveMotor('A', 40);
                        brick.MoveMotor('B', -40);
                    end
                catch
                    brick.StopMotor('AB', "Brake");
                end
                 brick.StopMotor('AB', "Brake");
            case "f"
                A= 0.125;
                EMA = 20;
                distance = brick.UltrasonicDist(4);
                    %This is an EMA(Exponentialy Moving Average) its used
                    %to smooth out the ultrasonic data
                    EMA = A * distance + (1-A) * EMA;
                    Angle = brick.GyroAngle(3);
                    disp("Distance: " + distance);
                    disp("EMA: " + EMA);
                    disp(" ")
                    pause(0.5);
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
             case "x"
                distance = brick.UltrasonicDist(4);
                disp(distance)
             case "n" 
               brick.MoveMotor('AB', 30);
                pause(0.1)
                brick.StopMotor('AB', "Brake");  
            case "a"
                 distance = brick.UltrasonicDist(4);
                 disp("Distance: " + distance);
            case "r"
                disp("Starting...")
                %Calibrate gyro at start
                brick.GyroCalibrate(3);
                pause(3)
                %Have to call angle at start becasue first angle is NaN
                disp(brick.GyroAngle(3));
                %Set gyroStart for the adjustSpeed algorithm
                gyroStart = brick.GyroAngle(3);
                turnCount = 0;
                finished = false;
                A = 0.07; %This is my value for gain
                EMA = 20;
                while(1==1)
                    if(key ~= 0 )
                        if(key == "q")
                            brick.StopMotor('AB', "Brake");
                            break;
                        end
                    end
                    %move foward    
                    brick.MoveMotor('AB', 30);
                    %Move the motors with an offset and adjust
                    %DriveStraight(brick,gyroStart);
                    DriveStraight( brick, gyroStart); % No outputs, as gyroStart is global
                    %Record the color outputted by the brick
                    [manual, finished] = detectColor(brick,finished);
                    if(manual)
                        break;
                    end
                    distance = brick.UltrasonicDist(4);
                    %This is an EMA(Exponentialy Moving Average) its used
                    %to smooth out the ultrasonic data
                    EMA = A * distance + (1-A) * EMA;
                    Angle = brick.GyroAngle(3);
                    disp("Distance: " + distance);
                    disp("EMA: " + EMA);
                    disp("Angle: " + Angle);
                    
                    if(EMA > 50)
                        EMA = 20;
                        disp("Starting Gap Stuff")
                        brick.MoveMotor('AB', -20);
                        brick.MoveMotor('B', -24);
                        pause(1.5)
                        brick.StopMotor('AB', "Brake");
                        %gyroStart = brick.GyroAngle(3);
                        %while(toc < .2)                            
                        %     DriveStraight(brick,gyroStart);
                        %    [manual, finished] = detectColor(brick,finished);
                        %   if(manual)
                        %      break;
                        %    end
                        %end
                         %Left turn
                         turnLeft(brick,turnCount);
                         %Turn(brick,-90);  
                       [manual, finished] = detectColor(brick,finished);
                        if(manual)
                            break;
                        end         
                        gyroStart = brick.GyroAngle(3);
                        %gyroStart = -90;
                        disp("AGAIN!")
                        tic
                        brick.MoveMotor('AB', 30);
                        while(toc < 3)                            
                            DriveStraight(brick,gyroStart);
                            [manual, finished] = detectColor(brick,finished);
                            if(manual)
                                break;
                            end
                        end
                        %pause(4)
                        brick.StopMotor('AB', "Brake");                     
                    end
                    if(brick.TouchPressed(2) == 1)   
                        EMA = 0;
                       brick.StopMotor('AB', "Brake");
                        %ouch! hit a wall
                        disp("I just hit a wall")
                       % gyroStart = -90;
                        gyroStart = brick.GyroAngle(3);
                        tic
                        brick.MoveMotor('AB', -30);
                        while(toc < 1.8)                            
                            DriveStraightBack(brick,gyroStart)
                            [manual, finished] = detectColor(brick,finished);
                            if(manual)
                                break;
                            end
                        end
                        brick.StopMotor('AB', "Brake"); 
                        distance = brick.UltrasonicDist(4);
                        [manual, finished] = detectColor(brick,finished);
                        if(manual)
                            break;
                        end   
                        disp("Distance: " + distance);
                        tic
                        avgDistance = distance;
                        counter = 1;
                        while(toc < 0.5)
                            distance = brick.UltrasonicDist(4);
                            avgDistance = avgDistance + distance;
                            counter = counter + 1;
                        end
                        avgDistance = avgDistance / counter;
                        
                        disp("Average: " + avgDistance)
                        pause(1)
                        if(avgDistance > 45)
                            %turn left
                            turnLeft(brick,turnCount);

                            %Turn(brick,-90)
                            %turnCount = turnCount + 1;
                            %gyroStart = -90;
                           gyroStart = brick.GyroAngle(3);
                        else
                            %turn right
                            turnRight(brick,turnCount);
                            %Turn(brick,90);
                            %turnCount = turnCount + 1;
                            %gyroStart = 90;
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
function turnLeft(brick,turnCount)
    brick.GyroCalibrate(3);
        pause(2)
        disp(brick.GyroAngle(3));    
        newAngle = brick.GyroAngle(3);
        brick.MoveMotor('A', -25);
        brick.MoveMotor('B', 20);
        switched = false;
        while( newAngle > -85)   
            newAngle = brick.GyroAngle(3);
            disp(newAngle);
            %if(newAngle < -85 && switched == false)
               % switched = true;
              %  brick.MoveMotor('A', 10);
             %   brick.MoveMotor('B', -10);
            %end
            %if(newAngle > -85 && switched == true )
               % switched = false;
              %  brick.MoveMotor('A', -10);
             %   brick.MoveMotor('B', 10);
            %end
        end
        brick.StopMotor('AB', "Brake");
end
function turnRight(brick, turnCount)
    brick.GyroCalibrate(3);
        pause(2)
        disp(brick.GyroAngle(3));    
        newAngle = brick.GyroAngle(3);
        brick.MoveMotor('A', 25);
        brick.MoveMotor('B', -20);
        switched = false;
        while( newAngle < 85)   
            newAngle = brick.GyroAngle(3);
            disp(newAngle);
            %if(newAngle > 85 && switched == false)
             %   switched = true;
              %  brick.MoveMotor('A', -10);
               % brick.MoveMotor('B', 10);
            %end
            %if(newAngle < 85 && switched == true )
            %    switched = false;
             %   brick.MoveMotor('A', 10);
             %   brick.MoveMotor('B', -10);
            %end
        end
        brick.StopMotor('AB', "Brake");
end
function flipAround(brick)
    brick.GyroCalibrate(3);
        pause(0.5)
        disp(brick.GyroAngle(3));    
        newAngle = brick.GyroAngle(3);
        while( newAngle < 170)   
            newAngle = brick.GyroAngle(3);
            disp(newAngle)
            brick.MoveMotor('A', 27);
            brick.MoveMotor('B', -25);
            pause(0.05)
        end
        brick.StopMotor('AB', "Brake");
end

