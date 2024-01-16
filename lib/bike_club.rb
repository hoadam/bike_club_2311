class BikeClub
  attr_reader :name,
              :bikers

  def initialize(name)
    @name = name
    @bikers = []
  end

  def add_biker(biker)
    @bikers << biker
  end

  def most_rides
    @bikers.max_by { |biker| biker.rides.length }
  end

  def best_time(ride)
    @bikers.min_by { |biker| biker.personal_report(ride) }
  end

  def biker_eligible(ride)
    @bikers.find_all do |biker|
      biker.acceptable_terrain.include?(ride.terrain) && ride.total_distance <= biker.max_distance
    end
  end
end
