module RacePartnerRegistrations
  describe Registration do

    let :name do
      "Sean Devine"
    end

    let :location do
      "Suffield, CT"
    end

    context "when initialized with the name and location" do
      subject do
        described_class.new name, location
      end
      it "sets and gets the name" do
        expect(subject.name).to eq name
      end
      it "sets and get the location" do
        expect(subject.location).to eq location
      end
      describe "#state" do
        [
          ["Suffield, CT", "CT"],
          ["Voorheesville, ny", "NY"]
        ].each do |l, s|
          context "when the location is #{l}" do
            let(:location) { l }
            let(:state) { s }
            subject do
              described_class.new name, location
            end
            it "extracts the state #{s}" do
              expect(subject.state).to eq state
            end
          end
        end
      end
    end

    context "when initialized without a name and location" do
      it "raises an ArgumentError" do
        expect{described_class.new}.to raise_error ArgumentError
      end
    end

  end
end
