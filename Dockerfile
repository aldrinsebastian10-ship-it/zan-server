FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build-env
WORKDIR /App
COPY . ./
RUN dotnet restore
RUN dotnet publish src/Behide.OnlineServices -c Release -o out
FROM mcr.microsoft.com/dotnet/aspnet:10.0
WORKDIR /App
COPY --from=build-env /App/out .
EXPOSE 10000
ENV ASPNETCORE_URLS=http://+:10000
ENTRYPOINT ["dotnet", "Behide.OnlineServices.dll"]
