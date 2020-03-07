
address="C:/Users/Administrator/Desktop/samples/"


use_bpm 130


## master ##
set_mixer_control! lpf: 0, lpf_slide: 16

## drum ##
drum_mix=130
drum_pattern = 2  #   1-full drum 2-transition

##  chord ##
chord_mix=130
chord_pattern = 2   # 1- chord progression , 2- house pattern

## bass ##
bass_mix=130
bass_octave=24  #  0 (bass) ----> 12 (bright bass) -----> 24 (lead)


#drum
live_loop :drum do
  with_fx :lpf ,cutoff: drum_mix do
    if drum_pattern ==1
      sample address, "drum1",beat_stretch: 16,amp: 2
      sleep 16
    end
    
    if drum_pattern ==2
      with_fx :ixi_techno ,mix: 0.5, phase: 2 do
        sample address, "drum2",beat_stretch: 16, amp: 2
        sleep 16
      end
    end
  end
end



#chord: G major7, A major 7, A# major 7, C major7
chord_progression=(ring (chord(:g3, :m7)),(chord(:a3, :m7)),(chord(:bb3, :m7)),(chord(:c4, :m7)))

live_loop :chord do
  with_fx :lpf ,cutoff: chord_mix do
    with_synth :piano do
      4. times do
        current_chord= chord_progression.tick
        
        if chord_pattern ==1
          play_chord current_chord,attack: 0.5,release: 4,amp: 6
          sleep 2
        end
        
        if chord_pattern ==2
          4. times do
            play_chord current_chord ,pan: rrand(-1,1),attack: 0.01 ,release: (ring 0.2,0.6,0.3,0.3).tick,pan:rrand(-1,1), amp: (ring 4,2.5,4,4).tick
            sleep (ring 0.25,0.75,0.5,0.5).tick
          end
        end
      end
    end
  end
end

#bass
octave=bass_octave
bass_note=(ring :g2+octave,:g2+octave,:bb2+octave,:c2+octave)

live_loop :bass do
  with_fx :lpf ,cutoff: bass_mix do
    with_fx :echo ,phase: 0.3, mix: 0.1 do
      with_synth :tb303 do
        note=bass_note.tick
        4. times do
          2. times do
            current_note=(ring :r,note-choose([12,0])).tick    # [:r,note-12,:r,note]
            play current_note,amp: 0.2,attack: 0.01,release: 0.125, cutoff: rrand(70, 130), res: 0.9, wave: 1
            sleep 0.25
          end
        end
      end
    end
  end
end
