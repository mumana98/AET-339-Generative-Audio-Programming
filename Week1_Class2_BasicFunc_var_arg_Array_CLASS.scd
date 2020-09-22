/*
Class Problem for Review
1. Create a function that adds 3 cubed to 4.
2. Declare a local variable basicFunction and use this to store the result of your function.
3. Retrieve the value of the function and print the result when the full block of code is evaluated.
*/


//inclass version
(
var basicFunction;
basicFunction = {
	3.cubed + 4
};
basicFunction.value;
)

//more effective function
(
var basicFunction;
basicFunction = {
	arg input;
	input.cubed + 4;
};
basicFunction.value(4);
)

//even more effective function
(
var basicFunction;
basicFunction = {
	arg input, offset;
	input.cubed + offset;
};
basicFunction.value(4, 5);
)

//my version - dont do - not modular
/*
(
var basicFunction = {3.cubed + 4};
basicFunction.value;
)
*/


//Makeing noise

(
~noise = {
	PinkNoise.ar * 0.2

};
)
~noise.play;

(
~noise = {
	arg amp = 0.05;
	var sig;
	sig = PinkNoise.ar;
	sig = sig * amp;

};
)
~noise.play(args:[\amp, 0.2]);


//Cmd + M will bring up meter

(
~noise = {
	arg amp = 0.05;
	var sig;
	sig = [PinkNoise.ar, PinkNoise.ar];
	sig = sig * amp;

};
)
~noise.play(args:[\amp, 0.2]);

//same ways of making an array of 2 pinknoise3
[PinkNoise.ar, PinkNoise.ar];

PinkNoise.ar.dup;

PinkNoise.ar!2;





