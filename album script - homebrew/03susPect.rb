#  -Aoi Sho

use_bpm 127

samples="C:/Users/OKMAX/Desktop/sonicPicode/AoiSho/homework/sample"
vocal_amp =3.5 #3.5

## master ##
set_mixer_control! lpf: 0, lpf_slide: 16

## snare ##
snare_mix= 0 #110

## chord ##
chord_mix=100   #50-100

## vocal ##
vocal_mix=0 #90


live_loop :drum do
  sample :bd_haus,amb: 2,cutoff: 80
  sleep 1
  sample :bd_haus,amb: 2,cutoff: 80
  with_fx :lpf ,cutoff: snare_mix do
    with_fx :bitcrusher, mix: 0.3,bits:9 do
      sample :sn_zome,rate: 1.01,cutoff: 123,attack: 0.015,lpf_attack: 0.008,amp: 0.47
    end
  end
  sleep 1
end



live_loop :rev_cymbal do
  with_fx :reverb ,room: 0.9 do
    sample :drum_cymbal_pedal ,rate: -0.7,cutoff: rrand(90,120)
    sleep choose([16,24])
  end
end

live_loop :low_frequency_osc do
  tick
  synth :sine, wave: 1, phase: 0.25, release: 5, note: (knit :e1, 12, :c1, 4).look, cutoff: (line 60, 120, steps: 6).look
  sleep 4
end




live_loop :texture do
  with_fx :bitcrusher ,bits: (range, 8,12,1).mirror.tick do
    with_fx :slicer ,pulse_width: 0.5 do
      sample :loop_compus,beat_stretch: 8,cutoff: 80,amp: 0.07
      sleep 8
    end
  end
end



live_loop :base_texture do
  with_fx :reverb, room: 0.9 do
    with_fx :distortion do
      sample :perc_impact2,rate:rrand(-1,-0.01),cutoff: 40
      sleep rrand(5,16)
    end
  end
end


live_loop :bass do
  with_fx :reverb ,room: 0.1 do
    use_synth :supersaw
    use_random_seed 76103
    sleep 0.5
    2. times do
      play :d3, amp: 1, release: 0.2,cutoff: rrand(40,95) ,detune: 12
      sleep 0.25
    end
  end
  
  ##| play_pattern_timed chord(:d3,:min), [0.25,0.25,0.25],
  ##|   amp: 0.3,
  ##|   attack: 0.2,
  ##|   release: 0.1
  
end


live_loop :chord do
  with_fx :lpf ,cutoff: chord_mix do
    use_synth :zawa
    3. times do
      play_chord (chord :d,:m11),attack: 0.9, sustain: 2,release: 1.3, res: 0.7,
        wave: 2
      sleep 4
    end
    play_chord (chord :c,:m11),attack: 0.9, sustain: 2,release: 2, res: 0.9,
      wave: 2
    sleep 4
  end
end






live_loop :vocal_sample do
  sync :chord
  with_fx :panslicer ,phase: 0.1 do
    with_fx :flanger ,mix: 1, phase: 8, wave: 3 do
      sleep 0.5
      3. times do
        sample samples, "vocal_suspected",amp: 2,lpf: vocal_mix
        sleep 4
      end
      sample samples, "vocal_quarantine", apm: 2,lpf: vocal_mix
      sleep 4
    end
  end
end



