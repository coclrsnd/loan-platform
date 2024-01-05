namespace Loan.Platform.Models.ViewModels
{
    /// <summary>
    /// Hold Information about pagination
    /// </summary>
    public class PaginationModel
    {
        public int Index { get; set; }

        public int Size { get; set; }

        public int TotalRecords { get; set; }
    }
}