class Biker
  attr_reader :name,
              :max_distance,
              :rides,
              :acceptable_terrain

  def initialize(name, max_distance)
    @name = name
    @max_distance = max_distance
    @rides = {}
    @acceptable_terrain = []
  end

  def learn_terrain!(terrain)
    @acceptable_terrain << terrain if !@acceptable_terrain.include?(terrain)
  end

  def log_ride(ride, time)
    return unless acceptable_terrain.include?(ride.terrain) && ride.total_distance <= @max_distance

    @rides[ride] = [] if !@rides.key?(ride)
    @rides[ride] << time
  end

  def personal_report(ride)
    return false if !@rides.key?(ride)

    @rides[ride].min
  end
end
