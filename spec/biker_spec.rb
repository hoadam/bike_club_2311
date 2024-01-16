require './lib/ride'
require './lib/biker'

RSpec.describe Biker do
  let(:ride_1) { Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills}) }
  let(:ride_2) { Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel}) }
  let(:biker_1) { Biker.new("Kenny", 30) }
  let(:biker_2) { Biker.new("Athena", 15) }

  describe "#initialize" do
    it "can initialize" do
      expect(biker_1.name).to eq("Kenny")
      expect(biker_1.max_distance).to eq(30)
      expect(biker_1.rides).to eq({})
      expect(biker_1.acceptable_terrain).to eq([])
    end
  end

  describe "#learn_terrain!" do
    it "adds terrain to acceptable_terrain array" do
      biker_1.learn_terrain!(:gravel)
      biker_1.learn_terrain!(:hills)

      expect(biker_1.acceptable_terrain).to eq([:gravel, :hills])
    end
  end

  describe "#log_ride" do
    it "logs a ride with a time if the terrain is acceptable and the ride's total distance does not exceeds the Biker's max distance" do
      biker_1.learn_terrain!(:hills)
      biker_1.log_ride(ride_1, 92.5)
      biker_1.log_ride(ride_1, 91.1)
      expect(biker_1.rides).to eq({ride_1=>[92.5, 91.1]})
    end

    it "can not log a ride if terrain is not acceptabe" do
      biker_1.learn_terrain!(:hills)
      biker_1.log_ride(ride_2, 92.5)
      expect(biker_1.rides).to eq({})
    end

    it "can not log a ride if the ride's distance is greater than the Biker's max_distance" do
      biker_2.learn_terrain!(:gravel)
      biker_2.learn_terrain!(:hills)
      biker_2.log_ride(ride_1, 95.0)
      biker_2.log_ride(ride_2, 65.0)
      expect(biker_2.rides).to eq({ride_2=>[65.0]})
    end
  end

  describe "#personal_report" do
    it "returns the lowest time recorded for a specific ride" do
      biker_1.learn_terrain!(:hills)
      biker_1.log_ride(ride_1, 92.5)
      biker_1.log_ride(ride_1, 91.1)
      expect(biker_1.personal_report(ride_1)).to eq(91.1)
      expect(biker_1.personal_report(ride_2)).to eq(false)
    end
  end
end
