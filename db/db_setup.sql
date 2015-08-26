-- CREATE USER ubuntu -- This is useful on cloud 9

CREATE DATABASE gignado_development;
CREATE DATABASE gignado_test;

GRANT ALL ON DATABASE gignado_development TO ubuntu;
GRANT ALL ON DATABASE gignado_test TO ubuntu;
