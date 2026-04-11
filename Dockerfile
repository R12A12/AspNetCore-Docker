FROM microsoft/dotnet/aspnet:8.0 AS build
WORKDIR /code
COPY . .
RUN dotnet build
RUN dotnet restore
RUN dotnet publish --output /output --configuration Release

FROM microsoft/dotnet/aspnet:8.0
COPY --from=build /output /app
WORKDIR /app
ENTRYPOINT ["dotnet", "AspNetCoreOnDocker.dll"]
