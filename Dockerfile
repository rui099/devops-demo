# ---------- BUILD ----------
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY app/*.csproj ./app/
RUN dotnet restore app/app.csproj

COPY app/. ./app/
WORKDIR /src/app
RUN dotnet publish -c Release -o /out

# ---------- RUNTIME ----------
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Criar user não-root (boa prática DevOps)
RUN useradd -m appuser
USER appuser

COPY --from=build /out .

ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

ENTRYPOINT ["dotnet", "app.dll"]
