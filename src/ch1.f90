module ch1
   implicit none
   public
   ! this nasty includes require saving this file each time one of the included files gets updated.
   !> @todo FIXME, use a safer alternative
   include 'date_utils.f90'   ! not part of nrf book routines
contains

   include 'julday.f90'
   include 'flmoon.f90'

end module ch1
