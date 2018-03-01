DROP TABLE animals;
DROP TABLE locations;
DROP TABLE terrain_types;

CREATE TABLE locations(
  id SERIAL8 primary key,
  name VARCHAR(255) not null,
  description TEXT,
  Land VARCHAR not null,
  Tree_top VARCHAR not null,
  Aquatic VARCHAR not null
);

CREATE TABLE terrain_types(
  id SERIAL4 primary key,
  terrain VARCHAR
);

CREATE TABLE animals(
  id SERIAL8 primary key,
  name VARCHAR(255),
  species VARCHAR(255) not null,
  type_id INT4 REFERENCES terrain_types(id),
  admission_date	date not null,
  health INT2,
  location_id	INT8 REFERENCES locations(id),
  age	VARCHAR(255),
  sex VARCHAR(255),
  size VARCHAR(255),
  colour VARCHAR(255)
);
