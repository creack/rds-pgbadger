# rds-pgbadger is a ruby app.
FROM	        ruby:2.1

# Install pgbadger itself (apt-get has v3.3 which is too old)
RUN             cd /tmp && wget https://github.com/dalibo/pgbadger/archive/v8.1.tar.gz -O - | tar xvzf - && cd pgbadger-8.1 && perl Makefile.PL && make && make install

# Set the workdir
WORKDIR		/app

# Set the default entyrpoint
ENTRYPOINT      ["/app/rds-pgbadger.rb", "-e", "production"]

# Install the gem deps.
ADD		Gemfile Gemfile.lock /app/
RUN		cd /app && bundle install

# Add the rds-pgbadger app
ADD             . /app
