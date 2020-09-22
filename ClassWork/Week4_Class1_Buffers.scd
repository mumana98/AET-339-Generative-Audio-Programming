//Buffers//
b = Buffer.read(s, "/Users/matthewumana/Documents/Generative Audio/Week4_Class1_Buffers.scd"); //Copy the file into the "path" argument area

b.play; //Test it

b.numChannels;
b.bufnum;
b.duration;
b.sampleRate;
b.numFrames; //Equal to the number of samples in a mono audio file. Stays the same regardless of the number of channels. Each sample, from every channel, will be in lock step with the frames.

~numSamples = b.numChannels * b.sampleRate * b.duration; //How to calculate number of samples. (This will be 2 times numFrames in a stereo file).

Buffer.freeAll; //Free all buffers;

(
SynthDef.new(\bufplay, {
	arg buf=0, rate=1, spos=0, amp=0.5, pan=0;
	var sig;
	sig = PlayBuf.ar(
		1,
		buf,
		BufRateScale.kr(buf) * rate, //Use BufRateScale.kr() to ensure that the sample plays correctly even if the sample rate differs from SC's sample rate. Then, multiply that by the rate ratio to change the speed. (rate=1 equals normal playback speed)
		startPos: spos, //start position specified in frames
		doneAction: 2);
	sig = sig * amp;
	sig = Pan2.ar(sig, pan); //Pan2 is great for simple stereo panning. A pan level of 0 is panned center (-1 far left, +1 far right)
	Out.ar(0, sig);
}).add;
)


(
x = Synth.new(\bufplay, args:[
	\buf, b.bufnum,
	\rate, rrand(0.5,4),
	\spos, rrand((b.numFrames * 0.005), (b.numFrames * 0.3)), //multiply by a percentage of the total number of frames to pick the earliest and latest possible start time positions (i.e., from half of a percent up to 50 percent of the way through the buffer in this case)
	\pan, rrand(-1,1),
	\amp, exprand(3,5)
]);
)

(
r = Routine.new({
	{
	Synth.new(\bufplay, args:[
		\buf, b.bufnum,
		\rate, [-12, -7, -5, -2, 0, 2, 4, 5, 7].choose.midiratio,
		\spos, rrand((b.numFrames * 0.005), (b.numFrames * 0.3)),
		\pan, rrand (-1,1),
		\amp, exprand(0.5,2.0)
		]);
	rrand(0.01,1).wait;
	}.loop;
}).play;
)

r.stop;




//Buffers Advanced//

//How to read file into buffer on any computer regardless of path:
//1. Provide a /sounds folder inside the parent folder containing the .scd file.
//2. Use this code below to load any sound contained within the /sounds folder:
~name = Buffer.read(s, PathName.new(thisProcess.nowExecutingPath).parentPath ++ "sounds/soundFileName.aif");

//glass sound
~glass = Buffer.read(s, PathName.new(thisProcess.nowExecutingPath).parentPath ++ "sounds/glass.wav");

~glass.play;

