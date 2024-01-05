using AutoMapper;
using Loan.Platform.Models.Entities;
using Loan.Platform.Models.ViewModels;

namespace Loan.Platform.Rest.Helpers
{
    public class ApplicationProfile : Profile
    {
        public ApplicationProfile()
        {           
            CreateMap<OrganizationViewModel, Organization>().ReverseMap();         
        }
    }
}
