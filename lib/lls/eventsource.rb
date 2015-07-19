module Lls
  class EventSource

    def initialize(db)
      @db = db
    end

    def call(env)
      if Faye::EventSource.eventsource?(env)
        request = Rack::Request.new(env)

        start_time = Time.now

        es   = Faye::EventSource.new(env)
        time = es.last_event_id.to_i

        p [:open, es.url, es.last_event_id]

        loop = EM.add_periodic_timer(2) do
          time += 1
          es.send("Time: #{time}")
          EM.add_timer(1) do
            es.send('Update!!', :event => 'update', :id => time) if es
          end
        end

        es.send("Welcome!\n\nThis is an EventSource server.")

        es.onclose = lambda do |event|
          EM.cancel_timer(loop)
          duration = (Time.now - start_time).to_i
          p [:close, es.url, duration]
          es = nil
        end

        es.rack_response
      else
        [404, {}, []]
      end
    end

  end
end
