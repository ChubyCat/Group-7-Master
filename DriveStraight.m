function DriveStraight(brick,gyroStart)
     gyroReading = brick.GyroAngle(3);
     %disp("Angles: " + gyroStart + " " + gyroReading)
     adj = (gyroStart - gyroReading) * -1;
     brick.MoveMotor('B', (30 + adj * 4));
    % disp("Foward Adjustment: " +( 30 + adj * 4));
end
