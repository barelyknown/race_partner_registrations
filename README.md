# Race Partner Registrations

[Race Partner](http://www.racepartner.com) is a platform for registration, volunteer management, and marketing for road races and other endurance events.

[racepartner.com](http://www.racepartner.com) enables users to browse the registrations for a given event.

![Race Partner Entrance List Screen Shot](./assets/images/entrance_list.jpg?raw=true)

`race_partner_registrations` enables you to extract these registration lists.

## Usage

The `name` and `location` are extracted from the entrance list.

### Examples

```bash
$ gem install race_partner_registrations
$ irb
irb> require 'race_partner_registrations'
irb> url = "https://register.racepartner.com/falmouthroadrace/entrants"
irb> event = RacePartnerRegistrations::Event.new(url)
```

An event can be converted to a CSV.
```
irb> puts event.to_csv
name,location
Sean Devine,"Suffield, CT"
```

You can also download the registrations and iterate through them directly.

```bash
irb> event.download_registrations!
irb> registration = event.registrations.first
irb> registration.name
=> "Sean Devine"
irb> registration.location
=> "Suffield, CT"
```
