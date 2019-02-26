# WTDTool
## Personal Project for facilitating some Ogame attacks

As with the ACSProfitCalc, this project was created a long time ago (in a galaxy far, far away...).

Watch the Debris (WTD) is an attack where the defender sends a fleet of spaceships slowly to some planet where there are debris around with the intent of recycling those debris and be sure that those spaceships cannot be attacked during the trip.
This was usually used when players would go to sleep.

My brother and I were part of a team that was already quite proficient at detecting such fleets and attacking the moment they returned (with 3/4 seconds difference), making it impossible for the defender to save those spaceships.

This tool was done with the intent of making such attacks easier and more accurate.

With the help of a mouse hook, every mouse click is registered (mouse clicks represent refreshes of the galaxy system's view).
When it is visible that the debris were recicled, Ctrl + D fixes the value of the last click in the main list.
With that value is then easy to calculate the returning time.

Later, it was also added the option to take Snapshots of part of the screen for each mouse click.
The images taken always have the time of the previous click.
