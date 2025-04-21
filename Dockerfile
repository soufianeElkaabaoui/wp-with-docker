# Use the official WordPress image as base
FROM wordpress:latest

# Install required libraries and PHP extensions
RUN apt-get update && \
    apt-get install -y \
      libfreetype6-dev \
      libjpeg-dev \
      libpng-dev \
      zlib1g-dev \
      pkg-config && \
    docker-php-ext-configure gd \
      --with-freetype \
      --with-jpeg && \
    docker-php-ext-install -j$(nproc) gd mysqli && \
    curl -sS https://getcomposer.org/installer | php \
      -- --install-dir=/usr/local/bin \
      --filename=composer && \
    rm -rf /var/lib/apt/lists/*

# Ensure files added by host keep correct permissions
RUN chown -R www-data:www-data /var/www/html
