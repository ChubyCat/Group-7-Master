function DriveStraightBack(brick,gyroStart)
       disp("Backing up")
     gyroReading = brick.GyroAngle(3);
     disp("Angles: " + gyroStart + " " + gyroReading)
     adj = (gyroStart - gyroReading) * -1;
     brick.MoveMotor('A', -30 - adj * 4);
     disp("Adjustment: " + (-30 - adj * 4));
end
