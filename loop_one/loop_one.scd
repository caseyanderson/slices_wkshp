/*
loop_one.scd
Casey Anderson, 2018

loop a sound file forever

run the file from inside supercolliderStandaloneRPI1 as follows (edit to suit your needs):

xvfb-run --auto-servernum ./sclang -a -l ~/supercolliderStandaloneRPI2/sclang.yaml /home/pi/slices_wkshp/loop_one/loop_one.scd /home/pi/recordings/haiti.wav

TODO:
* need a keyboard interrupt of some sort that shuts SC down gracefully
*/

s.options.memSize = 8192 * 4; // adjust multiplier to increase memory

s.latency= 0.05;

s.waitForBoot{
	var thePath;

	thePath = thisProcess.argv;

	SynthDef(\play, { | amp = 0.0, buf, trig = 0 |
		var env, sig;

		env = EnvGen.kr( Env.asr( 0.0, 0.99, 0.05), trig,  doneAction: 0 );
		sig = PlayBuf.ar(1, buf, BufRateScale.kr(buf), loop: 1) * env;
		Out.ar(0, sig);
	}).add;

	// setup buffer

//	~buf = Buffer.read( s, thePath[0].asString);
	~buf = Buffer.readChannel(s, thePath[0].asString, channels: 0 );

	// wait for sync message from server

	s.sync;

	// run the synth

	Synth.new(\play, [\amp, 0.9, \buf, ~buf, \trig, 1]);

	("PLAYING NOW!"++", Server Memory: "++s.options.memSize).postln;

};
