#!/usr/bin/env puma
# The directory to operate out of.
#
# The default is the current directory.
#
directory '/opt/lls'

# Load “path” as a rackup file.
#
# The default is “config.ru”.
#
rackup '/opt/lls/config.ru'

environment 'development'

# Daemonize the server into the background. Highly suggest that
# this be combined with “pidfile” and “stdout_redirect”.
#
# The default is “false”.
#
daemonize
# daemonize false

# Store the pid of the server in the file at “path”.
#
# pidfile '/u/apps/lolcat/tmp/pids/puma.pid'
#pidfile '/var/run/lls/puma.pid'

# Use “path” as the file to store the server info state. This is
# used by “pumactl” to query and control the server.
#
# state_path '/u/apps/lolcat/tmp/pids/puma.state'
#state_path '/var/run/lls/puma.state'

# Redirect STDOUT and STDERR to files specified. The 3rd parameter
# (“append”) specifies whether the output is appended, the default is
# “false”.
#
# stdout_redirect '/u/apps/lolcat/log/stdout', '/u/apps/lolcat/log/stderr'
# stdout_redirect '/u/apps/lolcat/log/stdout', '/u/apps/lolcat/log/stderr', true

# Disable request logging.
#
# The default is “false”.
#
# quiet

# Configure “min” to be the minimum number of threads to use to answer
# requests and “max” the maximum.
#
# The default is “0, 16”.
#
# threads 0, 16
threads 3, 16

# Bind the server to “url”. “tcp://”, “unix://” and “ssl://” are the only
# accepted protocols.
#
# The default is “tcp://0.0.0.0:9292”.
#
bind 'tcp://0.0.0.0:80'
# bind 'unix:///var/run/puma.sock'
# bind 'unix:///var/run/puma.sock?umask=0777'
# bind 'ssl://127.0.0.1:9292?key=path_to_key&cert=path_to_cert'
# bind 'unix:///usr/share/rails/sandbox/tmp/sockets/puma.sock'
