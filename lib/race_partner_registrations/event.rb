module RacePartnerRegistrations
  class Event
    class InvalidUrlError < StandardError; end
    class RegistrationsNotDownloadedError < StandardError; end

    attr_reader :url

    def initialize(url)
      @url = url
    end

    def valid?
      page.search("div#EntrantSearchForm").any?
    end

    def registrations
      @registrations || raise(RegistrationsNotDownloadedError, "download_registrations! has not been sent to this event.")
    end

    def downloaded?
      !!@registrations
    end

    def download_registrations!
      raise InvalidUrlError unless valid?
      @registrations = []
      get_state_values(page).each do |state_value|
        agent.get(single_page_url(state_value)).search("div#EntrantList tr").each do |row|
          name_td, location_td = [0,1].collect { |n| row.search("td")[n] }
          next unless name_td && location_td
          @registrations << Registration.new(name_td.text.strip, location_td.text.strip)
        end
      end
      @registrations
    end

    def to_csv
      download_registrations! unless downloaded?
      CSV.generate do |csv|
        csv << ["name", "location"]
        registrations.each do |registration|
          csv << [:name, :location].collect { |attr| registration.send(attr) }
        end
      end
    end

  private

    def page
      @page ||= agent.get(url)
    end

    def agent
      @agent = Mechanize.new
    end

    def get_form(page)
      form_action = page.search("div#EntrantSearchForm form").first.attr("action")
      page.form_with(action: form_action)
    end

    def get_state_values(page)
      get_form(page).field_with(id: "state").options.collect do |state_option|
        state_option.value
      end.reject do |state_value|
        state_value.length == 0
      end
    end

    def single_page_url(state_value)
      url + "?State=#{state_value}&PageSize=#{200_000_000}&PageIndex=1&Submitted=true"
    end

  end
end
