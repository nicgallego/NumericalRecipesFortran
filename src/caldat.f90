!> @brief implementation, see declaration in ch1.f90
!>
subroutine caldat(julian, mm, id, iyyy)
   implicit none
   integer, intent(in) :: julian
   integer, intent(out) :: mm, id, iyyy

   ! internal variables and constants
   integer, parameter :: IGREG = 2299161
   integer :: ja, jalpha, jb, jc, jd, je

   if (julian .ge. IGREG) then
      ! cross-over to Gregorian Calendar produces this correction
      jalpha = int( ((julian - 1867216) - 0.25) / 36524.25 )
      ja = julian + 1 + jalpha - int(0.25*jalpha)
   else
      ! no correction
      ja = julian
   end if
   jb = ja + 1524
   jc = int(6680. + ((jb - 2439870) - 122.1)/365.25)
   jd = 365*jc + int(0.25*jc)
   je = int((jb-jd)/30.6001)

   ! outputs
   id = jb - jd - int(30.6001*je)
   mm = je - 1
   if (mm .gt. 12) mm = mm - 12
   iyyy = jc - 4715
   if (mm .gt. 2) iyyy = iyyy - 1
   if (iyyy .le. 0) iyyy = iyyy - 1
   return
end subroutine caldat
