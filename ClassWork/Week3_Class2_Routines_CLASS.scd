//VarSaw vs. Triangle
{VarSaw.ar(220, width: 0.01) * 0.5}.plot;
{VarSaw.ar(220, width: 0.99) * 0.5}.play;
{LFTri.ar(220) * 0.5}.plot;
{LFTri.ar(220) * 0.5}.play;

{VarSaw.ar(220, width: 0.5) * 0.5}.plot;//tri wave but its a saw wave
{LFTri.ar(220) * 0.5}.plot;

FreqScope.new;


(
SynthDef.new(\varSaw, {
	arg freq=440, amp=0.1, rel=1, relW=2.3;
	var sig, env, envW;
	env = EnvGen.kr(Env.new([0, 1, 0.99, 0],[0.1, 0.5, rel],'lin'), doneAction:2);//Add an envelope to control the amplitude shape of the signal (use Env.new)
	envW = EnvGen.kr(Env.new([0.5,0.99,0],[2,rel],'lin'), doneAction:2);//Add an envelope to control the width of the VarSaw (use Env.new; 0.01 is buzzier, 0.5 is less buzzy; 0.99 is also buzzy)
	sig = VarSaw.ar(freq, width: envW)!2; //VarSaw in stereo
	sig = sig * amp * env;
	Out.ar(0, sig)
}).add;
)

//test the VarSaw
Synth.new(\varSaw, args:[\freq, 220, \amp, 0.1]);

//Routines
(
Routine.new({
	x = [36, 43, 52, 59, 61, 66];
	(x+12).do({
		arg note;
		Synth.new(\varSaw, args:[
			\freq, note.midicps,
			\amp, 0.1,
			\rel, 5,
			\relW, 6.3
		]);
	});

5.wait;

	x.do({
		arg note;
		Synth.new(\varSaw, args:[
			\freq, note.midicps,
			\amp, 0.1,
			\rel, 5,
			\relW, 6.3
		]);
	});
}).play;
)
