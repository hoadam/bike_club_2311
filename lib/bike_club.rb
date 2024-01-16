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

  def record_group_ride(ride)
    start_time = Time.now
    ride_data = { ride: ride, members: biker_eligible(ride), start_time: start_time }

    ride_data[:members].each do |biker|
      finish_time = Time.now
      ride_time = ((finish_time - start_time)/60).to_i
      biker.log_ride(ride_data[:ride],ride_time)
    end
  end
end
