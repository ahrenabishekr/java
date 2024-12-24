name: Docker Image CI/CD

on:
  push:
    branches: [ "main" ]

jobs:
  build-and-push:
    runs-on: ubuntu-latest

    steps:
      # Step 1: Check out the repository
      - name: Check out the code
        uses: actions/checkout@v4

      # Step 2: Set up Python
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.9'  # Adjust to your Python version

      # Step 3: Install dependencies
      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install pytest

      # Step 4: Run the tests using pytest
      - name: Run tests with pytest
        run: pytest test.py


      # Step 5: Log in to Docker Hub
      - name: Log in to Docker Hub
        uses: docker/login-action@v2
        with:
          username: "dharanijashu"
          password: "Journal@25"

      # Step 6: Build the Docker image
      - name: Build the Docker image
        run: docker build . --file Dockerfile --tag dharanijashu/myimages:latest

      # Step 7: Push the Docker image to Docker Hub
      - name: Push the Docker image
        run: docker push dharanijashu/myimages:latest
