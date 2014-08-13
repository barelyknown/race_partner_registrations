module RacePartnerRegistrations
  class Registration

    attr_reader :name, :location

    def initialize(name, location)
      @name, @location = name, location
    end

  end
end
