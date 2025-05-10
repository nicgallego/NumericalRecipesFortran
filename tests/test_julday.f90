module test_julday
   use testdrive, only : new_unittest, unittest_type, error_type, check, test_failed
   use ch1, only: julday
   implicit none
   private

   public :: collect_julday

contains

   !> @brief collect all exported unittests
   !> @param[out] testsuite the testdrive container of unit tests to be populated
   !>
   subroutine collect_julday(testsuite)
      type(unittest_type), allocatable, intent(out) :: testsuite(:)

      testsuite = [ &
         new_unittest("may23_1968", may231968), &
         new_unittest("before_gregorian", before_greg), &
         new_unittest("day_zero", day_zero) &
         ]
   end subroutine collect_julday

   !> @brief tests the example given in the text of julday
   !> @param[out] error testdrive error object to report back results
   !>
   subroutine may231968(error)
      type(error_type), allocatable, intent(out) :: error
      integer :: jd

      jd = julday(05, 23, 1968)
      call check(error, jd, 2440000)

      ! that day was a thursday, lets check that as well as documented
      call check(error, mod(jd + 1, 7), 4)

   end subroutine may231968

   !> @brief before 15 October 1582
   subroutine before_greg(error)
      type(error_type), allocatable, intent(out) :: error
      integer :: jd

      jd = julday(10, 14, 1582)
      call check(error, jd.gt.0)
   end subroutine

   !> @brief the day zero was January 1 4713 BC
   subroutine day_zero(error)
      type(error_type), allocatable, intent(out) :: error
      integer :: jd

      jd = julday(01, 01, -4713)
      call check(error, jd, 1)

      jd = julday(12, 31, -4714)
      call check(error, jd, 0)

   end subroutine day_zero

end module test_julday
