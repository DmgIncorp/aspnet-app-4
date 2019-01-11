FROM microsoft/dotnet:2.2-sdk AS builder
COPY ./*.csproj ./src/
WORKDIR /src
RUN dotnet restore
COPY . /src
RUN dotnet publish -c release

FROM microsoft/dotnet:2.2-aspnetcore-runtime
COPY --from=builder src/bin/release/netcoreapp2.2/publish app
WORKDIR app
ENV ASPNETCORE_URLS http://*:80
EXPOSE 80
ENTRYPOINT ["dotnet", "aspnetapp.dll"]
