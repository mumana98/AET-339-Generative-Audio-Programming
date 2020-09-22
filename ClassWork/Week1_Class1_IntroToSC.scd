//WELCOME TO GENERATIVE AUDIO PROGRAMMING IN SUPERCOLLIDER!
//My methods are based on teachings from Russell Pinkston and Eli Fieldsteel, my teachers!

/********INTRO to SC*********/


//Two sides to the SuperCollider program:
sclang //this is the language side of the software (logic, algorithms, arithmetic, etc.) - the "interpreter"
//The Interpreter is booted automatically when SC is opened

scsynth //this is the server side of the software (generates or manipulates sound)
//The server is not booted automatically and requires a boot



//////BOOTING///////
//Here are several methods for booting the server to make sound:
Server.local.boot;
s.boot; //'s' is an interpreter variable relegated to represent the local server (Server.local); so, you can simply type s.boot instead.

Server.local.quit; //quits the server
s.quit; //ditto

//You can also hover over the green server area in the bottom right-hand corner and right-click (or cntrl-click on a Mac) to access boot/quit options.


//////SHORTCUTS//////
//Boot shortcut: Cmd+B

//Cmd+Shift+P   Clears the Post window

//Cmd+.  Stops all audio on the server

//Access Help: Highlight a class or method and type Cmd+D



//////FUNCTIONS//////
{ } //Functions are created between curly braces

{}.play; //Functions that play sound often use the .play method

//Make some noise:
{PinkNoise.ar * 0.2}.play; //PinkNoise class, .ar method "audio rate", //.play message/method sent to the function

//IMPORTANT: If you hear nothing, the server is likely not booted
//You will also get this error: "WARNING: server 'localhost' not running."

//Cmd+. to stop the noise




//////SIMPLE LITERAL COMMANDS//////
5.squared; //5*5=25

x = {5.squared}; //Stores the function in the variable 'x'.

//READ: Any lower-case letter in the alphabet works as an interpreter variable; 'x' is great for quick testing.

x.value; //Gives the answer the above stored function

//"Persistency" - The value of 'x' is persistent throughout the file and even in new files. In other words, it's global throughout the program.

myFunc = {5.squared}; //returns an ERROR because variable isn't defined

~myFunc = {5.squared}; //Adding a tilda (~) before a variable name creates a user-defined global variable

~myFunc.value; //returns the answer to the function



//////EVALUATING CODE///////
//Shift+Enter (single line) vs. Cmd+Enter (block)

//Evaluate the following by placing the cursor inside the parentheses and typing Cmd+Enter
(
var myFunc, result;
myFunc = {5.squared};
result = myFunc.value;
)
//Now try evaluating individual lines
//You will get errors or 'nil' messages


//These are 'local' variables
var myFunc, result;

myFunc = {5.squared}; //this on its own will return an error because 'myFunc' is a local variable (it must be evaluated with the other code to work)



//EXTRA INFO:
//Study the "Using the Language" .scd file to learn more about "Literals" in SuperCollider






