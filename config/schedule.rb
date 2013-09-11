every :day, :at => "1:30 am" do

  # http://dan.me.uk/ only lets us download his list once every hour

  command "script/get_tor_ips"
end

