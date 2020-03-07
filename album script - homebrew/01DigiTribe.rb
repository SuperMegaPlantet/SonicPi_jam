use_bpm 120   #bpm

## master ##
set_mixer_control! lpf: 0, lpf_slide: 16


## drum ##
kick_mix=0
texture_mix=130
hihat_mix=80

## chord ##
pad_mix=100

## lead ##
lead_mix=0


live_loop :drum do #kick
  with_fx :lpf ,cutoff: kick_mix do
    sample :bd_tek
    sleep 1
  end
end



live_loop :texture do   #drum loop
  with_fx :lpf ,cutoff: texture_mix do
    sample :loop_safari ,amp: 0.5,
      cutoff: (range 80,120,20).mirror.tick
    sleep 4
  end
end


live_loop :hihat do    #hihat
  with_fx :lpf ,cutoff: hihat_mix do
    #with_fx :slicer ,phase: 1.5 do
    sample :drum_cymbal_closed
    sleep 0.25
    sample :drum_cymbal_closed
    sleep 0.5
    sample :drum_cymbal_closed
    sleep 0.25
    with_fx :reverb do
      sample :drum_cymbal_closed,rate: rrand(1,1.5)
      sleep 0.5
    end
  end
end

live_loop :chord do    #chord
  with_fx :lpf ,cutoff: pad_mix do
    with_fx :slicer do
      with_fx :reverb ,room: 0.9  do
        use_synth :tech_saws
        play_chord chord(:e3, :minor), attack: 0.6, sustain: 1.2, release: 0.9,cutoff: 90
        sleep 8
        #play_chord chord(:f3, :minor), attack: 0.6, sustain: 1.2, release: 0.9,cutoff: 90
        #sleep 8
      end
    end
  end
end

live_loop :lead do   #lead with lfo
  with_fx :lpf ,cutoff: lead_mix do
    use_synth :subpulse
    if one_in(2)
      use_transpose 2
    else
      use_transpose 0
    end
    play_pattern_timed chord(:e3, :m7), [1,0.25,0.75,0.5],
      attack: 0.01,
      sustain: rrand(0.05,0.1),
      release: 0.01 ,
      amp: 1.5,
      cutoff: (range 70,120,5).mirror.tick
  end
end




