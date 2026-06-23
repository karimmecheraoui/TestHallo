# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY ["WebformularFuerMit.csproj", "./"]
RUN dotnet restore

COPY . .
RUN dotnet publish WebformularFuerMit.csproj -c Release -o /app/publish

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "WebformularFuerMit.dll"]
