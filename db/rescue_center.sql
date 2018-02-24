DROP TABLE animals;
DROP TABLE locations;

CREATE TABLE locations(
  id SERIAL8 primary key,
  name VARCHAR(255) not null
  -- land boolean,
  -- tree_top boolean,
  -- aquatic boolean
);

CREATE TABLE animals(
  id SERIAL8 primary key,
  name VARCHAR(255),
  species VARCHAR(255) not null,
  admission_date	date not null,
  progress INT2,
  location_id	INT8 REFERENCES locations(id)
  -- age			INT2
  -- sex			VARCHAR(255)
  -- size			VARCHAR(255)
  -- colour		VARCHAR(255)
);
