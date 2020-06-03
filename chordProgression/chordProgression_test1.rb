
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
chordProgression=(ring I,VI,II,V)


######### play  ##################

n=chordProgression.length
live_loop :chordProgression_test do
  use_random_seed 1000
  play chordProgression.tick.choose
  sleep 1
end

