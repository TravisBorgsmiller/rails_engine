require 'csv'

desc "Import data from csv file"
task :import => [:environment] do
  Transaction.destroy_all
  InvoiceItem.destroy_all
  Item.destroy_all
  Invoice.destroy_all
  Customer.destroy_all
  Merchant.destroy_all

  file = File.read('./db/customers.csv')
  csv = CSV.parse(file, :headers => true)
  csv.each { |row| Customer.create(row.to_hash) }
  puts 'seeded customers'

  file = File.read('./db/merchants.csv')
  csv = CSV.parse(file, :headers => true)
  csv.each { |row| Merchant.create(row.to_hash) }
  puts 'seeded merchants'

  file = File.read('./db/items.csv')
  csv = CSV.parse(file, :headers => true)
  csv.each { |row| Item.create(row.to_hash) }
  puts 'seeded items'

  file = File.read('./db/invoices.csv')
  csv = CSV.parse(file, :headers => true)
  csv.each { |row| Invoice.create(row.to_hash) }
  puts 'seeded invoices'

  file = File.read('./db/invoice_items.csv')
  csv = CSV.parse(file, :headers => true)
  csv.each { |row| InvoiceItem.create(row.to_hash) }
  puts 'seeded invoice items'

  file = File.read('./db/transactions.csv')
  csv = CSV.parse(file, :headers => true)
  csv.each { |row| Transaction.create(row.to_hash) }
  puts 'seeded transactions'

  ActiveRecord::Base.connection.tables.each do |t|
    ActiveRecord::Base.connection.reset_pk_sequence!(t)
  end
end
