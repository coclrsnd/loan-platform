using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Loan.Platform.Rest.Migrations
{
    public partial class Resolving_Naming_conflicts : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Applicant_Organizations_OrganizationId",
                table: "Applicant");

            migrationBuilder.RenameColumn(
                name: "OrganizationId",
                table: "Applicant",
                newName: "ApplicantOrganizationId");

            migrationBuilder.RenameIndex(
                name: "IX_Applicant_OrganizationId",
                table: "Applicant",
                newName: "IX_Applicant_ApplicantOrganizationId");

            migrationBuilder.AddForeignKey(
                name: "FK_Applicant_Organizations_ApplicantOrganizationId",
                table: "Applicant",
                column: "ApplicantOrganizationId",
                principalTable: "Organizations",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Applicant_Organizations_ApplicantOrganizationId",
                table: "Applicant");

            migrationBuilder.RenameColumn(
                name: "ApplicantOrganizationId",
                table: "Applicant",
                newName: "OrganizationId");

            migrationBuilder.RenameIndex(
                name: "IX_Applicant_ApplicantOrganizationId",
                table: "Applicant",
                newName: "IX_Applicant_OrganizationId");

            migrationBuilder.AddForeignKey(
                name: "FK_Applicant_Organizations_OrganizationId",
                table: "Applicant",
                column: "OrganizationId",
                principalTable: "Organizations",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }
    }
}
