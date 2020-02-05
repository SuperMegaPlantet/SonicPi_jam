#fall in deep -Aoi Sho


use_bpm 120   

live_loop :drum do
  with_fx :slicer ,pulse_width: 0.5 do
    with_fx :reverb ,mix: 0.5 do
      with_fx :rlpf ,cutoff: 30 ,cutoff_slide: 40 do
        sample :loop_garzul, rate: 1
        sleep 4
      end
    end
  end
end

live_loop :sample do
  with_fx :rlpf ,cutoff:60 ,cutoff_slide: 20 do
    with_fx :reverb do
      #p=[-1,0,1].choose
      sample :guit_em9 ,rate: 1, pan:(range -1,1,0.4).mirror.tick
      sleep [16,32].choose
    end
  end
end

##| live_loop :bass do
##|   use_synth :sine
##|   play choose([:g2,:b2,:e2,:d2]), attack: 0, release: 0.25
##|   sleep 0.5
##|   play :b2, attack: 0, release: 0.3
##|   sleep 0.5
##|   play :e2
##|   sleep 0.5
##|   play choose([:g2,:b2,:e2,:d2])
##|   sleep 0.5
##| end

use_synth :hollow
with_fx :reverb ,mix: 0.9 do
  
  
  live_loop :ambi_chord_1 do
    play choose([:E3,:G3]),attack:6,sustain:1,release:6
    sleep 8
  end
  
  live_loop :ambi_chord_2 do
    play choose([:B3,:D3]),attack:5,sustain:2,release:4
    sleep 8
  end
  
  live_loop :ambi_chord_3 do
    play choose([:Fs3,:E4]),attack:6,sustain:3,release:6
    sleep 10
  end
  
  live_loop :ambi_chord_4 do
    play choose([:G4,:B4]),attack:5,sustain:5,release:6
    sleep 11
  end
end



