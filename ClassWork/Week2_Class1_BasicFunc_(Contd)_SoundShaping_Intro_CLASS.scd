/*
Class Problem for Review
1. Create a function using PinkNoise in stereo
2. Declare a user-defined global variable called noise.
3. Declare a local argument ('amp') and a local variable ('sig') and use amp to scale the signal of the PinkNoise.
4. Play the function using the .play method, and define the amplitude as 0.05 at runtime.
*/


/*
(
~noise = {
	arg amp;
	var sig;
	sig = PinkNoise.ar!2;
	sig = sig * amp;

};
)
~noise.play(args:[\amp, 0.05]);
*/


s.meter;
s.scope;

{SinOsc.ar * 0.1}.play;

(
~noise = {
	arg amp = 0.2;
	var sig;
	PinkNoise.ar!2;
	sig = sig * amp;
}
)
x = ~noise.play(args:['amp', 0.1]);
x.set('amp', 0.3);
x.free;
//Cmd + option + T
(
~noise = {
	arg amp = 0.2;
	var sig;
	sig = PinkNoise.ar(amp); //takes place of sig = sig * amp
}
)
~noise.play;


SinOsc
Pulse
Saw
WhiteNoise
PinkNoise

(
~sound = {
	arg amp = 0.05, freq=440;
	var sig;
	sig = SinOsc.ar(MouseX.kr(220, 440), 0, MouseY.kr(0.5, 0.8));

}
)
x = ~sound.play;
x.set('freq', 220)

{SinOsc.ar(100)}.plot(1);
{SinOsc.ar(100)}.plot(0.01);

Window.closeAll;



//Envelopes

e = Env.new([0, 1, 0], [1, 1], 'lin').plot;

e = Env.new([0, 1, 0.3, 0.3, 0.5, 0], [0.1, 0.1, 3, 0.5, 1], 'lin').plot;
(
x = {
	var sig, env;
	env = EnvGen.kr(Env.new([0, 1, 0.3, 0.3, 0.5, 0], [0.1, 0.1, 3, 0.5, 1], 'lin'));//EnvGen executes serverside, Env.new is schematics
	sig = PinkNoise.ar!2;//makes it stereo
	sig = BPF.ar(sig, 1000, 0.3);
	sig = sig * env;
}.play;
)





