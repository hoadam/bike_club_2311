require './lib/ride'
require './lib/biker'
require './lib/bike_club'

RSpec.describe BikeClub do
  let(:club) { BikeClub.new("Mountain Bike")}
  let(:ride_1) { Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills}) }
  let(:ride_2) { Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel}) }
  let(:biker_1) { Biker.new("Kenny", 30) }
  let(:biker_2) { Biker.new("Athena", 15) }

  describe "#initialize" do
    it "can initialize" do
      expect(club.name).to eq("Mountain Bike")
      expect(club.bikers).to eq([])
    end
  end

  describe "#add-biker" do
    it "adds a biker" do
      club.add_biker(biker_1)
      club.add_biker(biker_2)

      expect(club.bikers).to eq([biker_1,biker_2])
    end
  end

  describe "#most_rides" do
    it "returns biker who has logged the most rides" do
      club.add_biker(biker_1)
      club.add_biker(biker_2)
      biker_1.learn_terrain!(:gravel)
      biker_1.learn_terrain!(:hills)
      biker_2.learn_terrain!(:gravel)
      biker_2.log_ride(ride_2, 65.0)
      biker_1.log_ride(ride_1, 92.5)
      biker_1.log_ride(ride_1, 91.1)

      expect(club.most_rides).to eq(biker_1)
    end
  end

  describe "#best_time" do
    it "returns biker who has the best time for a given ride" do
      club.add_biker(biker_1)
      club.add_biker(biker_2)
      biker_1.learn_terrain!(:gravel)
      biker_2.learn_terrain!(:gravel)
      biker_2.log_ride(ride_2, 65.0)
      biker_1.log_ride(ride_2, 59.1)

      expect(club.best_time(ride_2)).to eq(biker_1)
    end
  end

  describe "#biker_eligible" do
    it "returns an array of bikers who are eligible for a given ride" do
      club.add_biker(biker_1)
      club.add_biker(biker_2)
      biker_1.learn_terrain!(:gravel)
      biker_1.learn_terrain!(:hills)
      biker_2.learn_terrain!(:gravel)
      biker_2.learn_terrain!(:hills)

      expect(club.biker_eligible(ride_1)).to eq([biker_1])
      expect(club.biker_eligible(ride_2)).to eq([biker_1, biker_2])
    end
  end

  describe "#record_group_ride" do
    it "records a group ride with ride time for eligible bikers in a given ride" do
      club.add_biker(biker_1)
      club.add_biker(biker_2)
      biker_1.learn_terrain!(:gravel)
      biker_2.learn_terrain!(:gravel)
      start_time = Time.new(2024,1,16,8,0,0)
      allow(Time).to receive(:now).and_return(start_time)
      finish_time_biker2 = allow(Time).to receive(:now).and_return(start_time + 95.minutes)
      finish_time_biker1 = allow(Time).to receive(:now).and_return(start_time + 90.minutes)
      club.record_group_ride(ride_2)

      expect(biker_1.rides[ride_2]).to eq(90)
      expect(biker_2.rides[ride_2]).to eq(95)
    end
  end
end
