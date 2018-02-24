DROP TABLE animals;
DROP TABLE locations;

CREATE TABLE locations(
  id SERIAL8 primary key,
  name VARCHAR(255) not null,
  description TEXT,
  land VARCHAR not null,
  tree_top VARCHAR not null,
  aquatic VARCHAR not null
);

CREATE TABLE animals(
  id SERIAL8 primary key,
  name VARCHAR(255),
  species VARCHAR(255) not null,
  admission_date	date not null,
  health INT2,
  location_id	INT8 REFERENCES locations(id),
  age	VARCHAR(255),
  sex VARCHAR(255),
  size VARCHAR(255),
  colour VARCHAR(255)
);
