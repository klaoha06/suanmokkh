# Set path to application
app_dir = File.expand_path("../..", __FILE__)
working_directory app_dir


# Set unicorn options
worker_processes 3
preload_app true
timeout 30

# Set up socket location
listen "/var/run/unicorn.sock", :backlog => 64

# Logging
stderr_path "/var/log/unicorn.stderr.log"
stdout_path "/var/log/unicorn.stdout.log"

# Set master PID location
pid "/var/run/unicorn.pid"
