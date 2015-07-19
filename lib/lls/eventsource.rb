module Lls
  class EventSource

    def initialize(app)
      @app = app
    end

    def call(env)
      if Faye::WebSocket.websocket?(env)
        ws_response(env)
      else
        [404, {}, []]
      end
    end

    def ws_response(env)
      session = env["rack.session"]
      start_time = Time.now

      set_online(session)

      ws = Faye::WebSocket.new(env)

      ws.onclose = lambda do |event|
        duration = (Time.now - start_time).to_i
        update_online_time(session, duration)
        set_offline(session)
        ws = nil
      end

      ws.rack_response
    end

    def set_online(session)
      if sid = session[:session_id]
        user_id = session[:user_id]
        if user_id != 0
          @app.set_online(user_id, "user")
        else
          @app.set_online(sid, "visitor")
        end
      end
    end

    def set_offline(session)
      if sid = session[:session_id]
        user_id = session[:user_id]
        if user_id != 0
          @app.set_offline(user_id)
        else
          @app.set_offline(sid)
        end
      end
    end

    def update_online_time(session, duration)
      if sid = session[:session_id]
        user_id = session[:user_id]
        if user_id != 0
          @app.update_online_time(user_id, duration)
        else
          @app.update_online_time(sid, duration)
        end
      end
    end

  end
end
