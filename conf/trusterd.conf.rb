SERVER_DESCRIPTION = "Trusterd"

s = HTTP2::Server.new({
  :port           => 80,
  :server_name    => SERVER_DESCRIPTION,
  :document_root  => "/trusterd-htdocs",
  :worker         => "auto",
  :run_user       => "trusterd",

  # listen ip address
  # default value is 0.0.0.0
  # :server_host  => "127.0.0.1",

  # debug default: false
  # :debug  =>  true,

  # tls default: true
  :tls => false,
  #:key            => "/ssl/server.key",
  #:crt            => "/ssl/server.crt",
  #:dh_params_file => "/ssl/dh.pem",

  # daemon default: false
  # :daemon => true,

  # callback default: false
  :callback => true,

  # connection_record defualt: true
  # :connection_record => false,
})

#
# when :callback option is true,
#
# s.set_map_to_strage_cb {
#
#   p "callback bloack at set_map_to_strage_cb"
#   p s.request.uri
#   p s.request.filename
#
#   # location setting
#   if s.request.uri == "/index.html"
#     s.request.filename = "#{root_dir}/htdocs/hoge"
#   end
#   p s.request.filename
#
#   # you can use regexp if you link regexp mrbgem.
#   # Or, you can use KVS like mruby-redis or mruby-
#   # vedis and so on.
#
#   # Experiment: reverse proxy config
#   # reciev front end with HTTP/2 and proxy upstream server with HTTP/1
#   # TODO: reciev/send headers transparently and support HTTP/2 at upstream
#
#   if s.request.uri =~ /^\/upstream(\/.*)/
#     s.upstream_uri = $1
#     s.upstream = “http://127.0.0.1“
#   end
#
#   # dynamic content with mruby
#   if s.request.filename =~ /^.*\.rb$/
#     s.enable_mruby
#   end
#
#   # dynamic content with mruby sharing mrb_state
#   if s.request.filename =~ /^.*\_shared.rb$/
#     s.enable_shared_mruby
#   end

#
#
# }

# s.set_content_cb {
#   s.rputs "hello trusterd world from cb"
#   s.echo "+ hello trusterd world from cb with \n"
# }

# write access log
f = File.open "/trusterd-logs/access.log", "a"
s.set_logging_cb {
  f.write "#{s.conn.client_ip} #{Time.now} - #{s.r.uri} - #{s.r.filename}\n"
}

s.run

