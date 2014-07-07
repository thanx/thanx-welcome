require 'appscript'

module Music
  class Switcher
    class << self

      FADE_STEP_COUNT = 100
      FADE_STEP_DURATION = 0.01

      #
      # @param track_id [String]
      # @param duration [Float]
      #
      def switch(track_id, start_at, end_at)
        # keep track of original track info
        info = Music::Track.new.summary

        # fade to nothing
        if info.present?
          info[:state] = Music::Player.state
          info[:state] == :playing ? self.fade_to(0) : Music::Player.volume = 0
          Music::Player.pause
          info[:position] = Music::Player.position
          sleep 1
        end

        # switch to new track for given duration
        Music::Player.volume = 0
        Music::Player.play(track_id)
        sleep 6 # introduce latency so airplay has time to connect
        Music::Player.position = start_at.to_f
        self.fade_to(100)
        fade_duration = 2*FADE_STEP_COUNT*FADE_STEP_DURATION
        sleep (end_at - start_at - fade_duration).to_f
        self.fade_to(0)
        Music::Player.stop

        # fade from nothing to original volume
        if info.present?
          # set the current track to the original song and continue with
          # the original player state
          Music::Player.play(info[:id])
          Music::Player.position = info[:position]
          if info[:state] == :playing
            sleep 1
            self.fade_to(100)
            # ensure at least 5 seconds of original song plays
            sleep 5
          else
            Music::Player.pause
          end
        else
          Music::Player.volume = 100
        end
      end


      protected

        ### Helpers

        #
        #
        #
        def fade_to(end_volume)
          end_volume = [[end_volume, 100].min, 0].max
          start_volume = Music::Player.volume
          puts "Tuning Volume from #{start_volume} to #{end_volume}"
          step_size = (end_volume - start_volume) / FADE_STEP_COUNT.to_f
          (1..FADE_STEP_COUNT).each do |step|
            Music::Player.volume = (start_volume + (step_size * step).to_i).to_i
            sleep FADE_STEP_DURATION
          end
          Music::Player.volume = end_volume
        end

    end
  end
end
