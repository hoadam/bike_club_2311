class Ride
  attr_reader :name,
              :distance,
              :loop,
              :terrain

  def initialize(input)
    @name = input[:name]
    @distance = input[:distance]
    @loop = input[:loop]
    @terrain = input[:terrain]
  end

  def loop?
    @loop
  end

  def total_distance
    if loop?
      @distance
    else
      @distance * 2
    end
  end
end
