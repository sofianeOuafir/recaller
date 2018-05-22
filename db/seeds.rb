# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
unless Rails.env.test?
  MediaType.delete_all
  MediaType.create!(name:'Book')
  MediaType.create!(name:'Music')
  MediaType.create!(name:'Movie')
  MediaType.create!(name:'Course')

  Language.delete_all
  Language.create!(name: 'French', code:'fr')
  Language.create!(name: 'English', code:'gb')
  Language.create!(name: 'Italian', code:'it')
  Language.create!(name: 'Spanish', code:'es')
  Language.create!(name: 'German', code:'al')
end
