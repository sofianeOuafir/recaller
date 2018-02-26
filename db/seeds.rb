# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
MediaType.delete_all
MediaType.create!(name:'Livre')
MediaType.create!(name:'Musique')
MediaType.create!(name:'Film')
MediaType.create!(name:'Cours')

Language.delete_all
Language.create!(name: 'Français', code:'fr')
Language.create!(name: 'Anglais', code:'gb')
Language.create!(name: 'Italien', code:'it')
Language.create!(name: 'Espagnole', code:'es')
Language.create!(name: 'Allemand', code:'al')
