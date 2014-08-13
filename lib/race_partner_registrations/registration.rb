module RacePartnerRegistrations
  class Registration

    attr_reader :name, :location

    def initialize(name, location)
      @name, @location = name, location
    end

    def state
      extract_state(location)
    end

  private

    def extract_state(location)
      raw_state = location.split(",").last
      raw_state.strip.upcase if raw_state.length > 0
    end

  end
end
