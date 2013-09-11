task :get_tor do

  # http://dan.me.uk/ only lets us download his list once every hour

  system("wget -q https://dan.me.uk/torlist/ -O #{Rails.root}/db/tor.db")
end

