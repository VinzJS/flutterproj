CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    detail_text VARCHAR(255),
    price DECIMAL(10, 2) NOT NULL,
    seller_name VARCHAR(255),
    star_rating DECIMAL(2, 1),
    description TEXT,
    image_paths TEXT
);
INSERT INTO products (name, detail_text, price, seller_name, star_rating, description, image_paths) VALUES
('Nike Air Max 97', 'Size 10 | Men\'s Shoe', 5999, 'Franklin Doledo', 4.5, 'Brand New with box. Willing to deliver via Maxim', '["assets/nike1_1.png", "assets/nike1_2.png", "assets/nike1_3.png", "assets/nike1_4.png"]'),
('Air Jordan 1 Low "Travis Scott x Fragment"', 'Size 11 | Men\'s Shoe', 7999, 'Vinz Jude', 4.8, 'Description for product 2', '["assets/nike2_1.png", "assets/nike2_2.png", "assets/nike2_3.png", "assets/nike2_4.png"]');
