module test_badluck
   use testdrive, only: new_unittest, unittest_type, error_type, check, test_failed
   use date_utils, only: date, date_node, dates_list
   use ch1, only: badluck
   implicit none
   private

   public :: collect_badluck

contains

   !> @brief collect tests into testsuite
   !>
   subroutine collect_badluck(testsuite)
      type(unittest_type), allocatable, intent(out) :: testsuite(:)

      testsuite = [ &
         new_unittest("compare_responses", compare_responses, should_fail=.true.) &
         ]
      !> @todo clarify groundtruth for badluck function and debug

   end subroutine collect_badluck

   subroutine compare_responses(error)
      type(error_type), allocatable, intent(out) :: error
      type(dates_list) :: dates, expected_dates
      type(date_node), pointer :: current, expected
      logical :: dates_coincide
      character(len=:), allocatable :: msg
      character(len=256) :: buffer

      dates = badluck(2000, 2050, -5)   ! get all the fridays the 13th that coincide with full moon

      ! fill in the book answers
      allocate(current)
      current%m_date = date(10,13,2000,0)   ! hours not available
      current%next => null()
      call expected_dates%push_back(current)

      allocate(current)
      current%m_date = date(9,13,2019,0)
      current%next => null()
      call expected_dates%push_back(current)

      allocate(current)
      current%m_date = date(8,13,2049,0)
      current%next => null()
      call expected_dates%push_back(current)

      ! compare
      current => dates%head
      expected => expected_dates%head


      msg = ""
      do while(associated(current) .and. associated(expected))

         ! @todo implement a comparison operator for dates later
         dates_coincide = &
            expected%m_date%month .eq. current%m_date%month .and. &
            expected%m_date%day .eq. current%m_date%day .and. &
            expected%m_date%year .eq. current%m_date%year

         if (.not. dates_coincide) then
            write (buffer, '(a,i2.2,a,i2.2,a,i4,a,i2.2,a,i2.2,a,i4)') &
               'wrong date ', current%m_date%month, '/', current%m_date%day, '/', current%m_date%year, &
               ' does not coincide with expected ', &
               expected%m_date%month, '/', expected%m_date%day, '/', expected%m_date%year

            msg = msg // trim(buffer) // new_line('a')
         end if

         current => current%next
         expected => expected%next
      end do

      call dates%destroy()
      call expected_dates%destroy()

      call check(error, msg, "", more=msg)

   end subroutine compare_responses

end module test_badluck
