module test_date_utils
   use testdrive, only: new_unittest, unittest_type, error_type, check, test_failed
   use date_utils, only: date, date_node, dates_list
   implicit none
   private

   public :: collect_date_utils

contains

   !> @brief collect all exported unitests
   !> @param[out] testsuite the test-drive container of unit tests to be populated
   !>
   subroutine collect_date_utils(testsuite)
      type(unittest_type), allocatable, intent(out) :: testsuite(:)

      testsuite = [ &
         new_unittest("empty_list", empty_list), &
         new_unittest("push_back", push_back) &
         ]

   end subroutine collect_date_utils

   !> @brief test initial conditions for a newly created list
   !> @param[out] error test-drive given object to signal errors
   !>
   subroutine empty_list(error)
      type(error_type), allocatable, intent(out) :: error
      type(dates_list) :: list

      call check(error, .not.associated(list%head))
      call check(error, .not.associated(list%tail))

   end subroutine empty_list

   !> @brief push back subroutine test
   !>
   subroutine push_back(error)
      type(error_type), allocatable, intent(out) :: error

      type(dates_list) :: list
      type(date_node), pointer :: node_ptr

      allocate(node_ptr)
      node_ptr%m_date = date(month=5,day=12,year=2025,hour=13)
      node_ptr%next => null()
      call list%push_back(node_ptr)

      call check(error, associated(list%head))
      call check(error, associated(list%tail))
      call check(error, associated(list%head, list%tail)) ! check they point to the same thing

      allocate(node_ptr)
      node_ptr%m_date = date(month=6,day=25,year=1982,hour=5)
      node_ptr%next => null()
      call list%push_back(node_ptr)

      call check(error, .not.associated(list%head, list%tail)) ! check they point to different things now

      call list%destroy()

   end subroutine push_back

end module test_date_utils
