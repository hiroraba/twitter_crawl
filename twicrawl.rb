require 'twitter'

client = Twitter::REST::Client.new do |config|
  config.consumer_key       = ''
  config.consumer_secret    = ''
  config.access_token        = ''
  config.access_token_secret = ''
end
page = 1

File.open("tweets.csv", "w") do |file|

  while 1 do
    results = client.user_timeline("hiroraba", :count => 200 ,:page => page).to_a

    exit if results.length == 0

    results.each do |tweet|
      line = "\"#{tweet.created_at}\", \"#{tweet.text.gsub(/[\r\n]/,"")}\", \"#{tweet.id}\""
      file.puts(line)
    end
    sleep 20
    page += 1
  end
  exit
end
