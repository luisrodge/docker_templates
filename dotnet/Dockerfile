FROM microsoft/dotnet:aspnetcore-runtime AS base
WORKDIR /app

EXPOSE 8080

FROM microsoft/dotnet:2.2-sdk-stretch AS build
WORKDIR /src

# copy project solution and csproj files and restore dependencies
COPY ./*.sln ./

RUN mkdir -p ./MARS.Core
COPY ./MARS.Core/*.csproj ./MARS.Core

RUN mkdir -p ./MARS.Migrator
COPY ./MARS.Migrator/*.csproj ./MARS.Migrator

RUN mkdir -p ./MARS.WebApp/MARS.WebApp
COPY ./MARS.WebApp/MARS.WebApp/*.csproj ./MARS.WebApp/MARS.WebApp

RUN mkdir -p ./Tests/UnitTests/MARS.UnitTests
COPY ./Tests/UnitTests/MARS.UnitTests/*.csproj ./Tests/UnitTests/MARS.UnitTests

RUN mkdir -p ./Tests/Integration/MARS.Integration.Tests
COPY ./Tests/Integration/MARS.Integration.Tests/*.csproj ./Tests/Integration/MARS.Integration.Tests

# RUN for file in $(ls *.csproj); do mkdir -p ${file%.*} && mv $file ${file%.*}; done

RUN dotnet restore

# copy everything else and build app
COPY . ./
RUN dotnet build -c Release -o /app

# install NodeJS 13.x
# RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN apt-get update -yq 
RUN apt-get install curl gnupg -yq 
RUN curl -sL https://deb.nodesource.com/setup_13.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g npm

WORKDIR /src/MARS.WebApp/MARS.WebApp/ClientApp
RUN npm install

# packs the app and its dependencies for deployment
WORKDIR /src

FROM build AS publish
RUN dotnet publish -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["website"]
