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
   private

   public :: ps_powers, ps_multiplications, ps_recursion

   real(kind=real64), parameter :: phi = 0.5_real64 * (sqrt(5.0_real64) - 1.0_real64)

contains

   !> @brief powers, direct method
   !> @param[in] n highest power \f$\phi^n\f$ to be computed
   !> @return p, n dimensional vector with the first \f$n\f$ powers \f$\phi^n\f$
   function ps_powers(n) result(p)
      integer, intent(in) :: n
      real(kind=real64), allocatable :: p(:)

      ! internal variables
      integer :: ierr ! error code
      integer :: k   ! for index range 1 ... n
      character(:), allocatable :: msg

      ! executable body
      call validate_allocate(n, p)

      p = phi ** [(k, k=1,n)]

   end function ps_powers

   !> @brief powers via explicit multiplications
   !> @param[in] n highest power \f$\phi^n\f$ to be computed
   !> @return p, n dimensional vector with the first \f$n\f$ powers \f$\phi^n\f$
   function ps_multiplications(n) result(p)
      integer, intent(in) :: n
      real(kind=real64), allocatable :: p(:)

      ! internal variables
      integer :: k   ! for index range 1 ... n

      ! executable body
      call validate_allocate(n, p)

      p(1) = phi
      do k=2, n
         p(k) = p(k-1)*phi
      end do

   end function ps_multiplications

   !> @brief using recursion \f$ \phi^{n+1} = \phi^{n-1} - \phi^{n} \f$
   !> @param[in] n highest power \f$\phi^n\f$ to be computed
   !> @return p, n dimensional vector with the first \f$n\f$ powers \f$\phi^n\f$
   function ps_recursion(n) result(p)
      integer, intent(in) :: n
      real(kind=real64), allocatable :: p(:)

      ! internal variables
      integer :: k   ! for index range 1 ... n

      ! executable body
      call validate_allocate(n, p)

      p(1) = phi
      p(2) = phi**2
      do k=3, n
         p(k) = p(k-2) - p(k-1)
      end do

   end function ps_recursion

   !> @brief convert integer to string for informative messages
   pure function itoa(i) result(str)
      integer, intent(in) :: i
      character(:), allocatable :: str
      character(len=20) :: tmp
      write (tmp, '(i0)') i
      str = trim(tmp)
   end function itoa

   !> @brief validate n > 0. Upper limit is platform dependent
   !>
   !> stops execution with error message if invalid or unable to allocated vector
   !> @param[in] n size to validate
   !> @param[inout] vec vector to be allocated
   subroutine validate_allocate(n, vec)
      integer, intent(in) :: n
      real(kind=real64), intent(inout), allocatable :: vec(:)

      integer :: ierr ! error code
      character(:), allocatable :: msg
      msg = ""
      if (n <= 0) error stop "Invalid vector size negative or zero"
      allocate(vec(n), stat=ierr) ! allocate with standard error handling
      if (ierr /= 0) then
         write (*,*) "Allocation failed with error code:", ierr
         msg = msg // "requested size n = " // itoa(n)
         error stop msg
      end if
   end subroutine validate_allocate
end module
