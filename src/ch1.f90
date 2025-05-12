module ch1
   implicit none
   public
   ! this nasty includes require saving this file each time one of the included files gets updated.
   !> @todo FIXME, use a safer alternative
contains

   include 'julday.f90'
   include 'flmoon.f90'

end module ch1
