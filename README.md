# {{cookiecutter.project_name}}

**{{cookiecutter.description}}**

This repository is part of the ProfitPals microservices ecosystem, generated using **SkrillScaffold**. It is designed as a modular microservice template that ensures consistency, scalability, and simplicity.

---

## **Features**
- Flask-based API-ready microservice template.
- Integrated Docker containerization for easy deployment.
- Centralized configuration management.
- Unit tests included for robust service reliability.
- Pre-configured for integration with DollarDrive, the ProfitPals orchestrator.

---

## **Service Architecture**

Each service in the ProfitPals ecosystem has a specific role, as shown below:

## **ProfitPals Microservices Overview**

The ProfitPals ecosystem is composed of modular microservices, each with a specific functionality. Here is an overview of each service:

| **Name**              | **Functionality**                                                                                         |
|-----------------------|---------------------------------------------------------------------------------------------------------|
| **ValueVortex**        | ETL Tools: Ingest, clean, and prepare data from various sources like market data, news, and 10-Ks.       |
| **EquityEngine**       | Backtesting & Strategy Simulation: Test strategies on historical data with performance analytics.        |
| **GreedGears**         | Machine Learning Models: Train and deploy ML models for predictive analytics and signal generation.      |
| **ChartChurner**       | EDA & Visualization: Create visualizations, correlation matrices, and other exploratory tools.           |
| **OpportunityOptimizer** | Feature Engineering & Strategy Tuning: Automate creation of features and tune strategies for optimal performance. |
| **RiskReducer**        | Risk Management: Analyze and manage portfolio risk, stop-loss strategies, and position sizing.           |
| **StochasticScreener** | Advanced stochastic risk analysis and daily strategy screening, integrating SHAP outputs for interpretability. |
| **MoneyMill**          | Strategy Execution: Handles execution of trading strategies in real-time or simulated environments.      |
| **CapitalCatalyst**    | LLM Signal Integration: Extract insights from 10-Ks, news, and analyst reports for decision-making.      |
| **PortfolioProcessor** | Portfolio Optimization: Optimize allocation using tools like PyPortfolioOpt or ML-based strategies.      |
| **RevenueReactor**     | Performance Monitoring & Reporting: Monitor live and backtested strategies and generate reports.         |
| **FortuneFilter**      | Screening Tools: Screen stocks or assets based on user-defined filters or strategies.                    |
| **DollarDriver**       | Orchestration & Pipeline Management: The orchestrator for the Kedro pipelines and microservices.         |
| **ValueVault**         | Data Storage & Version Control: Central repository for datasets, models, and metadata.                   |

---

## **Interaction Diagram**

```mermaid
graph TD
    subgraph DataPipeline
        ValueVortex --> CapitalCatalyst
        ValueVortex --> ChartChurner
    end

    subgraph StrategyDevelopment
        ChartChurner --> OpportunityOptimizer
        OpportunityOptimizer --> GreedGears
        CapitalCatalyst --> GreedGears
    end

    subgraph RiskAndExecution
        GreedGears --> StochasticScreener
        StochasticScreener --> RiskReducer
        RiskReducer --> MoneyMill
    end

    subgraph ReportingAndOptimization
        MoneyMill --> RevenueReactor
        RevenueReactor --> PortfolioProcessor
    end

    subgraph Orchestration
        DollarDriver --> ValueVortex
        DollarDriver --> GreedGears
        DollarDriver --> RiskReducer
    end

    subgraph DataStorage
        ValueVault --> allServices
    end
```

### **Notes**
- **StochasticScreener** will integrate SHAP (SHapley Additive exPlanations) outputs from machine learning models to enhance interpretability, providing insights into feature importance for stochastic risk analysis and daily decision-making.

---

## **Generated Template Directory Structure**
Upon using **SkrillScaffold**, the following structure is generated:

```plaintext
{{cookiecutter.project_name}}/
├── app/
│   ├── __init__.py          # Initializes the Flask application
│   ├── routes.py            # API routes
│   ├── models.py            # Optional database models
│   └── utils.py             # Utility functions
├── tests/
│   ├── test_routes.py       # Unit tests for routes
│   └── test_utils.py        # Unit tests for utilities
├── Dockerfile               # Docker configuration for containerizing the service
├── requirements.txt         # Python dependencies
├── config/
│   ├── base.yml             # Shared configurations
│   ├── dev.yml              # Development environment configurations
│   └── prod.yml             # Production environment configurations
├── README.md                # Documentation specific to this service
└── .env.example             # Example environment variables
```
## **Setup Instructions**

### **Pre-Requisites**
1. Install Python 3.9 or higher.
2. Install Docker.
3. Install Cookiecutter:
   ```bash
   pip install cookiecutter

## **Generate a New Service**

To generate a new microservice using SkrillScaffold:
`cookiecutter https://github.com/your-org/SkrillScaffold.git`

Follow the prompts to provide:

*    project_name: The name of your service.
*    description: A brief description of what your service does.
*    author_name: Your name.
*    version: Service version.
*    port: Port on which the service will run.

## **Development**

### **Run the Service Locally**

