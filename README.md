# Capistrano Simple Formatter

Simple formatter for Capistrano 3.

## Installation

With bundler:

```ruby
gem 'capistrano-simple-formatter'
```

or without bundler:

```ruby
$ gem install capistrano-simple-formatter

require 'capistrano-simple-formatter'
```

## Usage

Set the Capistrano `format` to `:simple`:

```ruby
# deploy.rb

set :format, :simple
```

Then, within any `task` block you can access the formatter through `SSHKit.config.output`, or just `output` within an `on` block.

### Examples

Hook into Capistrano callbacks:

```ruby
before('deploy:restart', :log_before_deploy_restart) do
  SSHKit.config.output.start("Restarting apps")
end

after('deploy:restart', :log_after_deploy_restart) do
  SSHKit.config.output.success
end
```

Log on your tasks:

```ruby
task(:link_files) do
  on roles(:app) do
    output.start "Linking files in #{host}"
    # Do your work

    if success
      output.success
    else
      output.error 'Something went wrong :('
    end
  end
end
```

Log nested:

```ruby
namespace(:delayed_jobs) do
  task(:status) do
    SSHKit.config.output.start("Checking delayed_job status...") do
      on roles(:apps), in: :parallel do
        status = run_delayed_job_command(:status) # Your magic

        if status.match(/delayed_job: no instances running/)
          output.error "Not running in #{host}"
        elsif matches = status.match(/delayed_job: running \[pid (?<pid>\d+)\]/)
          output.success "Running in #{host} with pid #{matches[:pid]}"
        else
          output.info status
        end
      end
    end
  end
end
```

## TODO
* Output samples
* Examples file
* Specs
