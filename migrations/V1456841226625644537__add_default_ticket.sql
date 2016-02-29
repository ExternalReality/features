INSERT INTO client (name) VALUES
    ('Client A'),
    ('Client B'),
    ('Client C');

INSERT INTO productArea (name) VALUES
    ('Policies'),
    ('Billing'),
    ('Claims'),
    ('Reports');

INSERT INTO ticket (title, description, client, priority, targetDate, productArea)
VALUES ('Welcome Ticket',
        'Your very first ticket',
        'Client A',
        '1',
        (SELECT CURRENT_DATE),
        'Billing'
        );