1. Install dependencies:
   ```bash
   pip install -r requirements.txt
2. Run the Flask application:
    ```flask run --host=0.0.0.0 --port={{cookiecutter.port}}```

### **Run Tests**
Use `pytest` to execute unit tests:

`pytest tests/`

### Build and Run with Docker

1. Build the Docker image:

    `docker build -t {{cookiecutter.project_name}} .`

2.Run the container:

    `docker run -p {{cookiecutter.port}}:{{cookiecutter.port}} {{cookiecutter.project_name}}`

### Customization
* Configuration: Update the config/ files to adjust service behavior for different environments.
* API Routes: Modify app/routes.py to define your service\'s endpoints.
* Utilities: Add reusable functions in app/utils.py.
* Models: If your service uses a database, define models in app/models.py.


## **Integration with DollarDrive**

**DollarDrive** is the central orchestrator of the ProfitPals microservices ecosystem. It is responsible for coordinating, deploying, and managing all microservices generated using **SkrillScaffold**, including their configurations, dependencies, and runtime environments.

By integrating a microservice with DollarDrive, you enable:
1. **Centralized Management**: Orchestration of all services via Docker Compose or Kubernetes.
2. **Seamless Communication**: Services can interact through predefined networks or message queues like Kafka.
3. **Scalability**: DollarDrive handles service scaling and load distribution for production deployments.
4. **Unified Configuration**: Centralized management of environment variables and shared configurations.

---

### **Steps to Integrate with DollarDrive**

#### **1. Define the Service in `docker-compose.yml`**
Add your service definition to DollarDrive’s `docker-compose.yml` file. This file manages the orchestration of all services during development and local testing.

Here’s an example for adding a service:
```yaml
services:
  {{cookiecutter.project_name}}:
    build: ./services/{{cookiecutter.project_name}}
    image: {{cookiecutter.project_name}}:latest
    ports:
      - "{{cookiecutter.port}}:{{cookiecutter.port}}"
    environment:
      - ENV=development
      - API_KEY=${API_KEY}  # Example: environment variable for secure tokens
    depends_on:
      - kafka  # Define any required dependencies
    networks:
      - profitpals_net
```
#### 1. Explanation:

* build: Points to the service directory.
* image: The name of the service's Docker image, built and tagged as latest.
* ports: Maps the internal service port (e.g., 5000) to a host port (e.g., 5001).
* environment: Passes environment variables into the container, such as development settings or API keys.
* depends_on: Specifies service dependencies (e.g., Kafka).
* networks: Ensures the service is on the same network as other microservices.

#### 2. Add the Service to the Network

Ensure the service is part of a shared network for inter-service communication. This is configured in the networks section of docker-compose.yml:

`networks:
  profitpals_net:
    driver: bridge`    

#### 3. Add Dependencies

If your service relies on external tools (e.g., Kafka, PostgreSQL, Redis), define them as part of the `docker-compose.yml`. Example:

```yaml
services:
  kafka:
    image: bitnami/kafka:latest
    environment:
      KAFKA_BROKER_ID: 1
      KAFKA_ZOOKEEPER_CONNECT: zookeeper:2181
      KAFKA_LISTENERS: PLAINTEXT://:9092
      KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://localhost:9092
    networks:
      - profitpals_net

  zookeeper:
    image: bitnami/zookeeper:latest
    ports:
      - "2181:2181"
    networks:
      - profitpals_net


#### 4. Kubernetes Integration

For production, integrate the service into DollarDrive's Kubernetes deployment. Here’s how to configure it:

##### Deployment YAML

Create a {{cookiecutter.project_name}}-deployment.yaml file:

```apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{cookiecutter.project_name}}
  labels:
    app: {{cookiecutter.project_name}}
spec:
  replicas: 3
  selector:
    matchLabels:
      app: {{cookiecutter.project_name}}
  template:
    metadata:
      labels:
        app: {{cookiecutter.project_name}}
    spec:
      containers:
      - name: {{cookiecutter.project_name}}
        image: {{cookiecutter.project_name}}:latest
        ports:
        - containerPort: {{cookiecutter.port}}
        env:
        - name: ENV
          value: "production"
        - name: API_KEY
          valueFrom:
            secretKeyRef:
              name: api-key-secret
              key: API_KEY
      restartPolicy: Always
```
##### Service YAML

Expose the service to the cluster:

`apiVersion: v1
kind: Service
metadata:
  name: {{cookiecutter.project_name}}
spec:
  selector:
    app: {{cookiecutter.project_name}}
  ports:
    - protocol: TCP
      port: {{cookiecutter.port}}
      targetPort: {{cookiecutter.port}}
  type: ClusterIP`

#### 5. Testing Integration Locally

##### 1. Start DollarDrive with All Services:

`docker-compose up --build`

##### 2. Verify Service Connectivity:

Use curl or Postman to check if the service responds correctly:

    `curl http://localhost:{{cookiecutter.port}}/health`

##### 3. Check Dependencies:

    Confirm that dependent services like Kafka or PostgreSQL are reachable:

        `docker logs {{container_name}}`

#### 6. Best Practices

    Environment Variables: Use .env files or Kubernetes secrets for sensitive data.
    Health Checks: Ensure all services expose /health endpoints to monitor availability.
    Logging: Centralize logs with tools like Elasticsearch or AWS CloudWatch.
    Scaling: Use Kubernetes Horizontal Pod Autoscaler (HPA) to manage dynamic scaling.

By integrating with DollarDrive, your microservice becomes part of a cohesive, scalable ecosystem, ensuring seamless collaboration with other services in the ProfitPals architecture.

### Notes for Future Reference

* Cookiecutter Variables: Ensure cookiecutter.json is up to date for generating new services.
* Integration: Always update DollarDrive orchestrator configs when adding new services.
* Testing: Maintain high test coverage for routes and utilities.
* Scalability: Ensure compatibility with Kubernetes when scaling services.

### Contributing

Contributions are welcome! Please submit a pull request or file an issue if you encounter any bugs.
