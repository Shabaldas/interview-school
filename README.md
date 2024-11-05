# Interview School Team Rails Project

**Live Application**: [https://interview-school.onrender.com/](https://interview-school.onrender.com/)


### Requirements

#### For macOS Users
We recommend using `rbenv` to manage Ruby versions.

- **Ruby**: 3.2.2
- **Bundler**: Install with `gem install bundler`
- **Node.js**: Version 18.0 or higher - Install via Homebrew: `brew install node@18`
- **Yarn**: Version 1.22.19 or higher - Install via Homebrew: `brew install yarn` or [Install Yarn](https://yarnpkg.com/en/docs/install)
- **PostgreSQL**: Install via Homebrew: `brew install postgresql`

### Setup

1. **Clone the Repository**:
    ```bash
    git clone git@github.com:Shabaldas/interview-school.git
    cd interview-school
    ```

2. **Environment Setup**:
    Create a `.env` file in the root directory and add your PostgreSQL credentials:

    ```makefile
    POSTGRES_USER=<your_postgres_username>
    POSTGRES_PASSWORD=<your_postgres_password>
    ```

3. **Install Dependencies**:
    ```bash
    bundle install
    yarn install
    ```

4. **Database Setup**:
    ```bash
    rails db:create
    rails db:migrate
    rails db:seed
    ```

### Running the Application Locally

To run the application locally, you need to start the following processes:

1. **Rails Server**:
    ```bash
    bin/rails server -p 3000
    ```
    Access the server at `http://localhost:3000`.

2. **CSS and JavaScript Watchers**:
    - **CSS Watcher**:
        ```bash
        yarn build:css --watch
        ```
    - **JavaScript Watcher**:
        ```bash
        yarn build --reload
        ```

Alternatively, you can use **Foreman** to start all processes at once:
```bash
foreman start
