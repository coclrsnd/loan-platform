using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Loan.Platform.Rest.Migrations
{
    public partial class Resolving_Naming_conflicts_4 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ApplicantOrganizationMapping_Applicant_ApplicantId",
                table: "ApplicantOrganizationMapping");

            migrationBuilder.AddForeignKey(
                name: "FK_ApplicantOrganizationMapping_Applicant_ApplicantId",
                table: "ApplicantOrganizationMapping",
                column: "ApplicantId",
                principalTable: "Applicant",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ApplicantOrganizationMapping_Applicant_ApplicantId",
                table: "ApplicantOrganizationMapping");

            migrationBuilder.AddForeignKey(
                name: "FK_ApplicantOrganizationMapping_Applicant_ApplicantId",
                table: "ApplicantOrganizationMapping",
                column: "ApplicantId",
                principalTable: "Applicant",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
