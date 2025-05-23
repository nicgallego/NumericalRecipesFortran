!> @brief entrypoint for tests in chapter 2

program ch2_tester
   use, intrinsic :: iso_fortran_env, only: error_unit
   use testdrive, only : run_testsuite, new_testsuite, testsuite_type
   use test_gaussj, only: collect_gaussj
   !> append here as we go
   implicit none

   integer :: status, csuite
   type(testsuite_type), allocatable :: testsuites(:)
   character(len=*), parameter :: fmt = '("#", *(1x, a))'

   status = 0

   testsuites = [ &
      new_testsuite("gaussj", collect_gaussj) &
   ]

   do csuite = 1, size(testsuites)
       write(error_unit, fmt) "Testing:", testsuites(csuite)%name
       call run_testsuite(testsuites(csuite)%collect, error_unit, status)
   end do

   deallocate(testsuites)

   if (status> 0) then
      write(error_unit, '(i0, 1x, a)') status, "tests(s) failed!"
        error stop 1
   end if

end program ch2_tester

