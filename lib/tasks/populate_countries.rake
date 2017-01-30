require 'csv'

namespace :invoicer do
  task populate_countries: :environment do
    if Currency.count == 0
      config = {
        headers: true
      }
      arr_of_arrs = CSV.read(Rails.root.join('lib/tasks/country_currency.csv'), config)

      arr_of_arrs.each do |line|
        c = Currency.new
        c.country = line['country']
        c.iso_alpha2 = line['iso_alpha2']
        c.iso_alpha3 = line['iso_alpha3']
        c.iso_numeric = line['iso_numeric']
        c.currency_name = line['currency_name']
        c.currency_code = line['currency_code']
        c.currency_symbol = line['symbol']
        c.save
      end
    end
  end
end
