!> @brief converts a date to Julian number
!>
!> @details The returned julday begins at noon of the specified calendar day.
!>
!> @param[in] mm month 01 January ... 12 December
!> @param[in] id day of the month. 1 to 31 at most
!> @param[in] iyyy year -1 is a B.C and the next is +1, 1 A.D. There is no year 0
!>
!> @return integer Julian day
!>
!> @details Example: Julian Day 2440000 began at noon of May 23, 1968.
!> Additionally jd+1 module 7 gives the day of the week. 0 Sunday, 1 Monday, ... 6 Saturday.
!>
function julday(mm,id,iyyy) result(jd)
   implicit none
   integer, intent(in) :: mm
   integer, intent(in) :: id
   integer, intent(in) :: iyyy
   integer :: jd
   integer, parameter :: IGREG = 15+31*(10+12*1582)

   integer ja, jm, jy
   jd = 0 ! avoid warning on unitialized
   jy = iyyy
   if (jy.eq.0) then
      write(6,*) '[error:] julday, ther is no year zero'
      return
   endif
   if (jy.lt.0) jy=jy+1
   if (mm.gt.2) then
      jm=mm+1
   else
      jy=jy-1
      jm=mm+13
   endif
   jd=int(365.25*jy)+int(30.6001*jm)+id+1720995
   if (id+31*(mm+12*iyyy).ge.IGREG) then   ! Test to change to Gregorian Calendar
      ja=int(0.01*jy)
      jd=jd+2-ja+int(0.25*ja)
   endif
   return
end function julday
