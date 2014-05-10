require 'appscript'

module Music
  class Switcher
    class << self


      #
      # @param track_id [String]
      # @param duration [Float]
      #
      def switch(track_id, duration=nil)
        if duration.nil?
          # permanently switch to the new track
          volume = Music::Player.volume
          self.fade_to(0)
          Music::Player.volume = volume
          Music::Player.play(track_id)
          Music::Player.pause
          Music::Player.volume = 0

          Music::Player.play(track_id)
          self.fade_to(volume)
        else
          # keep track of original track info
          info = Music::Track.new.summary

          # fade to nothing
          volume = Music::Player.volume
          self.fade_to(0)
          Music::Player.pause
          position = Music::Player.position

          # switch to new track for given duration
          Music::Player.volume = volume
          Music::Player.play(track_id)
          sleep duration
          Music::Player.pause

          # fade from nothing to original volume
          Music::Player.volume = 0
          Music::Player.play(info[:id])
          Music::Player.position = position
          self.fade_to(volume)
        end
      end


      protected

        ### Helpers

        #
        #
        #
        def fade_to(end_volume)
          start_volume = Music::Player.volume
          puts "fading to #{end_volume} from #{start_volume}"
          step_size = (end_volume - start_volume) / 20.0
          puts "step size: #{step_size}"
          (1..20).each do |step|
            Music::Player.volume = start_volume + (step_size * step).to_i
            puts "... #{Music::Player.volume}"
            sleep 0.05
          end
          Music::Player.volume = end_volume
        end

    end
  end
end

# # @query
# Music::Searcher.search('query')
# # @return
# [
#   {
#     track_id: '0D64E70AB638D696',
#     name:     'Smells Like Teen Spirit',
#     album:    'Nevermind',
#     artist:   'Nirvana'
#   }
# ]

# start:
# stop:



# SelectedTrack
# # track_id # String
# # start_at # Decimal
# # end_at   # Decimal
