-- Create database
CREATE DATABASE IF NOT EXISTS hotel_db;
USE hotel_db;

-- Users table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Hotels table
CREATE TABLE hotels (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    location VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    image VARCHAR(500) DEFAULT NULL,
    rating DECIMAL(3,2) DEFAULT 0,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bookings table
CREATE TABLE bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    hotel_id INT NOT NULL,
    checkin DATE NOT NULL,
    checkout DATE NOT NULL,
    guests INT DEFAULT 1,
    room_type VARCHAR(50) DEFAULT 'standard',
    requests TEXT,
    status ENUM('pending', 'confirmed', 'cancelled') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (hotel_id) REFERENCES hotels(id)
);

-- Sample data
INSERT INTO users (name, email, password) VALUES 
('John Doe', 'john@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi');

INSERT INTO hotels (name, location, price, image, rating) VALUES
('Grand Palace Hotel', 'New York, USA', 299, 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=400&h=220&fit=crop', 4.8),
('Ocean View Resort', 'Miami, USA', 199, 'https://images.unsplash.com/photo-1582719508461-905c673771fd?w=400&h=220&fit=crop', 4.6),
('Mountain Retreat', 'Denver, USA', 159, 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=400&h=220&fit=crop', 4.7),
('Sunset Paradise', 'California, USA', 349, 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400&h=220&fit=crop', 4.9),
('City Lights Hotel', 'Chicago, USA', 219, 'https://images.unsplash.com/photo-1519167758481-83f550bb49b3?w=400&h=220&fit=crop', 4.5),
('Royal Garden Inn', 'Boston, USA', 279, 'https://images.unsplash.com/photo-1540541338287-41700207dee6?w=400&h=220&fit=crop', 4.7);

INSERT INTO bookings (user_id, hotel_id, checkin, checkout, guests, room_type, status) VALUES
(1, 1, '2026-07-15', '2026-07-20', 2, 'deluxe', 'confirmed'),
(1, 2, '2026-08-01', '2026-08-05', 3, 'standard', 'pending'),
(1, 3, '2026-06-10', '2026-06-12', 1, 'suite', 'confirmed'),
(1, 4, '2026-05-20', '2026-05-25', 2, 'deluxe', 'cancelled');