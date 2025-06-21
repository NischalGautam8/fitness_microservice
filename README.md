# Fitness Microservice Application

A microservice-based fitness tracking application that helps users track their activities and get AI-powered recommendations.

## Architecture

The application consists of the following microservices:
- **Gateway Service**: API Gateway for routing requests
- **Eureka Server**: Service discovery and registration
- **Config Server**: Centralized configuration management
- **User Service**: User management and authentication
- **Activity Service**: Activity tracking and management
- **AI Service**: AI-powered fitness recommendations
 
## Prerequisites

- Java 21
- Maven
- Docker
- MongoDB
- RabbitMQ
- Keycloak
8 terminals required
## Required Services Setup
mvn clean install (to install dependencies)
### 1. RabbitMQ
Run RabbitMQ using Docker:
```bash
docker run -it --rm --name rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:4-management
```
Access RabbitMQ Management Console at: http://localhost:15672
- Default credentials: guest/guest

### 2. Keycloak 

Run Keycloak using Docker:
```bash
docker run -p 8181:8080 -e KC_BOOTSTRAP_ADMIN_USERNAME=admin -e KC_BOOTSTRAP_ADMIN_PASSWORD=admin quay.io/keycloak/keycloak:26.2.4 start-dev

```
Access Keycloak Admin Console at: http://localhost:8181
- Admin credentials: admin/admin

### 3. MongoDB
The application uses MongoDB Atlas. Make sure to update the MongoDB connection string in the configuration files with your credentials.
   To kill a process running on port 8080:
   ```bash
   # Find the process ID (PID)
   netstat -ano | findstr "8080"
   
   # Kill the process using the PID
   taskkill /PID <PID> /F
   ```
## Running the Application

### 1. Start the Config Server
```bash
cd configserver
mvn spring-boot:run
```

### 2. Start the Eureka Server
```bash
cd eureka
mvn spring-boot:run
```

### 3. Start the Gateway Service
```bash
cd gateway
mvn spring-boot:run
```

### 4. Start the User Service
```bash
cd userservice/userservice
mvn spring-boot:run
```

### 5. Start the Activity Service
```bash
cd activityservice
mvn spring-boot:run
```


### 6. Start the AI Service
```bash
cd aiservice
mvn spring-boot:run
```
### Run frontend
```bash
cd frontend
npm i 
npm run dev
```
## Service Ports

- Config Server: 8888
- Eureka Server: 8761
- Gateway Service: 8079
- User Service: 8081
- Activity Service: 8082
- AI Service: 8083

## API Endpoints

### Activity Service
- POST `/api/activities` - Track new activity
- GET `/api/activities` - Get user activities
- GET `/api/activities/{activityId}` - Get specific activity

### User Service
- POST `/api/users` - Create new user
- GET `/api/users/{userId}` - Get user details
- GET `/api/users/{userId}/validate` - Validate user

### AI Service
- GET `/api/recommendations/user/{userId}` - Get user recommendations
- GET `/api/recommendations/activity/{activityId}` - Get activity-specific recommendations

## Configuration

The application uses Spring Cloud Config Server for centralized configuration. Configuration files are stored in the `configserver/src/main/resources/config` directory.

## Security

The application uses Keycloak for authentication and authorization. Make sure to:
1. Create a realm in Keycloak
2. Configure clients for each service
3. Set up appropriate roles and permissions

## Development

### Building the Project
```bash
mvn clean install
```

### Running Tests
```bash
mvn test
```

## Troubleshooting

1. If services fail to start, check:
   - MongoDB connection
   - RabbitMQ connection
   - Keycloak configuration
   - Service discovery (Eureka) status

2. Common issues:
   - Port conflicts: Ensure no other services are using the required ports
   - Configuration issues: Verify config server is running and accessible
   - Service discovery: Check Eureka dashboard at http://localhost:8761

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request
`mvn clean install` to install dependencies
## License

This project is licensed under the MIT License - see the LICENSE file for details.