CREATE TABLE client(
  id SERIAL NOT NULL,
  name text NOT NULL UNIQUE
);

CREATE TABLE productArea(
  id SERIAL NOT NULL,
  name text NOT NULL UNIQUE
);

CREATE TABLE ticket(
  id SERIAL NOT NULL,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  client TEXT NOT NULL REFERENCES client(name),
  priority INT NOT NULL,
  targetDate date NOT NULL,
  ticketURL text,
  productArea TEXT NOT NULL REFERENCES productArea(name)
);

CREATE UNIQUE INDEX ticket_priority_contraint ON ticket (client, priority)
