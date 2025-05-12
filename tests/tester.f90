!> @brief Adapted from test driver suggested by [test-drive](https://github.com/fortran-lang/test-drive) getting started documentatation
!>
!> @details This is the necesary boiler plate to collect and run the tests.

program tester
   use, intrinsic :: iso_fortran_env, only: error_unit
   use testdrive, only : run_testsuite, new_testsuite, testsuite_type
   use test_julday, only : collect_julday
   use test_date_utils, only: collect_date_utils
   use test_badluck, only: collect_badluck
   !> add here tests as we go and append to the end of testsuites below
   implicit none

   integer :: stat, is
   type(testsuite_type), allocatable :: testsuites(:)
   character(len=*), parameter :: fmt = '("#", *(1x, a))'

   stat = 0

   testsuites = [ &
      new_testsuite("julday", collect_julday), &
      new_testsuite("date_utils", collect_date_utils), &
      new_testsuite("badluck", collect_badluck) &
      ] ! don't forget the comma except for the last

   do is = 1, size(testsuites)
      write(error_unit, fmt) "Testing:", testsuites(is)%name
      call run_testsuite(testsuites(is)%collect, error_unit, stat)
   end do

   deallocate(testsuites)

   if (stat > 0)  then
      write(error_unit, '(i0, 1x, a)') stat, "test(s) failed!"
      error stop 1
   end if


end program tester
