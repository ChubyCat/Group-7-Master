# Group-7-Master
The code is organized into four different files. 
 - Beeper.M is the main part of the code and it deals with all of the manual code.
 - DriveStraight.M contains a helper function that uses the curent gyroscope angle & a goal gyroscope angle to make sure the robot drives in a straight line
 - DrveStraight.M contains a helper function that uses the curent gyroscope angle & a goal angle to make sure the robot drives backgward in a straight line
 - detectColor.M contains a helper function and a set of helper functions that determine what color the robot is on top of using a set of thresholds.

# EMA
The code makes use of an exponential moving average filter for the ultrasonic sensor. This smooths out the sensor so that it outputs more consistent results. The formula for this is 
A is a gain value
EMA is the current smoothed distance
EMA = A * newReading + (1-A) * EMA

# Beeper File
The code the beeper file contians the intialization of a keyboard, and then a large switch statment that helps to define what the robot does next
A while loop is used to maintain the flow so that the robot state can be continuosly updated
Pressing "q" cancels the loop and lets the user exit control of the robot
Pressing "r" enables the automatic control of the robot
- Within automatic control, the robot moves foward until two possible things happen
      1.The button on the front is pressed
      2.There is a gap on the side of the robot

   In the first scenario, after the button is pressed, the robot will back up and stop. Then it will take an average of the ultrasonic sensor over a period of 1 second. Then if the left side is open( closest wall is at least 45cm away on that side) then it will move in that direction. If the left side is closer than 45cm it will move in the other direction.

In the second scenario, if EMA is greater than 65cm, the robot will back up and then turn towards that direction. It backs up to ensure that there is an opening for it.
