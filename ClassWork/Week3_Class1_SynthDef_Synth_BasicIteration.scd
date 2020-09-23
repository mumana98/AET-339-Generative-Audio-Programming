/******SynthDef******/


(
x = {
	arg amp=0.05, freq=440;
	var freqCtrl, sig;
	freqCtrl = freq + LFNoise1.kr(2!4).range(-2,2);
	freqCtrl.poll;
	sig = Saw.ar(freqCtrl);
	sig = sig * amp;
	sig = Splay.ar(sig);
}.play;
)

(
x = {
	arg amp=0.05, freq=440;
	var freqCtrl, sig;
	freqCtrl = freq * LFNoise1.kr(2!4).range(-0.10,0.10).midiratio; //midiratio creates a ratio that can be multiplied by the main frequency value to get an exact portion of a musical whole step up or down (in this case, -0.10 or +0.10 of a whole step)
	freqCtrl.poll;
	sig = Saw.ar(freqCtrl);
	sig = sig * amp;
	sig = Splay.ar(sig);
}.play;
)

//Wrapped into a SynthDef
(
SynthDef.new(\saw, {
	arg amp=0.05, freq=440;
	var freqCtrl, sig;
	freqCtrl = freq * LFNoise1.kr(2!4).range(-0.10,0.10).midiratio;
	sig = Saw.ar(freqCtrl);
	sig = sig * amp;
	sig = Splay.ar(sig);
}).add;
)

//Using the Synth class to play the SynthDef
Synth.new(\saw, [\amp, 0.05, \freq, [440,660].choose]); //No sound

(
SynthDef.new(\saw, {
	arg amp=0.05, freq=440;
	var freqCtrl, sig;
	freqCtrl = freq * LFNoise1.kr(2!4).range(-0.10,0.10).midiratio;
	sig = Saw.ar(freqCtrl);
	sig = sig * amp;
	sig = Splay.ar(sig);
	Out.ar(0, sig); //Must use the Out UGen to send the signal to a bus; check out the meters. Because Splay.ar creates a signal array across two channels, Out.ar automatically distributes the stereo signal into the necessary output buses beginning with the "zeroth" bus (so, bus 0 and 1, respectively).
}).add;
)

Synth.new(\saw, [\amp, 0.05, \freq, 440]);




//Three important things to remember about SynthDef:
//1. Give it a name
//2. Add it to the server using .add
//3. You must specify the output using Out.ar when wrapping a function in a SynthDef.

//Use the Synth class to discretely play synths that have been added to the server. SynthDef allows greater specificity and is ultimately the better choice when dealing with multiple synths on the server.


//Let's try multiple copies of a Synth to create a chord:
(
Synth.new(\saw, [\amp, 0.03, \freq, 220]);
Synth.new(\saw, [\amp, 0.03, \freq, 440]);
Synth.new(\saw, [\amp, 0.03, \freq, 660]);
Synth.new(\saw, [\amp, 0.03, \freq, 880]);
)


//Add an envelope to make it a bit more musical:
(
SynthDef.new(\saw, {
	arg amp=0.05, freq=440;
	var freqCtrl, sig, env; //declare a variable
	env = EnvGen.kr(Env.new([0,1,0],[2,3],[-3,3]),doneAction:2); //define the envelope
	freqCtrl = freq * LFNoise1.kr(2!4).range(-0.10,0.10).midiratio;
	sig = Saw.ar(freqCtrl);
	sig = sig * amp * env; //multiply the sig by the amp scale and the env
	sig = Splay.ar(sig);
	Out.ar(0, sig);
}).add;
)

//Using the .midicps method to convert from midi note numbers to cycles per second (frequency)
(
Synth.new(\saw, [\amp, 0.03, \freq, 33.midicps]);
Synth.new(\saw, [\amp, 0.03, \freq, 45.midicps]);
Synth.new(\saw, [\amp, 0.03, \freq, 52.midicps]);
Synth.new(\saw, [\amp, 0.03, \freq, 61.midicps]);
)



/******Basic Iteration******/

//Use .do method instead of repeating lots of lines of code to do redundant tasks:

//Posting "hello" for each item in array
//the array is the 'receiver' of action. The function inside of the .do method is what will occur with each item
(
[33,45,52,61].do({
	"hello".postln;
})
)

//Access the elements in the array by declaring an argument:
(
[33,45,52,61].do({
	arg note; //each element will be referred to as a 'note'
	note.postln; //post the value at each index in the array
})
)


//Using this process to create the notes of your chords
(
[33,45,52,61].do({
	arg note;
	Synth.new(\saw, [\freq, note.midicps])
})
)


// envelope with a gate (Env.adsr or Env.asr)
(
SynthDef.new(\saw, {
	arg amp=0.05, freq=440, gate=1; //add gate arg (1 by default)
	var freqCtrl, sig, env;
	env = EnvGen.kr(Env.adsr(0.3,0.3,0.5),gate,doneAction:2); //add gate into the EnvGen
	freqCtrl = freq * LFNoise1.kr(2!4).range(-0.10,0.10).midiratio;
	sig = Saw.ar(freqCtrl);
	sig = sig * amp * env;
	sig = Splay.ar(sig);
	Out.ar(0, sig);
}).add;
)

// .collect method to store the evaluation of the function--the synth playing on the server in this case--to be able to turn off their gates individually
(
x = [33,45,52,61].collect({ //using .collect instead of .do
	arg note;
	Synth.new(\saw, [\freq, note.midicps]) //it will store this evaluated last line as the array in x.
})
)

//Each of these will turn off their respective synths in the array
x[0].set(\gate, 0);
x[1].set(\gate, 0);
x[2].set(\gate, 0);
x[3].set(\gate, 0);


//Use the do method to turn them off simultaneously:
(
x.do({ // x is an array of synths that are playing on the server, so we can set all of the gates using iteration
	arg synth;
	synth.set(\gate, 0);
})
)
