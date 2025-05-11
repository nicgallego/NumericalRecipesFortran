!> @brief date structure mm/dd/yyyy hour 24h based
type date
   integer :: month
   integer :: day
   integer :: year
   integer :: hour
end type date

!> @brief a date node for a single linked list
type date_node
   type(date), pointer :: m_date
   type(date_node), pointer :: next
end type date_node

!> @brief a single linked list of dates
type dates_list
   type (date_node), pointer :: head
   type (date_node), pointer :: tail
end type dates_list
