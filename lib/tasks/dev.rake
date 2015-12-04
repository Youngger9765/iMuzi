namespace :dev do

  task :rebuild =>["db:drop", "db:create", "db:migrate", :faker]

  task :faker => :environment do
    puts "產生假資料"
    20.times do |u|
      name  = Faker::Name.name
      email = "test#{u}@gmail.com"
      nickname = "nickname#{u}"
      password = "password"
      about = "hi 你好，我是#{name}，歡迎來到我的個人頁面"
      u = User.create!( name: name,
                    email: email,
                    nickname: nickname,
                    about: about,
                    password:              password,
                    password_confirmation: password
                    )
      5.times do
      name  = Faker::Name.name
      singer = Faker::Name.name
      link = "v4yHXWvIMqM"
      introduction = "test"
      u.songs.create!(  name: name,
                        singer: singer,
                        link: link,
                        introduction: introduction,
                    )
    end
  end



  end


end