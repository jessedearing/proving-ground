#redis:  redis-server ./config/redis.conf
#worker: bundle exec rake resque:work QUEUE='*'
#sphinx: bundle exec rake ts:run_in_foreground
web: unicorn -E development -c ./config/unicorn.rb -l 3000
