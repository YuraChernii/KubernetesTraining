FROM mcr.microsoft.com/dotnet/sdk:8.0 AS BUILD

WORKDIR /src
COPY . .

RUN dotnet restore && \
    dotnet publish --no-restore -c Release -o /src/output
WORKDIR /src/output

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS DEPLOY

WORKDIR /app
COPY --from=BUILD /src/output .

EXPOSE 80
ENTRYPOINT ["dotnet", "KuberTraining.dll"]
