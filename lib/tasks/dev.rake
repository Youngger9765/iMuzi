namespace :dev do

  task :rebuild =>["db:drop", "db:create", "db:migrate", :faker]

  task :faker => :environment do
    puts "產生假資料"
    10.times do |u|
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
      u.build_profile
      u.profile.username = u.name || u.email
      u.profile.role = "normal"
      u.save
      2.times do
      name  = Faker::Name.name
      singer = Faker::Name.name
      link = "v4yHXWvIMqM"
      introduction = "Lorem ipsum dolor sit amet,
                      consectetur adipisicing elit.
                      Distinctio sint unde soluta,
                      sapiente sequi amet neque. Mag
                      nam, sit commodi, aperiam, dig
                      nissimos reprehenderit molesti
                      as facilis, ut dolorem ipsam i
                      ure natus officia."
      if u.id%2 ==0
        use = "study"
        if u.id%3 ==0
          teacher = "小龍老師"
        else
          teacher = "小久老師"
        end
      else
        use = "battle"
      end
      u.songs.create!(  name: name,
                        singer: singer,
                        link: link,
                        introduction: introduction,
                        use: use,
                        teacher_choice: teacher,
                    )
    end
  end



  end


end