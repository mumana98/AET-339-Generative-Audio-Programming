Env.new([0,0.8,0], [0.1,1], [0, 0]).plot;
Env.new([0,0.8,0], [0.1,1], [0, -10]).plot;
Env.new([0,0.8,0], [0.1,1], [0, 5]).plot;


(
x = {
	var sig, env;
	env = EnvGen.kr(Env.new([0,0.8,0], [0.1,1], 'lin'));
	sig = PinkNoise.ar!2; //
	sig = BPF.ar(sig,1000,0.1);
	sig = sig * env
}.play;
)
//Let's check the node tree on the server to see what's happening
s.plotTree;
//Shortcut: Opt+Cmd+T

//Notice: the more times you play the synth, the more copies of them begin to stack up on the server.

//We need to free them using another argument in EnvGen called 'doneAction'

(
x = {
	var sig, env;
	env = EnvGen.kr(Env.new([0,0.8,0], [0.1,1], 'lin'), doneAction:2 //frees the synth automatically
	).poll; //add the poll method to see the numbers on the Post window to compare doneAction:2 vs. doneAction:0
	sig = PinkNoise.ar!2;
	sig = BPF.ar(sig,1000,0.1);
	sig = sig * env
}.play;
)



/*******Other Env methods*******/

//Env.perc
(
x = {
	var sig, env;
	env = EnvGen.kr(Env.perc(0.01,1,1),doneAction:2);
	sig = PinkNoise.ar!2;
	sig = BPF.ar(sig,1000,0.1);
	sig = sig * env
}.play;
)

Env.perc(0.01,3,1).plot;

Window.closeAll;

//Env.adsr
(
x = {
	var sig, env;
	env = EnvGen.kr(Env.adsr(0.01,0.3,0.3,1),doneAction:2); //Doesn't really work correctly because the envelope holds at 0.3 indefinitely. Needs 'gate' argument.
	sig = PinkNoise.ar!2;
	sig = BPF.ar(sig,1000,0.1);
	sig = sig * env
}.play;
)


//Here it is adjusted with a gate arg
(
x = {
	arg gate;
	var sig, env;
	env = EnvGen.kr(Env.adsr(0.01,0.3,0.3,1),gate,doneAction:2); //added gate argument
	sig = PinkNoise.ar!2;
	sig = BPF.ar(sig,1000,0.1);
	sig = sig * env
}.play;
)

x.set(\gate, 1);
x.set(\gate, 0);




/*******RANDOMNESS*********/

{LFNoise0.ar(4)}.plot(1);
{LFNoise1.ar(10)}.plot(1);
{LFNoise2.ar(20)}.plot(1);

(
f = {
	var sig, freq;
	freq = LFNoise0.ar(10).range(40, 10000);
	sig = SinOsc.ar(freq);
	sig = sig * 0.01;//scales amp

}.play;
)

