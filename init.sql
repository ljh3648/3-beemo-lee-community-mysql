-- ============================================================================
-- Community Database Initialization Script
-- ============================================================================

-- Create database
CREATE DATABASE IF NOT EXISTS community DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE community;

-- ============================================================================
-- Users Table
-- ============================================================================
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nickname VARCHAR(10) NOT NULL UNIQUE,
  email VARCHAR(320) NOT NULL UNIQUE,
  password VARCHAR(60) NOT NULL,
  profile_url VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_nickname (nickname),
  INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- Posts Table
-- ============================================================================
CREATE TABLE IF NOT EXISTS posts (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(12) NOT NULL,
  body LONGTEXT NOT NULL,
  image_url VARCHAR(255),
  views_cnt INT DEFAULT 0,
  likes_cnt INT DEFAULT 0,
  comment_cnt INT DEFAULT 0,
  user_id INT NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  INDEX idx_user_id (user_id),
  INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- Comments Table
-- ============================================================================
CREATE TABLE IF NOT EXISTS comments (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  body VARCHAR(255) NOT NULL,
  user_id INT NOT NULL,
  post_id BIGINT NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
  INDEX idx_user_id (user_id),
  INDEX idx_post_id (post_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- Likes Table
-- ============================================================================
CREATE TABLE IF NOT EXISTS likes (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  post_id BIGINT NOT NULL,
  created_at DATETIME NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
  UNIQUE KEY unique_user_post (user_id, post_id),
  INDEX idx_user_id (user_id),
  INDEX idx_post_id (post_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- Images Table
-- ============================================================================
CREATE TABLE IF NOT EXISTS images (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  image_url VARCHAR(255) NOT NULL,
  user_id INT NOT NULL,
  created_at DATETIME NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  INDEX idx_user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- Refresh Tokens Table
-- ============================================================================
CREATE TABLE IF NOT EXISTS refresh_tokens (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  token VARCHAR(500) NOT NULL UNIQUE,
  user_id INT NOT NULL,
  expires_at DATETIME NOT NULL,
  created_at DATETIME NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  INDEX idx_user_id (user_id),
  INDEX idx_token (token)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- Sessions Table
-- ============================================================================
CREATE TABLE IF NOT EXISTS sessions (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  session_id VARCHAR(255) NOT NULL UNIQUE,
  user_id INT NOT NULL,
  expires_at DATETIME NOT NULL,
  created_at DATETIME NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  INDEX idx_user_id (user_id),
  INDEX idx_session_id (session_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
