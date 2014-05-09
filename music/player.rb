module Music
  class Player
    class << self

      def play; self.app.play end
      def pause; self.app.pause end
      def stop; self.app.stop end

      protected

        def app; Appscript.app('iTunes') end

    end
  end
end
