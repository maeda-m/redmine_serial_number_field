#!/bin/bash

DATABASE_CONF=/redmine/config/database.yml
if [ ${DATABASE_TYPE} = "mysql" ]; then
  cat <<-EOF > ${DATABASE_CONF}
default: &default
  adapter: mysql2
  database: redmine
  host: ${DATABASE_HOST}
  username: root
  password:
  # Use "utf8" instead of "utfmb4" for MySQL prior to 5.7.7
  encoding: utf8mb4
EOF
else
  cat <<-EOF > ${DATABASE_CONF}
default: &default
  adapter: postgresql
  database: redmine
  host: ${DATABASE_HOST}
  username: redmine
  encoding: utf8
EOF
fi

cat <<-EOF >> ${DATABASE_CONF}
development:
  <<: *default
test:
  <<: *default
EOF

bundle install
# rails db:migrate
# rails server --binding=0.0.0.0 --port=3000

exec "$@"
