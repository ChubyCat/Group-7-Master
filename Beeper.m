display('Push the button.')
A = 10;
c = 0;
while A > 0
    c=c+1;
    display("Running... NOWWWW");
    brick.MoveMotor('A', 50);
    %display(brick.UltrasonicDist('A'));
  notes = [523, 523, 392, 392, 440, 440, 392,349,349,330,330,294,294,523, 392,392,349,349,330,330,294,392,392,349,349,330,330];

  durations = [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5];
    volume = 30;
    
    % Play "Twinkle, Twinkle, Little Star"
    for i = 1:length(notes)
    brick.playTone(volume, notes(i), 500 * durations(i)); % Convert duration to milliseconds
    pause(0.5); % Add a short pause between notes
    end
 
end
display('Done!')