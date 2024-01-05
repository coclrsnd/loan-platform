using System.Collections.Generic;
using System.Threading.Tasks;
using Loan.Platform.Models.CustomModels;
using Loan.Platform.Models.Entities;
using Loan.Platform.Models.UserManagementModels;
using Loan.Platform.Models.ViewModels;

namespace Loan.Platform.Business.Pact
{
    /// <summary>
    /// Defines interface for User management.
    /// </summary>
    public interface IUserManagerService
    {
        /// <summary>
        /// Check user login credentials.
        /// </summary>
        /// <param name="loginModel">Login</param>
        /// <returns>Users security details like token, email etc.</returns>
        Task<SecurityContext> Login(Login loginModel);

        /// <summary>
        /// To Approve or Reject user detail.
        /// </summary>
        /// <param name="UserId">int</param>
        /// <param name="UserRoleId">int</param>
        /// <param name="isApprove">bool</param>
        /// <returns>Status of current request</returns>
        Task<Response> ApproveRejectUser(SignUpUserViewModel user, bool isApprove, string password = "");

        /// <summary>
        /// Get All Users list.
        /// </summary>
        /// <param name="userViewModel"></param>
        /// <returns>List of Users</returns>
        Task<UserFilterViewModel> GetUserDetails(UserFilterViewModel userViewModel);

        /// <summary>
        /// Get User detail by ID.
        /// </summary>
        /// <param name="userId">long</param>
        /// <returns>Get selected user detail.</returns>
        Task<User> GetUserById(long userId);

        /// <summary>
        /// Update User detail.
        /// </summary>
        /// <param name="userModel">UserModel</param>
        /// <returns>update user detail</returns>
        Task UpdateUserDetail(User userModel);

        /// <summary>
        /// To Approve or Reject users.
        /// </summary>
        /// <param name="usersForApproveReject"></param>
        /// <returns></returns>
        Task<bool> ApproveRejectUsers(ApproveRejectUserViewModel usersForApproveReject);

        /// <summary>
        /// Get Refresh Token
        /// </summary>
        /// <param name="token"></param>
        /// <returns>Refreshed Token</returns>
        SecurityContext GetRefreshToken(string token);

        /// <summary>
        /// Create Super Admin
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        Task<bool> CreateSuperAdminUser(string key);

        /// <summary>
        /// Change password by user from profile page.
        /// </summary>
        /// <param name="changePasswordRequest"><see cref="ChangePasswordRequest"></param>
        /// <returns>success if password changes else error message.</returns>
        Task<string> ChangePassword(ChangePasswordRequest changePasswordRequest);

        /// <summary>
        /// Update current role of user.
        /// </summary>
        /// <param name="token"></param>
        /// <param name="updatedRole"></param>
        /// <returns></returns>
        SecurityContext UpdateCurrentRole(string token, string updatedRole);

        /// <summary>
        /// Create Admins
        /// </summary>
        /// <param name="key"></param>
        /// <param name="userEmails"></param>
        /// <returns></returns>
        Task<bool> CreateAdminUsers(string key, IList<AdminUserModel> userEmails);
    }
}
