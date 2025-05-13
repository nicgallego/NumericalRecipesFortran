module test_caldat
   use testdrive, only: new_unittest, unittest_type, error_type, check
   use ch1, only: caldat
   implicit none
   private

   public collect_caldat

contains

   subroutine collect_caldat(testsuite)
      type(unittest_type), allocatable, intent(out) :: testsuite(:)

      testsuite = [ &
         new_unittest("may23_1968_inv", may231968inv) &
         ]
   end subroutine collect_caldat

   subroutine may231968inv(error)
      type(error_type), allocatable, intent(out) :: error

      integer :: month, day, year
      integer, parameter :: julday = 2440000

      call caldat(julday, month, day, year)

      call check(error, month, 5, more="Wrong month")
      call check(error, day, 23, more="Wrong day")
      call check(error, year, 1968, more="Wrong year")

   end subroutine may231968inv

end module test_caldat
