module RacePartnerRegistrations
  describe Event do

    subject do
      described_class.new url
    end

    context "when initialized with a valid url" do
      let :url do
        "https://register.racepartner.com/falmouthroadrace/entrants"
      end

      it "sets and gets the url" do
        expect(subject.url).to eq url
      end

      it "is valid" do
        expect(subject).to be_valid
      end

      describe "#downloaded?" do
        context "when the @registrations is not nil" do
          before do
            subject.instance_variable_set "@registrations", []
          end
          it "is downloaded" do
            expect(subject).to be_downloaded
          end
        end
        context "when the @registrations is nil" do
          before do
            subject.instance_variable_set "@registrations", nil
          end
          it "is not downloaded" do
            expect(subject).to_not be_downloaded
          end
        end
      end

      describe "#download_registrations!" do
        it "does not raise an exception", :slow do
          expect{subject.download_registrations!}.to_not raise_error
        end
        it "sets the registrations", :slow do
          subject.download_registrations!
          expect(subject.registrations).to_not be_empty
        end
      end

      describe "#to_csv" do
        before do
          allow(subject).to receive(:download_registrations!)
          allow(subject).to receive(:registrations).and_return([Registration.new("Sean Devine", "Suffield, CT")])
        end
        it "generates the csv" do          expect(subject.to_csv).to eq "name,location\nSean Devine,\"Suffield, CT\"\n"
        end
      end
    end

    context "when initialized with an invalid url" do
      let :url do
        "https://register.racepartner.com/falmouthroadrace"
      end

      it "is not valid" do
        expect(subject).to_not be_valid
      end

      describe "#download_registrations!" do
        it "raises an exception" do
          expect{subject.download_registrations!}.to raise_error Event::InvalidUrlError
        end
      end

      describe "#registrations" do
        it "raises an exception" do
          expect{subject.registrations}.to raise_error Event::RegistrationsNotDownloadedError
        end
      end
    end

  end
end
