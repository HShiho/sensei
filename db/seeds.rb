# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create([
  { email: 'sample@sample.com', password: 'okokok' }
  ])

Tag.create([
  { name: '進捗報告'},
  { name: '振り返り'},
  { name: '目標設定' },
  { name: '最終報告' },
  { name: '雑談' }
  ])

User.create([
  { email: 'yoshino@test.ex', nickname: 'yoshino', password: 'yoshinoyoshino', icon_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_user01.jpg"), filename:"sample_user01.jpg") },
  { email: 'u-tin@test.ex', nickname: 'うーてぃん', password: 'utinutin', icon_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_user02.jpg"), filename:"sample_user02.jpg") },
  { email: 'seira@test.ex', nickname: 'セイラ', password: 'seiraseira', icon_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_user03.jpg"), filename:"sample_user03.jpg") },
  { email: 'hukusuke@test.ex', nickname: '福SK', password: 'hukusukehukusuke', icon_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_user04.jpg"), filename:"sample_user04.jpg") },
  { email: 'sumi@test.ex', nickname: '須見', password: 'sumisumisumi', icon_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_user05.jpg"), filename:"sample_user05.jpg") },
  ])