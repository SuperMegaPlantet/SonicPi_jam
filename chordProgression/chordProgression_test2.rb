use_bpm 127

#############  define scale ##########################

current_scale = 'Cmajor_scale'


if current_scale == 'Cmajor_scale'
  #note=[:C,:D,:E,:F,:G,:A,:B]   # C major scale
  note=scale(:c3, :major)
elsif current_scale == 'Cminor_scale'
  #note=[:C,:D,:Eb,:F,:G,:Ab,:Bb] # C minor scale
  note=scale(:c3, :minor)
end

###############   define chord collection    ####################

I=[(chord note[0], :major7),(chord note[0], :maj9),(chord note[0], :dom7)]
II=[(chord note[1], :minor7),(chord note[1], :m9),(chord note[1], :m13)]
III=[(chord note[2], :minor7),(chord note[2], :m9),(chord note[2], :m13),(chord note[2], :madd11)]
IV=[(chord note[3], :major7),(chord note[3], :maj9),(chord note[3], :dom7)]
V=[(chord note[4], :major7),(chord note[4], :maj9),(chord note[4], :dom7)]
VI=[(chord note[5], :minor7),(chord note[5], :m9),(chord note[5], :m13),(chord note[5], :madd13)]
VII=[(chord note[6], :diminished),(chord note[6], :dim7)]

#############   define chord progression  #########################
chordProgression=(ring II,VI,IV,I)

# I,II,VI,V
# II,VI,IV,I

######### play  ##################

n=chordProgression.length



live_loop :chord_generator do
  use_random_seed 2000
  currentChord=chordProgression.tick.choose
  set :chord2play, currentChord
  #play currentChord
  sleep 1
end

live_loop :piano do
  use_synth :dsaw
  #play get :chord2play
  #sleep choose([0.25,0.5])
  piano_chord= get :chord2play
  play piano_chord if (spread 7, 16).tick
  sleep 0.25
end

live_loop :bass do
  use_synth :tb303
  with_fx :lpf ,cutoff: 80 do
    tick
    play (choose(get :chord2play)-12), release: 0.3, cutoff: rrand(60,120),amp: 0.4 if (spread 5,16).look
    sleep 0.25
  end
end


live_loop :drum do
  #sample :loop_amen, beat_stretch: 4
  #sleep 4
  tick
  sample :drum_cymbal_soft, amp: 1.5 if (spread 5,16).rotate(4).look
  sample :bd_tek, amp: 1.5 if (spread 4,16).look
  #sample :drum_snare_hard , amp: 1  if (spread 2,16).look
  sleep 0.25
end

