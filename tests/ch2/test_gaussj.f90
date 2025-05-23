!> @brief Gauss Jordan method test suite
module test_gaussj
   use testdrive, only : new_unittest, unittest_type, error_type, check, test_failed
   use ch2_mod, only: gaussj

   implicit none
   private
   real, parameter :: tol = 1e-6

   public :: collect_gaussj

contains

!> @brief collect exported unit tests from this module
!> @param[out] testsuite the list of available unit tests
!>
   subroutine collect_gaussj(testsuite)
      type(unittest_type), allocatable, intent(out) :: testsuite(:)

      testsuite = [ &
         new_unittest("trivial_decomp", trivial), &
         new_unittest("easy_problem", easy) &
      ]
   end subroutine

   !> @brief given and already solved system, verify it does not change
   !> @param[out] error test-drive object used for assertions and signaling error status.
   !>
   subroutine trivial(error)
      type(error_type), allocatable, intent(out) :: error

      real :: A(2,2), b(2,1), Ainv(2,2), r(2,1)
      integer :: i, j ! indices

      A = reshape( [1.0, 0.0, 0.0, 1.0], shape(A) )
      b = reshape([2.0, 0.5], shape(b))

      ! expect the same back
      Ainv = A
      r = b

      call gaussj(A,2,2,b,1,1)

      do i = 1, 2
         call check(error, abs(b(i,1) - r(i,1)) < tol, more="b != r")
         do j = 1, 2
            call check(error, abs(A(i,j) - Ainv(i,j)) < tol, more="Ainv != A")
         end do
      end do

   end subroutine trivial

   subroutine easy(error)
      type(error_type), allocatable, intent(out) :: error

      real, dimension(2,2) :: A, sln, B

      integer :: i, j ! indices
      
      ! column wise data assingment
      A = reshape([1,0,1,1], shape(A))
      B = reshape([4,1,0,1], shape(B))

      sln = reshape([3,1,-1,1], shape(sln))

      call gaussj(A,2,2,B,2,2)

      do i= 1, 2
         do j = 1, 2
            call check(error, abs(B(i,j) - sln(i,j)) < tol, more="not the expected solution")
         end do
      end do
   end subroutine easy
   
end module test_gaussj
