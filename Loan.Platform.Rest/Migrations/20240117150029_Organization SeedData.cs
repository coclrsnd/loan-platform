using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace Loan.Platform.Rest.Migrations
{
    /// <inheritdoc />
    public partial class OrganizationSeedData : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "LogoPath",
                table: "Organizations",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.InsertData(
                table: "Organizations",
                columns: new[] { "Id", "Code", "CreatedBy", "CreatedTime", "Description", "IsActive", "LogoPath", "ModifiedBy", "ModifiedTime", "Name" },
                values: new object[,]
                {
                    { 1L, "STDR", 0L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Standard Rail Description", null, null, 0L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Standard Rail" },
                    { 2L, "COPSIND", 0L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Co _operative Bank Sindhanur", null, null, 0L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Co _ Operative bank" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Organizations",
                keyColumn: "Id",
                keyValue: 1L);

            migrationBuilder.DeleteData(
                table: "Organizations",
                keyColumn: "Id",
                keyValue: 2L);

            migrationBuilder.DropColumn(
                name: "LogoPath",
                table: "Organizations");
        }
    }
}
