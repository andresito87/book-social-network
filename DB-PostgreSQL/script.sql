create table if not exists _user
(
    id                 integer      not null
        primary key,
    account_locked     boolean      not null,
    created_date       timestamp(6) not null,
    date_of_birth      date,
    email              varchar(255)
        constraint ukk11y3pdtsrjgy8w9b6q4bjwrx
            unique,
    enabled            boolean      not null,
    firstname          varchar(255),
    last_modified_date timestamp(6),
    lastname           varchar(255),
    password           varchar(255)
);

alter table _user
    owner to username;

create table if not exists book
(
    id                 integer      not null
        primary key,
    created_by         integer      not null,
    created_date       timestamp(6) not null,
    last_modified_by   integer,
    last_modified_date timestamp(6),
    archived           boolean      not null,
    author_name        varchar(255),
    book_cover         varchar(255),
    isbn               varchar(255),
    shareable          boolean      not null,
    synopsis           varchar(255),
    title              varchar(255),
    owner_id           integer
        constraint fk61m8am98w4y4vgpl82sojy8bh
            references _user
);

alter table book
    owner to username;

create table if not exists book_transaction_history
(
    id                 integer      not null
        primary key,
    created_by         integer      not null,
    created_date       timestamp(6) not null,
    last_modified_by   integer,
    last_modified_date timestamp(6),
    return_approved    boolean      not null,
    returned           boolean      not null,
    book_id            integer
        constraint fketks95hi6ay47e16sj6vdv9g9
            references book,
    user_id            integer
        constraint fkh081geal7xoydl9vyh7cbf4wc
            references _user
);

alter table book_transaction_history
    owner to username;

create table if not exists feedback
(
    id                 integer      not null
        primary key,
    created_by         integer      not null,
    created_date       timestamp(6) not null,
    last_modified_by   integer,
    last_modified_date timestamp(6),
    comment            varchar(255),
    note               double precision,
    book_id            integer
        constraint fkgclyi456gw0lcd6xcfj2l7r6s
            references book
);

alter table feedback
    owner to username;

create table if not exists role
(
    id                 integer      not null
        primary key,
    created_date       timestamp(6) not null,
    last_modified_date date,
    name               varchar(255)
        constraint uk8sewwnpamngi6b1dwaa88askk
            unique
);

alter table role
    owner to username;

create table if not exists _user_roles
(
    users_id integer not null
        constraint fkkna43mk14wb08rt62w1982ki6
            references _user,
    roles_id integer not null
        constraint fktq7v0vo9kka3qeaw2alou2j8p
            references role
);

alter table _user_roles
    owner to username;

create table if not exists token
(
    id           integer not null
        primary key,
    created_at   timestamp(6),
    expires_at   timestamp(6),
    token        varchar(255),
    validated_at timestamp(6),
    user_id      integer not null
        constraint fkiblu4cjwvyntq3ugo31klp1c6
            references _user
);

alter table token
    owner to username;

INSERT INTO _user (id, account_locked, created_date, date_of_birth, email, enabled, firstname, last_modified_date,
                   lastname, password)
VALUES
    (1, false, '2024-08-14', '1990-01-01', 'user1@example.com', true, 'John', '2024-08-14', 'Doe', 'hashed_password_1'),
    (2, false, '2024-08-14', '1985-05-05', 'user2@example.com', true, 'Jane', '2024-08-14', 'Smith', 'hashed_password_2'),
    (3, false, '2024-08-14', '1978-12-12', 'user3@example.com', true, 'Alice', '2024-08-14', 'Johnson', 'hashed_password_3'),
    (4, false, '2024-08-14', '1995-03-03', 'prueba@gmail.com', true, 'Prueba', '2024-08-14', 'Prueba', 'prueba');
INSERT INTO book (id, created_by, created_date, last_modified_by, last_modified_date, archived, author_name, book_cover,
                  isbn, shareable, synopsis, title, owner_id)
VALUES
    (1, 1, '2024-08-14', 1, '2024-08-14', false, 'Author 1', 'cover_url_1', '111-1-1111-1111-1', true, 'Synopsis of book 1', 'Book Title 1', 1),
    (2, 1, '2024-08-14', 1, '2024-08-14', false, 'Author 2', 'cover_url_2', '222-2-2222-2222-2', true, 'Synopsis of book 2', 'Book Title 2', 1),
    (3, 1, '2024-08-14', 1, '2024-08-14', false, 'Author 3', 'cover_url_3', '333-3-3333-3333-3', true, 'Synopsis of book 3', 'Book Title 3', 1),
    (4, 2, '2024-08-14', 2, '2024-08-14', false, 'Author 4', 'cover_url_4', '444-4-4444-4444-4', true, 'Synopsis of book 4', 'Book Title 4', 2),
    (5, 2, '2024-08-14', 2, '2024-08-14', false, 'Author 5', 'cover_url_5', '555-5-5555-5555-5', true, 'Synopsis of book 5', 'Book Title 5', 2),
    (6, 2, '2024-08-14', 2, '2024-08-14', false, 'Author 6', 'cover_url_6', '666-6-6666-6666-6', true, 'Synopsis of book 6', 'Book Title 6', 2),
    (7, 3, '2024-08-14', 3, '2024-08-14', false, 'Author 7', 'cover_url_7', '777-7-7777-7777-7', true, 'Synopsis of book 7', 'Book Title 7', 3),
    (8, 3, '2024-08-14', 3, '2024-08-14', false, 'Author 8', 'cover_url_8', '888-8-8888-8888-8', true, 'Synopsis of book 8', 'Book Title 8', 3),
    (9, 3, '2024-08-14', 3, '2024-08-14', false, 'Author 9', 'cover_url_9', '999-9-9999-9999-9', true, 'Synopsis of book 9', 'Book Title 9', 3),
    (10, 1, '2024-08-14', 1, '2024-08-14', false, 'Author 10', 'cover_url_10', '101-0-1010-1010-0', true, 'Synopsis of book 10', 'Book Title 10', 1);
