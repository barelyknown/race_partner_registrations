# Race Partner Registrations

[Race Partner](http://www.racepartner.com) is a platform for registration, volunteer management, and marketing for road races and other endurance events.

[racepartner.com](http://www.racepartner.com) enables users to browse the the registrations for a given event.

`race_partner_registrations` enables you to extract the registration list for a given event.

![Race Partner Entrance List Screen Shot](./assets/images/entrance_list.jpg?raw=true)

## Usage

### Capabilities
`race_partner_registrations` is able to extract `name` and `location` from Race Partner's Entrant List.

### Examples

```bash
$ gem install race_partner_registrations
$ irb
> require 'race_partner_registrations'
> url = "https://register.racepartner.com/falmouthroadrace/entrants"
> event = RacePartnerRegistrations::Event.new(url)
```

An event can be converted to a CSV.
```
> puts event.to_csv
name,location
Sean Devine, "Suffield, CT"
```

You can also download the registrations and iterate through the registrations directly.

```bash
irb> registration = event.registrations.first
irb> registration.name
=> "Sean Devine"
irb> registration.location
=> "Suffield, CT"
```
