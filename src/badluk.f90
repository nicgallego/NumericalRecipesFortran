!> @file FIXME this is not appearing in the generated documentation
!> @brief a funny program that computes all the occurences of friday 13th that coincide with full moon
!>
program badluk
   use ch1, only: julday, flmoon, badluck
   use date_utils, only: dates_list, date_node, date
   implicit none
   ! here extra variables for the future function ----
   type(dates_list) :: dates
   type(date_node), pointer :: current

   integer, parameter :: iybeg = 1900, iyend = 2050, timezone = -5

   integer :: im, iyyy, ifrac
   ! ------------------------------------------------

   write (*,'(1x,a,i5,a,i5)') 'Full moons on Friday 13th from', iybeg, ' to', iyend

   dates = badluck(iybeg,iyend,timezone)

   current => dates%head
   do while(associated(current))
      im = current%m_date%month
      iyyy = current%m_date%year
      ifrac = current%m_date%hour
      write (*,'(/1x,i2,a,i2,a,i4)') im,'/',13,'/',iyyy
      write (*,'(1x,a,i2,a)') 'Full moon ', ifrac, ' hrs after midnight (EST).'

      current => current%next
   end do

   call dates%destroy()
end program badluk
