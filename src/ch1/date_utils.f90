module date_utils
   implicit none
   private
   public :: date, date_node, dates_list

!> @brief date structure mm/dd/yyyy hour 24h based
   type date
      integer :: month
      integer :: day
      integer :: year
      integer :: hour
   end type date

!> @brief a date node for a single linked list
   type date_node
      type(date) :: m_date
      type(date_node), pointer :: next
   end type date_node

!> @brief a single linked list of dates
   type dates_list
      type (date_node), pointer :: head => null()
      type (date_node), pointer :: tail => null()
   contains
      procedure, pass(self) :: push_back
      procedure, pass(self) :: destroy => destroy_list
   end type dates_list

contains

   !> @brief adds node to the tail of the list
   !> @param[inout] self instance of date_node necessary for binding methods... inout allows to modify it
   !> @param[in] node_ptr the read only node to be pushed back
   !>
   subroutine push_back(self, node_pt)
      class(dates_list), intent(inout) :: self
      type(date_node), pointer, intent(in) :: node_pt

      if (.not.associated(self%head)) then ! first element
         self%head => node_pt
         self%tail => self%head
      else ! put it to the back of the list
         self%tail%next => node_pt
         self%tail => node_pt
      end if
   end subroutine push_back

   !> @brief destructor to free nodes
   !> @param[inout] sel instance of dates_list necesary for binding methods
   !>
   subroutine destroy_list(self)
      class(dates_list), intent(inout) :: self
      type(date_node), pointer :: current, temp

      current => self%head
      do while (associated(current))
         temp => current%next
         deallocate(current)
         current => temp
      end do

      self%head => null()
      self%tail => null()
   end subroutine destroy_list

end module date_utils
