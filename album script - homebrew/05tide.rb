#sample : Amazon(Amazonas) - Jo?o Donato

use_bpm 140

address="C:/Users/Administrator/Desktop/samples/"

##| live_loop :string1 do
##|   sample address, "string1", rate: 1,beat_stretch: 32
##|   sleep 32
##| end


live_loop :signal do
  with_synth :beep do
    with_fx :reverb do
      with_fx :lpf ,cutoff: 40 do
        2.times do
          #play :c6
          sleep 1
        end
        sleep 2
      end
    end
  end
end




live_loop :beat_slicer do
  with_fx :lpf ,cutoff:(range 30,100,2).mirror.tick  do
    with_fx :reverb ,mix: 0.8 do
      slice_idx = rand_i(8)
      slice_size =0.03125*2
      s = slice_idx * slice_size
      f = s + slice_size
      sample address, "string1", start: s, finish: f, amp: 2
      sleep 0.5   #0.25
    end
  end
end





