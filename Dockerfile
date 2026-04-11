FROM microsoft.com/dotnet/sdk:10.0.5 AS build
WORKDIR /App

# Copy everything
COPY . ./
# Restore as distinct layers
RUN dotnet restore
# Build and publish a release
RUN dotnet publish -o out

# Build runtime image
FROM microsoft.com/dotnet/aspnet:10.0.5
WORKDIR /App
COPY --from=build /App/out .
ENTRYPOINT ["dotnet", "DotNet.Docker.dll"]
