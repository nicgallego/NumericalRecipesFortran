!> @brief algorithms to compute the powers of the golden mean for benchmarking
!>
!> @details Compute the first n powers \f$\phi^n\f$ of the "Golden-Mean"
!> \f[
!>    \phi \equiv \frac{\sqrt{5} - 1}{2} \approx 0.61803398
!> \f]
!>
module ps_algorithms
   use, intrinsic :: iso_fortran_env, only: real32, real64
   implicit none
contains

   !> @brief powers, direct method
   !> @param[in] n highest power \f$\phi^n\f$ to be computed
   !> @return p, n dimensional vector with the first \f$n\f$ powers \f$\phi^n\f$
   function ps_powers(n) result(p)

   end function ps_powers
end module
