using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Loan.Platform.Rest.Migrations
{
    public partial class Resolving_Naming_conflicts_3 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Applicant_Organizations_OrganizationId",
                table: "Applicant");

            migrationBuilder.DropForeignKey(
                name: "FK_Applicant_Organizations_OrganizationId1",
                table: "Applicant");

            migrationBuilder.DropIndex(
                name: "IX_Applicant_OrganizationId",
                table: "Applicant");

            migrationBuilder.DropIndex(
                name: "IX_Applicant_OrganizationId1",
                table: "Applicant");

            migrationBuilder.DropColumn(
                name: "OrganizationId",
                table: "Applicant");

            migrationBuilder.DropColumn(
                name: "OrganizationId1",
                table: "Applicant");

            migrationBuilder.CreateTable(
                name: "ApplicantOrganizationMapping",
                columns: table => new
                {
                    Id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ApplicantId = table.Column<long>(type: "bigint", nullable: false),
                    OrganizationId = table.Column<long>(type: "bigint", nullable: false),
                    IsActive = table.Column<bool>(type: "bit", nullable: true),
                    CreatedTime = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CreatedBy = table.Column<long>(type: "bigint", nullable: false),
                    ModifiedTime = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedBy = table.Column<long>(type: "bigint", nullable: false),
                    TenantId = table.Column<long>(type: "bigint", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ApplicantOrganizationMapping", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ApplicantOrganizationMapping_Applicant_ApplicantId",
                        column: x => x.ApplicantId,
                        principalTable: "Applicant",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_ApplicantOrganizationMapping_Organizations_OrganizationId",
                        column: x => x.OrganizationId,
                        principalTable: "Organizations",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_ApplicantOrganizationMapping_ApplicantId",
                table: "ApplicantOrganizationMapping",
                column: "ApplicantId");

            migrationBuilder.CreateIndex(
                name: "IX_ApplicantOrganizationMapping_OrganizationId",
                table: "ApplicantOrganizationMapping",
                column: "OrganizationId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "ApplicantOrganizationMapping");

            migrationBuilder.AddColumn<long>(
                name: "OrganizationId",
                table: "Applicant",
                type: "bigint",
                nullable: false,
                defaultValue: 0L);

            migrationBuilder.AddColumn<long>(
                name: "OrganizationId1",
                table: "Applicant",
                type: "bigint",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Applicant_OrganizationId",
                table: "Applicant",
                column: "OrganizationId");

            migrationBuilder.CreateIndex(
                name: "IX_Applicant_OrganizationId1",
                table: "Applicant",
                column: "OrganizationId1");

            migrationBuilder.AddForeignKey(
                name: "FK_Applicant_Organizations_OrganizationId",
                table: "Applicant",
                column: "OrganizationId",
                principalTable: "Organizations",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_Applicant_Organizations_OrganizationId1",
                table: "Applicant",
                column: "OrganizationId1",
                principalTable: "Organizations",
                principalColumn: "Id");
        }
    }
}
