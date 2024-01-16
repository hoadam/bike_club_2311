require './lib/ride'

RSpec.describe Ride do
  let(:ride_1) { Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills}) }
  let(:ride_2) { Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel}) }

  describe "#initialize" do
    it "can initialize" do
      expect(ride_1.name).to eq("Walnut Creek Trail")
      expect(ride_1.distance).to eq(10.7)
      expect(ride_1.loop).to eq(false)
      expect(ride_1.terrain).to eq(:hills)
    end
  end

  describe "#loop?" do
    it "returns true if the ride has a loop" do
      expect(ride_2.loop?).to eq(true)
    end

    it "returns false if the ride has no loop" do
      expect(ride_1.loop?).to eq(false)
    end
  end

  describe "total_distance" do
    it "calculate the total distance of the ride" do
      expect(ride_1.total_distance).to eq(21.4)
      expect(ride_2.total_distance).to eq(14.9)
    end
  end
end
