FROM microsoft/dotnet:2.2-sdk AS builder

WORKDIR /src
COPY ./src ../src
RUN dotnet restore *.sln

RUN dotnet test -c release

WORKDIR /src/Web
RUN dotnet publish -c release

FROM microsoft/dotnet:2.2-aspnetcore-runtime
COPY --from=builder src/Web/bin/release/netcoreapp2.2/publish app
WORKDIR app
ENV ASPNETCORE_URLS http://*:80
EXPOSE 80
ENTRYPOINT ["dotnet", "aspnetapp.dll"]
