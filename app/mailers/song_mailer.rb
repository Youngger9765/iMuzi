class SongMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.song_mailer.notify_song.subject
  #

  def notify_song
      mail(:to => "purpleice9765@msn.com", :subject => "iMuzi New Song Upload")
  end

end
