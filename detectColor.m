function [manual, finished] =  detectColor(brick, fin)
      manual = false;
      finished = false;
      
    color_rgb = brick.ColorRGB(1);  % Get Color on port 1.
        red =  color_rgb(1);
        green =  color_rgb(2);
        blue =  color_rgb(3);
        %print color of object
        
        %fprintf("\tRed: %d\n", color_rgb(1));
        
        %fprintf("\tGreen: %d\n", color_rgb(2));
        
        %fprintf("\tBlue: %d\n", color_rgb(3));
       
    switch true
        case isBlue(red,green,blue)
            fprintf('Color is BLUE\n');
             manual = true;
             brick.StopMotor('AB', "Brake");
        case isGreen(red,green,blue)
            fprintf('Color is GREEN\n');          
                manual = true;
                brick.StopMotor('AB', "Brake");
          
        case isYellow(red,green,blue)
            fprintf('Color is YELLOW\n');
            manual = true;
            finished = true;
            brick.StopMotor('AB', "Brake");
        case isRed(red,green,blue)
            fprintf('Color is RED\n');
            brick.StopMotor('AB', "Brake");
            pause(2.0)
            brick.MoveMotor('AB', 20);
            brick.MoveMotor('B', 24.5);
            pause(0.8)
        otherwise
        
    end
end
function [yes]  = isRed(red,green,blue)
    yes = false;
    if(red > 35 && green < 25 && blue < 25 )
        yes = true;
    end
end
function [yes]  = isBlue(red,green,blue)
    yes = false;
    if(red < 25 && green < 25 && blue > 45 )
        disp("Tis blue")
        yes = true;
    
    end
end
function [yes]  = isGreen(red,green,blue)
    yes = false;
    if(red < 20 && green > 20 && blue > 20 )
        yes = true;
    end
end
function [yes]  = isYellow(red,green,blue)
    yes = false;
    if(red > 30 && green > 30 && blue < 25 )
        yes = true;
    end
end
