#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
USER app
WORKDIR /app
EXPOSE 8080
EXPOSE 8081

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["Loan.Platform.Rest/Loan.Platform.Rest.csproj", "Loan.Platform.Rest/"]
COPY ["Loan.Platform.Business/Loan.Platform.Business.csproj", "Loan.Platform.Business/"]
COPY ["Loan.Platform.Common/Loan.Platform.Common.csproj", "Loan.Platform.Common/"]
COPY ["Loan.Platform.Models/Loan.Platform.Models.csproj", "Loan.Platform.Models/"]
COPY ["Loan.Platform.SqlServer/Loan.Platform.Data.SqlServer.csproj", "Loan.Platform.SqlServer/"]
RUN dotnet restore "./Loan.Platform.Rest/./Loan.Platform.Rest.csproj"
COPY . .
WORKDIR "/src/Loan.Platform.Rest"
RUN dotnet build "./Loan.Platform.Rest.csproj" -c $BUILD_CONFIGURATION -o /app/build

FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "./Loan.Platform.Rest.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Loan.Platform.Rest.dll"]