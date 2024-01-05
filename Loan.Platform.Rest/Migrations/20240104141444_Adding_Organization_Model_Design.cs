using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Loan.Platform.Rest.Migrations
{
    public partial class Adding_Organization_Model_Design : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<long>(
                name: "OrganizationId1",
                table: "Applicant",
                type: "bigint",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Applicant_OrganizationId1",
                table: "Applicant",
                column: "OrganizationId1");

            migrationBuilder.AddForeignKey(
                name: "FK_Applicant_Organizations_OrganizationId1",
                table: "Applicant",
                column: "OrganizationId1",
                principalTable: "Organizations",
                principalColumn: "Id");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Applicant_Organizations_OrganizationId1",
                table: "Applicant");

            migrationBuilder.DropIndex(
                name: "IX_Applicant_OrganizationId1",
                table: "Applicant");

            migrationBuilder.DropColumn(
                name: "OrganizationId1",
                table: "Applicant");
        }
    }
}
