# product_catalog
Simple E-Commerce Product Catalog

 Requirements
PHP 8.1+
Backend: PHP Laravel ( version 10)
frontend framework (Vue.js,Inertia)
Composer

Node.js & npm

MySQL or another supported database

🚀 Installation Steps
# 1. Clone the repository
git clone https://github.com/your-username/your-project.git
cd your-project

# 2. Install PHP dependencies
composer install

# 3. Copy and configure environment file
cp .env.example .env

# 4. Generate application key
php artisan key:generate

# 5. Set your database credentials in .env file 
# DB_DATABASE=your_db
# DB_USERNAME=your_user
# DB_PASSWORD=your_pass

# 6. Import database or Run migrations and seeders
php artisan migrate --seed

# 7. Create storage symbolic link (for file uploads)
php artisan storage:link

# 8. Install frontend dependencies
npm install

# 9. Build frontend assets
npm run dev

# 10. Start the Laravel server
php artisan serve



👤 Admin Login Credentials
Email: testadmin@gmail.com
Password: chalindu
