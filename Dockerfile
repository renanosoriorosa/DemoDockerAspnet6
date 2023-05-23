# syntax=docker/dockerfile:1
#docker build -t apiteste:1.0 .
#docker run --publish 5000:80 --name apiteste  apiteste:1.0

FROM mcr.microsoft.com/dotnet/sdk:6.0 as build-env
WORKDIR /app
COPY DockerAPITeste/*.csproj .
RUN dotnet restore
COPY DockerAPITeste/ .
RUN dotnet publish -c Release -o /publish

FROM mcr.microsoft.com/dotnet/aspnet:6.0 as runtime
WORKDIR /publish
COPY --from=build-env /publish .
EXPOSE 80
ENTRYPOINT ["dotnet", "DockerAPITeste.dll"]
