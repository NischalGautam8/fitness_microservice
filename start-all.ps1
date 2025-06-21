# This script automates the startup of your services in separate PowerShell tabs.

# Function to run a command in a new PowerShell tab
function Start-New-Tab {
    param (
        [string]$Title,
        [string]$Command
    )
    Write-Host "Starting '$Title' in a new tab..."
    Start-Process powershell.exe -ArgumentList "-NoExit -Command $Command" -WindowStyle Normal
    Start-Sleep -Seconds 2 # Give a brief pause to allow the tab to open
}

Write-Host "Starting Docker containers and Spring Boot services..."
Write-Host "Please ensure Docker Desktop is running."
Write-Host ""

# --- Docker Containers ---
Write-Host "--- Starting Docker Containers ---"

# 1. Run RabbitMQ
# Access RabbitMQ Management Console at: http://localhost:15672 (default credentials: guest/guest)
Start-New-Tab -Title "RabbitMQ - Docker" -Command "docker run -it --rm --name rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:4-management"

# 2. Run Keycloak
# Access Keycloak Admin Console at: http://localhost:8181 (Admin credentials: admin/admin)
Start-New-Tab -Title "Keycloak - Docker" -Command "docker run -p 8181:8080 -e KC_BOOTSTRAP_ADMIN_USERNAME=admin -e KC_BOOTSTRAP_ADMIN_PASSWORD=admin quay.io/keycloak/keycloak:26.2.4 start-dev"

# --- MongoDB Note ---
Write-Host ""
Write-Host "--- MongoDB Configuration ---"
Write-Host "Remember: The application uses MongoDB Atlas. Please ensure your MongoDB connection string is updated in the configuration files."
Write-Host ""

# --- Optional: Kill process on port 8080 (if needed before Keycloak starts) ---
Write-Host "--- Port 8080 Process Management ---"
Write-Host "If Keycloak fails to start due to port 8080 being in use, you can manually run these commands in a separate terminal:"
Write-Host '   netstat -ano | findstr "8080"'
Write-Host '   taskkill /PID <PID> /F'
Write-Host "Or you can uncomment and use the section below in this script (use with caution):"
#
# $portToKill = 8080
# Write-Host "Checking for processes on port $portToKill..."
# try {
#     $processId = (netstat -ano | Select-String "LISTENING.*:$portToKill").ToString() -split '\s+' | Select-Object -Last 1
#     if ($processId) {
#         Write-Host "Found process with PID $processId on port $portToKill. Attempting to kill..."
#         taskkill /PID $processId /F
#         Write-Host "Process $processId killed."
#     } else {
#         Write-Host "No process found on port $portToKill."
#     }
# } catch {
#     Write-Warning "Could not check or kill process on port $portToKill. Error: $($_.Exception.Message)"
# }
# Write-Host ""

# --- Spring Boot Services ---
Write-Host "--- Starting Spring Boot Services ---"
Write-Host "Please ensure you are running this script from the parent directory containing 'configserver', 'eureka', 'gateway', etc."
Write-Host ""

# Define the base directory (assuming the script is run from the root of your project)
$baseDir = Get-Location

# 1. Start the Config Server
Start-New-Tab -Title "Config Server - Spring Boot" -Command "cd '$baseDir\configserver'; mvn spring-boot:run"

# 2. Start the Eureka Server
Start-New-Tab -Title "Eureka Server - Spring Boot" -Command "cd '$baseDir\eureka'; mvn spring-boot:run"

# 3. Start the Gateway Service
Start-New-Tab -Title "Gateway Service - Spring Boot" -Command "cd '$baseDir\gateway'; mvn spring-boot:run"

# 4. Start the User Service
Start-New-Tab -Title "User Service - Spring Boot" -Command "cd '$baseDir\userservice\userservice'; mvn spring-boot:run"

# 5. Start the Activity Service
Start-New-Tab -Title "Activity Service - Spring Boot" -Command "cd '$baseDir\activityservice'; mvn spring-boot:run"

# 6. Start the AI Service
Start-New-Tab -Title "AI Service - Spring Boot" -Command "cd '$baseDir\aiservice'; mvn spring-boot:run"

Write-Host ""
Write-Host "All services are being started in separate tabs. Please check each tab for their output."
